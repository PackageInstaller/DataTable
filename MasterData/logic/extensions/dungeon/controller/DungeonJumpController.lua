-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/controller/DungeonJumpController.lua

module("logic.extensions.dungeon.controller.DungeonJumpController", package.seeall)

local M = class("DungeonJumpController")

function M:ctor()
	self._dungeonType2JumpHandler = {
		[CommEnum.DungeonType.Mainline] = self._handleJumpMainline,
		[CommEnum.DungeonType.Branchline] = self._handleJumpMainline,
		[CommEnum.DungeonType.LightTower] = self._handleJumpLightTower,
		[CommEnum.DungeonType.DarkTower] = self._handleJumpDarkTower,
		[CommEnum.DungeonType.ControlAction] = self._handleJumpControlAction,
		[CommEnum.DungeonType.ControlActionTeaching] = self._handleJumpControlAction,
		[CommEnum.DungeonType.EquipExplore] = self._handleJumpEquipExplore,
		[CommEnum.DungeonType.Material] = self._handleJumpMaterial,
		[CommEnum.DungeonType.Gold] = self._handleJumpMaterial,
		[CommEnum.DungeonType.Exp] = self._handleJumpMaterial,
		[CommEnum.DungeonType.Teaching] = self._handleJumpTeaching,
		[CommEnum.DungeonType.HeroEarlyAccess] = self._handleJumpHeroEarlyAccess
	}
end

function M:jumpToDungeonView(dungeonCode)
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(dungeonCode)

	if not dungeonCO then
		printError("Jump Faild! Cannot find dungeon config", dungeonCode)

		return
	end

	local jumpHandler = self._dungeonType2JumpHandler[dungeonCO.type]

	if not jumpHandler then
		printError("Jump Faild! Cannot find jumpHandler", dungeonCode)

		return
	end

	jumpHandler(self, dungeonCode)

	return true
end

function M:_handleJumpMainline(dungeonCode)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local chapterJumpInfo = {
		clickDungeon = true,
		needShowChapterSelect = true,
		chapterId = dungeonMO:getChapterId(),
		difficulty = dungeonMO:getDifficulty(),
		dungeonIndex = dungeonMO:getDungeonIndex()
	}

	DungeonMainLineChapterModel.instance:tryEnterChapterScene(false, chapterJumpInfo)
end

function M:_handleJumpLightTower(dungeonCode)
	ClimbingTowerModel.instance:setEntryViewEnterTyp(ClimbingTowerEnum.PageTyp.BrightSide)
	ClimbingTowerModel.instance:cacheEntryViewPageType(ClimbingTowerEnum.PageTyp.BrightSide)
	ViewMgr.instance:open(ViewName.ClimbingTowerEntryView)
end

function M:_handleJumpDarkTower(dungeonCode)
	ClimbingTowerModel.instance:setEntryViewEnterTyp(ClimbingTowerEnum.PageTyp.DarkSide)
	ClimbingTowerModel.instance:cacheEntryViewPageType(ClimbingTowerEnum.PageTyp.DarkSide)
	ViewMgr.instance:open(ViewName.ClimbingTowerEntryView)
end

function M:_handleJumpControlAction(dungeonCode)
	local monitorMO = ControlActionModel.instance:getMonitorMO(dungeonCode)

	if monitorMO then
		local dungeonGroupCode = monitorMO:getDungeonGroupCode()
		local difficultIndex = monitorMO:getDungeonIndex(dungeonCode)

		ControlActionModel.instance:setBattleInfo(false, difficultIndex, dungeonGroupCode)
	end

	ViewMgr.instance:open(ViewName.ControlAction)
end

function M:_handleJumpEquipExplore(dungeonCode)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local chapterId = dungeonMO:getChapterId()
	local chapterMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(chapterId)
	local dungeonIndex = 1

	for index, dungeonId in ipairs(chapterMo:getDungeonIds()) do
		if dungeonId == dungeonCode then
			dungeonIndex = index

			break
		end
	end

	DungeonEquipExploreChapterModel.instance:setClickChapterIdAndDungeonIndex(dungeonMO:getChapterId(), dungeonIndex)
	ViewMgr.instance:open(ViewName.RedMistChapterView)
end

function M:_handleJumpMaterial(dungeonCode)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local chapterId = dungeonMO:getChapterId()
	local dungeonIndex = DungeonMaterialChapterModel.instance:getChapterLastUnlockDungeonIndex(chapterId)

	DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(chapterId, dungeonIndex)
	ViewMgr.instance:open(ViewName.StableAreaChapterView)
end

function M:_handleJumpTeaching(dungeonCode)
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

	DungeonTeachingChapterModel.instance:setClickChapterIdAndDungeonIndex(dungeonMO:getChapterId())
	ViewMgr.instance:open(ViewName.TeachingChapter)
end

function M:_handleJumpHeroEarlyAccess(dungeonCode)
	local tabId = 204

	if not WelfareUtil.isTabActive(tabId) then
		FloatWordMgr.instance:show(lang("activity_closed"))

		return
	end

	local param = {
		tabId = tabId
	}

	ViewMgr.instance:open(ViewName.WelfareMainView, param)
end

M.instance = M.New()

return M
