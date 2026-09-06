-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetPresetSelectView.lua

module("logic.extensions.cutepet.view.CutePetPresetSelectView", package.seeall)

local CutePetPresetSelectView = class("CutePetPresetSelectView", ViewComponent)

function CutePetPresetSelectView:ctor()
	CutePetPresetSelectView.super.ctor(self)
end

function CutePetPresetSelectView:unbindEvents()
	CutePetPresetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnType)
	GameUtil.rmClickHandler(self._btnTime)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSureSelect)
	GameUtil.rmClickHandler(self._btnFillter)
	GameUtil.rmClickHandler(self._btnClear)
	self._customInput:RemoveListener()
end

function CutePetPresetSelectView:bindEvents()
	CutePetPresetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnType, self._onClickType, self)
	GameUtil.addClickHandler(self._btnTime, self._onClickTime, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSureSelect, self._onClickSureSelect, self)
	GameUtil.addClickHandler(self._btnFillter, self._onClickFillter, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClear, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CutePetPresetSelectView:buildUI()
	CutePetPresetSelectView.super.buildUI(self)

	self._btnType = self:getGo("btnType")
	self._txtType = self:getTxt("btnType/bg/txtType")
	self._needType = goutil.findChildComponent(self.mainGO, "btnType/bg/imgType", "UIImageSpriteChange")
	self._btnTime = self:getGo("btnTime")
	self._txtTime = self:getTxt("publishInfo/txtTime")
	self._btnPublish = self:getGo("btnPublish")
	self._typeContent = self:getGo("typeContent")
	self._typeTable = self:getGo("typeContent/tableview")
	self._typeCell = self:getGo("typeContent/cell")
	self._customInput = UICustomInput.Get(self._typeContent)
	self._btnAdd = self:getGo("pet/btnAdd")
	self._petType = goutil.findChildComponent(self.mainGO, "pet/info/imgType", "UIImageSpriteChange")
	self._petName = self:getTxt("pet/info/txtName")
	self._selectPetInfo = self:getGo("pet/info")
	self._petCon = self:getGo("petcon")
	self._txtLevel = self:getTxt("pet/info/txtLevel")
	self._imgQualityChange = goutil.findChildComponent(self.mainGO, "pet/info/imgQuality", "UIImageSpriteChange")
	self._selectTable = self:getGo("selectTable")
	self._petTable = self:getGo("selectTable/tableview")
	self._petCell = self:getGo("selectTable/tablecell")
	self._btnSure = self:getGo("selectTable/btnSure")
	self._btnFillter = self:getGo("selectTable/btnFillter")
	self._btnClose = self:getGo("btnClose")
	self._typeList = ScrollerList.create(self._typeTable, self._typeCell, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))
	self._petList = ScrollerList.create(self._petTable, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnSureSelect = self:getGo("btnSureSelect")
	self._btnClear = self:getGo("btnClear")
end

function CutePetPresetSelectView:onExit()
	CutePetPresetSelectView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetPresetCloseSelect)
	CutePetFilterMgr.instance:resetDataByType(self._filterType)

	self._curShowPet = nil
	self._curSelectMo = nil
	self._selectType = 0
	self._selectTime = 0
end

function CutePetPresetSelectView:onEnter()
	CutePetPresetSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.CutePetCommunitySliderNum, self._onSelectTimeSet, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetAddPetsRes, self._handleAddPreset, self)
	self.addGEvent(self, GlobalNotify.CutePetPresetRemovePetsRes, self._handleRemovePreset, self)

	self._curSelectPetMap = {}
	self._filterType = CutePetFilterMgr.TYPE_COMMUNITY
	self._allPetList = self:_getUnselectedPetList()

	local list = {
		0
	}
	local typeCfgs = CutePetConfig.instance:getAllPetTypeCfg()

	for i = 1, #typeCfgs do
		table.insert(list, i)
	end

	self._typeList:reloadData(list)
	GameUtil.SetActive(self._selectTable, false)
	GameUtil.SetActive(self._typeContent, false)
	GameUtil.SetActive(self._btnSure, false)
	GameUtil.SetActive(self._petTable, false)
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)

	self._selectType = 0
	self._selectTime = 0
	self._curShowPet = nil

	local curEnterPetId = checknumber(self:getFirstParam()) or 0

	if curEnterPetId > 0 then
		self._curShowPet = CutePetModel.instance:getCutePeMo(curEnterPetId)

		local presetInfo = self._curSelectPetMap[curEnterPetId]

		if presetInfo then
			self._selectTime = presetInfo.cutePet.travelCountNeeds
			self._selectType = presetInfo.cutePet.cutePetTypeNeeds
		end
	end

	self:_refreshView()
