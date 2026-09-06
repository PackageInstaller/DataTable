-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutePetTravelTeamSelectView.lua

module("logic.extensions.cutepet.view.CutePetTravelTeamSelectView", package.seeall)

local CutePetTravelTeamSelectView = class("CutePetTravelTeamSelectView", ViewComponent)

CutePetTravelTeamSelectView.STATE_WAIT_SELECT = 1
CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT = 2

function CutePetTravelTeamSelectView:ctor()
	CutePetTravelTeamSelectView.super.ctor(self)
end

function CutePetTravelTeamSelectView:unbindEvents()
	CutePetTravelTeamSelectView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnAddLeft)
	GameUtil.rmClickHandler(self._btnAddRight)
	GameUtil.rmClickHandler(self._btnTravel)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSurprise)
	GameUtil.rmClickHandler(self._btnFillter)
end

function CutePetTravelTeamSelectView:bindEvents()
	CutePetTravelTeamSelectView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnAddLeft, self._onClickAddLeft, self)
	GameUtil.addClickHandler(self._btnAddRight, self._onClickAddRight, self)
	GameUtil.addClickHandler(self._btnTravel, self._onClickTravel, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSurprise, self._onClickSurprise, self)
	GameUtil.addClickHandler(self._btnFillter, self._onClickFillter, self)
end

function CutePetTravelTeamSelectView:buildUI()
	CutePetTravelTeamSelectView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("static/btnClose")
	self._btnTip = self:getBtn("static/btnTip")
	self._btnTravel = self:getGo("btnTravel")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSurprise = self:getGo("btnSurprise")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnAddLeft = self:getGo("pet/left/btnAdd")
	self._imgAddLeft = self:getGo("pet/left/btnAdd/img")
	self._leftInfo = self:getGo("pet/left/info")
	self._txtLeftName = self:getTxt("pet/left/info/txtName")
	self._imgLeftQuality = goutil.findChildComponent(self.mainGO, "pet/left/info/imgQuality", "UIImageSpriteChange")
	self._imgLeftType = goutil.findChildComponent(self.mainGO, "pet/left/info/imgType", "UIImageSpriteChange")
	self._txtLeftLv = self:getTxt("pet/left/info/txtLevel")
	self._leftPetCon = self:getGo("pet/left/petcon")
	self._btnAddRight = self:getGo("pet/right/btnAdd")
	self._imgAddRight = self:getGo("pet/right/btnAdd/img")
	self._rightInfo = self:getGo("pet/right/info")
	self._txtRightName = self:getTxt("pet/right/info/txtName")
	self._imgRightQuality = goutil.findChildComponent(self.mainGO, "pet/right/info/imgQuality", "UIImageSpriteChange")
	self._imgRightType = goutil.findChildComponent(self.mainGO, "pet/right/info/imgType", "UIImageSpriteChange")
	self._txtRightLv = self:getTxt("pet/right/info/txtLevel")
	self._imgWait = self:getGo("pet/right/imgWait")
	self._rightPetCon = self:getGo("pet/right/petcon")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTime = self:getTxt("txtTime")
	self._btnFillter = self:getGo("tableview/btnFillter")
end

function CutePetTravelTeamSelectView:onExit()
	CutePetTravelTeamSelectView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	UIStateManager.instance:popByName(ViewName.CutePetFilterView)
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	removetimer(self._onTimeClock, self)
	self._scrollerList:dispose()
end

