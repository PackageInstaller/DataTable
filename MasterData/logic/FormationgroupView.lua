-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationgroupView.lua

module("logic.extensions.formation.view.FormationgroupView", package.seeall)

local FormationgroupView = class("FormationgroupView", ViewComponent)
local inputLenLimit = 6
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "分组名可以由<color=#ffffff>2-6个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-13526] = "分组名不可为空"
resultCode[-13530] = "分组名不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-13528] = "分组名太长了"
resultCode[-1505] = "有些字不太合适哦，再想想看？"
resultCode[-1513] = "分组格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"
FormationgroupView.NONE_GROUP_ID = -1
FormationgroupView.NONE_TAB_ID = -1
FormationgroupView.TYPE_NORMAL = 0
FormationgroupView.TYPE_EDITOR = 1

function FormationgroupView:buildUI()
	FormationgroupView.super.buildUI(self)

	self._btnCLose = self:getGo("btnClose")
	self._btnUse = self:getGo("btnUse")
	self._btnEditGroup = self:getGo("groupRoot/btnEdit")
	self._btnEditGroupEnd = self:getGo("groupRoot/btnEditEnd")
	self._btnCreate = self:getGo("suitRoot/btnCreate")
	self._btnSort = self:getGo("suitRoot/btnSort")
	self._txtSort = self:getTxt("suitRoot/btnSort/txt")
	self._topMask = self:getGo("suitRoot/topMask")

	GameUtil.SetActive(self._topMask, false)

	self._groupTabelView = self:getGo("groupRoot/tableview")
	self._groupTableCell = self:getGo("groupRoot/tablecell")
	self._groupTabelCellConTr = self:getGo("groupRoot/tableview/Nego_Viewport/Nego_Content").transform
	self._suitTableView = self:getGo("suitRoot/tableview")
	self._suitTableCell = self:getGo("suitRoot/tablecell")
	self._downCon = self:getGo("downCon")
	self._customInput = UICustomInput.Get(self._downCon)
	self._scroll = self:getGo("downCon/scroll/ScrollView")
	self._downcell = self:getGo("downCon/cell")
	self._curPetCon = self:getGo("curPetCon")
	self._txtRecommen = self:getTxt("txtRecommen")
	self._suitDesc = self:getTxt("attrRoot/txtDesc")
	self._suitIcon = self:getGo("attrRoot/suitIcon")
	self._tabScrollerList = ScrollerList.create(self._suitTableView, self._suitTableCell, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
	self._downScrollerList = ScrollerList.create(self._scroll, self._downcell, GameUtil.handler(self._updateDownCell, self), GameUtil.handler(self._clearDownCell, self))
	self._groupTabCells = {}
end

function FormationgroupView:bindEvents()
	FormationgroupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnUse, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnCLose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnEditGroup, self._onClickEditGroup, self)
	GameUtil.addClickHandler(self._btnEditGroupEnd, self._onClickEditGroupEnd, self)
	GameUtil.addClickHandler(self._btnCreate, self._onCreateNewTab, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function FormationgroupView:unbindEvents()
	FormationgroupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnUse)
	GameUtil.rmClickHandler(self._btnCLose)
	GameUtil.rmClickHandler(self._btnEditGroup)
	GameUtil.rmClickHandler(self._btnEditGroupEnd)
	GameUtil.rmClickHandler(self._btnCreate)
	self._customInput:RemoveListener()
end

function FormationgroupView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._downCon, false)
	end
end

function FormationgroupView:_onClickClose()
	if self._curTabId > 0 then
		self:close()

		if self._isEditorType then
			FormationGroupController.instance:sendChangeTabId(self._curTabId)
		else
			GlobalDispatcher:dispatch(GlobalNotify.FormationTabModify, self._curTabId)
		end
	else
		self:close()
	end
end

function FormationgroupView:onExit()
	FormationgroupView.super.onExit()

	self._isEditing = false
end

