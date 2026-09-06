-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flytween/FlyTweenBase.lua

module("logic.extensions.flytween.FlyTweenBase", package.seeall)

local FlyTweenBase = class("FlyTweenBase", ViewComponent)

function FlyTweenBase:_setUIFlyTweenParam(param)
	self._uiFlyTweenParam = param
end

function FlyTweenBase:_doCloseCallback(closeCallback)
	if not self:_doFlyTween(closeCallback) then
		GameUtil.callBack(closeCallback)
	end
end

function FlyTweenBase:_resetFlyTween()
	if self._uiFlyTweenParam then
		self._uiFlyTweenParam:reset()
	end

	self._uiFlyTweenParam = nil
end

function FlyTweenBase:_doFlyTween(onComplete)
	if self._uiFlyTweenParam then
		local param = self._uiFlyTweenParam

		param.targetGo = self.mainGO
		param.onCompleteCallback = onComplete

		UIFlyTween.instance:doFlyTween(param)
		self:_resetFlyTween()

		return true
	else
		return false
	end
end

return FlyTweenBase
