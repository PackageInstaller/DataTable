-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetShowAwardDlg.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "PetShowAwardDlg"
local PetShowAwardDlg = Class(strClassName, UIControls.Window)
local autoFly, target

function PetShowAwardDlg:ctor()
	self.gridTargets = {}
	self.disableFly = {}

	self:initUI()
end

function PetShowAwardDlg:onOpen()
	PetShowAwardDlg.super.onOpen(self)

	self.autoFly = autoFly
	self.target = target
	autoFly = nil
	target = nil
end

function PetShowAwardDlg:initUI()
	self.awardGrids = {}
	self.textTitle = UIControls.Label(self, "Bg/TxtTitle")
	self.gridContainers = {}
end

function PetShowAwardDlg:onShow(petItems, showTitle, closeCB)
	self.closeCB = closeCB

	if showTitle then
		self.textTitle:setText(showTitle)
	end

	local clientItems = {}

	for i, item in ipairs(ClientUtils.getCommonPetItemsById(petItems)) do
		local transItem

		if item.transId and item.transNum then
			transItem = BaseObject.GetObject(item.transId)
		end

		table.insert(clientItems, {
			item,
			transItem
		})
	end

	if #clientItems <= 0 then
		self:setVisible(false, nil, true)
	else
		for index, item in ipairs(clientItems) do
			local nameGridContainer = UIControls.GridNameContainerChild(self, "Bg/AwardList/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)

			nameGridContainer:setObj(item[1])

			if item[2] then
				nameGridContainer:playTransItemEfx(item[2])
			end

			nameGridContainer.grid.mDisableWays = true

			table.insert(self.awardGrids, nameGridContainer.grid)
			table.insert(self.gridContainers, nameGridContainer)
		end
	end

	CurAvatar:resetOpenBoxDlg()
end

function PetShowAwardDlg.setCustomizeFlyConfig(mustAutoFly, targetUIObj)
	autoFly = mustAutoFly
	target = targetUIObj
end

function PetShowAwardDlg:setSpecialCustomizeFlyConfig(id, targetUIObj)
	self.gridTargets[id] = targetUIObj
end

function PetShowAwardDlg:setFlyEndCB(endCB)
	self.endCB = endCB
end

function PetShowAwardDlg:clearSpecialConfig()
	self.gridTargets = {}
end

function PetShowAwardDlg:disableFlyConfig(id, state)
	self.disableFly[id] = state
end

function PetShowAwardDlg:onClose(...)
	for i, v in pairs(self.gridContainers or {}) do
		v:clearCoroutine()
	end

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

	local petLevelUpDlg = UIManager.tryGetUI("petLevelUpDlg")

	if petLevelUpDlg then
		petLevelUpDlg:setVisible(true)
	end

	PetShowAwardDlg.super.onClose(self)
end

return PetShowAwardDlg
