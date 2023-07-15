import SwiftUI

struct dropdownMenu: View{
    var content: [String]
    @Binding var selection: String
    var activeTint: Color
    var inActiveTint : Color
    var dynamic: Bool = true
    
    @State private var expandView: Bool = false
    var body: some View{
        GeometryReader{
            let size = $0.size
            
            VStack(alignment: .leading, spacing: 0){
                if !dynamic{
                    RowView(selection, size)
                }
                ForEach(content.filter{
                    dynamic ? true : $0 != selection
                }, id: \.self){title in
                    RowView(title, size)
                }
            }
            .background{
                Rectangle()
                    .fill(inActiveTint)
                    .transition(.identity)
            }
            .offset(y: dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
        }
        .frame(height: 55)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing,10)
        }
        .mask(alignment: .top){
            Rectangle()
                .frame(height: expandView ? CGFloat(content.count) * 55 : 55)
                .offset(y: dynamic && expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
        }
    }
    @ViewBuilder
    func RowView(_ title: String,_ size: CGSize)->some View{
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background{
                if selection == title{
                    Rectangle()
                        .fill(activeTint)
                        .transition(.identity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture{
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                    if expandView{
                        expandView = false
                        if dynamic{
                            selection = title
                        }else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                                selection = title
                            }
                        }
                    }else{
                        if(selection == title){
                            expandView = true
                        }
                        
                    }
                }
            }
    }
}
