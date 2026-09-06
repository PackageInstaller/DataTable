-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitSelectView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitSelectView", package.seeall)

local HolyStripeSuitSelectView = class("HolyStripeSuitSelectView", ViewComponent)

HolyStripeSuitSelectView.CurEquipSuitId = 0
HolyStripeSuitSelectView.NewGroupGroupId = 0

function HolyStripeSuitSelectView:buildUI()
	HolyStripeSuitSelectView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnSure = self:getGo("suitRoot/btnSure")
	self._btnClear = self:getGo("suitRoot/btnClear")
	self._groupTabelView = self:getGo("groupRoot/tableview")
	self._groupTableCell = self:getGo("groupRoot/tablecell")
	self._suitTableView = self:getGo("suitRoot/tableview")
	self._suitTableCell = self:getGo("suitRoot/tablecell")
	self._suitFilterGo = self:getGo("suitRoot/tabCon/suitFitlerBtn")
	self._suitFilter = self:getGo("suitRoot/tabCon/suitFitlerBtn/bg")
	self._suitFilterName = self:getTxt("suitRoot/tabCon/suitFitlerBtn/bg/text")
	self._suitFilterUIChange = self._suitFilterGo:GetComponent("UIChangeGroup")
	self._conditionSortGo = self:getGo("suitRoot/tabCon/conditionSortBtn")
	self._conditionSort = self:getGo("suitRoot/tabCon/conditionSortBtn/bg")
	self._conditionSortName = self:getTxt("suitRoot/tabCon/conditionSortBtn/bg/text")
	self._conditionSortUIChange = self._conditionSortGo:GetComponent("UIChangeGroup")
	self._attrTableView = self:getGo("attrRoot/tableview")
	self._attrTableCell = self:getGo("attrRoot/tablecell")
	self._curPetCon = self:getGo("curPetCon")
	self._txtRecommen = self:getTxt("txtRecommen")
	self._suitDesc = self:getTxt("attrRoot/txtDesc")
	self._suitIcon = self:getGo("attrRoot/suitIcon")
	self._txtSuitName = self:getTxt("attrRoot/txtSuitName")
	self._posHolyStripeRoot = self:getGo("posHolyStripeRoot")
	self._posCellList = {}

	for i = 1, self._posHolyStripeRoot.transform.childCount do
		self._posCellList[i] = goutil.findChild(self._posHolyStripeRoot, "pos_" .. i)
	end

	self._groupTableList = ScrollerList.create(self._groupTabelView, self._groupTableCell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._suitTableList = ScrollerList.create(self._suitTableView, self._suitTableCell, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
	self._attrTableList = ScrollerList.create(self._attrTableView, self._attrTableCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
end

function HolyStripeSuitSelectView:bindEvents()
	HolyStripeSuitSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickClear, self)
	GameUtil.addClickHandler(self._suitFilter, self._onSuitFilterBtnClick, self)
	GameUtil.addClickHandler(self._conditionSort, self._onConditionSortBtnClick, self)
end

function HolyStripeSuitSelectView:unbindEvents()
	HolyStripeSuitSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._suitFilter)
	GameUtil.rmClickHandler(self._posFilter)
end

function HolyStripeSuitSelectView:onEnter()
	HolyStripeSuitSelectView.super.onEnter()
	self.addGEvent(self, HolyStripeController.On_Select_FilterSuit, self._onSuitFilterChange, self)
	self.addGEvent(self, HolyStripeController.On_Select_ConditionSort, self._onConditionSortChange, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeSuitGetInfoRes, self._PM_HolyStripeSuitGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes, self._PM_NotifyHolyStripeSuitInfoChangeRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyHolyStripeSuitGroupInfoChangeRes, self.refreshGroupView, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeModifySuitGroupRes, self.refreshGroupView, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeModifySuitRes, self._PM_NotifyHolyStripeSuitInfoChangeRes, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeWearSuitRes, self._PM_HolyStripeWearSuitRes, self)
	HolyStripeAgent.instance:sendPM_SuitGetInfoReq()

	local selectList = self:getFirstParam()

	self.selectSuitIdMap = {}

	for i, v in ipairs(selectList) do
		self.selectSuitIdMap[v] = true
	end
end

function HolyStripeSuitSelectView:onExit()
	HolyStripeSuitSelectView.super.onExit()
	MaterialMgr.resetAll(self._curPetCon)
	MaterialMgr.resetAll(self._suitIcon)
	self._groupTableList:dispose()
	self._suitTableList:dispose()
	self._attrTableList:dispose()
end

function HolyStripeSuitSelectView:refreshView()
	self:refreshPetInfoView()
	self:refreshGroupView()
	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitSelectView:refreshPetInfoView()
	self._curPetId = HolyStripeModel.instance:getCurrShowPetId()
	self._equipList = HolyStripeModel.instance:getEquippedByPetId(self._curPetId) or {}
	self._id2posList = self._id2posList or {}
	self._posDataList = {}
	self._isEquipNotEmpty = false

	for i, v in ipairs(self._equipList) do
		local defineId = v:getDefineId()
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(defineId)

		self._id2posList[defineId] = cfg.positionType
		self._posDataList[cfg.positionType] = v
		self._isEquipNotEmpty = true
	end

	local petId = HolyStripeModel.instance:getCurrShowPetId()

	MaterialMgr.setCellByGId(MatType.Pet, petId, self._curPetCon)

	local curFaceId = HolyStripeModel.instance:getCurShowFaceId()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	self._txtRecommen.text = langPara("推荐灵纹：%s", (cfg or nil) and cfg.recmdHolystripeId)
end

function HolyStripeSuitSelectView:refreshRightView()
	self:refreshAttrView()
	self:refreshSuitInfoView()
end

function HolyStripeSuitSelectView:refreshAttrView()
	local afterAttr

	if self._suitId ~= HolyStripeSuitSelectView.CurEquipSuitId then
		local suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)

		if suitMo:getIsDirty() then
			HolyStripeController.instance:_resetDirtySuitInfo(self._suitId)

			return
		end

		afterAttr = suitMo:getAttr()
	end

	afterAttr = afterAttr or {}

	local attrData = HolyStripeModel.instance:getCurWearAttrList()

	if #attrData == 0 then
		for i, v in ipairs(HolyStripeModel.DefaultAttr) do
			table.insert(attrData, {
				value = 0,
				type = v,
				name = ConstString.HolyStripeAttr[v]
			})
		end
	end

	for i, v in ipairs(attrData) do
		attrData[i].nextValue = attrData[i].value
	end

	for attrType, attrNum in pairs(afterAttr) do
		local isFind = false

		for i, v in ipairs(attrData) do
			if v.type == attrType then
				attrData[i].nextValue = attrNum
				isFind = true

				break
			end
		end

		if isFind == false then
			table.insert(attrData, {
				value = 0,
				type = attrType,
				name = ConstString.HolyStripeAttr[attrType],
				nextValue = attrNum
			})
		end
	end

	for i, v in ipairs(attrData) do
		if not afterAttr[v.type] then
			attrData[i].nextValue = 0
		end
	end

	self._attrTableList:reloadData(attrData)
