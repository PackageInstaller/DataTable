-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelsingleView.lua

module("logic.extensions.cutepet.view.CutepettravelsingleView", package.seeall)

local CutepettravelsingleView = class("CutepettravelsingleView", ViewComponent)

function CutepettravelsingleView:ctor()
	CutepettravelsingleView.super.ctor(self)
end

function CutepettravelsingleView:unbindEvents()
	CutepettravelsingleView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnAddLeft)
	GameUtil.rmClickHandler(self._btnAddRight)
	GameUtil.rmClickHandler(self._btnTravel)
	GameUtil.rmClickHandler(self._btnFillter)
end

function CutepettravelsingleView:bindEvents()
	CutepettravelsingleView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnAddLeft, self._onClickAddLeft, self)
	GameUtil.addClickHandler(self._btnAddRight, self._onClickAddRight, self)
	GameUtil.addClickHandler(self._btnTravel, self._onClickTravel, self)
	GameUtil.addClickHandler(self._btnFillter, self._onClickFillter, self)
end

function CutepettravelsingleView:buildUI()
	CutepettravelsingleView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("static/btnClose")
	self._btnTip = self:getBtn("static/btnTip")
	self._btnTravel = self:getGo("static/btnTravel")
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
	self._imgAddRight_2 = self:getGo("pet/right/btnAdd/imgAdd")
	self._rightInfo = self:getGo("pet/right/info")
	self._txtRightName = self:getTxt("pet/right/info/txtName")
	self._imgRightQuality = goutil.findChildComponent(self.mainGO, "pet/right/info/imgQuality", "UIImageSpriteChange")
	self._imgRightType = goutil.findChildComponent(self.mainGO, "pet/right/info/imgType", "UIImageSpriteChange")
	self._txtRightLv = self:getTxt("pet/right/info/txtLevel")
	self._rightPetCon = self:getGo("pet/right/petcon")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnFillter = self:getGo("tableview/btnFillter")
end

function CutepettravelsingleView:onExit()
	CutepettravelsingleView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	UIStateManager.instance:popByName(ViewName.CutePetFilterView)
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	self._scrollerList:dispose()
end

function CutepettravelsingleView:onEnter()
	CutepettravelsingleView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetTravelMySelfPairingResp, self._PM_CutePetTravelMySelfPairingResp, self)
	self.addGEvent(self, GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
	CutePetModelMgr.instance:pushViewWithModel({
		self._leftPetCon,
		self._rightPetCon
	}, self._viewPresentor.viewName, 2, 1, 180)

	self._allCutePetList = CutePetModel.instance:getAllCutePetsList()

	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnSure, false)

	self._leftPetMo = nil
	self._rightPetMo = nil
	self._filterType = CutePetFilterMgr.TYPE_TRAVEL

	self:_updateUI()
end

function CutepettravelsingleView:_updateCell(view, cell, data, tag)
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

	if self._isSelectRight ~= true or not self._leftPetMo or data.id ~= self._leftPetMo.id then
		if self._isSelectRight == false then
			if self._rightPetMo then
				local isReady = data.id == self._rightPetMo.id

				GameUtil.SetActive(imgReady, isReady)
				GameUtil.addClickHandler(btnClick, function()
					if isReady == true then
						FloatWordMgr.instance:show(lang("已选择"))
					elseif self._curSelectMo and data.id == self._curSelectMo.id then
						self._curSelectMo = nil

						self:_updateList()
					else
						self._curSelectMo = data

						self:_updateList()
					end
				end, self)
			end
		end
	end
end

function CutepettravelsingleView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btnClick = goutil.findChild(go, "btnClick")

	GameUtil.rmClickHandler(btnClick)
	MaterialMgr.resetAll(con)
end