end

function CutePetPresetSelectView:_refreshView()
	self:_refreshPet()
	self:_refreshInfo()
end

function CutePetPresetSelectView:_refreshPet()
	if self._curShowPet then
		local avatar = CutePetModelMgr.instance:getAvatarPet(1)

		CutePetModelMgr.instance:resetModel(1, self._curShowPet.config.modelId)
		CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._curShowPet.config.raceId))
		CutePetModelMgr.instance:isShowAvatarPet(1, true)
		GameUtil.SetActive(self._petType, true)
		GameUtil.SetActive(self._petName, true)
		GameUtil.SetActive(self._txtLevel, true)
		GameUtil.SetActive(self._imgQualityChange, true)
		GameUtil.SetActive(self._selectPetInfo, true)
		GameUtil.SetActive(self._btnAdd, false)
		self._petType:SetState(self._curShowPet.config.type - 1)

		self._petName.text = self._curShowPet.name
		self._txtLevel.text = self._curShowPet.curLvl

		self._imgQualityChange:SetState(self._curShowPet.curQuality - 1)
	else
		GameUtil.SetActive(self._txtLevel, false)
		GameUtil.SetActive(self._imgQualityChange, false)
		CutePetModelMgr.instance:isShowAvatarPet(1, false)
		GameUtil.SetActive(self._petType, false)
		GameUtil.SetActive(self._petName, false)
		GameUtil.SetActive(self._selectPetInfo, false)
		GameUtil.SetActive(self._btnAdd, true)
	end
end

function CutePetPresetSelectView:_refreshInfo()
	self._txtTime.text = checknumber(self._selectTime)

	if checknumber(self._selectType) > 0 then
		GameUtil.SetActive(self._needType, true)

		do
			local typeCfg = CutePetConfig.instance:getPetTypeCfg(self._selectType)

			self._needType:SetState(self._selectType - 1)

			self._txtType.text = typeCfg.name
		end
	else
		GameUtil.SetActive(self._needType, false)

		self._txtType.text = lang("无")
	end

	GameUtil.SetActive(self._btnTime, self._curShowPet and CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - self._curShowPet.travelCount > 1)
	self._typeList:refresh()
	self:_refreshPetList()
end

function CutePetPresetSelectView:_updateTypeCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = go:GetComponent(ComponentType.UIChangeGroup)
	local imgType = goutil.findChildComponent(go, "imgType", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local txtTotal = goutil.findChildTextComponent(go, "txtTotal")
	local btnClick = goutil.findChild(go, "raycast")

	if checknumber(data) > 0 then
		GameUtil.SetActive(imgType, true)
		GameUtil.SetActive(txtName, true)
		GameUtil.SetActive(txtTotal, false)
		imgType:SetState(data - 1)

		local typeCfg = CutePetConfig.instance:getPetTypeCfg(data)

		txtName.text = typeCfg.name
	else
		GameUtil.SetActive(imgType, false)
		GameUtil.SetActive(txtName, false)
		GameUtil.SetActive(txtTotal, true)

		txtName.text = lang("无")
	end

	if checknumber(self._selectType) == checknumber(data) then
		bgChange:SetState(1)
	else
		bgChange:SetState(0)
	end

	GameUtil.addClickHandler(btnClick, function()
		self:_onClickCellType(data)
	end, self)
end

function CutePetPresetSelectView:_clearTypeCell(cell)
	return
end

function CutePetPresetSelectView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local txtLeftTime = goutil.findChildTextComponent(go, "txtLeftTime")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local imgReady = goutil.findChild(go, "imgReady")
	local btnClick = goutil.findChild(go, "btnClick")

	MaterialMgr.setCellByMo(data, con)

	txtName.text = data.name
	txtLeftTime.text = langPara("剩余次数：%d", CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - data.travelCount)

	GameUtil.SetActive(imgSelect, self._curSelectMo and data.id == self._curSelectMo.id)

	if self._curShowPet then
		local isReady = self._curShowPet.id == data.id

		GameUtil.SetActive(imgReady, isReady)
		GameUtil.addClickHandler(btnClick, function()
			self._curSelectMo = data

			self._petList:refresh()
		end, self)
	end
end

function CutePetPresetSelectView:_clearPetCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btnClick = goutil.findChild(go, "btnClick")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btnClick)
end

