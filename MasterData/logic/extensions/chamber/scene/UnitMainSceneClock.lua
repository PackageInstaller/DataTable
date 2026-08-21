-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/scene/UnitMainSceneClock.lua

module("logic.extensions.chamber.scene.UnitMainSceneClock", package.seeall)

local M = class("UnitMainSceneClock")
local vec3Temp = Vector3.New()
local kMovePosX, kMovePosY, kMovePosZ = 0.1, 0, 0.1
local kSlotPos = {
	{
		-0.07,
		0.008,
		0.164
	},
	{
		-0.07,
		0.008,
		0.113
	},
	{
		-0.07,
		0.008,
		0.062
	},
	{
		-0.07,
		0.008,
		0.011
	},
	{
		-0.07,
		0.008,
		-0.04
	},
	{
		-0.07,
		0.008,
		-0.091
	}
}

local function _resetTrs(go)
	TransformUtils.SetLocalPosition(go.transform, 0, 0, 0)
	TransformUtils.SetLocalEulerAngles(go.transform, 0, 0, 0)
	TransformUtils.SetLocalScale(go.transform, 1, 1, 1)
end

local blockAnim = true

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_init()
end

function M:OnDestroy()
	self._animationPlayer = nil
end

function M:_init()
	self._doingAction = false
	self._animationPlayer = AnimationPlayer.Get(self._mainGO)
	self._animationPlayer.enabled = not blockAnim

	self._animationPlayer:SetListener(self._onAnimationEvent, self)

	self._goTimePos = goutil.create("time_point", false)

	goutil.addChildToParent(self._goTimePos, goutil.findChild(self._mainGO, "root/Bone001"))
	TransformUtils.SetLocalEulerAngles(self._goTimePos.transform, 0, 0, 90)

	self._arrayLightPosGO = {}
	self._arraySlotPosGO = {}

	for i = 1, ChamberModel.MAX_SLOT_NUM do
		local lightGO = goutil.findChild(self._mainGO, string.format("root/Bone001/Bone002/2436light_%s", i))

		table.insert(self._arrayLightPosGO, lightGO)

		local slotGO = goutil.create("slot_" .. i, false)

		goutil.addChildToParent(slotGO, goutil.findChild(self._mainGO, "root/Bone001/Bone002"))
		TransformUtils.SetLocalPosition(slotGO.transform, kSlotPos[i][1], kSlotPos[i][2], kSlotPos[i][3])
		TransformUtils.SetLocalEulerAngles(slotGO.transform, 0, -90, 90)
		table.insert(self._arraySlotPosGO, slotGO)
	end
end

function M:setChamberList(chamberList, edgeList)
	if chamberList then
		self._dictChamberGO = chamberList

		for idx, go in ipairs(self._dictChamberGO) do
			go.transform:DOKill(false)
			goutil.addChildToParent(go, self._arraySlotPosGO[idx])
			_resetTrs(go)
		end
	else
		self._dictChamberGO = nil
	end

	if edgeList then
		self._arrayChamberEdge = edgeList

		for idx, go in ipairs(self._arrayChamberEdge) do
			goutil.addChildToParent(go, self._arraySlotPosGO[idx])
			_resetTrs(go)
		end
	else
		self._arrayChamberEdge = nil
	end
end

function M:getMainGO()
	return self._mainGO
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:addToTimePos(go)
	goutil.addChildToParent(go, self._goTimePos)
	_resetTrs(go)
end

function M:play(animState, isLoop, isForceRestart, speed)
	if blockAnim then
		return
	end

	if not animState then
		return
	end

	if not isForceRestart and self._isLoop and isLoop and self._curAnimState == animState then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop or false

	local speed = speed or 1

	if self._animationPlayer then
		self._animationPlayer:SetSpeed(speed)
		self._animationPlayer:PlayAnimation(self._curAnimState, self._isLoop, isForceRestart)
	end
end

function M:calculateSlotScreenPos(rect)
	local worldCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local posList = {}

	for i, slotGO in ipairs(self._arraySlotPosGO) do
		vec3Temp:Set(TransformUtils.GetPosition(slotGO.transform, 0, 0, 0))

		local screenPos = worldCamera:WorldToScreenPoint(vec3Temp)
		local uiPos = Astral.GeometryUtil.ScreenToLocalPos(screenPos, rect, uiCamera)

		table.insert(posList, uiPos)
	end

	return posList
end

