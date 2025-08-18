-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\MailResultDlg.lua

local strClassName = "MailResultDlg"
local MailResultDlg = Class(strClassName, UIControls.Window)

function MailResultDlg:ctor(...)
	self:initUI()
end

function MailResultDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.gridListPath = "RewardList"
	self.grids = {}
end

function MailResultDlg:onShow(attrs, items, heros, equip, artifact)
	local clientItems = {}

	for _, item in pairs(ClientUtils.getAttrItems(attrs)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonItems(items)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonEquips(equip)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(artifact)) do
		table.insert(clientItems, item)
	end

	self:showAwardsMultiPages(clientItems)
end

function MailResultDlg:setMailAwards(items, equips, artifacts)
	local objList = {}

	for _, item in ipairs(items) do
		local fakeItem = BaseObject.GetObject(item.id, item.num)

		if not fakeItem.resData or fakeItem.resData.hide_in_mail ~= 1 then
			table.insert(objList, fakeItem)
		end
	end

	for _, item in pairs(ClientUtils.getCommonEquips(equips)) do
		table.insert(objList, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(artifacts)) do
		table.insert(objList, item)
	end

	self:showAwardsMultiPages(objList)
end

local MAX_SHOW_NUM = 7

function MailResultDlg:showAwardsMultiPages(objList)
	for i = 1, MAX_SHOW_NUM do
		local obj = objList[i]

		if obj then
			local grid = self.grids[i]

			if grid == nil then
				grid = UIControls.GridNameContainerChild(self, self.gridListPath, "System/Common/Grid/GridAwardGetHolder", 0, 0, true)
				grid.mDisableWays = true
				self.grids[i] = grid
			end

			grid:setObj(obj)
		else
			local grid = self.grids[i]

			if grid then
				grid:setVisible(false)
			end
		end
	end

	if #objList > MAX_SHOW_NUM then
		self.nextItems = {}

		for i = MAX_SHOW_NUM + 1, #objList do
			table.insert(self.nextItems, objList[i])
		end
	end
end

function MailResultDlg:onClose()
	for _, grid in ipairs(self.grids) do
		if grid:getVisible() and grid.grid and grid.grid.flyToCommonFuncEntryPanel then
			grid.grid:flyToCommonFuncEntryPanel()
		end
	end

	MailResultDlg.super.onClose(self)

	if self.nextItems and #self.nextItems > 0 then
		local dlg = UIManager.getUI("mailResultDlg", true)

		dlg:showAwardsMultiPages(self.nextItems)
	end
end

function MailResultDlg:_onClickClose(...)
	self:setVisible(false)
end

return MailResultDlg
