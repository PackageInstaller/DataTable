-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/KeycodeListener.lua

module("logiccommon.common.util.KeycodeListener", package.seeall)

local KeycodeListener = class("KeycodeListener")

function KeycodeListener.Get(go)
	if UnityEngine.Application.isMobilePlatform then
		KeycodeListener.instance = KeycodeListener.New()
		KeycodeListener.instance.enabled = false
	else
		KeycodeListener.instance = Framework.LuaComponentContainer.Add(go, KeycodeListener)
		KeycodeListener.instance.enabled = true
	end

	return KeycodeListener.instance
end

function KeycodeListener:ctor(container)
	self._downCodes = {}

	NotifyDispatcher.extend(self)
end

function KeycodeListener:isOn(keycode)
	return UnityEngine.Input.GetKey(keycode)
end

function KeycodeListener:Update()
	for k, v in pairs(self._allListeners) do
		if UnityEngine.Input.GetKey(k) then
			if not self._downCodes[k] then
				self:dispatch(k, k, true)

				self._downCodes[k] = true
			end
		elseif self._downCodes[k] then
			self:dispatch(k, k, false)

			self._downCodes[k] = nil
		end
	end
end

function KeycodeListener:OnDestroy()
	self._downCodes = nil
end

return KeycodeListener
