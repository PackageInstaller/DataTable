-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TipsViewPresentorBase.lua

module("logic.extensions.tips.view.TipsViewPresentorBase", package.seeall)

local TipsViewPresentorBase = class("TipsViewPresentorBase", ViewPresentor)

function TipsViewPresentorBase:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

return TipsViewPresentorBase
