-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseCupCollectData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseCupCollectData", package.seeall)

local M = class("CourseCupCollectData")

function M:ctor(cupInfo)
	self._cupData = {}

	for i, v in ipairs(cupInfo) do
		local cup = CourseCupData.buildFromMsg(v)

		cup.sortIndex = i

		table.insert(self._cupData, cup)
	end
end

function M:updateContent(ids)
	self._cupData = {}

	for i, v in ipairs(ids) do
		local mo = MonumentModel.instance:getMonumentMoById(v)
		local cup = CourseCupData.buildFromDepot(mo)

		cup.sortIndex = i

		table.insert(self._cupData, cup)
	end
end

function M:getDisplayCup()
	return self._cupData
end

return M
