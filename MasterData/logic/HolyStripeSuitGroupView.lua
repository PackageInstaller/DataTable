-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitGroupView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitGroupView", package.seeall)

local HolyStripeSuitGroupView = class("HolyStripeSuitGroupView", ViewComponent)
local inputLenLimit = 6
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "分组名可以由<color=#ffffff>2-6个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-13526] = "分组名不可为空"
resultCode[-13530] = "分组名不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-13528] = "分组名太长了"
resultCode[-1505] = "有些字不太合适哦，再想想看？"
resultCode[-1513] = "分组格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"
HolyStripeSuitGroupView.CurEquipSuitId = 0
HolyStripeSuitGroupView.NewGroupGroupId = 0

function HolyStripeSuitGroupView:buildUI()
	HolyStripeSuitGroupView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTips = self:getGo("leftTop/btnTip")
	self._btnEdit = self:getGo("btnEdit")
	self._btnEditGroup = self:getGo("groupRoot/btnEdit")
	self._btnEditGroupEnd = self:getGo("groupRoot/btnEditEnd")
	self._btnCreate = self:getGo("suitRoot/btnCreate")
	self._btnDeleteSuit = self:getGo("btnDelete")
	self._btnSort = self:getGo("suitRoot/btnSort")
	self._txtSort = self:getTxt("suitRoot/btnSort/txt")
	self._btnCreateSuit = self:getGo("btnCreateSuit")
	self._btnEquip = self:getGo("btnEquip")
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
	self._posHolyStripeRoot = self:getGo("posHolyStripeRoot")
	self._posCellList = {}

	for i = 1, self._posHolyStripeRoot.transform.childCount do
		self._posCellList[i] = goutil.findChild(self._posHolyStripeRoot, "pos_" .. i)
	end

	self._groupTableList = ScrollerList.create(self._groupTabelView, self._groupTableCell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._suitTableList = ScrollerList.create(self._suitTableView, self._suitTableCell, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
	self._attrTableList = ScrollerList.create(self._attrTableView, self._attrTableCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
end

function HolyStripeSuitGroupView:bindEvents()
	HolyStripeSuitGroupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnEdit, self._onClickEdit, self)
	GameUtil.addClickHandler(self._suitFilter, self._onSuitFilterBtnClick, self)
	GameUtil.addClickHandler(self._conditionSort, self._onConditionSortBtnClick, self)
	GameUtil.addClickHandler(self._btnEditGroup, self._onClickEditGroup, self)
	GameUtil.addClickHandler(self._btnEditGroupEnd, self._onClickEditGroupEnd, self)
	GameUtil.addClickHandler(self._btnCreate, self._onClickCreateSuit, self)
	GameUtil.addClickHandler(self._btnDeleteSuit, self._onClickDeleteSuit, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnCreateSuit, self._onClickCreateSuitByEquip, self)
	GameUtil.addClickHandler(self._btnEquip, function()
		self:_onClickEquip(self._suitId)
	end, self)
end

function HolyStripeSuitGroupView:unbindEvents()
	HolyStripeSuitGroupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEdit)
	GameUtil.rmClickHandler(self._suitFilter)
	GameUtil.rmClickHandler(self._posFilter)
	GameUtil.rmClickHandler(self._btnEditGroup)
	GameUtil.rmClickHandler(self._btnEditGroupEnd)
	GameUtil.rmClickHandler(self._btnCreate)
	GameUtil.rmClickHandler(self._btnDeleteSuit)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnCreateSuit)
	GameUtil.rmClickHandler(self._btnEquip)
end

