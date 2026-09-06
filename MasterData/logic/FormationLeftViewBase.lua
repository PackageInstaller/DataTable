-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationLeftViewBase.lua

module("logic.extensions.formation.view.FormationLeftViewBase", package.seeall)

local FormationLeftViewBase = class("FormationLeftViewBase", ViewComponent)

function FormationLeftViewBase:ctor()
	self._Character = nil
	self._draggingPetId = nil
	self._isDraging = false
	self._dragSeat = nil
end

function FormationLeftViewBase:buildUI()
	self._RightView = self._viewPresentor._views[2]
	self._Nego_Character = self:getGo("Nego_Character")
	self._characterEffect = self:getGo("characterEffect")

	local _Nego_Left = self:getGo("Nego_Left")

	self._gotTipRoot = goutil.findChild(_Nego_Left, "got")

	if self._gotTipRoot then
		self._gotTips = {}

		for i = 1, 9 do
			self._gotTips[i] = goutil.findChild(self._gotTipRoot, "tip" .. i)
		end
	end

	self._ImgC_Drop = self:getGo("dropThrowAwayArea")

	local _Nego_TeamInfo = goutil.findChild(_Nego_Left, "Nego_TeamInfo")

	self._TxtC_Power = goutil.findChild(_Nego_TeamInfo, "Nego_TeamPower/TxtC_TeamPower"):GetComponent("Text")
	self._TxtC_Speed = goutil.findChild(_Nego_TeamInfo, "Nego_TeamSpeed/TxtC_TeamSpeed"):GetComponent("Text")
	self._powerBtn = Framework.ButtonAdapter.GetFrom(_Nego_TeamInfo, "Nego_TeamPower")
	self._speedBtn = Framework.ButtonAdapter.GetFrom(_Nego_TeamInfo, "Nego_TeamSpeed/BtnSpeed")
	self._arrowGo = goutil.find("ImgArrow")

	local _Nego_Seats = goutil.findChild(_Nego_Left, "Nego_Seats")
	local startOrder = goutil.findChild(_Nego_Left, "startOrder")

	self._seats = {}
	self._startOrderGos = {}
	self._startOrderTxts = {}

	for i = 1, 9 do
		local go = goutil.findChild(_Nego_Seats, string.format("Item_Seat_%d", i))

		if not self._noNeedDrag then
			DropHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnDropSeat(_go, eventData)
			end)
			BeginDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnBeginDragSeat(_go, eventData)
			end)
			EndDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnEndDragSeat(_go, eventData)
			end)
			DragHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_OnDragSeat(_go, eventData)
			end)
			PointerEnterHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_onEnterSeat(_go, eventData)
			end)
			PointerExitHandler.Get(go):AddLuaHandler(function(_go, eventData)
				self:_onExitSeat(_go, eventData)
			end)
		end

		PointerClickHandler.Get(go):AddLuaHandler(function(_go, eventData)
			if eventData.dragging then
				return
			end

			self:_OnClickSeat(_go, eventData)
		end)

		self._seats[i] = go

		local startOrderGo = goutil.findChild(_Nego_Left, string.format("startOrder/item%d", i))

		self._startOrderGos[i] = startOrderGo
		self._startOrderTxts[i] = goutil.findChild(startOrderGo, "bg/Text"):GetComponent(goutil.Type_UIText)

		GameUtil.SetActive(startOrderGo, false)

		local pathLayerUI = "layerUI/item" .. i

		GameUtil.SetActive(goutil.findChild(_Nego_Left, pathLayerUI .. "/ImgC_Info"), false)
		GameUtil.SetActive(goutil.findChild(_Nego_Left, pathLayerUI .. "/Btn_Summon"), false)
		GameUtil.SetActive(goutil.findChild(_Nego_Left, pathLayerUI .. "/ImgC_Title"), false)
		GameUtil.SetActive(goutil.findChild(_Nego_Left, pathLayerUI .. "/txtTitle"), false)
	end

	self._selectEffectGo = self:getGo("Nego_Left/selectEffect")

	GameUtil.SetActive(self._selectEffectGo, false)
	self:_initSelectView(_Nego_Left)
	self:_initDomainSkills()
	self:_initPsychicSkill()
	self:_initSpiritInvocationSkill()
	self:_initElementSkill()
	self:_initHeavenAwakenSummonSkill()
end

function FormationLeftViewBase:_initHeavenAwakenSummonSkill()
	local go = self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select/Btn_HeavenAwaken")

	if go then
		self._heavenAwakenSummonSkillGo = go
		self._heavenAwakenSummonSkillIcon = goutil.findChild(go, "IconBg/Icon")
		self._heavenAwakenSummonSkillName = goutil.findChildTextComponent(go, "txt")
	end
end

function FormationLeftViewBase:_initElementSkill()
	local elementSkill = self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select/Btn_Element")

	if elementSkill then
		self._elementSkillGo = elementSkill
		self._elementSkillIcon = goutil.findChild(elementSkill, "IconBg/Icon")
		self._elementSkillName = goutil.findChildTextComponent(elementSkill, "TxtC_Psychic")
		self._elementSkillIconImage = self._elementSkillIcon:GetComponent(goutil.Type_UIImage)
	end
end

function FormationLeftViewBase:_initDomainSkills()
	local domainSkill = self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select/Btn_DomainSkill")

	if domainSkill then
		self._domainSkillGo = domainSkill
		self._btnDomainSkill = Framework.ButtonAdapter.GetFrom(domainSkill, "DomainSkill")
		self._domainSkillIcon = goutil.findChild(self._btnDomainSkill.gameObject, "Icon")
		self._domainSkillName = goutil.findChildTextComponent(self._btnDomainSkill.gameObject, "imgBg/Text")
	end
end

function FormationLeftViewBase:_initPsychicSkill()
	local psychicSkill = self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select/Btn_Psychic")

	if psychicSkill then
		self._psychicSkillGo = psychicSkill
		self._btnPsychicSkill = Framework.ButtonAdapter.Get(psychicSkill)
		self._psychicSkillIcon = goutil.findChild(psychicSkill, "IconBg/Icon")
		self._psychicSkillName = goutil.findChildTextComponent(psychicSkill, "TxtC_Psychic")
	end
end

function FormationLeftViewBase:_initSpiritInvocationSkill()
	local spiritInvocationSkill = self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select/Btn_SpiritInvocationSkill")

	if spiritInvocationSkill then
		self._spiritInvocationSkillGo = spiritInvocationSkill
		self._btnSpiritInvocationSkill = Framework.ButtonAdapter.Get(spiritInvocationSkill)
		self._spiritInvocationSkillIcon = goutil.findChild(spiritInvocationSkill, "Icon")
		self._spiritInvocationSkillName = goutil.findChildTextComponent(spiritInvocationSkill, "imgBg/Text")
	end
end

function FormationLeftViewBase:_initSelectView(_Nego_Left)
	local _Nego_Select = goutil.findChild(_Nego_Left, "SelectView/Viewport/Content/Nego_Select")

	_Nego_Select = _Nego_Select or goutil.findChild(_Nego_Left, "Nego_Select")
	self._Btn_Formation = goutil.findChild(_Nego_Select, "Btn_Formation")
	self._TxtC_Formation = goutil.findChild(self._Btn_Formation.gameObject, "TxtC_Formation"):GetComponent("Text")
	self._Popup_Formation = goutil.findChild(self._Btn_Formation.gameObject, "Nego_PopupMenu")
	self._formationIcon = goutil.findChild(self._Btn_Formation.gameObject, "IconBg/Icon"):GetComponent("UIImageSpriteChange")

	GameUtil.SetActive(self._Btn_Formation, false)

	self._Btn_FormationEdit = goutil.findChild(_Nego_Select, "Btn_FormationEdit")
	self._txtFormationEdit = goutil.findChildTextComponent(_Nego_Select, "Btn_FormationEdit/txt")

	GameUtil.SetActive(self._Btn_FormationEdit, false)

	self._Btn_FormationUse = goutil.findChild(_Nego_Select, "Btn_FormationUse")
	self._txtFormationUse = goutil.findChildTextComponent(_Nego_Select, "Btn_FormationUse/txt")

	GameUtil.SetActive(self._Btn_FormationUse, true)

	self._Btn_CutePet = goutil.findChild(_Nego_Select, "Btn_CutePet"):GetComponent("UIImageSpriteChange")
	self._cutePetIcon = goutil.findChild(_Nego_Select, "Btn_CutePet/Icon")
	self._isUseCutePet = GameUtil.GetActive(self._Btn_CutePet)
	self._Btn_HeroSkill = goutil.findChild(_Nego_Select, "Btn_HeroSkill"):GetComponent("UIImageSpriteChange")
	self._heroSkillIcon = goutil.findChild(_Nego_Select, "Btn_HeroSkill/Icon")
	self._Popup_HeroSkill = goutil.findChild(self._Btn_HeroSkill, "Nego_Skill")
	self._Popup_SkillFormation = goutil.findChild(self._Btn_HeroSkill, "Nego_PopupMenu")
	self._Btn_ContractPet = goutil.findChild(_Nego_Select, "Btn_ContractPet"):GetComponent("UIImageSpriteChange")
	self._contactPetIcon = goutil.findChild(_Nego_Select, "Btn_ContractPet/IconBg/Icon")
	self._TxtC_ContractPet = goutil.findChild(self._Btn_ContractPet, "TxtC_ContractPet"):GetComponent("Text")

	self._Btn_ContractPet.gameObject:SetActive(true)

	self._Btn_BuffForm = goutil.findChild(_Nego_Select, "Btn_BuffForm")
	self._Icon_Go_BuffForm = goutil.findChild(self._Btn_BuffForm, "icon")
	self._Icon_BuffForm = goutil.findChild(self._Btn_BuffForm, "icon"):GetComponent("UIImageSpriteChange")
	self._Txt_Lv_BuffForm = goutil.findChildTextComponent(self._Icon_Go_BuffForm, "lv/txt")
	self._MarkLock_BuffForm = goutil.findChild(self._Btn_BuffForm, "markLock")
	self._MarkNotActive_BuffForm = goutil.findChild(self._Btn_BuffForm, "markNotActive")
	self._TxtC_BuffForm = goutil.findChild(_Nego_Select, "Btn_BuffForm/text"):GetComponent(goutil.Type_UIText)
end

function FormationLeftViewBase:destroyUI()
	FormationLeftViewBase.super.destroyUI(self)
end

function FormationLeftViewBase:bindEvents()
	GameUtil.addClickHandler(self._Btn_FormationEdit, self._OnClickBtnFormationEidt, self)
	GameUtil.addClickHandler(self._Btn_FormationUse, self._OnClickBtnFormationUse, self)
	GameUtil.addClickHandler(self._Btn_Formation, self._OnClickBtnFormation, self)
	GameUtil.addClickHandler(self._Btn_CutePet, self._OnClickCutePet, self)
	GameUtil.addClickHandler(self._Btn_HeroSkill, self._OnClickBtnHeroSkill, self)
	GameUtil.addClickHandler(self._Btn_ContractPet, self._OnClickBtnContractPet, self)
	GameUtil.addClickHandler(self._Btn_BuffForm, self._OnClickBtnBuffForm, self)
	GameUtil.addClickHandler(self._heavenAwakenSummonSkillGo, self._onClickBtnHeavenAwakenSummon, self)

	self._onDropBgHandler = DropHandler.Get(self._ImgC_Drop.gameObject):AddLuaHandler(function(go, eventData)
		self:_OnDropBg()
	end)

	self._powerBtn:AddClickListener(self._onClickPower, self)
	self._speedBtn:AddClickListener(self._onClickSpeed, self)

	if self._btnDomainSkill then
		self._btnDomainSkill:AddClickListener(self._onClickDomainSkill, self)
	end

	if self._btnPsychicSkill then
		self._btnPsychicSkill:AddClickListener(self._onClickPsychicSkill, self)
	end

	GameUtil.addClickHandler(self._btnSpiritInvocationSkill, self._onClickSpiritInvocationSkill, self)
	GameUtil.addClickHandler(self._elementSkillGo, self._onClickElementSkill, self)
end

function FormationLeftViewBase:unbindEvents()
	GameUtil.rmClickHandler(self._Btn_FormationEdit)
	GameUtil.rmClickHandler(self._Btn_FormationUse)
	GameUtil.rmClickHandler(self._Btn_Formation)
	GameUtil.rmClickHandler(self._Btn_CutePet)
	GameUtil.rmClickHandler(self._Btn_HeroSkill)
	GameUtil.rmClickHandler(self._Btn_ContractPet)
	GameUtil.rmClickHandler(self._Btn_BuffForm)
	GameUtil.rmClickHandler(self._heavenAwakenSummonSkillGo)
	DropHandler.Get(self._ImgC_Drop.gameObject):RemoveLuaHandler(self._onDropBgHandler)
	self._powerBtn:RemoveClickListener()
	self._speedBtn:RemoveClickListener()

	if self._btnDomainSkill then
		self._btnDomainSkill:RemoveClickListener()
	end

	if self._btnPsychicSkill then
		self._btnPsychicSkill:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._elementSkillGo)
