-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoChanllengeView.lua

module("logic.extensions.lailisi.view.xingluo.XingluoChanllengeView", package.seeall)

local XingluoChanllengeView = class("XingluoChanllengeView", LailisiChanllengeView)

function XingluoChanllengeView:getFinalActivity()
	local activityId = checknumber(LailisiConfig.instance:getCommonCfg("xingluo_Id"))

	self._actInfo = LailisiModel.instance:getActivityInfo(activityId)
end

function XingluoChanllengeView:onEnter()
	XingluoChanllengeView.super.onEnter(self)

	local level = goutil.findChildTextComponent(self._fmoInfo, "level/txtLevel")

	level.text = "对决星洛"
end

function XingluoChanllengeView:_showEffect()
	return
end

return XingluoChanllengeView
