-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Base\\UIBaseControl.lua

local AnimatorType = typeof(UnityEngine.Animator)
local UIConst = require("UI/UIConst")
local strClassName = "UIBaseControl"
local UIBaseControl = Class(strClassName)
local tolua = tolua
local Vector2 = Vector2
local Vector3 = Vector3
local Quaternion = Quaternion

function UIBaseControl:ctor(parent, path)
	self.mParent = parent
	self.mWindow = parent.mWindow or parent
	self.mRoot = parent.mRoot or parent
	self.mPath = path
	self._isGray = false
end

function UIBaseControl:_getControlType()
	return UIConst.ControlTypeGameObject
end

function UIBaseControl:getControlType()
	return self:_getControlType()
end

function UIBaseControl:_packageCallback(func)
	if not func then
		return nil
	end

	local function callback(root, sender, ...)
		if self.mWindow and not self.mWindow:isInShow() and not UIConst.EXECUTABLE_CONTROL_TYPE[self:_getControlType()] then
			return
		end

		if self.mWindow and self.mWindow.mOpening and not UIConst.EXECUTABLE_CONTROL_TYPE[self:_getControlType()] then
			return
		end

		if root == self.mRoot and sender == self:getComObj() then
			func(self.mParent, self, ...)
		end
	end

	return callback
end

function UIBaseControl:getController()
	if self._controller == nil then
		self._controller = self.mRoot:getController()
	end

	return self._controller
end

function UIBaseControl:getComObj()
	if self._obj == nil then
		self._obj = self:getController():GetCom(self:_getControlType(), self.mPath)
	end

	return self._obj
end

function UIBaseControl:isAlive()
	return not tolua.isnull(self:getComObj())
end

function UIBaseControl:getGameObject()
	local obj = self:getComObj()

	if self:_getControlType() == UIConst.ControlTypeGameObject then
		self._gameObject = obj
	elseif self._obj ~= nil then
		self._gameObject = obj.gameObject
	end

	return self._gameObject
end

function UIBaseControl:getVisible()
	if self._visible == nil then
		local go = self:getGameObject()

		self._visible = false

		if go then
			self._visible = go.activeSelf
		end
	end

	return self._visible
end

function UIBaseControl:setVisible(v, forceUpdate)
	if forceUpdate or self:getVisible() ~= v then
		local go = self:getGameObject()

		if go ~= nil then
			self._visible = v

			if go.activeSelf ~= v then
				go:SetActive(v)
			end
		end
	end
end

function UIBaseControl:setObjEnabled(enabled)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.enabled = enabled
	end
end

function UIBaseControl:changeVisible()
	self:setVisible(not self:getVisible())
end

function UIBaseControl:setArchor(minX, minY, maxX, maxY)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.transform.anchorMin = Vector2(minX, minY)
		obj.transform.anchorMax = Vector2(maxX, maxY)
	end
end

function UIBaseControl:getPosition()
	local pos = self:getComObj().transform.anchoredPosition

	return {
		x = pos.x,
		y = pos.y
	}
end

function UIBaseControl:setPosition(x, y)
	local curPos = self:getPosition()

	if x == nil then
		x = curPos.x
	end

	if y == nil then
		y = curPos.y
	end

	self._obj.transform.anchoredPosition = Vector2(x, y)
end

function UIBaseControl:getAbsPosition()
	local pos = self:getComObj().transform.position

	return {
		x = pos.x,
		y = pos.y
	}
end

function UIBaseControl:setAbsPosition(x, y, z)
	local oldPosZ = self:getComObj().transform.position.z

	self._obj.transform.position = Vector3(x, y, oldPosZ)
end

function UIBaseControl:setScale(scale)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.transform.localScale = Vector3(scale, scale, scale)
	end
end

function UIBaseControl:setScaleXYZ(x, y, z)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.transform.localScale = Vector3(x, y, z)
	end
end

function UIBaseControl:getScale()
	local obj = self:getComObj()

	if obj ~= nil then
		local scale = obj.transform.localScale

		return {
			x = scale.x,
			y = scale.y
		}
	end
end

function UIBaseControl:setRotate(angle, roll)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.transform.rotation = Quaternion.Euler(0, roll or 0, angle)
	end
end

function UIBaseControl:setRotateByXYZ(x, y, z)
	local obj = self:getComObj()

	if obj ~= nil then
		local curRotateEuler = obj.transform.localEulerAngles

		obj.transform.localEulerAngles = Vector3(x or curRotateEuler.y, y or curRotateEuler.x, z or curRotateEuler.z)
	end
end

function UIBaseControl:getRotateEuler()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.transform.localEulerAngles
	end
end

function UIBaseControl:setHide(hide)
	if self._hide ~= hide then
		self._hide = hide

		local obj = self:getComObj()

		if self._hide then
			self:getController():ScaleHideUI(obj.transform, 1)
		else
			self:getController():ScaleHideUI(obj.transform, 0)
		end
	end
end

function UIBaseControl:setObjGray(isGray, forceUpdate)
	if self._isGray == isGray and not forceUpdate then
		return
	end

	local go = self:getGameObject()

	if go ~= nil then
		self._isGray = isGray

		self:getController():SetObjectGray(go, isGray)
	end
end

function UIBaseControl:setObjColor(color)
	if color == nil then
		return
	end

	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetObjectColor(obj, color.id)
	end
end

function UIBaseControl:playEffect(effPath)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():PlayUIEffect(obj, effPath)
	end
end

function UIBaseControl:playAnimator(stateName)
	local obj = self:getGameObject()

	if obj ~= nil then
		self:getController():PlayUIStateAnimator(obj, stateName)
	end
end

function UIBaseControl:playStateAnimator(stateName)
	coroutine.start(self._playAnimCoroutine, self, stateName)
end

function UIBaseControl:_playAnimCoroutine(stateName)
	coroutine.step()

	if self.mRoot and self.mRoot.id ~= nil then
		self:playAnimator(stateName)
	end
end

function UIBaseControl:setCanvasGroupAlpha(alpha)
	local obj = self:getGameObject()

	if obj ~= nil then
		self:getController():SetCanvasGroupAlpha(obj, alpha)
	end
end

function UIBaseControl:addTopNumAux()
	local obj = self:getGameObject()

	if not self.topNumAux and obj then
		self.topNumAux = self:getController():AddTopNumAux(obj)
	end

	return self.topNumAux
end

function UIBaseControl:getTopNumAux()
	return self.topNumAux
end

function UIBaseControl:showTopNumAuxNum(number, numType, stateInfo, parent)
	if not self:getTopNumAux() then
		self:addTopNumAux()
	end

	if self:getTopNumAux() and numType then
		self:getTopNumAux():ShowNum(numType, number or "0", stateInfo or "", parent:getGameObject())
	end
end

function UIBaseControl:setAnchorPresets(anchorPreset)
	local obj = self:getGameObject()

	if obj ~= nil then
		self:getController():SetAnchorPresets(obj, anchorPreset)
	end
end

function UIBaseControl:setRecttransform(anchorPreset, pos, size)
	local obj = self:getGameObject()

	if obj ~= nil then
		self:getController():SetRect(obj, anchorPreset, pos, size)
	end
end

function UIBaseControl:getAnimator()
	if self._animCom == nil then
		local obj = self:getComObj()

		if obj then
			local anim = obj.transform:GetComponent(AnimatorType)

			if anim then
				self._animCom = anim
			end
		end
	end

	return self._animCom
end

return UIBaseControl
