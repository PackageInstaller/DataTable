-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonBonusDlg.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "CommonBonusDlg"
local CommonBonusDlg = Class(strClassName, UIControls.Window)
local autoFly, target

function CommonBonusDlg:ctor()
	self.gridTargets = {}
	self.disableFly = {}

	self:initUI()
end

function CommonBonusDlg:onOpen()
	CommonBonusDlg.super.onOpen(self)

	self.autoFly = autoFly
	self.target = target
	autoFly = nil
	target = nil
end

function CommonBonusDlg:initUI()
	self.awardGrids = {}
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.sizeLayout = UIControls.Panel(self, "Bg/AwardList")
end

function CommonBonusDlg:onShow(notifyType, attrs, items, heros, equip, artifact, relic, showTitle, closeCB, openCb)
	self.closeCB = closeCB

	if showTitle then
		self.textTitle:setText(showTitle)
	end

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

	if relic then
		for _, item in pairs(ClientUtils.getCommonRelicsById(relic)) do
			table.insert(clientItems, item)
		end
	end

	if #clientItems <= 0 then
		self:setVisible(false, nil, true)
	else
		for index, item in ipairs(clientItems) do
			local nameGridContainer = UIControls.GridNameContainerChild(self, "Bg/AwardList/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)

			nameGridContainer:setObj(item)

			nameGridContainer.grid.mDisableWays = true

			table.insert(self.awardGrids, nameGridContainer.grid)
		end
	end

	CurAvatar:resetOpenBoxDlg()

	if openCb then
		openCb()
	end
end

function CommonBonusDlg.setCustomizeFlyConfig(mustAutoFly, targetUIObj)
	autoFly = mustAutoFly
	target = targetUIObj
end

function CommonBonusDlg:setSpecialCustomizeFlyConfig(id, targetUIObj)
	self.gridTargets[id] = targetUIObj
end

function CommonBonusDlg:setFlyEndCB(endCB)
	self.endCB = endCB
end

function CommonBonusDlg:clearSpecialConfig()
	self.gridTargets = {}
end

function CommonBonusDlg:disableFlyConfig(id, state)
	self.disableFly[id] = state
end

function CommonBonusDlg:onClose(...)
	local startObj, itemId, itemNum, itemData

	for _, grid in ipairs(self.awardGrids) do
		itemData = grid.mParent.object

		if itemData and itemData.id and itemData.num then
			startObj = grid
			itemId = itemData.id
			itemNum = itemData.num

			if not self.disableFly[itemId] then
				if self.gridTargets[itemId] then
					FlyIconUtils.setFlyUItoUI(startObj, self.gridTargets[itemId], itemId, itemNum, nil, self.endCB)
				elseif not self.autoFly then
					grid:flyToCommonFuncEntryPanel()
				elseif self.target then
					FlyIconUtils.setFlyUItoUI(startObj, self.target, itemId, itemNum)
				end
			end
		elseif not self.autoFly then
			grid:flyToCommonFuncEntryPanel()
		elseif self.target then
			FlyIconUtils.setFlyUItoUI(startObj, self.target)
		end
	end

	self.autoFly = nil
	self.target = nil
	self.endCB = nil

	if self.closeCB then
		self.closeCB()
	end

	CommonBonusDlg.super.onClose(self)
end

return CommonBonusDlg