function CutePetTravelTeamSelectView:onEnter()
	CutePetTravelTeamSelectView.super.onEnter(self)

	self._state = CutePetTravelTeamSelectView.STATE_WAIT_SELECT

	self.addGEvent(self, GlobalNotify.handlePM_CutePetTravelReceiverPutPairingCutePetResp, self._PM_CutePetTravelReceiverPutPairingCutePetResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifyReceiverHasReadyResp, self._PM_NotifyReceiverHasReadyResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetTravelCancelBuddyPairingResp, self._PM_CutePetTravelCancelBuddyPairingResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifyCancelPairingResp, self._PM_NotifyReceiverRespInviteMsgResp, self)
	self.addGEvent(self, GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)

	self._filterType = CutePetFilterMgr.TYPE_TRAVEL

	CutePetModelMgr.instance:pushViewWithModel({
		self._leftPetCon,
		self._rightPetCon
	}, self._viewPresentor.viewName, 2, 1, 180)

	local params = self:getOpenParam()

	self._isStarter = params and params[1]

	if self._isStarter == true then
		local myPetMo = CutePetModel.instance:getTeamTravelSelectMo()

		self._leftPetInfo = {}
		self._leftPetInfo.name = myPetMo.name
		self._leftPetInfo.quality = myPetMo.curQuality
		self._leftPetInfo.race = myPetMo.raceId
		self._leftPetInfo.lvl = myPetMo.curLvl
	else
		self._leftPetInfo = CutePetModel.instance:getTeamTravelReceiveMo()
	end

	self._rightPetInfo = nil
	self._selectPetId = nil
	self._selectTime = CutePetConfig.instance:getCommonValue("TravelBuddyPairingReceiverSelectCutePetTimeoutSecd", true)

	if self._isStarter == true then
		self._selectTime = self._selectTime * 2
	end

	self._confirmTime = CutePetConfig.instance:getCommonValue("TravelBuddyPairingInviterConfirmTimeoutSecd", true)

	if self._isStarter == false then
		self._confirmTime = self._confirmTime * 2
	end

	self._allCutePetList = CutePetModel.instance:getAllCutePetsList(GameUtil.handler(self._filterPet, self))

	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnSure, false)
	self:_updateUI()

	self._selectTime = self._selectTime + ServerTime.now()

	self:_onTimeClock()
	settimer(1, self._onTimeClock, self, true)
end

function CutePetTravelTeamSelectView:_updateUI()
	if self._leftPetInfo ~= nil then
		self._txtLeftName.text = self._leftPetInfo.name

		self._imgLeftQuality:SetState(self._leftPetInfo.quality - 1)

		local raceCfg = CutePetConfig.instance:getCutePetById(self._leftPetInfo.race)

		self._txtLeftLv.text = self._leftPetInfo.lvl or ""

		self._imgLeftType:SetState(raceCfg.type - 1)
		CutePetModelMgr.instance:resetModel(1, raceCfg.modelId)
		CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._leftPetInfo.race))
		CutePetModelMgr.instance:isShowAvatarPet(1, true)
		GameUtil.SetActive(self._imgAddLeft, false)
		GameUtil.SetActive(self._leftInfo, true)
	else
		CutePetModelMgr.instance:isShowAvatarPet(1, false)
		GameUtil.SetActive(self._imgAddLeft, false)
		GameUtil.SetActive(self._leftInfo, false)
	end

	if self._rightPetInfo ~= nil then
		self._txtRightName.text = self._rightPetInfo.name

		self._imgRightQuality:SetState(self._rightPetInfo.quality - 1)

		local raceCfg = CutePetConfig.instance:getCutePetById(self._rightPetInfo.race)

		self._txtRightLv.text = self._rightPetInfo.lvl or ""

		self._imgRightType:SetState(raceCfg.type - 1)
		CutePetModelMgr.instance:resetModel(2, raceCfg.modelId)
		CutePetModelMgr.instance:setOffset(2, CutePetConfig.instance:getPetOffsetInDefaultView(self._rightPetInfo.race))
		CutePetModelMgr.instance:isShowAvatarPet(2, true)
		GameUtil.SetActive(self._imgAddRight, false)
		GameUtil.SetActive(self._imgWait, false)
		GameUtil.SetActive(self._rightInfo, true)
	elseif self._isStarter == true then
		CutePetModelMgr.instance:isShowAvatarPet(2, false)
		GameUtil.SetActive(self._imgWait, true)
		GameUtil.SetActive(self._imgAddRight, false)
		GameUtil.SetActive(self._rightInfo, false)
	else
		CutePetModelMgr.instance:isShowAvatarPet(2, false)
		GameUtil.SetActive(self._imgWait, false)
		GameUtil.SetActive(self._imgAddRight, true)
		GameUtil.SetActive(self._rightInfo, false)
	end

	GameUtil.SetActive(self._txtTime, self._isStarter == true and self._state == CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT or self._isStarter == false and self._state == CutePetTravelTeamSelectView.STATE_WAIT_SELECT)
