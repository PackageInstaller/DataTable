-- chunkname: @modules/logic/scene/udimo/entity/UdimoEntity.lua

module("modules.logic.scene.udimo.entity.UdimoEntity", package.seeall)

local UdimoEntity = class("UdimoEntity", BaseUnitSpawn)

function UdimoEntity:ctor(udimoId)
	self.id = udimoId
end

function UdimoEntity:init(go)
	UdimoEntity.super.init(self, go)

	self.trans = go.transform

	self:_initPos()
end

function UdimoEntity:_initPos()
	self._zLevel = UdimoHelper.getUdimoZLevel(self.id)

	local leftX, rightX = UdimoHelper.getUdimoXRange(self.id)
	local x = math.random(leftX * 100, rightX * 100) / 100
	local y = UdimoHelper.getUdimoYLevel(self.id)
	local udimoType = UdimoConfig.instance:getUdimoType(self.id)

	if udimoType == UdimoEnum.UdimoType.Air then
		local scene = UdimoController.instance:getUdimoScene()

		if scene then
			::label_3_0::

			local airPointPos = scene.stayPoint:getAirPointPos(self.id, nil, self._zLevel)

			x = airPointPos.x
			y = airPointPos.y
		end
	end

	self:setPosition(x, y, nil, true)

	self._idleY = y

	local stateParamDict = UdimoConfig.instance:getStateParamDict(self.id, UdimoEnum.SpineAnim.Walk)
	local stateParam = stateParamDict[UdimoEnum.StateParamType.ChangeArea]

	if stateParam then
		self._walkY = UdimoHelper.getUdimoYLevel(self.id, stateParam[1])
		self._toWalkYTime = stateParam[2]
	end

	if math.random(0, 1) == 0 then
		if not SpineLookDir.Left then
			local spineDir = SpineLookDir.Right

			self:setSpineLookDir(spineDir)
		end
	end
end

function UdimoEntity:onStart()
	return
end

function UdimoEntity:initComponents()
	self:addComp("fsmcomp", UdimoFsmComp)
	self:addComp("spine", UdimoSpineComp)
	self:addComp("emoji", UdimoEmojiComp)
end

