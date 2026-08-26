-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandElementBase.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementBase", package.seeall)

local FairyLandElementBase = class("FairyLandElementBase", LuaCompBase)

function FairyLandElementBase:ctor(elements, config)
	self:__onInit()

	self._config = config
	self._elements = elements
end

function FairyLandElementBase:getElementId()
	return self._config.id
end

function FairyLandElementBase:init(go)
	self._go = go
	self._transform = go.transform

	self:updatePos()
	self:onInitView()
	self:onRefresh()

	local clickGo = self:getClickGO()

	if clickGo then
		self.click = gohelper.getClickWithAudio(clickGo)

		if self.click then
			self.click:AddClickListener(self.onClick, self)
		end
	end
end

function FairyLandElementBase:refresh()
	self:onRefresh()
end

function FairyLandElementBase:finish()
	self:onFinish()
	self:onDestroy()
end

function FairyLandElementBase:getPos()
	return tonumber(self._config.pos)
end

function FairyLandElementBase:updatePos()
	local spaceX = 244
	local spaceY = 73
	local pos = self:getPos()
	local x = pos * spaceX
	local y = -(pos * spaceY)

	recthelper.setAnchor(self._transform, x, y)
end

function FairyLandElementBase:hide()
	gohelper.setActive(self._go, false)
end

function FairyLandElementBase:show()
	gohelper.setActive(self._go, true)
end

function FairyLandElementBase:getVisible()
	return not gohelper.isNil(self._go) and self._go.activeSelf
end

function FairyLandElementBase:isValid()
	return not gohelper.isNil(self._go)
end

function FairyLandElementBase:onClick()
	return
end

function FairyLandElementBase:getTransform()
	return self._transform
end

function FairyLandElementBase:onDestroy()
	self:onDestroyElement()

	if self.click then
		self.click:RemoveClickListener()
	end

	if not gohelper.isNil(self._go) then
		gohelper.destroy(self._go)

		self._go = nil
	end

	self:__onDispose()
end

function FairyLandElementBase:getClickGO()
	return self._go
end

function FairyLandElementBase:setFinish()
	local elementId = self:getElementId()

	FairyLandRpc.instance:sendRecordElementRequest(elementId)
end

function FairyLandElementBase:onInitView()
	return
end

function FairyLandElementBase:onRefresh()
	return
end

function FairyLandElementBase:onFinish()
	return
end

function FairyLandElementBase:onDestroyElement()
	return
end

return FairyLandElementBase
