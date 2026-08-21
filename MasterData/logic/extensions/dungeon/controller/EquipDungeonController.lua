-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/controller/EquipDungeonController.lua

module("logic.extensions.dungeon.controller.EquipDungeonController", package.seeall)

local M = class("EquipDungeonController", BaseController)

function M:onInit()
	return
end

function M:onReset()
	return
end

function M:jump(chapterId, dungeonIdx)
	local dungeonIndex = dungeonIdx

	if ViewMgr.instance:isOpen(ViewName.RedMistChapterView) then
		ViewMgr.instance:close(ViewName.RedMistChapterView)
	end

	local chapterMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)

	if not chapterMo:getIsChapterUnlock() then
		FloatWordMgr.instance:show(chapterMo:getLockStr())

		return
	end

	ViewMgr.instance:open(ViewName.RedMistChapterView, chapterId, dungeonIndex)
end

M.instance = M.New()

return M
