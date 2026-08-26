-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_IllustrationListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_IllustrationListModel", package.seeall)

local Rouge2_IllustrationListModel = class("Rouge2_IllustrationListModel", MixScrollModel)

function Rouge2_IllustrationListModel:initList()
	local pages = {}
	local pageDatas = Rouge2_OutSideConfig.instance:getIllustrationPages()

	tabletool.addValues(pages, pageDatas)
	self:setList(pages)
end

local cellWidth = {
	480,
	660,
	1140,
	2100,
	2300,
	2550
}

function Rouge2_IllustrationListModel:getInfoList(scrollGO)
	self.scrollGO = scrollGO

	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo
		local num = #mo

		table.insert(mixCellInfos, (SLFramework.UGUI.MixCellInfo.New(num, cellWidth[num], i)))
	end

	return mixCellInfos
end

function Rouge2_IllustrationListModel:getScrollGO()
	return self.scrollGO
end

Rouge2_IllustrationListModel.instance = Rouge2_IllustrationListModel.New()

return Rouge2_IllustrationListModel
