-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/talent/V3a9RacingTalentItem.lua

module("modules.logic.versionactivity3_9.racingcar.view.talent.V3a9RacingTalentItem", package.seeall)

local V3a9RacingTalentItem = class("V3a9RacingTalentItem", ListScrollCellExtend)

function V3a9RacingTalentItem:onInitView()
	self._golinefg = gohelper.findChildImage(self.viewGO, "linebg/#go_linefg")
	self._goskillbottom = gohelper.findChildImage(self.viewGO, "#go_skillbottom")
	self._simageskillicon = gohelper.findChildImage(self.viewGO, "#simage_skillicon")
	self._golock = gohelper.findChild(self.viewGO, "#go_normallock")
	self._gospeciallock = gohelper.findChild(self.viewGO, "#go_speciallock")
	self._gospecialdark = gohelper.findChild(self.viewGO, "#go_speciallock/#go_darkbg")
	self._gospeciallight = gohelper.findChild(self.viewGO, "#go_speciallock/#go_lightbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_speciallock/#txt_num")
	self._gocanget = gohelper.findChild(self.viewGO, "#go_canget")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingTalentItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a9RacingTalentItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a9RacingTalentItem:_btnclickOnClick()
	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.onSelectTalentItem, self._mo:getId())
end

function V3a9RacingTalentItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V3a9RacingTalentItem:_editableAddEvents()
	return
end

function V3a9RacingTalentItem:_editableRemoveEvents()
	return
end

function V3a9RacingTalentItem:onUpdateMO(mo)
	self._mo = mo
	self._co = mo:getCurLevelCo()

	self:refreshMo()
end

function V3a9RacingTalentItem:refreshMo()
	self:_refreshSpecial()
	self:refreshUnlock()
end

function V3a9RacingTalentItem:refreshUnlock()
	local islock = self._mo:isLock()

	if not self._co then
		local co = self._mo:getCoByLevel(1)

		if not string.nilorempty(co.icon) then
			if islock then
				if not (co.icon .. "_0") then
					do
						local icon = co.icon .. "_1"

						UISpriteSetMgr.instance:setV3a9RacingSprite(self._simageskillicon, icon)
					end

					local cost = self._mo:getLevelUpCost()
					local currency = V3a9RacingTalentModel.instance:getCurrencyNum(self._actId).quantity or 0
					local isCanBuy = cost <= currency

					gohelper.setActive(self._gocanget, self._mo:isCanLevelUp() and isCanBuy)
					gohelper.setActive(self._gospecialdark, islock)
					gohelper.setActive(self._gospeciallight, not islock)
					gohelper.setActive(self._golock, islock and not self._mo:isCanLevelUp())
				end
			end
		end
	end
end

function V3a9RacingTalentItem:_refreshSpecial()
	local isSpecial = self._mo:isSpecial()

	if isSpecial then
		local format = luaLang("v3a9Racing_talent_special_level")

		self._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(format, self._mo:getCurLevel(), self._mo:getMaxLevel())
	end

	gohelper.setActive(self._gospeciallock, isSpecial)
end

function V3a9RacingTalentItem:refreshSelectById(id)
	gohelper.setActive(self._goselect, id == self._mo:getId())
end

function V3a9RacingTalentItem:playActivateAnim()
	self._animator:Play("activate", 0, 0)
end

function V3a9RacingTalentItem:onDestroyView()
	return
end

return V3a9RacingTalentItem
