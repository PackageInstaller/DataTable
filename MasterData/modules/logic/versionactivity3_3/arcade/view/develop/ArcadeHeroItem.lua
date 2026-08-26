-- chunkname: @modules/logic/versionactivity3_3/arcade/view/develop/ArcadeHeroItem.lua

module("modules.logic.versionactivity3_3.arcade.view.develop.ArcadeHeroItem", package.seeall)

local ArcadeHeroItem = class("ArcadeHeroItem", ListScrollCellExtend)

function ArcadeHeroItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "unlock/#simage_hero")
	self._imagehero = gohelper.findChildImage(self.viewGO, "unlock/#simage_hero")
	self._gonew = gohelper.findChild(self.viewGO, "#go_reddot")
	self._goequiped = gohelper.findChild(self.viewGO, "unlock/go_equiped")
	self._gohp = gohelper.findChild(self.viewGO, "unlock/go_hp")
	self._golock = gohelper.findChild(self.viewGO, "lock")
	self._simagelockhero = gohelper.findChildSingleImage(self.viewGO, "lock/#simage_hero")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)
	self._gohp = gohelper.findChild(self.viewGO, "unlock/go_hp")
	self._gobg = gohelper.findChild(self.viewGO, "bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHeroItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeHeroItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ArcadeHeroItem:_btnclickOnClick()
	local showId = ArcadeHeroModel.instance:getSelectHeroId()
	local id = self._mo:getId()

	if showId == id then
		return
	end

	ArcadeHeroModel.instance:setSelectHeroId(id)
	self:checkReddot()
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnClickHeroItem, id)
end

function ArcadeHeroItem:_editableInitView()
	gohelper.setActive(self._gohp, false)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ArcadeHeroItem:_editableAddEvents()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.onFinishPlayOpenAnimHeroView, self._checkUnlockAnim, self)
end

function ArcadeHeroItem:_editableRemoveEvents()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.onFinishPlayOpenAnimHeroView, self._checkUnlockAnim, self)
end

function ArcadeHeroItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView()
end

function ArcadeHeroItem:refreshView()
	self:checkReddot()
	self:_refreshStatus()
end

function ArcadeHeroItem:_checkUnlockAnim()
	local isLock = self._mo:isLock()
	local prefsKey, key = self._mo:getPlayUnlockAnimKey()
	local value = ArcadeOutSizeModel.instance:getPlayerPrefsValue(prefsKey, key, 0, true)

	if isLock then
		gohelper.setActive(self._golock, true)
		gohelper.setActive(self._gounlock, false)
		gohelper.setActive(self._gobg, false)
	elseif value == 0 then
		self._anim:Play("unlock", 0, 0)
		ArcadeOutSizeModel.instance:setPlayerPrefsValue(prefsKey, key, 1, true)
	end
end

function ArcadeHeroItem:_refreshStatus()
	local isLock = self._mo:isLock()
	local isSelect = self._mo:isSelect()
	local isNew = self._mo:isNew()
	local isEquip = self._mo:isEquip()

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._gounlock, not isLock)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._goequiped, isEquip)
	gohelper.setActive(self._gonew, isNew)
	gohelper.setActive(self._gobg, not isLock)

	local icon = self._mo.handbookMo:getIcon()

	if not string.nilorempty(icon) then
		self._simagehero:LoadImage(ResUrl.getEliminateIcon(icon))
		self._simagelockhero:LoadImage(ResUrl.getEliminateIcon(icon))
	end

	if not isLock then
		if isSelect then
			if not Color.white then
				self._imagehero.color = GameUtil.parseColor("#808080")
			end
		end
	end
end

function ArcadeHeroItem:checkReddot()
	if not self._mo:isLock() and self._mo:isNew() and self._mo:isSelect() then
		self._mo:setNew()

		local prefsKey, key = self._mo:getReddotKey()

		ArcadeOutSizeModel.instance:setPlayerPrefsValue(prefsKey, key, 1, true)
		gohelper.setActive(self._gonew, false)

		local id = self._mo:getId()

		ArcadeController.instance:dispatchEvent(ArcadeEvent.OnClickHeroItem, id)
	end
end

function ArcadeHeroItem:onDestroyView()
	self._simagehero:UnLoadImage()
	self._simagelockhero:UnLoadImage()
end

return ArcadeHeroItem
