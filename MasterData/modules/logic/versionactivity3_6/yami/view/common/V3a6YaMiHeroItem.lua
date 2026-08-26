-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiHeroItem.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiHeroItem", package.seeall)

local V3a6YaMiHeroItem = class("V3a6YaMiHeroItem", ListScrollCellExtend)

function V3a6YaMiHeroItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "root/#go_normal")
	self._simagechessicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_normal/#simage_chessicon")
	self._txtchessname = gohelper.findChildText(self.viewGO, "root/#go_normal/#txt_chessname")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._simagelockchessicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_lock/#simage_chessicon")
	self._txtfundingnormal = gohelper.findChildText(self.viewGO, "root/#go_lock/#txt_fundingnormal")
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_select")
	self._goselectNum = gohelper.findChild(self.viewGO, "root/#go_selectNum")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_reddot")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self._txtchessname2 = gohelper.findChildText(self.viewGO, "root/#go_lock/#txt_chessname")
	self._gounlock = gohelper.findChild(self.viewGO, "root/#go_lock/#btn_unlock")
	self._txtunlock = gohelper.findChildText(self.viewGO, "root/#go_lock/#btn_unlock/#txt_unlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiHeroItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
end

function V3a6YaMiHeroItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
end

function V3a6YaMiHeroItem:_btnclickOnClick()
	return
end

function V3a6YaMiHeroItem:_editableInitView()
	self._root = gohelper.findChild(self.viewGO, "root/#go_normal")
	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._root, V3a6YaMiAttrPanel)

	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goselectNum, false)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V3a6YaMiHeroItem:_editableAddEvents()
	return
end

function V3a6YaMiHeroItem:_editableRemoveEvents()
	return
end

function V3a6YaMiHeroItem:onUpdateMO(mo)
	self._mo = mo

	self._attrPanel:onRefresh(mo:getAttrMo(), true)

	self._txtchessname.text = mo.co.name
	self._txtchessname2.text = mo.co.name

	local color = GameUtil.parseColor(mo:getNameColor())

	self._txtchessname.color = color
	self._txtchessname2.color = color
	self._txtfundingnormal.text = mo.co.cost

	local isCanUnlock, toast = mo:isCanUnlock()
	local color = (isCanUnlock or toast ~= V3a6YaMiEnum.ToastId.NoEnoughMoney) and "#C6C5C5" or "#C36363"

	self._txtfundingnormal.color = GameUtil.parseColor(color)

	local icon = ResUrl.getV3a6YaMiHeroHandbookSingleBg(mo.co.icon)

	self._simagechessicon:LoadImage(icon)
	self._simagelockchessicon:LoadImage(icon)

	local isForceHideBtn = false

	if self.viewContainer and self.viewContainer.isForceHideUnlockBtn then
		isForceHideBtn = self.viewContainer:isForceHideUnlockBtn()
	end

	gohelper.setActive(self._txtchessname2.gameObject, mo.isLock and isForceHideBtn)
	gohelper.setActive(self._gounlock, mo.isLock and not isForceHideBtn)

	local isShowLockLevel = false

	if mo.isLock and not isForceHideBtn then
		local _, level, _ = V3a6YaMiModel.instance:getLevelExp()
		local unlockLevel = mo:getUnlockLevel()

		if level < unlockLevel then
			local lang = luaLang("v3a6_yami_material_unlock")

			self._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, unlockLevel)
			isShowLockLevel = true
		end
	end

	gohelper.setActive(self._txtunlock.gameObject, isShowLockLevel)
	gohelper.setActive(self._txtfundingnormal.gameObject, (false or nil) and true)

	if not self._isPlayingUnlockAnim then
		gohelper.setActive(self._gonormal, not mo.isLock)
		gohelper.setActive(self._golock, mo.isLock)
	end
end

function V3a6YaMiHeroItem:_onUnlockHero(id)
	self._isPlayingUnlockAnim = false

	if self._mo.id == id and self._animPlayer then
		self._isPlayingUnlockAnim = true

		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._golock, true)
		self._animPlayer:Play("unlock", self._playedUnlockAnim, self)
	end
end

function V3a6YaMiHeroItem:_playedUnlockAnim()
	self._isPlayingUnlockAnim = false

	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._golock, false)
end

function V3a6YaMiHeroItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V3a6YaMiHeroItem:refreshRedTag()
	gohelper.setActive(self._goreddot, self._mo.isNew)
end

function V3a6YaMiHeroItem:onDestroyView()
	self._simagechessicon:UnLoadImage()
	self._simagelockchessicon:UnLoadImage()
end

return V3a6YaMiHeroItem
