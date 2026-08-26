-- chunkname: @modules/logic/handbook/model/HandbookCGTripleListModel.lua

module("modules.logic.handbook.model.HandbookCGTripleListModel", package.seeall)

local HandbookCGTripleListModel = class("HandbookCGTripleListModel", MixScrollModel)

function HandbookCGTripleListModel:setCGList(list)
	local cgType = list.cgType
	local cgList = list.cgList
	local moList = {}
	local prevStoryChapterId, tripleList

	for i, config in ipairs(cgList) do
		if HandbookModel.instance:isCGUnlock(config.id) then
			local storyChapterId = config.storyChapterId

			tripleList = tripleList or {}

			if not prevStoryChapterId or prevStoryChapterId ~= storyChapterId then
				if #tripleList > 0 then
					local handbookCGTripleMO = HandbookCGTripleMO.New()

					handbookCGTripleMO:init({
						cgList = tripleList,
						cgType = cgType
					})
					table.insert(moList, handbookCGTripleMO)

					tripleList = {}
				end

				local handbookCGTripleMO = HandbookCGTripleMO.New()

				handbookCGTripleMO:init({
					isTitle = true,
					storyChapterId = storyChapterId
				})
				table.insert(moList, handbookCGTripleMO)
			end

			if config.preCgId == 0 then
				table.insert(tripleList, config)
			end

			prevStoryChapterId = storyChapterId
		end

		if tripleList and #tripleList >= 3 or i == #cgList and tripleList and #tripleList > 0 then
			local handbookCGTripleMO = HandbookCGTripleMO.New()

			handbookCGTripleMO:init({
				cgList = tripleList,
				cgType = cgType
			})
			table.insert(moList, handbookCGTripleMO)

			tripleList = nil
		end
	end

	self:setList(moList)
end

function HandbookCGTripleListModel:getInfoList(scrollGO)
	local mixCellInfos = {}

	for _, mo in ipairs(self:getList()) do
		local isTitle = mo.isTitle
		local type = isTitle and 0 or 1
		local lineWidth = isTitle and 90 or 298
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(type, lineWidth, nil)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

HandbookCGTripleListModel.instance = HandbookCGTripleListModel.New()

return HandbookCGTripleListModel
