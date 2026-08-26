-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/interacts/YaXianInteractHandleBase.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractHandleBase", package.seeall)

local YaXianInteractHandleBase = class("YaXianInteractHandleBase")

function YaXianInteractHandleBase:init(interactObject)
	self._interactObject = interactObject
end

function YaXianInteractHandleBase:onSelectCall()
	return
end

function YaXianInteractHandleBase:onCancelSelect()
	return
end

function YaXianInteractHandleBase:onSelectPos(x, y)
	return
end

function YaXianInteractHandleBase:onAvatarLoaded()
	self:faceTo(self._interactObject.interactMo.direction)
end

function YaXianInteractHandleBase:faceTo(direction)
	self._interactObject.interactMo:setDirection(direction)

	if self._interactObject:isDelete() then
		return
	end

	if not self._interactObject.directionAvatarDict then
		return
	end

	for dir, avatar in pairs(self._interactObject.directionAvatarDict) do
		gohelper.setActive(avatar, dir == direction)
	end
end

function YaXianInteractHandleBase:moveTo(x, y, callback, callbackObj)
	if x == self._interactObject.interactMo.posX and y == self._interactObject.interactMo.posY then
		if self.stepData then
			self:faceTo(self.stepData.direction)
		end

		if callback then
			return callback(callbackObj)
		end

		return
	end

	if self._interactObject:isDelete() then
		if callback then
			self._interactObject.interactMo:setXY(x, y)

			if self.stepData then
				self:faceTo(self.stepData.direction)
			end

			return callback(callbackObj)
		end

		return
	end

	self._moveCallback = callback
	self._moveCallbackObj = callbackObj

	local interactMo = self._interactObject.interactMo
	local moveDirection = YaXianGameHelper.getDirection(interactMo.posX, interactMo.posY, x, y)

	self:faceTo(moveDirection)
	interactMo:setXY(x, y)

	if self.stepData and self.stepData.assassinateSourceStep then
		self:handleAssassinate()

		return
	end

	local sceneX, sceneY, sceneZ = YaXianGameHelper.calcTilePosInScene(x, y)

	self:killMoveTween()

	self.moveWork = YaXianInteractMoveWork.New({
		transform = self._interactObject.interactItemContainerTr,
		targetX = sceneX,
		targetY = sceneY,
		targetZ = sceneZ,
		isPlayer = self._interactObject:isPlayer(),
		interactMo = interactMo
	})

	self.moveWork:registerDoneListener(self.onMoveCompleted, self)
	self.moveWork:onStart()
end