end

function FormationLeftViewBase:_onEnterBindingEvent()
	PetCvController.instance:setListener(self._onCvPlayFinished, self)
	GlobalDispatcher:addListener(GlobalNotify.TeamChanged, self._OnTeamChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationChanged, self._OnFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPosChanged, self._OnSeatValueChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationHeroSkillChanged, self._OnHeroSkillChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationDragBegin, self._onBagBeginDrag, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationDropBag, self._onBagEndDrag, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationNameChange, self._setCurFmtName, self)
	GlobalDispatcher:addListener(FormationAgent.PM_SetTabNameRes, self._onSetFormationTabSuccess, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.FormationClickPet, self._petClicked, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationUpdateStartOrder, self._updateStartOrder, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationChangeToSpecialPos, self._onUpdateSpecialPos, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationSelectPsychicedSkill, self._onFormationSelectPsychicedSkill, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationSelectSpiritInvocationSkill, self._onFormationSelectSpiritInvocationSkill, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationSelectElementSkill, self._setElementSkill, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self.onRecoverSeatPetMap, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.CancelContractInfo, self.onCancelContractInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.SetContractInfo, self.onSetContractInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MakeContractRes, self.onResSetContractInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.FormatForceEndDrag, self._OnForceDropSeat, self)
	self.addGEvent(self, GlobalNotify.FormationTabModify, self._onGroupTabModify, self)
end

function FormationLeftViewBase:_onExitUnbindingEvent()
	PetCvController.instance:setListener()
	GlobalDispatcher:removeListener(GlobalNotify.FormationSelectPsychicedSkill, self._onFormationSelectPsychicedSkill, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationSelectSpiritInvocationSkill, self._onFormationSelectSpiritInvocationSkill, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationSelectElementSkill, self._setElementSkill, self)
	GlobalDispatcher:removeListener(GlobalNotify.TeamChanged, self._OnTeamChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChanged, self._OnFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPosChanged, self._OnSeatValueChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationHeroSkillChanged, self._OnHeroSkillChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDragBegin, self._onBagBeginDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDropBag, self._onBagEndDrag, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationNameChange, self._setCurFmtName, self)
	GlobalDispatcher:removeListener(FormationAgent.PM_SetTabNameRes, self._onSetFormationTabSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationClickPet, self._petClicked, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationUpdateStartOrder, self._updateStartOrder, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeToSpecialPos, self._onUpdateSpecialPos, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self.onRecoverSeatPetMap, self, NotifyPriority.Low)
	GlobalDispatcher:removeListener(GlobalNotify.CancelContractInfo, self.onCancelContractInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SetContractInfo, self.onSetContractInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MakeContractRes, self.onResSetContractInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormatForceEndDrag, self._OnForceDropSeat, self)

	self._isPrevLeftFirst = nil
end

function FormationLeftViewBase:onCancelContractInfo(summonMasterId, summonedPetId)
	return
end

function FormationLeftViewBase:onSetContractInfo(summonMasterId, summonedPetId)
	return
end

function FormationLeftViewBase:onResSetContractInfo(summonMasterId, summonedPetId)
	self:onTrySetSummonPetBySendMsg(summonMasterId, summonedPetId)
end

function FormationLeftViewBase:onTrySetSummonPetBySendMsg(summonMasterId, summonedPetId)
	self:trySetSummonPetByMasterId(summonMasterId, summonedPetId)
end

function FormationLeftViewBase:onRecoverSeatPetMap(changePetIdList)
	for id, v in pairs(changePetIdList or {}) do
		local itemStartSeat = self:_getItemSeatByPetId(id)

		if itemStartSeat then
			itemStartSeat:updatePetMo(self:_getPet(id))
			itemStartSeat:recoverPetShow()
			itemStartSeat:recoverRaceType()
			self:_SetHeroSkill()
		end
	end
end

function FormationLeftViewBase:onRecoverSeatPet(oldPet, newPet)
	local itemStartSeat = self:_getItemSeatByPetId(newPet.petId)

	if itemStartSeat then
		itemStartSeat:recoverPetShow()
		itemStartSeat:recoverRaceType()
		self:_SetHeroSkill()
	end
end

function FormationLeftViewBase:onEnter()
	self:_beforeUseFormationMo()
	self:_onEnterBindingEvent()

	self._delayPara = 0
	self._isCanShowContractBtn = true

	local fid, flvl = self:GetFormStrengthIdAndLv()

	self._CurFormId = fid
	self.lastHeroSkollId = self:_getHeroSkillId()
	self._isDraging = false
	self._dragingGo = nil

	self._ImgC_Drop.gameObject:SetActive(false)
	GameUtil.SetActive(self._selectEffectGo, false)

	if self._arrowGo then
		self._arrowGo:SetActive(false)
	end

	self:_initFixedPos()
	self:_initSelfFormation()
	MissionModel.instance:setForceResetOneKey(true)
	settimer(0, self._updateInputWhileDragging, self, -1)
	self:_refreshBuffForm()
	self:_activeCharacterEffect(false)
	self:_loadCharacterEffect()
	self:_loadSelectEffect()
	self:_isShowNewActBonds(false)

	self._curBonds = {}

	self:_showNewActBonds()
	self:_isShowNewActBonds(true)
end

function FormationLeftViewBase:_initSelfFormation()
	self:_RefreshView()
end

function FormationLeftViewBase:onEnterFinished()
	self:_updateStartOrder()
end

function FormationLeftViewBase:onExit()
	self:_onExitUnbindingEvent()
	removetimer(self._doPlayAudio, self)
	removetimer(self._playFormationAni, self)

	self._formationChangeFlag = false
	self._playingCVPetId = nil
	self._readyToPlayingCvPetId = nil

	self:_saveCurrFmt()

	self._conditionId = nil
	self._CurFormId = 0

	GuideController.instance:setViewVar("formationleftview_heroskill", nil)
	self:_removeSelectEffect()
	self:_removeAllFixedEffs()
	self:_isSkipFirstHeroSkillEffect(nil)
	uGuiUtil.clearImage(self._contactPetIcon.gameObject)
	PetRelationController.instance:closePetrelationAlertView()
	UIStateManager.instance:popByName(ViewName.ElementpopView)
	UIStateManager.instance:popByName(ViewName.CutepetassistanceselectView)
	UIStateManager.instance:popByName(ViewName.FormationgroupView)
	UIStateManager.instance:popByName(ViewName.HeavenAwakenSummonPopView)
	UIStateManager.instance:popByName(ViewName.CustomSummonPopSelectView)
	UIStateManager.instance:popByName(ViewName.MissionPsychicsedSkills)
	UIStateManager.instance:popByName(ViewName.MissionDomainSkills)
	UIStateManager.instance:popByName(ViewName.FmtFeatureView)
end

function FormationLeftViewBase:onExitFinished()
	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:onExit()
	end

	removetimer(self._updateInputWhileDragging, self)

	if self._isDraging and self._dragSeat then
		self:_clearDragging()
	end

	if self._domainSkillIcon then
		MaterialMgr.clearIcon(self._domainSkillIcon)
	end

	if self._psychicSkillIcon then
		MaterialMgr.clearIcon(self._psychicSkillIcon)
	end

	if self._elementSkillIcon then
		MaterialMgr.clearIcon(self._elementSkillIcon)
	end
end

function FormationLeftViewBase:_updateInputWhileDragging()
	if FormationController.instance:isGuidingBuzhen() then
		return
	end

	if self._isDraging and self._dragSeat and UGUIToolHelper.IsMultiTouchDown() then
		self:_clearDragging()
	end
end

function FormationLeftViewBase:_clearDragging()
	if not goutil.isNil(self._Character) then
		self._loader, self._lastCallBack, self._asset = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._asset)

		goutil.destroy(self._Character, true)

		self._Character = nil
	end

	local posId = self._dragSeat:GetPosition()

	self:_changePosition(posId, 0)

	self._dragSeat = nil

	self._ImgC_Drop.gameObject:SetActive(false)
	self:_activeCharacterEffect(false)
	GlobalDispatcher:dispatch(GlobalNotify.FormationEndDragSeat)
end

function FormationLeftViewBase:_OnMenuCloseTeam()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickTeam, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseTeam, self)
end

function FormationLeftViewBase:_OnMenuClickTeam(id)
	self:_OnClickTeamItem(id)
end

function FormationLeftViewBase:_OnMenuCloseFormation()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickFormation, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseFormation, self)
end

function FormationLeftViewBase:_onClickPower()
	FloatWordMgr.instance:show(lang("text_all_power") .. " " .. self._TxtC_Power.text)
end

function FormationLeftViewBase:_onClickSpeed()
	FloatWordMgr.instance:show(lang("text_all_speed") .. " " .. self._TxtC_Speed.text)
end

function FormationLeftViewBase:_OnMenuClickFormation(id)
	self:_OnClickFormationItem(id)
end

function FormationLeftViewBase:_onClickDomainSkill()
	local positions = self:_getCurPositions()
	local petDatas = {}

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if petMo then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

				if petCo.domainSkillId ~= 0 then
					table.insert(petDatas, petMo)
				end
			end
		end
	end

	ViewMgr.instance:open(ViewName.MissionDomainSkills, petDatas)
end

function FormationLeftViewBase:_OnClickBtnFormationEidt()
	UIStateManager.instance:push(ViewName.FormationgroupView, FormationgroupView.TYPE_EDITOR)
end

function FormationLeftViewBase:_OnClickBtnFormationUse()
	UIStateManager.instance:push(ViewName.FormationgroupView, FormationgroupView.TYPE_NORMAL)
end

function FormationLeftViewBase:_OnClickBtnFormation()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchFormationButton)
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseFormation, self)
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickFormation, self)

	local teams = FormationNewModel.instance:GetAllTeams()
	local t = {}

	for _, id in pairs(GameEnum.FormationType) do
		local team = teams[id]
		local name = ""
		local gray = true

		if team then
			name = team:getTabName()
			gray = false
		else
			name = "阵型" .. id
			gray = true
		end

		t[id] = {
			name = name,
			value = id,
			gray = gray
		}
	end

	local viewMgr = ViewMgr.instance
	local viewName = ViewName.formationpopupmenu

	if viewMgr:isOpen(viewName) then
		viewMgr:close(viewName)
	end

	local teamId = self:_getCurrTeamId()

	printInfo("teamId = ", teamId)
	viewMgr:open(viewName, self._Popup_Formation.transform.position, t, false, "", false, teamId)
end

function FormationLeftViewBase:_OnClickTeamItem(id)
	self:_changeTeamId(id)
end

function FormationLeftViewBase:_OnClickFormationItem(id)
	if self:_checkHasTeam(id) then
		self:_changeTeamId(id)
	else
		printInfo("此时的id是： = ", id)

		local cfg = BattleConfig.instance:getFormationUnlockCfg(id)
		local param = {}

		param.type = cfg.type
		param.desc = cfg.desc

		UIStateManager.instance:open(ViewName.FmtUnlockView, param)
	end
end

function FormationLeftViewBase:_GetFormationName(id)
	return BattleConfig.instance:getFormationCo(id).name
end

function FormationLeftViewBase:_GetFormationDesc(id)
	local formation = BattleConfig.instance:getFormationCo(id)

	return string.format("%s\n%s", formation.name, formation.properties)
end

function FormationLeftViewBase:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()

	if index ~= FormationNewModel.arenaTeamId then
		self._formationIcon:SetState(index - 1)
	else
		self._formationIcon:SetState(index - 1)
	end
end

function FormationLeftViewBase:_setCurFmtName(tabId, tabName)
	local teamTabId = self:_getCurFormId()

	if teamTabId ~= tabId then
		return
	end

	self._TxtC_Formation.text = tabName
end

function FormationLeftViewBase:_updateDomainSkill()
	if not self._domainSkillGo then
		return
	end

	local positions = self:_getCurPositions()
	local raceId, domainSkillId

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if petMo then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

				if petCo.domainSkillId ~= 0 then
					raceId = petMo.raceId
					domainSkillId = petCo.domainSkillId

					break
				end
			end
		end
	end

	if not raceId then
		self._domainSkillGo:SetActive(false)
	else
		self._domainSkillGo:SetActive(true)

		self._domainSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.Domain]

		MaterialMgr.setIcon(self._domainSkillIcon, MatType.Pet, raceId)
	end
