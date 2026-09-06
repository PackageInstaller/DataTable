-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnventerView.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnventerView", package.seeall)

local LongnventerView = class("LongnventerView", ViewComponent)

function LongnventerView:ctor()
	LongnventerView.super.ctor(self)
end

function LongnventerView:buildUI()
	LongnventerView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnChallenge = self:getGo("btnChallenge")
	self.txtChallengeCount = self:getTxt("challengeCount/txt")
	self.blood = self:getGo("blood"):GetComponent(typeof(UnityEngine.UI.Slider))
	self.blood = self:getSlider("blood")
	self.txtBlood = self:getTxt("blood/txtBlood")
	self.txtNum1 = self:getTxt("hurt_1/txtNum")
	self.txtNum2 = self:getTxt("hurt_2/txtNum")
	self.txtHurtdiff = self:getTxt("hurtdiff")
	self.txtRule = self:getTxt("txtRule")
end

function LongnventerView:bindEvents()
	LongnventerView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnChallenge, self.onEnterFight, self)
end

function LongnventerView:unbindEvents()
	LongnventerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnChallenge)
end

function LongnventerView:destroyUI()
	LongnventerView.super.destroyUI(self)
end

function LongnventerView:onEnter()
	LongnventerView.super.onEnter(self)

	local type = LongnvModel.TYPE_3

	self.type = type
	self.txtRule.text = lang("longnv_ch_rule")
	self._challengeId = 16

	GlobalDispatcher:addListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_LongnvBuyTimesEnd, self.onBuyTimeEnd, self)
	LongnvController.instance:sendGetChallengeInfoByType(type)
	self:onRefreshUI()
end

function LongnventerView:onEnterFinished()
	LongnventerView.super.onEnterFinished(self)
end

function LongnventerView:onExit()
	LongnventerView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_LongnvBuyTimesEnd, self.onBuyTimeEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_LongnvInfoRes, self.onRefreshUI, self)
end

function LongnventerView:onExitFinished()
	LongnventerView.super.onExitFinished(self)
end

function LongnventerView:onEnterFight()
	LongnvController.instance:checkIfCanChallenge(function()
		self:close()

		local params = {}

		params.type = self.type
		params.stageId = self.stage
		params.challengeId = self._challengeId

		UIStateManager.instance:push(ViewName.LongnvMissionView, params)
	end)
end

function LongnventerView:onBuyTimeEnd()
	self:onEnterFight()
end

function LongnventerView:onRefreshUI()
	self.stage = 0

	local planId = LongnvModel.instance:getPlanId()
	local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}
	local totalHp = checknumber(cfg.bossHP)
	local deff = checknumber(cfg.maxDamageDiff)
	local ddd = langPara("%s万", math.ceil(LongnvModel.instance.bossHP / 10000))

	self.txtBlood.text = langPara("剩余血量：%s", ddd)

	self.blood:SetValue(LongnvModel.instance.bossHP / totalHp)

	local last = LongnvModel.instance.lastDamage

	if last > 0 then
		self.stage = 2
		self.txtNum1.text = last
		self.txtNum2.text = lang("把龙女剩余血量降为0就可以通关")
	else
		self.stage = 1

		local hDeff = deff * 0.5
		local helfHp = totalHp * 0.5
		local min = langPara("%s万", math.ceil((helfHp - hDeff) / 10000))
		local max = langPara("%s万", math.ceil((helfHp + hDeff) / 10000))

		self.txtNum1.text = langPara("未挑战（需要%s-%s）", min, max)
		self.txtNum2.text = langPara("未挑战（需要%s-%s）", min, max)
	end

	local dhp = langPara("%s万", math.ceil(deff / 10000))

	self.txtHurtdiff.text = langPara("两次挑战伤害相差不能超过<color=#20b376>%s</color>", dhp)

	local todayChallengeTimes = LongnvModel.instance.todayChallengeTimes
	local todayChallengeBuyTimes = LongnvModel.instance.todayChallengeBuyTimes
	local total = checknumber(LongnvConfig.instance:getCommonValue("FREE_CHALLENGE_TIMES"))
	local left = total + todayChallengeBuyTimes - todayChallengeTimes

	self.txtChallengeCount.text = langPara("剩余挑战次数：<color=#20b376>%s</color>/%s", left, total)

	local spaceGained = LongnvModel.instance.spaceGained
	local total = checknumber(LongnvConfig.instance:getCommonValue("SPACE_LIMIT"))
	local left = math.max(0, total - spaceGained)

	GameUtil.SetGray(self.btnChallenge, left <= 0)
end

return LongnventerView
