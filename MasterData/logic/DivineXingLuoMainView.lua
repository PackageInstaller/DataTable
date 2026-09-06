-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/DivineXingLuoMainView.lua

module("logic.extensions.yishichallenge.view.DivineXingLuoMainView", package.seeall)

local DivineXingLuoMainView = class("DivineXingLuoMainView", YishiChallengeMainView)

function DivineXingLuoMainView:ctor()
	DivineXingLuoMainView.super.ctor(self)

	self._challengeId = 226
end

function DivineXingLuoMainView:bindEvents()
	DivineXingLuoMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGainBuff, self._onClickBuff, self)
end

function DivineXingLuoMainView:unbindEvents()
	DivineXingLuoMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGainBuff)
end

function DivineXingLuoMainView:buildUI()
	DivineXingLuoMainView.super.buildUI(self)

	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._txtBuffLv = self:getTxt("buffCol/Lv/txt")
	self._rdBuff = self:getGo("buffCol/cell/rd")
end

function DivineXingLuoMainView:_setRedPointState(name)
	if not GameUtil.getUserDayData("divinexingluomainview_" .. name) then
		GameUtil.saveUserDayData("divinexingluomainview_" .. name, true)
	end
end

function DivineXingLuoMainView:onEnter()
	DivineXingLuoMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.YishiChallengeUpgradeBuffReq, self._handleUpgradeBuff, self)
end

function DivineXingLuoMainView:_getRedPointState()
	goutil.setActive(self._shopRedPoint, not GameUtil.getUserDayData("divinexingluomainview_" .. self._cfg.jump_shop))
	goutil.setActive(self._rankRedPoint, not GameUtil.getUserDayData("divinexingluomainview_" .. self._cfg.jump_rank))
	goutil.setActive(self._callRedPoint, not GameUtil.getUserDayData("divinexingluomainview_" .. self._cfg.jump_lotery))
end

function DivineXingLuoMainView:_tipsOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "DivineXingLuoRule_1")
end

function DivineXingLuoMainView:_enterOnClick()
	if self._isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineXingLuoLevelView)
end

function DivineXingLuoMainView:_handleGetInfo()
	DivineXingLuoMainView.super._handleGetInfo(self)
	self:_updateBuff()
end

function DivineXingLuoMainView:_handleUpgradeBuff()
	self:_updateBuff()
end

function DivineXingLuoMainView:_updateBuff()
	local curBuffLv = YishiChallengeModel.instance:getSignInBuffLv()
	local isGainBuff = YishiChallengeModel.instance:getIsSignInBuff()
	local buffCfgs = YishiChallengeConfig.instance:getBuffCfgs(self._challengeId)
	local maxBuffLv = #buffCfgs
	local showEff = not isGainBuff and curBuffLv < maxBuffLv
	local buffCfg = buffCfgs[curBuffLv]

	self._txtBuffLv.text = string.format("Lv.%s", curBuffLv)

	if buffCfg then
		self._txtDescBuff.text = buffCfg.desc or "未激活"
	end

	goutil.setActive(self._rdBuff, showEff)
end

function DivineXingLuoMainView:_onClickBuff()
	local curBuffLv = YishiChallengeModel.instance:getSignInBuffLv()
	local isGainBuff = YishiChallengeModel.instance:getIsSignInBuff()
	local buffCfgs = YishiChallengeConfig.instance:getBuffCfgs(self._challengeId)
	local maxBuffLv = #buffCfgs

	if maxBuffLv <= curBuffLv then
		FloatWordMgr.instance:show("已满级")

		return
	end

	if isGainBuff then
		FloatWordMgr.instance:show("今日已升级")

		return
	end

	YiShiChallengeAgent.instance:sendPM_YiShiChallengeUpgradeBuffReq(self._challengeId)
end

return DivineXingLuoMainView
