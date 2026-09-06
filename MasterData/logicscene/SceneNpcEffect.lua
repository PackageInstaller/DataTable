-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneNpcEffect.lua

module("logicscene.scene.SceneNpcEffect", package.seeall)

local SceneNpcEffect = class("SceneNpcEffect")

function SceneNpcEffect:ctor()
	self.startTimeStamp = 0
	self.endTimeStamp = 0
	self.effectPath = nil
	self.resObject = nil
	self.unit = nil
	self.hagPoint = nil
end

function SceneNpcEffect:createEffect()
	if self.resObject or self.unit:isClipping() then
		return
	end

	if string.nilorempty(self.effectPath) then
		return
	end

	self.resObject = GameEffectManager.instance:playEffect(self.effectPath, true)

	self.resObject:setParent(self.hagPoint.transform)
	self.resObject:setScale(1)
	self.resObject:setLocalPos(0, 0, 0)
	self.resObject:setLayer(self.unit:getLayer())
end

function SceneNpcEffect:destroyEffect()
	if self.resObject then
		GameEffectManager.instance:stopEffect(self.resObject)

		self.resObject = nil
	end
end

function SceneNpcEffect:setActive(visible)
	if self.resObject then
		self.resObject:setActive(visible)
	end
end

return SceneNpcEffect
