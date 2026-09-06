-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/ChallengeEffectBase.lua

module("logic.extensions.challenge.view.specialviews.ChallengeEffectBase", package.seeall)

local ChallengeEffectBase = class("ChallengeEffectBase", SpecialViewBase)

ChallengeEffectBase._phaseBranch = {
	{
		0,
		0
	},
	{
		0,
		1
	},
	{
		1,
		0
	}
}
ChallengeEffectBase._uiEffectPath = {
	Passed = "common/fx_ui_gaizhang.prefab"
}

function ChallengeEffectBase:_initData()
	ChallengeEffectBase.super._initData(self)
	self:_setMask(false)

	local params = self:_getParams()

	if params._bGaiZhang0 then
		self:_setMask(true)
	end

	self:_playEffect()

	self._delayTime = 2

	settimer(self._delayTime, self._popupReward, self, false)
end

function ChallengeEffectBase:_setPrePhaseAndBranch(phase, branch)
	ChallengeEffectBase._prePhase = phase
	ChallengeEffectBase._preBranch = branch
end

function ChallengeEffectBase:_onClickMission(phase, branch)
	local state = ChallengeModel.instance:getBranchState(phase, branch)

	if state == GameEnum.ChallengeBranchState.UNLOCKED then
		ChallengeEffectBase._prePhase = phase
		ChallengeEffectBase._preBranch = branch

		UIStateManager.instance:push(ViewName.missionview, phase, branch)
	elseif state == GameEnum.ChallengeBranchState.LOCKED then
		FloatWordMgr.instance:show(lang("clg_passbefore"))
	elseif state == GameEnum.ChallengeBranchState.PASSED then
		FloatWordMgr.instance:show(lang("tip_passed"))
	end

	ChallengeModel.instance:setCurBranch(branch)
end

function ChallengeEffectBase:teamFightEnd()
	ChallengeModel.instance:setCurBranchForLinear()

	local phase = ChallengeModel.instance:getCurPhase()
	local branch = ChallengeModel.instance:getCurBranch()
	local bRes = BattleFacade.instance:getLastBattleResult()
	local params = self:_setGaiZhangState(bRes, phase, branch)

	UIJumper.instance:pushOneStack(ViewName.challengemgrview, true, params)

	if ChallengeEffectBase._prePhase == phase and ChallengeEffectBase._preBranch == branch then
		if bRes == GameEnum.BattleResult.Success and ChallengeModel.instance:isBranchPassed(phase, branch) then
			UIJumper.instance:pushOneStack(ViewName.missionview, true, phase, branch + 1, true)
		else
			UIJumper.instance:pushOneStack(ViewName.missionview, true, phase, branch, true)
		end
	end
end

function ChallengeEffectBase:_setGaiZhangState(bRes, phase, branch)
	local params = {}

	if ChallengeEffectBase._prePhase == phase and ChallengeEffectBase._preBranch == branch then
		params._bGaiZhang0 = false
		params._bGaiZhang1 = false
		params._bGaiZhang2 = false
	elseif bRes == GameEnum.BattleResult.Success then
		params._bGaiZhang0 = true
		params._bGaiZhang1 = true
		params._bGaiZhang2 = true
	end

	return params
end

function ChallengeEffectBase:buildDiffView()
	ChallengeEffectBase.super.buildDiffView(self)

	self.passed = {}
	self.passed[0] = goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_" .. self._phaseBranch[1][1] .. "_" .. self._phaseBranch[1][2] .. "/Passed")

	if self._phaseBranch[2] then
		self.passed[1] = goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_" .. self._phaseBranch[2][1] .. "_" .. self._phaseBranch[2][2] .. "/Passed")
	end

	if self._phaseBranch[3] then
		self.passed[2] = goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_" .. self._phaseBranch[3][1] .. "_" .. self._phaseBranch[3][2] .. "/Passed")
	end

	self._imgMask = goutil.findChild(self._go, "imgMask")

	function self._delayFunc()
		return
	end

	self._jinhuaBtnEffect = goutil.findChild(self._go, "JinHuaBtn/effect")
