//
//  FriendsListView.swift
//  FriendFace
//
//  Created by Derek Santolo on 4/14/21.
//

import SwiftUI

struct FriendsListView: View {
    
    var users: Users
    var user: User
    
    var body: some View {
        List(user.friends)
        { friend in
            NavigationLink(destination: DetailUserView(user: self.users.findUser(string: friend.id), users: self.users)) {
                VStack(alignment: .leading, spacing: nil) {
                    Text(friend.name)
                }
            }
        }.navigationBarTitle("\(user.name)'s Friends", displayMode: .inline)
        .toolbar {
            Button(action: {
                print("Add friend")
            }) {
                Image(systemName: "plus")
            }
        }
    }
}

struct FriendsListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListView(users: Users(), user: User(id: "id", name: "Name", age: 30, company: "COM", isActive: true, friends: [Friend]()))
    }
}
