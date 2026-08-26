-- chunkname: @modules/logic/survival/controller/work/step/SurvivalContinueMoveWork.lua

module("modules.logic.survival.controller.work.step.SurvivalContinueMoveWork", package.seeall)

local SurvivalContinueMoveWork = class("SurvivalContinueMoveWork", BaseWork)

function SurvivalContinueMoveWork:onStart(context)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if SurvivalMapHelper.instance:isInSurvivalScene() and sceneMo and not context.isEnterFight and SurvivalMapModel.instance.result == SurvivalEnum.MapResult.None and not self.context.fastExecute then
		if sceneMo.panel then
			SurvivalMapHelper.instance:tryShowServerPanel(sceneMo.panel)
			self:onDone(true)

			return
		end

		local playerPos = sceneMo.player.pos

		if type(context.tryTrigger) == "table" then
			local allUnitMo = sceneMo:getUnitByPos(playerPos, true)
			local haveUnit = false

			for _, v in ipairs(allUnitMo) do
				if context.tryTrigger[v.id] then
					haveUnit = true

					break
				end
			end

			if not haveUnit then
				context.tryTrigger = nil
			end
		end

		local targetPos, targetPath = SurvivalMapModel.instance:getTargetPos()

		if targetPos or context.tryTrigger and not sceneMo.panel then
			if context.tryTrigger or targetPos == playerPos then
				SurvivalMapHelper.instance:tryShowEventView(playerPos)
			else
				local nextPos

				if targetPath then
					for k, point in ipairs(targetPath) do
						if point == playerPos then
							nextPos = targetPath[k + 1]

							break
						end
					end
				end

				local walkables = SurvivalMapModel.instance:getCurMapCo().walkables

				if nextPos and SurvivalHelper.instance:getValueFromDict(walkables, nextPos) then
					self._nextPos = nextPos

					TaskDispatcher.runDelay(self._delaySendMoveReq, self, 0)
				end
			end
		end
	end

	self:onDone(true)
end

function SurvivalContinueMoveWork:_delaySendMoveReq()
	if SurvivalMapHelper.instance:isInFlow() or not self._nextPos then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SurvivalGuideLock) then
		return
	end

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local playerPos = sceneMo.player.pos
	local dir = SurvivalHelper.instance:getDir(playerPos, self._nextPos)

	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.PlayerMove, tostring(dir))
end

return SurvivalContinueMoveWork
