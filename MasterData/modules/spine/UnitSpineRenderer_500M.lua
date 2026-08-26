-- chunkname: @modules/spine/UnitSpineRenderer_500M.lua

module("modules.spine.UnitSpineRenderer_500M", package.seeall)

local UnitSpineRenderer_500M = class("UnitSpineRenderer_500M", FightBaseClass)

function UnitSpineRenderer_500M:onConstructor(entity)
	self._entity = entity
	self.go = entity.go
end

function UnitSpineRenderer_500M:setSpine(unitSpine)
	self.centerSpineRender = self.centerSpineRender or self:newClass(FightSpineRendererComp, self._entity)

	self.centerSpineRender:setSpine(unitSpine.centerSpine)

	self.frontSpineRender = self.frontSpineRender or self:newClass(FightSpineRendererComp, self._entity)

	self.frontSpineRender:setSpine(unitSpine.frontSpine)

	self.behindSpineRender = self.behindSpineRender or self:newClass(FightSpineRendererComp, self._entity)

	self.behindSpineRender:setSpine(unitSpine.behindSpine)
end

function UnitSpineRenderer_500M:getReplaceMat()
	if self.centerSpineRender then
		return self.centerSpineRender:getReplaceMat()
	end
end

function UnitSpineRenderer_500M:getCloneOriginMat()
	if self.centerSpineRender then
		return self.centerSpineRender:getCloneOriginMat()
	end
end

function UnitSpineRenderer_500M:getSpineRenderMat()
	if self.centerSpineRender then
		return self.centerSpineRender:getSpineRenderMat()
	end
end

function UnitSpineRenderer_500M:_setReplaceMat(originMat, replaceMat)
	return
end

function UnitSpineRenderer_500M:replaceSpineMat(mat)
	if self.centerSpineRender then
		self.centerSpineRender:replaceSpineMat(mat)
	end
end

function UnitSpineRenderer_500M:resetSpineMat()
	if self.frontSpineRender then
		self.frontSpineRender:resetSpineMat()
	end
end

function UnitSpineRenderer_500M:setAlpha(alpha, duration)
	self:callFunc("setAlpha", alpha, duration)
end

function UnitSpineRenderer_500M:setColor(color)
	self:callFunc("setColor", color)
end

function UnitSpineRenderer_500M:_frameCallback(alpha)
	return
end

function UnitSpineRenderer_500M:_finishCallback()
	return
end

function UnitSpineRenderer_500M:_stopAlphaTween()
	return
end

function UnitSpineRenderer_500M:_setRendererEnabled(state)
	return
end

function UnitSpineRenderer_500M:onDestructor()
	return
end

function UnitSpineRenderer_500M:callFunc(funcName, ...)
	if self.frontSpineRender then
		local func = self.frontSpineRender[funcName]

		if func then
			func(self.frontSpineRender, ...)
		else
			logError("not found func int frontSpineRender : " .. tostring(funcName))
		end
	end

	if self.behindSpineRender then
		local func = self.behindSpineRender[funcName]

		if func then
			func(self.behindSpineRender, ...)
		else
			logError("not found func int behindSpineRender : " .. tostring(funcName))
		end
	end

	if self.centerSpineRender then
		local func = self.centerSpineRender[funcName]

		if func then
			return func(self.centerSpineRender, ...)
		else
			logError("not found func int centerSpineRender : " .. tostring(funcName))
		end
	end
end

return UnitSpineRenderer_500M
