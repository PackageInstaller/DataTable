-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiFloatItem.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiFloatItem", package.seeall)

local V3a6YaMiFloatItem = class("V3a6YaMiFloatItem", LuaCompBase)

function V3a6YaMiFloatItem:init(go)
	self.go = go
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._animePlayer = SLFramework.AnimatorPlayer.Get(self.go)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiFloatItem:addEventListeners()
	return
end

function V3a6YaMiFloatItem:removeEventListeners()
	return
end

function V3a6YaMiFloatItem:_editableInitView()
	self._showTime = 5
end

function V3a6YaMiFloatItem:setActive(isActive)
	gohelper.setActive(self.go, isActive)
end

function V3a6YaMiFloatItem:show()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_shuzi)

	self.isShow = true

	self:setActive(true)

	self._anim.enabled = true

	self._anim:Play("open", 0, 0)
	TaskDispatcher.runDelay(self.delayHide, self, self._showTime)
end

function V3a6YaMiFloatItem:hide()
	self.isShow = false

	self:setActive(false)
end

function V3a6YaMiFloatItem:delayHide()
	self._anim.enabled = true

	self._anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.hide, self, self._showTime)
end

function V3a6YaMiFloatItem:onDestroy()
	TaskDispatcher.cancelTask(self.delayHide, self)
	TaskDispatcher.cancelTask(self.hide, self)
end

return V3a6YaMiFloatItem
