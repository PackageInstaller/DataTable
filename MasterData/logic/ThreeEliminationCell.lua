-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationCell.lua

module("logic.extensions.threeelimination.view.ThreeEliminationCell", package.seeall)

local ThreeEliminationCell = class("ThreeEliminationCell")

ThreeEliminationCell.cellIconPosAndScaleByQuality = {
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	}
}
ThreeEliminationCell.maskPosAndScaleByQuality = {
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	},
	{
		0,
		0,
		1
	}
}

function ThreeEliminationCell:ctor(componetContainer)
	self._container = componetContainer
	self._cellData = nil
	self.moveDistance = 50
	self._x_space = 125
	self._y_space = 125
	self._downPosition = nil
	self._fadeOutTag = false
	self._moveList = Array.New()
end

function ThreeEliminationCell:initCell(cellDat)
	self._cellData = cellDat
	self._activityId = ThreeEliminationModel.instance:getActivityId()
	self._cellCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, self._cellData._type)
	self._container.name = tostring(cellDat._y * 10 + cellDat._x)

	self:onBuildUI()
	self:onBuildEvent()
	self._moveList:Clear()
	self._imgQualityChange:SetState(self._cellCfg.quality - 1)
	MaterialMgr.setIcon(self._imgIcon, MatType.Pet, self._cellCfg.raceId)
end

function ThreeEliminationCell:resetCell(cellDat)
	self._cellData = cellDat

	if cellDat._type ~= self._cellData._type then
		self._cellCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, self._cellData._type)

		MaterialMgr.resetAll(self._imgIcon)
		MaterialMgr.setIcon(self._imgIcon, MatType.Pet, self._cellCfg.raceId)
	end

	self._container.name = tostring(cellDat._y * 10 + cellDat._x)

	self._container.gameObject:SetActive(true)
	GameUtil.setLocalScale(self._container.gameObject, 1, 1, 1)
end

function ThreeEliminationCell:getObj()
	return self._container
end

function ThreeEliminationCell:getType()
	return self._cellData._type
end

function ThreeEliminationCell:getAddType()
	return self._cellData._addType
end

function ThreeEliminationCell:onBuildUI()
	self._imgIcon = goutil.findChild(self._container.gameObject, "imgMask/imgIcon")
	self._imgQualityChange = self._container:GetComponent(ComponentType.UIChangeGroup)
	self._CellBtn = GameUtil.asBtn(self._container.gameObject)
	self._movePos = self._container:GetComponent(UnityTweensType.TweenPosition)
	self._fadeOut = self._container:GetComponent(UnityTweensType.UITweenFadeOut)
	self._drag = Framework.UIDragTrigger.Get(self._container.gameObject)
	self._canvasGroup = self._container:GetComponent(ComponentType.CanvasGroup)
end

function ThreeEliminationCell:onBuildAction(moveByFunc)
	self._moveList:Clear()

	self._moveByFunc = moveByFunc

	local dir = Vector3.New(self._x_space * (self._cellData._x - 1), -self._y_space * (self._cellData._y - 1), 0)

	if self._moveList:IsEmpty() then
		self._movePos.to = dir
		self._movePos.time = 0.1
		self._movePos.delay = 0
		self._movePos.from = GameUtil.getLocalPos(self._container.gameObject)
	end

	local info = {
		delay = 0,
		duration = 0.1,
		to = dir
	}

	self._moveList:PushBack(info)
	self._movePos:Begin()
end

function ThreeEliminationCell:onBuildEvent()
	self._CellBtn:AddClickListener(self._onClickCell, self)
	self._movePos:AddListener(self._moveByFinishCallBack, self)
	self._fadeOut:AddListener(self._fadeOutFinishCallBack, self)

	self._pointerDown = PointerDownHandler.Get(self._container.gameObject):AddLuaHandler(function(obj, eventData)
		self:onPointDown(obj, eventData)
	end)

	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onDragBegin, self)
	self._drag:AddEndDragListener(self._onDragEnd, self)
end

function ThreeEliminationCell:_onClickCell()
	return
end

function ThreeEliminationCell:onChangePos(x, y, moveByFunc)
	self._moveByFunc = moveByFunc
	self._container.name = tostring(y * 10 + x)

	local dir = Vector3.New(self._x_space * (x - 1), -self._y_space * (y - 1), 0)

	if self._moveList:IsEmpty() then
		self._movePos.to = dir
		self._movePos.time = 0.1
		self._movePos.delay = 0
		self._movePos.from = GameUtil.getLocalPos(self._container.gameObject)
	end

	local info = {
		delay = 0,
		duration = 0.1,
		to = dir
	}

	self._moveList:PushBack(info)
	self._movePos:Begin()
end

function ThreeEliminationCell:moveCell(pos, removeFunc, duration, delay)
	self._moveByFunc = removeFunc

	local dir = Vector3.New(pos.x, pos.y, 0)
	local info = {
		to = dir,
		duration = duration or 0.1,
		delay = delay or 0
	}

	self._moveList:PushBack(info)

	if not self._moveList:IsEmpty() then
		local moveInfo = self._moveList:Get(0)

		self._movePos.to = moveInfo.to
		self._movePos.time = moveInfo.duration
		self._movePos.delay = moveInfo.delay
		self._movePos.from = GameUtil.getLocalPos(self._container.gameObject)

		self._movePos:Begin()
	end

	if self._moveByFunc and self._moveList:IsEmpty() then
		self:_moveByFunc()
	end
end

