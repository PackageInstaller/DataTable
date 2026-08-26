-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoBoxComp.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoBoxComp", package.seeall)

local FeiLinShiDuoBoxComp = class("FeiLinShiDuoBoxComp", LuaCompBase)

function FeiLinShiDuoBoxComp:init(go)
	self.go = go
	self.boxTrans = self.go.transform
	self.moveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	self.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed

	self:resetData()
end

function FeiLinShiDuoBoxComp:resetData()
	self.isGround = true
	self.fallYSpeed = 0
	self.deltaMoveX = 0
	self.curInPlaneItem = nil
	self.planeStartPosX = 0
	self.planeEndPosX = 0
	self.isTopBox = false
	self.topBoxOffset = -10000
	self.topBoxDeltaMove = self.deltaMoveX
	self.bottomBoxMap = {}
end

function FeiLinShiDuoBoxComp:initData(mapItemInfo, viewCls)
	self.itemInfo = mapItemInfo
	self.sceneViewCls = viewCls

	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

	self.boxElementMap = elementMap[FeiLinShiDuoEnum.ObjectType.Box]
end

function FeiLinShiDuoBoxComp:addEventListeners()
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, self.cleanTopBoxBottomInfo, self)
end

function FeiLinShiDuoBoxComp:removeEventListeners()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, self.cleanTopBoxBottomInfo, self)
end

function FeiLinShiDuoBoxComp:cleanTopBoxBottomInfo()
	if self.isTopBox then
		self.bottomBoxMap = {}
	end
end

function FeiLinShiDuoBoxComp:onTick()
	self:handleEvent()
end

function FeiLinShiDuoBoxComp:handleEvent()
	if not self.sceneViewCls then
		return
	end

	if FeiLinShiDuoGameModel.instance:getElementShowState(self.itemInfo) and not self:checkBoxInPlane() then
		self:checkBoxFall()
	end
end

function FeiLinShiDuoBoxComp:checkBoxFall(isChangeColor)
	if self.deltaMoveX and self.itemInfo or self.isTopBox then
		local isTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x, self.boxTrans.localPosition.y, self.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, nil, {
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		})

		if #isTouchElementList == 0 then
			self.isGround = false
			self.fallYSpeed = self.fallYSpeed + self.fallAddSpeed

			if not self.isTopBox then
				local elementShowStateMap = FeiLinShiDuoGameModel.instance:getElementShowStateMap()

				transformhelper.setLocalPosXY(self.boxTrans, (self.curInPlaneItem and elementShowStateMap[self.curInPlaneItem.id] and self.deltaMoveX ~= 0 or nil) and (self.deltaMoveX > 0 and self.planeEndPosX or self.planeStartPosX - self.itemInfo.width), self.boxTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
			elseif isChangeColor then
				if not self.boxTrans.localPosition.y then
					local checkY = self.boxTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth
					local fallCheckTouchBoxList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x, checkY, self.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, self.boxElementMap)

					transformhelper.setLocalPosXY(self.boxTrans, (#fallCheckTouchBoxList == 0 or nil) and (not FeiLinShiDuoGameModel.instance:getElementShowState(self.bottomBoxItemInfo) and self.boxTrans.localPosition.x or self.bottomBoxItemInfo and Mathf.Abs(self.boxTrans.localPosition.x + self.itemInfo.width / 2 - (self.bottomBoxItemInfo.pos[1] + self.bottomBoxItemInfo.width / 2)) > self.itemInfo.width / 2 + self.bottomBoxItemInfo.width / 2 and self.boxTrans.localPosition.x or self.topBoxDeltaMove > 0 and self.bottomBoxItemInfo.pos[1] + self.bottomBoxItemInfo.width or self.bottomBoxItemInfo.pos[1] - self.itemInfo.width), self.boxTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
				end
			end
		else
			if not self.isGround then
				self.boxTrans.localPosition = self:fixStandPos(isTouchElementList)

				AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_activity_organ_open)
				FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.CleanTopBoxBottomInfo)
			end

			self.isGround = true
			self.fallYSpeed = 0
			self.deltaMoveX = 0
			self.isTopBox = false

			for _, mapItem in ipairs(isTouchElementList) do
				if mapItem.type == FeiLinShiDuoEnum.ObjectType.Box then
					self.isTopBox = true
					self.topBoxOffset = mapItem.pos[1] - self.boxTrans.localPosition.x
					self.bottomBoxItemInfo = mapItem
					self.bottomBoxMap[self.bottomBoxItemInfo.id] = self.topBoxOffset

					break
				end
			end

			if not self.isTopBox then
				self.bottomBoxMap = {}
			end
		end

		local posTab = {
			self.boxTrans.localPosition.x,
			self.boxTrans.localPosition.y
		}

		FeiLinShiDuoGameModel.instance:updateBoxPos(self.itemInfo.id, posTab)
	end
