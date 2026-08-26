-- chunkname: @modules/logic/gm/model/GMFightSimulateRightModel.lua

module("modules.logic.gm.model.GMFightSimulateRightModel", package.seeall)

local GMFightSimulateRightModel = class("GMFightSimulateRightModel", ListScrollModel)

function GMFightSimulateRightModel:setChapterId(chapterId)
	local list = {}

	for _, episodeCO in ipairs(lua_episode.configList) do
		if episodeCO.chapterId == chapterId then
			table.insert(list, episodeCO)
		end
	end

	self:setList(list)
end

GMFightSimulateRightModel.instance = GMFightSimulateRightModel.New()

return GMFightSimulateRightModel