end

function FormationLeftViewBase:_SetHeroSkill(id)
	id = checknumber(id)

	local toId = id

	if toId == 0 then
		toId = self:_getHeroSkillId()
	end

	local skills = self:_getPetsHeroSkills()

	if TableUtil.isHad(skills, toId) then
		-- block empty
	else
		toId = table.getn(skills) > 0 and skills[1] or 0
	end

	toId = checknumber(toId)

	if toId > 0 then
		self._heroSkillIcon:SetActive(true)
		self._Btn_HeroSkill:ChangeStateNow(0)
	else
		self._heroSkillIcon:SetActive(false)
		self._Btn_HeroSkill:ChangeStateNow(1)
	end

	if self.lastHeroSkollId ~= toId then
		self.lastHeroSkollId = toId

		self:_changeHeroSkillId(toId)
		self:_playEffectOnChangeHeroSkillId(-1, self.lastHeroSkollId)
	end

	self:_setSkillBtnName(self.lastHeroSkollId)
	self:_setHeroSkillEffect(self.lastHeroSkollId)
end

function FormationLeftViewBase:_setHeavenAwakenSummonSkill()
	local _curMasterId = self:_getCurFormation():GetHeavenAwakenMasterId()
	local _targetId = self:_getCurFormation():GetHeavenAwakenSummonPetId()
	local hasMaster = self:_checkHasJob(GameEnum.CareerType.Tianjue)

	if hasMaster then
		local petIds = self:_getTianjuePetIds()

		if _curMasterId > 0 then
			if not table.indexof(petIds, _curMasterId) then
				_curMasterId = petIds[1]
				_targetId = 0
			end
		else
			_curMasterId = petIds[1]
		end

		local petMo = self:_getPet(_curMasterId)

		if petMo and not petMo.isMyPackPet then
			_targetId = checknumber(petMo.heavenAwakenSummonPetId)
		end
	else
		_curMasterId = 0
		_targetId = 0
	end

	GameUtil.SetActive(self._heavenAwakenSummonSkillGo, hasMaster)
	GameUtil.SetActive(self._heavenAwakenSummonSkillIcon, false)

	if self._heavenAwakenSummonSkillName then
		self._heavenAwakenSummonSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.TianjueSkill]
	end

	if _curMasterId > 0 and _targetId > 0 and self._heavenAwakenSummonSkillIcon then
		local petMo = self:_getPet(_curMasterId)

		if petMo then
			GameUtil.SetActive(self._heavenAwakenSummonSkillIcon, true)
			MaterialMgr.setIcon(self._heavenAwakenSummonSkillIcon, MatType.Pet, petMo.curFaceId)
		end
	end

	self:_getCurFormation():SetHeavenAwakenMasterId(_curMasterId)
	self:_getCurFormation():SetHeavenAwakenSummonPetId(_targetId)
end

function FormationLeftViewBase:_setElementSkill()
	local _curMasterId = self:_getCurFormation():GetElementalMasterId()
	local _targetId = self:_getCurFormation():GetElementalTargetId()

	GameUtil.SetActive(self._elementSkillGo, _curMasterId > 0)
	GameUtil.SetActive(self._elementSkillIcon, false)

	if self._elementSkillName then
		self._elementSkillName.text = lang("元素师")
	end

	if _curMasterId > 0 and self._elementSkillIcon then
		local petMo = self:_getPet(_curMasterId)

		if petMo then
			GameUtil.SetActive(self._elementSkillIcon, true)
			MaterialMgr.setIcon(self._elementSkillIcon, MatType.Pet, petMo.curFaceId)
		end

		local gray = "909090"
		local colorStr = _targetId <= 0 and gray or ColorConst.White

		Framework.ColorUtil.SetImageColor(self._elementSkillIconImage, colorStr)
	end

	self:_playChangeRaceTypeEff()
end

function FormationLeftViewBase:_playChangeRaceTypeEff()
	local eleMap = self:_getCurElementMap()
	local poisitions = self:_getCurPositions()
	local effect_path = "20220930/yuansushixitong/fx_ui_yssxt_qiehuan.prefab"

	effect_path = UIEffectManager.instance:getEffectPath(effect_path)

	for i, targetId in ipairs(poisitions) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		if checknumber(eleMap[targetId]) > 0 then
			local petMo = self:_getPet(targetId)

			itemSeat:setRaceType(petMo, eleMap)
			itemSeat:playElementSkillEffect(self, effect_path, 1)
		else
			itemSeat:removeElementSkillEffect()
		end
	end
end

function FormationLeftViewBase:_setPsychicedSkill(id)
	self._psychicSkillGo:SetActive(false)

	local toId = self:_checkPsychicedSkill(id)

	self:_changePsychicedSkillId(toId)

	if not self._psychicSkillGo then
		return
	end

	local psychics

	if toId > 0 then
		psychics = self:_getPsychicsPetBySkillId(toId)
	end

	if not psychics then
		self._psychicSkillIcon:SetActive(false)
	else
		self._psychicSkillGo:SetActive(true)
		self._psychicSkillIcon:SetActive(true)

		self._psychicSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.PsychicSkill]

		MaterialMgr.setIcon(self._psychicSkillIcon, MatType.Pet, psychics.curFaceId)
	end
end

function FormationLeftViewBase:_checkPsychicedSkill(id)
	local toId = id

	if toId == nil then
		toId = self:_getPsychicedSkillId()
	end

	toId = checknumber(toId)

	local pets = self:_getPetsPsychics()
	local isValid = false

	if toId > 0 then
		for i = 1, #pets do
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pets[i].curFaceId)

			if petCo.psychicSkillId == toId then
				isValid = true

				break
			end
		end
	end

	if not isValid then
		if table.getn(pets) > 0 then
			local petCo = PetSkinConfig.instance:getPetSkinCfg(pets[1].curFaceId)

			toId = petCo.psychicSkillId
		else
			toId = 0
		end
	end

	toId = checknumber(toId)

	return toId
end

function FormationLeftViewBase:_onFormationSelectPsychicedSkill(id)
	self:_setPsychicedSkill(id)
end

function FormationLeftViewBase:_setSpiritInvocationSkill(petId)
	if not self._spiritInvocationSkillGo then
		return
	end

	self._spiritInvocationSkillGo:SetActive(false)

	local toPetId = self:_checkSpiritInvocationSkill(petId)

	self:_changeSpiritInvocationPetId(toPetId)

	local petMo

	if toPetId > 0 then
		petMo = self:_getPet(checknumber(toPetId))
	end

	if not petMo then
		GameUtil.SetActive(self._spiritInvocationSkillIcon, false)
	else
		self._spiritInvocationSkillGo:SetActive(true)
		GameUtil.SetActive(self._spiritInvocationSkillIcon, true)
		MaterialMgr.setIcon(self._spiritInvocationSkillIcon, MatType.Pet, petMo.curFaceId)

		self._spiritInvocationSkillName.text = ConstString.SkillType[GameEnum.SkillRaceType.SpiritInvocationSkill]
	end
end

function FormationLeftViewBase:_checkSpiritInvocationSkill(petId)
	local toPetId = petId

	if toPetId == nil then
		toPetId = self:_getSpiritInvocationPetId()
	end

	toPetId = checknumber(toPetId)

	local pets = self:_getPetsSpiritInvocation()
	local isValid = false

	if toPetId > 0 then
		for i = 1, #pets do
			if checknumber(pets[i].petId) == toPetId then
				isValid = true

				break
			end
		end
	end

	if not isValid then
		toPetId = table.getn(pets) > 0 and checknumber(pets[1].petId) or 0
	end

	return checknumber(toPetId)
end

function FormationLeftViewBase:_onFormationSelectSpiritInvocationSkill(petId)
	self:_setSpiritInvocationSkill(petId)
end

function FormationLeftViewBase:_setSkillBtnName(id)
	local skillCo = BattleConfig.instance:getSkillCo(id)

	if skillCo == nil then
		printInfo("id:" .. id)

		return
	end

	self._heroSkillIcon:SetActive(id > 0)
	BagPetsFacade.setHeadIconByRaceId(self._heroSkillIcon, math.fmod(id, 100000))
end

function FormationLeftViewBase:_getSummonMasterId()
	local formationMo = self:_getCurFormation()

	return formationMo:GetSummonMasterPetId()
end

function FormationLeftViewBase:_checkHasJob(idx_GameEnum_CareerType)
	local formationMo = self:_getCurFormation()

	for idx, v in ipairs(formationMo:GetPositions()) do
		local petMo = self:_getPet(v)

		if petMo then
			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
			local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

			if firstJobIdx == idx_GameEnum_CareerType or secondJobIdx == idx_GameEnum_CareerType then
				return true
			end
		end
	end

	return false
end

function FormationLeftViewBase:_SetSummonPet()
	GameUtil.SetActive(self._Btn_ContractPet, false)

	if self._isCanShowContractBtn and self:_checkHasJob(GameEnum.CareerType.Zhaohuanshi) then
		GameUtil.SetActive(self._Btn_ContractPet, true)
	end

	local summonMasterId = self:_getSummonMasterId()

	if summonMasterId > 0 then
		self._contactPetIcon:SetActive(true)
		self._Btn_ContractPet:ChangeStateNow(0)

		local petMo = self:_getPet(summonMasterId)

		if petMo then
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))
			local url = GameUrl.getCharacterIconUrl(modelCo.headName)

			uGuiUtil.setSpriteToImage(self._contactPetIcon.gameObject, nil, url)
		end
	else
		self._contactPetIcon:SetActive(false)
		self._Btn_ContractPet:ChangeStateNow(1)
	end

	self._TxtC_ContractPet.text = "召唤师"
end

function FormationLeftViewBase:_getCutePetInfo()
	local cutePetRaceId, cutePetQuality = 0, 0

	if self._isUseCutePet == nil or self._isUseCutePet == true then
		local formationMo = self:_getCurFormation()

		cutePetRaceId, cutePetQuality = formationMo:getCutePetInfo()
	end

	return cutePetRaceId, cutePetQuality
end

function FormationLeftViewBase:_SetCutePet()
	local cutePetRaceId, cutePetQuality = self:_getCutePetInfo()

	if cutePetRaceId > 0 then
		self._Btn_CutePet:ChangeStateNow(0)
		self._cutePetIcon:SetActive(true)
		MaterialMgr.setIcon(self._cutePetIcon, MatType.CutePet, cutePetRaceId)
	else
		self._Btn_CutePet:ChangeStateNow(1)
		self._cutePetIcon:SetActive(false)
	end
end

function FormationLeftViewBase:_RefreshView(pos, petId, isFilterAll, notRefreshSeat)
	local formationId = self:_getCurFormId()

	self:_SetFormationNameAndIcon(formationId)
	self:_RefeshSeats(pos, petId, isFilterAll)
	self:_SetCutePet()
	self:_SetSummonPet()
	self:_SetHeroSkill()
	self:_updateDomainSkill()
	self:_setPsychicedSkill()
	self:_setSpiritInvocationSkill()
	self:_setElementSkill()
	self:_setFusionSkillEffect()
	self:_setSummonContractSkillEffect()
	self:_setHeavenAwakenSummonSkill()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChangeFinish)
	self:_refreshBuffForm()
	self:_SetPowerAndSpeed()
	self:_initFixedEffs()
end

function FormationLeftViewBase:_RefreshViewOnHeroSkillChanged(id)
	local formationId = self:_getCurFormId()

	self:_SetFormationNameAndIcon(formationId)
	self:_RefeshSeats()
	self:_SetCutePet()
	self:_SetSummonPet()
	self:_SetHeroSkill(id)
	self:_setSpiritInvocationSkill()
	self:_setElementSkill()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChangeFinish)
	self:_refreshBuffForm()
	self:_SetPowerAndSpeed()
end

function FormationLeftViewBase:_getPowerAndSpeed()
	local team, formation, speed = self:getTeamAndFormation()
	local fid, flvl = self:GetFormStrengthIdAndLv()
	local heroSkill = self:_getHeroSkillId()
	local eleMap = self:_getCurElementMap()
	local cutePetRaceId, cutePetQuality = self:_getCutePetInfo()
	local fmtMo = self:_getCurFormation()
	local masterId = fmtMo:GetSummonMasterPetId()
	local summonId = fmtMo:GetSummonPetId()
	local power = FightingPowerFormula.instance:getTeamFightingPower(team, heroSkill, fid, flvl, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId)

	return power, speed
end

function FormationLeftViewBase:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, flvl
end

