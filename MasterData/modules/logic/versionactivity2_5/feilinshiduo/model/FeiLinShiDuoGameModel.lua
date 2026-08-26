-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/model/FeiLinShiDuoGameModel.lua

module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoGameModel", package.seeall)

local FeiLinShiDuoGameModel = class("FeiLinShiDuoGameModel", BaseModel)

function FeiLinShiDuoGameModel:onInit()
	self:reInit()

	self.curGameConfig = {}
	self.isBlindnessMode = false
end

function FeiLinShiDuoGameModel:reInit()
	self.elementMap = {}
	self.elementList = {}
	self.interElementList = {}
	self.interElementMap = {}
	self.elementShowStateMap = {}
	self.touchElementState = {}
	self.playerCurMoveSpeed = 0
	self.doorOpenStateMap = {}
	self.curColor = FeiLinShiDuoEnum.ColorType.None
	self.isInColorChanging = false
	self.isPlayerInIdleState = true
end

function FeiLinShiDuoGameModel:initConfigData(mapId)
	self:reInit()

	self.mapConfigData = addGlobalModule("modules.configs.feilinshiduo.lua_feilinshiduo_map_" .. tostring(mapId))
	self.mapConfig = self.mapConfigData.mapConfig

	for index, config in ipairs(self.mapConfig) do
		local mapItem = self.elementMap[config.type]

		if not mapItem then
			mapItem = {}
			self.elementMap[config.type] = mapItem
		end

		if not mapItem[config.id] then
			local itemInfo = {}

			itemInfo.id = config.id
			itemInfo.type = config.type
			itemInfo.pos = string.splitToNumber(config.pos, "#")
			itemInfo.color = config.color
			itemInfo.refId = config.refId
			itemInfo.scale = string.splitToNumber(config.scale, "#")
			itemInfo.params = config.params
			itemInfo.subGOPosList = GameUtil.splitString2(config.subGOPosList, true)
			itemInfo.groupName = FeiLinShiDuoEnum.ParentName[config.type]
			itemInfo.width = tonumber(config.width)
			itemInfo.height = tonumber(config.height)
			mapItem[config.id] = itemInfo
		end

		table.insert(self.interElementList, mapItem[config.id])
		table.insert(self.elementList, mapItem[config.id])

		self.elementShowStateMap[config.id] = true
		self.interElementMap[config.id] = mapItem[config.id]
	end
end

function FeiLinShiDuoGameModel:setCurMapId(mapId)
	self.curMapId = mapId
end

function FeiLinShiDuoGameModel:getCurMapId()
	return self.curMapId
end

function FeiLinShiDuoGameModel:setGameConfig(config)
	self.curGameConfig = config
end

function FeiLinShiDuoGameModel:getCurGameConfig()
	return self.curGameConfig
end

function FeiLinShiDuoGameModel:getElementList()
	return self.elementList
end

function FeiLinShiDuoGameModel:getInterElementList()
	return self.interElementList
end

function FeiLinShiDuoGameModel:getInterElementMap()
	return self.interElementMap
end

function FeiLinShiDuoGameModel:getElementMap()
	return self.elementMap
end

function FeiLinShiDuoGameModel:getMapConfigData()
	return self.mapConfigData
end

function FeiLinShiDuoGameModel:setCurPlayerMoveSpeed(speed)
	self.playerCurMoveSpeed = speed
end

function FeiLinShiDuoGameModel:getCurPlayerMoveSpeed()
	return self.playerCurMoveSpeed
end

function FeiLinShiDuoGameModel:setBlindnessModeState(state)
	self.isBlindnessMode = state
end

function FeiLinShiDuoGameModel:getBlindnessModeState()
	return self.isBlindnessMode
end

local touchItemBLPos = Vector3()
local touchItemTRPos = Vector3()

function FeiLinShiDuoGameModel:checkTouchElement(posX, posY, ignoreTypeList, elementList, isFallCheck)
	local isTouchElementList = {}
	local checkElementList = elementList or self.interElementList

	for _, mapItem in pairs(checkElementList) do
		touchItemBLPos.x = mapItem.pos[1]
		touchItemBLPos.y = mapItem.pos[2]
		touchItemTRPos.x = touchItemBLPos.x + mapItem.width
		touchItemTRPos.y = touchItemBLPos.y + mapItem.height

		local canCheckTouch = true

		if ignoreTypeList and #ignoreTypeList > 0 then
			for _, ignoreType in ipairs(ignoreTypeList) do
				if mapItem.type == ignoreType then
					canCheckTouch = false

					break
				end
			end
		end

		if mapItem.type == FeiLinShiDuoEnum.ObjectType.Stairs and isFallCheck and posX >= touchItemBLPos.x and posX <= touchItemTRPos.x and posY > touchItemBLPos.y and posY < touchItemTRPos.y - FeiLinShiDuoEnum.HalfSlotWidth / 2 then
			canCheckTouch = false
		end

		if self.elementShowStateMap[mapItem.id] and posX >= touchItemBLPos.x and posX <= touchItemTRPos.x and posY >= touchItemBLPos.y and posY <= touchItemTRPos.y and canCheckTouch then
			table.insert(isTouchElementList, mapItem)
		end
	end

	return isTouchElementList
