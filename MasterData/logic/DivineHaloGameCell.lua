-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloGameCell.lua

module("logic.extensions.divinehalogame.view.DivineHaloGameCell", package.seeall)

local DivineHaloGameCell = class("DivineHaloGameCell", ViewComponent)

function DivineHaloGameCell:ctor(luaComponentContainer)
	self._go = luaComponentContainer.gameObject
	self._bgGo = goutil.findChild(self._go, "bg")
	self._bgGo2 = goutil.findChild(self._go, "bg2")
	self._colorChange = self._bgGo:GetComponent(ComponentType.UIImageColorChange)
	self._colorChange2 = self._bgGo2:GetComponent(ComponentType.UIImageColorChange)
	self._spriteChange = self._bgGo:GetComponent(ComponentType.UIImageSpriteChange)
	self._spriteChange2 = self._bgGo2:GetComponent(ComponentType.UIImageSpriteChange)
	self._boundingBox2D = BoundingBox2D.New()
	self._abstractType = 0
	self._width = 0
	self._height = 0
	self._data = nil
	self._abstractType = nil
	self._playerPosType = nil
	self._localPos = Vector3.New(0, 0, 0)
	self._parentOffsetPos = Vector3.New(0, 0, 0)
end

function DivineHaloGameCell:onReset()
	self._abstractType = 0

	self._colorChange:SetState(0)
	self._colorChange2:SetState(0)
	self._spriteChange:SetState(0)
	self._spriteChange2:SetState(0)
end

function DivineHaloGameCell:onDispose()
	self._boundingBox2D = nil
	self._data = nil
	self._abstractType = nil
end

function DivineHaloGameCell:onInit(data)
	self._abstractType = DivineHaloGameModel.instance:getCellAbstractType(data.cellType)
	self._width = data.width
	self._height = data.height
	self._data = data

	if self._abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Player then
		self._rigidBody = self._go:GetComponent(typeof(UnityEngine.Rigidbody2D)) or self._go:AddComponent(typeof(UnityEngine.Rigidbody2D))
		self._rigidBody.gravityScale = 0
	end

	if self._abstractType ~= DivineHaloGameModel.CellAbstarctTypeEnum.Trig then
		local vec2 = UnityEngine.Vector2.New(data.width, data.height)

		self._boxCollider = self._go:GetComponent(typeof("UnityEngine.BoxCollider2D")) or self._go:AddComponent(typeof("UnityEngine.BoxCollider2D"))

		SystemReflexHelp.setBoxCollider2DSize(self._boxCollider, vec2)
	end

	if data.cellType == DivineHaloGameModel.CellTypeEnum.ChangeColor then
		self._colorChange:SetState(0)
	else
		self._colorChange:SetState(data.colorType)
	end

	self._colorChange2:SetState(data.colorType)

	if data.cellType == DivineHaloGameModel.CellTypeEnum.Player then
		self._colorChange:SetState(0)
		self._colorChange2:SetState(0)
	end

	self._spriteChange:SetState(data.cellType)
	self._spriteChange2:SetState(data.cellType)
	GameUtil.setLocalPos(self._go, data.localX, data.localY, data.localZ)
	GameUtil.setLocalRotation(self._go, data.rotateX, data.rotateY, data.rotateZ)
	GameUtil.setWidth(self._go, data.width)
	GameUtil.setHeight(self._go, data.height)
	self._bgGo2:GetComponent(goutil.Type_UIImage):SetNativeSize()
end

function DivineHaloGameCell:getBoundingBox2D()
	if self._abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Wall then
		return
	end

	return self._boundingBox2D
end