function FormationgroupView:onEnter()
	FormationgroupView.super.onEnter()

	local params = self:getOpenParam() or {}

	self._type = checknumber(params[1])
	self._formationMo = params[2]

	GameUtil.SetActive(self._downCon, false)
	GameUtil.SetActive(self._btnUse, false)

	local tabId = FormationGroupModel.instance:getCurNewTabId()

	self._isEditorType = false
	self._curGroupId = FormationgroupView.NONE_GROUP_ID
	self._curTabId = FormationgroupView.NONE_TAB_ID

	if self._type == FormationgroupView.TYPE_EDITOR then
		self._isEditorType = true
		self._curTabId = FormationGroupModel.instance.curTabId
	elseif self._formationMo then
		local tabInfo = FormationGroupModel.instance:getMatchTabIdByFmo(self._formationMo)

		if tabInfo then
			self._curTabId = tabInfo.tabId
		end
	end

	local tabInfo = FormationGroupModel.instance:getTabInfo(self._curTabId)

	if tabInfo then
		self._curGroupId = tabInfo.groupId
	end

	self._isEditing = false
	self._hasOnlyOneGroup = false
	self._editingGroup = nil
	self._editingGroupInput = nil
	self._editingTabInfo = nil
	self._editingTabInput = nil

	self.addGEvent(self, GlobalNotify.FormationGroupInfoUpdate, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.FormationGroupModify, self._onGroupModify, self)
	self.addGEvent(self, GlobalNotify.FormationTabModify, self._onTabModify, self)
	FormationGroupController.instance:sendGetInfoOnce()
	self:_refreshUI()
end

function FormationgroupView:refreshAllBtns()
	GameUtil.SetActive(self._btnEditGroup, self._isEditorType and self._isEditing == false)
	GameUtil.SetActive(self._btnEditGroupEnd, self._isEditorType and self._isEditing == true)
	GameUtil.SetActive(self._btnCreate, self._isEditorType and self._isEditing == false)
end

function FormationgroupView:_refreshUI()
	self:refreshGroupView()
	self:refreshRightView()
	self:refreshAllBtns()
end

function FormationgroupView:_onGroupModify(modifyGroupId)
	if self._curGroupId ~= modifyGroupId then
		self._curTabId = FormationgroupView.NONE_GROUP_ID
	end

	self._curGroupId = modifyGroupId

	self:_refreshUI()
end

function FormationgroupView:_onTabModify(modifyTabId)
	local tabId = FormationGroupModel.instance:getCurNewTabId()

	if tabId > 0 then
		self._curTabId = tabId
	end

	self:refreshRightView()

	if tabId > 0 then
		for i, v in ipairs(self._tabList) do
			if v.tabId == tabId then
				self._tabScrollerList:MoveCellToCenter(i - 1)

				break
			end
		end
	end
end

function FormationgroupView:refreshRightView()
	self._tabList = self:_getTabListData()

	self._tabScrollerList:reloadData(self._tabList)
end

function FormationgroupView:_getSorttingGroup()
	local list = {}
	local groups = FormationGroupModel.instance:getGroupList()

	for i, v in ipairs(groups or {}) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, {
		"topId",
		"groupId"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})

	return list
end

function FormationgroupView:refreshGroupView()
	self._groupList = self:_getSorttingGroup()

	local len = #self._groupList

	self._hasOnlyOneGroup = len == 1

	if self._isEditing == true then
		table.insert(self._groupList, {
			groupId = FormationgroupView.NONE_GROUP_ID
		})
	end

	if self._curGroupId == FormationgroupView.NONE_GROUP_ID and len > 0 then
		self._curGroupId = self._groupList[1].groupId
	else
		local hasGroup = false

		for i, v in ipairs(self._groupList) do
			if v.groupId == self._curGroupId then
				hasGroup = true

				break
			end
		end

		if not hasGroup then
			self._curGroupId = len > 0 and self._groupList[1].groupId or FormationgroupView.NONE_GROUP_ID
		end
	end

	self:_buildGroupTableCells(self._groupList)
	self:_updateGroupTableCells(self._groupList)
end

