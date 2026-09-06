-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/XiaonuoBirthCopyViewPresentor.lua

module("logic.extensions.bonus.view.XiaonuoBirthCopyViewPresentor", package.seeall)

local XiaonuoBirthCopyViewPresentor = class("XiaonuoBirthCopyViewPresentor", XiaonuoBirthViewPresentor)

function XiaonuoBirthCopyViewPresentor:buildViews()
	return {
		XiaonuoBirthCopyView.New()
	}
end

return XiaonuoBirthCopyViewPresentor
