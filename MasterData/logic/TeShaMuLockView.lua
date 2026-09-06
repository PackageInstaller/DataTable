-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/TeShaMuLockView.lua

module("logic.extensions.teshamu.view.TeShaMuLockView", package.seeall)

local TeShaMuLockView = class("TeShaMuLockView", CustomRightCell)

TeShaMuLockView.prefabUrl = "ui/views/timelimitedchallenge/teshamu/teshamulockview.prefab"

function TeShaMuLockView:buildUI()
	self._lock = goutil.findChild(self.mainGO, "lock")
end

function TeShaMuLockView:isLock(lock)
	goutil.setActive(self._lock, lock)
end

return TeShaMuLockView
