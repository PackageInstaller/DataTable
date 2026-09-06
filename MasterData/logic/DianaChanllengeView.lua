-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaChanllengeView.lua

module("logic.extensions.lailisi.view.diana.DianaChanllengeView", package.seeall)

local DianaChanllengeView = class("DianaChanllengeView", LailisiChanllengeView)

function DianaChanllengeView:getFinalActivity()
	local activityId = checknumber(LailisiConfig.instance:getCommonCfg("daianna_Id"))

	self._actInfo = LailisiModel.instance:getActivityInfo(activityId)
end

function DianaChanllengeView:buildUI()
	DianaChanllengeView.super.buildUI(self)

	local go = self:getGo("bottom/btnRank")

	GameUtil.SetActive(go, false)
end

return DianaChanllengeView
