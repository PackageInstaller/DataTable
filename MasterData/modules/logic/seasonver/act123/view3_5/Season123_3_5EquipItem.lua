-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EquipItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EquipItem", package.seeall)

local Season123_3_5EquipItem = class("Season123_3_5EquipItem", ListScrollCellExtend)

function Season123_3_5EquipItem:init(go)
	Season123_3_5EquipItem.super.init(self, go)

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

function Season123_3_5EquipItem:addEvents()
	return
end

function Season123_3_5EquipItem:removeEvents()
	return
end

function Season123_3_5EquipItem:onUpdateMO(mo)
	self._mo = mo
	self._uid = mo.id
	self._itemId = mo.itemId

	self:refreshUI()
	self:checkPlayAnim()
end

Season123_3_5EquipItem.ColumnCount = 6
Season123_3_5EquipItem.AnimRowCount = 4
Season123_3_5EquipItem.OpenAnimTime = 0.06
Season123_3_5EquipItem.OpenAnimStartTime = 0.05

function Season123_3_5EquipItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Season123EquipItemListModel.instance:getDelayPlayTime(self._mo)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season123_3_5EquipItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season123_3_5EquipItem:refreshUI()
	local itemUid = self._uid
	local isTrialEquip = Season123EquipItemListModel.isTrialEquip(itemUid)

	self:refreshIcon(self._itemId, itemUid)

	local equipPos, equipSlot = Season123EquipItemListModel.instance:getItemEquipedPos(itemUid)

	gohelper.setActive(self._goselect, Season123EquipItemListModel.instance:isItemUidInShowSlot(itemUid))
	gohelper.setActive(self._gonew, not isTrialEquip and not Season123EquipItemListModel.instance.recordNew:contain(itemUid))

	if equipPos == nil then
		gohelper.setActive(self._gorole, false)
	else
		local heroUid = Season123EquipItemListModel.instance:getPosHeroUid(equipPos)

		if heroUid ~= nil and heroUid ~= Activity123Enum.EmptyUid then
			self:refreshEquipedHero(heroUid)
		else
			gohelper.setActive(self._gorole, false)
		end
	end

	self:refreshDeckCount()
end

function Season123_3_5EquipItem:refreshDeckCount()
	local itemUid = self._uid
	local needShow, count = Season123EquipItemListModel.instance:getNeedShowDeckCount(itemUid)

	gohelper.setActive(self._gocount, needShow)

	if needShow then
		self._txtcountvalue.text = luaLang("multiple") .. tostring(count)
	end
end

function Season123_3_5EquipItem:refreshEquipedHero(heroUid)
	local heroMO = HeroModel.instance:getById(heroUid) or HeroGroupTrialModel.instance:getById(heroUid)

	if Season123EquipItemListModel.instance.stage ~= nil then
		heroMO = heroMO or Season123HeroUtils.getHeroMO(Season123EquipItemListModel.instance.activityId, heroUid, Season123EquipItemListModel.instance.stage)
	end

	if not heroMO then
		return
	end

	local heroSkinId = heroMO.skin

	gohelper.setActive(self._gorole, true)
	self._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(heroSkinId))
end

function Season123_3_5EquipItem:refreshIcon(itemId, itemUid)
	self:checkCreateIcon()

	if itemId then
		self.icon:updateData(itemId)
		self.icon:setIndexLimitShowState(true)

		local isSameCard = Season123EquipItemListModel.instance:disableBecauseSameCard(itemUid)
		local isTypeWrong = Season123EquipItemListModel.instance:disableBecauseRole(itemId)
		local isCareerWrong = Season123EquipItemListModel.instance:disableBecauseCareerNotFit(itemId)
		local isPosWrong = Season123EquipItemListModel.instance:disableBecausePos(itemId)
		local needDark = isSameCard or isCareerWrong or isTypeWrong or isPosWrong

		self.icon:setColorDark(needDark)
		self:setRoleIconDark(needDark)
	end
end

function Season123_3_5EquipItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_3_5CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season123_3_5EquipItem:setRoleIconDark(value)
	if value then
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#ffffff")
	end
end

function Season123_3_5EquipItem:onClickSelf()
	local itemUid = self._uid

	logNormal("onClickSelf : " .. tostring(itemUid))
	self:checkClickNew(itemUid)

	if self:checkCanNotEquipWithToast(itemUid) then
		return
	end

	local oldItemUid = Season123EquipItemListModel.instance.curEquipMap[Season123EquipItemListModel.instance.curSelectSlot]

	if oldItemUid == itemUid then
		return
	end

	Season123EquipController.instance:equipItemOnlyShow(itemUid)
end

function Season123_3_5EquipItem:checkClickNew(itemUid)
	if not Season123EquipItemListModel.instance.recordNew:contain(itemUid) then
		Season123EquipItemListModel.instance.recordNew:add(itemUid)
		gohelper.setActive(self._gonew, false)
	end
end

Season123_3_5EquipItem.Toast_Same_Card = 2851
Season123_3_5EquipItem.Toast_Wrong_Type = 2852
Season123_3_5EquipItem.Toast_MainRole_Wrong_Type = 2854
Season123_3_5EquipItem.Toast_Other_Hero_Equiped = 2853
Season123_3_5EquipItem.Toast_Career_Wrong = 2859
Season123_3_5EquipItem.Toast_Slot_Lock = 67
Season123_3_5EquipItem.Toast_Pos_Wrong = 70501

function Season123_3_5EquipItem:checkCanNotEquipWithToast(itemUid)
	if Season123EquipItemListModel.instance:slotIsLock(Season123EquipItemListModel.instance.curSelectSlot) then
		GameFacade.showToast(Season123_3_5EquipItem.Toast_Slot_Lock)

		return true
	end

	local isSameCard = Season123EquipItemListModel.instance:disableBecauseSameCard(itemUid)

	if isSameCard then
		GameFacade.showToast(Season123_3_5EquipItem.Toast_Same_Card)

		return true
	end

	local itemMO = Season123EquipItemListModel.instance:getEquipMO(itemUid)

	if itemMO then
		local isTypeWrong = Season123EquipItemListModel.instance:disableBecauseRole(itemMO.itemId)

		if isTypeWrong then
			if Season123EquipItemListModel.instance.curPos == Season123EquipItemListModel.MainCharPos then
				GameFacade.showToast(Season123_3_5EquipItem.Toast_MainRole_Wrong_Type)
			else
				GameFacade.showToast(Season123_3_5EquipItem.Toast_Wrong_Type)
			end

			return true
		end

		local isCareerWrong = Season123EquipItemListModel.instance:disableBecauseCareerNotFit(itemMO.itemId)

		if isCareerWrong then
			GameFacade.showToast(Season123_3_5EquipItem.Toast_Career_Wrong)

			return true
		end

		local isPosWrong, tarPosStr = Season123EquipItemListModel.instance:disableBecausePos(itemMO.itemId)

		if isPosWrong then
			GameFacade.showToast(Season123_3_5EquipItem.Toast_Pos_Wrong, tarPosStr)

			return true
		end
	end

	return false
end

function Season123_3_5EquipItem:onDestroyView()
	if self.icon then
		self.icon:removeEventListeners()
		self.icon:disposeUI()
	end
end

return Season123_3_5EquipItem
