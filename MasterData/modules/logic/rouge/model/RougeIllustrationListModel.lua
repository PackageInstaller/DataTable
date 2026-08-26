-- chunkname: @modules/logic/rouge/model/RougeIllustrationListModel.lua

module("modules.logic.rouge.model.RougeIllustrationListModel", package.seeall)

local RougeIllustrationListModel = class("RougeIllustrationListModel", MixScrollModel)

function RougeIllustrationListModel:initList()
	local pages = {}
	local pageDatas = RougeFavoriteConfig.instance:getIllustrationPages()

	tabletool.addValues(pages, pageDatas)

	local normalPageCount = RougeFavoriteConfig.instance:getNormalIllustrationPageCount()

	if normalPageCount > 0 then
		local splitSpaceItem = self:getSplitSpaceInfoItem()

		table.insert(pages, normalPageCount + 1, splitSpaceItem)
	end

	self:setList(pages)
end

local cellWidth = {
	480,
	660,
	1140,
	1500,
	1770,
	2103
}
local splitSpaceWidth = 300
local splitSpaceItemType = 1000

function RougeIllustrationListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	self._splitSpaceStartPosX = 0

	local hasGetSpacePos = false

	for i, mo in ipairs(list) do
		local mixCellInfo

		if mo.isSplitSpace then
			mixCellInfo = SLFramework.UGUI.MixCellInfo.New(splitSpaceItemType, splitSpaceWidth, i)
			hasGetSpacePos = true
		else
			local num = #mo

			mixCellInfo = SLFramework.UGUI.MixCellInfo.New(num, cellWidth[num], i)

			if not hasGetSpacePos then
				self._splitSpaceStartPosX = self._splitSpaceStartPosX + cellWidth[num]
			end
		end

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function RougeIllustrationListModel:getSplitSpaceInfoItem()
	self._splitSpaceItem = self._splitSpaceItem or {
		isSplitSpace = true
	}

	return self._splitSpaceItem
end

function RougeIllustrationListModel:getSplitEmptySpaceStartPosX()
	return self._splitSpaceStartPosX or 0
end

RougeIllustrationListModel.instance = RougeIllustrationListModel.New()

return RougeIllustrationListModel
