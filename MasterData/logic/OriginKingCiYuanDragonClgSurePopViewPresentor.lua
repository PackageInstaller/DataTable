-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/view/OriginKingCiYuanDragonClgSurePopViewPresentor.lua

module("logic.extensions.originkingciyuandragonclg.view.OriginKingCiYuanDragonClgSurePopViewPresentor", package.seeall)

local OriginKingCiYuanDragonClgSurePopViewPresentor = class("OriginKingCiYuanDragonClgSurePopViewPresentor", ViewPresentor)

function OriginKingCiYuanDragonClgSurePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingCiYuanDragonClgSurePopViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingciyuandragonclg/originkingciyuandragonclgsurepopview.prefab"
	}
end

function OriginKingCiYuanDragonClgSurePopViewPresentor:buildViews()
	return {
		OriginKingCiYuanDragonClgSurePopView.New()
	}
end

return OriginKingCiYuanDragonClgSurePopViewPresentor
