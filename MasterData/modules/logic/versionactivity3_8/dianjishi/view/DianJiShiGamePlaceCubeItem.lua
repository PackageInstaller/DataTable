-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGamePlaceCubeItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGamePlaceCubeItem", package.seeall)

local DianJiShiGamePlaceCubeItem = class("DianJiShiGamePlaceCubeItem", LuaCompBase)

function DianJiShiGamePlaceCubeItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._imageIcon = gohelper.findChildImage(self.go, "image_Icon")
	self._imageFront = gohelper.findChildImage(self.go, "image_Icon/image_Front")
	self._goClick = gohelper.findChild(self.go, "btn_Click")
	self._dragListener = SLFramework.UGUI.UIDragListener.Get(self._goClick)
	self._localCubePosIndex = {
		[1] = -1,
		[2] = -1
	}
	self._canvasgroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function DianJiShiGamePlaceCubeItem:addEventListeners()
	self._dragListener:AddDragBeginListener(self._onDragBegin, self)
	self._dragListener:AddDragListener(self._onDrag, self)
	self._dragListener:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, DianJiShiGameController.instance, DianJiShiGameEvent.OnBeginDragBlock, self._onBeginDragBlock, self)
end

function DianJiShiGamePlaceCubeItem:removeEventListeners()
	self._dragListener:RemoveDragBeginListener()
	self._dragListener:RemoveDragListener()
	self._dragListener:RemoveDragEndListener()
end

function DianJiShiGamePlaceCubeItem:_onDragBegin(param, pointerEventData)
	if DianJiShiGameController.instance:isMultiTouch() then
		return
	end

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnBeginDragBlock, self._blockInfo)
end

function DianJiShiGamePlaceCubeItem:_onDrag(param, pointerEventData)
	if DianJiShiGameController.instance:isMultiTouch() then
		return
	end

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnDragBlock, self._blockInfo)
end

function DianJiShiGamePlaceCubeItem:_onDragEnd(param, pointerEventData)
	if DianJiShiGameController.instance:isMultiTouch() then
		return
	end

	DianJiShiGameController.instance:dispatchEvent(DianJiShiGameEvent.OnEndDragBlock, self._blockInfo)
end

function DianJiShiGamePlaceCubeItem:onUpdateMO(cubeInfo, index, putAnim)
	self._cubeInfo = cubeInfo
	self._posIndex = cubeInfo and cubeInfo.posIndex
	self._blockId = cubeInfo and cubeInfo.blockId
	self._blockInfo = DianJiShiGameModel.instance:getBlockInfoById(self._blockId)
	self._index = index

	if putAnim then
		self._animator:Play("put", 0, 0)
	end

	self:calcLocalCubePos()
	self:refreshUI()
end

function DianJiShiGamePlaceCubeItem:refreshUI()
	gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, true)
	DianJiShiGameController.instance:setCubeIcon(self._blockId, self._localCubePosIndex, self._imageIcon, self._imageFront)
	self:refreshPos()
end

function DianJiShiGamePlaceCubeItem:calcLocalCubePos()
	if self._blockInfo then
		if self._blockInfo then
			if not self._blockInfo[1] then
				local blockPosXIndex = 0

				if self._blockInfo then
					if not self._blockInfo[2] then
						local blockPosYIndex = 0
						local localPosXIndex, localPosYIndex = DianJiShiGameController.instance:globalIndex2CellPosIndex(self._posIndex[1], self._posIndex[2], blockPosXIndex, blockPosYIndex)

						self._localCubePosIndex[1] = localPosXIndex
						self._localCubePosIndex[2] = localPosYIndex
					end
				end
			end
		end
	end
end

function DianJiShiGamePlaceCubeItem:refreshPos()
	if self._posIndex then
		if not self._posIndex[1] then
			local posXIndex = 0

			if self._posIndex then
				if not self._posIndex[2] then
					local posYIndex = 0
					local posX, posY = DianJiShiGameController.instance:posIndex2Pos(posXIndex, posYIndex, true)

					recthelper.setAnchor(self._tran, posX, posY)
				end
			end
		end
	end
end

function DianJiShiGamePlaceCubeItem:_onBeginDragBlock(blockInfo)
	if blockInfo and self._blockId == blockInfo.id then
		gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, false)
	end
end

function DianJiShiGamePlaceCubeItem:setInteract(isInteract)
	self._canvasgroup.blocksRaycasts = isInteract
	self._canvasgroup.interactable = isInteract
end

return DianJiShiGamePlaceCubeItem
