-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridContainerChild.lua

local UIControls = UIControls
local GridContainerChild = Class("GridContainerChild", UIControls.Child)

function GridContainerChild:ctor()
	self.gridPath = ""
	self.isShowPreviewTips = false
end

function GridContainerChild:setObj(clientItem, checkNeedConvertObject)
	self.object = clientItem

	local gridPrefab = UIControls.getGridPanelPrefab(clientItem)

	if gridPrefab ~= self.nowGridPrefab then
		self.nowGridPrefab = gridPrefab

		if self.grid then
			self.grid:destroy()
		end

		local gridType = UIControls.getGridPanelType(clientItem, "Child")

		self.grid = gridType(self, self.gridPath, self.nowGridPrefab)

		self.grid:setVisible(true)

		self.grid.mDisableWays = self.mDisableWays

		if clientItem.itemType and Const.HAVE_PREVIEW_TIPS_TYPE_DIC[clientItem.itemType] then
			self.grid.isShowPreviewTips = self.isShowPreviewTips
		end
	end

	self.grid.checkNeedConvertObject = checkNeedConvertObject

	self.grid:setObj(clientItem)
end

function GridContainerChild:flyToCommonFuncEntryPanel()
	self.grid:flyToCommonFuncEntryPanel()
end

function GridContainerChild:setTipsEnable(enable)
	self.grid.mEnableTips = enable
end

return GridContainerChild
