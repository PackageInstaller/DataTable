-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/battleflow/BattleRecordUtil.lua

module("logic.extensions.battlerecord.battleflow.BattleRecordUtil", package.seeall)

local BattleRecordUtil = {}
local kStateKey = "battle_record"

function BattleRecordUtil.enterBattle(msg)
	BattleEnterUtil.enterRecordBattle(msg.battleInfo)

	local battleFlow = BattleMgr.instance:getActiveBattleFlow()

	battleFlow.netEventMgr:setEventTriggeredPushList(msg.push)
end

function BattleRecordUtil.enterSetup()
	SceneFace.instance:exitScene()
	ViewMgr.instance:close(ViewName.MainUIView)
	ViewMgr.instance:close(ViewName.HackToolView)
	ViewMgr.instance:close(ViewName.BattleRecord)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Auto, false, kStateKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.RoundFinish, false, kStateKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.DangerZone, false, kStateKey)
end

function BattleRecordUtil.exitSetup()
	SceneFace.instance:enterRoomScene(true, true)
	ViewMgr.instance:open(ViewName.BattleRecord)
	ViewMgr.instance:open(ViewName.MainUIView)
end

function BattleRecordUtil.forceExitBattle()
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()

	cmdExecuter:clearCommands()
	cmdExecuter:addCommand(BattleRecordForceExitCommand:createInstance())
	cmdExecuter:submit()
	ViewMgr.instance:close(ViewName.BattleSettingViewPresentor)
end

return BattleRecordUtil
