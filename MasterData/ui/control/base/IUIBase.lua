-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Base\\IUIBase.lua

local strClassName = "IUIBase"
local IUIBase = Class(strClassName)
local UIUtils = Framework.UI.UIUtils

function IUIBase:ctor()
	return
end

function IUIBase:destroy()
	if self.id ~= nil then
		ModelStageManager.onUIDestroy(self.id)
		UIUtils.DestroyUI(self.id)

		self.id = nil
	end
end

function IUIBase:OnCtorEnd(id, controller)
	self.id = id
	self._controller = controller
end

function IUIBase:OnInitEnd()
	self:onInit()

	if self.eventInit then
		self:eventInit()
	end
end

function IUIBase:OnDestroyStart()
	RedDotManager.clearRedDots(self.id, true)
	ClientTimerManager.RemoveSecondTickRoot(self.id)
	self:onDestroy()
end

function IUIBase:OnOpenStart()
	if not self:getVisible() then
		return
	end

	self:onOpen()

	if self.eventOpen then
		self:eventOpen()
	end
end

function IUIBase:OnOpenEnd()
	if not self:getVisible() then
		return
	end

	self:onOpenOver()
end

function IUIBase:OnCloseEnd()
	self:onClose()

	if self.eventClose then
		self:eventClose()
	end
end

function IUIBase:onInit()
	self._uiLayer = self:getLayer(true)
end

function IUIBase:onDestroy()
	self.id = nil
end

function IUIBase:onOpen()
	return
end

function IUIBase:onOpenOver()
	return
end

function IUIBase:onClose()
	return
end

function IUIBase:getController()
	return self._controller
end

function IUIBase:isInit()
	return self._controller ~= nil
end

function IUIBase:setVisible(v)
	self._visible = v
end

function IUIBase:getVisible()
	return self._visible
end

function IUIBase:changeVisible()
	self:setVisible(not self._visible)
end

function IUIBase:setPosition(x, y)
	self:getController():SetPosition(x, y, 0)
end

function IUIBase:getPosition()
	local pos = self:getController().transform.localPosition

	return {
		x = pos.x,
		y = pos.y
	}
end

function IUIBase:setAbsPosition(x, y)
	self:getController():SetAbsPosition(x, y, 0)
end

function IUIBase:getAbsPosition()
	local pos = self:getController().transform.position

	return {
		x = pos.x,
		y = pos.y
	}
end

function IUIBase:setScale(scale)
	self:getController().transform.localScale = Vector3(scale, scale, scale)
end

function IUIBase:setLayer(layer)
	self:getController():SetLayerName(layer)

	self._uiLayer = layer
end

function IUIBase:getLayer(refresh)
	if refresh then
		return self:getController():GetLayerName()
	else
		return self._uiLayer
	end
end

function IUIBase:playStateAnimator(stateName)
	coroutine.start(self._playAnimCoroutine, self, stateName)
end

function IUIBase:playAni(aniName, callback, immidiatly)
	self:getController():StartAni(aniName, callback, immidiatly or false)
end

function IUIBase:setRenderMode(renderMode)
	if renderMode >= 0 then
		self:getController():SetRenderMode(renderMode)
	end
end

function IUIBase:getRenderMode()
	return self:getController():GetRenderMode()
end

function IUIBase:_playAnimCoroutine(stateName)
	coroutine.step()

	if self.id then
		self:getController():PlayStateAnimator(stateName)
	end
end

function IUIBase:setObjGray(isGray)
	if self._isGray == isGray then
		return
	end

	local go = self:getController().gameObject

	if go ~= nil then
		self._isGray = isGray

		self:getController():SetObjectGray(go, isGray)
	end
end

local RectTransformType = typeof(UnityEngine.RectTransform)

function IUIBase:getRectSize()
	local go = self:getController().gameObject

	if go then
		local rectTran = go:GetComponent(RectTransformType)

		if rectTran then
			return rectTran.rect
		end
	end
end

return IUIBase
