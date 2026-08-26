-- chunkname: @modules/logic/versionactivity1_2/dreamtail/view/Activity119TabItem.lua

module("modules.logic.versionactivity1_2.dreamtail.view.Activity119TabItem", package.seeall)

local Activity119TabItem = class("Activity119TabItem")

function Activity119TabItem:init(go, index)
	self.go = go
	self.index = index
	self.co = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, index)

	self:onInitView()
	self:addEvents()
end

function Activity119TabItem:onInitView()
	self._btn = gohelper.findButtonWithAudio(self.go)
	self._goselect = gohelper.findChild(self.go, "go_select")
	self._txtindex = gohelper.findChildText(self.go, "txt_index")
	self._txtname = gohelper.findChildTextMesh(self.go, "txt_name")
	self._golock = gohelper.findChild(self.go, "go_lock")
	self._txtunlock = gohelper.findChildTextMesh(self.go, "go_lock/txt_unlock")
	self._anim = ZProj.ProjAnimatorPlayer.Get(self.go)
	self._goredPoint = gohelper.findChild(self.go, "redPoint")
	self._txtindex.text = string.format("TRAINING NO.%s", self.index)
	self._txtname.text = self.co.normalCO.name

	RedDotController.instance:addRedDot(self._goredPoint, RedDotEnum.DotNode.ActivityDreamTailTask, self.index)
	self:changeSelect(false)
end

function Activity119TabItem:addEvents()
	self._btn:AddClickListener(self.changeSelect, self, true)
end

function Activity119TabItem:updateLock(nowDay)
	self.nowDay = nowDay

	local day = self.co.normalCO.openDay - nowDay

	self._isLock = false

	if day > 0 then
		self._isLock = true

		if day == 1 then
			gohelper.setActive(self._golock, true)

			self._txtunlock.text = formatLuaLang("versionactivity_1_2_119_unlock", day)

			SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, "#20202099")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtname, "#20202099")
		else
			gohelper.setActive(self._golock, false)

			self._txtname.text = luaLang("versionactivity_1_2_119_unlock1")
			self._txtindex.text = "UNLOCK"

			SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, "#20202066")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtname, "#20202066")
		end
	else
		gohelper.setActive(self._golock, false)

		self._txtindex.text = string.format("TRAINING NO.%s", self.index)
		self._txtname.text = self.co.normalCO.name

		if self._isSelect then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, "#ffffffb2")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtname, "#ffffffb2")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, "#202020b2")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtname, "#202020b2")
		end
	end
end

function Activity119TabItem:playUnLockAnim()
	return
end

function Activity119TabItem:onUnLockEnd()
	return
end

function Activity119TabItem:changeSelect(isSelect)
	if isSelect and self._isLock and not self._isPlayingUnLock then
		ToastController.instance:showToast(3401)

		return
	end

	gohelper.setActive(self._goselect, isSelect)

	self._isSelect = isSelect

	if isSelect then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, "#ffffffb2")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtname, "#ffffffb2")
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
		Activity119Controller.instance:dispatchEvent(Activity119Event.TabChange, self.index)
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, "#202020b2")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtname, "#202020b2")
	end
end

function Activity119TabItem:removeEvents()
	self._btn:RemoveClickListener()
end

function Activity119TabItem:dispose()
	self:removeEvents()

	self.go = nil
	self.index = nil
	self._btn = nil
	self._goselect = nil
	self._txtindex = nil
	self._txtname = nil
	self._golock = nil
	self._txtunlock = nil
end

return Activity119TabItem
