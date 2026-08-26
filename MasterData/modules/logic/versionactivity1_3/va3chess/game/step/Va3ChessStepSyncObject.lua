-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepSyncObject.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepSyncObject", package.seeall)

local Va3ChessStepSyncObject = class("Va3ChessStepSyncObject", Va3ChessStepBase)

function Va3ChessStepSyncObject:start()
	local newServerData = self.originData.object
	local interactId = newServerData.id
	local extendData = newServerData.data
	local dir = newServerData.direction
	local interactMO = Va3ChessGameModel.instance:getObjectDataById(interactId)

	if interactMO then
		self:_syncObject(interactId, extendData, dir)
	end

	self:finish()
end

function Va3ChessStepSyncObject:_syncObject(interactId, extendData, dir)
	local deltaDatas = Va3ChessGameModel.instance:syncObjectData(interactId, extendData)

	if deltaDatas == nil then
		return
	end

	if self:dataHasChanged(deltaDatas, "alertArea") then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
	end

	if self:dataHasChanged(deltaDatas, "goToObject") then
		local interactObj = Va3ChessGameController.instance.interacts:get(interactId)

		if interactObj then
			interactObj.goToObject:updateGoToObject()
		end
	end

	if self:dataHasChanged(deltaDatas, "lostTarget") then
		local interactObj = Va3ChessGameController.instance.interacts:get(interactId)

		if interactObj then
			interactObj.effect:refreshSearchFailed()
			interactObj.goToObject:refreshTarget()
		end
	end

	if self:dataHasChanged(deltaDatas, "pedalStatus") then
		local interactObj = Va3ChessGameController.instance.interacts:get(interactId)

		if interactObj and interactObj:getHandler().refreshPedalStatus then
			interactObj:getHandler():refreshPedalStatus()
		end
	end

	local interactObj = Va3ChessGameController.instance.interacts:get(interactId)

	if not interactObj or not interactObj.chessEffectObj then
		return
	end

	if extendData.attributes and extendData.attributes.sleep and interactObj.chessEffectObj.setSleep then
		interactObj.chessEffectObj:setSleep(extendData.attributes.sleep)
	end

	if interactObj.chessEffectObj.refreshKillEffect then
		interactObj.chessEffectObj:refreshKillEffect()
	end

	if dir then
		interactObj:getHandler():faceTo(dir)
	end
end

function Va3ChessStepSyncObject:dataHasChanged(deltaDatas, fieldName)
	if deltaDatas[fieldName] ~= nil or deltaDatas.__deleteFields and deltaDatas.__deleteFields[fieldName] then
		return true
	end

	return false
end

return Va3ChessStepSyncObject
