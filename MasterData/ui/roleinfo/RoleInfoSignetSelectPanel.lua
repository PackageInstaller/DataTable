-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoSignetSelectPanel.lua

local ResSignet = require("ClientData/ResSignet")
local HorizontalFilterPanel = require("UI/Common/HorizontalFilterPanel")
local RoleInfoSignetSelectPanel = Class("RoleInfoSignetSelectPanel", UIControls.Panel)

function RoleInfoSignetSelectPanel:ctor()
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnFuncPanel/BtnSave")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm)

	self.btnCancel = UIControls.Button(self, self.mPath .. "/BtnFuncPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onClickBtnCancel)

	self.horizontalFilter = HorizontalFilterPanel(self.mWindow, self.mPath .. "/BtnFuncPanel/ListSelectPanel")
	self.slotHorizontalFilterCb = Slot(self.horizontalFiterCb, self)
	self.scrollViewLoop = UIControls.ScrollViewLoopV(self, self.mPath .. "/CardPanel", 0, self.onCellChanged)
	self.slotOnClickSignetCell = Slot(self.onClickSignetCell, self)
	self.btnListType = UIControls.Button(self, self.mPath .. "/BtnFuncPanel/BtnListType")

	self.btnListType:addEventClick(self.onClickBtnListType)

	self.imgArrow = UIControls.Image(self, self.mPath .. "/BtnFuncPanel/BtnListType/ImgArrow")
end

function RoleInfoSignetSelectPanel:init(cancelCb, confirmCb, changeCb)
	self.cancelCb = cancelCb
	self.confirmCb = confirmCb
	self.changeCb = changeCb
end

function RoleInfoSignetSelectPanel:setData(maxSelectNum, selectDataList)
	self.maxSelectNum = maxSelectNum
	self.selectDataList = selectDataList
	self.selectIdList = {}

	for i = 1, #self.selectDataList do
		table.insert(self.selectIdList, self.selectDataList[i].id)
	end

	self.checkTimeUp = false

	self.horizontalFilter:init(UIConst.SIGNET_HORIZONTAL_FILTER_MAP, self.slotHorizontalFilterCb, "System/PlayerInfor/TabAchievementListS")
	self:refreshBtnListType()
end

function RoleInfoSignetSelectPanel:changeData(selectDataList)
	self.selectDataList = selectDataList
	self.selectIdList = {}

	for i = 1, #self.selectDataList do
		table.insert(self.selectIdList, self.selectDataList[i].id)
	end

	self:refreshCellListShow(true)
end

function RoleInfoSignetSelectPanel:horizontalFiterCb(type)
	self.horizontalFilterType = type

	self:refreshDataList()
end

function RoleInfoSignetSelectPanel:refreshDataList()
	if not self.horizontalFilterType then
		return
	end

	local groupList = CurAvatar:getSignetConfigGroupListByType(self.horizontalFilterType)

	self.signetDataList = {}

	for _, group in ipairs(groupList) do
		local signetId, checkHave = CurAvatar:getShowSignetIdByGroup(group)

		if checkHave then
			local signetData = CurAvatar:getSignetData(signetId)

			table.insert(self.signetDataList, signetData)
		end
	end

	self.slotSortSignetByTime = self.slotSortSignetByTime or Slot(self.sortSignetByTime, self)

	table.sort(self.signetDataList, self.slotSortSignetByTime)
	self:refreshCellListShow()
end

function RoleInfoSignetSelectPanel:sortSignetByTime(a, b)
	if self.checkTimeUp then
		return a.achieve_time < b.achieve_time
	else
		return a.achieve_time > b.achieve_time
	end
end

function RoleInfoSignetSelectPanel:refreshCellListShow(checkKeepPos)
	local num = self.signetDataList and #self.signetDataList or 0

	if checkKeepPos then
		self.scrollViewLoop:setTotalCount(num, nil)
	else
		self.scrollViewLoop:setTotalCount(num, 1)
	end
end

function RoleInfoSignetSelectPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.SignetCellLoop(sender, "System/HandBook/AchievementListItem", newIdx)

		targetCell:init(self.slotOnClickSignetCell)
	end

	local signetData = self.signetDataList[newIdx]
	local signetId = signetData.id

	targetCell:setData(signetId, signetData)

	local checkSelect = utils.getIndexByValue(self.selectIdList, signetId) > 0

	targetCell:setSelect(checkSelect)
end

function RoleInfoSignetSelectPanel:onClickSignetCell(cell)
	local idx = utils.getIndexByValue(self.selectIdList, cell.signetId)

	if idx > 0 then
		table.remove(self.selectDataList, idx)
		table.remove(self.selectIdList, idx)
		cell:setSelect(false)
		self.changeCb(self.selectDataList)
	elseif #self.selectDataList >= self.maxSelectNum then
		MsgManager.notice(Lang.get(83185))
	else
		table.insert(self.selectIdList, cell.signetId)
		table.insert(self.selectDataList, cell.signetData)
		cell:setSelect(true)
		self.changeCb(self.selectDataList)
	end
end

function RoleInfoSignetSelectPanel:refreshBtnListType()
	self.imgArrow:setImage("Atlas/CommonAtlas/OtherAtlas", self.checkTimeUp and "IconBtnLevelUp" or "IconBtnLevelDown")
end

function RoleInfoSignetSelectPanel:onClickBtnListType()
	self.checkTimeUp = not self.checkTimeUp

	self:refreshBtnListType()
	self:refreshDataList()
end

function RoleInfoSignetSelectPanel:onClickBtnCancel()
	self.cancelCb()
end

function RoleInfoSignetSelectPanel:onClickBtnConfirm()
	self.confirmCb()
end

return RoleInfoSignetSelectPanel
