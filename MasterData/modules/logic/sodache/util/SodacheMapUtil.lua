-- chunkname: @modules/logic/sodache/util/SodacheMapUtil.lua

module("modules.logic.sodache.util.SodacheMapUtil", package.seeall)

local SodacheMapUtil = class("SodacheMapUtil")
local bit = require("bit")

function SodacheMapUtil:ctor()
	self.btnClickType = SodacheEnum.MapBtnClickType.None
	self.movePathInfo = nil
	self._steps = nil
	self.flow = nil
	self.cacheDropItems = nil
end

function SodacheMapUtil:setClickType(clickType)
	self.btnClickType = bit.bor(clickType, self.btnClickType)
end

function SodacheMapUtil:isHaveClick(clickType)
	return bit.band(self.btnClickType, clickType) > 0
end

function SodacheMapUtil:clearClickType()
	self.btnClickType = SodacheEnum.MapBtnClickType.None
end

function SodacheMapUtil:isPlayerMove()
	return not not self.movePathInfo
end

function SodacheMapUtil:setMovePaths(pathInfo)
	if self.movePathInfo == pathInfo then
		return
	end

	self.movePathInfo = pathInfo

	SodacheController.instance:dispatchEvent(SodacheEvent.OnSetMovePath)
end

function SodacheMapUtil:tryMoveNextPath(isFirst)
	if not self.movePathInfo then
		return
	end

	local locationId = SodacheMapUtil.getPlayerLocationId()
	local index = tabletool.indexOf(self.movePathInfo.path, locationId)

	if not index then
		return
	end

	local nextId = self.movePathInfo.path[index + 1]

	if not nextId then
		self:setMovePaths()
		SodacheController.instance:dispatchEvent(SodacheEvent.OnPlayerMoveEnd)

		return
	end

	if isFirst then
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Move, table.concat(self.movePathInfo.path, ",", index + 1))
	else
		SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.ContinueMove, tostring(nextId))
	end
end

function SodacheMapUtil:tryTriggerUnit(unitMo)
	local func = self[string.format("_triggerUnitType_%s", SodacheEnum.UnitTypeToName[unitMo.type])] or self._triggerUnitType_Common_Type

	if func and func(self, unitMo) then
		return true
	end

	return false
end

function SodacheMapUtil:_triggerUnitType_Common_Type(unitMo)
	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Interaction, tostring(unitMo.uid))

	return true
end

function SodacheMapUtil:_triggerUnitType_Escape(unitMo)
	ViewMgr.instance:openView(ViewName.SodacheEscapeView, {
		unitMo = unitMo
	})

	return true
end

function SodacheMapUtil:_triggerUnitType_Altar(unitMo)
	ViewMgr.instance:openView(ViewName.SodacheAltarView, {
		unitMo = unitMo
	})

	return true
end

function SodacheMapUtil.haveTriggerEvent()
	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		return false
	end

	if insideMo.prop.battleInfo.status == SodacheEnum.FightStatus.ShowPanel then
		return true
	end

	if insideMo.panelBox.currPanel.type > 0 then
		return true
	end

	return false
end

function SodacheMapUtil.enterFight()
	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		return false
	end

	local battleInfo = insideMo.prop.battleInfo

	if battleInfo.status == SodacheEnum.FightStatus.ShowPanel then
		local episodeId = SodacheEnum.EpisodeId
		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
			GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, SodacheMapUtil._onEnterOneSceneFinish, SodacheMapUtil.instance)
		end

		DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, battleInfo.fightId)

		return true
	end
end

function SodacheMapUtil:_onEnterOneSceneFinish()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	SodacheUtil.closeViews(true)
end

function SodacheMapUtil:cacheSteps(steps)
	self._steps = self._steps or {}

	for _, step in ipairs(steps) do
		local stepMo = SodacheStepMo.New()

		stepMo:init(step)

		if not SodacheEnum.StepTypeToName[step.type] then
			local stepName = ""
			local cls = _G[string.format("SodacheStep%sWork", stepName)]

			if cls then
				table.insert(self._steps, cls.New(stepMo))
			end
		end
	end
end

function SodacheMapUtil:addPushToFlow(msgName, msg)
	self._steps = self._steps or {}

	local workCls = _G[string.format("%sWork", msgName)] or SodacheMsgPushWork
	local work = workCls.New(msgName, msg)

	table.insert(self._steps, work)
end

