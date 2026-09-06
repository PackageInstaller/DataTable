-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/operate/OprateBase.lua

module("logic.extensions.funcopen.operate.OprateBase", package.seeall)

local OprateBase = class("OprateBase")

function OprateBase:ctor(operateDat)
	self._operateDat = operateDat
end

function OprateBase:getWidget()
	local presentor = ViewMgr.instance._views[self._operateDat.presentorName]

	for i = 1, #presentor._views do
		if string.find(presentor._views[i].mainGO.name, self._operateDat.view) then
			local go = goutil.findChild(presentor._views[i].mainGO, self._operateDat.widget)

			if go then
				return go
			end
		end
	end
end

function OprateBase:_onViewIsOpen()
	local presentor = ViewMgr.instance._views[self._operateDat.presentorName]

	if not presentor or not presentor._views then
		return false
	end

	for i = 1, #presentor._views do
		if string.find(presentor._views[i].mainGO.name, self._operateDat.view) then
			return true
		end
	end

	return false
end

function OprateBase:checkViewIsIn()
	if not self._operateDat then
		return false
	end

	if self:_onViewIsOpen() then
		removetimer(self._onCheckView, self)
		self:doOprate()
	else
		settimer(0, self._onCheckView, self)
	end
end

function OprateBase:_onCheckView()
	self:checkViewIsIn()
end

function OprateBase:doOprate()
	return
end

return OprateBase
