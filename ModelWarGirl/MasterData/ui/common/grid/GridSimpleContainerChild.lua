-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridSimpleContainerChild.lua

local UIControls = UIControls
local ITEM_GRID_TYPE_CONFIG = {
	[Const.ITEM_TYPE_ITEM] = {
		UIControls.ItemGridChild,
		"System/Common/Grid/GridMaterialItem"
	},
	[Const.ITEM_TYPE_ARTIFACT] = {
		UIControls.ArtifactGridChild,
		"System/Common/Grid/GridBadgeSmallItem"
	},
	[Const.ITEM_TYPE_RELIC] = {
		UIControls.RelicGridChild,
		"System/Common/Grid/GridRelicSmallItem"
	},
	[Const.ITEM_TYPE_HERO] = {
		UIControls.GridSimpleHeroChild,
		"System/Common/Grid/GridHeroTeam"
	},
	[Const.ITEM_TYPE_SKIN] = {
		UIControls.SkinGridChild,
		"System/Common/Grid/GridSkinItemSmall"
	}
}
local GridSimpleContainerChild = Class("GridSimpleContainerChild", UIControls.Child)

function GridSimpleContainerChild:ctor()
	self.gridPath = ""
	self.mEnableTips = true
	self.mEnableHoldTips = false
	self.mTipsConfig = nil
	self.mEventClick = nil
	self.mEventHold = nil
	self.mEventHoldPointerUp = nil
	self.mDisableWays = nil
end

function GridSimpleContainerChild:setObj(clientItem)
	self.object = clientItem

	local gridConfig = ITEM_GRID_TYPE_CONFIG[clientItem.itemType] or ITEM_GRID_TYPE_CONFIG[Const.ITEM_TYPE_ITEM]

	if gridConfig[1] ~= self.nowGridClass then
		self.nowGridClass = gridConfig[1]

		if self.grid then
			self.grid:destroy()
		end

		self.grid = self.nowGridClass(self, self.gridPath, gridConfig[2])
		self.grid.mEnableTips = self.mEnableTips
		self.grid.mEnableHoldTips = self.mEnableHoldTips
		self.grid.mTipsConfig = self.mTipsConfig
		self.grid.mEventClick = self.mEventClick
		self.grid.mEventHold = self.mEventHold
		self.grid.mEventHoldPointerUp = self.mEventHoldPointerUp
		self.grid.mDisableWays = self.mDisableWays

		self.grid:setVisible(true)

		if clientItem.itemType and Const.HAVE_PREVIEW_TIPS_TYPE_DIC[clientItem.itemType] then
			self.grid.isShowPreviewTips = self.isShowPreviewTips
		end
	end

	self.grid:setObj(clientItem)
	self:postProcessGrid()
end

function GridSimpleContainerChild:postProcessGrid()
	if self.nowGridClass == Const.ITEM_TYPE_ARTIFACT then
		-- block empty
	elseif self.nowGridClass == Const.ITEM_TYPE_RELIC then
		-- block empty
	end
end

function GridSimpleContainerChild:flyToCommonFuncEntryPanel()
	self.grid:flyToCommonFuncEntryPanel()
end

return GridSimpleContainerChild
