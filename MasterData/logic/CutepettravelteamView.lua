-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelteamView.lua

module("logic.extensions.cutepet.view.CutepettravelteamView", package.seeall)

local CutepettravelteamView = class("CutepettravelteamView", ViewComponent)

function CutepettravelteamView:ctor()
	CutepettravelteamView.super.ctor(self)
end

function CutepettravelteamView:unbindEvents()
	CutepettravelteamView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnFind:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnFillter)

	for i, cell in ipairs(self._presetCellList) do
		GameUtil.rmClickHandler(cell.btn)
	end

	GameUtil.rmClickHandler(self._btnTogPreset)
	GameUtil.rmClickHandler(self._btnBuddyPet)
end

function CutepettravelteamView:bindEvents()
	CutepettravelteamView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnFind:AddClickListener(self._onClickbtnFind, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnAdd:AddClickListener(self._onClickbtnAdd, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	GameUtil.addClickHandler(self._btnFillter, self._onClickFillter, self)

	for i, cell in ipairs(self._presetCellList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickPos, self, i), self)
	end

	GameUtil.addClickHandler(self._btnTogPreset, self._onClickTogPreset, self)
	GameUtil.addClickHandler(self._btnBuddyPet, self._onClickBuddyPet, self)
end

function CutepettravelteamView:buildUI()
	CutepettravelteamView.super.buildUI(self)

	self._btnTip = self:getBtn("static/btnTip")
	self._btnClose = self:getBtn("static/btnClose")
	self._btnFind = self:getBtn("btnFind")
	self._btnReward = self:getBtn("btnReward")
	self._btnAdd = self:getBtn("pet/btnAdd")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnSure = self:getBtn("btnSure")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._petCon = self:getGo("pet/petcon")
	self._imgAdd = self:getGo("pet/btnAdd/img")
	self._petInfo = self:getGo("pet/info")
	self._imgQuality = goutil.findChildComponent(self.mainGO, "pet/info/imgQuality", "UIImageSpriteChange")
	self._imgType = goutil.findChildComponent(self.mainGO, "pet/info/imgType", "UIImageSpriteChange")
	self._txtName = self:getTxt("pet/info/txtName")
	self._txtLv = self:getTxt("pet/info/txtLevel")
	self._btnFillter = self:getGo("tableview/btnFillter")
	self._btnTogPreset = self:getGo("preset/btnTogPreset")
	self._markPublic = self:getGo("preset/btnTogPreset/mark")
	self._presetCellList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("preset/list/pos" .. i)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.conEmpty = goutil.findChild(cell.go, "empty")
		cell.conInfo = goutil.findChild(cell.go, "info")
		cell.icon = goutil.findChild(cell.go, "info/icon")
		cell.txtName = goutil.findChildTextComponent(cell.go, "info/txtName")
		cell.txtTime = goutil.findChildTextComponent(cell.go, "info/txtTime")
		cell.txtNeed = goutil.findChildTextComponent(cell.go, "info/txtNeed")

		table.insert(self._presetCellList, cell)
	end

	self._btnBuddyPet = self:getGo("btnBuddyPet")
	self._goTips = self:getGo("pet/tips")
end

function CutepettravelteamView:onExit()
	CutepettravelteamView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	UIStateManager.instance:popByName(ViewName.CutePetFilterView)
	CutePetFilterMgr.instance:resetDataByType(self._filterType)
	self._scrollerList:dispose()

	for i, cell in ipairs(self._presetCellList) do
		MaterialMgr.resetAll(cell.icon)
	end
end

function CutepettravelteamView:onEnter()
	CutepettravelteamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.CutePetBagFilterSelect, self._onFilterSelect, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetInfoRes, self._updatePresetInfo, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetAddPetsRes, self._refreshPresetCells, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetRemovePetsRes, self._refreshPresetCells, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetSetPublicRes, self._refreshPresetIsPublic, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetCloseSelect, self._onCloseSelectView, self)
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)

	self._filterType = CutePetFilterMgr.TYPE_TRAVEL
	self._curShowMo = nil
	self._allCutePetList = CutePetModel.instance:getAllCutePetsList()
	self._inviteUserId = self:getFirstParam()

	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnSure, false)
	self:_refreshPetInfo()
	CutePetGardenAgent.instance:sendPM_PresetCutePetInfoReq()
end

function CutepettravelteamView:_refreshPetInfo()
	if self._curShowMo then
		GameUtil.SetActive(self._imgAdd, false)
		CutePetModelMgr.instance:resetModel(1, self._curShowMo.config.modelId)
		CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._curShowMo.config.raceId))
		GameUtil.SetActive(self._petInfo, true)
		CutePetModelMgr.instance:isShowAvatarPet(1, true)
		self._imgQuality:SetState(self._curShowMo.curQuality - 1)

		local raceCfg = CutePetConfig.instance:getCutePetById(self._curShowMo.config.raceId)

		self._imgType:SetState(raceCfg.type - 1)

		self._txtName.text = self._curShowMo.name
		self._txtLv.text = self._curShowMo.curLvl

		GameUtil.SetActive(self._goTips, false)
	else
		GameUtil.SetActive(self._imgAdd, true)
		CutePetModelMgr.instance:isShowAvatarPet(1, false)
		GameUtil.SetActive(self._petInfo, false)
		GameUtil.SetActive(self._goTips, true)
	end
