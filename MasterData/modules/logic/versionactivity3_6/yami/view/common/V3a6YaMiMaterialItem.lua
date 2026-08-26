-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiMaterialItem.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiMaterialItem", package.seeall)

local V3a6YaMiMaterialItem = class("V3a6YaMiMaterialItem", ListScrollCellExtend)

function V3a6YaMiMaterialItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "root/#go_normal")
	self._simagecategaryicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_normal/#simage_categaryicon")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_normal/#txt_num")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_normal/txt_name")
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_normal/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_click")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._simagelockicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_lock/#simage_icon")
	self._txtlock = gohelper.findChildText(self.viewGO, "root/#go_lock/#txt_unlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiMaterialItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a6YaMiMaterialItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a6YaMiMaterialItem:_btnclickOnClick()
	return
end

function V3a6YaMiMaterialItem:_editableInitView()
	gohelper.setActive(self._goselect, false)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V3a6YaMiMaterialItem:_editableAddEvents()
	return
end

function V3a6YaMiMaterialItem:_editableRemoveEvents()
	return
end

function V3a6YaMiMaterialItem:onUpdateMO(mo, isHide)
	self._mo = mo
	self._type, self._id = self._mo.co.type, self._mo.co.id
	self._txtname.text = self._mo.co.name

	local icon = ResUrl.getV3a6YaMiCollectionSingleBg(mo.co.icon)

	self._simagecategaryicon:LoadImage(icon)
	self._simagelockicon:LoadImage(icon)

	if not isHide then
		if self._mo.co.cost == 0 then
			isHide = true
		end

		self:refreshNum()
	end

	self._isHideNum = isHide

	local _isUnlock = self._mo:isUnlock()
	local _isNewUnlock = self._mo:isNewUnlock()

	if not self._isPlayingUnlockAnim and not _isNewUnlock then
		::label_8_0::

		local isLock = not _isUnlock

		if isLock then
			local level = self._mo:getUnlockLevel()
			local lang = luaLang("v3a6_yami_material_unlock")

			self._txtlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, level)
		end

		gohelper.setActive(self._golock.gameObject, isLock)
		gohelper.setActive(self._txtnum.gameObject, not isLock and not isHide)
	end
end

function V3a6YaMiMaterialItem:checkPlayUnlock()
	self._isPlayingUnlockAnim = false

	if self._mo:isNewUnlock() and self._animPlayer then
		self._isPlayingUnlockAnim = true

		gohelper.setActive(self._golock, true)
		gohelper.setActive(self._txtnum, false)
		self._animPlayer:Play("unlock", self._playedUnlockAnim, self)

		return true
	end
end

function V3a6YaMiMaterialItem:_playedUnlockAnim()
	self._isPlayingUnlockAnim = false

	gohelper.setActive(self._golock, false)
	gohelper.setActive(self._txtnum, not self._isHideNum)
	self._mo:cancelNewUnlock()
end

function V3a6YaMiMaterialItem:refreshNum()
	self._txtnum.text = self._mo.co.cost

	local isEnoughCurrency = V3a6YaMiModel.instance:isEnoughCurrency(self._mo.co.cost)
	local color = isEnoughCurrency and "#CBCBCB" or "#C36363"

	self._txtnum.color = GameUtil.parseColor(color)
end

function V3a6YaMiMaterialItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V3a6YaMiMaterialItem:onDestroyView()
	self._simagecategaryicon:UnLoadImage()
	self._simagelockicon:UnLoadImage()
end

return V3a6YaMiMaterialItem
