-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Signet\\SignetMainDlg.lua

local ResSignet = require("ClientData/ResSignet")
local HorizontalFilterPanel = require("UI/Common/HorizontalFilterPanel")
local VerticalFilterPanel = require("UI/Common/VerticalFilterPanel")
local SignetMainDlg = Class("SignetMainDlg", UIControls.Window)

function SignetMainDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnEdit = UIControls.Button(self, "MainInfoPanel/ListFunPanel/BtnEdit")

	self.btnEdit:addEventClick(self.onClickBtnEdit)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.horizontalFilter = HorizontalFilterPanel(self, "ListTab")
	self.slotHorizontalFilterCb = Slot(self.horizontalFilterCb, self)
	self.verticalFilter = VerticalFilterPanel(self, "MainInfoPanel")
	self.scrollViewLoop = UIControls.ScrollViewLoopV(self, "MainInfoPanel/AchievementList", 0, self.onCellChange)
	self.slotVerticalFilterCb = Slot(self.verticalFilterCb, self)
	self.slotOnClickSignetCell = Slot(self.onClickSignetCell, self)
	self.slotTimerCb = Slot(self.timerCb, self)
end

function SignetMainDlg:onOpen()
	SignetMainDlg.super.onOpen(self)

	self.checkPlayNewEfx = false

	self:clearTimer()

	self.timer = Timer.New(self.slotTimerCb, 0.5)

	self.timer:Start()
	self.horizontalFilter:init(UIConst.SIGNET_HORIZONTAL_FILTER_MAP, self.slotHorizontalFilterCb, "System/HandBook/TabAchievementList")
	self.verticalFilter:init(UIConst.SIGNET_VERTICAL_FILTER_MAP, self.slotVerticalFilterCb)
	self:refreshTabRedDot()
	self.btnEdit:setVisible(true)
end

function SignetMainDlg:onClose()
	SignetMainDlg.super.onClose(self)

	CurAvatar.showPlayerTipsCb = nil
end

function SignetMainDlg:destroy()
	SignetMainDlg.super.destroy(self)
	self:clearTimer()
end

function SignetMainDlg:clearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function SignetMainDlg:timerCb()
	self.checkPlayNewEfx = true
	self.timer = nil
end

function SignetMainDlg:horizontalFilterCb(type)
	self.horizontalFilterType = type

	self:refreshDataList()
end

function SignetMainDlg:verticalFilterCb(type)
	self.verticalFilterType = type

	self:refreshDataList()
end

function SignetMainDlg:scrollViewLoopValueChangeCb()
	self.checkPlayNewEfx = true
end

function SignetMainDlg:refreshDataList()
	if not self.horizontalFilterType or not self.verticalFilterType then
		return
	end

	local groupList = CurAvatar:getSignetConfigGroupListByType(self.horizontalFilterType)

	self.groupList = {}

	if self.verticalFilterType == "all" then
		for _, group in ipairs(groupList) do
			table.insert(self.groupList, group)
		end
	elseif self.verticalFilterType == "have" then
		self.group2TimeDic = {}

		for _, group in ipairs(groupList) do
			local signetId, checkHave = CurAvatar:getShowSignetIdByGroup(group)

			if checkHave then
				table.insert(self.groupList, group)

				local signetData = CurAvatar:getSignetData(signetId)

				self.group2TimeDic[group] = signetData.achieve_time
			end
		end

		if #self.groupList > 0 then
			self.slotSortHaveGroup = self.slotSortHaveGroup or Slot(self.sortHaveGroup, self)

			table.sort(self.groupList, self.slotSortHaveGroup)
		end
	elseif self.verticalFilterType == "noHave" then
		for _, group in ipairs(groupList) do
			local signetId, checkHave = CurAvatar:getShowSignetIdByGroup(group)

			if not checkHave then
				table.insert(self.groupList, group)
			end
		end
	end

	local num = #self.groupList

	self.scrollViewLoop:setTotalCount(num)
end

function SignetMainDlg:sortHaveGroup(a, b)
	return self.group2TimeDic[b] < self.group2TimeDic[a]
end

function SignetMainDlg:onCellChange(sender, cell, idx)
	if cell == nil then
		cell = UIControls.SignetCellLoop(sender, "System/HandBook/AchievementListItem", idx)

		cell:init(self.slotOnClickSignetCell)
	end

	local group = self.groupList[idx]
	local signetId, checkHave = CurAvatar:getShowSignetIdByGroup(group)
	local signetData = CurAvatar:getSignetData(signetId)

	cell:setData(signetId, signetData)

	local checkNew = CurAvatar:checkSignetGroupRedDot(group)

	cell:setRedDot(checkNew)

	local checkShowEffect = not self.checkPlayNewEfx and checkNew

	cell:setEfxNew(checkShowEffect)
end

function SignetMainDlg:onClickSignetCell(cell)
	if CurAvatar:checkSignetGroupRedDot(cell.group) then
		cell:setRedDot(false)
		CurAvatar:lookSignetGroup(cell.group)
		self:refreshTabRedDot()
	end

	local ui = UIManager.getUI("signetInfoDlg", true)

	ui:setData(cell.signetId, cell.signetData)
end

function SignetMainDlg:refreshTabRedDot()
	for _, filter in ipairs(UIConst.SIGNET_HORIZONTAL_FILTER_MAP) do
		local check = CurAvatar:checkSignetTypeRedDot(filter.name)

		self.horizontalFilter:setRedDot(filter.name, check)
	end
end

function SignetMainDlg:hideBtnEdit()
	self.btnEdit:setVisible(false)
end

function SignetMainDlg:onClickBtnClose()
	self:setVisible(false)
end

function SignetMainDlg:onClickBtnEdit()
	self.showTipCb = self.showTipCb or function()
		local ui = UIManager.tryGetUI("roleInfoPersonalDlg")

		if ui then
			ui:showTab("Signet")
			ui:hideSignetPanelBtnAll()
		end
	end

	CurAvatar:showPlayerTips(CurAvatar.uid, self, true, nil, self.showTipCb)
end

function SignetMainDlg:onClickBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(413)
end

return SignetMainDlg