function HolyStripeSuitGroupView:onEnter()
	HolyStripeSuitGroupView.super.onEnter()
	self.addGEvent(self, HolyStripeController.On_Select_FilterSuit, self._onSuitFilterChange, self)
	self.addGEvent(self, HolyStripeController.On_Select_ConditionSort, self._onConditionSortChange, self)
	self.addGEvent(self, GlobalNotify.HolyStripeSuitEndEdit, self._onHolyStripeSuitEndEdit, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeSuitGetInfoRes, self._PM_HolyStripeSuitGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes, self._PM_NotifyHolyStripeSuitInfoChangeRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyHolyStripeSuitGroupInfoChangeRes, self.refreshGroupView, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeModifySuitGroupRes, self.refreshGroupView, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeModifySuitRes, self._PM_NotifyHolyStripeSuitInfoChangeRes, self)
	self.addGEvent(self, GlobalNotify.PM_HolyStripeWearSuitRes, self._PM_HolyStripeWearSuitRes, self)
	HolyStripeAgent.instance:sendPM_SuitGetInfoReq()

	self._isEditGroup = false
	self._isEditingSuit = false
	self._suitChangeSorting = false
	self._txtSort.text = self._suitChangeSorting == true and lang("确认") or lang("排序")

	GameUtil.SetActive(self._btnSort, true)
end

function HolyStripeSuitGroupView:onExit()
	HolyStripeSuitGroupView.super.onExit()

	self._isEditGroup = false

	MaterialMgr.resetAll(self._curPetCon)
	MaterialMgr.resetAll(self._suitIcon)
	self._groupTableList:dispose()
	self._suitTableList:dispose()
	self._attrTableList:dispose()
end

function HolyStripeSuitGroupView:refreshView()
	self:refreshPetInfoView()
	self:refreshGroupView()
	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitGroupView:refreshPetInfoView()
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

function HolyStripeSuitGroupView:refreshRightView()
	self:refreshAttrView()
	self:refreshSuitInfoView()
	self:refreshRightBtns()
end

function HolyStripeSuitGroupView:refreshAttrView()
	local afterAttr

	if self._suitId ~= HolyStripeSuitGroupView.CurEquipSuitId then
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

function HolyStripeSuitGroupView:refreshSuitInfoView()
	local curSuitCountList

	if self._suitId == HolyStripeSuitGroupView.CurEquipSuitId then
		curSuitCountList = HolyStripeModel.instance:getCurSuitList()
	else
		local suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)

		curSuitCountList = suitMo:getSuitList()
	end

	self._suitDesc.text = ""

	goutil.setActive(self._suitIcon, true)
	MaterialMgr.resetAll(self._suitIcon)

	local isFindSuit = false

	for i, v in ipairs(curSuitCountList or {}) do
		if v.num >= 4 then
			local iconCfg = HolyStripeConfig.instance:getSuitInfo(v.suitType)

			MaterialMgr.setIcon(self._suitIcon, MatType.HolyStripe, iconCfg.cfg.id)

			self._suitDesc.text = v.doc
			isFindSuit = true

			break
		end
	end

	if not isFindSuit then
		goutil.setActive(self._suitIcon, false)

		self._suitDesc.text = lang("未激活套装4件套效果")
	end

	local wearMos

	if self._suitId == HolyStripeSuitGroupView.CurEquipSuitId then
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

function HolyStripeSuitGroupView:refreshRightBtns()
	GameUtil.SetActive(self._btnEdit, self._suitId ~= HolyStripeSuitGroupView.CurEquipSuitId)
	GameUtil.SetActive(self._btnDeleteSuit, self._suitId ~= HolyStripeSuitGroupView.CurEquipSuitId)
	GameUtil.SetActive(self._btnEquip, self._suitId ~= self._curEquipSuitId)
	GameUtil.SetActive(self._btnCreateSuit, self._suitId == HolyStripeSuitGroupView.CurEquipSuitId and self._isEquipNotEmpty == true)
end

function HolyStripeSuitGroupView:refreshGroupView()
	local groupList = HolyStripeModel.instance:getSuitGroupList()

	if #groupList <= 0 then
		if self._groupId ~= HolyStripeSuitGroupView.NewGroupGroupId then
			self._groupId = HolyStripeSuitGroupView.NewGroupGroupId

			self:refreshSuitView()
		end

		self._groupId = HolyStripeSuitGroupView.NewGroupGroupId
	elseif HolyStripeModel.instance:getSuitGroupById(self._groupId) == nil then
		self._groupId = groupList[1].groupId

		self:refreshSuitView()
	end

	self._hasOnlyOneGroup = #groupList == 1

	if self._isEditGroup == true then
		table.insert(groupList, {
			groupId = HolyStripeSuitGroupView.NewGroupGroupId
		})
	end

	self._groupTableList:reloadData(groupList)
	GameUtil.SetActive(self._btnEditGroup, self._isEditGroup == false)
	GameUtil.SetActive(self._btnEditGroupEnd, self._isEditGroup == true)