function FormationgroupView:_buildGroupTableCells(groupList)
	goutil.setActive(self._groupTableCell, false)

	for i, v in ipairs(groupList) do
		local go = self._groupTabCells[i]

		if not go then
			go = goutil.cloneAndSetParent(self._groupTableCell, self._groupTabelCellConTr)
			self._groupTabCells[i] = go
		end

		Framework.TransformUtil.SetAnchoredPos(go.transform, 0, -75 * (i - 1))
		goutil.setActive(go, true)
	end

	goutil.setHeight(self._groupTabelCellConTr, #groupList * 75)

	for i = #groupList + 1, #self._groupTabCells do
		goutil.setActive(self._groupTabCells[i])
	end
end

function FormationgroupView:_updateGroupTableCells(groupList)
	for i, v in ipairs(groupList) do
		local go = self._groupTabCells[i]

		self:_updateGroupCell(nil, go, v)
	end
end

function FormationgroupView:_updateGroupCell(view, cell, data, tag)
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
	GameUtil.rmClickHandler(input.input.gameObject)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnDelete)
	GameUtil.SetActive(txtName, not self._isEditing)
	GameUtil.SetActive(input, self._isEditing)
	GameUtil.SetActive(btnDelete, self._isEditorType and self._isEditing and not self._hasOnlyOneGroup and data.groupId ~= FormationGroupController.DEFAULT_GROUP_ID)
	GameUtil.SetActive(imgSelect, self._curGroupId == data.groupId)
	GameUtil.SetActive(info, data.groupId ~= FormationgroupView.NONE_GROUP_ID)
	GameUtil.SetActive(newGroup, data.groupId == FormationgroupView.NONE_GROUP_ID)

	if data.groupId ~= FormationgroupView.NONE_GROUP_ID then
		local groupName = FormationGroupController.instance:getGroupName(data)

		txtName.text = groupName

		input:SetText(groupName)
		input:AddOnEndEdit(function()
			self:_onGroupEndEdit(data, input)
		end, self)
		input:AddOnValueChanged(function()
			self:_onGroupValueChanged(data, input)
		end, self)
		GameUtil.addClickHandler(input.input.gameObject, function()
			self:_onClickGroupInput(data, input)
			self:_onSelectGroup(data)
		end, self, nil)
		GameUtil.addClickHandler(btnSelect, function()
			self:_onSelectGroup(data)
		end, self)
		GameUtil.addClickHandler(btnDelete, function()
			self:_onDeleteGroup(data)
		end, self)
	else
		GameUtil.addClickHandler(btnAdd, self._onClickAddNewGroup, self)
	end
end

function FormationgroupView:_clearGroupCell(cell)
	local go = cell.gameObject
	local input = Framework.InputFieldAdapter.GetFrom(go, "info/InputC_Search")
	local btnAdd = goutil.findChild(go, "newGroup/btnClick")
	local btnSelect = goutil.findChild(go, "info/btnSelect")
	local btnDelete = goutil.findChild(go, "info/btnDelete")

	input:RemoveOnValueChanged()
	input:RemoveOnEndEdit()
	GameUtil.rmClickHandler(input.input.gameObject)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnDelete)
end

function FormationgroupView:_clearDownCell(cell)
	return
end

function FormationgroupView:_updateDownCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")

	txt.text = data.groupName

	GameUtil.addClickHandler(cell, function()
		FormationGroupController.instance:sendTabChangeGroup(self._downData.tabId, data.groupId)
		GameUtil.SetActive(self._downCon, false)
	end)
end

