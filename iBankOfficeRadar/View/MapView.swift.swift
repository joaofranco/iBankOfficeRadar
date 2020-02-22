import SwiftUI
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let id: String
    let title: String?
    let place: Place
    let coordinate: CLLocationCoordinate2D

    init(place: Place) {
        self.id = place.id
        self.title = place.name
        self.place = place
        self.coordinate = CLLocationCoordinate2D(latitude: place.geometry.location.lat,
                                                 longitude: place.geometry.location.lng)
    }
}

struct MapView: UIViewRepresentable {
    @Binding var actualLocation: CLLocationCoordinate2D
    @Binding var places: [Place]
    @Binding var showingDetail: Bool
    @Binding var placeTapped: Place
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.isZoomEnabled = false
        map.delegate = context.coordinator
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotations(from: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView

        init(_ control: MapView) {
            self.control = control
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let landMark = view.annotation as? LandmarkAnnotation {
                control.showingDetail = true
                control.placeTapped = landMark.place
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? LandmarkAnnotation else { return nil }
            let identifier = "Annotation"
            var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            control.actualLocation = mapView.centerCoordinate
        }

    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        
        let viewRegion = MKCoordinateRegion(center: actualLocation, latitudinalMeters: 1500, longitudinalMeters: 1500)
        mapView.setRegion(viewRegion, animated: false)
        
        mapView.removeAnnotations(mapView.annotations)
        let newAnnotations = places.map { LandmarkAnnotation(place: $0) }
        mapView.addAnnotations(newAnnotations)
    }
}
