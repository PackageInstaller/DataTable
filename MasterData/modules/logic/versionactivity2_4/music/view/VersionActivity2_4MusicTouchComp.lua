-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicTouchComp.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTouchComp", package.seeall)

local VersionActivity2_4MusicTouchComp = class("VersionActivity2_4MusicTouchComp", LuaCompBase)

function VersionActivity2_4MusicTouchComp:ctor(param)
	self._callback = param.callback
	self._callbackTarget = param.callbackTarget
	self._isCanTouch = true
end

function VersionActivity2_4MusicTouchComp:init(go)
	self.go = go

	if VersionActivity2_4MultiTouchController.isMobilePlayer() then
		VersionActivity2_4MultiTouchController.instance:addTouch(self)
	else
		self._uiclick = SLFramework.UGUI.UIClickListener.Get(self.go)

		self._uiclick:AddClickDownListener(self._onClickDown, self)
	end
end

function VersionActivity2_4MusicTouchComp:canTouch()
	return self._isCanTouch
end

function VersionActivity2_4MusicTouchComp:setTouchEnabled(value)
	self._isCanTouch = value
end

function VersionActivity2_4MusicTouchComp:_onClickDown()
	self:touchDown()
end

function VersionActivity2_4MusicTouchComp:touchDown()
	self.touchDownFrame = Time.frameCount

	if self._callback then
		self._callback(self._callbackTarget)
	end
end

function VersionActivity2_4MusicTouchComp:onDestroy()
	if self._uiclick then
		self._uiclick:RemoveClickDownListener()

		self._uiclick = nil
	end

	self.go = nil
	self._callback = nil
	self._callbackTarget = nil
end

return VersionActivity2_4MusicTouchComp