end

function CutePetTravelTeamSelectView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtLeftTime = goutil.findChildTextComponent(go, "txtLeftTime")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local imgType = goutil.findChildComponent(go, "imgType", "UIImageSpriteChange")
	local imgReady = goutil.findChild(go, "imgReady")
	local btnClick = goutil.findChild(go, "btnClick")

	MaterialMgr.setCellByMo(data, con)
	imgType:SetState(data.config.type - 1)

	txtName.text = data.name
	txtLeftTime.text = langPara("出游次数：%d", CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - data.travelCount)

	GameUtil.SetActive(imgSelect, self._curSelectMo and data.id == self._curSelectMo.id)

	if self._selectPetId then
		local isReady = self._selectPetId == data.id

		GameUtil.SetActive(imgReady, isReady)
		GameUtil.addClickHandler(btnClick, function()
			self._curSelectMo = data

			self._scrollerList:refresh()
		end, self)
	end
end

function CutePetTravelTeamSelectView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btnClick = goutil.findChild(go, "btnClick")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnClick)
end

function CutePetTravelTeamSelectView:_onClickFillter()
	if self._isStarter == false and self._state == CutePetTravelTeamSelectView.STATE_WAIT_SELECT then
		local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFillter)

		CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._showPetList, self))
	end
end

function CutePetTravelTeamSelectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutePetTravelTeamSelectView:_onFilterSelect(typeIds)
	self._fillterTypes = #(typeIds or {}) > 0 and typeIds or nil

	self:_showPetList()
end

function CutePetTravelTeamSelectView:_showPetList()
	local result = {}

	for i, v in ipairs(self._allCutePetList) do
		if CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - v.travelCount > 0 and CutePetFilterMgr.instance:checkIsMatch(self._filterType, v.cfg, v.id) == true then
			table.insert(result, v)
		end
	end

	self._scrollerList:reloadData(result)
	GameUtil.SetActive(self._tableviewGo, true)
	GameUtil.SetActive(self._btnSure, true)
end

function CutePetTravelTeamSelectView:_filterPet(petMo)
	return not petMo:getState(CutePetMo.STATE_IN_ADVENTURE)
end

function CutePetTravelTeamSelectView:_onClickbtnSure()
	if self._isStarter == true or self._state == CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT then
		return
	end

	if not self._curSelectMo then
		FloatWordMgr.instance:show(lang("请选择宠物"))

		return
	end

	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnSure, false)

	self._selectPetId = self._curSelectMo.id
	self._rightPetInfo = {
		name = self._curSelectMo.name,
		quality = self._curSelectMo.curQuality,
		race = self._curSelectMo.raceId,
		lvl = self._curSelectMo.curLvl
	}

	self:_updateUI()
end

function CutePetTravelTeamSelectView:_onClickbtnClose()
	CutePetGardenAgent.instance:sendPM_CutePetTravelCancelBuddyPairingReq()
end

function CutePetTravelTeamSelectView:_onClickCancel()
	CutePetGardenAgent.instance:sendPM_CutePetTravelCancelBuddyPairingReq()
end

function CutePetTravelTeamSelectView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("cute_pet_travel_team_select_rule")
end

