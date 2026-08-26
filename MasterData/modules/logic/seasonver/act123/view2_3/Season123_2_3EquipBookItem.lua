-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EquipBookItem.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipBookItem", package.seeall)

local Season123_2_3EquipBookItem = class("Season123_2_3EquipBookItem", ListScrollCellExtend)

function Season123_2_3EquipBookItem:init(go)
	Season123_2_3EquipBookItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "image_roleicon")
	self._txtcountvalue = gohelper.findChildText(self.viewGO, "go_count/bg/#txt_countvalue")
	self._gocount = gohelper.findChild(self.viewGO, "go_count")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Season123_2_3EquipBookItem:addEventListeners()
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
end

function Season123_2_3EquipBookItem:removeEventListeners()
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
end

function Season123_2_3EquipBookItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = Season123Config.instance:getSeasonEquipCo(self._mo.id)

	if self._cfg then
		self:refreshUI()
	end

	self:checkPlayAnim()
end

Season123_2_3EquipBookItem.ColumnCount = 6
Season123_2_3EquipBookItem.AnimRowCount = 4
Season123_2_3EquipBookItem.OpenAnimTime = 0.06
Season123_2_3EquipBookItem.OpenAnimStartTime = 0.05

function Season123_2_3EquipBookItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._mo.id)
	self.icon:setColorDark(self._mo.count <= 0)
	self.icon:setIndexLimitShowState(true)
	gohelper.setActive(self._goselect, Season123EquipBookModel.instance.curSelectItemId == self._mo.id)
	gohelper.setActive(self._gonew, self._mo.isNew)

	if self._mo.count > 0 then
		gohelper.setActive(self._gocount, true)

		self._txtcountvalue.text = luaLang("multiple") .. tostring(self._mo.count)
	else
		gohelper.setActive(self._gocount, false)
	end
end

function Season123_2_3EquipBookItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Season123EquipBookModel.instance:getDelayPlayTime(self._mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season123_2_3EquipBookItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season123_2_3EquipBookItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_2_3CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season123_2_3EquipBookItem:onClickSelf()
	if self._mo then
		Season123EquipBookController.instance:changeSelect(self._mo.id)
	end
end

function Season123_2_3EquipBookItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
end

return Season123_2_3EquipBookItem
