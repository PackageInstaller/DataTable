-- chunkname: @modules/logic/season/view/SeasonEquipBookItem.lua

module("modules.logic.season.view.SeasonEquipBookItem", package.seeall)

local SeasonEquipBookItem = class("SeasonEquipBookItem", ListScrollCellExtend)

function SeasonEquipBookItem:init(go)
	SeasonEquipBookItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "image_roleicon")
	self._txtcountvalue = gohelper.findChildText(self.viewGO, "go_count/bg/#txt_countvalue")
	self._gocount = gohelper.findChild(self.viewGO, "go_count")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function SeasonEquipBookItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = SeasonConfig.instance:getSeasonEquipCo(self._mo.id)

	if self._cfg then
		self:refreshUI()
	end

	self:checkPlayAnim()
end

SeasonEquipBookItem.ColumnCount = 6
SeasonEquipBookItem.AnimRowCount = 4
SeasonEquipBookItem.OpenAnimTime = 0.06
SeasonEquipBookItem.OpenAnimStartTime = 0.05

function SeasonEquipBookItem:refreshUI()
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

function SeasonEquipBookItem:checkPlayAnim()
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

function SeasonEquipBookItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function SeasonEquipBookItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, SeasonCelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function SeasonEquipBookItem:onClickSelf()
	if self._mo then
		Activity104EquipBookController.instance:changeSelect(self._mo.id)
	end
end

function SeasonEquipBookItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
end

return SeasonEquipBookItem
