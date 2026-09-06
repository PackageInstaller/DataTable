-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveMainView.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveMainView", package.seeall)

local NaiLongEvolveMainView = class("NaiLongEvolveMainView", ViewComponent)

function NaiLongEvolveMainView:buildUI()
	NaiLongEvolveMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnExtClg = self:getGo("btnExtClg/btn")
	self._itemBubbleCell = self:getGo("btnExtClg/bubble/itemcell")
	self._imgBubbleHasGain = self:getGo("btnExtClg/bubble/imgHasGain")
	self._effRoot = self:getGo("btnExtClg/bubble/effRoot")
	self._btnGain = self:getGo("btnExtClg/bubble/btnGain")
	self._txtScore = self:getTxt("btnExtClg/bubble/txtScore")
	self._txtSignIn = self:getTxt("btnExtClg/bubble/txtSignIn")
	self._imgPass = self:getGo("btnExtClg/btn/imgPass")
	self._imgPassBubble = self:getGo("btnExtClg/bubble/imgPass")
end

function NaiLongEvolveMainView:bindEvents()
	NaiLongEvolveMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "One"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "Two"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "Three"))
	GameUtil.addClickHandler(self._btnExtClg, self._onClickBtnExtClg, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickBtnGetPrize, self)
end

function NaiLongEvolveMainView:unbindEvents()
	NaiLongEvolveMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnExtClg)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function NaiLongEvolveMainView:onEnter()
	NaiLongEvolveMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgSignInRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyMilkDragonFightEndRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 451001
	end

	self._activityType = 451
	self._actCfg = NaiLongEvolveConfig.instance:getActData(self._activityId)
	self._stageCfg = NaiLongEvolveConfig.instance:getStageData(self._activityId)

	self:_onSetUI()
	NaiLongEvolveController.instance:sendPM_MilkDragonClgGetInfoReq(self._activityId)
end

function NaiLongEvolveMainView:onExit()
	NaiLongEvolveMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemBubbleCell)
	self:_onClearBubble()
end

function NaiLongEvolveMainView:_onSetUI()
	local scoreIcon = self._actCfg.scoreIcon
	local arr = string.split(scoreIcon, ":")

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self._actCfg.skinId)

	MaterialMgr.resetAll(self._itemBubbleCell)
	MaterialMgr.setCell(arr[1], arr[2], self._itemBubbleCell)
end

function NaiLongEvolveMainView:_onUpdate()
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)

	self:_onUpdateBubble()

	local isPass = NaiLongEvolveController.instance:isPass(self._activityId)

	GameUtil.SetActive(self._imgPass, isPass)
end

function NaiLongEvolveMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function NaiLongEvolveMainView:_onClickBtnJump(jumpStr)
	local btnStr = self._actCfg["jumpStr" .. jumpStr]

	GotoMgr.gotoByString(btnStr)
end

function NaiLongEvolveMainView:_onClickBtnExtClg()
	local stageNum = #self._stageCfg
	local isPass = stageNum <= self._info.curPassStageId

	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.NaiLongEvolveChallengeView, self._activityId)
end

function NaiLongEvolveMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self._actCfg.skinId)
end

function NaiLongEvolveMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self._actCfg.skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function NaiLongEvolveMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function NaiLongEvolveMainView:_onUpdateBubble()
	local pass = NaiLongEvolveController.instance:isPass(self._activityId)
	local leftDay = self._actCfg.maxSignInDays - self._info.signInDays

	self._txtScore.text = self._actCfg.dailySignInGainScore
	self._txtSignIn.text = leftDay <= 0 and "已完成全部签到" or "剩余可签到<color=#00FF0CFF>" .. leftDay .. "</color>天"

	GameUtil.SetActive(self._btnGain, leftDay > 0 and not self._info.todayHasSignIn and not pass)
	GameUtil.SetActive(self._imgBubbleHasGain, self._info.todayHasSignIn)
	GameUtil.SetActive(self._imgPassBubble, pass)
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	if leftDay > 0 and not self._info.todayHasSignIn and not pass then
		local effectParent = self._effRoot
		local clippParent = self._effRoot
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setClipping(clippParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._eff = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end
end

function NaiLongEvolveMainView:_onClearBubble()
	MaterialMgr.resetAll(self._itemBubbleCell)
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
end

function NaiLongEvolveMainView:_onClickBtnGetPrize()
	if self._info == nil then
		return
	end

	if not self._info.todayHasSignIn then
		NaiLongEvolveController.instance:sendPM_MilkDragonClgSignInReq(self._activityId)
	else
		FloatWordMgr.instance:show("今日已领取过，请明日再来")
	end
end

return NaiLongEvolveMainView
