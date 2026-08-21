-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueShowResult.lua

module("logic.extensions.roguelike.flow.work.WorkRogueShowResult", package.seeall)

local M = class("WorkRogueShowResult", WorkBase)
local kDelayExitTime = 1.7

function M:onEnter(context)
	RogueMgr.instance:getModel():setMonsterChangeFight(0)
	RogueBroadcastModel.instance:clearList()
	RogueMgr.instance:getRogueFlow().stateMgr:clearClientCardEntry()

	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()
	local isWin = RogueMgr.instance:getModel():getJudgeResult()
	local plotId = 0

	if replyCo ~= nil then
		if isWin then
			plotId = replyCo.successStory
		else
			plotId = replyCo.failStory
		end
	end

	if not RogueMgr.instance:getNeedShowDice() then
		local eventMo = RogueMgr.instance:getModel() and RogueMgr.instance:getModel():getCurEventMo() or nil

		if eventMo ~= nil then
			eventMo:reset()
			eventMo:destroy()
		end

		ViewMgr.instance:open(ViewName.RogueEventSettlement)
		self:onDone(WorkResult.Succeed)

		return
	end

	if isWin then
		local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

		for k, v in pairs(roleMos) do
			v.meshModel:play(RoguelikeConst.ROGUE_MONSTER_ANI.WIN, false, true)
		end
	end

	self:showEndAni(isWin)
end

function M:onExit(isInterrupt)
	return
end

function M:_onPlotFinish()
	local isWin = RogueMgr.instance:getModel():getJudgeResult()

	self:showEndAni(isWin)
end

function M:showEndAni(isWin)
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	RogueMgr.instance:getRogueFlow().judgeMgr:clearRoleDiceWall()

	if isWin then
		if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
			self:delayExitState()
		elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
			self:delayExitState()
		elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
			self:delayExitState()
		elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
			local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp
			local aniTime = prop:getAniTime()

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_ROLE_ANI, RoguelikeConst.ROGUE_ROLE_ANI.WIN, 1.63)
			settimer(aniTime[4] / 1000 + 0.01, self.onMonsterAniEnd, self, false)
			CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_win)
		elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT then
			-- block empty
		end
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self:delayExitState()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		self:delayExitState()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self:delayExitState()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp
		local aniTime = prop:getAniTime()
		local roleProp = RogueMgr.instance:getModel():getCurRoleMo()
		local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleProp:getRoleId())
		local deathTime = 1

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_ANI, RoguelikeConst.ROGUE_MONSTER_ANI.WIN, aniTime[3] / 1000)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_ROLE_ANI, RoguelikeConst.ROGUE_ROLE_ANI.DEATH, deathTime)
		settimer(deathTime, self.hideRoleDelay, self, false)
		settimer(aniTime[3] / 1000 + 0.01, self.onMonsterAniEnd, self, false)
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT then
		-- block empty
	end
end

function M:delayExitState()
	self:onDone(WorkResult.Succeed)

	local eventMo = RogueMgr.instance:getModel() and RogueMgr.instance:getModel():getCurEventMo() or nil

	if eventMo ~= nil then
		eventMo:reset()
		eventMo:destroy()
	end

	settimer(kDelayExitTime, function()
		self:closeView()
		RoguelikeController.instance:checkNeedQuit(function()
			RoguelikeController.instance:exitRunGroupJudgeSceneFlow(function()
				if RogueMgr.instance:isInRogue() then
					ViewMgr.instance:open(ViewName.RogueEventSettlement)
				end
			end)
		end)
	end, self, false)
end

function M:hideRoleDelay()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_HIDE_ROLE_SPINE)
end

function M:onMonsterAniEnd()
	self:onDone(WorkResult.Succeed)

	local monster = RogueMgr.instance:getModel() and RogueMgr.instance:getModel():getCurMonster() or nil

	if monster ~= nil then
		monster:reset()
		monster:destroy()
	end

	settimer(kDelayExitTime, function()
		self:closeView()
		RoguelikeController.instance:checkNeedQuit(function()
			RoguelikeController.instance:exitRunGroupJudgeSceneFlow(function()
				if RogueMgr.instance:isInRogue() then
					ViewMgr.instance:open(ViewName.RogueMonsterSettlement)
				end
			end)
		end)
	end, self, false)
end

function M:closeView()
	ViewMgr.instance:close(ViewName.RogueMonsterJudge)
	ViewMgr.instance:close(ViewName.RogueEventJudge)
end

return M
