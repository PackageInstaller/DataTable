-- chunkname: @modules/live2d/special/BaseLive2dSpecialEffect.lua

module("modules.live2d.special.BaseLive2dSpecialEffect", package.seeall)

local BaseLive2dSpecialEffect = class("BaseLive2dSpecialEffect", LuaCompBase)

function BaseLive2dSpecialEffect:init(go)
	self._go = go

	self:_onInit()
end

function BaseLive2dSpecialEffect:setLive2d(live2d)
	self._live2d = live2d
end

function BaseLive2dSpecialEffect:getCubismController()
	return self._live2d and self._live2d._cubismController
end

function BaseLive2dSpecialEffect:getLive2dCamera()
	return self._live2d and self._live2d._camera
end

function BaseLive2dSpecialEffect:getMat()
	return self._live2d and self._live2d._mat
end

function BaseLive2dSpecialEffect:isPlayingVoiceId(id)
	return self._live2d and self._live2d:isPlayingVoiceId(id)
end

function BaseLive2dSpecialEffect:onBodyChange(prevBodyName, curBodyName)
	self:_onBodyChange(prevBodyName, curBodyName)
end

function BaseLive2dSpecialEffect:isFindAnim(curName, checkNames)
	if not checkNames then
		return false
	end

	for _, checkName in ipairs(checkNames) do
		if string.find(curName, checkName) ~= nil then
			return true
		end
	end

	return false
end

function BaseLive2dSpecialEffect:_onInit()
	return
end

function BaseLive2dSpecialEffect:_onBodyChange(prevBodyName, curBodyName)
	return
end

function BaseLive2dSpecialEffect:onDestroy()
	return
end

return BaseLive2dSpecialEffect
