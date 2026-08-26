-- chunkname: @modules/logic/season/view1_2/Season1_2EquipItem.lua

module("modules.logic.season.view1_2.Season1_2EquipItem", package.seeall)

local Season1_2EquipItem = class("Season1_2EquipItem", ListScrollCellExtend)

function Season1_2EquipItem:init(go)
	Season1_2EquipItem.super.init(self, go)

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

function Season1_2EquipItem:addEvents()
	return
end

function Season1_2EquipItem:removeEvents()
	return
end

function Season1_2EquipItem:onUpdateMO(mo)
	self._mo = mo
	self._itemMO = mo.originMO

	self:refreshUI()
	self:checkPlayAnim()
end

Season1_2EquipItem.ColumnCount = 6
Season1_2EquipItem.AnimRowCount = 4
Season1_2EquipItem.OpenAnimTime = 0.06
Season1_2EquipItem.OpenAnimStartTime = 0.05

function Season1_2EquipItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Activity104EquipItemListModel.instance:getDelayPlayTime(self._mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season1_2EquipItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season1_2EquipItem:refreshUI()
	local itemUid = self._itemMO.uid

	self:refreshIcon(itemUid)

	local equipPos, equipSlot = Activity104EquipItemListModel.instance:getItemEquipedPos(itemUid)

	gohelper.setActive(self._goselect, Activity104EquipItemListModel.instance:isItemUidInShowSlot(itemUid))
	gohelper.setActive(self._gonew, not Activity104EquipItemListModel.instance.recordNew:contain(itemUid))

	if equipPos == nil then
		gohelper.setActive(self._gorole, false)
	else
		local heroUid = Activity104EquipItemListModel.instance:getPosHeroUid(equipPos)

		if heroUid ~= nil and heroUid ~= Activity104EquipItemListModel.EmptyUid then
			self:refreshEquipedHero(heroUid)
		else
			gohelper.setActive(self._gorole, false)
		end
	end

	self:refreshDeckCount()
end

function Season1_2EquipItem:refreshDeckCount()
	local itemUid = self._itemMO.uid
	local needShow, count = Activity104EquipItemListModel.instance:getNeedShowDeckCount(itemUid)

	gohelper.setActive(self._gocount, needShow)

	if needShow then
		self._txtcountvalue.text = luaLang("multiple") .. tostring(count)
	end
end

function Season1_2EquipItem:refreshEquipedHero(heroUid)
	local heroMO = HeroModel.instance:getById(heroUid)

	if not heroMO then
		return
	end

	local heroSkinId = heroMO.skin

	gohelper.setActive(self._gorole, true)
	self._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(heroSkinId))
end

function Season1_2EquipItem:refreshIcon(itemUid)
	self:checkCreateIcon()

	local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

	if itemMO then
		self.icon:updateData(itemMO.itemId)

		local isSameCard = Activity104EquipItemListModel.instance:disableBecauseSameCard(itemUid)
		local isTypeWrong = Activity104EquipItemListModel.instance:disableBecauseRole(itemMO.itemId)
		local isCareerWrong = Activity104EquipItemListModel.instance:disableBecauseCareerNotFit(itemMO.itemId)
		local needDark = isSameCard or isCareerWrong or isTypeWrong

		self.icon:setColorDark(needDark)
		self:setRoleIconDark(needDark)
	end
end

function Season1_2EquipItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season1_2CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season1_2EquipItem:setRoleIconDark(value)
	if value then
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#ffffff")
	end
end

function Season1_2EquipItem:onClickSelf()
	local itemUid = self._itemMO.uid

	logNormal("onClickSelf : " .. tostring(itemUid))
	self:checkClickNew(itemUid)

	if self:checkCanNotEquipWithToast(itemUid) then
		return
	end

	local oldItemUid = Activity104EquipItemListModel.instance.curEquipMap[Activity104EquipItemListModel.instance.curSelectSlot]

	if oldItemUid == itemUid then
		return
	end

	Activity104EquipController.instance:equipItemOnlyShow(itemUid)
end

function Season1_2EquipItem:checkClickNew(itemUid)
	if not Activity104EquipItemListModel.instance.recordNew:contain(itemUid) then
		Activity104EquipItemListModel.instance.recordNew:add(itemUid)
		gohelper.setActive(self._gonew, false)
	end
end

Season1_2EquipItem.Toast_Same_Card = 2851
Season1_2EquipItem.Toast_Wrong_Type = 2852
Season1_2EquipItem.Toast_MainRole_Wrong_Type = 2854
Season1_2EquipItem.Toast_Other_Hero_Equiped = 2853
Season1_2EquipItem.Toast_Career_Wrong = 2859
Season1_2EquipItem.Toast_Slot_Lock = 67

function Season1_2EquipItem:checkCanNotEquipWithToast(itemUid)
	if Activity104EquipItemListModel.instance:slotIsLock(Activity104EquipItemListModel.instance.curSelectSlot) then
		GameFacade.showToast(Season1_2EquipItem.Toast_Slot_Lock)

		return true
	end

	local isSameCard = Activity104EquipItemListModel.instance:disableBecauseSameCard(itemUid)

	if isSameCard then
		GameFacade.showToast(Season1_2EquipItem.Toast_Same_Card)

		return true
	end

	local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

	if itemMO then
		local isTypeWrong = Activity104EquipItemListModel.instance:disableBecauseRole(itemMO.itemId)

		if isTypeWrong then
			if Activity104EquipItemListModel.instance.curPos == Activity104EquipItemListModel.MainCharPos then
				GameFacade.showToast(Season1_2EquipItem.Toast_MainRole_Wrong_Type)
			else
				GameFacade.showToast(Season1_2EquipItem.Toast_Wrong_Type)
			end

			return true
		end

		local isCareerWrong = Activity104EquipItemListModel.instance:disableBecauseCareerNotFit(itemMO.itemId)

		if isCareerWrong then
			GameFacade.showToast(Season1_2EquipItem.Toast_Career_Wrong)

			return true
		end
	end

	return false
end

function Season1_2EquipItem:onDestroyView()
	if self.icon then
		self.icon:removeEventListeners()
		self.icon:disposeUI()
	end
end

return Season1_2EquipItem