end

function FeiLinShiDuoBoxComp:setMove(trans, deltaMoveX, boxParam, isChangeColor)
	local isBox = boxParam and boxParam.isBox
	local isTopBox = boxParam and boxParam.isTopBox

	if not self.isGround or self:checkBoxInPlane() then
		return
	end

	if self.deltaMoveX == 0 then
		self.deltaMoveX = deltaMoveX
	end

	if self.deltaMoveX ~= deltaMoveX then
		return
	end

	self.isTopBox = isTopBox

	local curInPlaneItem, planeStartPosX, planeEndPosX = self:getBoxInColorPlane(self.boxTrans.localPosition.x + ((self.deltaMoveX >= 0 or nil) and (-FeiLinShiDuoEnum.HalfSlotWidth or self.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth)), self.boxTrans.localPosition.y - 2, self.curInPlaneItem)

	self.curInPlaneItem = curInPlaneItem
	self.planeStartPosX = planeStartPosX or self.planeStartPosX
	self.planeEndPosX = planeEndPosX or self.planeEndPosX

	if isBox then
		local boxCanMove, touchPosX = FeiLinShiDuoGameModel.instance:checkForwardCanMove(self.boxTrans.localPosition.x, self.boxTrans.localPosition.y, deltaMoveX, self.itemInfo, isBox)

		self.topBoxDeltaMove = self.deltaMoveX

		if boxCanMove then
			if self.isTopBox then
				self.bottomBoxTrans = trans
				self.bottomBoxItemInfo = boxParam.itemInfo

				local tempTopBoxOffset = self.bottomBoxMap[self.bottomBoxItemInfo.id]

				if not tempTopBoxOffset or self.topBoxOffset == -10000 then
					self.topBoxOffset = self.bottomBoxItemInfo.pos[1] - self.boxTrans.localPosition.x
					self.bottomBoxMap[self.bottomBoxItemInfo.id] = self.topBoxOffset
					tempTopBoxOffset = self.topBoxOffset
				end

				self.topBoxOffset = tempTopBoxOffset

				transformhelper.setLocalPosXY(self.boxTrans, self.bottomBoxItemInfo.pos[1] - self.topBoxOffset, self.boxTrans.localPosition.y)
			else
				transformhelper.setLocalPosXY(self.boxTrans, trans.localPosition.x + ((self.deltaMoveX >= 0 or nil) and (boxParam.itemInfo.width or -self.itemInfo.width)), self.boxTrans.localPosition.y)
			end
		else
			if self.isTopBox then
				self.topBoxDeltaMove = -self.deltaMoveX or self.deltaMoveX
			end

			transformhelper.setLocalPosXY(self.boxTrans, (self.deltaMoveX > 0 or nil) and (touchPosX - self.itemInfo.width or touchPosX), self.boxTrans.localPosition.y)
		end
	else
		local playerCanMoveForward = FeiLinShiDuoGameModel.instance:checkForwardCanMove(trans.localPosition.x + self.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth + 1), trans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, self.deltaMoveX)

		if playerCanMoveForward and not isChangeColor then
			transformhelper.setLocalPosXY(self.boxTrans, trans.localPosition.x + self.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 2 + (self.deltaMoveX >= 0 and 0 or -self.itemInfo.width), self.boxTrans.localPosition.y)
		end
	end

	local posTab = {
		self.boxTrans.localPosition.x,
		self.boxTrans.localPosition.y
	}

	FeiLinShiDuoGameModel.instance:updateBoxPos(self.itemInfo.id, posTab)
	self:boxTouchElement()
end

