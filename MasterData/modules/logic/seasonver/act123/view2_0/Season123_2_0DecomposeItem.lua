-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0DecomposeItem.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeItem", package.seeall)

local Season123_2_0DecomposeItem = class("Season123_2_0DecomposeItem", ListScrollCellExtend)

function Season123_2_0DecomposeItem:init(go)
	Season123_2_0DecomposeItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "image_roleicon")
	self._gorolebg = gohelper.findChild(self.viewGO, "bg")
	self._imageroleicon = gohelper.findChildImage(self.viewGO, "image_roleicon")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goDecomposeEffect = gohelper.findChild(self.viewGO, "vx_compose")
end

function Season123_2_0DecomposeItem:addEventListeners()
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnRefleshDecomposeItemUI, self.refreshUI, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnBatchDecomposeEffectPlay, self.showDecomposeEffect, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.CloseBatchDecomposeEffect, self.hideDecomposeEffect, self)
end

function Season123_2_0DecomposeItem:removeEventListeners()
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnRefleshDecomposeItemUI, self.refreshUI, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnBatchDecomposeEffectPlay, self.showDecomposeEffect, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.CloseBatchDecomposeEffect, self.hideDecomposeEffect, self)
end

function Season123_2_0DecomposeItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = Season123Config.instance:getSeasonEquipCo(self._mo.itemId)

	if self._cfg then
		self:refreshUI()
	end

	self:checkPlayAnim()
end

Season123_2_0DecomposeItem.AnimRowCount = 4
Season123_2_0DecomposeItem.OpenAnimTime = 0.06
Season123_2_0DecomposeItem.OpenAnimStartTime = 0.05

function Season123_2_0DecomposeItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._mo.itemId)
	self.icon:setIndexLimitShowState(true)
	gohelper.setActive(self._goselect, Season123DecomposeModel.instance:isSelectedItem(self._mo.uid))

	local heroUid = Season123DecomposeModel.instance:getItemUidToHeroUid(self._mo.uid)

	self:refreshEquipedHero(heroUid)
end

function Season123_2_0DecomposeItem:refreshEquipedHero(heroUid)
	if not heroUid or heroUid == Activity123Enum.EmptyUid then
		gohelper.setActive(self._simageroleicon, false)
		gohelper.setActive(self._gorolebg, false)

		return
	end

	local heroSkinId

	if heroUid == Activity123Enum.MainRoleHeroUid then
		heroSkinId = Activity123Enum.MainRoleHeadIconID
	else
		local heroMO = HeroModel.instance:getById(heroUid)

		if not heroMO then
			gohelper.setActive(self._simageroleicon, false)
			gohelper.setActive(self._gorolebg, false)

			return
		end

		heroSkinId = heroMO.skin
	end

	gohelper.setActive(self._simageroleicon, true)
	gohelper.setActive(self._gorolebg, true)
	self._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(heroSkinId))
end

function Season123_2_0DecomposeItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local cellCount = self._view.viewContainer:getLineCount()

	Season123DecomposeModel.instance:setItemCellCount(cellCount)

	local delayTime = Season123DecomposeModel.instance:getDelayPlayTime(self._mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season123_2_0DecomposeItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season123_2_0DecomposeItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_2_0CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season123_2_0DecomposeItem:onClickSelf()
	if not Season123DecomposeModel.instance.curSelectItemDict[self._mo.uid] and Season123DecomposeModel.instance:isSelectItemMaxCount() then
		GameFacade.showToast(ToastEnum.OverMaxCount)

		return
	end

	Season123DecomposeModel.instance:setCurSelectItemUid(self._mo.uid)
	self:refreshUI()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeItemSelect)
end

function Season123_2_0DecomposeItem:showDecomposeEffect()
	local isSelect = Season123DecomposeModel.instance.curSelectItemDict[self._mo.uid]

	if isSelect then
		gohelper.setActive(self._goDecomposeEffect, false)
		gohelper.setActive(self._goDecomposeEffect, true)
	else
		self:hideDecomposeEffect()
	end
end

function Season123_2_0DecomposeItem:hideDecomposeEffect()
	gohelper.setActive(self._goDecomposeEffect, false)
end

function Season123_2_0DecomposeItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
end

return Season123_2_0DecomposeItem
