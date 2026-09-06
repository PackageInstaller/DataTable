-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameCell.lua

module("logic.extensions.sxgame.view.SxGameCell", package.seeall)

local SxGameCell = class("SxGameCell")

function SxGameCell:ctor(componetContainer)
	self._container = componetContainer
	self._cellData = nil
	self.moveDistance = 50
	self._x_space = 80
	self._y_space = 80
	self._downPosition = nil
	self._fadeOutTag = false
	self._moveList = Array.New()
end

function SxGameCell:initCell(cellDat)
	self._cellData = cellDat
	self._container.name = tostring(cellDat._y * 10 + cellDat._x)

	self:onBuildUI()
	self:onBuildEvent()
	GameUtil.SetActive(self._IceGo, false)

	if self._cellData and self._cellData._addType and #self._cellData._addType > 0 then
		for i, v in pairs(self._cellData._addType) do
			if v == SxGameCellAddType.Ice_1 then
				self._IceImageChange:SetState(0)
				GameUtil.SetActive(self._IceGo, true)
			elseif v == SxGameCellAddType.Ice_2 then
				self._IceImageChange:SetState(1)
				GameUtil.SetActive(self._IceGo, true)
			end
		end
	end

	self._moveList:Clear()
end

function SxGameCell:resetCell(cellDat)
	self._cellData = cellDat
	self._container.name = tostring(cellDat._y * 10 + cellDat._x)
	self._container:GetComponent(goutil.Type_UIImage).color = Color.white

	self._container.gameObject:SetActive(true)
	GameUtil.SetActive(self._IceGo, false)

	if self._cellData and self._cellData._addType and #self._cellData._addType > 0 then
		for i, v in pairs(self._cellData._addType) do
			if v == SxGameCellAddType.Ice_1 then
				self._IceImageChange:SetState(0)
				GameUtil.SetActive(self._IceGo, true)
			elseif v == SxGameCellAddType.Ice_2 then
				self._IceImageChange:SetState(1)
				GameUtil.SetActive(self._IceGo, true)
			end
		end
	end
end

function SxGameCell:getObj()
	return self._container
end

function SxGameCell:getType()
	return self._cellData._type
end

function SxGameCell:getAddType()
	return self._cellData._addType
end

function SxGameCell:onBuildUI()
	self._CellBtn = Framework.ButtonAdapter.Get(self._container.gameObject)
	self._IceGo = goutil.findChild(self._container.gameObject, "imgIce")
	self._IceImageChange = goutil.findChildComponent(self._container.gameObject, "imgIce", "UIImageSpriteChange")
	self._moveBy = self._container:GetComponent(UnityTweensType.TweenPositionBy)
	self._fadeOut = self._container:GetComponent(UnityTweensType.UITweenFadeOut)
	self._drag = Framework.UIDragTrigger.Get(self._container.gameObject)
end

function SxGameCell:onBuildAction(moveByFunc)
	self._moveList:Clear()

	self._moveByFunc = moveByFunc

	local dir = Vector3.New(0, -self._container.transform.localPosition.y + self._y_space * (self._cellData._y - 1), 0)

	if self._moveList:IsEmpty() then
		self._moveBy.positionBy = dir
	end

	self._moveList:PushBack(dir)
	self._moveBy:Begin()
end

function SxGameCell:onBuildEvent()
	self._CellBtn:AddClickListener(self._onClickCell, self)
	self._moveBy:AddListener(self._moveByFinishCallBack, self)
	self._fadeOut:AddListener(self._fadeOutFinishCallBack, self)

	self._pointerDown = PointerDownHandler.Get(self._container.gameObject):AddLuaHandler(function(obj, eventData)
		self:onPointDown(obj, eventData)
	end)

	self._drag:AddDragListener(self._onDrag, self)
end

function SxGameCell:_onClickCell()
	return
end

function SxGameCell:onChangePos(x, y, moveByFunc)
	self._moveByFunc = moveByFunc
	self._container.name = tostring(y * 10 + x)

	local dir = Vector3.New(self._x_space * (x - self._cellData._x), self._y_space * (y - self._cellData._y), 0)

	if self._moveList:IsEmpty() then
		self._moveBy.positionBy = dir
	end

	self._moveList:PushBack(dir)
	self._moveBy:Begin()
end

function SxGameCell:onRemove(removeFunc)
	self._removeFunc = removeFunc

	self._fadeOut:Begin()

	if self._fadeOutTag == false then
		self._fadeOutTag = true

		SxGameModel.instance:addRemoveCount()
	end
end

function SxGameCell:_moveByFinishCallBack()
	self._moveList:PopFront()

	if not self._moveList:IsEmpty() then
		self._moveBy.positionBy = self._moveList:Get(0)

		self._moveBy:Begin()
	end

	if self._moveByFunc and self._moveList:IsEmpty() then
		self._moveByFunc()
	end
end

function SxGameCell:onPointDown(obj, eventData)
	SxGameController.instance:addAction(self._cellData)

	self._downPosition = TableUtil.deepcopy(eventData.position)

	if SxGameController.instance:isCanDoAction() then
		-- block empty
	end
end

function SxGameCell:_onDrag(eventData)
	if not SxGameController.instance:isCanDoAction() or not self._downPosition then
		return
	end

	local x = self._cellData._x
	local y = self._cellData._y

	if eventData.position.x - self._downPosition.x > self.moveDistance then
		self:onDoSwapAction(x + 1, y)

		return
	end

	if eventData.position.x - self._downPosition.x < -self.moveDistance then
		self:onDoSwapAction(x - 1, y)

		return
	end

	if eventData.position.y - self._downPosition.y > self.moveDistance then
		self:onDoSwapAction(x, y + 1)

		return
	end

	if eventData.position.y - self._downPosition.y < -self.moveDistance then
		self:onDoSwapAction(x, y - 1)

		return
	end
end

function SxGameCell:onDoSwapAction(newX, newY)
	self._downPosition = nil

	local x = self._cellData._x
	local y = self._cellData._y

	SxGameModel.instance:removeAction()
	SxGameController.instance:addActionByGuest(x, y)
	SxGameController.instance:addActionByGuest(newX, newY)
end

function SxGameCell:addSelEffect()
	if not self._selEffect then
		self._selEffect = UIEffectManager.instance:playHUDEffect("fx_ui_sanxiao/fx_ui_xuanzhong.prefab", self._container.gameObject, true, nil, nil, function(finishHandlerTarget, eff)
			return
		end)

		self._selEffect:setSortingOrder(251)
	end
end

function SxGameCell:removeSelEffect()
	if self._selEffect then
		UIEffectManager.instance:stopEffect(self._selEffect)

		self._selEffect = nil
	end
end

function SxGameCell:_fadeOutFinishCallBack()
	if self._removeFunc then
		self:removeSelEffect()
		self:_removeFunc()
	end

	self._fadeOutTag = false

	self._container.gameObject:SetActive(false)
end

function SxGameCell:returnToPool()
	self:removeSelEffect()
	self._container.gameObject:SetActive(false)
end

function SxGameCell:onDestroy()
	self:removeSelEffect()
	self._CellBtn:RemoveClickListener()
	PointerDownHandler.Get(self._container.gameObject):RemoveLuaHandler(self._pointerDown)
	goutil.destroy(self._container.gameObject)
end

return SxGameCell