function FormationgroupView:_updateSuitCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "itemCon")
	local conList = {}
	local childCount = imgCon.transform.childCount

	for i = 1, childCount do
		local con = goutil.findChild(go, "itemCon/con_" .. i)

		table.insert(conList, con)
	end

	local imgCur = goutil.findChild(go, "imgCur")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local btnUpSort = goutil.findChild(go, "btnUpSort")
	local btnDelete = goutil.findChild(go, "btnDelete")
	local btnDown = goutil.findChild(go, "btnDown")
	local txtName = goutil.findChildTextComponent(go, "nameText")
	local input = Framework.InputFieldAdapter.GetFrom(go, "InputC_Search")

	input:SetCharacterLimit(inputLenLimit)
	input:RemoveOnValueChanged()
	input:RemoveOnEndEdit()
	GameUtil.rmClickHandler(input.input.gameObject)
	GameUtil.SetActive(btnDown, self._isEditorType and self._isEditing and data.tabId ~= FormationGroupController.DEFAULT_FORM_ID)
	GameUtil.SetActive(btnDelete, self._isEditorType and self._isEditing and data.tabId ~= FormationGroupController.DEFAULT_FORM_ID)
	GameUtil.SetActive(btnUpSort, self._isEditorType and self._isEditing)

	local tabName = FormationGroupController.instance:getTabName(data)

	txtName.text = tabName

	input:SetText(tabName)
	input:AddOnEndEdit(function()
		self:_onTabEndEdit(data, input)
	end, self)
	input:AddOnValueChanged(function()
		self:_onTabValueChanged(data, input)
	end, self)
	GameUtil.addClickHandler(input.input.gameObject, function()
		self:_onClickTabInput(data, input)
	end, self, nil)
	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnUpSort)
	GameUtil.rmClickHandler(btnDelete)
	GameUtil.rmClickHandler(btnDown)
	GameUtil.addClickHandler(btnDelete, function()
		self:_onClickDeleteTab(data)
	end)
	GameUtil.addClickHandler(btnDown, function()
		local list = FormationGroupModel.instance:getOtherGroupList(data.tabId)

		if list and #list > 0 then
			self._downData = data

			GameUtil.SetActive(self._downCon, true)

			local x, y, z = Framework.TransformUtil.GetPos(btnDown.transform, 0, 0, 0)

			Framework.TransformUtil.SetPos(self._downCon.transform, x, y, z)
			self._downScrollerList:reloadData(list)
		else
			TipsFacade.instance:openCommonTips("没有可以转移的分组")
		end
	end)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSelectTab(data)
	end)
	GameUtil.addClickHandler(btnUpSort, function()
		self:_onClickUpSort(data)
	end)
	GameUtil.SetActive(txtName, not self._isEditing)
	GameUtil.SetActive(input, self._isEditing)
	GameUtil.SetActive(imgSelect, data.tabId == self._curTabId)
	GameUtil.SetActive(imgCur, false)

	if not data.simpleForm then
		if not data.simpleForm.pos then
			local pos = {}
			local petIds = {}

			for i, v in ipairs(pos) do
				if v > 0 then
					table.insert(petIds, v)
				end
			end

			for i, con in ipairs(conList) do
				local petId = checknumber(petIds[i])

				if petId > 0 then
					MaterialMgr.setCellByGId(MatType.Pet, petId, con)
				else
					MaterialMgr.resetAll(con)
				end
			end
		end
	end
end

function FormationgroupView:_clearSuitCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")
	local btnUpSort = goutil.findChild(go, "btnUpSort")

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.rmClickHandler(btnUpSort)

	local childCount = imgCon.transform.childCount

	for i = 1, childCount do
		local con = goutil.findChild(go, "itemCon/con_" .. i)

		MaterialMgr.resetAll(con)
	end
end

function FormationgroupView:_getTabListData()
	local result = {}

	if self._curGroupId ~= FormationgroupView.NONE_GROUP_ID then
		local groups = FormationGroupModel.instance:getGroupList()

		for i, group in ipairs(groups or {}) do
			if group.groupId == self._curGroupId then
				for j, tab in ipairs(group.presetsForm or {}) do
					table.insert(result, tab)
				end

				break
			end
		end
	end

	ArraySort.sortOn(result, {
		"topId",
		"tabId"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})

	return result
end

