-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/view/WBB_UIPopupTips.lua

module("logic.extensions.weeklybigbox.view.WBB_UIPopupTips", package.seeall)

local WBB_UIPopupTips = class("WBB_UIPopupTips")

function WBB_UIPopupTips:ctor(mainGo)
	self._mainGo = mainGo
	self._txtTip = goutil.findChildTextComponent(mainGo, "txtTip")
end

function WBB_UIPopupTips:show(sec, content, callback, thisArg)
	self._callback = callback
	self._thisArg = thisArg
	self._txtTip.text = content

	if sec and sec > 0 then
		settimer(sec, self._onTimer, self, true)
	end

	goutil.setActive(self._mainGo, true)
end

function WBB_UIPopupTips:hide(bTriggerCallback)
	removetimer(self._onTimer, self)
	goutil.setActive(self._mainGo, false)

	if bTriggerCallback and self._thisArg.destroyed == false then
		GameUtil.callBack(self._callback, self._thisArg)
	end
end

function WBB_UIPopupTips:_onTimer()
	self:hide()

	if self._thisArg.destroyed == false then
		GameUtil.callBack(self._callback, self._thisArg)
	end
end

function WBB_UIPopupTips:dispose()
	self:hide()
end

return WBB_UIPopupTips
