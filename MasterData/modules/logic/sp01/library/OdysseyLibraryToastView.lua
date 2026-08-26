-- chunkname: @modules/logic/sp01/library/OdysseyLibraryToastView.lua

module("modules.logic.sp01.library.OdysseyLibraryToastView", package.seeall)

local OdysseyLibraryToastView = class("OdysseyLibraryToastView", AssassinLibraryToastView)

function OdysseyLibraryToastView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_unlock)

	local newItem = table.remove(self._freeList, 1)

	if not newItem then
		local go = gohelper.clone(self._gotemplate, self._gopoint)

		newItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, OdysseyLibraryToastItem)
	end

	local item

	if #self._usingList >= self._maxCount then
		self:_doRecycleAnimation(self._usingList[1], true)
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
end

return OdysseyLibraryToastView
