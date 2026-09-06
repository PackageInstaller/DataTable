-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuMainView.lua

module("logic.extensions.kunwu.view.KunWuMainView", package.seeall)

local KunWuMainView = class("KunWuMainView", ViewComponent)

function KunWuMainView:buildUI()
	KunWuMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnNorClg = self:getGo("btnNorClg/btn")
	self._imgNorPass = self:getGo("btnNorClg/btn/imgPass")
	self._bubbleNor = self:getGo("btnNorClg/bubble")
	self._itemcellNor = self:getGo("btnNorClg/bubble/itemcell")
	self._btnGainNor = self:getGo("btnNorClg/bubble/btnGain")
	self._imgHasGainNor = self:getGo("btnNorClg/bubble/imgHasGain")
	self._effRootNor = self:getGo("btnNorClg/bubble/effRoot")
	self._btnExtClg = self:getGo("btnExtClg/btn")
	self._imgExtPass = self:getGo("btnExtClg/btn/imgPass")
	self._itemBubbleCell = self:getGo("btnExtClg/bubble/itemcell")
	self._imgBubbleHasGain = self:getGo("btnExtClg/bubble/imgHasGain")
end

function KunWuMainView:bindEvents()
	KunWuMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "One"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "Two"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "Three"))
	GameUtil.addClickHandler(self._btnNorClg, self._onClickBtnNorClg, self)
	GameUtil.addClickHandler(self._btnExtClg, self._onClickBtnExtClg, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnGainNor, self._onClickBtnGetNorPrize, self)
end

function KunWuMainView:unbindEvents()
	KunWuMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnNorClg)
	GameUtil.rmClickHandler(self._btnExtClg)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnGainNor)
end

function KunWuMainView:onEnter()
	KunWuMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_KunWuClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_KunWuClgGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyKunWuNormalFightEndRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 444001
	end

	self._activityType = KunWuController.instance:getActivityType()
	self._actCfg = KunWuConfig.instance:getKunWuActData(self._activityId)

	self:_onSetUI()
	KunWuController.instance:sendPM_KunWuClgGetInfoReq(self._activityId)
end

function KunWuMainView:onExit()
	KunWuMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._itemBubbleCell)
	MaterialMgr.resetAll(self._pointRare)
	self:_onClearNorBubble()
end

function KunWuMainView:_onSetUI()
	local extPassPrize = self._actCfg.extremeClgPassPrize

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self._actCfg.skinId)

	MaterialMgr.resetAll(self._itemBubbleCell)
	MaterialMgr.setCellByCfg(extPassPrize, self._itemBubbleCell)
end

function KunWuMainView:_onUpdate()
	GameUtil.SetActive(self._imgBubbleHasGain, KunWuModel.instance:hasPassedAllPhase(self._activityId))
	GameUtil.SetActive(self._imgNorPass, KunWuController.instance:isPassNor(self._activityId))
	GameUtil.SetActive(self._imgExtPass, KunWuModel.instance:hasPassedAllPhase(self._activityId))
	self:_onUpdateNorBubble()
end

function KunWuMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function KunWuMainView:_onClickBtnJump(jumpStr)
	local btnStr = self._actCfg["jumpStr" .. jumpStr]

	GotoMgr.gotoByString(btnStr)
end

function KunWuMainView:_onClickBtnNorClg()
	local isPassNor = KunWuController.instance:isPassNor(self._activityId)

	if isPassNor then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.KunWuNorView, self._activityId)
end

function KunWuMainView:_onClickBtnExtClg()
	local isPassExt = KunWuModel.instance:hasPassedAllPhase(self._activityId)

	if isPassExt then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.KunWuExtView, self._activityId)
end

function KunWuMainView:_getRaceId()
	return KunWuController.instance:getRaceId(self._activityId)
end

function KunWuMainView:_getSkinId()
	return KunWuController.instance:getSkinId(self._activityId)
end

function KunWuMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KunWuMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KunWuMainView:_onUpdateNorBubble()
	local prizeId = 0
	local cfg = KunWuConfig.instance:getKunWuNorProgressData(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if KunWuController.instance:isCanGetNorPrize(self._activityId, data.dataBitId) then
				prizeId = data.dataBitId

				break
			end
		end
	end

	self._norPrizeId = prizeId

	local data = KunWuConfig.instance:getKunWuNorProgressDataById(self._activityId, self._norPrizeId)

	if data == nil then
		GameUtil.SetActive(self._bubbleNor, false)
		GameUtil.SetActive(self._btnGainNor, false)
		self:_onClearNorBubble()

		return
	end

	GameUtil.SetActive(self._bubbleNor, true)
	GameUtil.SetActive(self._btnGainNor, true)
	MaterialMgr.setCellByCfg(data.prize, self._itemcellNor)
	UIEffectManager.instance:stopEffect(self._effNor)

	self._effNor = nil

	if self._norPrizeId > 0 then
		local effectParent = self._effRootNor
		local clippParent = self._effRootNor
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setClipping(clippParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._effNor = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end
end

function KunWuMainView:_onClearNorBubble()
	MaterialMgr.resetAll(self._itemcellNor)
	UIEffectManager.instance:stopEffect(self._effNor)

	self._effNor = nil
end

function KunWuMainView:_onClickBtnGetNorPrize()
	if self._norPrizeId <= 0 then
		return
	end

	if KunWuController.instance:isCanGetNorPrize(self._activityId, self._norPrizeId) then
		KunWuController.instance:sendPM_KunWuClgGainProgressPrizeReq(self._activityId, self._norPrizeId)
	end
end

return KunWuMainView
