-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleWorkLeaveDungeon.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleWorkLeaveDungeon", package.seeall)

local M = class("DungeonBattleWorkLeaveDungeon", WorkBase)

function M:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.SCENE_FLOW_EXIT_FINISH, self._onSceneEixtFinish, self)

	local dungeonType = context.model:getDungeonType()

	if dungeonType == CommEnum.DungeonType.Mainline or dungeonType == CommEnum.DungeonType.Branchline then
		ViewMgr.instance:destroy(ViewName.DungeonEntranceView)
		ViewMgr.instance:close(ViewName.MainlineDungeonView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.Material or dungeonType == CommEnum.DungeonType.Gold or dungeonType == CommEnum.DungeonType.Exp then
		ViewMgr.instance:destroy(ViewName.DungeonEntranceView)
		ViewMgr.instance:close(ViewName.StableAreaChapterView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.Teaching then
		ViewMgr.instance:close(ViewName.TeachingChapter, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.EquipExplore then
		ViewMgr.instance:destroy(ViewName.DungeonEntranceView)
		ViewMgr.instance:close(ViewName.RedMistChapterView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		ViewMgr.instance:close(ViewName.EquipExploreMultiplicityFightTipsView)
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.LightTower then
		ViewMgr.instance:destroy(ViewName.DungeonEntranceView)
		ViewMgr.instance:close(ViewName.ClimbingTowerEntryView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.DarkTower then
		ViewMgr.instance:destroy(ViewName.DungeonEntranceView)
		ViewMgr.instance:close(ViewName.ClimbingTowerEntryView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.ControlAction or dungeonType == CommEnum.DungeonType.ControlActionTeaching or dungeonType == CommEnum.DungeonType.HeroEarlyAccess then
		ViewMgr.instance:destroy(ViewName.DungeonEntranceView)
		ControlActionModel.instance:enterBattle()
		self:_onSceneEixtFinish()
	elseif dungeonType == CommEnum.DungeonType.PowerChallenge then
		ViewMgr.instance:close(ViewName.WelfareMainView)
		self:_onSceneEixtFinish()
	end

	SpaceX.RendererFeatureUtils.ToggleRendererFeature(false, RendererFeatureName.HEIGHT_FOG)
end

function M:onExit(isInterrupt)
	GlobalDispatcher:removeEventListener(EventType.SCENE_FLOW_EXIT_FINISH, self._onSceneEixtFinish, self)
end

function M:_onSceneEixtFinish()
	DungeonModel.instance:setIsInBattle(true)
	GlobalDispatcher:removeEventListener(EventType.SCENE_FLOW_EXIT_FINISH, self._onSceneEixtFinish, self)
	self:onDone(WorkResult.Succeed)
end

return M