function DivineHaloGameCell:updateBoundingBox2D()
	if self._abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Wall then
		return
	end

	self._localPos = DivineHaloGameController.instance:getLocalPos(self._go, self._localPos)

	if self._data.cellType == DivineHaloGameModel.CellTypeEnum.PortalsDoor or self._data.cellType == DivineHaloGameModel.CellTypeEnum.Player then
		self._boundingBox2D:setSize(self._width - 70, self._height - 70)
	else
		self._boundingBox2D:setSize(self._width, self._height)
	end

	if self._abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Trig then
		self._parentOffsetPos = DivineHaloGameController.instance:getLocalPos(self._go.transform.parent.gameObject, self._parentOffsetPos)

		self._boundingBox2D:setCenter(self._localPos.x + self._parentOffsetPos.x, self._localPos.y + self._parentOffsetPos.y)
	else
		self._boundingBox2D:setCenter(self._localPos.x, self._localPos.y)
	end
end

function DivineHaloGameCell:tryTrig(boundBox2D, playerColorType)
	if self._abstractType == DivineHaloGameModel.CellAbstarctTypeEnum.Wall then
		return
	end

	if not boundBox2D or not self._boundingBox2D:intersects(boundBox2D) then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.DivineHaloPlayerEnterTrigCell, self._data.cellType, self._data.colorType, self._data.index)
end

function DivineHaloGameCell:getColorType()
	return self._data and self._data.colorType
end

function DivineHaloGameCell:setColorType(colorType)
	self._data.colorType = colorType
end

function DivineHaloGameCell:setCellType(cellType)
	self._data.cellType = cellType

	self._spriteChange:SetState(cellType)
end

function DivineHaloGameCell:getGo()
	return self._go
end

function DivineHaloGameCell:getRigidbody2D()
	return self._rigidBody
end

function DivineHaloGameCell:getBoxCollider2D()
	return self._boxCollider
end

function DivineHaloGameCell:getData()
	return self._data
end

function DivineHaloGameCell:getAfterOffsetLocalPos()
	self._parentOffsetPos = DivineHaloGameController.instance:getLocalPos(self._go.transform.parent.gameObject, self._parentOffsetPos)
	self._localPos = DivineHaloGameController.instance:getLocalPos(self._go, self._localPos)

	return Vector2(self._localPos.x + self._parentOffsetPos.x, self._localPos.y + self._parentOffsetPos.y)
end

function DivineHaloGameCell:setPlayerPosType(playerPosType)
	if self._abstractType ~= DivineHaloGameModel.CellAbstarctTypeEnum.Player then
		printError("不是玩家类型的cell也设置了playerPosType")

		return
	end

	self._playerPosType = playerPosType
end

function DivineHaloGameCell:getPlayerPosType()
	return self._playerPosType
end

function DivineHaloGameCell:setPlayerVerticalChangeState(changeState)
	if self._abstractType ~= DivineHaloGameModel.CellAbstarctTypeEnum.Player then
		printError("不是玩家类型的cell也设置了playerChangeState")

		return
	end

	self._playerVerticalChangeState = changeState

	return self._playerVerticalChangeState
end

function DivineHaloGameCell:getPlayerVerticalChangeState()
	return self._playerVerticalChangeState
end

function DivineHaloGameCell:setPlayerHorizontalChangeState(changeState)
	if self._abstractType ~= DivineHaloGameModel.CellAbstarctTypeEnum.Player then
		printError("不是玩家类型的cell也设置了playerChangeState")

		return
	end

	self._playerHorizontalChangeState = changeState

	return self._playerHorizontalChangeState
end

function DivineHaloGameCell:getPlayerHorizontalChangeState()
	return self._playerHorizontalChangeState
end

function DivineHaloGameCell:addPlayerLight(playerLightGo)
	if self._abstractType ~= DivineHaloGameModel.CellAbstarctTypeEnum.Player then
		printError("不是玩家类型的cell也添加了playerLightGo进来")

		return
	end

	self._playerLightGo = playerLightGo

	goutil.addChildToParent(playerLightGo, self._go)
	playerLightGo.gameObject.transform:SetSiblingIndex(0)
end

return DivineHaloGameCell