function FeiLinShiDuoBoxComp:getBoxInColorPlane(posX, posY, curInPlaneItem)
	if curInPlaneItem then
		local planeStartPosX, planeEndPosX = self:getPlaneWidthRange(curInPlaneItem.id)

		if planeStartPosX <= posX and posX <= planeEndPosX then
			return curInPlaneItem, planeStartPosX, planeEndPosX
		end
	end

	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()
	local standeItems = {}

	if not elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] then
		if not elementMap[FeiLinShiDuoEnum.ObjectType.Box] then
			local boxItems = {}

			if not elementMap[FeiLinShiDuoEnum.ObjectType.Wall] then
				local wallItems = {}

				if not elementMap[FeiLinShiDuoEnum.ObjectType.Trap] then
					local trapItems = {}

					if not elementMap[FeiLinShiDuoEnum.ObjectType.Stairs] then
						local stairsItems = {}

						for index, item in pairs(wallItems) do
							table.insert(standeItems, item)
						end

						for index, item in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane]) do
							table.insert(standeItems, item)
						end

						for index, item in pairs(boxItems) do
							table.insert(standeItems, item)
						end

						for index, item in pairs(trapItems) do
							table.insert(standeItems, item)
						end

						for index, item in pairs(stairsItems) do
							table.insert(standeItems, item)
						end

						for _, mapItem in pairs(standeItems) do
							local planeStartPosX, planeEndPosX = self:getPlaneWidthRange(mapItem.id)

							if planeStartPosX <= posX and posX <= planeEndPosX and posY > mapItem.pos[2] and posY <= mapItem.pos[2] + mapItem.height then
								return mapItem, planeStartPosX, planeEndPosX
							end
						end
					end
				end
			end
		end
	end
end

function FeiLinShiDuoBoxComp:getPlaneWidthRange(id)
	local elementMap = FeiLinShiDuoGameModel.instance:getInterElementMap()

	if not elementMap[id] then
		local planeItem = {}
		local startPosX = planeItem.pos[1]
		local endPosX = planeItem.pos[1] + planeItem.width

		return startPosX, endPosX
	end
end

function FeiLinShiDuoBoxComp:fixStandPos(isTouchElementList)
	local subItemBLPos, subItemTRPos = FeiLinShiDuoGameModel.instance:getFixStandePos(isTouchElementList, self.boxTrans.localPosition.x, self.boxTrans.localPosition.y)

	if subItemBLPos and subItemTRPos then
		return Vector3(self.boxTrans.localPosition.x, subItemTRPos.y, 0)
	end

	return self.boxTrans.localPosition
end

function FeiLinShiDuoBoxComp:boxTouchElement()
	if self.isGround and self.deltaMoveX ~= 0 then
		if self.deltaMoveX > 0 then
			if not FeiLinShiDuoEnum.checkDir.Right then
				local checkDir = FeiLinShiDuoEnum.checkDir.Left
				local forwardTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x + self.deltaMoveX, self.boxTrans.localPosition.y, self.itemInfo, checkDir)

				if #forwardTouchElementList > 0 then
					for _, element in pairs(forwardTouchElementList) do
						if element.type == FeiLinShiDuoEnum.ObjectType.Box then
							local boxParam = {}
							local boxComp = self.sceneViewCls:getBoxComp(element.id)

							boxParam.touchElementData = element
							boxParam.isBox = true
							boxParam.isTopBox = false
							boxParam.itemInfo = self.itemInfo

							boxComp:setMove(self.boxTrans, self.deltaMoveX, boxParam)
						end
					end
				end

				local topTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x, self.boxTrans.localPosition.y, self.itemInfo, FeiLinShiDuoEnum.checkDir.Top)

				if #topTouchElementList > 0 then
					for _, element in pairs(topTouchElementList) do
						if element.type == FeiLinShiDuoEnum.ObjectType.Box then
							local boxParam = {}
							local boxComp = self.sceneViewCls:getBoxComp(element.id)

							boxParam.touchElementData = element
							boxParam.isBox = true
							boxParam.isTopBox = true
							boxParam.itemInfo = self.itemInfo

							boxComp:setMove(self.boxTrans, self.deltaMoveX, boxParam)
						end
					end
				end
			end
		end
	end
end

function FeiLinShiDuoBoxComp:checkBoxInPlane()
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()
	local checkElementList = {}

	if not elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] then
		for index, item in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane]) do
			table.insert(checkElementList, item)
		end

		for _, checkItem in pairs(checkElementList) do
			if FeiLinShiDuoGameModel.instance:getElementShowState(checkItem) and FeiLinShiDuoGameModel.instance:getElementShowState(self.itemInfo) then
				local curItemCenterPosX = self.itemInfo.pos[1] + self.itemInfo.width / 2
				local checkItemCenterPosX = checkItem.pos[1] + checkItem.width / 2

				if Mathf.Abs(curItemCenterPosX - checkItemCenterPosX) < self.itemInfo.width / 2 + checkItem.width / 2 - 2 * FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(self.itemInfo.pos[2] - checkItem.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
					return true
				end
			end
		end

		return false
	end
end

function FeiLinShiDuoBoxComp:getShowState()
	return FeiLinShiDuoGameModel.instance:getElementShowState(self.itemInfo)
end

return FeiLinShiDuoBoxComp