end

function HolyStripeSuitGroupView:refreshSuitView()
	local isChangeSuit = not self:_checkCurEquipSuit()

	self.suitList = self:_getListData()

	self:_refreshFilter()

	if isChangeSuit == true then
		self:refreshRightView()
	end

	self._suitTableList:reloadData(self.suitList)
end

function HolyStripeSuitGroupView:_refreshFilter()
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

function HolyStripeSuitGroupView:_updateGroupCell(view, cell, data, tag)
	local go = cell.gameObject
	local info = goutil.findChild(go, "info")
	local newGroup = goutil.findChild(go, "newGroup")
	local txtName = goutil.findChildTextComponent(go, "info/nameText")
	local input = Framework.InputFieldAdapter.GetFrom(go, "info/InputC_Search")

	input:SetCharacterLimit(inputLenLimit)

	local btnAdd = goutil.findChild(go, "newGroup/btnClick")
	local btnSelect = goutil.findChild(go, "info/btnSelect")
	local btnDelete = goutil.findChild(go, "info/btnDelete")
	local imgSelect = goutil.findChild(go, "info/imgSelect")

	input:RemoveOnValueChanged()
	input:RemoveOnEndEdit()
	Framework.UIClickTrigger.Get(input.input.gameObject):RemoveClickListener()
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnDelete)
	GameUtil.SetActive(txtName, not self._isEditGroup)
	GameUtil.SetActive(btnSelect, not self._isEditGroup)
	GameUtil.SetActive(btnDelete, self._isEditGroup and not self._hasOnlyOneGroup)
	GameUtil.SetActive(input, self._isEditGroup)
	GameUtil.SetActive(imgSelect, self._groupId == data.groupId)
	GameUtil.SetActive(info, data.groupId ~= HolyStripeSuitGroupView.NewGroupGroupId)
	GameUtil.SetActive(newGroup, data.groupId == HolyStripeSuitGroupView.NewGroupGroupId)

	if data.groupId ~= HolyStripeSuitGroupView.NewGroupGroupId then
		txtName.text = data.groupName

		input:SetText(data.groupName)
		input:AddOnEndEdit(function()
			self:_onGroupEndEdit(data.groupId, input)
		end, self)
		input:AddOnValueChanged(function()
			self:_onValueChanged(data.groupId, input)
		end, self)
		Framework.UIClickTrigger.Get(input.input.gameObject):AddClickListener(function()
			self:_onClickInput(data.groupId, input)
		end, self, nil)
		GameUtil.addClickHandler(btnSelect, function()
			self:_onSelectGroup(data.groupId)
		end, self)
		GameUtil.addClickHandler(btnDelete, function()
			self:_onDeleteGroup(data.groupId)
		end, self)
	else
		GameUtil.addClickHandler(btnAdd, self._onClickAddNewGroup, self)
	end
end

function HolyStripeSuitGroupView:_clearGroupCell(cell)
	local go = cell.gameObject
	local input = Framework.InputFieldAdapter.GetFrom(go, "info/InputC_Search")
	local btnAdd = goutil.findChild(go, "newGroup/btnClick")
	local btnSelect = goutil.findChild(go, "info/btnSelect")
	local btnDelete = goutil.findChild(go, "info/btnDelete")

	input:RemoveOnValueChanged()
	input:RemoveOnEndEdit()
	Framework.UIClickTrigger.Get(input.input.gameObject):RemoveClickListener()
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnDelete)
end

