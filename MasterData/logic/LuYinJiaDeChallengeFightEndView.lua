-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeFightEndView.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeFightEndView", package.seeall)

local LuYinJiaDeChallengeFightEndView = class("LuYinJiaDeChallengeFightEndView", ViewComponent)

function LuYinJiaDeChallengeFightEndView:ctor()
	LuYinJiaDeChallengeFightEndView.super.ctor(self)
end

function LuYinJiaDeChallengeFightEndView:unbindEvents()
	LuYinJiaDeChallengeFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function LuYinJiaDeChallengeFightEndView:bindEvents()
	LuYinJiaDeChallengeFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function LuYinJiaDeChallengeFightEndView:buildUI()
	LuYinJiaDeChallengeFightEndView.super.buildUI(self)

	self._arrowChangeLevel = self:getGo("content1/txtLevelScore/arrow"):GetComponent(ComponentType.UIImageSpriteChange)
	self._arrowChangeArea = self:getGo("content1/txtAreaScore/arrow"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtNum1 = self:getTxt("content1/txtNum")
	self._txtLevelScore1 = self:getTxt("content1/txtLevelScore")
	self._txtAreaScore1 = self:getTxt("content1/txtAreaScore")
	self._txtHurt1 = self:getTxt("content1/txtHurt")
	self._txtTotalScore1 = self:getTxt("content1/txtTotalScore")
	self._txtNum2 = self:getTxt("content2/txtNum")
	self._txtHurt2 = self:getTxt("content2/txtHurt")
	self._txtLevelScore2 = self:getTxt("content2/txtLevelScore")
	self._txtAreaScore2 = self:getTxt("content2/txtAreaScore")
	self._txtTotalScore2 = self:getTxt("content2/txtTotalScore")
	self._btnSure = self:getGo("btnSure")
end

function LuYinJiaDeChallengeFightEndView:onExit()
	LuYinJiaDeChallengeFightEndView.super.onExit(self)
end

function LuYinJiaDeChallengeFightEndView:onEnter()
	LuYinJiaDeChallengeFightEndView.super.onEnter(self)

	local params = self:getFirstParam() or {}

	self._activityId = params.activityId
	self._stageId = params.stageId
	self._curDamage = params.curDamage
	self._signBuffId = params.signBuffId
	self._curStageScore = params.curStageScore
	self._curspecialScore = params.curspecialScore
	self._preStageInfo = params.preStageInfo
	self._preDamage = self._preStageInfo and self._preStageInfo.damage
	self._preSignBuffId = params.preSignBuffId
	self._stageCfg = LuYinJiaDeConfig.instance:getStageDataById(self._activityId, self._stageId)

	self:_onSetUI()
end

function LuYinJiaDeChallengeFightEndView:_onSetUI()
	if self._stageCfg then
		self._txtNum1.text = string.format("%s次数%s", self._stageCfg, self._signBuffId)
		self._txtHurt1.text = string.format("伤害总量：%s", self._curDamage)

		local totalScoreCur = self._curStageScore + self._curspecialScore

		self._txtTotalScore1.text = string.format("总积分：<color=#20b376>%s</color>", totalScoreCur)
		self._txtNum2.text = string.format("%s次数%s", self._stageCfg, checknumber(self._preSignBuffId))
		self._txtHurt2.text = string.format("伤害总量：%s", checknumber(self._preDamage))

		local totalScorePre = checknumber(self._preStageInfo.stageScore) + checknumber(self._preStageInfo.specialScore)

		self._txtTotalScore2.text = string.format("总积分：<color=#20b376>%s</color>", totalScorePre)

		local levelArrowChangeIdx = 0

		if checknumber(self._preStageInfo.stageScore) < self._curStageScore then
			levelArrowChangeIdx = 1
			self._txtLevelScore1.text = string.format("关卡分：<color=#20b376>%s</color>", self._curStageScore)
			self._txtLevelScore2.text = string.format("关卡分：<color=#20b376>%s</color>", self._preStageInfo.stageScore)
		elseif checknumber(self._preStageInfo.stageScore) > self._curStageScore then
			levelArrowChangeIdx = 2
			self._txtLevelScore1.text = string.format("关卡分：<color=#BC3936FF>%s</color>", self._curStageScore)
			self._txtLevelScore2.text = string.format("关卡分：<color=#BC3936FF>%s</color>", self._preStageInfo.stageScore)
		else
			self._txtLevelScore1.text = string.format("关卡分：%s", self._curStageScore)
			self._txtLevelScore2.text = string.format("关卡分：%s", self._preStageInfo.stageScore)
		end

		local areaArrowChangeIdx = 0

		if checknumber(self._preStageInfo.specialScore) < self._curspecialScore then
			areaArrowChangeIdx = 1
			self._txtAreaScore1.text = string.format("领域分：<color=#20b376>%s</color>", self._curspecialScore)
			self._txtAreaScore2.text = string.format("领域分：<color=#20b376>%s</color>", self._preStageInfo.specialScore)
		elseif checknumber(self._preStageInfo.specialScore) > self._curspecialScore then
			areaArrowChangeIdx = 2
			self._txtAreaScore1.text = string.format("领域分：<color=#BC3936FF>%s</color>", self._curspecialScore)
			self._txtAreaScore2.text = string.format("领域分：<color=#BC3936FF>%s</color>", self._preStageInfo.specialScore)
		else
			self._txtAreaScore1.text = string.format("领域分：%s", self._curspecialScore)
			self._txtAreaScore2.text = string.format("领域分：%s", self._preStageInfo.specialScore)
		end

		self._arrowChangeLevel:SetState(levelArrowChangeIdx)
		self._arrowChangeArea:SetState(areaArrowChangeIdx)
	end
end

function LuYinJiaDeChallengeFightEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return LuYinJiaDeChallengeFightEndView
