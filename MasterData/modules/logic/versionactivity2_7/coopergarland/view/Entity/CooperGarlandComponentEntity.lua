-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/Entity/CooperGarlandComponentEntity.lua

module("modules.logic.versionactivity2_7.coopergarland.view.Entity.CooperGarlandComponentEntity", package.seeall)

local CooperGarlandComponentEntity = class("CooperGarlandComponentEntity", LuaCompBase)

function CooperGarlandComponentEntity:ctor(param)
	self.mapId = param.mapId
	self.componentId = param.componentId
	self.componentType = param.componentType

	local strParam = CooperGarlandConfig.instance:getMapComponentExtraParams(self.mapId, self.componentId)

	self.extraParam = string.splitToNumber(strParam, "#")
	self.spikeMoveSpeed = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.SpikeMoveSpeed, true)
end

function CooperGarlandComponentEntity:init(go)
	self.go = go
	self.trans = go.transform
	self.animator = self.go:GetComponent(typeof(UnityEngine.Animator))

	if self.animator then
		self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	end

	self:onInit()
end

function CooperGarlandComponentEntity:onInit()
	local isWall = self.componentType == CooperGarlandEnum.ComponentType.Wall
	local posX, posY = CooperGarlandConfig.instance:getMapComponentPos(self.mapId, self.componentId)
	local posZ = CooperGarlandGameEntityMgr.instance:getCompPosZ(isWall)

	transformhelper.setLocalPos(self.trans, posX, posY, posZ)

	self.originalPos = {
		x = posX,
		y = posY,
		z = posZ
	}

	local rotation = CooperGarlandConfig.instance:getMapComponentRotation(self.mapId, self.componentId)

	transformhelper.setEulerAngles(self.trans, 0, 0, rotation)

	local scale = CooperGarlandConfig.instance:getMapComponentScale(self.mapId, self.componentId)

	transformhelper.setLocalScale(self.trans, scale, scale, 1)

	local width, height = CooperGarlandConfig.instance:getMapComponentSize(self.mapId, self.componentId)

	recthelper.setSize(self.trans, width, height)

	self._collider = gohelper.onceAddComponent(self.go, typeof(UnityEngine.BoxCollider))

	local w, h = CooperGarlandConfig.instance:getMapComponentColliderSize(self.mapId, self.componentId)
	local sizeZ = CooperGarlandGameEntityMgr.instance:getCompColliderSizeZ()

	self._collider.size = Vector3(w, h, sizeZ)

	local isDoor = self.componentType == CooperGarlandEnum.ComponentType.Door
	local offsetX, offsetY = CooperGarlandConfig.instance:getMapComponentColliderOffset(self.mapId, self.componentId)
	local offsetZ = CooperGarlandGameEntityMgr.instance:getCompColliderOffsetZ(isWall)

	self._collider.center = Vector3(offsetX, offsetY, offsetZ)
	self._collider.isTrigger = not isWall and not isDoor

	if self.componentType == CooperGarlandEnum.ComponentType.Hole or self.componentType == CooperGarlandEnum.ComponentType.Spike then
		self._goRemoveModeVx = gohelper.findChild(self.go, "image_vx")

		local goClick = gohelper.findChild(self.go, "#go_click")

		self._click = ZProj.BoxColliderClickListener.Get(goClick)

		self._click:SetIgnoreUI(true)
	end

	self:reset()
end

function CooperGarlandComponentEntity:addEventListeners()
	if self._click then
		self._click:AddClickListener(self._onClick, self)
	end

	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, self._onBallKeyChange, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, self._onRemoveModeChange, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnGameStopChange, self._onGameStopChange, self)
end

function CooperGarlandComponentEntity:removeEventListeners()
	if self._click then
		self._click:RemoveClickListener()
	end

	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, self._onBallKeyChange, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, self._onRemoveModeChange, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnGameStopChange, self._onGameStopChange, self)
end

function CooperGarlandComponentEntity:_onClick()
	if self._isDead then
		return
	end

	local forceClickCompId = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.CooperGarlandForceRemove)

	if forceClickCompId and self.componentId ~= tonumber(forceClickCompId) then
		return
	end

	CooperGarlandController.instance:removeComponent(self.mapId, self.componentId)
end

function CooperGarlandComponentEntity:onTriggerEnter(other)
	if self._isDead then
		return
	end

	CooperGarlandController.instance:triggerEnterComponent(self.mapId, self.componentId)
end

function CooperGarlandComponentEntity:onTriggerExit(other)
	if self._isDead then
		return
	end

	CooperGarlandController.instance:triggerExitComponent(self.mapId, self.componentId)
end

function CooperGarlandComponentEntity:_onBallKeyChange()
	if self._isDead then
		return
	end

	self:refreshDoorCollider()
end

