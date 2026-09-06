-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloGameMapMoveCtrl.lua

module("logic.extensions.divinehalogame.view.DivineHaloGameMapMoveCtrl", package.seeall)

local DivineHaloGameMapMoveCtrl = class("DivineHaloGameMapMoveCtrl", ViewComponent)
local Move_Type_Speed_Enum = {
	QuickMove = 5,
	SlowMove = 4,
	DontMove = 0
}

function DivineHaloGameMapMoveCtrl:ctor(luaComponentContainer)
	self._go = luaComponentContainer.gameObject
	self._tempLocalPos = Vector3.New(0, 0, 0)
	self._playerLocalPos = Vector3.New(0, 0, 0)
	self._leftUpWallPos = Vector3.New(0, 0, 0)
	self._rightDownWallPos = Vector3.New(0, 0, 0)
	self.leftUpMapPos = Vector3.New(0, 0, 0)
	self.rightDownMapPos = Vector3.New(0, 0, 0)
	self.leftUpChangeMoveModePos = Vector3.New(0, 0, 0)
	self.rightDownChangeMoveModePos = Vector3.New(0, 0, 0)
	self._wallRootPos = Vector3.New(0, 0, 0)
	self._cellRootPos = Vector3.New(0, 0, 0)
end

function DivineHaloGameMapMoveCtrl:onReset()
	return
end

function DivineHaloGameMapMoveCtrl:onInit(sameParentGo, playerGo, leftUpMapGo, rightDownMapGo, leftUpChangeMoveModeGo, rightDownChangeMoveModeGo, cellRootGo, wallRootGo, bgRootGo, mapWidth, mapHeight)
	self._sameParentGo = sameParentGo
	self._playerGo = playerGo
	self._playerRigidBody = self._playerGo:AddComponent(typeof("UnityEngine.BoxCollider2D"))
	self._cellRoot = cellRootGo
	self._wallRoot = wallRootGo
	self._bgRoot = bgRootGo
	self._mapWidth = mapWidth
	self._mapHeight = mapHeight
	self._mapLayerNum = self:_getToSameParentLayerNum(self._go)
	self._playerLayerNum = self:_getToSameParentLayerNum(playerGo)
	self._mapSideGoLayerNum = self:_getToSameParentLayerNum(leftUpMapGo)
	self._changeMoveModeGoLayerNum = self:_getToSameParentLayerNum(leftUpChangeMoveModeGo)
	self._wallRootNum = self:_getToSameParentLayerNum(self._wallRoot)
	self._playerLocalPos = self:_getLocalPosUntillSameParentLayer(self._go, self._playerLayerNum, self._playerLocalPos)
	self._leftUpWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._leftUpWallPos)
	self._leftUpWallPos = self:_vec3Add(self._leftUpWallPos, -self._mapWidth / 2, self._mapHeight / 2, 0)
	self._rightDownWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._rightDownWallPos)
	self._rightDownWallPos = self:_vec3Add(self._rightDownWallPos, self._mapWidth / 2, -self._mapHeight / 2, 0)
	self.leftUpMapPos = self:_getLocalPosUntillSameParentLayer(leftUpMapGo, self._mapSideGoLayerNum, self.leftUpMapPos)
	self.rightDownMapPos = self:_getLocalPosUntillSameParentLayer(rightDownMapGo, self._mapSideGoLayerNum, self.rightDownMapPos)
	self.leftUpChangeMoveModePos = self:_getLocalPosUntillSameParentLayer(leftUpChangeMoveModeGo, self._changeMoveModeGoLayerNum, self.leftUpChangeMoveModePos)
	self.rightDownChangeMoveModePos = self:_getLocalPosUntillSameParentLayer(rightDownChangeMoveModeGo, self._changeMoveModeGoLayerNum, self.rightDownChangeMoveModePos)
end

