-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/RogueRectifyJudgeHandler.lua

module("logic.extensions.roguelike.flow.component.handler.RogueRectifyJudgeHandler", package.seeall)

local M = class("RogueRectifyJudgeHandler", IRogueJudgeHandler)

function M:getExtraResult()
	local result
	local bigSuccess = RoguelikeConfig.instance:getConstByName("RectifyBigSuccess").numValue
	local bigFail = 0

	if bigSuccess > math.random(1, 1000) then
		result = RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS

		self._mgr.flow.model:setExtraResult(result)

		return result
	end

	if bigFail > math.random(1, 1000) then
		result = RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_FAIL

		self._mgr.flow.model:setExtraResult(result)

		return result
	end

	return result
end

function M:judgeDice()
	local matchCount = 0

	for idx, dice1 in ipairs(self._mgr._curRoundPlayerDice) do
		if dice1:getUpPattern() ~= RoguelikeConst.DICE_PATTERN.WHITE then
			matchCount = matchCount + 1
		end
	end

	local extraResult = self._mgr.flow.model:getExtraResult()

	if extraResult == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS then
		matchCount = 6

		self._mgr.flow.model:setExtraResult(nil)
	elseif extraResult == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_FAIL then
		matchCount = 0

		self._mgr.flow.model:setExtraResult(nil)
	end

	print("整顿属性面数量", matchCount)
	self._mgr.flow.model:setRoundFinish(true)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_RECTIFY_RESULT, matchCount)

	return true
end

function M:saveJudgeArchive(isJudged)
	if RogueMgr.instance:getIsClientMode() then
		return
	end

	local type = self._mgr.flow.model:getCurEventType()
	local roomId = RoguelikeModel.instance:getCurRoomId()
	local enemyId = RogueMgr.instance:getModel():getRectifyProp()
	local eventId = RogueMgr.instance:getModel():getCurEventId()
	local enemyOuterHp = #self._mgr._curRoundCombatDice
	local combatDices = self._mgr._curRoundCombatDice
	local enemyInnerHp = #combatDices
	local round = self._mgr.flow.stateMgr:getRoundIndex()
	local heroId = self._mgr.flow.model:getCurRoleMo():getRoleId()
	local monsterDiceFaceNO = RoguelikeExtension_pb.FaceNO()
	local pattern = self._mgr.flow.model:getRectifyProp()

	monsterDiceFaceNO.face = RoguelikeUtil.instance:convertCAttrType2SType(pattern)
	monsterDiceFaceNO.num = #combatDices

	local enemyFace = monsterDiceFaceNO
	local selectedAttr = RoguelikeUtil.instance:convertCAttrType2SType(pattern)
	local roleDices = self._mgr._curRoundPlayerDice
	local selfFaces = roleDices
	local archiveNO = RoguelikeAgent.instance:generateArchive(type, roomId, enemyId, enemyOuterHp, enemyInnerHp, round, heroId, enemyFace, selectedAttr, selfFaces, isJudged, eventId)

	RoguelikeAgent.instance:sendJudgeArchiveRequest(archiveNO)
end

return M
