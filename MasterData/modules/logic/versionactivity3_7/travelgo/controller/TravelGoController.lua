-- chunkname: @modules/logic/versionactivity3_7/travelgo/controller/TravelGoController.lua

module("modules.logic.versionactivity3_7.travelgo.controller.TravelGoController", package.seeall)

local TravelGoController = class("TravelGoController", BaseController)

function TravelGoController:onInit()
	self.BkgMoveSpeedDefault = 400
	self.EntityCreatePosX = 1750
	self.NpcStopMovePosX = -110
	self.EnemyStopMovePosX = 550
	self.PlayerMoveToTime = 1
	self.isFullProbability = false
end

function TravelGoController:reInit()
	self:onGameEnd()
end

function TravelGoController:startGame(gameId, isTest, isNotEvent)
	if self.isRunning then
		return
	end

	self.isRunning = true
	self.isSettle = false
	self.isTest = isTest
	self.isNotEvent = isNotEvent

	logNormal("小瑞安依 游戏开始")
	TravelGoStatHelper.instance:enterGame()

	self.bkgMoveSpeed = self.BkgMoveSpeedDefault

	math.randomseed(os.time())
	TravelGoModel.instance:onGameStart(gameId)

	self.travelGoProcessMgr = TravelGoProcessMgr.New()
	self.travelGoRewardMgr = TravelGoRewardMgr.New()
	self.travelGoBattleMgr = TravelGoBattleMgr.New()
	self.travelGoEntityMgr = TravelGoEntityMgr.New()
	self.comps = {
		self.travelGoProcessMgr,
		self.travelGoRewardMgr,
		self.travelGoBattleMgr,
		self.travelGoEntityMgr
	}

	for i, comp in ipairs(self.comps) do
		comp:awake(true)
	end

	ViewMgr.instance:openView(ViewName.TravelGoView)

	return true
end

function TravelGoController:onViewOpen()
	self:startNextDay()
end

function TravelGoController:settle()
	self.isSettle = true

	self:dispatchEvent(TravelGoEvent.OnGameSettle)
	ViewMgr.instance:openView(ViewName.TravelGoResultView, {
		isWin = TravelGoModel.instance.isWin,
		gameId = TravelGoModel.instance.gameId
	})
	TravelGoStatHelper.instance:sendGameSettle()
end

function TravelGoController:onSettleEnd()
	ViewMgr.instance:closeView(ViewName.TravelGoView)

	if not self.isTest and TravelGoModel.instance.isWin then
		local episodeId = XRuiAnYiController.instance.gameEpisodeId

		XRuiAnYiController.instance:_onGameFinished(VersionActivity3_7Enum.ActivityId.XRuiAnYi, episodeId)
	end
end

function TravelGoController:onGameEnd()
	if not self.isRunning then
		return
	end

	for i, comp in ipairs(self.comps) do
		comp:dispose()
	end

	self.comps = nil
	self.isRunning = nil
end

function TravelGoController:startNextDay()
	if self.isSettle then
		return
	end

	self.travelGoProcessMgr:startNextDay()
end

function TravelGoController:addDescItem(param)
	self:dispatchEvent(TravelGoEvent.OnCreateDescItem, param)
end

function TravelGoController:addSkillRewardItem(param)
	self:dispatchEvent(TravelGoEvent.OnCreateSkillRewardItem, param)
end

function TravelGoController:createFloatItem(param)
	self:dispatchEvent(TravelGoEvent.OnCreateFloatItem, param)
end

function TravelGoController:showBattleTip(tip)
	self:dispatchEvent(TravelGoEvent.OnShowBattleTip, tip)
end

function TravelGoController:startBattle()
	self.travelGoBattleMgr:startBattle()
end

function TravelGoController:getDayEventWork()
	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO

	if travelGoEventMO.eventType == TravelGoEnum.EventType.Story then
		return TravelGoStoryEventWork.New()
	elseif travelGoEventMO.eventType == TravelGoEnum.EventType.Battle then
		return TravelGoBattleEventWork.New()
	elseif travelGoEventMO.eventType == TravelGoEnum.EventType.Luck then
		return TravelGoLuckEventWork.New()
	end
end

function TravelGoController:randomByWeight(weights)
	local total = 0

	for i, v in ipairs(weights) do
		total = total + v
	end

	local n = math.random(1, total)

	for index, wt in ipairs(weights) do
		if n <= wt then
			return index
		end

		n = n - wt
	end
end

function TravelGoController:formatNumber(v)
	return math.floor(v + 0.5)
end

function TravelGoController:getSkillRareColor(rare)
	if rare == 1 then
		return "#677f9f"
	elseif rare == 2 then
		return "#b67833"
	elseif rare == 3 then
		return "#892d1e"
	end

	return "#677f9f"
end

function TravelGoController:exeGM(gm)
	local infos = string.split(gm, " ")
	local cmd = infos[2]

	if cmd == "进入关卡" then
		local value = tonumber(infos[3])
		local isNotEvent = infos[4] == "1"

		if value then
			TravelGoController.instance:startGame(value, true, isNotEvent)
		end
	elseif cmd == "生成事件" then
		local value = tonumber(infos[3])

		if value then
			TravelGoModel.instance:createDayEvent(value)

			local flow = FlowSequence.New()

			flow:addWork(TravelGoDayEventWork.New())
			flow:start()
		end
	elseif cmd == "增加经验" then
		local value = tonumber(infos[3])

		if value then
			TravelGoModel.instance:addExp(value)
		end
	elseif cmd == "修改属性基础值" then
		local attrId = tonumber(infos[3])
		local value = tonumber(infos[4])

		if attrId and value then
			TravelGoController.instance.travelGoEntityMgr.playerEntity.attributes:setBasicAttr(attrId, value)
		end
	elseif cmd == "增加玩家技能" then
		local skillId = tonumber(infos[3])

		if skillId then
			TravelGoController.instance.travelGoEntityMgr.playerEntity.skill:addSkill(skillId)
		end
	elseif cmd == "增加玩家buff" then
		local buffId = tonumber(infos[3])

		if buffId then
			TravelGoController.instance.travelGoEntityMgr.playerEntity.buff:addBuff(buffId, nil)
		end
	elseif cmd == "胜利" then
		TravelGoModel.instance:setSettle(true)
		TravelGoController.instance:settle()
	elseif cmd == "失败" then
		TravelGoModel.instance:setSettle(false)
		TravelGoController.instance:settle()
	end
end

TravelGoController.instance = TravelGoController.New()

return TravelGoController
