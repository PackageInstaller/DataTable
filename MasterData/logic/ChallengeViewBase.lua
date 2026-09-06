-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/ChallengeViewBase.lua

module("logic.extensions.challenge.view.ChallengeViewBase", package.seeall)

local ChallengeViewBase = class("ChallengeViewBase", ChallengeLoadBase)

function ChallengeViewBase:onEnter(go, cfg, params)
	self._go = go

	goutil.setActive(self._go, true)

	self._btns = {}
	self.effList = {}
	self.CurState = 1
	self._params = params
	self._stateGo = {}
	self._cfg = cfg

	self:buildDiffView()
	self:procPreFight()
	self:_procMissionBtns()
	self:bindEvents()
	self:_initData()
	self:_initPanel(cfg)
	self:changeState(1)
	ChallengeController.instance:localNotify("ClassLoaded")
	ChallengeViewBase.super.onEnter(self, go)
end

function ChallengeViewBase:onExit()
	self:unbindEvents()

	for i, v in ipairs(self._btns) do
		if v then
			local btn = Framework.ButtonAdapter.Get(v.gameObject)

			btn:RemoveClickListener()
		end
	end

	self._btns = {}

	for i, v in ipairs(self.effList) do
		UIEffectManager.instance:stopEffect(v)
	end

	self.effList = {}

	ChallengeViewBase.super.onExit(self)
end

function ChallengeViewBase:bindEvents()
	if self._startBtn then
		self._startBtn:AddClickListener(self._onClickStart, self)
	end

	if self._jinhuaBtn then
		self._jinhuaBtn:AddClickListener(self.onClickJinHua, self)
	end

	if self._detailBtn then
		self._detailBtn:AddClickListener(self.onClickDetail, self)
	end

	if self._spBtn then
		self._spBtn:AddClickListener(self.onClickSpecial, self)
	end

	self._closeBtn:AddClickListener(self.onClickClose, self)
	ChallengeController.instance:registerLocalNotify("SpBtnClicked", self.onClickSpecial, self)
end

function ChallengeViewBase:unbindEvents()
	if self._startBtn then
		self._startBtn:RemoveClickListener()
	end

	if self._jinhuaBtn then
		self._jinhuaBtn:RemoveClickListener()
	end

	if self._detailBtn then
		self._detailBtn:RemoveClickListener()
	end

	if self._spBtn then
		self._spBtn:RemoveClickListener()
	end

	self._closeBtn:RemoveClickListener()
	ChallengeController.instance:unregisterLocalNotify("SpBtnClicked", self.onClickSpecial, self)
end

function ChallengeViewBase:_initData()
	ChallengeViewBase._prePhase = ChallengeModel.instance:getCurPhase()
end

function ChallengeViewBase:_initPanel(cfg)
	self._nameTxt.text = lang(cfg.name)
end

function ChallengeViewBase:_procMissionBtns()
	local btns = UGUIToolHelper.GetChildTransforms(self._btnRoot)
	local n = 0

	for i = 0, btns.Length - 1 do
		local name = btns[i].gameObject.name

		if string.find(name, "BranchBtn_") then
			self:_procMissionBtn(name, btns[i], n)

			n = n + 1
		end
	end
end

function ChallengeViewBase:_procBtnColor(state, btnTrans)
	local text = goutil.findChild(btnTrans, "Name"):GetComponent("Text")

	if state ~= GameEnum.ChallengeBranchState.UNLOCKED then
		local image = btnTrans:GetComponent("Image")

		image.color = Color.New(0, 0, 0, image.color.a)
		text.color = Color.New(0.5, 0.5, 0.5, 1)
	end
end

function ChallengeViewBase:_procMissionBtn(name, btnTrans, index)
	local strs = string.split(name, "_")
	local phase = tonumber(strs[2])
	local branch = tonumber(strs[3])
	local passObj = goutil.findChild(btnTrans, "Passed")
	local text = goutil.findChild(btnTrans, "Name"):GetComponent("Text")
	local desc = goutil.findChild(btnTrans, "Desc")
	local btn = Framework.ButtonAdapter.Get(btnTrans.gameObject)
	local TxtOrder = goutil.findChild(btnTrans, "TxtOrder"):GetComponent("Text")
	local cfg = ChallengeConfig.instance:getChallengeMissionCfg(ChallengeModel.instance:getCurId(), phase, branch)

	self:_setMissionName(text, cfg)

	TxtOrder.text = lang(cfg.name)

	if desc then
		desc:GetComponent("Text").text = lang(cfg.desc)
	end

	local state = ChallengeModel.instance:getBranchState(phase, branch)
	local isPassed = state == GameEnum.ChallengeBranchState.PASSED

	passObj:SetActive(isPassed)
	self:onIsPassed(isPassed, index, state)
	self:_procBtnColor(state, btnTrans)
	btn:AddClickListener(function()
		self:_onClickMission(phase, branch)
	end, self)
	table.insert(self._btns, btnTrans)
end

function ChallengeViewBase:_setMissionName(text, cfg)
	text.text = lang(cfg.name)
end

function ChallengeViewBase:onIsPassed(isPassed, index, state)
	return
end

function ChallengeViewBase:changeState(state)
	self.CurState = state

	for i = 1, #self._stateGo do
		self._stateGo[i]:SetActive(i == state)
	end
end