end

function HolyStripeSuitSelectView:refreshSuitInfoView()
	local curSuitCountList

	if self._suitId == HolyStripeSuitSelectView.CurEquipSuitId then
		curSuitCountList = HolyStripeModel.instance:getCurSuitList()
	else
		local suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)

		curSuitCountList = suitMo:getSuitList()
	end

	self._suitDesc.text = ""

	MaterialMgr.resetAll(self._suitIcon)

	local isFindSuit = false

	for i, v in ipairs(curSuitCountList or {}) do
		if v.num >= 4 then
			local iconCfg = HolyStripeConfig.instance:getSuitInfo(v.suitType)

			MaterialMgr.setIcon(self._suitIcon, MatType.HolyStripe, iconCfg.cfg.id)

			self._suitDesc.text = v.doc

			local suitCfg = HolyStripeConfig.instance:getSuitInfo(v.suitType)

			self._txtSuitName.text = langPara("%s：", suitCfg.name)
			isFindSuit = true

			break
		end
	end

	if not isFindSuit then
		self._txtSuitName.text = lang("未激活套装4件套效果")
		self._suitDesc.text = lang("")
	end

	local wearMos

	if self._suitId == HolyStripeSuitSelectView.CurEquipSuitId then
		wearMos = self._equipList
	else
		local suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)

		wearMos = {}

		for i, v in ipairs(suitMo.wearIds) do
			local mo = HolyStripeModel.instance:getHolyStripeMo(v)

			if mo then
				table.insert(wearMos, mo)
			end
		end
	end

	for i, v in ipairs(self._posCellList) do
		self:_clearPosCell(i)
	end

	for i, mo in ipairs(wearMos) do
		self:_updatePosCell(mo:getPosType(), mo:getDefineId(), mo)
	end
