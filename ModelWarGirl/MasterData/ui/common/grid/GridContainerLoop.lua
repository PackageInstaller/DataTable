-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridContainerLoop.lua

local UIControls = UIControls
local GridContainerLoop = Class("GridContainerLoop", UIControls.ScrollViewLoopCell)

function GridContainerLoop:ctor()
	self.isShowPreviewTips = false
end

function GridContainerLoop:setObj(clientItem)
	local gridPrefab = UIControls.getGridPanelPrefab(clientItem)

	if gridPrefab ~= self.nowGridPrefab then
		self.nowGridPrefab = gridPrefab

		if self.grid then
			self.grid:destroy()
		end

		local gridType = UIControls.getGridPanelType(clientItem, "Child")

		self.grid = gridType(self, "", self.nowGridPrefab)

		self.grid:setVisible(true)
	end

	self.grid:setObj(clientItem)

	if clientItem.itemType and Const.HAVE_PREVIEW_TIPS_TYPE_DIC[clientItem.itemType] then
		self.grid.isShowPreviewTips = self.isShowPreviewTips
	end
end

return GridContainerLoop
