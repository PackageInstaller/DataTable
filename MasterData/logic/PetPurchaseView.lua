-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/PetPurchaseView.lua

module("logic.extensions.directpurchase.view.PetPurchaseView", package.seeall)

local PetPurchaseView = class("PetPurchaseView", LongNvPurchaseView)

function PetPurchaseView:_getDirectPurchaseType()
	return GameEnum.ActivityType.DirectPurchaseSec
end

function PetPurchaseView:_getAnimRecordName()
	return ViewName.PetPurchaseView
end

return PetPurchaseView
