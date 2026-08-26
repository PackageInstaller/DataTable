-- chunkname: @modules/logic/season/view3_0/Season3_0EquipComposeItem.lua

module("modules.logic.season.view3_0.Season3_0EquipComposeItem", package.seeall)

local Season3_0EquipComposeItem = class("Season3_0EquipComposeItem", ListScrollCellExtend)

function Season3_0EquipComposeItem:init(go)
	Season3_0EquipComposeItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._simageroleicon = gohelper.findChildSingleImage(self.viewGO, "image_roleicon")
	self._gorolebg = gohelper.findChild(self.viewGO, "bg")
	self._imageroleicon = gohelper.findChildImage(self.viewGO, "image_roleicon")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Season3_0EquipComposeItem:onUpdateMO(mo)
	self._mo = mo.originMO
	self._listMO = mo
	self._cfg = SeasonConfig.instance:getSeasonEquipCo(self._mo.itemId)

	if self._cfg then
		self:refreshUI()
	end

	self:checkPlayAnim()
end

function Season3_0EquipComposeItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._cfg.equipId)

	local targetRare = Activity104EquipItemComposeModel.instance:getSelectedRare()
	local needDark = targetRare ~= nil and targetRare ~= self._cfg.rare

	self.icon:setColorDark(needDark)
	self:setRoleIconDark(needDark)
	gohelper.setActive(self._goselect, Activity104EquipItemComposeModel.instance:isEquipSelected(self._mo.uid))

	local heroUid = Activity104EquipItemComposeModel.instance:getEquipedHeroUid(self._mo.uid)

	self:refreshEquipedHero(heroUid)
end

function Season3_0EquipComposeItem:setRoleIconDark(value)
	if value then
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._imageroleicon, "#ffffff")
	end
end

function Season3_0EquipComposeItem:refreshEquipedHero(heroUid)
	if not heroUid or heroUid == Activity104EquipItemComposeModel.EmptyUid then
		gohelper.setActive(self._simageroleicon, false)
		gohelper.setActive(self._gorolebg, false)

		return
	end

	local heroSkinId

	if heroUid == Activity104EquipItemComposeModel.MainRoleHeroUid then
		heroSkinId = Activity104Enum.MainRoleHeadIconID
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

Season3_0EquipComposeItem.ColumnCount = 6
Season3_0EquipComposeItem.AnimRowCount = 4
Season3_0EquipComposeItem.OpenAnimTime = 0.06
Season3_0EquipComposeItem.OpenAnimStartTime = 0.05

function Season3_0EquipComposeItem:checkPlayAnim()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)

	local delayTime = Activity104EquipItemComposeModel.instance:getDelayPlayTime(self._listMO)

	if delayTime == -1 then
		self._animator:Play("idle", 0, 0)

		self._animator.speed = 1
	else
		self._animator:Play("open", 0, 0)

		self._animator.speed = 0

		TaskDispatcher.runDelay(self.onDelayPlayOpen, self, delayTime)
	end
end

function Season3_0EquipComposeItem:onDelayPlayOpen()
	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
	self._animator:Play("open", 0, 0)

	self._animator.speed = 1
end

function Season3_0EquipComposeItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season3_0CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
		self.icon:setLongPressCall(self.onLongPress, self)
	end
end

function Season3_0EquipComposeItem:onClickSelf()
	if self._mo then
		Activity104EquipComposeController.instance:changeSelectCard(self._mo.uid)
	end
end

function Season3_0EquipComposeItem:onLongPress()
	local data = {
		actId = self._view.viewParam.actId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, self._cfg.equipId, data)
end

function Season3_0EquipComposeItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(self.onDelayPlayOpen, self)
end

return Season3_0EquipComposeItem