end

function HolyStripeSuitSelectView:refreshGroupView()
	local groupList = HolyStripeModel.instance:getSuitGroupList()

	if #groupList <= 0 then
		if self._groupId ~= HolyStripeSuitSelectView.NewGroupGroupId then
			self._groupId = HolyStripeSuitSelectView.NewGroupGroupId

			self:refreshSuitView()
		end

		self._groupId = HolyStripeSuitSelectView.NewGroupGroupId
	elseif HolyStripeModel.instance:getSuitGroupById(self._groupId) == nil then
		self._groupId = groupList[1].groupId

		self:refreshSuitView()
	end

	self._hasOnlyOneGroup = #groupList == 1

	self._groupTableList:reloadData(groupList)
end

function HolyStripeSuitSelectView:refreshSuitView()
	local isChangeSuit = not self:_checkCurEquipSuit()

	self.suitList = self:_getListData()

	self:_refreshFilter()

	if isChangeSuit == true then
		self:refreshRightView()
	end

	self._suitTableList:reloadData(self.suitList)
end

function HolyStripeSuitSelectView:_refreshFilter()
	if self._suitFilterId then
		local suitFilterInfo = HolyStripeConfig.instance:getSuitInfo(self._suitFilterId)

		self._suitFilterName.text = suitFilterInfo.name

		self._suitFilterUIChange:SetState(0)
	else
		self._suitFilterName.text = lang("类型")

		self._suitFilterUIChange:SetState(1)
	end

	if self._conditionSortId then
		local showtext = ""

		showtext = self._conditionSortId == -1 and lang("已镶嵌") or self._conditionSortId == -2 and lang("默认") or self._conditionSortId == -3 and lang("等级") or self._conditionSortId == -4 and lang("品质") or ConstString.HolyStripeAttr[GameEnum.HolyStripeAttrType[self._conditionSortId]]
		self._conditionSortName.text = not string.nilorempty(showtext) and showtext or "--"

		self._conditionSortUIChange:SetState(0)
	else
		self._conditionSortName.text = lang("入手时间")

		self._conditionSortUIChange:SetState(1)
	end
end

function HolyStripeSuitSelectView:_updateGroupCell(view, cell, data, tag)
	local go = cell.gameObject
	local info = goutil.findChild(go, "info")
	local txtName = goutil.findChildTextComponent(go, "info/nameText")
	local btnAdd = goutil.findChild(go, "newGroup/btnClick")
	local btnSelect = goutil.findChild(go, "info/btnSelect")
	local imgSelect = goutil.findChild(go, "info/imgSelect")

	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.SetActive(txtName, true)
	GameUtil.SetActive(btnSelect, true)
	GameUtil.SetActive(imgSelect, self._groupId == data.groupId)
	GameUtil.SetActive(info, data.groupId ~= HolyStripeSuitSelectView.NewGroupGroupId)

	if data.groupId ~= HolyStripeSuitSelectView.NewGroupGroupId then
		txtName.text = data.groupName

		GameUtil.addClickHandler(btnSelect, function()
			self:_onSelectGroup(data.groupId)
		end, self)
	end
end

function HolyStripeSuitSelectView:_clearGroupCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "info/btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function HolyStripeSuitSelectView:_updateSuitCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "itemCon")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local imgCurShow = goutil.findChild(go, "imgCurShow")
	local btnShow = goutil.findChild(go, "btnShow")

	GameUtil.SetActive(imgSelect, self.selectSuitIdMap[data.suitId] == true)
	GameUtil.SetActive(imgCurShow, data.suitId == self._suitId)
	GameUtil.rmClickHandler(btnShow)
	GameUtil.addClickHandler(btnShow, function()
		self:_onClickSuit(data.suitId)
	end)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSelectSuit(data.suitId)
	end)
	MaterialMgr.resetAll(imgCon)

	nameText.text = data.suitName

	local suitList = data:getSuitList()
	local suitType = 0
	local suitNum = 0

	for i, v in ipairs(suitList) do
		if suitNum < v.num then
			suitNum = v.num
			suitType = v.suitType
		end
	end

	GameUtil.SetActive(imgCon, false)

	local iconCfg = HolyStripeConfig.instance:getSuitInfo(suitType)

	if iconCfg.cfg and checknumber(iconCfg.cfg.id) > 0 then
		GameUtil.SetActive(imgCon, true)
		MaterialMgr.setIcon(imgCon, MatType.HolyStripe, iconCfg.cfg.id)
	end
