-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleTabView.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleTabView", package.seeall)

local FashionShowSkinSaleTabView = class("FashionShowSkinSaleTabView", FashionShowSkinSaleView)

function FashionShowSkinSaleTabView:_getCurVersionInfo()
	curVersionInfo = PayTrussController.curVersionInfos[1]

	return curVersionInfo
end

return FashionShowSkinSaleTabView