function FormationLeftViewBase:_SetPowerAndSpeed()
	local power, speed = self:_getPowerAndSpeed()

	self._power = power
	self._TxtC_Power.text = power
	self._TxtC_Speed.text = speed

	MissionModel.instance:setLeftPower(power)
	MissionModel.instance:setLeftSpeed(speed)
	GlobalDispatcher:dispatch(GlobalNotify.FormationSpeedUpdate)

	if self._isPrevLeftFirst == nil then
		self._isPrevLeftFirst = MissionModel.instance:isLeftFirst()
	else
		local isLeftFirst = MissionModel.instance:isLeftFirst()

		if self._isPrevLeftFirst ~= isLeftFirst then
			self._isPrevLeftFirst = isLeftFirst
		end
	end
end

function FormationLeftViewBase:_RefeshSeats(pos, newPetId, isFilterAll)
	self:dealWithLimitPetPos()

	local toId = self:_getHeroSkillId()
	local skills = self:_getPetsHeroSkills()

	if TableUtil.isHad(skills, toId) then
		-- block empty
	else
		toId = table.getn(skills) > 0 and skills[1] or 0
	end

	self:_changeHeroSkillId(toId)

	local positions = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(positions) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])
		local petMo

		itemSeat:SetSeatInfo(i, (petId > 0 or nil) and self:_getPet(petId), self:_getCurElementMap())
		itemSeat:SetSelect(false)
		itemSeat:SetRestrain("", false)
	end

	self:_SetHeroSkill(toId)
	self:_updateStartOrder()
	self:_updateBtnFormEidtName()
end

function FormationLeftViewBase:_updateBtnFormEidtName()
	if self._txtFormationEdit and self._txtFormationUse then
		self._txtFormationEdit.text = "编辑预设"
		self._txtFormationUse.text = "使用预设"

		local formationMO = self:_getCurFormation()
		local tabInfo = FormationGroupModel.instance:getMatchTabIdByFmo(formationMO)

		if tabInfo then
			local tabName = FormationGroupController.instance:getTabName(tabInfo)

			self._txtFormationUse.text = tabName
			self._txtFormationEdit.text = tabName
		end

		local modifyTabId = FormationGroupModel.instance.curTabId
		local tabInfo = FormationGroupModel.instance:getTabInfo(modifyTabId)

		if tabInfo then
			self._txtFormationEdit.text = FormationGroupController.instance:getTabName(tabInfo)
		end
	end
end

function FormationLeftViewBase:_SetSeatHightLight(isOpen, visible)
	return
end

function FormationLeftViewBase:_setSeatHightLightIdx(idx, visible)
	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(self._seats[idx])

	itemSeat:SetSelect(visible)
end

function FormationLeftViewBase:_setRestrainTxt(idx, txt, visible)
	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(self._seats[idx])

	if itemSeat then
		itemSeat:SetRestrain(txt, visible)
	else
		printInfo("idx:=============" .. idx)
	end
end

function FormationLeftViewBase:_isExceedSpecifiedNumber()
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local specificNumber = MissionModel.instance:getMaxPetNum()

	return specificNumber <= curPetNumber
end

function FormationLeftViewBase:_isExistBorrowPet()
	return self:_getCurFormation():checkHasBorrowPet()
end

function FormationLeftViewBase:_showFailedSummonMasterTips()
	FloatWordMgr.instance:show(lang("不能替换自己的召唤师下阵哦！"))
end

function FormationLeftViewBase:_showFailedSummonPetTips()
	FloatWordMgr.instance:show(lang("只能同时上阵一只契约精灵哦！"))
end

function FormationLeftViewBase:_showFailedYuanTips()
	local content = lang("阵上源属性精灵已达上限，只能替换源属性精灵")

	FloatWordMgr.instance:show(content)
end

function FormationLeftViewBase:_showFailedTips()
	local content = langPara("不包含契约精灵，最多上阵%d只精灵哦！", MissionModel.instance:getMaxPetNum())

	FloatWordMgr.instance:show(content)
end

function FormationLeftViewBase:_showBorrowPetFailedTips()
	FloatWordMgr.instance:show(lang("只能同时上阵一只助战精灵哦！"))
end

function FormationLeftViewBase:_showSetSummonPetTips()
	TipsFacade.instance:openCommonTips(lang("切换召唤师成功，尝试上阵对应的契约精灵"))
end

function FormationLeftViewBase:_OnDropSeat(go, eventData)
	local ItemSeatCls = self:_getItemSeatCls()
	local curItemSeat = ItemSeatCls.Get(go)

	if not curItemSeat then
		return
	end

	local targetPetId = curItemSeat:GetData()
	local targetPetMo = self:_getPet(targetPetId)
	local pos = curItemSeat:GetPosition()
	local itemPet = ItemPet.Get(eventData.pointerDrag)
	local draggingPetMo

	if itemPet then
		draggingPetMo = itemPet:GetData()
	end

	local curFormationMo = self:_getCurFormation()
	local hasSameRaceIdUp = curFormationMo:getHasSameRaceIdUp(draggingPetMo)

	if hasSameRaceIdUp and draggingPetMo and (targetPetMo == nil or draggingPetMo.raceId ~= targetPetMo.raceId) then
		TipsFacade.instance:openCommonTips("只能替换相同的精灵哦")

		return
	end

	if self:_isFixedPos(pos) then
		GlobalDispatcher:dispatch(GlobalNotify.FormationEndDragSeatBlockByFixPos, (draggingPetMo or nil) and draggingPetMo.petId, pos)

		return
	end

	self:_setSelectEffectState(false)

	if not self._dragSeat and not self._RightView._dragging then
		return
	end

	local itemSeat = ItemSeatCls.Get(eventData.pointerDrag)

	if itemSeat and curItemSeat:IsOpen() ~= itemSeat:IsOpen() or not itemSeat and curItemSeat:GetData() == -1 then
		return
	end

	local newPetId = draggingPetMo and draggingPetMo.petId

	if self._RightView._dragging and self:_isPetUnableToLeve(targetPetId, newPetId) then
		return
	end

	local petId

	if itemPet then
		local data = itemPet:GetData()

		petId = data.petId
	elseif itemSeat then
		petId = itemSeat:GetData()
	end

	if not petId then
		return
	end

	local canUpState = curFormationMo:preDealDragMasterPosAndSetSummonPet(pos, petId, self:_isExceedSpecifiedNumber())

	if canUpState ~= 0 then
		if canUpState == FormationMO.STATE_CAN_NOT_UP_YUAN then
			self:_showFailedYuanTips()
		else
			self:_showFailedTips()
		end

		return
	end

	if not itemSeat and self:_isExistBorrowPet() and draggingPetMo and draggingPetMo:isBorrowPet() and (not itemPet or not itemPet:isInTeam()) and (not curItemSeat:isHasPet() or targetPetMo and not targetPetMo:isBorrowPet()) then
		self:_showBorrowPetFailedTips()

		return
	end

	local petId

	AudioPlayerEx.instance:playEffect(30008)

	if itemPet then
		local data = itemPet:GetData()

		if data.forbit then
			return
		end

		petId = data.petId

		local isExist, rightPos = self:_isExistPetId(data.petId)

		if isExist and self:_isFixedPos(rightPos) then
			return
		end

		self._RightView:_OnDropSeat()
	elseif itemSeat then
		local itemPos = itemSeat:GetPosition()

		if self:_isFixedPos(itemPos) then
			return
		end

		petId = itemSeat:GetData()
		self._dragSeat = nil

		local endPetId = curItemSeat:GetData()
		local initPos = itemSeat:GetPosition()

		if endPetId and endPetId > 0 and not self:_isPosValidatorMatchOnSelect(initPos, endPetId) then
			itemSeat:ShowPet()
			itemSeat:recoverPetShow()
			itemSeat:recoverRaceType()
			curItemSeat:ShowPet()
			curItemSeat:recoverPetShow()
			curItemSeat:recoverRaceType()
			self:_playAudio(petId)

			return
		end
	end

	if not petId then
		return
	end

	local pos = curItemSeat:GetPosition()

	if not self:_isPosValidatorMatchOnSelect(pos, petId) then
		if itemSeat then
			itemSeat:ShowPet()
			itemSeat:recoverPetShow()
			itemSeat:recoverRaceType()
		end

		local endPetId = curItemSeat:GetData()

		if endPetId and endPetId > 0 then
			curItemSeat:ShowPet()
			curItemSeat:recoverPetShow()
			curItemSeat:recoverRaceType()
		end

		return
	end

	self:_onRealChangePosition(pos, petId, curItemSeat)
end

function FormationLeftViewBase:_onRealChangePosition(pos, petId, curItemSeat)
	curItemSeat:playDropEffect(self)

	if not self:_isInTeam(petId) then
		self:_playAudio(petId)
	end

	self:_changePosition(pos, petId)
end

function FormationLeftViewBase:_OnDropBg(go, eventData)
	if self._dragSeat then
		local petId = self._dragSeat:GetData()

		if self._dragSeat:IsOpen() and petId > 0 then
			local pos = self._dragSeat:GetPosition()

			if self:_isFixedPos(pos) then
				return
			end

			if self:_isPetUnableToLeve(petId) then
				return
			end

			self:_changePosition(pos, 0)

			self._dragSeat = nil
		end
	end
end

function FormationLeftViewBase:_OnBeginDragSeat(go, eventData)
	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat then
		return
	end

	self._dragingGo = go

	local pos = itemSeat:GetPosition()

	if self:_isFixedPos(pos) then
		return
	end

	self:_SetSeatHightLight(itemSeat:IsOpen(), true)

	local petId = itemSeat:GetData()

	if petId <= 0 then
		return
	end

	local pet = self:_getPet(petId)

	if pet == nil then
		return
	end

	self._ImgC_Drop.gameObject:SetActive(true)
	self:_setSelectEffectState(true, itemSeat:getWorldPosition(), itemSeat:GetPosition())
	self:_setCharactorColor()

	self._isDraging = true
	self._Character = goutil.cloneAndSetParent(self._Nego_Character, self._Nego_Character.transform.parent)

	self._Character:SetActive(true)

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()
	self._loader, self._lastCallBack, self._asset = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._asset)
	self._loader, self._lastCallBack = RoleObjectPool.instance:getRoleAsset(pet.curFaceId, function(go)
		self._asset = go

		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					go:SetActive(true)
					goutil.addChildToParent(go, goutil.findChild(self._Character, "petContainer"))
					Framework.TransformUtil.SetLocalPos(go.transform, modelCfg[1], y, 0)
					Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)
				end
			end
		end
	end, false)

	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	itemSeat:HidePet()

	self._dragSeat = itemSeat

	self:_activeCharacterEffect(true)
	GlobalDispatcher:dispatch(GlobalNotify.FormationBeginDragSeat, pet, itemSeat:GetPosition())
end

function FormationLeftViewBase:_OnEndDragSeat(go, eventData)
	if self._isDraging or self._RightView._dragging then
		self._isDraging = false
		go = go or self._dragingGo

		self._ImgC_Drop.gameObject:SetActive(false)

		local ItemSeatCls = self:_getItemSeatCls()

		if go then
			local itemSeat = ItemSeatCls.Get(go)

			if not itemSeat then
				return
			end

			local pos = itemSeat:GetPosition()

			if self:_isFixedPos(pos) then
				return
			end

			self:_SetSeatHightLight(itemSeat:IsOpen(), false)
		end

		self:_resetCharactorColor()
		self:_resetPetShow()
		self:_setSelectEffectState(false)
		self:_activeCharacterEffect(false)

		if not self._Character then
			return
		end

		self._loader, self._lastCallBack, self._asset = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._asset)

		goutil.destroy(self._Character, true)

		self._Character = nil
		self._dragingGo = nil

		if self._dragSeat then
			self._dragSeat:ShowPet()

			self._dragSeat = nil
		end

		GlobalDispatcher:dispatch(GlobalNotify.FormationDropFromSeat)
		GlobalDispatcher:dispatch(GlobalNotify.FormationEndDragSeat)
	end
end

function FormationLeftViewBase:_OnDragSeat(go, eventData)
	if not self._Character then
		return
	end

	local pos = uGuiUtil.GetTouchWorldPosition()

	self._Character.transform.position = pos

	self:_setCharacterEffectPos(pos)
end

function FormationLeftViewBase:_petClicked()
	self._selectedPetId = nil

	local positions = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(positions) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		itemSeat:SetSelect(false)
	end
end

function FormationLeftViewBase:_onSetFormationTabSuccess()
	local formationId = self:_getCurFormId()

	self:_SetFormationNameAndIcon(formationId)
end

function FormationLeftViewBase:_OnClickSeat(go, eventData)
	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		printInfo("当前位置没有精灵")

		return
	end

	local petId = itemSeat:GetData()
	local petMo = self:_getPet(petId)

	if petMo then
		self:_onClickShowPetTips(petMo)
	end
