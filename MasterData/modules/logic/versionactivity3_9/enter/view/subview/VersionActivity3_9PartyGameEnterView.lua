-- chunkname: @modules/logic/versionactivity3_9/enter/view/subview/VersionActivity3_9PartyGameEnterView.lua

module("modules.logic.versionactivity3_9.enter.view.subview.VersionActivity3_9PartyGameEnterView", package.seeall)

local VersionActivity3_9PartyGameEnterView = class("VersionActivity3_9PartyGameEnterView", VersionActivity3_4PartyGameEnterView)

function VersionActivity3_9PartyGameEnterView:getPartyGameStoreId()
	return VersionActivity3_9Enum.ActivityId.V3_A9_PartyGameStore
end

return VersionActivity3_9PartyGameEnterView
