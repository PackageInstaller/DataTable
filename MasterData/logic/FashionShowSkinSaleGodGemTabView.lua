-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/FashionShowSkinSaleGodGemTabView.lua

module("logic.extensions.dressactivityshop.view.FashionShowSkinSaleGodGemTabView", package.seeall)

local FashionShowSkinSaleGodGemTabView = class("FashionShowSkinSaleGodGemTabView", FashionShowSkinSaleGodGemView)

function FashionShowSkinSaleGodGemTabView:_getCurVersionInfo()
	curVersionInfo = PayTrussGodGemController.curVersionInfos[1]

	return curVersionInfo
end

return FashionShowSkinSaleGodGemTabView