function ThreeEliminationCell:moveAndRemove(pos, removeFunc, duration, delay)
	local function moveFunc()
		self:onRemove(removeFunc)
	end

	self:moveCell(pos, moveFunc, duration, delay)
end

function ThreeEliminationCell:hideCell()
	self._canvasGroup.alpha = 0
end

function ThreeEliminationCell:onRemove(removeFunc)
	self._removeFunc = removeFunc

	self._fadeOut:Begin()

	if self._fadeOutTag == false then
		self._fadeOutTag = true
	end
end

function ThreeEliminationCell:_moveByFinishCallBack()
	self._moveList:PopFront()

	if not self._moveList:IsEmpty() then
		local moveInfo = self._moveList:Get(0)

		self._movePos.to = moveInfo.to
		self._movePos.time = moveInfo.duration
		self._movePos.delay = moveInfo.delay
		self._movePos.from = GameUtil.getLocalPos(self._container.gameObject)

		self._movePos:Begin()
	end

	if self._moveByFunc and self._moveList:IsEmpty() then
		self:_moveByFunc()
	end
end

function ThreeEliminationCell:onPointDown(obj, eventData)
	if not ThreeEliminationController.instance:isCanDoAction() then
		return
	end

	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")

	self._downPosition = goutil.screenToLocalPos(TableUtil.deepcopy(eventData.position), rectTransform)
	self._startPos = GameUtil.getLocalPos(self._container.gameObject)
end

function ThreeEliminationCell:_onDrag(eventData)
	if not ThreeEliminationController.instance:isCanDoAction() or not self._downPosition then
		return
	end

	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	GameUtil.setLocalPos(self._container.gameObject, self._startPos.x + (posEvent.x - self._downPosition.x), self._startPos.y + (posEvent.y - self._downPosition.y), self._startPos.z)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeEliminationCellMove, GameUtil.getLocalPos(self._container.gameObject))
end

function ThreeEliminationCell:_onDragBegin(eventData)
	ThreeEliminationController.instance:checkMoveStateAndTip(true)

	if not ThreeEliminationController.instance:isCanDoAction() or not self._downPosition then
		return
	end

	ThreeEliminationController.instance:addAction(self._cellData)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeEliminationCellMoveStart, self._container.gameObject, self)
	UnityTweens.TweenScale.StartTween(self._container.gameObject, GameUtil.getLocalScale(self._container.gameObject), Vector3(1.2, 1.2, 1.2), 0.2)
end

function ThreeEliminationCell:_onDragEnd(eventData)
	if not ThreeEliminationController.instance:isCanDoAction() or not self._downPosition then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.ThreeEliminationCellMoveEnd, GameUtil.getLocalPos(self._container.gameObject))
	GameUtil.setLocalPos(self._container.gameObject, self._startPos.x, self._startPos.y, self._startPos.z)
	UnityTweens.TweenScale.StartTween(self._container.gameObject, GameUtil.getLocalScale(self._container.gameObject), Vector3(1, 1, 1), 0.2)
end

function ThreeEliminationCell:checkHit(pos)
	local selfPos = GameUtil.getLocalPos(self._container.gameObject)

	if pos.x > selfPos.x - self._x_space / 2 and pos.x < selfPos.x + self._x_space / 2 and pos.y < selfPos.y + self._y_space / 2 and pos.y > selfPos.y - self._y_space / 2 then
		return true
	else
		return false
	end
end

function ThreeEliminationCell:setHitScale()
	UnityTweens.TweenScale.StopTween(self._container.gameObject)
	UnityTweens.TweenScale.StartTween(self._container.gameObject, GameUtil.getLocalScale(self._container.gameObject), Vector3(1.2, 1.2, 1.2), 0.2)
end

function ThreeEliminationCell:resetScale()
	UnityTweens.TweenScale.StopTween(self._container.gameObject)
	UnityTweens.TweenScale.StartTween(self._container.gameObject, GameUtil.getLocalScale(self._container.gameObject), Vector3(1, 1, 1), 0.2)
end

function ThreeEliminationCell:setSwapCell()
	ThreeEliminationController.instance:addAction(self._cellData)
end

function ThreeEliminationCell:addSelEffect()
	if not self._selEffect then
		self._selEffect = UIEffectManager.instance:playHUDEffect("fx_ui_sanxiao/fx_ui_xuanzhong.prefab", self._container.gameObject, true, nil, nil, function(finishHandlerTarget, eff)
			return
		end)

		self._selEffect:setSortingOrder(251)
	end
end

function ThreeEliminationCell:removeSelEffect()
	if self._selEffect then
		UIEffectManager.instance:stopEffect(self._selEffect)

		self._selEffect = nil
	end
end

function ThreeEliminationCell:_fadeOutFinishCallBack()
	if self._removeFunc then
		self:removeSelEffect()
		self:_removeFunc()
	end

	self._fadeOutTag = false

	self._container.gameObject:SetActive(false)
end

function ThreeEliminationCell:returnToPool()
	self:removeSelEffect()
	self._container.gameObject:SetActive(false)
end

function ThreeEliminationCell:onDestroy()
	self:removeSelEffect()
	self._CellBtn:RemoveClickListener()
	MaterialMgr.resetAll(self._imgIcon)
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
	self._movePos:RemoveListener()
	self._fadeOut:RemoveListener()
	PointerDownHandler.Get(self._container.gameObject):RemoveLuaHandler(self._pointerDown)
	goutil.destroy(self._container.gameObject)
end

return ThreeEliminationCell
