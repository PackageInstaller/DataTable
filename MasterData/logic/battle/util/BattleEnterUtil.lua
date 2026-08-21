-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleEnterUtil.lua

module("logic.battle.util.BattleEnterUtil", package.seeall)

local BattleEnterUtil = {}
local BattleType = BattleExtension_pb.BattleType
local GameType = BattleExtension_pb.GameType

function BattleEnterUtil.enterBattle(battleInfoNO, mode)
	local type = battleInfoNO.type

	if type == BattleType.DUNGEON then
		local battleFlowClass = DungeonController.instance:getBattleFlowClassByCode(battleInfoNO.passId)

		BattleMgr.instance:enter(battleInfoNO, battleFlowClass, mode)
	elseif type == BattleType.GM_CUSTOMIZE then
		BattleMgr.instance:enter(battleInfoNO, DummyBattleFlow, mode)
	elseif type == BattleType.GM_LEVEL then
		local dungeonId = DungeonConfig.instance:getDungeonCodeByLevelCode(battleInfoNO.levelId)

		BattleTestUtil.TestBattleLevelCode = battleInfoNO.levelId

		if ControlActionUtil.isDoomForecastDungeon(dungeonId) then
			BattleMgr.instance:enter(battleInfoNO, DoomBattleFlow, mode)
		else
			BattleMgr.instance:enter(battleInfoNO, DummyLevelBattleFlow, mode)
		end
	elseif type == BattleType.RODEO_AIR or type == BattleType.TEST_AIR or type == BattleType.FREE_AIR or type == BattleType.ENDLESS_AIR then
		BattleMgr.instance:enter(battleInfoNO, AirLevelBattleFlow, mode)
	elseif type == BattleType.PVP then
		local pvpType = battleInfoNO.pvpType

		if pvpType == GameType.FOOTBALLPVP then
			BattleMgr.instance:enter(battleInfoNO, FootBallBattleFlow, mode)
		elseif BattleLog.enableError then
			BattleLog.error("unhandle pvp type", pvpType)
		end
	elseif BattleLog.enableError then
		BattleLog.error("unhandle type", type)
	end
end

function BattleEnterUtil.enterRecordBattle(battleInfoNO)
	local mode = BattleEnum.Mode.RECORD
	local type = battleInfoNO.type

	if type == BattleType.DUNGEON or type == BattleType.GM_LEVEL then
		BattleMgr.instance:enter(battleInfoNO, BattleLevelRecordBattleFlow, mode)
	elseif type == BattleType.PVP then
		BattleMgr.instance:enter(battleInfoNO, BattleMultiPlayerRecordBattleFlow, mode)
	elseif type == BattleType.GM_CUSTOMIZE then
		BattleMgr.instance:enter(battleInfoNO, DefaultRecordBattleFlow, mode)
	elseif BattleLog.enableError then
		BattleLog.error("unhandle type", type)
	end
end

function BattleEnterUtil.getCurrentDungeonCode()
	local battleFlow = BattleMgr.instance:getActiveBattleFlow()

	if battleFlow and OOPUtil.isInstanceOf(battleFlow, IDungeonConfigBattleFlow) then
		return battleFlow:getPassId()
	end

	return false
end

function BattleEnterUtil.exitFromDungeon()
	local jumpData = BattleCalculateMgr.instance:getBattleReturnJumpData()

	if jumpData then
		BattleEnterUtil.exitByJump()

		return
	end

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if not DungeonJumpController.instance:jumpToDungeonView(dungeonCode) then
		ViewMgr.instance:jumpToMainView(ViewName.MainUIView)
	end

	SceneFace.instance:enterRoomScene(true, true)
end

function BattleEnterUtil.exitByJump()
	local jumpData = BattleCalculateMgr.instance:getBattleReturnJumpData()

	VirtualCameraMgr.instance:clearFollowConfiner()
	ViewMgr.instance:closeAllViews(WindowType.WindowCloseReasonType.QuickCloseType)

	if jumpData.jumpSystem == DungeonEnum.ReturnJumpType.CharacterSystem then
		local _heroId = jumpData.heroId
		local _tab = jumpData.tab
		local _tabInfo
		local _needDepot = true
		local _openView = jumpData.openView

		SystemJumpController.instance:jumpToCharacterSystem(_heroId, _tab, _tabInfo, _needDepot, _openView)
		SceneFace.instance:clearEnterSceneInfo()
	else
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
	end

	BattleCalculateMgr.instance:setBattleReturnJumpData(false)
end

return BattleEnterUtil