function DivineHaloGameMapMoveCtrl:tryTrig(directionX, directionY, playerPosType, playerChangeStateHorizontal, playerChangeStateVertical, rushingHorizontal, rushingVertical)
	self._playerLocalPos = self:_getLocalPosUntillSameParentLayer(self._playerGo, self._playerLayerNum, self._playerLocalPos)
	self._leftUpWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._leftUpWallPos)
	self._leftUpWallPos = self:_vec3Add(self._leftUpWallPos, -self._mapWidth / 2, self._mapHeight / 2, 0)
	self._rightDownWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._rightDownWallPos)
	self._rightDownWallPos = self:_vec3Add(self._rightDownWallPos, self._mapWidth / 2, -self._mapHeight / 2, 0)
	self._rushingHorizontal = rushingHorizontal
	self._rushingVertical = rushingVertical

	local wallHorizontalIsSide = self:_isOnHorizontalSide(self._leftUpWallPos, self._rightDownWallPos)
	local wallVerticalIsSide = self:_isOnVerticalSide(self._leftUpWallPos, self._rightDownWallPos)
	local moveSpeedType = Move_Type_Speed_Enum.DontMove

	if playerPosType == DivineHaloGameModel.PlayerPosType.Middle then
		moveSpeedType = Move_Type_Speed_Enum.SlowMove
	elseif playerPosType == DivineHaloGameModel.PlayerPosType.Side then
		moveSpeedType = Move_Type_Speed_Enum.QuickMove
	end

	self._wallRootPos = DivineHaloGameController.instance:getLocalPos(self._wallRoot, self._wallRootPos)
	self._cellRootPos = DivineHaloGameController.instance:getLocalPos(self._cellRoot, self._cellRootPos)

	if not rushingHorizontal then
		if wallHorizontalIsSide ~= DivineHaloGameModel.Map_Horizontal_Is_Side.None then
			GlobalDispatcher:dispatch(GlobalNotify.DivineHaloPlayerMoveEveryWhere, DivineHaloGameModel.PlayerChangeState.ToOutHorizontal)

			local finalWallMovePosX = self._wallRootPos.x
			local finalCellMovePosX = self._cellRootPos.x
			local isTowardsSideLeft = directionX < 0 and wallHorizontalIsSide == DivineHaloGameModel.Map_Horizontal_Is_Side.Left
			local isTowardsSideRight = directionX > 0 and wallHorizontalIsSide == DivineHaloGameModel.Map_Horizontal_Is_Side.Right

			if playerChangeStateHorizontal == DivineHaloGameModel.PlayerChangeState.ToInHorizontal and not isTowardsSideLeft and not isTowardsSideRight then
				finalWallMovePosX = self._wallRootPos.x - directionX * Move_Type_Speed_Enum.SlowMove
				finalCellMovePosX = self._cellRootPos.x - directionX * Move_Type_Speed_Enum.SlowMove
			end

			GameUtil.setLocalPos(self._wallRoot, finalWallMovePosX, self._wallRootPos.y, self._wallRootPos.z)
			GameUtil.setLocalPos(self._cellRoot, finalCellMovePosX, self._cellRootPos.y, self._cellRootPos.z)
			GameUtil.setLocalPos(self._bgRoot, finalCellMovePosX, self._cellRootPos.y, self._cellRootPos.z)
		else
			GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x - directionX * moveSpeedType, self._wallRootPos.y, self._wallRootPos.z)
			GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x - directionX * moveSpeedType, self._cellRootPos.y, self._cellRootPos.z)
			GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x - directionX * moveSpeedType, self._cellRootPos.y, self._cellRootPos.z)
		end
	end

	self._wallRootPos = DivineHaloGameController.instance:getLocalPos(self._wallRoot, self._wallRootPos)
	self._cellRootPos = DivineHaloGameController.instance:getLocalPos(self._cellRoot, self._cellRootPos)

	if not rushingVertical then
		if wallVerticalIsSide ~= DivineHaloGameModel.Map_Vertical_Is_Side.None then
			GlobalDispatcher:dispatch(GlobalNotify.DivineHaloPlayerMoveEveryWhere, DivineHaloGameModel.PlayerChangeState.ToOutVertical)

			local finalWallMovePosY = self._wallRootPos.y
			local finalCellMovePosY = self._cellRootPos.y
			local isTowardsSideUp = directionY > 0 and wallVerticalIsSide == DivineHaloGameModel.Map_Vertical_Is_Side.Top
			local isTowardsSideDown = directionY < 0 and wallVerticalIsSide == DivineHaloGameModel.Map_Vertical_Is_Side.Bottom

			if playerChangeStateVertical == DivineHaloGameModel.PlayerChangeState.ToInVertical and not isTowardsSideUp and not isTowardsSideDown then
				finalWallMovePosY = self._wallRootPos.y - directionY * Move_Type_Speed_Enum.SlowMove
				finalCellMovePosY = self._cellRootPos.y - directionY * Move_Type_Speed_Enum.SlowMove
			end

			GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x, finalWallMovePosY, self._wallRootPos.z)
			GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x, finalCellMovePosY, self._cellRootPos.z)
			GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x, finalCellMovePosY, self._cellRootPos.z)
		else
			GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x, self._wallRootPos.y - directionY * moveSpeedType, self._wallRootPos.z)
			GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x, self._cellRootPos.y - directionY * moveSpeedType, self._cellRootPos.z)
			GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x, self._cellRootPos.y - directionY * moveSpeedType, self._cellRootPos.z)
		end
	end
