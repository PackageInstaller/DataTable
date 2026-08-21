-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\PreviewPkgTips.lua

local ItemTips = require("UI/Common/Tips/ItemTips")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "PreviewPkgTips"
local PreviewPkgTips = Class(strClassName, ItemTips)

function PreviewPkgTips:ctor()
	self:_initUI()

	self.cells = {}
end

function PreviewPkgTips:_initUI()
	self.panelContent = UIControls.Panel(self, "BgPanel/ContentPanel")
	self.panelBlank = UIControls.Panel(self, "BgPanel/BlankPanel")
end

function PreviewPkgTips:_setObj(grid)
	PreviewPkgTips.super._setObj(self, grid)
	self.panelBlank:setVisible(false)
	self.panelContent:setVisible(true)

	for _, grid in pairs(self.cells) do
		grid:destroy()
	end

	self.cells = {}

	local awardData = ResRandClient[self.item.resData.extend_args1]

	if awardData and awardData.show_ids then
		for idx, itemId in ipairs(awardData.show_ids) do
			local pkgItem = BaseObject.GetObject(itemId, awardData.show_nums[idx])
			local itemGrid = UIControls.getGridChild(pkgItem, self, "BgPanel/ContentPanel")

			itemGrid:setVisible(true)

			itemGrid.mDisableWays = true
			itemGrid.isShowPreviewTips = true

			itemGrid:setObj(pkgItem)
			table.insert(self.cells, itemGrid)
		end
	end
end

return PreviewPkgTips