function FormationgroupView:_checkName(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		-- block empty
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

function FormationgroupView:_showTips(status)
	FloatWordMgr.instance:show(lang(resultCode[status] or ""))
end

function FormationgroupView:_onTabEndEdit(tabInfo, input)
	self._editingTabInfo = nil
	self._editingTabInput = nil

	local newName = input:GetText()

	if tabInfo and tabInfo.tabName ~= newName and self:_checkName(newName) == true then
		FormationGroupController.instance:sendModifyTabName(tabInfo.tabId, newName)
	end
end

function FormationgroupView:_onGroupEndEdit(groupInfo, input)
	self._editingGroup = nil
	self._editingGroupInput = nil

	local newName = input:GetText()

	if groupInfo and groupInfo.groupName ~= newName and self:_checkName(newName) == true then
		FormationGroupController.instance:sendModifyOrAddGroup(groupInfo.groupId, newName)
	end
end

function FormationgroupView:_onClickGroupInput(groupInfo, input)
	self._editingGroup = groupInfo
	self._editingGroupInput = input
end

function FormationgroupView:_onClickTabInput(tabInfo, input)
	self._editingTabInfo = tabInfo
	self._editingTabInput = input
end

function FormationgroupView:_onClickAddNewGroup()
	FormationGroupController.instance:sendModifyOrAddGroup(nil, "")
end

function FormationgroupView:_onDeleteGroup(groupInfo)
	local groupName = FormationGroupController.instance:getGroupName(groupInfo)
	local content = langPara("确定删除分组【%s】？", groupName)

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		FormationGroupController.instance:sendDeleteGroup(groupInfo.groupId)
	end)
end

function FormationgroupView:_onSelectGroup(groupInfo)
	self:_onGroupModify(groupInfo.groupId)
end

function FormationgroupView:_onGroupValueChanged(data, input)
	local value = input:GetText()
	local arr = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #arr)

	for i = 1, count do
		result = result .. arr[i]
	end

	input:RemoveOnValueChanged()
	input:SetText(result)
	input:AddOnValueChanged(function()
		self:_onGroupValueChanged(data, input)
	end, self)
end

function FormationgroupView:_onTabValueChanged(data, input)
	local value = input:GetText()
	local arr = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #arr)

	for i = 1, count do
		result = result .. arr[i]
	end

	input:RemoveOnValueChanged()
	input:SetText(result)
	input:AddOnValueChanged(function()
		self:_onTabValueChanged(data, input)
	end, self)
end

function FormationgroupView:_onClickEditGroup()
	self._isEditing = true

	self:_refreshUI()
end

function FormationgroupView:_onClickEditGroupEnd()
	self._isEditing = false

	local isNotify = false

	if self._editingGroup and self._editingGroupInput then
		self:_onGroupEndEdit(self._editingGroup, self._editingGroupInput)

		isNotify = true
	end

	if self._editingTabInfo and self._editingTabInput then
		self:_onTabEndEdit(self._editingTabInfo, self._editingTabInput)

		isNotify = true
	end

	if not isNotify then
		self:_refreshUI()
	end
end

function FormationgroupView:_onClickDeleteTab(tabInfo)
	local tabName = FormationGroupController.instance:getTabName(tabInfo)
	local content = langPara("确定删除预设阵容【%s】？", tabName)

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		FormationGroupController.instance:sendDeleteTab(tabInfo.tabId)
	end)
end

function FormationgroupView:_onClickSelectTab(tabInfo)
	if self._isEditing then
		return
	end

	self._curTabId = self._curTabId == tabInfo.tabId and FormationgroupView.NONE_TAB_ID or tabInfo.tabId

	if self._curTabId > 0 then
		self:_onClickClose()
	end
end

function FormationgroupView:_onClickUpSort(tabInfo)
	FormationGroupController.instance:sendTopPresetsTab(tabInfo.tabId)
end

function FormationgroupView:_onCreateNewTab()
	if self._curGroupId == FormationgroupView.NONE_GROUP_ID then
		FloatWordMgr.instance:show(lang("请先创建分组"))

		return
	end

	FormationGroupController.instance:sendModifyOrAddTab(self._curGroupId, "")
end

return FormationgroupView