function CooperGarlandComponentEntity:_onRemoveModeChange()
	if self._isDead then
		return
	end

	self:refreshRemoveMode()
end

function CooperGarlandComponentEntity:_onGameStopChange()
	if self.componentType ~= CooperGarlandEnum.ComponentType.Spike or #self.extraParam <= 0 then
		return
	end

	local isStopGame = CooperGarlandGameModel.instance:getIsStopGame()

	if isStopGame then
		self:killTween()
	elseif not self.moveTweenId then
		local dir = self.extraParam[1]
		local x, y, _ = transformhelper.getLocalPos(self.trans)

		if self._moveParam then
			local from = self._moveParam.from

			if self._moveParam then
				local to = self._moveParam.to

				self:beginMove(dir == CooperGarlandEnum.Const.SpikeMoveDirX and x or y, from, to)
			end
		end
	end
end

function CooperGarlandComponentEntity:refresh()
	self:refreshDoorCollider()
	self:refreshRemoveMode()
end

function CooperGarlandComponentEntity:refreshDoorCollider()
	local isDoor = self.componentType == CooperGarlandEnum.ComponentType.Door

	if not isDoor then
		return
	end

	if self._collider then
		self._collider.isTrigger = CooperGarlandGameModel.instance:getBallHasKey()
	end
end

function CooperGarlandComponentEntity:refreshRemoveMode()
	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(self._goRemoveModeVx, isRemoveMode)
end

function CooperGarlandComponentEntity:beginMove(argsBeginPos, argsFrom, argsTo)
	local isStopGame = CooperGarlandGameModel.instance:getIsStopGame()

	if isStopGame or self.moveTweenId or self.componentType ~= CooperGarlandEnum.ComponentType.Spike or #self.extraParam <= 0 then
		return
	end

	local dir = self.extraParam[1]
	local isMoveX = dir == CooperGarlandEnum.Const.SpikeMoveDirX
	local to = argsTo or self.extraParam[2]

	if not argsFrom then
		::label_15_0::

		if isMoveX then
			if not self.originalPos.x then
				local from = self.originalPos.y
				local time = math.abs(to - (argsBeginPos or from)) / self.spikeMoveSpeed

				self._moveParam = {
					dir = dir,
					from = from,
					to = to
				}
				self.moveTweenId = isMoveX and ZProj.TweenHelper.DOAnchorPosX(self.trans, to, time, self._movePingPong, self, self._moveParam, EaseType.Linear) or ZProj.TweenHelper.DOAnchorPosY(self.trans, to, time, self._movePingPong, self, self._moveParam, EaseType.Linear)
			end
		end
	end
end

function CooperGarlandComponentEntity:_movePingPong(param)
	local dir = param.dir
	local from = param.from
	local to = param.to
	local time = math.abs(from - to) / self.spikeMoveSpeed

	self._moveParam = {
		dir = dir,
		from = to,
		to = from
	}
	self.moveTweenId = dir == CooperGarlandEnum.Const.SpikeMoveDirX and ZProj.TweenHelper.DOAnchorPosX(self.trans, from, time, self._movePingPong, self, self._moveParam, EaseType.Linear) or ZProj.TweenHelper.DOAnchorPosY(self.trans, from, time, self._movePingPong, self, self._moveParam, EaseType.Linear)
end

function CooperGarlandComponentEntity:setRemoved()
	self._isDead = true

	self:killTween()

	if self.animatorPlayer then
		self.animator.speed = 1

		self.animatorPlayer:Play("out", self._playRemoveAnimFinish, self)
	else
		self:_playRemoveAnimFinish()
	end
end

function CooperGarlandComponentEntity:_playRemoveAnimFinish()
	gohelper.setActive(self.go, false)
end

function CooperGarlandComponentEntity:getWorldPos()
	return self.trans and self.trans.position
end

function CooperGarlandComponentEntity:reset()
	local isStoryCompFinished = CooperGarlandGameModel.instance:isFinishedStoryComponent(self.mapId, self.componentId)

	if isStoryCompFinished then
		return
	end

	self._isDead = false
	self._moveParam = nil

	self:refresh()
	self:killTween()
	transformhelper.setLocalPos(self.trans, self.originalPos.x, self.originalPos.y, self.originalPos.z)
	self:beginMove()
	gohelper.setActive(self.go, true)

	if self.animator then
		self.animator.enabled = true
		self.animator.speed = 0

		self.animator:Play("out", 0, 0)
	end
end

function CooperGarlandComponentEntity:killTween()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end
end

function CooperGarlandComponentEntity:getIsRemoved()
	return self._isDead
end

function CooperGarlandComponentEntity:destroy()
	self:killTween()
	self:removeEventListeners()

	self._moveParam = nil

	gohelper.destroy(self.go)
end

function CooperGarlandComponentEntity:onDestroy()
	return
end

return CooperGarlandComponentEntity