end

function HolyStripeSuitSelectView:_clearSuitCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local btnUpSort = goutil.findChild(go, "btnUpSort")
	local btnEquip = goutil.findChild(go, "btnEquip")
	local imgCon = goutil.findChild(go, "itemCon")

	MaterialMgr.resetAll(imgCon)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnEquip)
	GameUtil.rmClickHandler(btnUpSort)
end

function HolyStripeSuitSelectView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")
	local txtNext = goutil.findChildTextComponent(go, "txtNextValue")
	local nextColorChange = goutil.findChildComponent(go, "txtNextValue", "UITextColorChange")
	local arrowGo = goutil.findChild(go, "imgArrow")
	local arrowChange = goutil.findChildComponent(go, "imgArrow", "UIImageSpriteChange")

	if data.type then
		goutil.setActive(iconGo, true)
		icon:SetState(data.type - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = data.name

	GameUtil.SetActive(arrowGo, false)
	GameUtil.SetActive(txtNext, false)

	if data.nextValue ~= data.value and self._suitId ~= HolyStripeSuitSelectView.CurEquipSuitId then
		GameUtil.SetActive(arrowGo, true)
		GameUtil.SetActive(txtNext, true)

		txtNext.text = data.nextValue > 0 and data.nextValue < 1 and string.format("%s%%", data.nextValue * 100) or data.nextValue

		if data.nextValue - data.value > 0 then
			arrowChange:SetState(0)
			nextColorChange:SetState(0)
		else
			arrowChange:SetState(1)
			nextColorChange:SetState(1)
		end
	end
end

function HolyStripeSuitSelectView:_clearAttrCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeSuitSelectView:_updatePosCell(index, defineId, mo)
	if self._posCellList[index] then
		local go = self._posCellList[index]
		local emptyGo = goutil.findChild(go, "img")
		local icon = goutil.findChild(go, "icon")
		local qualityGo = goutil.findChild(go, "quality")
		local quality = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

		GameUtil.rmClickHandler(go)

		if checknumber(defineId) > 0 then
			GameUtil.SetActive(emptyGo, false)
			GameUtil.SetActive(icon, true)
			GameUtil.SetActive(qualityGo, true)
			MaterialMgr.setIcon(icon, MatType.HolyStripe, defineId)

			local cfg = HolyStripeConfig.instance:getHolyStripeCfg(defineId)

			quality:SetState(cfg.quality)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:openMaterialTips(self.mainGo, MatType.HolyStripe, mo:getId(), mo)
			end)
		else
			GameUtil.SetActive(emptyGo, true)
			GameUtil.SetActive(qualityGo, false)
			GameUtil.SetActive(icon, false)
			MaterialMgr.resetAll(icon)
		end
	end
end

function HolyStripeSuitSelectView:_clearPosCell(index)
	if self._posCellList[index] then
		local go = self._posCellList[index]
		local emptyGo = goutil.findChild(go, "img")
		local icon = goutil.findChild(go, "icon")
		local qualityGo = goutil.findChild(go, "quality")

		GameUtil.SetActive(emptyGo, true)
		GameUtil.SetActive(icon, false)
		GameUtil.SetActive(qualityGo, false)
		MaterialMgr.resetAll(icon)
	end
end

function HolyStripeSuitSelectView:_getListData()
	local info
	local result = {}

	if checknumber(self._groupId) ~= HolyStripeSuitSelectView.NewGroupGroupId then
		info = HolyStripeModel.instance:getSuitListByGroup(self._groupId)
	else
		return result
	end

	for i, v in ipairs(info or {}) do
		if checknumber(self._suitFilterId) > 0 then
			local isCanInsert = false

			for j, typeInfo in ipairs(v:getSuitList() or {}) do
				if typeInfo.suitType == self._suitFilterId and typeInfo.num > 0 then
					isCanInsert = true

					break
				end
			end

			if isCanInsert == true then
				table.insert(result, v)
			end
		else
			table.insert(result, v)
		end
	end

	if self._conditionSortId then
		local attrType = GameEnum.HolyStripeAttrType[self._conditionSortId]

		table.sort(result, function(a, b)
			local suitMoA = HolyStripeModel.instance:getSuitMo(a.suitId)
			local suitMoB = HolyStripeModel.instance:getSuitMo(b.suitId)
			local attrA = suitMoA:getAttr()
			local attrB = suitMoB:getAttr()

			if checknumber(attrA[attrType]) ~= checknumber(attrB[attrType]) then
				return checknumber(attrA[attrType]) > checknumber(attrB[attrType])
			else
				return a.suitId < b.suitId
			end
		end)
	else
		table.sort(result, function(a, b)
			return a.suitId < b.suitId
		end)
	end

	for i, v in ipairs(result) do
		result[i].index = i
	end

	return result