end

function FormationLeftViewBase:_onClickShowPetTips(petMo)
	CommonTipsMgr.instance:showPetTips(petMo)
end

function FormationLeftViewBase:_onEnterSeat(go, eventData)
	if self._isDraging then
		if not eventData.pointerDrag then
			return
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local endPos = endSeat:GetPosition()

		if self:_isFixedPos(endPos) then
			return
		end

		local itemStartSeat = ItemSeatCls.Get(eventData.pointerDrag)

		if not itemStartSeat then
			return
		end

		local itemStartPos = itemStartSeat:GetPosition()

		if self:_isFixedPos(itemStartPos) then
			return
		end

		if itemStartSeat and itemStartSeat:isHasPet() then
			self:_setSelectEffectState(true, endSeat:getWorldPosition(), endSeat:GetPosition())
		else
			return
		end

		self:_previewOnEnterSeatByDragSeat(itemStartSeat, endSeat)
	elseif self._RightView._dragging then
		local dragingGo = self._RightView._dragingGo

		if not dragingGo then
			return
		end

		local itemPet = ItemPet.Get(dragingGo)

		if itemPet then
			local data = itemPet:GetData()

			if data == nil or data.forbit then
				return
			end

			local isExist, rightPos = self:_isExistPetId(data.petId)

			if isExist and self:_isFixedPos(rightPos) then
				return
			end
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local pos = endSeat:GetPosition()

		if self:_isFixedPos(pos) then
			return
		end

		self:_setSelectEffectState(true, endSeat:getWorldPosition(), endSeat:GetPosition())

		if itemPet then
			self:_previewOnEnterSeatByRightView(itemPet, endSeat)
		end
	end
end

function FormationLeftViewBase:_getItemSeatByPetId(petId)
	if not self._seats then
		return nil
	end

	for i = 1, #self._seats do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.Get(self._seats[i])

		if itemSeat:GetData() == petId then
			return itemSeat
		end
	end

	return nil
end

function FormationLeftViewBase:_onExitSeat(go, eventData)
	if self._isDraging then
		if not eventData.pointerDrag then
			return
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local endPos = endSeat:GetPosition()

		if self:_isFixedPos(endPos) then
			return
		end

		self:_setSelectEffectState(false)

		local itemStartSeat = ItemSeatCls.Get(eventData.pointerDrag)

		if not itemStartSeat then
			return
		end

		local itemStartPos = itemStartSeat:GetPosition()

		if self:_isFixedPos(itemStartPos) then
			return
		end

		self:_previewOnExitSeatByDragSeat(itemStartSeat, endSeat)
	elseif self._RightView._dragging then
		local dragingGo = self._RightView._dragingGo

		if not dragingGo then
			return
		end

		local itemPet = ItemPet.Get(dragingGo)

		if itemPet then
			local data = itemPet:GetData()

			if data == nil or data.forbit then
				return
			end

			local isExist, rightPos = self:_isExistPetId(data.petId)

			if isExist and self:_isFixedPos(rightPos) then
				return
			end
		end

		local ItemSeatCls = self:_getItemSeatCls()
		local endSeat = ItemSeatCls.Get(go)

		if not endSeat then
			return
		end

		local pos = endSeat:GetPosition()

		if self:_isFixedPos(pos) then
			return
		end

		if itemPet then
			self:_previewOnExitSeatByRightView(itemPet, endSeat)
		end

		self:_setSelectEffectState(false)
	end
end

function FormationLeftViewBase:_previewOnEnterSeatByDragSeat(itemStartSeat, endSeat)
	if endSeat:isHasPet() then
		local startPetId = itemStartSeat:GetData()
		local endPetId = endSeat:GetData()

		if startPetId ~= endPetId then
			itemStartSeat:ShowPet()
			itemStartSeat:previewPetShow(endSeat:getPetMo())
			itemStartSeat:setTempPetId(endPetId)
			endSeat:setRaceType(itemStartSeat:getPetMo(), self:_getCurElementMap())
			endSeat:HidePet()
		end
	else
		itemStartSeat:setTempPetId(0)
	end

	local tempPetId = itemStartSeat:GetData()

	endSeat:setTempPetId(tempPetId)
	GlobalDispatcher:dispatch(GlobalNotify.FormationEnterSeat, tempPetId, endSeat:GetPosition())
end

function FormationLeftViewBase:_previewOnExitSeatByDragSeat(itemStartSeat, endSeat)
	endSeat:recoverPetShow()
	endSeat:setCharactorColor()
	endSeat:resetTempPetId()
	itemStartSeat:recoverRaceType()
	itemStartSeat:resetTempPetId()
	itemStartSeat:HidePet()
	GlobalDispatcher:dispatch(GlobalNotify.FormationExitSeat, itemStartSeat:GetData(), endSeat:GetPosition())
end

function FormationLeftViewBase:_previewOnEnterSeatByRightView(itemPet, endSeat)
	local data = itemPet:GetData()
	local petId = data.petId
	local itemStartSeat = self:_getItemSeatByPetId(petId)

	if itemStartSeat then
		self:_previewOnEnterSeatByDragSeat(itemStartSeat, endSeat)
	end
end

function FormationLeftViewBase:_previewOnExitSeatByRightView(itemPet, endSeat)
	local data = itemPet:GetData()
	local petId = data.petId
	local itemStartSeat = self:_getItemSeatByPetId(petId)

	if itemStartSeat then
		self:_previewOnExitSeatByDragSeat(itemStartSeat, endSeat)
	end
end

function FormationLeftViewBase:_OnMenuCloseHeroskill()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._OnMenuClickHeroskill, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseHeroskill, self)
end

function FormationLeftViewBase:_OnMenuClickHeroskill(value)
	self:_SetHeroSkill(value)
	self:_SetPowerAndSpeed()
end

function FormationLeftViewBase:_OnClickCutePet()
	local formationMo = self:_getCurFormation()
	local cutePetId = formationMo:GetCutePetId()

	UIStateManager.instance:push(ViewName.CutepetassistanceselectView, cutePetId, GameUtil.handler(self._onSelectCutePet, self))
end

function FormationLeftViewBase:_onSelectCutePet(cutePetId)
	local cutePetMo = MaterialMgr.getModel(MatType.CutePet, cutePetId)

	if self:_getCurFormation() then
		self:_getCurFormation():SetCutePetMo(cutePetMo)
	end

	self:_RefreshViewOnHeroSkillChanged()
end

function FormationLeftViewBase:_OnClickBtnHeroSkill()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchHeroSkill)

	local skills = self:_getPetsHeroSkills()
	local curBonds, petIdList = self:_getCurBonds(true)
	local petMoMap = self:_getBagPetMoList(petIdList)
	local team, formation, speed = self:getTeamAndFormation()

	if table.getn(skills) == 0 then
		ViewMgr.instance:open(ViewName.FmtFeatureView, skills, nil, curBonds, petMoMap, formation)

		return nil
	else
		ViewMgr.instance:open(ViewName.FmtFeatureView, skills, self:_getHeroSkillId(), curBonds, petMoMap, formation)

		return nil
	end
end

function FormationLeftViewBase:_onClickPsychicSkill()
	local currSkillId = self:_getPsychicedSkillId()

	currSkillId = self:_checkPsychicedSkill(currSkillId)

	if currSkillId == 0 then
		FloatWordMgr.instance:show(lang("阵上没有通灵师"))

		return
	end

	local pets = self:_getPetsPsychics()

	ViewMgr.instance:open(ViewName.MissionPsychicsedSkills, currSkillId, pets)
end

function FormationLeftViewBase:_onClickSpiritInvocationSkill()
	local currPetId = self:_getSpiritInvocationPetId()

	currPetId = self:_checkSpiritInvocationSkill(currPetId)

	if currPetId == 0 then
		FloatWordMgr.instance:show(lang("阵上没有唤灵师"))

		return
	end

	local pets = self:_getPetsSpiritInvocation()

	ViewMgr.instance:open(ViewName.MissionSpiritInvocationSkillView, currPetId, pets)
end

function FormationLeftViewBase:_getBagPetMoList(petIdList)
	local list = {}

	for i, v in ipairs(petIdList) do
		local petMo = self:_getPet(v)

		if petMo then
			local raceId = petMo:getDefineId()

			list[raceId] = petMo
		else
			printError(">>>>>>>>>>>>> error 是否没重写  _getPet 方法 找不到 petId:", v, " 注意重写 FormationLeftViewBase:getIsBoundUseBagPet() ")
		end
	end

	return list
end

function FormationLeftViewBase:_onClickElementSkill()
	local hasMaster = false
	local positions = self:_getCurPositions()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if enableDebug and petMo == nil then
				printError("精灵信息为空, FormationLeftViewBase:_onClickElementSkill petMo = nil", v)
			end

			if petMo and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Element) then
				hasMaster = true

				break
			end
		end
	end

	if hasMaster then
		UIStateManager.instance:push(ViewName.ElementpopView, self:_getCurFormation())
	else
		FloatWordMgr.instance:show(lang("阵上没有元素师"))
	end
end

function FormationLeftViewBase:_onClickBtnHeavenAwakenSummon()
	local hasMaster = false
	local isMyMaster = false
	local positions = self:_getCurPositions()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if enableDebug and petMo == nil then
				printError("精灵信息为空, FormationLeftViewBase:_onClickBtnHeavenAwakenSummon petMo = nil", v)
			end

			if petMo and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Tianjue) then
				hasMaster = true

				if petMo.isMyPackPet then
					isMyMaster = true
				end

				break
			end
		end
	end

	if hasMaster then
		if not isMyMaster then
			FloatWordMgr.instance:show("助战天觉者无需设置契约精灵")

			return
		end

		local bagPetMos = self:_getRightAllShowPetsForTianjue()

		UIStateManager.instance:push(ViewName.HeavenAwakenSummonPopView, self:_getCurFormation(), bagPetMos)
	else
		FloatWordMgr.instance:show(lang("阵上没有天觉者"))
	end
end

function FormationLeftViewBase:_getCurElementMap()
	return self:_getCurFormation():getCurElementRelationMap()
end

function FormationLeftViewBase:_OnClickBtnContractPet()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchSummonerOrSummonMonster)

	local masterMoList, cusMasterMo = self:getSummonMasterPets()

	if masterMoList and #masterMoList > 0 then
		local formationMo = self:_getCurFormation()

		formationMo:trySaveMySelf()

		local list = self:getSummonPetList()

		UIStateManager.instance:push(ViewName.CustomSummonPopSelectView, masterMoList, list, cusMasterMo, self:getSummonPetLimitLvl(), formationMo:GetSummonPetId(), self:_getFixedPetsForContract())
	else
		FloatWordMgr.instance:show(lang("阵上没有符合条件的召唤师~"))
	end
end

function FormationLeftViewBase:getSummonPetList()
	return (BagPetsController.instance:getFightBagPet())
end

function FormationLeftViewBase:getSummonPetLimitLvl()
	return (checknumber(ContractConfig.instance:getConstValueByKey("SUMMONED_PET_MIN_LVL")))
end

function FormationLeftViewBase:getSummonMasterPets()
	local masterMoList = {}
	local cusMasterMo
	local formationMo = self:_getCurFormation()
	local positions = self:_getCurPositions()
	local limitLv = self:getSummonPetLimitLvl()
	local masterId = formationMo:GetSummonMasterPetId()

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			if petMo then
				if petMo.petId == masterId then
					cusMasterMo = petMo
				end

				if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) and limitLv <= petMo.level then
					table.insert(masterMoList, petMo)
				end
			end
		end
	end

	return masterMoList, cusMasterMo
end

function FormationLeftViewBase:checkHasSummonMasterPets()
	local positions = self:_getCurPositions()
	local limitLv = checknumber(ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL"))
	local hasMaster = false

	for i, v in ipairs(positions) do
		if v > 0 then
			local petMo = self:_getPet(v)

			hasMaster = petMo and limitLv <= petMo.level and PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Zhaohuanshi) and petMo.isMyPackPet and true or hasMaster
		end
	end

	if hasMaster == false then
		FloatWordMgr.instance:show(lang("阵上没有符合条件的召唤师"))
	end

	return hasMaster
end

function FormationLeftViewBase:trySetSummonPetByMasterId(_curSummonerId, summonedPetId)
	MissionModel.instance:setForceResetOneKey(true)

	local fmo = self:_getCurFormation()

	fmo:trySetSummonPetByMasterId(_curSummonerId, summonedPetId, MissionModel.instance:getMaxPetNum())

	local petMo = fmo:_getPet(summonedPetId)
	local canNotUpYuan = fmo:checkYuanLimit(petMo)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))
	end

	if not fmo:checkAllBorrowPet(_curSummonerId, summonedPetId) then
		-- block empty
	else
		self:_showBorrowPetFailedTips()
	end

	self:onSummonPosSetdown()
	GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	self:onAllPetSetFinish()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChangeFinish)
