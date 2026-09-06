-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationsetdefenseLeftView.lua

module("logic.extensions.formation.view.FormationsetdefenseLeftView", package.seeall)

local FormationsetdefenseLeftView = class("FormationsetdefenseLeftView", ViewComponent)

FormationsetdefenseLeftView.NONE_GROUP_ID = -1
FormationsetdefenseLeftView.NONE_TAB_ID = -1
FormationsetdefenseLeftView.TYPE_NORMAL = 0
FormationsetdefenseLeftView.TYPE_EDITOR = 1

function FormationsetdefenseLeftView:buildUI()
	FormationsetdefenseLeftView.super.buildUI(self)

	self._groupTabelView = self:getGo("leftroot/groupRoot/tableview")
	self._groupTableCell = self:getGo("leftroot/groupRoot/tablecell")
	self._suitTableView = self:getGo("leftroot/suitRoot/tableview")
	self._suitTableCell = self:getGo("leftroot/suitRoot/tablecell")
	self._downCon = self:getGo("leftroot/downCon")
	self._scroll = self:getGo("leftroot/downCon/scroll/ScrollView")
	self._downcell = self:getGo("leftroot/downCon/cell")
	self._curPetCon = self:getGo("leftroot/curPetCon")
	self._txtRecommen = self:getTxt("leftroot/txtRecommen")
	self._suitDesc = self:getTxt("leftroot/attrRoot/txtDesc")
	self._suitIcon = self:getGo("leftroot/attrRoot/suitIcon")
	self._groupTableList = ScrollerList.create(self._groupTabelView, self._groupTableCell, GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._suitScrollerList = ScrollerList.create(self._suitTableView, self._suitTableCell, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))
end

function FormationsetdefenseLeftView:bindEvents()
	FormationsetdefenseLeftView.super.bindEvents(self)
end

function FormationsetdefenseLeftView:unbindEvents()
	FormationsetdefenseLeftView.super.unbindEvents(self)
end

function FormationsetdefenseLeftView:onExit()
	FormationsetdefenseLeftView.super.onExit()
end

function FormationsetdefenseLeftView:onEnter()
	FormationsetdefenseLeftView.super.onEnter()
	self.addGEvent(self, GlobalNotify.OneKeySetDefenseSelectModifyTab, self._onOneKeySetDefenseSelectModifyTab, self)
	self.addGEvent(self, GlobalNotify.FormationGroupInfoUpdate, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.OneKeySetDefenseRefreshView, self.refreshRightView, self)

	local tabId = FormationGroupModel.instance:getCurNewTabId()

	self._curGroupId = FormationsetdefenseLeftView.NONE_GROUP_ID
	self._curTabId = FormationsetdefenseLeftView.NONE_TAB_ID

	local tabInfo = FormationGroupModel.instance:getTabInfo(self._curTabId)

	if tabInfo then
		self._curGroupId = tabInfo.groupId
	end

	FormationGroupController.instance:sendGetInfoOnce()
	self:_refreshUI()
end

function FormationsetdefenseLeftView:refreshAllBtns()
	return
end

function FormationsetdefenseLeftView:_refreshUI()
	self:refreshGroupView()
	self:refreshRightView()
	self:refreshAllBtns()
end

function FormationsetdefenseLeftView:refreshRightView()
	self._tabList = self:_getTabListData()
	self._usePetIdMap = self:_getAllUsePetIdMap()

	self._suitScrollerList:reloadData(self._tabList)
end

function FormationsetdefenseLeftView:_getSorttingGroup()
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

function FormationsetdefenseLeftView:refreshGroupView()
	self._groupList = self:_getSorttingGroup()

	local len = #self._groupList

	if self._curGroupId == FormationsetdefenseLeftView.NONE_GROUP_ID and len > 0 then
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
			self._curGroupId = len > 0 and self._groupList[1].groupId or FormationsetdefenseLeftView.NONE_GROUP_ID
		end
	end

	self._groupTableList:reloadData(self._groupList)
end

