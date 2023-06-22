//
//  ProfileView.swift
//  projeto 4
//
//  Created by Student09 on 11/04/23.
//

import SwiftUI
import UIKit

struct PerfilView: View {
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @State private var name: String = ""
    @State private var isEditing = false
    @State private var isNameSaved = false
    @State private var ingredients: [String] = []
    @State private var newIngredient = ""

    var body: some View {
        VStack{
            HStack{
                Text("souschef")
                    .font(.headline)
                    .foregroundColor(Color("TabBarHighlight"))
                Spacer()
                Image(systemName: "person.circle")
                    .foregroundColor(Color("TabBarHighlight"))
            }
            .padding(.horizontal)
            Divider()
                .background(Color.black)
        ScrollView {
            VStack {
                if let profileImage = image {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 20)
                        .fontWeight(.thin)
                        .foregroundColor(Color("CardColor"))
                }

                Button(action: {
                    showImagePicker.toggle()
                }) {
                    Text("Choose Image")
                        .foregroundColor(Color("TabBarHighlight"))
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $image)
                }
                .padding(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/, 30)

                if isEditing || !isNameSaved {
                    TextField("Digite o seu Nome", text: $name, onCommit: {
                        if !name.isEmpty {
                            isNameSaved = true
                        }
                        isEditing = false
                    })
                    
                    .padding()
                    .background(.ultraThickMaterial)
                    .accentColor(Color("CardColor"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom)
                } else {
                    Text(name.isEmpty ? "Digite o seu Nome" : name)
                        .foregroundColor(name.isEmpty ? Color("CardColor") : .black)
                        .font(.title)
                        .padding(.bottom, 10)
                        .onTapGesture {
                            isEditing = true
                        }
                        .padding()
                        .padding(.horizontal)
                }

                if isEditing && !name.isEmpty {
                    Button(action: {
                        isEditing = false
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }

                CardView(ingredients: $ingredients, newIngredient: $newIngredient)
                    .frame(height: 300) // Set a fixed height for CardView
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}


struct CardView: View {
    @Binding var ingredients: [String]
    @Binding var newIngredient: String
    
    var body: some View {
        VStack {
            Text("Restrições")
                .font(.title)
                .padding(.vertical, 10)
                .foregroundColor(Color("CardColor"))
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: 50)
                if newIngredient.isEmpty {
                    Text("Adicione ingredientes")
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(Color("CardColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    TextField("", text: $newIngredient)
                        .font(.headline)
                        .foregroundColor(Color("CardColor"))
                        .multilineTextAlignment(.leading)
                        .accentColor(Color("CardColor"))
                        .padding(.leading)
                    Spacer()
                    Button(action: {
                        addIngredient()
                    }) {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(Color("CardColor"))
                            .padding(.trailing)
                    }
                }
            }
            
            
            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                .onDelete(perform: deleteIngredient)
            }
            .cornerRadius(10)
        }
        .padding()
        .background(.ultraThickMaterial)
        .cornerRadius(10)
    }

    
    private func addIngredient() {
        if !newIngredient.isEmpty {
            ingredients.append(newIngredient)
            newIngredient = ""
        }
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}


    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        @Environment(\.presentationMode) private var presentationMode
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .photoLibrary
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            
        }
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            let parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let image = info[.originalImage] as? UIImage {
                    parent.image = image
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}