function SodacheMapUtil:tryStartFlow(recvProtoName, isFromInside)
	if not self._steps or #self._steps <= 0 then
		return
	end

	local isNewFlow = false

	if not self.flow then
		self.flow = FlowSequence.New()
		isNewFlow = true
	end

	if recvProtoName == "SodacheInsideEnterSceneReply" or recvProtoName == "SodacheInsideSceneOperationReply" then
		self.flow:addWork(SodacheWaitSceneFinishWork.New())
	end

	local sortableTypes = {
		[SodacheEnum.StepType.AddUnits] = 1,
		[SodacheEnum.StepType.Move] = 2,
		[SodacheEnum.StepType.RemoveUnits] = 3
	}
	local segStart

	local function sortSegment(steps, from, to)
		for i = from + 1, to do
			local cur = steps[i]

			if not sortableTypes[cur._stepMo and cur._stepMo.type] then
				local curOrder = 0
				local j = i - 1

				while from <= j do
					if not sortableTypes[steps[j]._stepMo and steps[j]._stepMo.type] then
						local prevOrder = 0

						if prevOrder <= curOrder then
							break
						end

						steps[j + 1] = steps[j]
						j = j - 1
					end
				end

				steps[j + 1] = cur
			end
		end
	end

	for i = 1, #self._steps do
		if self._steps[i]._stepMo then
			if sortableTypes[self._steps[i]._stepMo] then
				segStart = segStart or i
			else
				if segStart and segStart < i - 1 then
					sortSegment(self._steps, segStart, i - 1)
				end

				segStart = nil
			end
		end
	end

	if segStart and segStart < #self._steps then
		sortSegment(self._steps, segStart, #self._steps)
	end

	local moveFlow
	local moveSet = {}

	for index, v in ipairs(self._steps) do
		if not isFromInside and v:isInsideStep() then
			if isDebugBuild then
				logError("在局外发了局内的数据！请保留数据然后联系森总！！！" .. v.__cname)
			end
		elseif v._stepMo and v._stepMo.type == SodacheEnum.StepType.Move then
			local uid = v._stepMo.paramLong[1]

			if moveFlow and not moveSet[uid] then
				moveFlow:addWork(v)
			else
				moveSet = {}
				moveFlow = FlowParallel.New()

				moveFlow:addWork(v)
				self.flow:addWork(moveFlow)
			end

			moveSet[uid] = true
		elseif v:canMergeExecute(moveSet) and moveFlow then
			moveFlow:addWork(v)
		else
			moveSet = {}
			moveFlow = nil

			self.flow:addWork(v)
		end
	end

	if SodacheUtil.isInside() then
		self.flow:addWork(SodacheContinueMoveWork.New())
	end

	if isNewFlow then
		self.flow:registerDoneListener(self.flowDone, self)
		self.flow:start({
			beginDt = ServerTime.now()
		})
	end

	self._steps = nil
end

function SodacheMapUtil:flowDone()
	if self.flow then
		self.flow = nil
		self._steps = nil

		SodacheController.instance:dispatchEvent(SodacheEvent.OnStepFlowEnd, self.flow)
	end
end

function SodacheMapUtil:isInFlow()
	return (self.flow == nil or nil) and self._steps and #self._steps > 0
end

function SodacheMapUtil:tryRemoveFlow()
	if not self.flow then
		return
	end

	if ServerTime.now() - self.flow.context.beginDt > 10 then
		local curWorks = self:getCurRunningWorks(self.flow)
		local workNames = {}

		for i, v in ipairs(curWorks) do
			table.insert(workNames, v.__cname)
		end

		logError("可能卡主了，清掉数据吧!runningwork:" .. table.concat(workNames, ","))

		self._steps = nil

		self.flow:onDestroyInternal()

		self.flow = nil
	end
end

function SodacheMapUtil:getCurRunningWorks(flow)
	local works = {}
	local workList = flow:getWorkList()

	if not workList or flow.status ~= WorkStatus.Running then
		return works
	end

	for i, work in ipairs(workList) do
		if work.status == WorkStatus.Running then
			if isTypeOf(work, BaseFlow) then
				tabletool.addValues(works, self:getCurRunningWorks(work))
			else
				table.insert(works, work)
			end
		end
	end

	return works
end

function SodacheMapUtil:clear()
	if self.flow then
		self.flow:destroy()
	end

	self.flow = nil
	self._steps = nil
	self.movePathInfo = nil
	self.cacheDropItems = nil

	self:clearClickType()
end

function SodacheMapUtil.getPlayerLocationId()
	local insideMo = SodacheModel.instance:getInsideMo()

	return insideMo.player.locationId
end

function SodacheMapUtil.setUnitDataDirty()
	local insideMo = SodacheModel.instance:getInsideMo()

	insideMo.unitDirty = true
end

function SodacheMapUtil.getOperPath(nodeId)
	local insideMo = SodacheModel.instance:getInsideMo()
	local player = insideMo.player
	local mapCo = insideMo.mapCo

	if player.locationId == nodeId then
		return {
			dis = 0,
			path = {
				nodeId
			}
		}
	end

	return mapCo:getPath(player.locationId, nodeId)
end

function SodacheMapUtil.getBossCareerRecommend()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if not episodeId or episodeId ~= SodacheEnum.EpisodeId then
		return false
	end

	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		return false
	end

	return insideMo.prop.battleInfo.careerIds, {}
end

function SodacheMapUtil.getWorshipItems()
	local allShowItems = {}
	local conditionDict = {}
	local constStr = SodacheConfig.instance:getConstVal(SodacheEnum.ConstId.WorshipItemCond)

	if not string.nilorempty(constStr) then
		for i, v in ipairs(string.splitToNumber(constStr, "#")) do
			conditionDict[v] = true
		end
	end

	local outsideMo = SodacheModel.instance:getOutsideMo()

	for i, v in pairs(outsideMo.relicBox.relics) do
		if v.level > 0 and conditionDict[v.itemCo.quality] then
			table.insert(allShowItems, SodacheCardMo.Create(v.id))
		end
	end

	return allShowItems
end

SodacheMapUtil.instance = SodacheMapUtil.New()

return SodacheMapUtil
