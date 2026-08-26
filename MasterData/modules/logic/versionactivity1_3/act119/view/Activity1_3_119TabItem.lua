-- chunkname: @modules/logic/versionactivity1_3/act119/view/Activity1_3_119TabItem.lua

module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119TabItem", package.seeall)

local Activity1_3_119TabItem = class("Activity1_3_119TabItem")

function Activity1_3_119TabItem:init(_go, index)
	self._go = _go
	self.index = index
	self.co = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, index)

	self:onInitView()
	self:addEvents()
end

function Activity1_3_119TabItem:onInitView()
	self._btn = gohelper.findButtonWithAudio(self._go)
	self._txtTabName = gohelper.findChildText(self._go, "#txt_TabName")
	self._txtTabNum = gohelper.findChildText(self._go, "#txt_TabName/#txt_TabNum")
	self._goSelected = gohelper.findChild(self._go, "#go_Selected")
	self._imageSelected = gohelper.findChildImage(self._go, "#go_Selected/#image_Selected")
	self._txtTabNameSelected = gohelper.findChildText(self._go, "#go_Selected/#txt_TabName")
	self._txtTabNumSelected = gohelper.findChildText(self._go, "#go_Selected/#txt_TabName/#txt_TabNum")
	self._txtLockedTips = gohelper.findChildText(self._go, "#go_Locked/#txt_LockedTips")
	self._goLocked = gohelper.findChild(self._go, "#go_Locked")
	self._goFinished = gohelper.findChild(self._go, "#go_Finished")
	self._txtTabNum.text = string.format("TRAINING NO.%s", self.index)
	self._txtTabName.text = self.co.normalCO.name
	self._txtTabNumSelected.text = string.format("TRAINING NO.%s", self.index)
	self._txtTabNameSelected.text = self.co.normalCO.name
	self._goRedPoint = gohelper.findChild(self._go, "redPoint")

	RedDotController.instance:addRedDot(self._goRedPoint, RedDotEnum.DotNode.ActivityDreamTailTask, self.index)
	self:changeSelect(false)
end

function Activity1_3_119TabItem:addEvents()
	self._btn:AddClickListener(self.changeSelect, self, true)
end

function Activity1_3_119TabItem:updateLock(nowDay)
	self.nowDay = nowDay

	local day = self.co.normalCO.openDay - nowDay

	self._isLock = false

	if day > 0 then
		self._isLock = true

		if day == 1 then
			gohelper.setActive(self._goLocked, true)

			self._txtLockedTips.text = formatLuaLang("versionactivity_1_2_119_unlock", day)
		else
			gohelper.setActive(self._goLocked, false)

			self._txtTabName.text = luaLang("versionactivity_1_2_119_unlock1")
			self._txtTabNum.text = "UNLOCK"
		end
	else
		gohelper.setActive(self._goLocked, false)

		self._txtTabNum.text = string.format("TRAINING NO.%s", self.co.normalCO.tabId)
		self._txtTabName.text = self.co.normalCO.name
	end
end

function Activity1_3_119TabItem:updateFinishView()
	local cfg = self.co
	local taskList = cfg.taskList
	local isAllFinish = true

	for i = 1, #taskList do
		local taskMO = TaskModel.instance:getTaskById(taskList[i].id)

		if taskMO and taskMO.finishCount <= 0 then
			isAllFinish = false

			break
		end
	end

	gohelper.setActive(self._goFinished, isAllFinish)
end

function Activity1_3_119TabItem:playUnLockAnim()
	return
end

function Activity1_3_119TabItem:changeSelect(isSelect)
	if isSelect and self._isLock and not self._isPlayingUnLock then
		ToastController.instance:showToast(3401)

		return
	end

	gohelper.setActive(self._goSelected, isSelect)

	self._isSelect = isSelect

	if isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
		Activity119Controller.instance:dispatchEvent(Activity119Event.TabChange, self.index)
	end
end

function Activity1_3_119TabItem:removeEvents()
	self._btn:RemoveClickListener()
end

function Activity1_3_119TabItem:dispose()
	self:removeEvents()

	self._go = nil
	self.index = nil
	self._btn = nil
	self._goSelected = nil
	self._txtTabNum = nil
	self._txtTabNumSelected = nil
	self._txtTabName = nil
	self._txtTabNameSelected = nil
	self._goLocked = nil
end

return Activity1_3_119TabItem