function CutepettravelsingleView:_updateUI()
	if self._leftPetMo ~= nil then
		self._txtLeftName.text = self._leftPetMo.name

		self._imgLeftQuality:SetState(self._leftPetMo.curQuality - 1)
		self._imgLeftType:SetState(self._leftPetMo.config.type - 1)

		self._txtLeftLv.text = self._leftPetMo.curLvl

		CutePetModelMgr.instance:resetModel(1, self._leftPetMo.config.modelId)
		CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._leftPetMo.config.raceId))
		CutePetModelMgr.instance:isShowAvatarPet(1, true)
		GameUtil.SetActive(self._imgAddLeft, false)
		GameUtil.SetActive(self._leftInfo, true)
	else
		CutePetModelMgr.instance:isShowAvatarPet(1, false)
		GameUtil.SetActive(self._imgAddLeft, true)
		GameUtil.SetActive(self._leftInfo, false)
	end

	if self._rightPetMo ~= nil then
		self._txtRightName.text = self._rightPetMo.name

		self._imgRightQuality:SetState(self._rightPetMo.curQuality - 1)
		self._imgRightType:SetState(self._rightPetMo.config.type - 1)

		self._txtRightLv.text = self._rightPetMo.curLvl

		CutePetModelMgr.instance:resetModel(2, self._rightPetMo.config.modelId)
		CutePetModelMgr.instance:setOffset(2, CutePetConfig.instance:getPetOffsetInDefaultView(self._rightPetMo.config.raceId))
		CutePetModelMgr.instance:isShowAvatarPet(2, true)
		GameUtil.SetActive(self._imgAddRight, false)
		GameUtil.SetActive(self._imgAddRight_2, false)
		GameUtil.SetActive(self._rightInfo, true)
	else
		CutePetModelMgr.instance:isShowAvatarPet(2, false)
		GameUtil.SetActive(self._imgAddRight, true)
		GameUtil.SetActive(self._imgAddRight_2, true)
		GameUtil.SetActive(self._rightInfo, false)
	end

	if self._leftPetMo ~= nil and self._rightPetMo ~= nil then
		GameUtil.SetGray(self._btnTravel, false)
	else
		GameUtil.SetGray(self._btnTravel, true)
	end
end

function CutepettravelsingleView:_updateList()
	self._scrollerList:refresh()
end

function CutepettravelsingleView:_showPetList()
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

function CutepettravelsingleView:_onClickbtnSure()
	if self._isSelectRight == true then
		self._rightPetMo = self._curSelectMo
	elseif self._isSelectRight == false then
		self._leftPetMo = self._curSelectMo
	end

	self._curSelectMo = nil
	self._isSelectRight = nil

	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnSure, false)
	self:_updateUI()
end

function CutepettravelsingleView:_onClickbtnClose()
	self:close()
end

function CutepettravelsingleView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("cute_pet_travel_single_rule")
end

function CutepettravelsingleView:_onClickTravel()
	if self._leftPetMo ~= nil and self._rightPetMo ~= nil then
		CutePetController.instance:sendPM_CutePetTravelMySelfPairingReq({
			self._leftPetMo.id,
			self._rightPetMo.id
		})
	else
		FloatWordMgr.instance:show(lang("请放入出游宠物"))
	end
end

function CutepettravelsingleView:_onClickFillter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFillter)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._showPetList, self))
end

function CutepettravelsingleView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutepettravelsingleView:_onFilterSelect(typeIds)
	self._fillterTypes = #(typeIds or {}) > 0 and typeIds or nil

	self:_showPetList()
end

function CutepettravelsingleView:_onClickAddLeft()
	self._curSelectMo = nil

	if self._leftPetMo then
		self._curSelectMo = self._leftPetMo
	end

	self._isSelectRight = false

	self:_showPetList()
end

function CutepettravelsingleView:_onClickAddRight()
	self._curSelectMo = nil

	if self._rightPetMo then
		self._curSelectMo = self._rightPetMo
	end

	self._isSelectRight = true

	self:_showPetList()
end

function CutepettravelsingleView:_PM_CutePetTravelMySelfPairingResp()
	return
end

return CutepettravelsingleView
