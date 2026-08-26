-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongBaseComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongBaseComp", package.seeall)

local V3a8EchoSongBaseComp = class("V3a8EchoSongBaseComp", LuaCompBase)

function V3a8EchoSongBaseComp:init(go)
	self._go = go
end

function V3a8EchoSongBaseComp:getGo()
	return self._go
end

function V3a8EchoSongBaseComp:isActivated()
	return true
end

function V3a8EchoSongBaseComp:_showTriggerEffect()
	return false
end

function V3a8EchoSongBaseComp:_addTriggerEffect()
	if not self._triggerEffectGo then
		local path = self._view.viewContainer:getSetting().otherRes.switchEvent

		self._triggerEffectGo = self._view:getResInst(path, self._go)
	end

	if self._triggerEffectGo then
		gohelper.setActive(self._triggerEffectGo, false)
		gohelper.setActive(self._triggerEffectGo, true)
	else
		logError("V3a8EchoSongBaseComp:_addTriggerEffect is nil")
	end

	AudioMgr.instance:trigger(V3a8EchoSongEnum.Audio.play_ui_shiji3_8_hsy_jigaun)
end

function V3a8EchoSongBaseComp:_addSwitchEffect(parentGo, animName)
	if not self._switchEffectGo then
		parentGo = parentGo or self._go

		local path = self._view.viewContainer:getSetting().otherRes.lockItem

		self._switchEffectGo = self._view:getResInst(path, parentGo)
		self._switchEffectAnimator = self._switchEffectGo and ZProj.ProjAnimatorPlayer.Get(self._switchEffectGo)
		self._switchNodeRed = gohelper.findChild(self._switchEffectGo, "node_mask/node_red")
		self._switchNodeGreen = gohelper.findChild(self._switchEffectGo, "node_mask/node_green")
		self._switchNodePurple = gohelper.findChild(self._switchEffectGo, "node_mask/node_purple")

		local maskGo = gohelper.findChild(self._switchEffectGo, "node_mask")

		if maskGo then
			local w, h = recthelper.getWidth(parentGo.transform), recthelper.getHeight(parentGo.transform)

			recthelper.setSize(maskGo.transform, w, h)
		end

		if self._switchEffectGo then
			local matPropsCtrl = self._switchEffectGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
			local firstMat = matPropsCtrl.mas[0]
			local secondMat = matPropsCtrl.mas[1]

			if firstMat then
				firstMat = UnityEngine.Object.Instantiate(firstMat)
				matPropsCtrl.mas[0] = firstMat

				local child1 = gohelper.findChildImage(self._switchEffectGo, "node_mask/node_purple/vx_green_line")

				if child1 then
					child1.material = firstMat
				end

				local child2 = gohelper.findChildImage(self._switchEffectGo, "node_mask/node_green/vx_green_line")

				if child2 then
					child2.material = firstMat
				end
			end

			if secondMat then
				secondMat = UnityEngine.Object.Instantiate(secondMat)
				matPropsCtrl.mas[1] = secondMat

				local child1 = gohelper.findChildImage(self._switchEffectGo, "node_mask/node_purple/vx_green_light")

				if child1 then
					child1.material = secondMat
				end

				local child2 = gohelper.findChildImage(self._switchEffectGo, "node_mask/node_green/vx_green_light")

				if child2 then
					child2.material = secondMat
				end
			end
		end
	end

	gohelper.setActive(self._switchEffectGo, true)

	if self._switchEffectGo then
		self:_onSwitchEffectUnlock()

		if animName then
			self._switchEffectAnimator:Play(animName, self._switchUnlockDone, self)
		end
	else
		logError("V3a8EchoSongBaseComp:_addSwitchEffect is nil")
	end
end

function V3a8EchoSongBaseComp:_onSwitchEffectUnlock()
	return
end

function V3a8EchoSongBaseComp:_switchUnlockDone()
	gohelper.setActive(self._switchEffectGo, false)
end

function V3a8EchoSongBaseComp:initComp(view, type, id, params, paramList)
	self._view = view
	self._type = type
	self._id = id
	self._params = params
	self._paramList = paramList
	self._recordInfo = {
		type = type,
		id = id
	}
	self._tempCheckPos = Vector2()
	self._checkRect = self._go.transform.rect
	self._exitPadding = 10
	self._inBoundsState = false

	self:_onInitComp()
end

function V3a8EchoSongBaseComp:_onInitComp()
	return
end

function V3a8EchoSongBaseComp:rollback(info)
	return
end

function V3a8EchoSongBaseComp:getRecordInfo()
	return tabletool.copy(self._recordInfo)
end

function V3a8EchoSongBaseComp:getType()
	return self._type
end

function V3a8EchoSongBaseComp:_checkMainPlayerInBounds()
	return false
end

function V3a8EchoSongBaseComp:_mainPlayerInBounds()
	return
end

function V3a8EchoSongBaseComp:_mainPlayerOutOfBounds()
	return
end

function V3a8EchoSongBaseComp:_getBoundsTarget()
	return self._go.transform
end

function V3a8EchoSongBaseComp:_onMoveMainPlayer(anchorPos, mainPlayerWorldX, mainPlayerWorldY)
	if not self:_checkMainPlayerInBounds() then
		return
	end

	if not mainPlayerWorldX then
		return
	end

	local target = self:_getBoundsTarget()

	if not target then
		return
	end

	local localPos = target:InverseTransformPoint(mainPlayerWorldX, mainPlayerWorldY, 0)

	self._tempCheckPos.x = localPos.x
	self._tempCheckPos.y = localPos.y

	local isInside = self:_isInsideWithHysteresis(self._tempCheckPos)

	if isInside == self._inBoundsState then
		return
	end

	self._inBoundsState = isInside

	if isInside then
		self:_mainPlayerInBounds()

		if self:_showTriggerEffect() then
			self:_addTriggerEffect()
		end
	else
		self:_mainPlayerOutOfBounds()
	end
end

function V3a8EchoSongBaseComp:_isInsideWithHysteresis(checkPos)
	if not self._inBoundsState then
		return self._checkRect:Contains(checkPos)
	end

	if not self._exitPadding then
		local pad = 0
		local rect = self._checkRect

		return checkPos.x >= rect.x - pad and checkPos.x <= rect.x + rect.width + pad and checkPos.y >= rect.y - pad and checkPos.y <= rect.y + rect.height + pad
	end
end

function V3a8EchoSongBaseComp:addEventListeners()
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.MoveMainPlayer, self._onMoveMainPlayer, self)
end

function V3a8EchoSongBaseComp:removeEventListeners()
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.MoveMainPlayer, self._onMoveMainPlayer, self)
end

return V3a8EchoSongBaseComp