end

function FeiLinShiDuoGameModel:checkItemTouchElemenet(posX, posY, itemInfo, dir, elementList, ignoreTypeList)
	local isTouchElementList = {}

	if not self.elementShowStateMap[itemInfo.id] then
		return isTouchElementList
	end

	local checkRange = FeiLinShiDuoEnum.touchCheckRange
	local checkElementList = elementList or self.interElementList

	for _, mapItem in pairs(checkElementList) do
		if self.elementShowStateMap[mapItem.id] then
			local canTouch = false

			if dir == FeiLinShiDuoEnum.checkDir.Left then
				if posY < mapItem.pos[2] + mapItem.height - checkRange and mapItem.pos[2] + checkRange < posY + itemInfo.height and posX > mapItem.pos[1] and Mathf.Abs(mapItem.pos[1] - posX) <= mapItem.width then
					canTouch = true
				end
			elseif dir == FeiLinShiDuoEnum.checkDir.Top then
				if posX < mapItem.pos[1] + mapItem.width - checkRange and mapItem.pos[1] + checkRange < posX + itemInfo.width and posY < mapItem.pos[2] and Mathf.Abs(mapItem.pos[2] - posY) <= itemInfo.height then
					canTouch = true
				end
			elseif dir == FeiLinShiDuoEnum.checkDir.Right then
				if posY < mapItem.pos[2] + mapItem.height - checkRange and mapItem.pos[2] + checkRange < posY + itemInfo.height and posX < mapItem.pos[1] and Mathf.Abs(mapItem.pos[1] - posX) <= itemInfo.width then
					canTouch = true
				end
			elseif dir == FeiLinShiDuoEnum.checkDir.Bottom and posX < mapItem.pos[1] + mapItem.width - checkRange and mapItem.pos[1] + checkRange < posX + itemInfo.width and posY > mapItem.pos[2] and Mathf.Abs(mapItem.pos[2] - posY) <= mapItem.height then
				canTouch = true
			end

			if mapItem.type == FeiLinShiDuoEnum.ObjectType.Stairs and Mathf.Abs(itemInfo.pos[1] + itemInfo.width / 2 - (mapItem.pos[1] - mapItem.width / 2)) < itemInfo.width / 2 + mapItem.width / 2 and posY > mapItem.pos[2] and posY <= mapItem.pos[2] + mapItem.height - FeiLinShiDuoEnum.HalfSlotWidth / 2 then
				canTouch = false
			end

			if ignoreTypeList and #ignoreTypeList > 0 then
				for _, ignoreType in pairs(ignoreTypeList) do
					if mapItem.type == ignoreType then
						canTouch = false

						break
					end
				end
			end

			if canTouch then
				table.insert(isTouchElementList, mapItem)
			end
		end
	end

	return isTouchElementList
end

function FeiLinShiDuoGameModel:updateBoxPos(id, pos)
	if not self.elementMap or next(self.elementMap) == nil then
		return
	end

	local mapItem = self.elementMap[FeiLinShiDuoEnum.ObjectType.Box][id]

	mapItem.pos = pos
end

local subItemBLPos = Vector3()
local subItemTRPos = Vector3()

function FeiLinShiDuoGameModel:getFixStandePos(isTouchElementList, posX, posY)
	if isTouchElementList and #isTouchElementList > 0 then
		for _, mapItem in ipairs(isTouchElementList) do
			if posY >= mapItem.pos[2] and (mapItem.type == FeiLinShiDuoEnum.ObjectType.ColorPlane or mapItem.type == FeiLinShiDuoEnum.ObjectType.Wall or mapItem.type == FeiLinShiDuoEnum.ObjectType.Box or mapItem.type == FeiLinShiDuoEnum.ObjectType.Trap) then
				subItemBLPos.x = mapItem.pos[1]
				subItemBLPos.y = mapItem.pos[2]
				subItemTRPos.x = subItemBLPos.x + mapItem.width
				subItemTRPos.y = subItemBLPos.y + mapItem.height

				if posY >= subItemBLPos.y and posY <= subItemTRPos.y then
					return subItemBLPos, subItemTRPos
				end
			end
		end
	end
