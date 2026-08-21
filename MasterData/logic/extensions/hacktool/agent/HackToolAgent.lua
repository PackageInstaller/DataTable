-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/agent/HackToolAgent.lua

module("logic.extensions.hacktool.agent.HackToolAgent", package.seeall)

local json = require("cjson")
local M = class("HackToolAgent", BaseAgent)
local GMCmdEnum = GameEnum.GMCmdEnum

function M:sendGmRequest(tableData)
	local gmExtension = GmExtension_pb.GmRequest()

	json.encode_sparse_array(true)

	gmExtension.gmJson = json.encode(tableData or "")
	self._lastTableData = tableData

	self:sendMsg(gmExtension)
end

function M:sendGmStrRequest(gmStr)
	local gmExtension = GmExtension_pb.GmRequest()

	gmExtension.gmJson = gmStr

	self:sendMsg(gmExtension)
end

function M:handleGmReply(state, gmReply)
	if state == 0 then
		if not self._lastTableData then
			return
		end

		local cmd = self._lastTableData.cmd
		local value = self._lastTableData.value

		if cmd == GMCmdEnum.AddHeroAbsolute then
			local heroId = tonumber(value.heroMark)
			local heroName = PastInfoConfig.instance:getCharacterInfo(heroId).name

			FloatWordMgr.instance:show(string.format(lang("tip_add_role_success"), heroName))
		elseif cmd == GMCmdEnum.DelHero then
			local heroId = value[1].hero
			local heroName = PastInfoConfig.instance:getCharacterInfo(heroId).name

			FloatWordMgr.instance:show(string.format(lang("tip_remove_role_success"), heroName))
		elseif cmd == GMCmdEnum.DelAllHero then
			FloatWordMgr.instance:show(lang("tip_clear_all_role"))
		elseif cmd == GMCmdEnum.ItemClear then
			FloatWordMgr.instance:show(lang("tip_clear_all_goods"))
		elseif cmd == GMCmdEnum.ReduceItemCmd then
			local itemId = value[1].itemId
			local co = BackpackConfig.instance:getItemInfoByItemId(itemId)
			local itemName = co and co.name or itemId
			local reduceNum = value[1].reduce
			local nowCount = ItemModel.instance:getItemCountByItemId(itemId)

			FloatWordMgr.instance:show(string.format(lang("tip_dec_x_prop"), itemName, reduceNum, nowCount))
		end

		GlobalDispatcher:dispatchEvent(EventType.GM_REPLY, self._lastTableData)
	end
end

function M:handleDummyBattlePush(status, message)
	if BattleTestUtil.TestBattleLevelCode > 0 then
		local dungeonId = DungeonConfig.instance:getDungeonCodeByLevelCode(BattleTestUtil.TestBattleLevelCode)

		if ControlActionUtil.isDoomForecastDungeon(dungeonId) then
			BattleMgr.instance:enter(message.info, DoomBattleFlow)
		else
			BattleMgr.instance:enter(message.info, DummyLevelBattleFlow)
		end
	else
		BattleMgr.instance:enter(message.info, DummyBattleFlow)
	end
end

function M:handleServerExceptionPush(status, message)
	if enableErrorLog then
		printError("ServerException::", message)
	end
end

function M:handleDummyLottery1Push(status, msg)
	if status == 0 then
		RetrieveDispatcher:dispatchEvent(RetrieveEventType.onTestLotteryCharacterReply, msg)
	end
end

function M:handleDummyLottery2Push(status, msg)
	if status == 0 then
		RetrieveDispatcher:dispatchEvent(RetrieveEventType.onTestLotteryCharacterNO2Reply, msg)
	end
end

function M:handleDummyLottery3Push(status, msg)
	if status == 0 then
		RetrieveDispatcher:dispatchEvent(RetrieveEventType.onTestLotteryCharacterNO3Reply, msg)
	end
end

function M:handleDelayShutdownPush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.SERVER_DELAY_SHUTDOWN, msg.delay)
	end
end

function M:sendCancelDelayShutdownRequest()
	local msg = GmExtension_pb.CancelDelayShutdownRequest()

	self:sendMsg(msg)
end

function M:handleCancelDelayShutdownReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.SERVER_SHUTDOWN_CANCEL)
	end
end

function M:sendGetBattleHackableInfoRequest()
	local msg = GmExtension_pb.GetBattleHackableInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetBattleHackableInfoReply(status, msg)
	if status == 0 then
		BattleAttrHackModel.instance:initBattleAttrInfo(msg.battle)
		GlobalDispatcher:dispatchEvent(EventType.HACK_BATTLE_INFO_INIT)
	end
end

function M:sendHackBattleInfoRequest(battle)
	local msg = GmExtension_pb.HackBattleInfoRequest()

	msg.battle.round = battle.round
	msg.battle.stage = battle.stage
	msg.battle.player = battle.player
	msg.battle.leftBackCount = battle.leftBackCount

	for i, v in ipairs(battle.entities) do
		table.insert(msg.battle.entities, v)
	end

	self:sendMsg(msg)
end

function M:handleHackBattleInfoReply(status, msg)
	if status == 0 then
		BattleAttrHackModel.instance:updateBattleAttrInfo(msg.battle)
		GlobalDispatcher:dispatchEvent(EventType.HACK_BATTLE_INFO_INIT)
	end
end

function M:handleRoguelikeRoomPush(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateCurHackToolRoomInfo(msg)
	end
end

M.instance = M.New()

return M
