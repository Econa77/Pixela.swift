//
//  Webhook.swift
//  Pixela
//
//  Created by 古林俊佑 on 2020/03/14.
//

import Foundation

public struct Webhook: Decodable {

    // MARK: - Properties
    public let webhookHash: String
    public let graphID: String
    public let type: WebhookType

    // MARK: - Initialize
    init(webhookHash: String, graphID: String, type: WebhookType) {
        self.webhookHash = webhookHash
        self.graphID = graphID
        self.type = type
    }

}