end

function FeiLinShiDuoGameModel:setElememntShowStateByColor(color)
	self.curColor = color

	for _, mapItem in ipairs(self.elementList) do
		if color == FeiLinShiDuoEnum.ColorType.Yellow and mapItem.color == FeiLinShiDuoEnum.ColorType.Red then
			self.elementShowStateMap[mapItem.id] = false
		else
			self.elementShowStateMap[mapItem.id] = mapItem.color ~= color or color == FeiLinShiDuoEnum.ColorType.None
		end
	end
end

function FeiLinShiDuoGameModel:showAllElementState()
	for _, mapItem in ipairs(self.elementList) do
		self.elementShowStateMap[mapItem.id] = true
	end
end

function FeiLinShiDuoGameModel:getCurColor()
	return self.curColor
end

function FeiLinShiDuoGameModel:getElementShowStateMap()
	return self.elementShowStateMap
end

function FeiLinShiDuoGameModel:getElementShowState(mapItem)
	return self.elementShowStateMap[mapItem.id]
end

function FeiLinShiDuoGameModel:setDoorOpenState(id, state)
	self.doorOpenStateMap[id] = state
end

function FeiLinShiDuoGameModel:getDoorOpenStateMap()
	return self.doorOpenStateMap
end

function FeiLinShiDuoGameModel:setIsPlayerInColorChanging(state)
	self.isInColorChanging = state
end

function FeiLinShiDuoGameModel:getIsPlayerInColorChanging()
	return self.isInColorChanging
end

function FeiLinShiDuoGameModel:setPlayerIsIdleState(state)
	self.isPlayerInIdleState = state
end

function FeiLinShiDuoGameModel:getPlayerIsIdleState()
	return self.isPlayerInIdleState
end

function FeiLinShiDuoGameModel:checkForwardCanMove(checkPosX, checkPosY, deltaMoveX, mapElementItem, isBox)
	local isTouchElementList = {}

	if isBox then
		if deltaMoveX > 0 then
			if not FeiLinShiDuoEnum.checkDir.Right then
				local checkDir = FeiLinShiDuoEnum.checkDir.Left

				isTouchElementList = self:checkItemTouchElemenet(checkPosX, checkPosY, mapElementItem, checkDir)
			end
		end
	else
		isTouchElementList = self:checkTouchElement(checkPosX, checkPosY)
	end

	if isTouchElementList and #isTouchElementList > 0 then
		for _, mapItem in ipairs(isTouchElementList) do
			if mapItem.type == FeiLinShiDuoEnum.ObjectType.Wall or mapItem.type == FeiLinShiDuoEnum.ObjectType.ColorPlane then
				return false, (deltaMoveX > 0 or nil) and (mapItem.pos[1] or mapItem.pos[1] + mapItem.width)
			elseif mapItem.type == FeiLinShiDuoEnum.ObjectType.Door and not self.doorOpenStateMap[mapItem.id] then
				if mapElementItem and mapElementItem.type == FeiLinShiDuoEnum.ObjectType.Box then
					if deltaMoveX > 0 then
						if Mathf.Abs(mapItem.pos[1] + mapItem.width / 2 - (checkPosX + (mapElementItem.width or 0))) <= FeiLinShiDuoEnum.touchElementRange then
							return false, mapItem.pos[1] + mapItem.width / 2 - deltaMoveX * FeiLinShiDuoEnum.doorTouchCheckRang / 2
						elseif not mapElementItem and Mathf.Abs(mapItem.pos[1] + mapItem.width / 2 - checkPosX) <= FeiLinShiDuoEnum.touchElementRange then
							return false, mapItem.pos[1] + mapItem.width / 2 - deltaMoveX * FeiLinShiDuoEnum.doorTouchCheckRang / 2
						end
					end
				end
			elseif mapItem.type == FeiLinShiDuoEnum.ObjectType.Box then
				local forwardCanMove, touchPosX = self:checkForwardCanMove(mapItem.pos[1] + deltaMoveX, mapItem.pos[2], deltaMoveX, mapItem, true)

				touchPosX = touchPosX and (deltaMoveX > 0 and mapItem.pos[1] or mapItem.pos[1] + mapItem.width)

				return forwardCanMove, touchPosX
			end
		end
	end

	return true
end

FeiLinShiDuoGameModel.instance = FeiLinShiDuoGameModel.New()

return FeiLinShiDuoGameModel
