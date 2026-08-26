-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameMapAreaItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameMapAreaItem", package.seeall)

local DianJiShiGameMapAreaItem = class("DianJiShiGameMapAreaItem", LuaCompBase)

function DianJiShiGameMapAreaItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._goFlag = gohelper.findChild(self.go, "go_Flag")
	self._goValue = gohelper.findChild(self.go, "go_Flag/go_Value")
	self._imageValue = gohelper.findChildImage(self.go, "go_Flag/go_Value/image_Value")
	self._txtValue = gohelper.findChildText(self.go, "go_Flag/go_Value/txt_Value")
	self._goCheck = gohelper.findChild(self.go, "go_Flag/go_Check")
	self._imageCheckBg = gohelper.findChild(self.go, "go_Flag/go_Check/bg")
	self._goLight = gohelper.findChild(self.go, "go_Flag/go_Light")
	self._goPlaced = gohelper.findChild(self.go, "go_Flag/go_Placed")
	self._imagePlacedBg = gohelper.findChild(self.go, "go_Flag/go_Placed/bg")
	self._goLeftTop = gohelper.findChild(self.go, "go_LeftTop")
	self._goLeftBottom = gohelper.findChild(self.go, "go_LeftBottom")
	self._goRightTop = gohelper.findChild(self.go, "go_RightTop")
	self._goRightBottom = gohelper.findChild(self.go, "go_RightBottom")
	self._directionMap = self:getUserDataTb_()
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.LeftTop] = self._goLeftTop
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.LeftBottom] = self._goLeftBottom
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.RightTop] = self._goRightTop
	self._directionMap[DianJiShiGameEnum.AreaTipsDir.RightBottom] = self._goRightBottom

	gohelper.setActive(self._goLight, false)
	gohelper.setActive(self._goCheck, false)
	gohelper.setActive(self._goPlaced, false)

	self._tranFlag = self._goFlag.transform
	self._tranLight = self._goLight.transform
	self._tranImagePlacedBg = self._imagePlacedBg.transform
	self._tranImageValueBg = self._imageValue.transform
	self._tranImageCheckBg = self._imageCheckBg.transform
	self._filterCellList = {}
	self._filterAreaMap = {}
	self._resultValue = 0
end

function DianJiShiGameMapAreaItem:addEventListeners()
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnBeginDragBlock, self._onBeginDragBlock, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockDone, self._onPlaceBlockDone, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnPlaceBlockError, self._onPlaceBlockError, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnLightAreaValue, self._onLightAreaValue, self)
end

function DianJiShiGameMapAreaItem:removeEventListeners()
	return
end

function DianJiShiGameMapAreaItem:onUpdateMO(areaInfo, index)
	self._areaInfo = areaInfo
	self._areaId = self._areaInfo.id
	self._index = index
	self._areaCo = self._areaInfo and self._areaInfo.config

	self:refreshUI()
end

function DianJiShiGameMapAreaItem:refreshUI()
	self:setBonus()
	self:setAreaFlag()
end

function DianJiShiGameMapAreaItem:setBonus()
	if not self._areaInfo then
		return
	end

	local cellWidth, cellHeight = DianJiShiGameModel.instance:getCellSize()

	if not self._areaInfo.minXIndex then
		local minXIndex = 0

		if not self._areaInfo.minYIndex then
			local minYIndex = 0

			if not self._areaInfo.maxXIndex then
				local maxXIndex = 0

				if not self._areaInfo.maxYIndex then
					local maxYIndex = 0
					local wholeWidth = (maxXIndex - minXIndex + 1) * cellWidth
					local wholeHeight = (maxYIndex - minYIndex + 1) * cellHeight

					recthelper.setSize(self._tran, wholeWidth, wholeHeight)

					local posX, posY = DianJiShiGameController.instance:posIndex2Pos(minXIndex, minYIndex, true)

					recthelper.setAnchor(self._tran, posX, posY)
				end
			end
		end
	end
end