function YaXianInteractHandleBase:handleAssassinate()
	local stepMgr = YaXianGameController.instance.stepMgr
	local deleteStepData = stepMgr:getStepData(self.stepData.deleteStepIndex)

	if deleteStepData then
		if not deleteStepData.id then
			local killInteractId = 0
			local killInteractItem = YaXianGameController.instance:getInteractItem(killInteractId)

			if deleteStepData then
				if not deleteStepData.sourceId then
					local sourceInteractId = 0
					local sourceInteractItem = YaXianGameController.instance:getInteractItem(sourceInteractId)

					self:stopFlow()

					self.flow = FlowSequence.New()

					local targetPosX, targetPosY = self._interactObject.interactMo.posX, self._interactObject.interactMo.posY
					local prePosX, prePosY = self._interactObject.interactMo.prePosX, self._interactObject.interactMo.prePosY

					if killInteractItem.interactMo.posX ~= sourceInteractItem.interactMo.posX or killInteractItem.interactMo.posY ~= sourceInteractItem.interactMo.posY then
						local x, y, z = YaXianGameHelper.calcTilePosInScene(targetPosX, targetPosY)

						self.flow:addWork(YaXianInteractMoveWork.New({
							transform = self._interactObject.interactItemContainerTr,
							targetX = x,
							targetY = y,
							targetZ = z,
							isPlayer = self._interactObject:isPlayer(),
							interactMo = self._interactObject.interactMo
						}))
						self.flow:addWork(YaXianInteractEffectWork.New(killInteractId, YaXianGameEnum.EffectType.Assassinate))
						self.flow:addWork(YaXianInteractEffectWork.New(killInteractId, YaXianGameEnum.EffectType.Die))
						self.flow:addWork(YaXianInteractEffectWork.New(sourceInteractId, YaXianGameEnum.EffectType.FightSuccess))
					else
						local moveDirection = YaXianGameHelper.getDirection(prePosX, prePosY, targetPosX, targetPosY)
						local oppositeDirection = YaXianGameEnum.OppositeDirection[moveDirection]
						local x, y, z = YaXianGameHelper.calBafflePosInScene(targetPosX, targetPosY, oppositeDirection)

						self.flow:addWork(YaXianInteractMoveWork.New({
							transform = self._interactObject.interactItemContainerTr,
							targetX = x,
							targetY = y,
							targetZ = z,
							isPlayer = self._interactObject:isPlayer(),
							interactMo = self._interactObject.interactMo
						}))

						local otherInteractItem = killInteractId == self._interactObject.id and sourceInteractItem or killInteractItem

						x, y, z = YaXianGameHelper.calBafflePosInScene(targetPosX, targetPosY, moveDirection)

						self.flow:addWork(YaXianInteractMoveWork.New({
							transform = otherInteractItem.interactItemContainerTr,
							targetX = x,
							targetY = y,
							targetZ = z
						}))
						self.flow:addWork(YaXianInteractEffectWork.New(killInteractId, YaXianGameEnum.EffectType.Assassinate))

						local parallelFlow = FlowParallel.New()

						parallelFlow:addWork(YaXianInteractEffectWork.New(killInteractId, YaXianGameEnum.EffectType.Die))

						x, y, z = YaXianGameHelper.calcTilePosInScene(targetPosX, targetPosY)

						parallelFlow:addWork(YaXianInteractMoveWork.New({
							transform = sourceInteractItem.interactItemContainerTr,
							targetX = x,
							targetY = y,
							targetZ = z
						}))
						self.flow:addWork(parallelFlow)
						self.flow:addWork(YaXianInteractEffectWork.New(sourceInteractId, YaXianGameEnum.EffectType.FightSuccess))
					end

					self.flow:registerDoneListener(self.onMoveCompleted, self)
					self.flow:start()
				end
			end
		end
	end
end

function YaXianInteractHandleBase:onMoveCompleted()
	self:killMoveTween()
	self:stopFlow()

	if self.stepData and self._interactObject.interactMo.direction ~= self.stepData.direction then
		TaskDispatcher.runDelay(self.doMoveCallback, self, YaXianGameEnum.SwitchDirectionDelay)

		return
	end

	self:doMoveCallback()
end

function YaXianInteractHandleBase:doMoveCallback()
	if self.stepData then
		self:faceTo(self.stepData.direction)

		self.stepData = nil
	end

	if self._interactObject:isPlayer() then
		local exitInteractMo = YaXianGameModel.instance:getExitInteractMo()

		if self._interactObject.interactMo.posX == exitInteractMo.posX and self._interactObject.interactMo.posY == exitInteractMo.posY then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
		end
	end

	if self._moveCallback then
		-- block empty
	end
end

function YaXianInteractHandleBase:killMoveTween()
	if self.moveWork then
		self.moveWork:onDestroy()

		self.moveWork = nil
	end
end

function YaXianInteractHandleBase:moveToFromMoveStep(stepData, callback, callbackObj)
	self.stepData = stepData

	self:moveTo(self.stepData.x, self.stepData.y, callback, callbackObj)
end

function YaXianInteractHandleBase:stopFlow()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

function YaXianInteractHandleBase:stopAllAction()
	self:stopFlow()
	self:killMoveTween()
	TaskDispatcher.cancelTask(self.doMoveCallback, self)
end

function YaXianInteractHandleBase:dispose()
	self:stopAllAction()
end

return YaXianInteractHandleBase