end

function DivineHaloGameMapMoveCtrl:_getToSameParentLayerNum(go)
	local layerNum = 1
	local parent = go.transform.parent.gameObject
	local parentName = parent.name

	while parentName ~= self._sameParentGo.name and parentName ~= "UIROOT" do
		layerNum = layerNum + 1
		parent = parent.transform.parent.gameObject
		parentName = parent.name
	end

	if parentName == "TOP" then
		printError("没有找到与sameParentGo同名的parent，找到UIROOT了都没找到")

		return false
	end

	return layerNum
end

function DivineHaloGameMapMoveCtrl:_getLocalPosUntillSameParentLayer(go, layerNum, vec)
	self._tempLocalPos:Set(0, 0, 0)

	local parent = go

	for i = 1, layerNum do
		local var_6_0, var_6_1, var_6_2 = Framework.TransformUtil.GetLocalPos(parent.transform, 0, 0, 0)

		self._tempLocalPos:Set(self._tempLocalPos.x + var_6_0, self._tempLocalPos.y + var_6_1, self._tempLocalPos.z + var_6_2)

		parent = parent.transform.parent.gameObject
	end

	vec:Set(self._tempLocalPos.x, self._tempLocalPos.y, self._tempLocalPos.z)

	return vec
end

function DivineHaloGameMapMoveCtrl:_vec3Add(vec, x, y, z)
	vec:Set(vec.x + x, vec.y + y, vec.z + z)

	return vec
end

function DivineHaloGameMapMoveCtrl:_isOnHorizontalSide(leftUpPos, rightDownPos)
	local leftPos = leftUpPos.x
	local rightPos = rightDownPos.x

	if leftPos >= self.leftUpMapPos.x then
		return DivineHaloGameModel.Map_Horizontal_Is_Side.Left
	end

	if rightPos <= self.rightDownMapPos.x then
		return DivineHaloGameModel.Map_Horizontal_Is_Side.Right
	end

	return DivineHaloGameModel.Map_Horizontal_Is_Side.None
end

function DivineHaloGameMapMoveCtrl:_isOnVerticalSide(leftUpPos, rightDownPos)
	local upPos = leftUpPos.y
	local downPos = rightDownPos.y

	if upPos <= self.leftUpMapPos.y then
		return DivineHaloGameModel.Map_Vertical_Is_Side.Top
	end

	if downPos >= self.rightDownMapPos.y then
		return DivineHaloGameModel.Map_Vertical_Is_Side.Bottom
	end

	return DivineHaloGameModel.Map_Vertical_Is_Side.None
