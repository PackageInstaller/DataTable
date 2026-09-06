-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialMissionView.lua

module("logic.extensions.herotrial.view.HerotrialMissionView", package.seeall)

local HerotrialMissionView = class("HerotrialMissionView", MissionView)

function HerotrialMissionView:ctor()
	HerotrialMissionView.super.ctor(self)

	self.model = HerotrialModel.instance
end

function HerotrialMissionView:buildUI()
	HerotrialMissionView.super.buildUI(self)

	self._goBtnRule = self:getGo("btnRule")
end

function HerotrialMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(false)
	self._btnEvaluate.gameObject:SetActive(false)
	GameUtil.SetActive(self._btnOneKey, true)
	GameUtil.SetActive(self._goBtnRule, false)

	if not HerotrialModel.instance:getLoginFirstChallenge() then
		UIStateManager.instance:push(ViewName.HerotrialopentipView)
		HerotrialModel.instance:setLoginFirstChallenge(true)
	end
end

function HerotrialMissionView:onExit()
	HerotrialMissionView.super.onExit(self)
end

function HerotrialMissionView:procMid()
	local activityId = HerotrialModel.instance:getActivityId()
	local htCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)
	local titleStr = htCfg.name
	local levelStr = ""
	local ruleDesc = "伤害越多奖励越多"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function HerotrialMissionView:_onClickStart()
	HerotrialController.instance:realTimeUpdate(function()
		if self:_checkFormationPosNumber(function()
			self:_startClg()
		end) then
			return
		end

		self:_startClg()
	end)
end

function HerotrialMissionView:_startClg()
	self:_setMaskBlock(true)
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self.model:saveCurrFormation()
end

function HerotrialMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = self.model:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local totalPos = 5
	local petsNum = self.model:diffRacePetCount()
	local showNum = -1
	local boo = false

	if totalPos <= petsNum and numPos < totalPos then
		boo = true
		showNum = totalPos
	elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
		boo = true
		showNum = petsNum
	end

	if showNum > 0 then
		local function onekeyCallBack()
			self:_onClickOneKey()
		end

		TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("上阵精灵未满%s只（上阵精灵越多，战斗力越强），请一键布阵上阵%s只精灵吧！", showNum, showNum), onekeyCallBack, lang("一键布阵"))
	end

	return boo
end

function HerotrialMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	HeroTrialFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function HerotrialMissionView:_openPassRuleView()
	local param1, param2 = MissionModel.instance:getRuleDesc()
	local param3 = MissionModel.instance:getRuleParam()

	UIStateManager.instance:open(ViewName.PassRuleView, param1, param2, param3)
end

function HerotrialMissionView:_onClickClean()
	HeroTrialFastFormation.instance:clean()
end

function HerotrialMissionView:_enterBattle()
	local activityId = HerotrialModel.instance:getActivityId()
	local bossId = HerotrialConfig.instance:getHeroTrialActivity(activityId).bossId

	HerotrialController.instance:startBattle()
	BattleFacade.instance:startHeroTrial(bossId)
end

return HerotrialMissionView