function DianJiShiGameMapAreaItem:setAreaFlag()
	if self._areaCo then
		local dir = self._areaCo.direction

		dir = dir or DianJiShiGameEnum.Direction.LeftTop

		if self._directionMap then
			local goDir = self._directionMap[dir]

			if gohelper.isNil(goDir) then
				return
			end

			gohelper.addChild(goDir, self._goFlag)

			if self._areaCo then
				if not self._areaCo.value then
					local configValue = 0

					if self._areaInfo then
						if not self._areaInfo.value then
							local placeValue = 0

							self._resultValue = configValue - placeValue

							self:setTagByValue(self._resultValue)
							self:setTagBgDir(dir)
							self:setTagOffset(self._areaCo.offset)
						end
					end
				end
			end
		end
	end
end

function DianJiShiGameMapAreaItem:setTagByValue(resultValue)
	local isFinish = resultValue == 0

	gohelper.setActive(self._goValue, not isFinish)
	gohelper.setActive(self._goCheck, isFinish)

	if not isFinish then
		self._txtValue.text = resultValue

		if self._areaCo then
			UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageValue, self._areaCo, true)
		end
	end
end

function DianJiShiGameMapAreaItem:setTagBgDir(dir)
	local isLeft = dir == DianJiShiGameEnum.AreaTipsDir.LeftTop or dir == DianJiShiGameEnum.AreaTipsDir.LeftBottom
	local xScale = isLeft and -1 or 1

	transformhelper.setLocalScale(self._tranLight, xScale, 1, 1)
	transformhelper.setLocalScale(self._tranImagePlacedBg, xScale, 1, 1)
	transformhelper.setLocalScale(self._tranImageValueBg, xScale, 1, 1)
	transformhelper.setLocalScale(self._tranImageCheckBg, xScale, 1, 1)
end

function DianJiShiGameMapAreaItem:setTagOffset(offsetStr)
	local offsetList = string.splitToNumber(offsetStr, "#")
	local offsetX = offsetList and offsetList[1]
	local offsetY = offsetList and offsetList[2]

	offsetX = offsetX or 0
	offsetY = offsetY or 0

	recthelper.setAnchor(self._tranFlag, offsetX, offsetY)
end

function DianJiShiGameMapAreaItem:_onLightAreaValue(areaIdMap)
	local isLight = areaIdMap and areaIdMap[self._areaId] == true

	self:_updateLightEffect(isLight)
end

function DianJiShiGameMapAreaItem:_onPlaceBlockDone()
	if not self._isLight then
		return
	end

	self:_updateLightEffect(false)
	gohelper.setActive(self._goPlaced, false)
	gohelper.setActive(self._goPlaced, true)

	local tagFullPath = SLFramework.GameObjectHelper.GetPath(self._goFlag)

	DianJiShiGameModel.instance:recordLastUpdateAreaTagPath(tagFullPath)
end

function DianJiShiGameMapAreaItem:_onPlaceBlockError()
	self:_updateLightEffect(false)
end

function DianJiShiGameMapAreaItem:_updateLightEffect(isLight)
	if self._isLight == isLight then
		return
	end

	self._isLight = isLight

	gohelper.setActive(self._goLight, self._isLight)
end

function DianJiShiGameMapAreaItem:_onBeginDragBlock(blockInfo)
	local isInThisArea = self:_isBlockInThisArea(blockInfo)

	if not isInThisArea then
		return
	end

	local blockCo = blockInfo.config

	if blockCo then
		if not blockCo.value then
			local blockValue = 0
			local tempAreaValue = self._resultValue + blockValue

			self:setTagByValue(tempAreaValue)

			if self._resultValue == 0 and tempAreaValue ~= 0 then
				DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnMapAreaValueNotFit)
			end
		end
	end
end

function DianJiShiGameMapAreaItem:_isBlockInThisArea(blockInfo)
	local status = blockInfo and blockInfo.status

	if status ~= DianJiShiGameEnum.BlockStatus.Placed then
		return
	end

	DianJiShiGameController.instance:getBlockFilterCellList(blockInfo, blockInfo.posIndex[1], blockInfo.posIndex[2], self._filterCellList, self._filterAreaMap)

	return self._filterAreaMap and self._filterAreaMap[self._areaId] ~= nil
end

function DianJiShiGameMapAreaItem:onDestroy()
	return
end

return DianJiShiGameMapAreaItem
