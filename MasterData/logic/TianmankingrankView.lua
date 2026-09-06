-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingrankView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmankingrankView", package.seeall)

local TianmankingrankView = class("TianmankingrankVew", LightKingRankView)

function TianmankingrankView:onEnter()
	TianmankingrankView.super.onEnter(self)

	local challengeId = checknumber(self:getFirstParam())

	self._txtTitle.text = TianmanKingController.instance:getText("TEXT_25")
	self._txtSubTitle.text = lang("text_tongguanshijian")
	self._txtTip.text = TianmanKingController.instance:getText("TEXT_27")

	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	self._txtTitle.text = TianmanKingController.instance:getText("TEXT_28")
	self._txtSubTitle.text = TianmanKingController.instance:getText("TEXT_26")
	self._txtTip.text = ""

	if not string.nilorempty(cfg.rankDesc) then
		self._txtTip.text = cfg.rankDesc
	elseif not string.nilorempty(cfg.desc) then
		self._txtTip.text = cfg.desc
	end

	TimedChallengeAgent.instance:sendPM_TimedChallengeGetPetRankReq(challengeId, self._onPetRankRes, self)
end

return TianmankingrankView