function HolyStripeSuitGroupView:_updateSuitCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "itemCon")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local imgCur = goutil.findChild(go, "imgCur")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local btnUpSort = goutil.findChild(go, "btnUpSort")
	local btnEquip = goutil.findChild(go, "btnEquip")

	GameUtil.SetActive(imgSelect, data.suitId == self._suitId)
	GameUtil.SetActive(imgCur, data.suitId == self._curEquipSuitId and not self._suitChangeSorting)
	GameUtil.SetActive(btnEquip, data.suitId ~= self._curEquipSuitId and data.isCurEquip ~= true and not self._suitChangeSorting)
	GameUtil.SetActive(btnUpSort, data.isCurEquip ~= true and self._suitChangeSorting == true and self._conditionSortId == nil)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnEquip)
	GameUtil.rmClickHandler(btnUpSort)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSuit(data.suitId)
	end)
	GameUtil.addClickHandler(btnEquip, function()
		self:_onClickEquip(data.suitId)
	end)
	GameUtil.addClickHandler(btnUpSort, function()
		self:_onClickUpSort(data.suitId, data.index)
	end)
	MaterialMgr.resetAll(imgCon)

	local suitList

	if data.isCurEquip == true then
		nameText.text = lang("当前装备")
		suitList = HolyStripeModel.instance:getCurSuitList()
	else
		nameText.text = data.suitName
		suitList = data:getSuitList()
	end

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

function HolyStripeSuitGroupView:_clearSuitCell(cell)
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

function HolyStripeSuitGroupView:_updateAttrCell(view, cell, data, tag)
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

	if data.nextValue ~= data.value and self._suitId ~= HolyStripeSuitGroupView.CurEquipSuitId then
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

function HolyStripeSuitGroupView:_clearAttrCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function HolyStripeSuitGroupView:_updatePosCell(index, defineId, mo)
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

function HolyStripeSuitGroupView:_clearPosCell(index)
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

function HolyStripeSuitGroupView:_getListData()
	local info
	local result = {}

	if checknumber(self._groupId) ~= HolyStripeSuitGroupView.NewGroupGroupId then
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

	if self._curEquipSuitId == HolyStripeSuitGroupView.CurEquipSuitId then
		table.insert(result, 1, {
			isCurEquip = true,
			suitId = HolyStripeSuitGroupView.CurEquipSuitId
		})
	end

	for i, v in ipairs(result) do
		result[i].index = i
	end

	return result
end

function HolyStripeSuitGroupView:_checkCurEquipSuit()
	local isFindEquipSuit = false

	self._curEquipSuitId = HolyStripeSuitGroupView.CurEquipSuitId

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
		self._curEquipSuitId = HolyStripeSuitGroupView.CurEquipSuitId
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

