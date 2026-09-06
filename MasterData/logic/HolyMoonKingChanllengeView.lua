-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syyueyingwang/view/HolyMoonKingChanllengeView.lua

module("logic.extensions.syyueyingwang.view.HolyMoonKingChanllengeView", package.seeall)

local HolyMoonKingChanllengeView = class("HolyMoonKingChanllengeView", LailisiChanllengeView)

function HolyMoonKingChanllengeView:getFinalActivity()
	local activityId = checknumber(LailisiConfig.instance:getCommonCfg("holymoonking_Id"))

	self._actInfo = LailisiModel.instance:getActivityInfo(activityId)
end

return HolyMoonKingChanllengeView