function M:refreshChamber(force)
	if force then
		self._doingAction = false
	elseif self._doingAction then
		return
	end

	local isOpen = ChamberModel.instance:isClockOpen()
	local selectedIdx = ChamberModel.instance:getSelectedIdx()
	local isEmpty = true
	local mo = ChamberModel.instance:getSlot(selectedIdx)

	if mo and mo:getItemUUID() then
		isEmpty = false
	end

	if self._dictChamberGO then
		for i = 1, ChamberModel.MAX_SLOT_NUM do
			local go = self._dictChamberGO[i]

			go.transform:DOKill(false)

			local showEmpty = false

			if isOpen and selectedIdx == i and isEmpty then
				TransformUtils.SetLocalPosition(go.transform, kMovePosX, kMovePosY, kMovePosZ)

				showEmpty = true
			else
				TransformUtils.SetLocalPosition(go.transform, 0, 0, 0)
			end

			local mo = ChamberModel.instance:getSlot(i)

			if mo:getItemUUID() or showEmpty then
				goutil.setActive(go, true)
			else
				goutil.setActive(go, false)
			end
		end
	end

	if self._arrayChamberEdge then
		for i = 1, ChamberModel.MAX_SLOT_NUM do
			local go = self._arrayChamberEdge[i]

			if isOpen and selectedIdx == i then
				goutil.setActive(go, true)
			else
				goutil.setActive(go, false)
			end
		end
	end
end

function M:playIdle()
	local inAirtightTime, inTimeByItem = AirtightRoomController.instance:getAirtightTimeInfo()

	if inAirtightTime then
		-- block empty
	end

	ChamberModel.instance:setAnimState(SeasonEnum.ClockAnim.Idle)
end

function M:addLights(lights)
	for i, light in ipairs(lights) do
		local posGO = self._arrayLightPosGO[i]

		goutil.addChildToParent(light:getMainGO(), posGO)
		light:resetTrs()
	end
end

function M:doChamberAction(type, targetIdx, otherIdx)
	local isOpen = ChamberModel.instance:isClockOpen()

	if not isOpen then
		return
	end

	self._doingAction = true

	local function _actionEnd()
		self._doingAction = false

		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ACTION_FINISHED)
	end

	if type == SeasonEnum.ClockAction.Mount then
		self:_doAdd(targetIdx, _actionEnd)
	elseif type == SeasonEnum.ClockAction.Unmount then
		self:_doMove(targetIdx, _actionEnd)
	elseif type == SeasonEnum.ClockAction.Exchange then
		self:_doExchange(targetIdx, otherIdx, _actionEnd)
	elseif type == SeasonEnum.ClockAction.ExchangeWithSelf then
		self:_doMove(otherIdx)
		self:_doExchange(targetIdx, targetIdx, _actionEnd)
	end
end

function M:_doAdd(idx, callback)
	if self._dictChamberGO then
		local go = self._dictChamberGO[idx]

		go.transform:DOKill(false)
		TransformUtils.SetLocalPosition(go.transform, kMovePosX, kMovePosY, kMovePosZ)
		goutil.setActive(go, true)
		vec3Temp:Set(0, 0, 0)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:AppendInterval(0.5)
		sequence:Append(go.transform:DOLocalMove(vec3Temp, 1):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:AppendCallback(callback)
		sequence:SetAutoKill(true)
		sequence:SetTarget(go)

		return sequence
	end
end

function M:_doMove(idx, callback, showUnactive)
	if self._dictChamberGO then
		local go = self._dictChamberGO[idx]

		go.transform:DOKill(false)
		TransformUtils.SetLocalPosition(go.transform, 0, 0, 0)
		goutil.setActive(go, true)
		vec3Temp:Set(kMovePosX, kMovePosY, kMovePosZ)

		local sequence = DG.Tweening.DOTween.Sequence()

		sequence:Append(go.transform:DOLocalMove(vec3Temp, 1):SetEase(DG.Tweening.Ease.OutBack, 1))
		sequence:AppendInterval(0.1)
		sequence:AppendCallback(function()
			goutil.setActive(go, false)
		end)

		if showUnactive then
			sequence:AppendInterval(0.3)
		end

		sequence:AppendCallback(function()
			if callback then
				callback()
			end
		end)
		sequence:SetAutoKill(true)
		sequence:SetTarget(go)

		return sequence
	end
end

function M:_doExchange(targetIdx, otherIdx, callback)
	self:_doMove(otherIdx, function()
		self:_doAdd(targetIdx, callback)
	end, true)
end

function M:_onAnimationEvent(animationName)
	if animationName == SeasonEnum.ClockAnim.Open then
		ChamberModel.instance:setIsClockOpen(true)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ANIM_OPEN_FINISHED, self)
		self:play(SeasonEnum.ClockAnim.Loop, true)
		ChamberModel.instance:setAnimState(SeasonEnum.ClockAnim.Loop)
	elseif animationName == SeasonEnum.ClockAnim.Close then
		self:playIdle()
	end
end

return M