function CutePetTravelTeamSelectView:_onClickTravel()
	if self._isStarter == true then
		if self._state == CutePetTravelTeamSelectView.STATE_WAIT_SELECT then
			FloatWordMgr.instance:show(lang("请等待对方选择宠物"))

			return
		end

		CutePetController.instance:sendPM_CutePetTravelInviterConfirmPairingReq(self._leftPetInfo.race, self._rightPetInfo.race)
	end

	if self._isStarter == false and checknumber(self._selectPetId) > 0 then
		if self._state == CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT then
			FloatWordMgr.instance:show(lang("请等待对方接受请求"))

			return
		end

		self._selectTime = CutePetConfig.instance:getCommonValue("TravelBuddyPairingReceiverSelectCutePetTimeoutSecd", true) + ServerTime.now()

		CutePetController.instance:sendPM_CutePetTravelReceiverPutPairingCutePetReq(self._selectPetId)
		CutePetController.instance:setTempCutePetList({
			self._leftPetInfo.race,
			self._rightPetInfo.race
		})
	end
end

function CutePetTravelTeamSelectView:_onTimeClock()
	if self._state == CutePetTravelTeamSelectView.STATE_WAIT_SELECT then
		local time = self._selectTime - ServerTime.now()

		if time <= 0 then
			CutePetGardenAgent.instance:sendPM_CutePetTravelCancelBuddyPairingReq()
			FloatWordMgr.instance:show(lang("已超时"))
		else
			self._txtTime.text = self._isStarter == true and lang("") or langPara("%d秒", time)
		end
	elseif self._state == CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT then
		local time = self._confirmTime - ServerTime.now()

		if time <= 0 then
			CutePetGardenAgent.instance:sendPM_CutePetTravelCancelBuddyPairingReq()
			FloatWordMgr.instance:show(lang("已超时"))
		else
			self._txtTime.text = self._isStarter == true and langPara("%d秒", time) or lang("等待对方确认")
		end
	end
end

function CutePetTravelTeamSelectView:_onClickAddLeft()
	return
end

function CutePetTravelTeamSelectView:_onClickAddRight()
	if self._isStarter == false and self._state == CutePetTravelTeamSelectView.STATE_WAIT_SELECT then
		self:_showPetList()
	end
end

function CutePetTravelTeamSelectView:_onClickSurprise()
	UIStateManager.instance:push(ViewName.CutePetSurpriseView)
end

function CutePetTravelTeamSelectView:_PM_CutePetTravelReceiverPutPairingCutePetResp()
	self._state = CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT
	self._confirmTime = self._confirmTime + ServerTime.now()

	self:_updateUI()
end

function CutePetTravelTeamSelectView:_PM_NotifyReceiverHasReadyResp()
	self._rightPetInfo = CutePetModel.instance:getTeamTravelReceiveMo()
	self._state = CutePetTravelTeamSelectView.STATE_WAIT_ACCEPT
	self._confirmTime = self._confirmTime + ServerTime.now()

	self:_updateUI()
end

function CutePetTravelTeamSelectView:_PM_CutePetTravelCancelBuddyPairingResp()
	self:close()
end

function CutePetTravelTeamSelectView:_PM_NotifyReceiverRespInviteMsgResp(msg)
	self._resultCode = self._resultCode or usingnow("logicconfig.config.t_lang_tip_result_code")

	local key = msg.reason and checknumber(msg.reason) ~= 0 and "rc_" .. checknumber(msg.reason) or nil

	if key ~= nil and self._resultCode[key] then
		local langKey = "content" .. LanguageMgr.instance:getLanguageType()
		local msg = self._resultCode[key][langKey]

		if not string.nilorempty(msg) then
			FloatWordMgr.instance:show(msg)
		else
			FloatWordMgr.instance:show(lang("对方已拒绝"))
		end
	else
		FloatWordMgr.instance:show(lang("对方已拒绝"))
	end

	self:close()
end

return CutePetTravelTeamSelectView
