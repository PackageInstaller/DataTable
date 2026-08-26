-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/talent/V3a9RacingTalentGroupItem.lua

module("modules.logic.versionactivity3_9.racingcar.view.talent.V3a9RacingTalentGroupItem", package.seeall)

local V3a9RacingTalentGroupItem = class("V3a9RacingTalentGroupItem", ListScrollCellExtend)

function V3a9RacingTalentGroupItem:onInitView()
	self._btninfo = gohelper.findChildButtonWithAudio(self.viewGO, "titletxt/#btn_info")
	self._goskillitem = gohelper.findChild(self.viewGO, "skilllayout/#go_skillitem")
	self._goline = gohelper.findChildImage(self.viewGO, "linestartbg/linestartfg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingTalentGroupItem:addEvents()
	self._btninfo:AddClickListener(self._btninfoOnClick, self)
end

function V3a9RacingTalentGroupItem:removeEvents()
	self._btninfo:RemoveClickListener()
end

local ProgressFillAmount = {
	0,
	0.35,
	0.7,
	1
}

function V3a9RacingTalentGroupItem:_btninfoOnClick()
	return
end

function V3a9RacingTalentGroupItem:_editableInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "titletxt")
end

function V3a9RacingTalentGroupItem:_editableAddEvents()
	return
end

function V3a9RacingTalentGroupItem:_editableRemoveEvents()
	return
end

function V3a9RacingTalentGroupItem:onUpdateMO(mo)
	self._mo = mo
	self._co = mo:getConfig()
	self._talentMos = mo:getTalentMos()
	self._txtname.text = self._co.name

	self:_initTalentItems()
end

function V3a9RacingTalentGroupItem:_initTalentItems()
	gohelper.setActive(self._goskillitem, false)

	self._talentItems = self:getUserDataTb_()

	if self._talentMos then
		for order, mo in ipairs(self._talentMos) do
			local item = self:getTalentItem(order)

			item:onUpdateMO(mo)
		end
	end

	if self._talentMos then
		if not #self._talentMos then
			local count = 0

			for i = 1, #self._talentItems do
				gohelper.setActive(self._talentItems[i].viewGO, i <= count)
			end

			self:_refreshProgress()
		end
	end
end

function V3a9RacingTalentGroupItem:_refreshProgress(isTween)
	local order = self._mo:getUnlockOrder()

	order = Mathf.Clamp(order, 1, 4)

	local fillAmount = ProgressFillAmount[order]

	if isTween then
		ZProj.TweenHelper.DOFillAmount(self._goline, fillAmount, 0.5, nil, self, nil, EaseType.Linear)
	else
		self._goline.fillAmount = fillAmount
	end
end

function V3a9RacingTalentGroupItem:getTalentItem(order)
	local item = self._talentItems[order]

	if not item then
		local go = gohelper.cloneInPlace(self._goskillitem, "order_" .. order)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a9RacingTalentItem)
		self._talentItems[order] = item
	end

	return item
end

function V3a9RacingTalentGroupItem:refreshSelectById(id)
	for i, item in ipairs(self._talentItems) do
		item:refreshSelectById(id)
	end
end

function V3a9RacingTalentGroupItem:refreshMo()
	for i, item in ipairs(self._talentItems) do
		item:refreshMo()
	end

	self:_refreshProgress(true)
end

function V3a9RacingTalentGroupItem:onDestroyView()
	ZProj.TweenHelper.KillByObj(self._goline)
end

return V3a9RacingTalentGroupItem