end

function HolyStripeSuitSelectView:_checkCurEquipSuit()
	local isFindEquipSuit = false

	self._curEquipSuitId = HolyStripeSuitSelectView.CurEquipSuitId

	local allSuitMo = HolyStripeModel.instance:getAllSuitMo()
	local equipMap = {}
	local equipNum = 0

	for i, v in ipairs(self._equipList) do
		equipMap[v:getId()] = v
		equipNum = equipNum + 1
	end

	for i, suitMo in pairs(allSuitMo) do
		local count = 0
		local isAllCheck = true

		for j, v in pairs(suitMo.wearIds) do
			if equipMap[v] then
				count = count + 1
			elseif v ~= -1 then
				isAllCheck = false

				break
			end
		end

		if isAllCheck and count == equipNum then
			isFindEquipSuit = true
			self._curEquipSuitId = suitMo.suitId

			break
		end
	end

	if isFindEquipSuit == false then
		self._curEquipSuitId = HolyStripeSuitSelectView.CurEquipSuitId
	end

	local findSuit = false

	for i, v in pairs(allSuitMo) do
		if v.suitId == self._suitId then
			findSuit = true
		end
	end

	if not findSuit then
		self._suitId = self._curEquipSuitId
	end

	return findSuit
end

function HolyStripeSuitSelectView:_onSelectGroup(groupId)
	self._groupId = groupId

	self:refreshGroupView()
	self:refreshSuitView()
end

function HolyStripeSuitSelectView:_onClickSelectSuit(suitId)
	self.selectSuitIdMap[suitId] = not self.selectSuitIdMap[suitId]

	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitSelectView:_onClickSuit(suitId)
	self._suitId = suitId

	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitSelectView:_onSuitFilterBtnClick()
	self:showTabAt(self._suitFilterGo, ViewName.HolyStripeSuitFilterView, self._suitFilterId)
end

function HolyStripeSuitSelectView:_onConditionSortBtnClick()
	self:showTabAt(self._conditionSortGo, ViewName.HolyStripeSuitConditionSortView, self._conditionSortId)
end

function HolyStripeSuitSelectView:_onSuitFilterChange(suitFilterId)
	self._suitFilterId = suitFilterId

	self:refreshSuitView()

	if self._suitFilterId == nil and self._conditionSortId == nil then
		GameUtil.SetActive(self._btnSort, true)
	else
		GameUtil.SetActive(self._btnSort, false)
	end
end

function HolyStripeSuitSelectView:_onConditionSortChange(condition)
	if checknumber(self._conditionSortId) ~= 0 and checknumber(self._conditionSortId) < 0 then
		self._conditionSortId = nil
	else
		self._conditionSortId = condition
	end

	self:refreshSuitView()

	if self._conditionSortId == nil and self._suitFilterId == nil then
		GameUtil.SetActive(self._btnSort, true)
	else
		GameUtil.SetActive(self._btnSort, false)
	end
end

function HolyStripeSuitSelectView:_onClickSure()
	local list = {}

	for id, v in pairs(self.selectSuitIdMap) do
		if v == true then
			table.insert(list, id)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HolyStripeSuitSelect, list)
	self:close()
end

function HolyStripeSuitSelectView:_onClickClear()
	self.selectSuitIdMap = {}

	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitSelectView:_PM_HolyStripeSuitGetInfoRes()
	self._suitFilterId = nil
	self._conditionSortId = nil
	self._groupId = HolyStripeSuitSelectView.NewGroupGroupId
	self._suitId = HolyStripeSuitSelectView.CurEquipSuitId

	self:refreshView()

	local groupList = HolyStripeModel.instance:getSuitGroupList()

	self:_onSelectGroup(groupList[1].groupId)
end

function HolyStripeSuitSelectView:_PM_NotifyHolyStripeSuitInfoChangeRes()
	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitSelectView:_PM_HolyStripeWearSuitRes()
	self:refreshPetInfoView()
	self:refreshSuitView()
	self:refreshRightView()
end

return HolyStripeSuitSelectView