end

function CutepettravelteamView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("cute_pet_travel_team_rule")
end

function CutepettravelteamView:_onClickbtnClose()
	self:close()
end

function CutepettravelteamView:_onClickbtnFind()
	if not self._curShowMo then
		FloatWordMgr.instance:show("请先选择出游的宠物")

		return
	end

	if not self:_checkIsCanJump() then
		return
	end

	CutePetModel.instance:setTeamTravelSelectMo(self._curShowMo)
	UIStateManager.instance:push(ViewName.CutepettravelteaminvateView, self._inviteUserId)
end

function CutepettravelteamView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.CutePetSurpriseView)
end

function CutepettravelteamView:_onClickbtnAdd()
	self:_showPetList()
end

function CutepettravelteamView:_onClickbtnSure()
	self._curShowMo = self._curSelectMo

	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnSure, false)
	self:_refreshPetInfo()
end

function CutepettravelteamView:_onFilterSelect(typeIds)
	self._fillterTypes = #(typeIds or {}) > 0 and typeIds or nil

	self:_showPetList()
end

function CutepettravelteamView:_onClickFillter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFillter)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._showPetList, self))
end

function CutepettravelteamView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function CutepettravelteamView:_showPetList()
	local result = {}
	local count = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true)

	for i, v in ipairs(self._allCutePetList) do
		if count - v.travelCount > 0 and CutePetFilterMgr.instance:checkIsMatch(self._filterType, v.cfg, v.id) == true then
			table.insert(result, v)
		end
	end

	self._scrollerList:reloadData(result)
	GameUtil.SetActive(self._tableviewGo, true)
	GameUtil.SetActive(self._btnSure, true)
end

function CutepettravelteamView:_updateCell(view, cell, data, tag)
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

	if self._curShowMo then
		local isReady = self._curShowMo.id == data.id

		GameUtil.SetActive(imgReady, isReady)
		GameUtil.addClickHandler(btnClick, function()
			self._curSelectMo = data

			self:_updateList()
		end, self)
	end
end

function CutepettravelteamView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function CutepettravelteamView:_updateList()
	self._scrollerList:refresh()
end

function CutepettravelteamView:_updatePresetInfo()
	self:_refreshPresetCells()
	self:_refreshPresetIsPublic()
end

function CutepettravelteamView:_refreshPresetCells()
	self._showPetInfoList = {}

	local presetInfo = CutePetModel.instance:getMyPetPresetInfo()

	if presetInfo then
		if not presetInfo.presetCutePetList then
			for i, v in ipairs(presetInfo.presetCutePetList) do
				table.insert(self._showPetInfoList, v)
			end
		end
	end

	for i, cell in ipairs(self._presetCellList) do
		local petInfo = self._showPetInfoList[i]

		if petInfo then
			goutil.setActive(cell.conEmpty, false)
			goutil.setActive(cell.conInfo, true)

			local petMo = CutePetModel.instance:getCutePeMo(petInfo.uniqueId)

			MaterialMgr.setCellByMo(petMo, cell.icon)

			cell.txtName.text = petMo.name

			local leftCount = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - petMo.travelCount

			if not petInfo.cutePet.travelCountNeeds then
				cell.txtTime.text = langPara("剩余：%d次", Mathf.Min(leftCount, petInfo.cutePet.travelCountNeeds))

				if not petInfo.cutePet.cutePetTypeNeeds then
					local cutePetTypeNeeds = 0
					local needTypeNameStr = "无"

					if cutePetTypeNeeds > 0 then
						local typeCfg = CutePetConfig.instance:getPetTypeCfg(cutePetTypeNeeds)

						needTypeNameStr = typeCfg.name
					end

					cell.txtNeed.text = langPara("期望：%s", needTypeNameStr)
				end
			end
		else
			goutil.setActive(cell.conEmpty, true)
			goutil.setActive(cell.conInfo, false)
		end
	end
end

function CutepettravelteamView:_refreshPresetIsPublic()
	self._isPresetPublic = false

	local presetInfo = CutePetModel.instance:getMyPetPresetInfo()

	if presetInfo then
		self._isPresetPublic = presetInfo.presetPublic
	end

	goutil.setActive(self._markPublic, self._isPresetPublic)
end

function CutepettravelteamView:_onClickPos(posIndex)
	local petInfo = self._showPetInfoList[posIndex]

	UIStateManager.instance:push(ViewName.CutePetPresetSelectView, (petInfo or nil) and petInfo.uniqueId)
end

function CutepettravelteamView:_onClickTogPreset()
	local newPublic = not self._isPresetPublic

	CutePetGardenAgent.instance:sendPM_SetPresetPublicReq(newPublic)
end

function CutepettravelteamView:_onCloseSelectView()
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)
	self:_refreshPetInfo()
end

function CutepettravelteamView:_onClickBuddyPet()
	local isCanJump = self:_checkIsCanJump()

	if isCanJump then
		UIStateManager.instance:push(ViewName.CutePetPresetBuddyView)
	end
end

function CutepettravelteamView:_checkIsCanJump()
	local leftTime, totalCount = CutePetController.instance:getTravelTimeParams()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("出游次数已用完")

		return false
	end

	return true
end

return CutepettravelteamView
