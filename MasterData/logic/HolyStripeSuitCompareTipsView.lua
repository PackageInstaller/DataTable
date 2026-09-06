-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitCompareTipsView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitCompareTipsView", package.seeall)

local HolyStripeSuitCompareTipsView = class("HolyStripeSuitCompareTipsView", HolyStripeCompareTipsView)

function HolyStripeSuitCompareTipsView:onEnter()
	local prams = self:getOpenParam()

	self._suitId = checknumber(prams[3])
	self._suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)
	self._equipList = {}

	for i, v in ipairs(self._suitMo.wearIds) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(v)

		if mo then
			table.insert(self._equipList, mo)
		end
	end

	HolyStripeSuitCompareTipsView.super.onEnter(self)
end

function HolyStripeSuitCompareTipsView:_setBtns(holyStripId, UIGroup)
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)
	local isEquip = false

	for i, v in ipairs(self._equipList) do
		if v:getId() == holyStripId then
			isEquip = true

			break
		end
	end

	if petId then
		goutil.setActive(UIGroup._equipBtnGo, true)

		UIGroup._equipTxt.text = isEquip == true and lang("卸下") or lang("替换")
	else
		goutil.setActive(UIGroup._equipBtnGo, false)
	end

	if holyStripeMo:getExp() < holyStripeMo:getMaxStrengthExp() then
		goutil.setActive(UIGroup._strengthenBtnGo, true)
	else
		goutil.setActive(UIGroup._strengthenBtnGo, false)
	end
end

function HolyStripeSuitCompareTipsView:_onClickEquipBtn(holyStripId)
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(holyStripId)
	local isEquip = false

	for i, v in ipairs(self._equipList) do
		if v:getId() == holyStripId then
			isEquip = true

			break
		end
	end

	if isEquip == true then
		for i, v in ipairs(self._suitMo.wearIds) do
			if v == holyStripId then
				self._suitMo.wearIds[i] = -1

				break
			end
		end
	else
		local findId = 0

		for i, v in ipairs(self._equipList) do
			if v:getPosType() == holyStripeMo:getPosType() then
				findId = v:getId()

				break
			end
		end

		for i, v in ipairs(self._suitMo.wearIds) do
			if v == findId then
				self._suitMo.wearIds[i] = holyStripId

				break
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes)
	self:close()
end

return HolyStripeSuitCompareTipsView
