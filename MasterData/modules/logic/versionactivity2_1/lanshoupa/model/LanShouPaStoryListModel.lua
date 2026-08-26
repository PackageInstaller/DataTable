-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/model/LanShouPaStoryListModel.lua

module("modules.logic.versionactivity2_1.lanshoupa.model.LanShouPaStoryListModel", package.seeall)

local LanShouPaStoryListModel = class("LanShouPaStoryListModel", ListScrollModel)

function LanShouPaStoryListModel:init(actId, episodeId)
	local storyCos = Activity164Config.instance:getStoryList(actId, episodeId)
	local dataList = {}

	if storyCos then
		for index, storyCo in ipairs(storyCos) do
			local stroyMO = LanShouPaStoryMO.New()

			stroyMO:init(index, storyCo)
			table.insert(dataList, stroyMO)
		end
	end

	self:setList(dataList)
end

LanShouPaStoryListModel.instance = LanShouPaStoryListModel.New()

return LanShouPaStoryListModel