function HolyStripeSuitGroupView:_checkName(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_showTips(-13526)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_showTips(-1513)
	elseif realLen < 2 then
		self:_showTips(-13530)
	elseif isAllUnderLine then
		self:_showTips(-1513)
	elseif realLen > inputLenLimit then
		self:_showTips(-13528)
	else
		isValid = true
	end

	return isValid
end

function HolyStripeSuitGroupView:_showTips(status)
	FloatWordMgr.instance:show(lang(resultCode[status] or ""))
end

function HolyStripeSuitGroupView:_onGroupEndEdit(groupId, input)
	self._editingGroup = nil
	self._editingInput = nil

	local groupInfo = HolyStripeModel.instance:getSuitGroupById(groupId)

	if groupInfo and groupInfo.groupName ~= input:GetText() and self:_checkName(input:GetText()) == true then
		HolyStripeAgent.instance:sendPM_ModifySuitGroupReq(groupId, input:GetText())
	else
		input:SetText(groupInfo.groupName)
	end
end

function HolyStripeSuitGroupView:_onClickInput(groupId, input)
	self._editingGroup = groupId
	self._editingInput = input
end

function HolyStripeSuitGroupView:_onClickAddNewGroup()
	HolyStripeAgent.instance:sendPM_ModifySuitGroupReq(nil, lang("默认分组"))
end

function HolyStripeSuitGroupView:_onSelectGroup(groupId)
	self._groupId = groupId

	self:refreshGroupView()
	self:refreshSuitView()
end

function HolyStripeSuitGroupView:_onDeleteGroup(groupId)
	HolyStripeAgent.instance:sendPM_DeleteSuitGroupReq(groupId)
end

function HolyStripeSuitGroupView:_onValueChanged(groupId, input)
	local value = input:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	input:RemoveOnValueChanged()
	input:SetText(result)
	input:AddOnValueChanged(function()
		self:_onValueChanged(groupId, input)
	end, self)
end

function HolyStripeSuitGroupView:_onClickEdit()
	self._isEditingSuit = true

	UIStateManager.instance:push(ViewName.HolyStripeSuitEditView, self._suitId)
end

function HolyStripeSuitGroupView:_onClickEditGroup()
	self._isEditGroup = true

	self:refreshGroupView()
end

function HolyStripeSuitGroupView:_onClickEditGroupEnd()
	if self._editingGroup and self._editingInput then
		local groupInfo = HolyStripeModel.instance:getSuitGroupById(self._editingGroup)
		local curTxt = self._editingInput:GetText()

		if groupInfo and groupInfo.groupName ~= curTxt and self:_checkName(curTxt) == true then
			HolyStripeAgent.instance:sendPM_ModifySuitGroupReq(self._editingGroup, self._editingInput:GetText())
		else
			self._editingInput:SetText(groupInfo.groupName)
		end
	end

	self._editingGroup = nil
	self._editingInput = nil
	self._isEditGroup = false

	self:refreshGroupView()
end

function HolyStripeSuitGroupView:_onClickSuit(suitId)
	self._suitId = suitId

	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitGroupView:_onClickEquip(suitId)
	local suitMo = HolyStripeModel.instance:getSuitMo(suitId)

	if suitMo then
		if HolyStripeModel.instance:getSuitReplaceTip() == true then
			HolyStripeAgent.instance:sendPM_HolyStripeWearSuitReq(self._curPetId, suitId)

			return
		end

		for i, v in ipairs(suitMo.wearIds) do
			local mo = HolyStripeModel.instance:getHolyStripeMo(v)

			if mo and checknumber(mo:getEquipPetId()) > 0 and mo:getEquipPetId() ~= self._curPetId then
				UIStateManager.instance:push(ViewName.HolyStripeSuitReplaceTipsView, suitId)

				return
			end
		end

		HolyStripeAgent.instance:sendPM_HolyStripeWearSuitReq(self._curPetId, suitId)
	end
end

function HolyStripeSuitGroupView:_onClickUpSort(suitId, index)
	if index > 2 and self._curEquipSuitId == HolyStripeSuitGroupView.CurEquipSuitId or index >= 2 and self._curEquipSuitId ~= HolyStripeSuitGroupView.CurEquipSuitId then
		local exchangeSuitMo = self.suitList[index - 1]
		local upSuitMo = self.suitList[index]

		HolyStripeController.instance:_swapSuitInfo(exchangeSuitMo.suitId, upSuitMo.suitId)

		if self._suitId == upSuitMo.suitId then
			self._suitId = exchangeSuitMo.suitId
		end
	end
end

function HolyStripeSuitGroupView:_onClickCreateSuit()
	if self._groupId == HolyStripeSuitGroupView.NewGroupGroupId then
		FloatWordMgr.instance:show(lang("请先创建分组"))

		return
	end

	if self._suitChangeSorting == true then
		FloatWordMgr.instance:show(lang("正在调整排序中"))

		return
	end

	HolyStripeModel.instance:createTempSuitMo(self._groupId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes)
	UIStateManager.instance:push(ViewName.HolyStripeSuitEditView, HolyStripeModel.TempSuitId)
end

function HolyStripeSuitGroupView:_onClickCreateSuitByEquip()
	if self._groupId == HolyStripeSuitGroupView.NewGroupGroupId then
		FloatWordMgr.instance:show(lang("请先创建分组"))

		return
	end

	if self._suitChangeSorting == true then
		FloatWordMgr.instance:show(lang("正在调整排序中"))

		return
	end

	local holyStripeList = {}

	for i, mo in ipairs(self._equipList) do
		holyStripeList[mo:getPosType()] = mo:getId()
	end

	local hasEquip = false

	for i = 1, 5 do
		if not holyStripeList[i] or holyStripeList[i] == -1 then
			holyStripeList[i] = -1
		else
			hasEquip = true
		end
	end

	if not hasEquip then
		FloatWordMgr.instance:show(lang("当前套装为空"))

		return
	else
		HolyStripeAgent.instance:sendPM_ModifySuitReq(nil, lang("新建套装"), self._groupId, holyStripeList)
	end
end

function HolyStripeSuitGroupView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, "planofholystripe_rule")
end

