-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/controller/MaterialDungeonController.lua

module("logic.extensions.dungeon.controller.MaterialDungeonController", package.seeall)

local M = class("MaterialDungeonController", BaseController)

function M:onInit()
	return
end

function M:onReset()
	return
end

function M:jump(chapterId, dungeonIdx)
	local dungeonIndex = dungeonIdx

	if ViewMgr.instance:isOpen(ViewName.StableAreaChapterView) then
		ViewMgr.instance:close(ViewName.StableAreaChapterView)
	end

	local chapterMo = DungeonMaterialChapterModel.instance:getChapterMoByChapterId(chapterId)

	if not chapterMo:getIsChapterUnlock() then
		FloatWordMgr.instance:show(chapterMo:getLockStr())

		return
	end

	if dungeonIndex then
		local dungeonIds = chapterMo:getDungeonIds()
		local dungeonId = dungeonIds[dungeonIndex]
		local dungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(dungeonId)

		if dungeonMo:getIsLock() then
			dungeonIndex = DungeonMaterialChapterModel.instance:getChapterLastUnlockDungeonIndex(chapterId)
		end
	end

	dungeonIndex = dungeonIndex or DungeonMaterialChapterModel.instance:getChapterLastUnlockDungeonIndex(chapterId)

	ViewMgr.instance:open(ViewName.StableAreaChapterView, chapterId, dungeonIndex)
end

M.instance = M.New()

return M