function FormationsetdefenseLeftView:_updateGroupCell(view, cell, data, tag)
	local go = cell.gameObject
	local info = goutil.findChild(go, "info")
	local txtName = goutil.findChildTextComponent(go, "info/nameText")
	local btnSelect = goutil.findChild(go, "info/btnSelect")
	local imgSelect = goutil.findChild(go, "info/imgSelect")

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.SetActive(imgSelect, self._curGroupId == data.groupId)
	GameUtil.SetActive(info, data.groupId ~= FormationsetdefenseLeftView.NONE_GROUP_ID)

	if data.groupId ~= FormationsetdefenseLeftView.NONE_GROUP_ID then
		txtName.text = FormationGroupController.instance:getGroupName(data)

		GameUtil.addClickHandler(btnSelect, function()
			self:_onSelectGroup(data)
		end, self)
	end
end

function FormationsetdefenseLeftView:_clearGroupCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "info/btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

function FormationsetdefenseLeftView:_clearDownCell(cell)
	return
end

function FormationsetdefenseLeftView:_updateDownCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")

	txt.text = data.groupName

	GameUtil.addClickHandler(cell, function()
		return
	end)
end

function FormationsetdefenseLeftView:_updateSuitCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "itemCon")
	local conList = {}
	local maskList = {}
	local childCount = imgCon.transform.childCount

	for i = 1, childCount do
		local con = goutil.findChild(go, "itemCon/con_" .. i .. "/con")
		local mask = goutil.findChild(go, "itemCon/con_" .. i .. "/mask")

		table.insert(conList, con)
		table.insert(maskList, mask)
	end

	local imgSelect = goutil.findChild(go, "imgSelect")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local txtName = goutil.findChildTextComponent(go, "nameText")

	txtName.text = FormationGroupController.instance:getTabName(data)

	GameUtil.rmClickHandler(btnSelect)
	GameUtil.addClickHandler(btnSelect, function()
		self:_onClickSelectTab(data)
	end)
	GameUtil.SetActive(imgSelect, data.tabId == self._curTabId)

	if not data.simpleForm then
		local form = {}

		if not form.pos then
			local pos = {}
			local petIds = {}
			local positions = {}
			local isEmpty = true

			for i, v in ipairs(pos) do
				if v > 0 then
					table.insert(petIds, v)
					table.insert(positions, {
						pos = i,
						petId = v
					})

					isEmpty = false
				end
			end

			for i, con in ipairs(conList) do
				local petId = checknumber(petIds[i])

				if petId > 0 then
					MaterialMgr.setCellByGId(MatType.Pet, petId, con)
				else
					MaterialMgr.resetAll(con)
				end

				goutil.setActive(maskList[i], self._usePetIdMap[petId])
			end
		end
	end
end

function FormationsetdefenseLeftView:_clearSuitCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)

	local childCount = imgCon.transform.childCount

	for i = 1, childCount do
		local con = goutil.findChild(go, "itemCon/con_" .. i)

		MaterialMgr.resetAll(con)
	end
end

function FormationsetdefenseLeftView:_getTabListData()
	local result = {}

	if self._curGroupId ~= FormationsetdefenseLeftView.NONE_GROUP_ID then
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

function FormationsetdefenseLeftView:_onSelectGroup(groupInfo)
	self:_onGroupModify(groupInfo.groupId)
end

function FormationsetdefenseLeftView:_onClickSelectTab(tabInfo)
	if self._curTabId == tabInfo.tabId then
		return
	end

	self._curTabId = tabInfo.tabId

	self._suitScrollerList:refresh()

	if self._curTabId > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSelectPrefabTab, tabInfo)
	end
end

function FormationsetdefenseLeftView:_onOneKeySetDefenseSelectModifyTab()
	self._curTabId = FormationsetdefenseLeftView.NONE_TAB_ID

	self:refreshRightView()
end

function FormationsetdefenseLeftView:_onGroupModify(modifyGroupId)
	if self._curGroupId ~= modifyGroupId then
		self._curTabId = FormationsetdefenseLeftView.NONE_GROUP_ID
	end

	self._curGroupId = modifyGroupId

	self:_refreshUI()
end

function FormationsetdefenseLeftView:_getAllUsePetIdMap()
	local map = {}
	local tabType = FormationSetDefenseModel.instance:getCurrIndex()

	if tabType then
		local positionsList = FormationSetDefenseModel.instance:getDefenseFmtPositions(tabType)

		if positionsList then
			for _, v in ipairs(positionsList) do
				for _, petId in ipairs(v.formationMo:GetPositions()) do
					if petId > 0 then
						map[petId] = true
					end
				end
			end
		end
	end

	return map
end

return FormationsetdefenseLeftView
