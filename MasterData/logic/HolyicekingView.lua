-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holyiceking/view/HolyicekingView.lua

module("logic.extensions.holyiceking.view.HolyicekingView", package.seeall)

local HolyicekingView = class("HolyicekingView", DianaMainView)

function HolyicekingView:_setActivityId()
	self._activityId = checknumber(LailisiConfig.instance:getCommonCfg("holyiceking_Id"))
end

function HolyicekingView:_showEffect()
	return
end

return HolyicekingView
