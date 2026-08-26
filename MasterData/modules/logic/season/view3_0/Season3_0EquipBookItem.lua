-- chunkname: @modules/logic/season/view3_0/Season3_0EquipBookItem.lua

module("modules.logic.season.view3_0.Season3_0EquipBookItem", package.seeall)

local Season3_0EquipBookItem = class("Season3_0EquipBookItem", ListScrollCellExtend)

function Season3_0EquipBookItem:init(go)
	Season3_0EquipBookItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "image_roleicon")
	self._txtcountvalue = gohelper.findChildText(self.viewGO, "go_count/bg/#txt_countvalue")
	self._gocount = gohelper.findChild(self.viewGO, "go_count")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Season3_0EquipBookItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = SeasonConfig.instance:getSeasonEquipCo(self._mo.id)

	if self._cfg then
		self:refreshUI()
	end

	self:checkPlayAnim()
end

Season3_0EquipBookItem.ColumnCount = 6
Season3_0EquipBookItem.AnimRowCount = 4
Season3_0EquipBookItem.OpenAnimTime = 0.06
Season3_0EquipBookItem.OpenAnimStartTime = 0.05

function Season3_0EquipBookItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._mo.id)
	self.icon:setColorDark(self._mo.count <= 0)
	gohelper.setActive(self._goselect, Activity104EquipItemBookModel.instance.curSelectItemId == self._mo.id)
	gohelper.setActive(self._gonew, self._mo.isNew)

	if self._mo.count > 0 then
		gohelper.setActive(self._gocount, true)

		self._txtcountvalue.text = luaLang("multiple") .. tostring(self._mo.count)
	else
		gohelper.setActive(self._gocount, false)
	end
end

function Season3_0EquipBookItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Activity104EquipItemBookModel.instance:getDelayPlayTime(self._mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season3_0EquipBookItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season3_0EquipBookItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season3_0CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season3_0EquipBookItem:onClickSelf()
	if self._mo then
		Activity104EquipBookController.instance:changeSelect(self._mo.id)
	end
end

function Season3_0EquipBookItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
end

return Season3_0EquipBookItem
