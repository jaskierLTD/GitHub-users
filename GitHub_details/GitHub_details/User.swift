//
//  User.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 05/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Foundation
/*
struct User : Decodable
{
    let login:String,avatar:String
    
    private enum CodingKeys : String, CodingKey{
        case login = "login"
        case avatar = "avatar_url"
    }
    
}
*/

struct Owner:Decodable {
    let login               : String?
    let id                  : Double?
    let avatar_url          : String?
    let gravatar_id         : String?
    let url                 : String?
    let html_url            : String?
    let followers_url       : String?
    let following_url       : String?
    let gists_url           : String?
    let starred_url         : String?
    let subscriptions_url   : String?
    let organizations_url   : String?
    let repos_url           : String?
    let events_url          : String?
    let received_events_url : String?
    let type                : String?
    let site_admin          : Bool?
}

struct License:Decodable {
    let key     : String?
    let name    : String?
    let spdx_id : String?
    let url     : String?
}

struct Repo:Decodable {
    let id                : Double?
    let name              : String?
    let full_name         : String?
    let owner             : Owner?
    let `private`         : Bool?
    let html_url          : String?
    let description       : String?
    let fork              : Bool?
    let url               : String?
    let forks_url         : String?
    let keys_url          : String?
    let collaborators_url : String?
    let teams_url         : String?
    let hooks_url         : String?
    let issue_events_url  : String?
    let events_url        : String?
    let assignees_url     : String?
    let branches_url      : String?
    let tags_url          : String?
    let blobs_url         : String?
    let git_tags_url      : String?
    let git_refs_url      : String?
    let trees_url         : String?
    let statuses_url      : String?
    let languages_url     : String?
    let stargazers_url    : String?
    let contributors_url  : String?
    let subscribers_url   : String?
    let subscription_url  : String?
    let commits_url       : String?
    let git_commits_url   : String?
    let comments_url      : String?
    let issue_comment_url : String?
    let contents_url      : String?
    let compare_url       : String?
    let merges_url        : String?
    let archive_url       : String?
    let downloads_url     : String?
    let issues_url        : String?
    let pulls_url         : String?
    let milestones_url    : String?
    let notifications_url : String?
    let labels_url        : String?
    let releases_url      : String?
    let deployments_url   : String?
    let created_at        : String?
    let updated_at        : String?
    let pushed_at         : String?
    let git_url           : String?
    let ssh_url           : String?
    let clone_url         : String?
    let svn_url           : String?
    let homepage          : String?
    let size              : Double?
    let stargazers_count  : Double?
    let watchers_count    : Double?
    let language          : String?
    let has_issues        : Bool?
    let has_projects      : Bool?
    let has_downloads     : Bool?
    let has_wiki          : Bool?
    let has_pages         : Bool?
    let forks_count       : Double?
    let mirror_url        : String?
    let archived          : Bool?
    let open_issues_count : Double?
    let license           : License?
    let forks             : Double?
    let open_issues       : Double?
    let topics            : Topic?
    let permissions       : Permissions?
    let watchers          : Double?
    let default_branch    : String?
    //    let score             : Double?
    //    let subscribers_count : Double?
    //    let network_count     : Double?
    //    let allow_rebase_merge: Bool?
    //    let allow_squash_merge: Bool?
    //    let allow_merge_commit: Bool?
    
}

struct Topic:Decodable {
    let topics : [String]?
}

struct Permissions:Decodable {
    let admin : Bool
    let push  : Bool
    let pull  : Bool
}

struct RepoList:Decodable{
    let total_count        : Int?
    let incomplete_results : Bool?
    let items              : [Repo]?
}

struct User:Decodable {
    let login: String?
    let id: Double?
    let avatar_url: String?
    let gravatar_id: String?
    let url: String?
    let html_url: String?
    let followers_url: String?
    let following_url: String?
    let gists_url: String?
    let starred_url: String?
    let subscriptions_url: String?
    let organizations_url: String?
    let repos_url: String?
    let events_url: String?
    let received_events_url: String?
    let type: String?
    let site_admin: Bool?
}

struct Creator:Decodable {
    let login: String?
    let id: Double?
    let avatar_url: String?
    let gravatar_id: String?
    let url: String?
    let html_url: String?
    let followers_url: String?
    let following_url: String?
    let gists_url: String?
    let starred_url: String?
    let subscriptions_url: String?
    let organizations_url: String?
    let repos_url: String?
    let events_url: String?
    let received_events_url: String?
    let type: String?
    let site_admin: Bool?
}

struct Link:Decodable {
    let href :String?
}

struct _Links:Decodable {
    let `self`           :Link?
    let html             :Link?
    let issue            :Link?
    let comments         :Link?
    let review_comments  :Link?
    let review_comment   :Link?
    let commits          :Link?
    let statuses         :Link?
}

struct Base:Decodable {
    let label :String?
    let ref   :String?
    let sha   :String?
    let user  :User?
    let repo  :Repo?
}

struct Head:Decodable {
    let label :String?
    let ref   :String?
    let sha   :String?
    let user  :User?
    let repo  :Repo?
}

struct Milestone:Decodable {
    let url:String?
    let html_url:String?
    let labels_url:String?
    let id: Double?
    let number:Double?
    let title:String?
    let description:String?
    let creator:Creator?
    let open_issues:Double?
    let closed_issues:Double?
    let state:String?
    let created_at:String?
    let updated_at:String?
    let closed_at:String?
    let due_on:String?
}

struct Assignee:Decodable {
    let login               :String?
    let id                  :Double?
    let avatar_url          :String?
    let gravatar_id         :String?
    let url                 :String?
    let html_url            :String?
    let followers_url       :String?
    let following_url       :String?
    let gists_url           :String?
    let starred_url         :String?
    let subscriptions_url   :String?
    let organizations_url   :String?
    let repos_url           :String?
    let events_url          :String?
    let received_events_url :String?
    let type                :String?
    let site_admin          :Bool?
}

struct Reviewers:Decodable {
    let login: String?
    let id: Double?
    let avatar_url: String?
    let gravatar_id: String?
    let url: String?
    let html_url: String?
    let followers_url: String?
    let following_url: String?
    let gists_url: String?
    let starred_url: String?
    let subscriptions_url: String?
    let organizations_url: String?
    let repos_url: String?
    let events_url: String?
    let received_events_url: String?
    let type: String?
    let site_admin: Bool?
}

struct Pull:Decodable {
    let id: Double?
    let url:String?
    let html_url:String?
    let diff_url:String?
    let patch_url:String?
    let issue_url:String?
    let number:Double?
    let state:String?
    let locked:Bool?
    let title:String?
    let user:User?
    let body:String?
    let created_at:String?
    let updated_at:String?
    let closed_at:String?
    let merged_at:String?
    let merge_commit_sha: String?
    let assignee: Assignee?
    let assignees: [Assignee]?
    let requested_reviewers: [Reviewers]?
    let milestone:Milestone?
    let commits_url:String?
    let review_comments_url:String?
    let review_comment_url:String?
    let comments_url:String?
    let statuses_url:String?
    let head:Head?
    let base:Base?
    let _links:_Links?
    let author_association:String?
}

struct PullList:Decodable {
    let pulls:[Pull]?
}

