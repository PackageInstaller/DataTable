-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseEditView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseEditView", package.seeall)

local M = class("PlayerCourseEditView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	local root = goutil.findChild(self.mainGO, "allContent")

	self._emptyGo = goutil.findChild(root, "txtEmpty")
	self._loopList = LoopListHelper.New(goutil.findChild(root, "scroll"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._btnConfirm = Astral.ButtonAdapter.Get(goutil.findChild(root, "btnSave"))
	self._btnCancel = Astral.ButtonAdapter.Get(goutil.findChild(root, "btnCancel"))
	self._btnClose = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "middle_tips_common_bg/btnClose"))

	local cellRoot = goutil.findChild(root, "top")

	self.showItems = {}

	for i = 1, 5 do
		local go = goutil.findChild(cellRoot, self._itemPrefabName .. i)
		local item = Astral.LuaComponentContainer.Add(go, self._cellCls)

		item:AddClickListener(self._onClickShowItem, self)

		self.showItems[i] = item
	end
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:initListData()

	if #self._entityInEdit == 0 then
		goutil.setActive(self._emptyGo, true)
		self:refreshShowList()
	else
		goutil.setActive(self._emptyGo, false)
		self:sortAndShowAll()
	end
end

function M:onExit()
	self._loopList:ClearCells()
end

function M:destroyUI()
	self.showItems = nil
	self._bgBlur = nil
	self._emptyGo = nil
	self._btnConfirm = nil
	self._btnCancel = nil
	self._btnClose = nil

	self._loopList:Dispose()

	self._loopList = nil
end

function M:sortAndShowAll()
	PlayerCourseUtil.sortChooseList(self._entityInShow, self._entityInEdit, self._editType)
	self:refreshShowList()
	self:refreshEditList()
end

function M:refreshShowList()
	local items = self.showItems
	local showInfo = self._entityInShow
	local showCount = #showInfo

	for i = 1, showCount do
		local info = showInfo[i]

		items[i]:showEntity(info)
	end

	for i = showCount + 1, 5 do
		items[i]:showEntity(false)
	end
end

function M:refreshEditList()
	local len = self._entityInEdit and #self._entityInEdit

	if len > 0 then
		self._loopList:SetListItemCount(len, true)
		self._loopList:RefreshAllShownItem()
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local entity = self._entityInEdit[curIndex]
	local item = self._loopList:NewListViewItem(self._itemPrefabName)
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, self._cellCls)

	shower:showEntity(entity)
	shower:showSign(entity.sortIndex)
	shower:AddClickListener(self.onClickEditItem, self)

	return item
end

function M:_onCaptureFinish()
	local downSample = 1
	local iteration = 4

	goutil.setActive(self.mainGO, true)
end

function M:initListData()
	local entityInShow = {}
	local entityInEdit = {}
	local entityInEditMap = {}
	local showData, allData = PlayerCourseModel.instance:getEditDatas(self._editType)

	for _, v in ipairs(allData) do
		local temp = self._callDataCls.buildFromDepot(v)

		temp.sortIndex = nil

		table.insert(entityInEdit, temp)

		local id = temp:getId()

		entityInEditMap[id] = temp

		for _, v in ipairs(showData) do
			if id == v:getId() then
				temp.sortIndex = v.sortIndex

				table.insert(entityInShow, temp)

				break
			end
		end
	end

	self._showInfoRaw = showData
	self._entityInShow = entityInShow
	self._entityInEdit = entityInEdit
	self._entityInEditMap = entityInEditMap
end

function M:removeFromShowList(id)
	for k, v in ipairs(self._entityInShow) do
		if v:getId() == id then
			table.remove(self._entityInShow, k)

			self._entityInEditMap[id].sortIndex = nil

			break
		end
	end
end

function M:addToShowList(entity)
	table.insert(self._entityInShow, entity)

	for i, v in ipairs(self._entityInShow) do
		v.sortIndex = i
	end
end

function M:isChanged()
	local raw = self._showInfoRaw
	local now = self._entityInShow
	local lenRaw = table.nums(raw)

	if not raw or not now then
		return false
	end

	if lenRaw ~= #now then
		return true
	end

	for i, v in ipairs(now) do
		if v:getId() ~= raw[i]:getId() then
			return true
		end
	end

	return false
end

function M:getSortIndex()
	self._sortIndex = self._sortIndex + 1

	return self._sortIndex
end

function M:_onClickShowItem(id)
	self:removeFromShowList(id)
	self:sortAndShowAll()
end

function M:onClickEditItem(id)
	local entity = self._entityInEditMap[id]

	if entity.sortIndex then
		self:removeFromShowList(id)
		self:sortAndShowAll()
	elseif #self._entityInShow < 5 then
		self:addToShowList(entity)
		self:sortAndShowAll()
	else
		FloatWordMgr.instance:show(lang("数量已满"))
	end
end

function M:_onClickClose()
	if self:isChanged() then
		local content = "确认不保存就退出编辑吗？"
		local dialog = Dialog.showMessage(lang("tip_title"), content)

		dialog:setConfirmListener(function()
			ViewMgr.instance:close(self._viewName)
		end, self)
	else
		ViewMgr.instance:close(self._viewName)
	end
end

function M:_onClickConfirm()
	if self:isChanged() then
		local ids = {}

		for _, v in ipairs(self._entityInShow) do
			table.insert(ids, v:getId())
		end

		PlayerCourseAgent.instance:sendSetDisplayContentRequest(self._editType, ids)
	end

	ViewMgr.instance:close(self._viewName)
end

return M