end

function FormationLeftViewBase:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local isUseMax = self:isUseMaxStreng()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, not isUseMax, isUseMax)
end

function FormationLeftViewBase:isUseMaxStreng()
	return false
end

function FormationLeftViewBase:_onGroupTabModify(modifyTabId)
	local tabInfo = FormationGroupModel.instance:getTabInfo(modifyTabId)

	if tabInfo then
		self:_beforeUseFormationMo()

		local formationMo = self:_getCurFormation()
		local summonMasterId = checknumber(formationMo:GetSummonMasterPetId())
		local summonedPetId = checknumber(formationMo:GetSummonPetId())
		local pos = clone(formationMo:GetPositions() or {})
		local simpleForm = tabInfo.simpleForm

		formationMo:SetData(simpleForm)

		local isLockMaster = false
		local isLockSummon = false
		local fixPos = {}
		local hasFixPet = false

		for i = 1, 9 do
			local petId = checknumber(pos[i])

			if self:_isFixedPos(i) or self:_isPetUnableToLeve(petId) then
				fixPos[i] = true
				hasFixPet = true

				formationMo:SetPosition(i, petId, true)

				if petId == summonedPetId then
					isLockSummon = true
				end

				if petId == summonMasterId then
					isLockMaster = true
				end
			end
		end

		if isLockMaster and isLockMaster then
			formationMo.summonMasterPetId = summonMasterId
			formationMo.summonedPetId = summonedPetId
		else
			summonMasterId = checknumber(formationMo:GetSummonMasterPetId())
			summonedPetId = checknumber(formationMo:GetSummonPetId())
		end

		local maxPetNum = MissionModel.instance:getMaxPetNum()
		local count = formationMo:getCurExistPetNumber()
		local needDeletePetCount = count - maxPetNum

		for i = 1, 9 do
			if needDeletePetCount <= 0 then
				break
			end

			local checkPetId = formationMo:GetPosition(i)

			if checkPetId > 0 and not fixPos[i] and checkPetId ~= summonMasterId and checkPetId ~= summonedPetId then
				formationMo:SetPosition(i, 0, true)

				needDeletePetCount = needDeletePetCount - 1
			end
		end

		if hasFixPet then
			TipsFacade.instance:openCommonTips("固定位置的精灵不能替换上阵")
		end

		self:_RefreshView(nil, nil, true)
	end
end

function FormationLeftViewBase:_OnTeamChanged()
	self:_beforeUseFormationMo()
	self:_RefreshView(nil, nil, true)
end

function FormationLeftViewBase:_OnFormationChanged()
	self:_RefreshView()
end

function FormationLeftViewBase:_OnSeatValueChanged(pos, petId)
	self:_RefreshView(pos, petId)
	self:_showNewActBonds()
end

function FormationLeftViewBase:_OnHeroSkillChanged(id)
	self:_RefreshViewOnHeroSkillChanged(id)
	FormationController.instance:setRaceChange()
end

function FormationLeftViewBase:_onBagBeginDrag(bagPetMo)
	self:_hideDragPet(bagPetMo)
	self:_setCharactorColor()

	if bagPetMo then
		local fmo = self:_getCurFormation()

		if fmo and fmo:checkYuanLimit(bagPetMo) and self._seats then
			for i = 1, #self._seats do
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.Get(self._seats[i])

				if itemSeat and itemSeat:isHasPet() then
					local petId = itemSeat:GetData()
					local petMo = self:_getPet(petId)

					if petMo and PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, GameEnum.RaceType.Yuan) then
						itemSeat:playYuanLimitEffect(self)
					end
				end
			end
		end
	end
end

function FormationLeftViewBase:_onBagEndDrag()
	self:_resetPetShow()
	self:_resetCharactorColor()
	self:_activeCharacterEffect(false)

	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:removeYuanLimitEffect()
			end
		end
	end
end

function FormationLeftViewBase:_hideDragPet(bagPetMo)
	if bagPetMo then
		local petId = bagPetMo:getId()
		local itemSeat = self:_getItemSeatByPetId(petId)

		if itemSeat then
			itemSeat:HidePet()
		end
	end
end

function FormationLeftViewBase:_updateStartOrder()
	local formationView = self._viewPresentor:getViewByName("FormationView")
	local isFormationView = not not formationView
	local enemyPoses = {}
	local isLeftFirst = true

	if not isFormationView then
		isLeftFirst = MissionModel.instance:isLeftFirst()
		enemyPoses = MissionModel.instance:getEnemyPetPoses()

		local arenaFormationLeftView = self._viewPresentor:getViewByName("ArenaFormationLeftView")
		local arenaMissionView = self._viewPresentor:getViewByName("ArenaMissionView")

		if #enemyPoses == 0 and not arenaMissionView and not arenaFormationLeftView then
			return
		end
	end

	local selfPoses = {}
	local fmtPoses = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(fmtPoses) do
		if petId > 0 then
			table.insert(selfPoses, i)
		end
	end

	self:_doUpdateStartOrder(isLeftFirst, selfPoses, enemyPoses)
end

function FormationLeftViewBase:_doUpdateStartOrder(isLeftFirst, selfPoses, enemyPoses)
	local leftCount = #selfPoses
	local rightCount = #enemyPoses
	local startOrderIndex = 1

	ArraySort.sortOn(enemyPoses)

	local rightList = {}
	local totalCount = rightCount <= leftCount and leftCount or rightCount

	if isLeftFirst then
		for i = 1, totalCount do
			if i <= leftCount then
				self._startOrderTxts[selfPoses[i]].text = string.format("%d手", startOrderIndex)
				startOrderIndex = startOrderIndex + 1
			end

			if i <= rightCount then
				local txt = string.format("%d手", startOrderIndex)
				local param = {
					pos = enemyPoses[i],
					text = txt
				}

				table.insert(rightList, param)

				startOrderIndex = startOrderIndex + 1
			end
		end
	else
		for i = 1, totalCount do
			if i <= rightCount then
				local txt = string.format("%d手", startOrderIndex)
				local param = {
					pos = enemyPoses[i],
					text = txt
				}

				table.insert(rightList, param)

				startOrderIndex = startOrderIndex + 1
			end

			if i <= leftCount then
				self._startOrderTxts[selfPoses[i]].text = string.format("%d手", startOrderIndex)
				startOrderIndex = startOrderIndex + 1
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateStartOrder, rightList)
end

function FormationLeftViewBase:_filterFormationPosOnEnter(conditionId)
	self._conditionId = conditionId

	if conditionId then
		FormationValidatorController.instance:filterFormationPosOnEnter(conditionId, self:_getCurFormation())
	end

	self:_initItemSeatEffectActive(conditionId)
end

function FormationLeftViewBase:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	return true
end

function FormationLeftViewBase:_initItemSeatEffectActive(conditionId)
	local stateList = FormationValidatorController.instance:getNecessaryAndForbidPosList(conditionId)
	local fixedPos = {}
	local positions = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(positions) do
		local isNecessary = stateList[i]
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[i])

		if stateList[i] ~= nil then
			itemSeat:setEffectActive(true, isNecessary)

			if not isNecessary then
				table.insert(fixedPos, i)
			end
		else
			itemSeat:setEffectActive(false, false)
		end
	end
end

function FormationLeftViewBase:_loadCharacterEffect()
	local path = "fx_ui_jinglinggezi/fx_ui_jinglinggezi_gai.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._characterEffect.transform, 0, 0, true, false)

	effect:setParent(self._characterEffect.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)
	effect:setSortingOrder(195)

	effect.hideEffWhileNotOnTop = false
end

function FormationLeftViewBase:_activeCharacterEffect(isActive)
	self._characterEffect:SetActive(isActive)
end

function FormationLeftViewBase:_setCharacterEffectPos(pos)
	Framework.TransformUtil.SetPos(self._characterEffect.transform, pos.x, pos.y, pos.z)
end

function FormationLeftViewBase:_setActiveBtnFormation(isActive)
	goutil.setActive(self._Btn_Formation, false)
end

function FormationLeftViewBase:_setActiveBtnFormationEdit(isActive)
	GameUtil.SetActive(self._Btn_FormationEdit, isActive)
end

function FormationLeftViewBase:_setActiveBtnFormationUse(isActive)
	GameUtil.SetActive(self._Btn_FormationUse, isActive)
end

function FormationLeftViewBase:setBtnFormActive(flag)
	GameUtil.SetActive(self._Btn_BuffForm, flag)
end

function FormationLeftViewBase:setBtnContractActive(isActive)
	self._isCanShowContractBtn = isActive

	if not isActive then
		GameUtil.SetActive(self._Btn_ContractPet, isActive)
	end
end

function FormationLeftViewBase:setBtnCutePetActive(isActive)
	self._isUseCutePet = isActive

	GameUtil.SetActive(self._Btn_CutePet, isActive)
end

function FormationLeftViewBase:_playAudio(petId)
	if self._playingCVPetId and AudioVoicePlayer.instance:isPlayingCv() and self:_isInTeam(self._playingCVPetId) then
		self._readyToPlayingCvPetId = petId

		return
	end

	self:_doPlayAudio(petId)
end

function FormationLeftViewBase:_doPlayAudio(petId)
	removetimer(self._doPlayAudio, self)

	petId = petId or self._readyToPlayingCvPetId
	self._readyToPlayingCvPetId = nil
	self._playingCVPetId = nil

	local bagPetMo = self:_getPet(petId)

	if bagPetMo then
		self._playingCVPetId = petId

		PetCvController.instance:playPetCv(bagPetMo.curFaceId, GameEnum.PetCvType.Formation)
	end
end

function FormationLeftViewBase:_onCvPlayFinished()
	self._playingCVPetId = nil

	if self._readyToPlayingCvPetId and self:_isInTeam(self._readyToPlayingCvPetId) then
		settimer(1, self._doPlayAudio, self, false)
	end
end

function FormationLeftViewBase:_setCharactorColor()
	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:setCharactorColor()
			end
		end
	end
end

function FormationLeftViewBase:_resetCharactorColor()
	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:resetCharactorColor()
			end
		end
	end
end

function FormationLeftViewBase:_resetPetShow()
	if self._seats then
		for i = 1, #self._seats do
			local ItemSeatCls = self:_getItemSeatCls()
			local itemSeat = ItemSeatCls.Get(self._seats[i])

			if itemSeat then
				itemSeat:resetPetShow()
			end
		end
	end

	self:_setSelectEffectState(false)
end

function FormationLeftViewBase:_initFixedPos()
	MissionModel.instance:setFixedPos(nil)
end

function FormationLeftViewBase:_initFixedEffs()
	return
end

function FormationLeftViewBase:_setFixedPos(poses)
	MissionModel.instance:setFixedPos(poses)
end

function FormationLeftViewBase:_isFixedPos(posIndex)
	return MissionModel.instance:isFixedPos(posIndex)
end

function FormationLeftViewBase:_isExistPetId(petId)
	if petId <= 0 then
		return false, 0
	end

	local positions = self:_getCurFormation():GetPositions()

	for pos, id in ipairs(positions) do
		if petId == id then
			return true, pos
		end
	end

	return false, 0
end

function FormationLeftViewBase:getIsBoundUseBagPet()
	return true
end

function FormationLeftViewBase:_getCurBonds(isGetPetIdList)
	local racesInCurFormation = {}
	local positions = self:_getCurFormation():GetPositions()
	local petIdList = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo then
				local raceId = mo.raceId

				table.insert(racesInCurFormation, raceId)
				table.insert(petIdList, petId)
			end
		end
	end

	if isGetPetIdList then
		return CharacterConfig.instance:getMatchBondCfgOnForm(racesInCurFormation, petIdList, self:getIsBoundUseBagPet()), petIdList
	end

	return CharacterConfig.instance:getMatchBondCfgOnForm(racesInCurFormation, petIdList, self:getIsBoundUseBagPet())
end

function FormationLeftViewBase:_isShowNewActBonds(isShow)
	self._isShowActBonds = isShow
end

function FormationLeftViewBase:_showNewActBonds()
	self._delayPara = 0

	local curbonds, petList = self:_getCurBonds(true)
	local bonds = {}

	for _, v in pairs(curbonds) do
		if self._curBonds[v.raceId] == nil then
			local bond = {
				v.raceId,
				name = v.name
			}

			for k, temRacid in pairs(v.relativeRaceIds) do
				table.insert(bond, temRacid)
			end

			table.insert(bonds, bond)

			self._curBonds[v.raceId] = true
		end
	end

	if type(self._isShowActBonds) == "boolean" and not self._isShowActBonds then
		return
	end

	local petMoMap = self:_getBagPetMoList(petList)

	if PetRelationController.instance:getIsShowDetail() then
		for _, bond in ipairs(bonds) do
			local param = {
				bond = bond,
				petMoMap = petMoMap
			}

			PetRelationController.instance:showSimplePopup(param)
		end
	end
