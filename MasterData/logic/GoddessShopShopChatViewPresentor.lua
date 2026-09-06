-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopChatViewPresentor.lua

module("logic.extensions.goddessshop.view.GoddessShopShopChatViewPresentor", package.seeall)

local GoddessShopShopChatViewPresentor = class("GoddessShopShopChatViewPresentor", ViewPresentor)

function GoddessShopShopChatViewPresentor:ctor()
	GoddessShopShopChatViewPresentor.super.ctor(self)
end

function GoddessShopShopChatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessShopShopChatViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessshop/goddessshopshopchatview.prefab"
	}
end

function GoddessShopShopChatViewPresentor:buildViews()
	return {
		GoddessShopShopChatView.New()
	}
end

return GoddessShopShopChatViewPresentor
