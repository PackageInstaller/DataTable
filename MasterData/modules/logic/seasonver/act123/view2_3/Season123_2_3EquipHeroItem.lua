-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EquipHeroItem.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipHeroItem", package.seeall)

local Season123_2_3EquipHeroItem = class("Season123_2_3EquipHeroItem", ListScrollCellExtend)

function Season123_2_3EquipHeroItem:init(go)
	Season123_2_3EquipHeroItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._gorole = gohelper.findChild(self.viewGO, "go_role")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "go_role/image_roleicon")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._gocount = gohelper.findChild(self.viewGO, "go_count")
	self._txtcountvalue = gohelper.findChildText(self.viewGO, "go_count/bg/#txt_countvalue")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._imageroleicon = gohelper.findChildImage(self.viewGO, "go_role/image_roleicon")
end

function Season123_2_3EquipHeroItem:addEvents()
	return
end

function Season123_2_3EquipHeroItem:removeEvents()
	return
end

function Season123_2_3EquipHeroItem:onUpdateMO(mo)
	self._mo = mo
	self._uid = mo.id
	self._itemId = mo.itemId

	self:refreshUI()
	self:checkPlayAnim()
end

Season123_2_3EquipHeroItem.ColumnCount = 6
Season123_2_3EquipHeroItem.AnimRowCount = 4
Season123_2_3EquipHeroItem.OpenAnimTime = 0.06
Season123_2_3EquipHeroItem.OpenAnimStartTime = 0.05

function Season123_2_3EquipHeroItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Season123EquipHeroItemListModel.instance:getDelayPlayTime(self._mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season123_2_3EquipHeroItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season123_2_3EquipHeroItem:refreshUI()
	local itemUid = self._uid

	self:refreshIcon(self._itemId, itemUid)

	local equipPos, equipSlot = Season123EquipHeroItemListModel.instance:getItemEquipedPos(itemUid)

	gohelper.setActive(self._goselect, Season123EquipHeroItemListModel.instance:isItemUidInShowSlot(itemUid))
	gohelper.setActive(self._gonew, not Season123EquipHeroItemListModel.instance.recordNew:contain(itemUid))
	gohelper.setActive(self._gorole, false)

	if equipPos == nil then
		-- block empty
	end

	self:refreshDeckCount()
end

function Season123_2_3EquipHeroItem:refreshDeckCount()
	local itemUid = self._uid
	local needShow, count = Season123EquipHeroItemListModel.instance:getNeedShowDeckCount(itemUid)

	gohelper.setActive(self._gocount, needShow)

	if needShow then
		self._txtcountvalue.text = luaLang("multiple") .. tostring(count)
	end
end

function Season123_2_3EquipHeroItem:refreshEquipedHero(heroUid)
	local heroMO = HeroModel.instance:getById(heroUid) or HeroGroupTrialModel.instance:getById(heroUid)

	if not heroMO then
		return
	end

	local heroSkinId = heroMO.skin

	gohelper.setActive(self._gorole, true)
	self._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(heroSkinId))
end

function Season123_2_3EquipHeroItem:refreshIcon(itemId, itemUid)
	self:checkCreateIcon()

	if itemId then
		self.icon:updateData(itemId)

		local isSameCard = Season123EquipHeroItemListModel.instance:disableBecauseSameCard(itemUid)
		local isTypeWrong = Season123EquipHeroItemListModel.instance:disableBecauseRole(itemId)
		local needDark = isSameCard or isTypeWrong

		self.icon:setColorDark(needDark)
		self:setRoleIconDark(needDark)
	end
end

function Season123_2_3EquipHeroItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_2_3CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season123_2_3EquipHeroItem:setRoleIconDark(value)
	if value then
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#ffffff")
	end
end

function Season123_2_3EquipHeroItem:onClickSelf()
	local itemUid = self._uid

	logNormal("onClickSelf : " .. tostring(itemUid))
	self:checkClickNew(itemUid)

	if self:checkCanNotEquipWithToast(itemUid) then
		return
	end

	local oldItemUid = Season123EquipHeroItemListModel.instance.curEquipMap[Season123EquipHeroItemListModel.instance.curSelectSlot]

	if oldItemUid == itemUid then
		return
	end

	Season123EquipHeroController.instance:equipItemOnlyShow(itemUid)
end

function Season123_2_3EquipHeroItem:checkClickNew(itemUid)
	if not Season123EquipHeroItemListModel.instance.recordNew:contain(itemUid) then
		Season123EquipHeroItemListModel.instance.recordNew:add(itemUid)
		gohelper.setActive(self._gonew, false)
	end
end

Season123_2_3EquipHeroItem.Toast_Same_Card = 2851
Season123_2_3EquipHeroItem.Toast_Wrong_Type = 2852
Season123_2_3EquipHeroItem.Toast_MainRole_Wrong_Type = 2854
Season123_2_3EquipHeroItem.Toast_Other_Hero_Equiped = 2853
Season123_2_3EquipHeroItem.Toast_Career_Wrong = 2859
Season123_2_3EquipHeroItem.Toast_Slot_Lock = 67

function Season123_2_3EquipHeroItem:checkCanNotEquipWithToast(itemUid)
	if Season123EquipHeroItemListModel.instance:slotIsLock(Season123EquipHeroItemListModel.instance.curSelectSlot) then
		GameFacade.showToast(Season123_2_3EquipHeroItem.Toast_Slot_Lock)

		return true
	end

	local isSameCard = Season123EquipHeroItemListModel.instance:disableBecauseSameCard(itemUid)

	if isSameCard then
		GameFacade.showToast(Season123_2_3EquipHeroItem.Toast_Same_Card)

		return true
	end

	local itemMO = Season123EquipHeroItemListModel.instance:getEquipMO(itemUid)

	if itemMO then
		local isTypeWrong = Season123EquipHeroItemListModel.instance:disableBecauseRole(itemMO.itemId)

		if isTypeWrong then
			if Season123EquipHeroItemListModel.instance.curPos == Season123EquipHeroItemListModel.MainCharPos then
				GameFacade.showToast(Season123_2_3EquipHeroItem.Toast_MainRole_Wrong_Type)
			else
				GameFacade.showToast(Season123_2_3EquipHeroItem.Toast_Wrong_Type)
			end

			return true
		end
	end

	return false
end

function Season123_2_3EquipHeroItem:onDestroyView()
	if self.icon then
		self.icon:removeEventListeners()
		self.icon:disposeUI()
	end
end

return Season123_2_3EquipHeroItem