end

function FormationLeftViewBase:_setFixedEffs(effMap)
	self:_removeAllFixedEffs()

	if effMap then
		for pos = 1, 9 do
			local effPath = effMap[pos]

			if not string.nilorempty(effPath) then
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

				itemSeat:playFixedEffect(self, effPath)
			end
		end
	end
end

function FormationLeftViewBase:_removeAllFixedEffs()
	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeFixedEffect()
	end
end

function FormationLeftViewBase:_loadSelectEffect()
	self:_removeSelectEffect()

	local path = "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab"
	local effect = UIEffectManager.instance:playEffect(self, path, self._selectEffectGo.transform, 0, 0, true, false)

	effect:setParent(self._selectEffectGo.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	effect.hideEffWhileNotOnTop = false
	self._selectUIEffect = effect
end

function FormationLeftViewBase:_removeSelectEffect()
	if self._selectUIEffect then
		UIEffectManager.instance:stopEffect(self._selectUIEffect)

		self._selectUIEffect = nil
	end
end

function FormationLeftViewBase:_getPerspectiveScale(posIndex)
	local num = posIndex % 3

	return num == 1 and 0.9 or num == 2 and 1 or 1.1
end

function FormationLeftViewBase:_setSelectEffectState(isEnter, worldPosition, posIndex)
	if not self._selectEffectGo then
		return
	end

	self._selectEffectGo:SetActive(isEnter)

	if isEnter then
		if worldPosition then
			self._selectEffectGo.transform.position = worldPosition
		end

		if posIndex then
			local scale = self:_getPerspectiveScale(posIndex)

			Framework.TransformUtil.SetLocalScale(self._selectEffectGo.transform, scale, scale, scale)
		end
	end
end

function FormationLeftViewBase:_getFightingPowerFormulaTeams()
	local formation = self:_getCurFormation()
	local team = {}

	for _, v in ipairs(formation:GetPositions()) do
		if v > 0 then
			local pet = self:_getPet(v)

			if pet then
				local fightingPowerMo = pet:toFightingPowerPetMo()

				fightingPowerMo.petId = v

				table.insert(team, fightingPowerMo)
			end
		end
	end

	return team
end

function FormationLeftViewBase:_getHeroSkillBuffList(heroSkillId)
	local teams = self:_getFightingPowerFormulaTeams()
	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()
	local t = FightingPowerFormula.instance:getHeroSkillsWhichPetValid(heroSkillId, teams, self:_getCurElementMap(), masterId, summonId)
	local positions = self:_getCurFormation():GetPositions()
	local result = {}

	for pos, petId in ipairs(positions) do
		local element = {}

		element.pos = pos
		result[pos] = element

		if t ~= nil then
			for team, buffs in pairs(t) do
				if team.petId == petId then
					element.buffs = buffs

					break
				end
			end
		end
	end

	return result
end

function FormationLeftViewBase:_setHeroSkillEffect(heroSkillId)
	GuideController.instance:setViewVar("formationleftview_heroskill", heroSkillId)

	local buffList = self:_getHeroSkillBuffList(heroSkillId)

	for pos, buffElement in ipairs(buffList) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeHeroSkillEff()
		itemSeat:setHeroSkillEffect(self, buffElement.buffs, pos)
	end
end

function FormationLeftViewBase:_getFusionPosSkillDic()
	local team, formation = self:getTeamAndFormation()
	local fusionSkillIds, skillsFormulaIdList, bagPetMoLists = FightingPowerFormula.instance:getCombinationValidSkills(formation)

	if not fusionSkillIds or not skillsFormulaIdList or not bagPetMoLists or #fusionSkillIds ~= #bagPetMoLists or #fusionSkillIds <= 0 then
		return nil
	end

	local petIdAndSkillIdDic = {}

	for i, bagPetMoList in ipairs(bagPetMoLists) do
		local skillId = fusionSkillIds[i]
		local formulaId = skillsFormulaIdList[i]

		for k, bagPetMo in pairs(bagPetMoList) do
			local petId = bagPetMo:getPetId()

			petIdAndSkillIdDic[petId] = petIdAndSkillIdDic[petId] or {}
			petIdAndSkillIdDic[petId].skillIds = petIdAndSkillIdDic[petId].skillIds or {}
			petIdAndSkillIdDic[petId].formulaIds = petIdAndSkillIdDic[petId].formulaIds or {}

			table.insert(petIdAndSkillIdDic[petId].skillIds, skillId)
			table.insert(petIdAndSkillIdDic[petId].formulaIds, formulaId)
		end
	end

	local posAndSkillIdsDic
	local positions = self:_getCurFormation():GetPositions()

	for k, v in pairs(petIdAndSkillIdDic) do
		for pos, petId in ipairs(positions) do
			if k == petId then
				posAndSkillIdsDic = posAndSkillIdsDic or {}
				posAndSkillIdsDic[pos] = v

				break
			end
		end
	end

	return posAndSkillIdsDic
end

function FormationLeftViewBase:_setFusionSkillEffect()
	local posAndSkillIdsDic = self:_getFusionPosSkillDic()

	if not posAndSkillIdsDic then
		self:_removeAllFusionSkillEffect()

		return
	end

	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		if posAndSkillIdsDic[pos] then
			local skillIds = posAndSkillIdsDic[pos].skillIds
			local formulaIds = posAndSkillIdsDic[pos].formulaIds

			if skillIds and formulaIds and itemSeat:isHasPet() then
				itemSeat:playFusionSkillEffect(skillIds, formulaIds, self)
			else
				itemSeat:removeFusionSkillEffect()
			end
		else
			itemSeat:removeFusionSkillEffect()
		end
	end
end

function FormationLeftViewBase:_removeAllFusionSkillEffect()
	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeFusionSkillEffect()
	end
end

function FormationLeftViewBase:_heroSkillIdToRaceId(heroSkillId)
	if type(heroSkillId) == "number" then
		return heroSkillId % 100000
	else
		return 0
	end
end

function FormationLeftViewBase:_getContractId(groupId, summonPetMo)
	return summonPetMo.contractSkillId
end

function FormationLeftViewBase:_getContractSkillEffectPath(summonId, summonMasterId)
	local summonPetMo = self:_getPet(summonId)

	if summonPetMo then
		local contractId = self:_getContractId(0, summonPetMo)
		local cfgStrategy = ContractConfig.instance:getSkillStrategyBySkillId(contractId)

		if cfgStrategy then
			return cfgStrategy.effectPath
		end
	end

	return "common/buff/fx_buff_zhaohuanshou"
end

function FormationLeftViewBase:_setSummonContractSkillEffect()
	self:_removeSummonContractSkillEffect()

	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()

	if summonId > 0 then
		local effectPath = self:_getContractSkillEffectPath(summonId, masterId)

		if not string.nilorempty(effectPath) then
			local curPos = -1
			local poisitions = self:_getCurPositions()

			for i, v in ipairs(poisitions) do
				if v == summonId then
					curPos = i

					break
				end
			end

			if curPos > 0 then
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.AddOnce(self._seats[curPos])

				itemSeat:playContractSkillEffect(self, effectPath)
			end
		end
	end
end

function FormationLeftViewBase:_removeSummonContractSkillEffect()
	local ItemSeatCls = self:_getItemSeatCls()

	for pos = 1, 9 do
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])

		itemSeat:removeContractSkillEffect()
	end
end

function FormationLeftViewBase:_isSkipFirstHeroSkillEffect(isSkip)
	self._isSkipFirstHeroSkill = isSkip
end

function FormationLeftViewBase:_playEffectOnChangeHeroSkillId(oldHeroSkillId, newHeroSkillId)
	if self._isSkipFirstHeroSkill then
		self._isSkipFirstHeroSkill = nil

		return
	end

	if not newHeroSkillId then
		return
	end

	if newHeroSkillId == oldHeroSkillId then
		return
	end

	local buffList = self:_getHeroSkillBuffList(newHeroSkillId)

	for pos, buffElement in ipairs(buffList) do
		local ItemSeatCls = self:_getItemSeatCls()
		local itemSeat = ItemSeatCls.AddOnce(self._seats[pos])
		local isHaveBuff = buffElement.buffs

		itemSeat:playChangeHeroSkillEffect(self:_heroSkillIdToRaceId(newHeroSkillId), self, isHaveBuff, self:_getCurElementMap())
	end
end

function FormationLeftViewBase:_onUpdateSpecialPos(posCfg)
	if posCfg and posCfg.posList then
		local posList = posCfg.posList
		local positions = self:_getCurFormation():GetPositions()
		local isCanChange, lastPosSet = self:_autoFixPetPosition(positions, posList, true)

		if isCanChange then
			self:_setPositionForce(lastPosSet)

			local num = self:_getCurFormation():getCurExistPetNumber()
			local fitPetNum = 0

			for _, posId in ipairs(posList) do
				local petId = positions[posId]

				if petId > 0 then
					fitPetNum = fitPetNum + 1
				end
			end

			if fitPetNum ~= #posList or num ~= #posList then
				TipsFacade.instance:openCommonTips(langPara("站位已调整，精灵数量跟%s不匹配，阵法不生效", posCfg.name))
			else
				local allNoraml = true
				local positions = self:_getCurFormation():GetPositions()
				local summonedPetId = self:_getCurFormation():GetSummonPetId()

				for i, v in ipairs(posList) do
					local pid = positions[v]

					if pid > 0 and summonedPetId == pid then
						allNoraml = false

						break
					end
				end

				if allNoraml == false then
					TipsFacade.instance:openCommonTips(langPara("站位已调整，精灵站位跟%s不匹配，阵法不生效", posCfg.name))
				end
			end
		else
			TipsFacade.instance:openCommonTips(langPara("条件不匹配，无法按照%s调整站位", posCfg.name))
		end
	end
end

function FormationLeftViewBase:_autoFixPetPosition(positions, posList, changeSummonPet)
	local lastPosSet = {}

	for i = 1, 9 do
		lastPosSet[i] = 0
	end

	local extList = {}
	local extMap = {}
	local isCanChange = true

	for i, v in ipairs(positions) do
		if checknumber(v) > 0 and self:checkPetIsForbit(checknumber(v)) and not self:_isFixedPos(checknumber(i)) then
			positions[i] = 0
		end
	end

	local fmtMo = self:_getCurFormation()
	local masterId = fmtMo:GetSummonMasterPetId()
	local summonId = fmtMo:GetSummonPetId()
	local petMap = {}
	local list = {}

	for i, v in ipairs(posList) do
		local pid = checknumber(positions[v])

		if self:_isFixedPos(v) then
			if pid > 0 then
				lastPosSet[v] = pid
				petMap[pid] = v
			else
				table.insert(list, v)
			end
		elseif pid > 0 then
			if pid == summonId and changeSummonPet then
				if extMap[pid] == nil then
					extMap[pid] = true

					table.insert(extList, pid)
				end

				table.insert(list, v)
			else
				local isMatch = self:_isPosValidatorMatchOnSelect(i, pid, false)

				if isMatch then
					lastPosSet[v] = pid
					petMap[pid] = v
				else
					table.insert(list, v)
				end
			end
		else
			table.insert(list, v)
		end
	end

	local temp = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local pet = self:_getPet(petId)

			if petId == summonId and changeSummonPet then
				if self:_isFixedPos(i) then
					temp[i] = petId
					petMap[petId] = i
				elseif extMap[petId] == nil then
					extMap[petId] = true

					table.insert(extList, petId)
				end
			elseif lastPosSet[i] == 0 then
				if self:_isFixedPos(i) then
					temp[i] = petId
					petMap[petId] = i
				elseif #list > 0 then
					local isExt = true

					for idx, pos in ipairs(list) do
						local isMatch = self:_isPosValidatorMatchOnSelect(pos, petId, false)

						if isMatch then
							temp[pos] = petId
							petMap[petId] = pos

							table.remove(list, idx)

							isExt = false

							break
						end
					end

					if isExt and extMap[petId] == nil then
						extMap[petId] = true

						table.insert(extList, petId)
					end
				elseif extMap[petId] == nil then
					extMap[petId] = true

					table.insert(extList, petId)
				end
			end
		end
	end

	table.merge(lastPosSet, temp)

	local low = 0
	local high = 10
	local valueMap = {}

	ArraySort.sortOn(extList, function(pid)
		if valueMap[pid] then
			return valueMap[pid]
		else
			if pid == summonId then
				low = low + 1
				valueMap[pid] = low

				return low
			end

			high = high + 1
			valueMap[pid] = high

			return high
		end
	end)

	if isCanChange then
		while #extList > 0 do
			local pid = table.remove(extList)
			local mo = self:_getPet(pid)

			for i = 9, 1, -1 do
				if lastPosSet[i] == 0 and self:_isPosValidatorMatchOnSelect(i, pid, false) then
					if pid == summonId then
						if masterId > 0 and checknumber(petMap[masterId]) > 0 then
							lastPosSet[i] = pid
						end

						break
					end

					lastPosSet[i] = pid

					break
				end
			end

			if pid == masterId then
				local pos = checknumber(petMap[summonId])

				if pos > 0 then
					lastPosSet[pos] = pid
				end
			end
		end
	end

	return isCanChange, lastPosSet