end

function DivineHaloGameMapMoveCtrl:trigMapChase(diffPos)
	self._wallRootPos = DivineHaloGameController.instance:getLocalPos(self._wallRoot, self._wallRootPos)
	self._cellRootPos = DivineHaloGameController.instance:getLocalPos(self._cellRoot, self._cellRootPos)
	self._leftUpWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._leftUpWallPos)
	self._leftUpWallPos = self:_vec3Add(self._leftUpWallPos, -self._mapWidth / 2, self._mapHeight / 2, 0)
	self._rightDownWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._rightDownWallPos)
	self._rightDownWallPos = self:_vec3Add(self._rightDownWallPos, self._mapWidth / 2, -self._mapHeight / 2, 0)

	local afterLeftUpPos = self._leftUpWallPos - diffPos
	local afterRightDownPos = self._rightDownWallPos - diffPos
	local wallHorizontalIsSide = self:_isOnHorizontalSide(self._leftUpWallPos, self._rightDownWallPos)
	local wallVerticalIsSide = self:_isOnVerticalSide(self._leftUpWallPos, self._rightDownWallPos)
	local nextHorizontalIsSide = self:_isOnHorizontalSide(afterLeftUpPos, afterRightDownPos)
	local nextVerticalIsSide = self:_isOnVerticalSide(afterLeftUpPos, afterRightDownPos)

	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerGo, self._playerLocalPos)

	if wallHorizontalIsSide == DivineHaloGameModel.Map_Horizontal_Is_Side.None or nextHorizontalIsSide == DivineHaloGameModel.Map_Horizontal_Is_Side.None or nextHorizontalIsSide ~= wallHorizontalIsSide or self._playerLocalPos.x < self.leftUpMapPos.x or self._playerLocalPos.x > self.rightDownMapPos.x then
		GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x - diffPos.x, self._wallRootPos.y, self._wallRootPos.z)
		GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x - diffPos.x, self._cellRootPos.y, self._cellRootPos.z)
		GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x - diffPos.x, self._cellRootPos.y, self._cellRootPos.z)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseHorizontal, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseHorizontal, false)
	end

	self._wallRootPos = DivineHaloGameController.instance:getLocalPos(self._wallRoot, self._wallRootPos)
	self._cellRootPos = DivineHaloGameController.instance:getLocalPos(self._cellRoot, self._cellRootPos)

	if wallVerticalIsSide == DivineHaloGameModel.Map_Vertical_Is_Side.None or nextVerticalIsSide == DivineHaloGameModel.Map_Vertical_Is_Side.None or nextVerticalIsSide ~= wallVerticalIsSide or self._playerLocalPos.y < self.rightDownMapPos.y or self._playerLocalPos.y > self.leftUpMapPos.y then
		GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x, self._wallRootPos.y - diffPos.y, self._wallRootPos.z)
		GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x, self._cellRootPos.y - diffPos.y, self._cellRootPos.z)
		GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x, self._cellRootPos.y - diffPos.y, self._cellRootPos.z)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseVertical, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseVertical, false)
	end
end

