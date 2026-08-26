-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/status/YaXianInteractPlayerStatus.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractPlayerStatus", package.seeall)

local YaXianInteractPlayerStatus = class("YaXianInteractPlayerStatus", YaXianInteractStatusBase)

function YaXianInteractPlayerStatus:updateStatus()
	self.statusDict = {}
	self.hadInVisibleEffect = YaXianGameModel.instance:hasInVisibleEffect()
	self.hadThroughWallEffect = YaXianGameModel.instance:hasThroughWallEffect()
	self.canWalkDirection2Pos = YaXianGameModel.instance:getCanWalkTargetPosDict()
	self.canWalkPos2Direction = YaXianGameModel.instance:getCanWalkPos2Direction()

	self:addVisibleStatus()
	self:addThroughWallStatus()
	self:addAssassinateOrFightStatus()
end

function YaXianInteractPlayerStatus:addVisibleStatus()
	if self.hadInVisibleEffect then
		self:addStatus(YaXianGameEnum.IconStatus.InVisible)
	end
end

function YaXianInteractPlayerStatus:addThroughWallStatus()
	if self.hadThroughWallEffect then
		self:addStatus(YaXianGameEnum.IconStatus.ThroughWall)
	end
end

function YaXianInteractPlayerStatus:addAssassinateOrFightStatus()
	local interactItemList = YaXianGameController.instance:getInteractItemList()

	if interactItemList and #interactItemList > 0 then
		for _, interactItem in ipairs(interactItemList) do
			if interactItem and interactItem:isEnemy() and not interactItem:isDelete() then
				self:handleInteractPos(interactItem)
				self:handleInteractAlertArea(interactItem)
				self:handleInteractMoving(interactItem)
			end
		end
	end
end

function YaXianInteractPlayerStatus:handleInteractPos(interactItem)
	for direction, pos in pairs(self.canWalkDirection2Pos) do
		local interactMo = interactItem.interactMo

		if interactMo.posX == pos.x and interactMo.posY == pos.y then
			if interactItem:isFighting() then
				self:addStatus(YaXianGameEnum.IconStatus.Fight, direction)
			elseif not self.hadInVisibleEffect and interactMo.direction == YaXianGameEnum.OppositeDirection[direction] then
				self:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, direction)
			end
		end
	end
end

function YaXianInteractPlayerStatus:handleInteractAlertArea(interactItem)
	local alertAreaList = interactItem.interactMo.alertPosList

	if alertAreaList and #alertAreaList > 0 then
		for _, alertArea in ipairs(alertAreaList) do
			local direction = self.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(alertArea.posX, alertArea.posY)]

			if direction then
				if interactItem:isFighting() then
					self:addStatus(YaXianGameEnum.IconStatus.Fight, direction)
				elseif not self.hadInVisibleEffect then
					self:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, direction)
				end
			end
		end
	end
end

function YaXianInteractPlayerStatus:handleInteractMoving(interactItem)
	local interactMo = interactItem.interactMo
	local nextPos = interactItem.interactMo.nextPos

	if not nextPos then
		return
	end

	for posX, posY in YaXianGameHelper.getPassPosGenerator(interactMo.posX, interactMo.posY, nextPos.posX, nextPos.posY) do
		local direction = self.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(posX, posY)]

		if direction then
			if interactItem:isFighting() then
				self:addStatus(YaXianGameEnum.IconStatus.Fight, direction)
			elseif not self.hadInVisibleEffect then
				self:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, direction)
			end
		end
	end
end

return YaXianInteractPlayerStatus