function HolyStripeSuitGroupView:_onClickDeleteSuit()
	if self._suitId == HolyStripeSuitGroupView.CurEquipSuitId then
		FloatWordMgr.instance:show(lang("请先选中预设"))

		return
	end

	HolyStripeAgent.instance:sendPM_DeleteSuitReq(self._suitId)
end

function HolyStripeSuitGroupView:_onClickSort()
	self._suitChangeSorting = not self._suitChangeSorting

	self:refreshSuitView()

	self._txtSort.text = self._suitChangeSorting == true and lang("确认") or lang("排序")
end

function HolyStripeSuitGroupView:_onSuitFilterBtnClick()
	self:showTabAt(self._suitFilterGo, ViewName.HolyStripeSuitFilterView, self._suitFilterId)
end

function HolyStripeSuitGroupView:_onConditionSortBtnClick()
	self:showTabAt(self._conditionSortGo, ViewName.HolyStripeSuitConditionSortView, self._conditionSortId)
end

function HolyStripeSuitGroupView:_onSuitFilterChange(suitFilterId)
	if self._suitChangeSorting == true then
		FloatWordMgr.instance:show(lang("正在调整排序中"))

		return
	end

	if not self._isEditingSuit then
		self._suitFilterId = suitFilterId

		self:refreshSuitView()
	end

	if self._suitFilterId == nil and self._conditionSortId == nil then
		GameUtil.SetActive(self._btnSort, true)
	else
		GameUtil.SetActive(self._btnSort, false)
	end
end

function HolyStripeSuitGroupView:_onConditionSortChange(condition)
	if self._suitChangeSorting == true then
		FloatWordMgr.instance:show(lang("正在调整排序中"))

		return
	end

	if not self._isEditingSuit then
		if checknumber(self._conditionSortId) ~= 0 and checknumber(self._conditionSortId) < 0 then
			self._conditionSortId = nil
		else
			self._conditionSortId = condition
		end

		self:refreshSuitView()
	end

	if self._conditionSortId == nil and self._suitFilterId == nil then
		GameUtil.SetActive(self._btnSort, true)
	else
		GameUtil.SetActive(self._btnSort, false)
	end
end

function HolyStripeSuitGroupView:_onHolyStripeSuitEndEdit()
	self._isEditingSuit = false
end

function HolyStripeSuitGroupView:_PM_HolyStripeSuitGetInfoRes()
	self._suitFilterId = nil
	self._conditionSortId = nil
	self._groupId = HolyStripeSuitGroupView.NewGroupGroupId
	self._suitId = HolyStripeSuitGroupView.CurEquipSuitId

	self:refreshView()

	local curEquipSuitMo = HolyStripeModel.instance:getSuitMo(self._curEquipSuitId)

	if curEquipSuitMo then
		self:_onSelectGroup(curEquipSuitMo.groupId)
	end
end

function HolyStripeSuitGroupView:_PM_NotifyHolyStripeSuitInfoChangeRes()
	self:refreshSuitView()
	self:refreshRightView()
end

function HolyStripeSuitGroupView:_PM_HolyStripeWearSuitRes()
	self:refreshPetInfoView()
	self:refreshSuitView()
	self:refreshRightView()
end

return HolyStripeSuitGroupView