function DivineHaloGameMapMoveCtrl:mapChase(diffPos)
	self._wallRootPos = DivineHaloGameController.instance:getLocalPos(self._wallRoot, self._wallRootPos)
	self._cellRootPos = DivineHaloGameController.instance:getLocalPos(self._cellRoot, self._cellRootPos)
	self._leftUpWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._leftUpWallPos)
	self._leftUpWallPos = self:_vec3Add(self._leftUpWallPos, -self._mapWidth / 2, self._mapHeight / 2, 0)
	self._rightDownWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._rightDownWallPos)
	self._rightDownWallPos = self:_vec3Add(self._rightDownWallPos, self._mapWidth / 2, -self._mapHeight / 2, 0)

	local afterLeftUpPos = self._leftUpWallPos - diffPos
	local afterRightDownPos = self._rightDownWallPos - diffPos
	local wallHorizontalIsSide = self:_isOnHorizontalSide(self._leftUpWallPos, self._rightDownWallPos)
	local wallVerticalIsSide = self:_isOnVerticalSide(self._leftUpWallPos, self._rightDownWallPos)
	local nextHorizontalIsSide = self:_isOnHorizontalSide(afterLeftUpPos, afterRightDownPos)
	local nextVerticalIsSide = self:_isOnVerticalSide(afterLeftUpPos, afterRightDownPos)

	if wallHorizontalIsSide == DivineHaloGameModel.Map_Horizontal_Is_Side.None or nextHorizontalIsSide == DivineHaloGameModel.Map_Horizontal_Is_Side.None or nextHorizontalIsSide ~= wallHorizontalIsSide then
		GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x - diffPos.x, self._wallRootPos.y, self._wallRootPos.z)
		GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x - diffPos.x, self._cellRootPos.y, self._cellRootPos.z)
		GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x - diffPos.x, self._cellRootPos.y, self._cellRootPos.z)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseHorizontal, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseHorizontal, false)
	end

	self._wallRootPos = DivineHaloGameController.instance:getLocalPos(self._wallRoot, self._wallRootPos)
	self._cellRootPos = DivineHaloGameController.instance:getLocalPos(self._cellRoot, self._cellRootPos)

	if wallVerticalIsSide == DivineHaloGameModel.Map_Vertical_Is_Side.None or nextVerticalIsSide == DivineHaloGameModel.Map_Vertical_Is_Side.None or nextVerticalIsSide ~= wallVerticalIsSide then
		GameUtil.setLocalPos(self._wallRoot, self._wallRootPos.x, self._wallRootPos.y - diffPos.y, self._wallRootPos.z)
		GameUtil.setLocalPos(self._cellRoot, self._cellRootPos.x, self._cellRootPos.y - diffPos.y, self._cellRootPos.z)
		GameUtil.setLocalPos(self._bgRoot, self._cellRootPos.x, self._cellRootPos.y - diffPos.y, self._cellRootPos.z)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseVertical, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DivineHaloMapCanChaseVertical, false)
	end
end

function DivineHaloGameMapMoveCtrl:getStillNeedChase()
	self._leftUpWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._leftUpWallPos)
	self._leftUpWallPos = self:_vec3Add(self._leftUpWallPos, -self._mapWidth / 2, self._mapHeight / 2, 0)
	self._rightDownWallPos = self:_getLocalPosUntillSameParentLayer(self._wallRoot, self._wallRootNum, self._rightDownWallPos)
	self._rightDownWallPos = self:_vec3Add(self._rightDownWallPos, self._mapWidth / 2, -self._mapHeight / 2, 0)

	local wallHorizontalIsSide = self:_isOnHorizontalSide(self._leftUpWallPos, self._rightDownWallPos)
	local wallVerticalIsSide = self:_isOnVerticalSide(self._leftUpWallPos, self._rightDownWallPos)

	self._playerLocalPos = DivineHaloGameController.instance:getLocalPos(self._playerGo, self._playerLocalPos)

	local isSide = wallHorizontalIsSide ~= DivineHaloGameModel.Map_Horizontal_Is_Side.None and wallVerticalIsSide ~= DivineHaloGameModel.Map_Vertical_Is_Side.None
	local playerIsInMiddle = self._playerLocalPos == Vector3.zero

	return not isSide and not playerIsInMiddle
end

function DivineHaloGameMapMoveCtrl:playerIsInScreen()
	return self._playerLocalPos.x >= self._leftUpWallPos.x and self._playerLocalPos.x <= self._rightDownWallPos.x and self._playerLocalPos.y <= self._leftUpWallPos.y and self._playerLocalPos.y >= self._rightDownWallPos.y
end

return DivineHaloGameMapMoveCtrl
