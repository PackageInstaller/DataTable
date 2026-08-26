-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3CardPackageItem.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3CardPackageItem", package.seeall)

local Season123_2_3CardPackageItem = class("Season123_2_3CardPackageItem", ListScrollCellExtend)

function Season123_2_3CardPackageItem:init(go)
	Season123_2_3CardPackageItem.super.init(self, go)

	self._gopos = gohelper.findChild(self.viewGO, "go_itempos/go_pos")
	self._gocount = gohelper.findChild(self.viewGO, "go_itempos/go_count")
	self._txtcountvalue = gohelper.findChildText(self.viewGO, "go_itempos/go_count/bg/#txt_countvalue")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Season123_2_3CardPackageItem:addEventListeners()
	return
end

function Season123_2_3CardPackageItem:removeEventListeners()
	return
end

function Season123_2_3CardPackageItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function Season123_2_3CardPackageItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._mo.itemId)
	self.icon:setIndexLimitShowState(true)

	if self._mo.count > 0 then
		gohelper.setActive(self._gocount, true)

		self._txtcountvalue.text = luaLang("multiple") .. tostring(self._mo.count)
	else
		gohelper.setActive(self._gocount, false)
	end
end

function Season123_2_3CardPackageItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gopos, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_2_3CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
	end
end

function Season123_2_3CardPackageItem:onClickSelf()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, self._mo.itemId)
end

function Season123_2_3CardPackageItem:getAnimator()
	self._animator.enabled = true

	return self._animator
end

function Season123_2_3CardPackageItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end
end

return Season123_2_3CardPackageItem
