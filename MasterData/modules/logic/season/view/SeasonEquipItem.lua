-- chunkname: @modules/logic/season/view/SeasonEquipItem.lua

module("modules.logic.season.view.SeasonEquipItem", package.seeall)

local SeasonEquipItem = class("SeasonEquipItem", ListScrollCellExtend)

function SeasonEquipItem:init(go)
	SeasonEquipItem.super.init(self, go)

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

function SeasonEquipItem:addEvents()
	return
end

function SeasonEquipItem:removeEvents()
	return
end

function SeasonEquipItem:onUpdateMO(mo)
	self._mo = mo
	self._itemMO = mo.originMO

	self:refreshUI()
	self:checkPlayAnim()
end

SeasonEquipItem.ColumnCount = 6
SeasonEquipItem.AnimRowCount = 4
SeasonEquipItem.OpenAnimTime = 0.06
SeasonEquipItem.OpenAnimStartTime = 0.05

function SeasonEquipItem:checkPlayAnim()
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

function SeasonEquipItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function SeasonEquipItem:refreshUI()
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

function SeasonEquipItem:refreshDeckCount()
	local itemUid = self._itemMO.uid
	local needShow, count = Activity104EquipItemListModel.instance:getNeedShowDeckCount(itemUid)

	gohelper.setActive(self._gocount, needShow)

	if needShow then
		self._txtcountvalue.text = luaLang("multiple") .. tostring(count)
	end
end

function SeasonEquipItem:refreshEquipedHero(heroUid)
	local heroMO = HeroModel.instance:getById(heroUid)

	if not heroMO then
		return
	end

	local heroSkinId = heroMO.skin

	gohelper.setActive(self._gorole, true)
	self._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(heroSkinId))
end

function SeasonEquipItem:refreshIcon(itemUid)
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

function SeasonEquipItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, SeasonCelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function SeasonEquipItem:setRoleIconDark(value)
	if value then
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#ffffff")
	end
end

function SeasonEquipItem:onClickSelf()
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

function SeasonEquipItem:checkClickNew(itemUid)
	if not Activity104EquipItemListModel.instance.recordNew:contain(itemUid) then
		Activity104EquipItemListModel.instance.recordNew:add(itemUid)
		gohelper.setActive(self._gonew, false)
	end
end

SeasonEquipItem.Toast_Same_Card = 2851
SeasonEquipItem.Toast_Wrong_Type = 2852
SeasonEquipItem.Toast_MainRole_Wrong_Type = 2854
SeasonEquipItem.Toast_Other_Hero_Equiped = 2853
SeasonEquipItem.Toast_Career_Wrong = 2859
SeasonEquipItem.Toast_Slot_Lock = 67

function SeasonEquipItem:checkCanNotEquipWithToast(itemUid)
	if Activity104EquipItemListModel.instance:slotIsLock(Activity104EquipItemListModel.instance.curSelectSlot) then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return true
	end

	local isSameCard = Activity104EquipItemListModel.instance:disableBecauseSameCard(itemUid)

	if isSameCard then
		GameFacade.showToast(SeasonEquipItem.Toast_Same_Card)

		return true
	end

	local itemMO = Activity104EquipItemListModel.instance:getEquipMO(itemUid)

	if itemMO then
		local isTypeWrong = Activity104EquipItemListModel.instance:disableBecauseRole(itemMO.itemId)

		if isTypeWrong then
			if Activity104EquipItemListModel.instance.curPos == Activity104EquipItemListModel.MainCharPos then
				GameFacade.showToast(SeasonEquipItem.Toast_MainRole_Wrong_Type)
			else
				GameFacade.showToast(SeasonEquipItem.Toast_Wrong_Type)
			end

			return true
		end

		local isCareerWrong = Activity104EquipItemListModel.instance:disableBecauseCareerNotFit(itemMO.itemId)

		if isCareerWrong then
			GameFacade.showToast(SeasonEquipItem.Toast_Career_Wrong)

			return true
		end
	end

	return false
end

function SeasonEquipItem:onDestroyView()
	if self.icon then
		self.icon:removeEventListeners()
		self.icon:disposeUI()
	end
end

return SeasonEquipItem
