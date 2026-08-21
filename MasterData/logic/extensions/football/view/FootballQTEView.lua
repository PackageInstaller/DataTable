-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballQTEView.lua

module("logic.extensions.football.view.FootballQTEView", package.seeall)

local M = class("FootballRankView", ViewComponent)
local InitScale = 1.5

function M:buildUI()
	self._roundGo = self:getGo("football_click_view_403367167")
	self._clickBtn = self:getBtn("football_click_view_1083874276")
	self._score1Go = self:getGo("football_click_view_431310288")
	self._score3Go = self:getGo("football_click_view_1286712029")
	self._score5Go = self:getGo("football_click_view_1147819862")
	self._outRound = self:getImage("football_click_view1_1914235438")
	self._inRound = self:getImage("football_click_view1_43942587")
	self._qteScore = 0
end

function M:bindEvents()
	self._clickBtn:AddClickListener(self._onClick, self)
end

function M:onEnter()
	self._hasClick = false
	self._qteScore = 0

	local index = 0

	self:_initView()

	local tweenTime = FootBallConfig.instance:getConstNum("QTETime")
	local tweenInitSpeed = tonumber(FootBallConfig.instance:getConstString("QTEInitSpeed"))
	local addSpeed = (InitScale - tweenInitSpeed * tweenTime) * 2 / (tweenTime * tweenTime)

	self._tweener = DoTweenUtil.To(0, tweenTime, tweenTime, function(time)
		local scale = InitScale - (tweenInitSpeed * time + addSpeed * time * time / 2)

		Astral.TransformUtil.SetLocalScale(self._roundGo.transform, scale, scale, 1)
	end)

	self._tweener:OnComplete(function()
		self:_onCompleteTweener()
	end)
	self._tweener:SetTarget(self._roundGo)
end

function M:_initView()
	goutil.setActive(self._score1Go, false)
	goutil.setActive(self._score3Go, false)
	goutil.setActive(self._score5Go, false)
	Astral.TransformUtil.SetLocalScale(self._roundGo.transform, InitScale, InitScale, 1)

	local outWidth = math.random(25, 40)
	local startPos = math.random(10, 90 - outWidth)
	local centerPos = outWidth / 2 + startPos
	local inWidth = outWidth / 3

	self._outRound.material:SetFloat("_InnerRadius", startPos * 0.5 / 100)
	self._outRound.material:SetFloat("_OuterRadius", (startPos + outWidth) * 0.5 / 100)
	self._inRound.material:SetFloat("_InnerRadius", (centerPos - inWidth / 2) * 0.5 / 100)
	self._inRound.material:SetFloat("_OuterRadius", (centerPos + inWidth / 2) * 0.5 / 100)

	self._scale1 = (startPos + outWidth) / 100
	self._scale2 = (centerPos + inWidth / 2) / 100
	self._scale3 = (centerPos - inWidth / 2) / 100
	self._scale4 = startPos / 100
end

function M:_onCompleteTweener()
	self._hasClick = true

	self:_handleScore(1)
	settimer(2, self._close, self, false)
end

function M:onExit()
	removetimer(self._close, self)
end

function M:unbindEvents()
	self._clickBtn:RemoveClickListener()
end

function M:_onClick()
	if self._hasClick then
		self:_close()
	else
		DG.Tweening.DOTween.Kill(self._roundGo, false)

		if self._roundGo.transform.localScale.x > self._scale1 then
			self:_handleScore(1)
		elseif self._roundGo.transform.localScale.x > self._scale2 then
			self:_handleScore(3)
		elseif self._roundGo.transform.localScale.x >= self._scale3 then
			self:_handleScore(5)
		elseif self._roundGo.transform.localScale.x >= self._scale4 then
			self:_handleScore(3)
		else
			self:_handleScore(1)
		end

		settimer(2, self._close, self, false)

		self._hasClick = true
	end
end

function M:_handleScore(score)
	local scoreIndex = 1

	if score == 1 then
		scoreIndex = 1

		goutil.setActive(self._score1Go, true)
		goutil.setActive(self._score3Go, false)
		goutil.setActive(self._score5Go, false)
	elseif score == 3 then
		scoreIndex = 2

		goutil.setActive(self._score1Go, false)
		goutil.setActive(self._score3Go, true)
		goutil.setActive(self._score5Go, false)
	else
		scoreIndex = 3

		goutil.setActive(self._score1Go, false)
		goutil.setActive(self._score3Go, false)
		goutil.setActive(self._score5Go, true)
	end

	local qteScores = FootBallConfig.instance:getConstNumList(FootBallConstEnum.QTEScores)

	self._qteScore = qteScores[scoreIndex]
end

function M:_close()
	self:_sendQTEAttack()
	self:close()
end

function M:_sendQTEAttack()
	local releaseSkillContext = self:getFirstParam()

	if not releaseSkillContext then
		return
	end

	FootBallCompReleaseSkillAgent.sendQTEAttack(releaseSkillContext, self._qteScore)
	releaseSkillContext:returnSelf()
end

return M
