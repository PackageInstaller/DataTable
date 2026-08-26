-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/status/YaXianInteractEnemyStatus.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractEnemyStatus", package.seeall)

local YaXianInteractEnemyStatus = class("YaXianInteractEnemyStatus", YaXianInteractStatusBase)

function YaXianInteractEnemyStatus:updateStatus()
	self.statusDict = {}
	self.hadInVisibleEffect = YaXianGameModel.instance:hasInVisibleEffect()

	if self.interactItem:isFighting() then
		self:addStatus(YaXianGameEnum.IconStatus.Fight)
	end

	self.playerCanWalkPos2Direction = YaXianGameModel.instance:getCanWalkPos2Direction()

	self:handleInteractPos()
	self:handleInteractAlertArea()
	self:handleInteractMoving()
end

function YaXianInteractEnemyStatus:handleInteractPos()
	local playerMoveDirection = self.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(self.interactMo.posX, self.interactMo.posY)]

	if not playerMoveDirection then
		return
	end

	if self.interactItem:isFighting() then
		self:addStatus(YaXianGameEnum.IconStatus.Fight, YaXianGameEnum.OppositeDirection[playerMoveDirection])
	elseif self.hadInVisibleEffect then
		self:addStatus(YaXianGameEnum.IconStatus.Assassinate)
	elseif YaXianGameEnum.OppositeDirection[playerMoveDirection] ~= self.interactMo.direction then
		self:addStatus(YaXianGameEnum.IconStatus.Assassinate)
	end
end

function YaXianInteractEnemyStatus:handleInteractAlertArea()
	if not self.interactItem:isFighting() then
		return
	end

	local alertAreaList = self.interactMo.alertPosList

	if alertAreaList and #alertAreaList > 0 then
		for _, alertArea in ipairs(alertAreaList) do
			local playerMoveDirection = self.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(alertArea.posX, alertArea.posY)]

			if playerMoveDirection then
				self:addStatus(YaXianGameEnum.IconStatus.Fight)

				break
			end
		end
	end
end

function YaXianInteractEnemyStatus:handleInteractMoving()
	local interactMo = self.interactItem.interactMo
	local nextPos = self.interactItem.interactMo.nextPos

	if not nextPos then
		return
	end

	if not self.hadInVisibleEffect then
		return
	end

	for posX, posY in YaXianGameHelper.getPassPosGenerator(interactMo.posX, interactMo.posY, nextPos.posX, nextPos.posY) do
		local direction = self.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(posX, posY)]

		if direction then
			self:addStatus(YaXianGameEnum.IconStatus.Assassinate)

			break
		end
	end
end

return YaXianInteractEnemyStatus
