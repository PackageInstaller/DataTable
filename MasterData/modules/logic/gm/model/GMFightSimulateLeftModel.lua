-- chunkname: @modules/logic/gm/model/GMFightSimulateLeftModel.lua

module("modules.logic.gm.model.GMFightSimulateLeftModel", package.seeall)

local GMFightSimulateLeftModel = class("GMFightSimulateLeftModel", ListScrollModel)

function GMFightSimulateLeftModel:onOpen()
	local list = {}

	for _, chapterCO in ipairs(lua_chapter.configList) do
		if chapterCO.type == DungeonEnum.ChapterType.Simulate then
			table.insert(list, chapterCO)
		end
	end

	self:setList(list)
end

GMFightSimulateLeftModel.instance = GMFightSimulateLeftModel.New()

return GMFightSimulateLeftModel