function ChallengeViewBase:_onClickMission(phase, branch)
	local state = ChallengeModel.instance:getBranchState(phase, branch)

	if state == GameEnum.ChallengeBranchState.UNLOCKED then
		UIStateManager.instance:push(ViewName.missionview, phase, branch)
	elseif state == GameEnum.ChallengeBranchState.LOCKED then
		FloatWordMgr.instance:show(lang("clg_passbefore"))
	elseif state == GameEnum.ChallengeBranchState.PASSED then
		FloatWordMgr.instance:show(lang("tip_passed"))
	end

	ChallengeModel.instance:setCurBranch(branch)
end

function ChallengeViewBase:teamFightEnd()
	local phase = ChallengeModel.instance:getCurPhase()
	local branch = ChallengeModel.instance:getCurBranch()
	local bRes = BattleFacade.instance:getLastBattleResult()

	UIJumper.instance:pushOneStack(ViewName.challengemgrview, true)

	if ChallengeViewBase._prePhase == phase then
		if bRes == GameEnum.BattleResult.Success and ChallengeModel.instance:isBranchPassed(phase, branch) then
			UIJumper.instance:pushOneStack(ViewName.missionview, true, phase, branch + 1, true)
		else
			UIJumper.instance:pushOneStack(ViewName.missionview, true, phase, branch, true)
		end
	end
end

function ChallengeViewBase:_onClickStart()
	self:changeState(self:getCurState())
end

function ChallengeViewBase:onClickDetail()
	if self._cfg.getRaceIds then
		local raceId = self._cfg.getRaceIds[1]

		CommonTipsMgr.instance:showMaxLvlPetTips(raceId)
	end
end

function ChallengeViewBase:onClickJinHua()
	local challengeId = ChallengeModel.instance:getCurId()
	local cfg = ChallengeConfig.instance:getChallengeCfg(challengeId)

	local function callBack(petId)
		ChallengeController.instance:getPrize(challengeId, 0, petId, "", function()
			self:onEvolveFinish()
			GlobalModel.instance:setUIInteractable(false)
			AnimatorEffect.instance:onPlayEffect(self._preId, self._nowId, "storyconfig/animations/petevolve.txt", function()
				GlobalModel.instance:setUIInteractable(true)
				PetDisplayModel.instance:addNewPet(petId)
				PetDisplayController.instance:checkAndOpenDisplay()
			end)
		end)
	end

	local evolveMo = EvolveMo.New()

	evolveMo:setParamById(self._preId, self._nowId)
	evolveMo:setCallback(callBack)
	UIStateManager.instance:push(ViewName.Evolve, evolveMo)
end

function ChallengeViewBase:onClickClose()
	if self.CurState ~= 1 then
		self:changeState(1)
	else
		UIStateManager.instance:pop()
	end
end

function ChallengeViewBase:procPreFight()
	return
end

function ChallengeViewBase:onEvolveFinish()
	return
end

function ChallengeViewBase:buildDiffView()
	self._nameTxt = goutil.findChild(self._go, "Name/NameTxt"):GetComponent("Text")
	self._btnRoot = goutil.findChild(self._go, "PhaseRoot")
	self._closeBtn = Framework.ButtonAdapter.GetFrom(self._go, "Btn_Close")
	self._startBtn = Framework.ButtonAdapter.GetFrom(self._go, "PreFight/BtnStart")
	self._spBtn = Framework.ButtonAdapter.GetFrom(self._go, "PreFight/BtnGet")
	self._jinhuaBtn = Framework.ButtonAdapter.GetFrom(self._go, "JinHuaBtn")
	self._detailBtn = Framework.ButtonAdapter.GetFrom(self._go, "BtnDetail")
end

function ChallengeViewBase:getCurState()
	return ChallengeModel.instance:getCurPhase() + 2
end

function ChallengeViewBase:onClickSpecial()
	return
end

function ChallengeViewBase:_prizeGot()
	return
end

function ChallengeViewBase:getSpValues()
	return {
		0
	}
end

function ChallengeViewBase:getChallengeViewComponent()
	local presentor = ViewMgr.instance._views[ViewName.challengemgrview]

	return presentor._views[1]
end

function ChallengeViewBase:playEffect(path, parent, x, y, z, loop, scale)
	scale = scale or 1
	x = x or 0
	y = y or 0
	z = z or 0

	if loop == nil then
		loop = true
	end

	if not string.find(path, ".prefab") then
		path = path .. ".prefab"
	end

	local view = self:getChallengeViewComponent()
	local effect = UIEffectManager.instance:playEffect(view, path, parent, x, y, loop, false, nil, function(self, uiEffect)
		return
	end, self)

	effect:setParent(parent.transform)
	effect:setScale(scale)
	effect:setLocalPos(x, y, z)

	self.effList = self.effList or {}

	table.insert(self.effList, effect)

	return effect
end

function ChallengeViewBase:loadEffect(parentName, path, pos, scale, loadedCallback)
	local parentTrans = self._go.transform

	if parentName and parentName ~= "" then
		parentTrans = goutil.findChild(self._go, parentName).transform

		printInfo("此处执行了", parentTrans.name)
	end

	local view = self:getChallengeViewComponent()
	local effect = UIEffectManager.instance:playEffect(view, path, parentTrans, 0, 0, true, false, nil, function(self, uiEffect)
		GameUtil.callBack(loadedCallback, self, uiEffect)
	end, self)

	effect:setParent(parentTrans)
	effect:setScale(scale)
	effect:setLocalPos(pos.x, pos.y, pos.z)

	self.effList = self.effList or {}

	table.insert(self.effList, effect)

	return effect
end

return ChallengeViewBase