function CutePetPresetSelectView:_filterPet(petMo)
	local travelCount = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true)

	return travelCount - petMo.travelCount > 0 and not self._curSelectPetMap[petMo.id]
end

function CutePetPresetSelectView:_onClickCellType(typeId)
	self._selectType = typeId

	self:_refreshInfo()
	GameUtil.SetActive(self._typeContent, false)
end

function CutePetPresetSelectView:_onClickType()
	GameUtil.SetActive(self._typeContent, true)
end

function CutePetPresetSelectView:_onClickTime()
	if self._curShowPet and CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - self._curShowPet.travelCount > 1 then
		UIStateManager.instance:push(ViewName.CutePetCommunitySliderView, CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - self._curShowPet.travelCount, checknumber(self._selectTime))
	end
end

function CutePetPresetSelectView:_onClickSure()
	self._curShowPet = self._curSelectMo

	GameUtil.SetActive(self._selectTable, false)
	GameUtil.SetActive(self._petTable, false)
	GameUtil.SetActive(self._btnSure, false)

	if self._curShowPet then
		self._selectTime = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true) - self._curShowPet.travelCount

		self:_refreshView()
	end
end

function CutePetPresetSelectView:_onClickAdd()
	GameUtil.SetActive(self._selectTable, true)
	GameUtil.SetActive(self._petTable, true)
	GameUtil.SetActive(self._btnSure, true)
	self:_refreshPetList()
end

function CutePetPresetSelectView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._typeContent, false)
	end
end

function CutePetPresetSelectView:_onSelectTimeSet(selectTime)
	self._selectTime = selectTime

	self:_refreshInfo()
end

function CutePetPresetSelectView:_getUnselectedPetList()
	self._presetPetInfoList = {}
	self._curSelectPetMap = {}

	local presetInfo = CutePetModel.instance:getMyPetPresetInfo()

	if presetInfo then
		self._presetPetInfoList = presetInfo.presetCutePetList or {}

		for i, info in ipairs(self._presetPetInfoList) do
			self._curSelectPetMap[info.uniqueId] = info
		end
	end

	return (CutePetModel.instance:getAllCutePetsList(GameUtil.handler(self._filterPet, self)))
end

function CutePetPresetSelectView:_refreshPetList()
	local dataList = {}

	for i, v in ipairs(self._allPetList or {}) do
		if CutePetFilterMgr.instance:checkIsMatch(self._filterType, v.cfg, v.id) == true then
			table.insert(dataList, v)
		end
	end

	self._petList:reloadData(dataList)
end

function CutePetPresetSelectView:_onClickSureSelect()
	if self._curShowPet then
		local sendInfo = CutePetGardenExtension_pb.PM_PresetCutePet()

		sendInfo.uniqueId = self._curShowPet.id

		local petInfo = CutePetGardenExtension_pb.RecentlyPublishCutePet()

		petInfo.cutePetId = self._curShowPet.raceId
		petInfo.cutePetTypeNeeds = checknumber(self._selectType)
		petInfo.travelCountNeeds = self._selectTime or 1

		sendInfo.cutePet:ParseFromString(petInfo:SerializeToString())
		CutePetGardenAgent.instance:sendPM_AddPresetCuteReq(sendInfo)
	else
		FloatWordMgr.instance:show(lang("请先选择宠物"))
	end
end

function CutePetPresetSelectView:_onClickClear()
	if self._curShowPet then
		if self._curSelectPetMap[self._curShowPet.id] then
			CutePetGardenAgent.instance:sendPM_RemovePresetCutePetReq(self._curShowPet.id)
		end

		self._curShowPet = nil
		self._selectType = 0
		self._selectTime = 0

		self:_refreshView()
	end
end

function CutePetPresetSelectView:_onClickFillter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFillter)

	CutePetFilterMgr.instance:openFilterViewByType(self._viewPresentor, self._filterType, pos, sizeDelta, GameUtil.handler(self._refreshPetList, self))
end

function CutePetPresetSelectView:_handleAddPreset()
	FloatWordMgr.instance:show("修改成功")
	self:close()
end

function CutePetPresetSelectView:_handleRemovePreset()
	FloatWordMgr.instance:show("移除成功")
end

return CutePetPresetSelectView