end

function FormationLeftViewBase:checkPetIsForbit(petId)
	return false
end

function FormationLeftViewBase:_refreshBuffForm()
	local cfgs = BattleConfig.instance:getFormStrengthTriggerCfgs()
	local positions = self:_getCurPositions()
	local posDataList = {}
	local summonedPetId = self:_getCurFormation():GetSummonPetId()
	local compA = 0

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo == nil then
				printError(">>>>>>>>>  看看为什么没有：PetId = " .. petId .. "的精灵，是否忘记重写 FormationLeftViewBase:_getPet 方法 还是被觉醒消耗掉了")
			end

			if mo.petId ~= summonedPetId then
				table.insert(posDataList, i)

				compA = compA + math.pow(2, i)
			end
		end
	end

	local fsMap = self:getCurAllFormStrengthInfo()

	for k, v in pairs(fsMap or {}) do
		if v.formStrengthLv > 0 then
			local posCfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(v.formStrengthId)

			if posCfg then
				local posList = posCfg.posList

				if posList and #posList == #posDataList then
					local compB = 0

					for i = 1, #posList do
						local pp_b = posList[i]

						compB = compB + math.pow(2, pp_b)
					end

					if compA == compB then
						self:_onUpdateBuffFormById(v)

						return
					end
				end
			end
		end
	end

	self:_onUpdateBuffFormById(nil)
end

function FormationLeftViewBase:getCurAllFormStrengthInfo()
	return FormationNewModel.instance:getAllFormStrengthInfo()
end

function FormationLeftViewBase:checkBuffFormIsOpen()
	return FuncOpenModel.instance:getFuncIsOpen(96)
end

function FormationLeftViewBase:_onUpdateBuffFormById(info)
	local isOpen = self:checkBuffFormIsOpen()

	goutil.setActive(self._MarkLock_BuffForm, not isOpen)

	local formId
	local formLv = 0

	if isOpen then
		self:SetFormStrengthInfo(info)

		if info then
			formId = info.formStrengthId
			formLv = info.formStrengthLv
		end
	end

	self:_onSelectBuffForm(formId, formLv)

	if self._CurFormId ~= formId then
		self._CurFormId = checknumber(formId)

		self:_SetPowerAndSpeed()

		if checknumber(formId) > 0 and PetRelationController.instance:getIsShowDetail() then
			local param = {
				formInfo = info
			}

			PetRelationController.instance:showSimplePopup(param)
		end
	end
end

function FormationLeftViewBase:_onSelectBuffForm(formId, formLv)
	formLv = checknumber(formLv)
	formId = checknumber(formId)
	self._TxtC_BuffForm.text = lang("阵法")

	goutil.setActive(self._MarkNotActive_BuffForm, true)
	goutil.setActive(self._Icon_Go_BuffForm, false)

	if formId > 0 then
		goutil.setActive(self._MarkNotActive_BuffForm, false)

		local cfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(formId)

		if cfg then
			goutil.setActive(self._Icon_Go_BuffForm, true)
			self._Icon_BuffForm:SetState(cfg.formStrengthId - 1)

			self._TxtC_BuffForm.text = cfg.name
			self._Txt_Lv_BuffForm.text = "Lv." .. formLv
		end
	end
end

function FormationLeftViewBase:_showFormationActive()
	removetimer(self._playFormationAni, self)

	self._formationChangeFlag = true

	if self._formationChangeFlag then
		if self._delayPara ~= 0 then
			settimer(1.4 * self._delayPara, self._playFormationAni, self, false)

			self._delayPara = 0
		else
			self:_playFormationAni()
		end
	end
end

function FormationLeftViewBase:_playFormationAni()
	self._formationChangeFlag = false

	if self._CurFormId and self._CurFormId > 0 then
		local info = FormationNewModel.instance:getFormStrengthInfo(self._CurFormId)

		if info then
			UIStateManager.instance:open(ViewName.FomationactiveView, info)
		end
	end
end

function FormationLeftViewBase:getTeamAndFormation()
	local curForm = self:_getCurFormation()
	local team = {}
	local formations = {}
	local speed = 0

	for idx = 1, 9 do
		local v = checknumber(curForm:GetPosition(idx))

		if v > 0 then
			local pet = self:_getPet(v)

			if pet then
				table.insert(team, pet)

				formations[idx] = pet

				if curForm.summonedPetId ~= pet.petId then
					speed = speed + pet._speed
				end
			end
		end
	end

	return team, formations, speed
end

function FormationLeftViewBase:_getPetsHeroSkills()
	local pet_poisition = self:_getCurPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()

	return (FightingPowerFormula.instance:getHeroValidSkills(teams, self:_getCurElementMap(), masterId, summonId))
end

function FormationLeftViewBase:_getPetsPsychics()
	local psychicSkillFaceIds = {}
	local pet_poisition = self:_getCurPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if petCo.psychicSkillId ~= 0 then
					table.insert(psychicSkillFaceIds, pet)
				end
			end
		end
	end

	return psychicSkillFaceIds
end

function FormationLeftViewBase:_getPetsSpiritInvocation()
	local pet_poisition = self:_getCurPositions()
	local teams = {}

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				table.insert(teams, pet)
			end
		end
	end

	local spiritInvocationPets = {}

	if not teams or #teams == 0 then
		return spiritInvocationPets
	end

	for i = 1, #teams do
		local skinId = checknumber(teams[i].curFaceId)

		if skinId == 0 then
			skinId = teams[i].raceId
		end

		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)
		local spiritInvocationSkillId = petCo and checknumber(petCo.spiritInvocationSkillId) or 0

		if spiritInvocationSkillId > 0 then
			table.insert(spiritInvocationPets, teams[i])
		end
	end

	return spiritInvocationPets
end

function FormationLeftViewBase:_getPsychicsPetBySkillId(skillId)
	if checknumber(skillId) == 0 then
		return
	end

	local pet_poisition = self:_getCurPositions()

	for i, v in ipairs(pet_poisition) do
		if v > 0 then
			local pet = self:_getPet(checknumber(v))

			if pet then
				local petCo = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)

				if petCo.psychicSkillId == skillId then
					return pet
				end
			end
		end
	end
end

function FormationLeftViewBase:resetNum()
	return nil
end

function FormationLeftViewBase:dealWithLimitPetPos()
	local formationMo = self:_getCurFormation()

	if formationMo then
		formationMo:resetHasPet(self:resetNum())

		local summonPetId = formationMo:GetSummonPetId()
		local positions = formationMo:GetPositions()
		local posList = {}
		local list = {}
		local isSummpetCanPut = false

		for i = 1, 9 do
			local isMatch = self:_isPosValidatorMatchOnSelect(i, summonPetId, false)

			if not isMatch then
				table.insert(list, i)
			else
				isSummpetCanPut = true
			end

			if not self:_isFixedPos(i) then
				table.insert(posList, i)
			end
		end

		if not isSummpetCanPut then
			formationMo:_resetSummonPet()

			summonPetId = formationMo:GetSummonPetId()
		end

		local isCanChange, lastPosSet = self:_autoFixPetPosition(positions, posList)

		if isCanChange then
			formationMo:_setAllPositions(lastPosSet)
		else
			for i, pos in ipairs(list) do
				if positions[pos] > 0 and positions[pos] ~= summonPetId then
					positions[pos] = 0
				end
			end

			if summonPetId > 0 then
				local change = formationMo:setSummonPetAndSetPos(summonPetId, list)

				if change then
					TipsFacade.instance:openCommonTips(lang("当前阵容限制，触发了契约精灵位置自动调整"))
				end
			end
		end

		formationMo:resetHasPet(self:resetNum())
	end

	self:_filterFormationPosOnEnter(self._conditionId)
end

function FormationLeftViewBase:_getCurFormId()
	local team = FormationNewModel.instance:GetCurTeam()

	return (team:GetCurFormationId())
end

function FormationLeftViewBase:_getCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function FormationLeftViewBase:_getCurPositions()
	return self:_getCurFormation():GetPositions()
end

function FormationLeftViewBase:_setPositionForce(positions, forceDispatch)
	self:_getCurFormation():setPositionForce(positions, forceDispatch)
	self:onFmoSetDown()
end

function FormationLeftViewBase:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
	self:onFmoSetDown()
end

function FormationLeftViewBase:_getHeroSkillId()
	return self:_getCurFormation():GetHeroSkillId()
end

function FormationLeftViewBase:_getPsychicedSkillId()
	return self:_getCurFormation():GetPsychicedSkillId()
end

function FormationLeftViewBase:_getSpiritInvocationPetId()
	return self:_getCurFormation():GetSpiritInvocationPetId()
end

function FormationLeftViewBase:_changePsychicedSkillId(skillId)
	self:_getCurFormation():SetPsychicedSkillId(skillId)
	self:onFmoSetDown()
end

function FormationLeftViewBase:_changeSpiritInvocationPetId(petId)
	self:_getCurFormation():SetSpiritInvocationPetId(petId)
	self:onFmoSetDown()
end

function FormationLeftViewBase:_changeHeroSkillId(skillId)
	self:_getCurFormation():SetHeroSkillId(skillId)
	self:onFmoSetDown()
end

function FormationLeftViewBase:_getPet(id)
	return BagPetsController.instance:getPet(id)
end

function FormationLeftViewBase:_checkHasTeam(id)
	return FormationNewModel.instance:GetTeam(id) ~= nil
end

function FormationLeftViewBase:_getCurrTeamId()
	return FormationNewModel.instance:GetCurTeamId()
end

function FormationLeftViewBase:_changeTeamId(id)
	FormationController.instance:ChangeTeamId(id)
end

function FormationLeftViewBase:_isInTeam(petId)
	local formation = self:_getCurFormation()

	if formation then
		local pet_poisition = formation:GetPositions()

		for i, v in ipairs(pet_poisition) do
			if v > 0 and v == petId then
				return true
			end
		end
	end
end

function FormationLeftViewBase:_saveCurrFmt()
	FormationController.instance:SaveFormationEx()
end

function FormationLeftViewBase:SetFormStrengthInfo(info)
	self:_getCurFormation():SetFormStrengthInfo(info)
	self:onFmoSetDown()
end

function FormationLeftViewBase:onAllPetSetFinish()
	self:onFmoSetDown()
end

function FormationLeftViewBase:_beforeUseFormationMo()
	return
end

function FormationLeftViewBase:onSummonPosSetdown()
	return
end

function FormationLeftViewBase:onFmoSetDown()
	return
end

function FormationLeftViewBase:_getItemSeatCls()
	return ItemSeat
end

function FormationLeftViewBase:_OnForceDropSeat()
	self:_OnEndDragSeat()
end

function FormationLeftViewBase:_isPetUnableToLeve(oldPetId, newPetId)
	return false
end

function FormationLeftViewBase:_maxPetNum()
	return 5
end

function FormationLeftViewBase:_getRightAllShowPetsForTianjue()
	return self._RightView:getAllShowPetList()
end

function FormationLeftViewBase:_getTianjuePetIds()
	local petIds = {}
	local formationMo = self:_getCurFormation()

	for idx, v in ipairs(formationMo:GetPositions()) do
		local petMo = self:_getPet(v)

		if petMo then
			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)
			local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

			if firstJobIdx == GameEnum.CareerType.Tianjue or secondJobIdx == GameEnum.CareerType.Tianjue then
				table.insert(petIds, v)
			end
		end
	end

	return petIds
end

function FormationLeftViewBase:_getFixedPetsForContract()
	local list = {}

	for i = 1, 9 do
		if self:_isFixedPos(i) then
			local petId = self:_getCurFormation():GetPosition(i)

			if petId ~= 0 then
				local petMo = self:_getPet(petId)

				if petMo then
					table.insert(list, petMo)
				end
			end
		end
	end

	return list
end

return FormationLeftViewBase