function UdimoEntity:addComp(compName, compClass)
	local compInst = MonoHelper.addLuaComOnceToGo(self.go, compClass, self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function UdimoEntity:playEmoji(emojiId, cb, cbObj, cbParam)
	self.emoji:playEmoji(emojiId, cb, cbObj, cbParam)
end

function UdimoEntity:checkAndAdjustPos(state)
	local useBg = UdimoItemModel.instance:getUseBg()
	local interactId = UdimoModel.instance:getUdimoInteractId(self.id)

	if interactId then
		local scene = UdimoController.instance:getUdimoScene()

		if scene then
			::label_8_0::

			local worldPos = scene.interactPoint:getInteractPointWorldPos(interactId)

			if worldPos then
				self:setPosition(worldPos.x, worldPos.y, worldPos.z)
			end

			local isLeft = UdimoConfig.instance:getInteractDirIsLeft(useBg, interactId)

			self:setSpineLookDir((isLeft or nil) and (SpineLookDir.Left or SpineLookDir.Right))
		end
	else
		local newX, newY
		local pos = self:getPosition()
		local leftX, rightX = UdimoHelper.getUdimoXRange(self.id)
		local udimoType = UdimoConfig.instance:getUdimoType(self.id)

		if udimoType == UdimoEnum.UdimoType.Air then
			local curState = self:getState()

			if curState == UdimoEnum.UdimoState.Idle then
				local scene = UdimoController.instance:getUdimoScene()

				if scene then
					::label_8_1::

					local airPoint = scene.stayPoint:getUseAirPoint(self.id)

					if airPoint then
						newX = airPoint.x
						newY = airPoint.y
					else
						local yLevelList = UdimoConfig.instance:getBgAreaYLevelList(useBg, UdimoEnum.UdimoType.Land)

						newY = yLevelList and yLevelList[1]
					end
				end
			else
				local yLevelList = UdimoConfig.instance:getBgAreaYLevelList(useBg, udimoType)

				if yLevelList then
					if not yLevelList[1] then
						local minY = 0

						if not yLevelList[2] then
							local maxY = 0

							if minY > pos.y or maxY < pos.y then
								newY = GameUtil.clamp(pos.y, minY, maxY)
							end
						end
					end
				end
			end
		else
			newY = UdimoHelper.getUdimoYLevel(self.id)
		end

		self._idleY = newY
		newY = state and state == UdimoEnum.SpineAnim.Walk and self._walkY or newY

		self:setPosition((leftX > pos.x or rightX < pos.x or nil) and GameUtil.clamp(pos.x, leftX, rightX), newY, nil, true)
	end
end

function UdimoEntity:clampPosX()
	local pos = self:getPosition()
	local leftX, rightX = UdimoHelper.getUdimoXRange(self.id)

	if leftX > pos.x or rightX < pos.x then
		local newX = GameUtil.clamp(pos.x, leftX, rightX)

		self:setPosition(newX)
	end
end

function UdimoEntity:refreshOrderLayer(targetState)
	if self.spine then
		self.spine:refreshOrderLayer(targetState)
	end
end

function UdimoEntity:setPosition(x, y, z, reset2ZLevel)
	local pos = self:getPosition()

	x = x or pos.x
	y = y or pos.y
	z = z or reset2ZLevel and self._zLevel or pos.z
	self._pos = {
		x = x,
		y = y,
		z = z
	}

	transformhelper.setPos(self.trans, x, y, z)
end

function UdimoEntity:setSpineLookDir(dir)
	self.spine:changeLookDir(dir)
end

function UdimoEntity:triggerChangeStateEvent(eventId, param)
	self.fsmcomp:triggerFSMEvent(eventId, param)
end

function UdimoEntity:updateCurStateParam(checkStateName, param)
	local curState = self:getState()

	if curState ~= checkStateName then
		return
	end

	self.fsmcomp:updateFSMStateParam(curState, param)
end

function UdimoEntity:getId()
	return self.id
end

function UdimoEntity:getTag()
	return SceneTag.Untagged
end

function UdimoEntity:getState()
	return self.fsmcomp:getCurStateName()
end

function UdimoEntity:getPosition()
	if self._pos then
		return self._pos
	else
		return self.trans.position
	end
end

function UdimoEntity:getZLevel()
	return self._zLevel
end

function UdimoEntity:getSpineLookDir()
	return self.spine:getLookDir()
end

function UdimoEntity:getIdleY()
	return self._idleY
end

function UdimoEntity:getWalkY()
	return self._walkY, self._toWalkYTime
end

function UdimoEntity:getFallDownTargetY()
	local targetY
	local pos = self:getPosition()
	local curPosY = pos.y

	if self._walkY then
		targetY = self._walkY
	else
		local udimoType = UdimoConfig.instance:getUdimoType(self.id)

		if udimoType == UdimoEnum.UdimoType.Air then
			local useBg = UdimoItemModel.instance:getUseBg()
			local yLevelList = UdimoConfig.instance:getBgAreaYLevelList(useBg, udimoType)

			if yLevelList then
				if not yLevelList[1] then
					local minY = 0

					if yLevelList then
						if not yLevelList[2] then
							local maxY = 0

							targetY = minY < curPosY and curPosY < maxY and curPosY or UdimoHelper.getUdimoYLevel(self.id)
						end
					end
				end
			end
		else
			targetY = UdimoHelper.getUdimoYLevel(self.id)
		end
	end

	local playAnimY
	local animHeight = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.PlayCatch2WalkAnimHeight, false, nil, true)

	return curPosY, targetY, (animHeight <= curPosY - targetY or nil) and targetY + animHeight
end

function UdimoEntity:getIsInTranslating()
	return self.fsmcomp and self.fsmcomp:isInTranslating()
end

function UdimoEntity:beforeDestroy()
	local compList = self:getCompList()

	if compList then
		for _, comp in ipairs(compList) do
			if comp.beforeDestroy then
				comp:beforeDestroy()
			end
		end
	end

	local scene = UdimoController.instance:getUdimoScene()

	if scene and scene.level then
		scene.level:removeGameObjectToColorCtrl(self.go, true)
	end

	self.id = nil
	self._pos = nil
	self._zLevel = nil
end

return UdimoEntity