end

function ChallengeEffectBase:onExit()
	ChallengeEffectBase.super.onExit(self)
	removetimer(self._popupReward, self)
	removetimer(self._delayFunc, self)
	self:_stopEffect()
end

function ChallengeEffectBase:_playEffect()
	self._effs = {}

	local view = self:getChallengeViewComponent()
	local path = self._uiEffectPath.Passed

	UIEffectManager.instance:setPermanent(path, true)

	for i = 0, #self._phaseBranch - 1 do
		local effect = UIEffectManager.instance:playEffect(view, path, self.passed[i], 0, 0, true, false, nil, self._onEffectLoaded, self)

		self._effs[i] = effect
		effect.hideEffWhileNotOnTop = false

		effect:setParent(self.passed[i].transform)
		effect:setScale(1.28)
		self:_setSortingOrder(effect)
	end
end

function ChallengeEffectBase:_setSortingOrder(uiEffect)
	return
end

function ChallengeEffectBase:_stopEffect()
	for k, v in pairs(self._effs) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function ChallengeEffectBase:_getParams()
	local params = {}

	if not self._params then
		params._bGaiZhang0 = false
		params._bGaiZhang1 = false
		params._bGaiZhang2 = false
		self._params = params
	end

	return self._params
end

function ChallengeEffectBase:_onEffectLoaded(uiEffect)
	local bOne = ChallengeModel.instance:getBranchState(self._phaseBranch[1][1], self._phaseBranch[1][2]) == GameEnum.ChallengeBranchState.PASSED
	local bTwo
	local bThree
	local parent = uiEffect.widget.transform
	local lastIndex = 0

	if bOne then
		lastIndex = 1
	end

	if (self._phaseBranch[2] or nil) and ChallengeModel.instance:getBranchState(self._phaseBranch[2][1], self._phaseBranch[2][2]) == GameEnum.ChallengeBranchState.PASSED then
		lastIndex = 2
	end

	if (self._phaseBranch[3] or nil) and ChallengeModel.instance:getBranchState(self._phaseBranch[3][1], self._phaseBranch[3][2]) == GameEnum.ChallengeBranchState.PASSED then
		lastIndex = 3
	end

	local params = self:_getParams()

	if parent.gameObject == self.passed[0] then
		self:_startEffect(uiEffect, params._bGaiZhang0 and lastIndex == 1)

		self._params._bGaiZhang0 = false
	elseif self.passed[1] and parent.gameObject == self.passed[1] then
		self:_startEffect(uiEffect, params._bGaiZhang1 and lastIndex == 2)

		self._params._bGaiZhang1 = false
	elseif self.passed[2] and parent.gameObject == self.passed[2] then
		self:_startEffect(uiEffect, params._bGaiZhang2 and lastIndex == 3)

		self._params._bGaiZhang2 = false
	end
end

function ChallengeEffectBase:_startEffect(uiEffect, isPlayFromStart)
	local animator = uiEffect.effGo:GetComponentInChildren(typeof(UnityEngine.Animator))

	if isPlayFromStart then
		animator.gameObject:SetActive(false)

		function self._delayFunc()
			if animator then
				animator.gameObject:SetActive(true)
				animator:Play("fx_ui_gaizhang", 0, 0)
			end
		end

		local delayTime = 0.5

		settimer(delayTime, self._delayFunc, self, false)
	else
		if not animator.gameObject.activeSelf then
			animator.gameObject:SetActive(true)
		end

		animator:Play("fx_ui_gaizhang", 0, 1)
	end
end

function ChallengeEffectBase:_popupReward()
	self:_setMask(false)

	local changeSetIds = ChallengeModel.instance:getChangeSetIds()

	MaterialFacade.instance:popAndShowChangeSetItems(changeSetIds)
	ChallengeModel.instance:clearChangeSetIds()
end

function ChallengeEffectBase:_setMask(bOn)
	self._imgMask.gameObject:SetActive(bOn)
end

return ChallengeEffectBase
