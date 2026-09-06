-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitTipsView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitTipsView", package.seeall)

local HolyStripeSuitTipsView = class("HolyStripeSuitTipsView", HolyStripeTipsView)

function HolyStripeSuitTipsView:onEnter()
	local prams = self:getOpenParam()

	self._suitId = checknumber(prams[6])
	self._suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)
	self._equipList = {}

	for i, v in ipairs(self._suitMo.wearIds) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(v)

		if mo then
			table.insert(self._equipList, mo)
		end
	end

	HolyStripeSuitTipsView.super.onEnter(self)
end

function HolyStripeSuitTipsView:_setBtns()
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(self._holyStripId)
	local isEquip = false

	for i, v in ipairs(self._equipList) do
		if v:getId() == self._holyStripId then
			isEquip = true

			break
		end
	end

	if petId then
		goutil.setActive(self._equipBtnGo, true)

		if isEquip == true then
			self._equipTxt.text = lang("卸下")
			self._isequip = true
		else
			self._equipTxt.text = lang("装备")
			self._isequip = false
		end
	else
		goutil.setActive(self._equipBtnGo, false)
	end

	if holyStripeMo:getExp() < holyStripeMo:getMaxStrengthExp() then
		goutil.setActive(self._strengthenBtnGo, not self._isFromCuiling)
	else
		goutil.setActive(self._strengthenBtnGo, false)
	end

	goutil.setActive(self._equipBtnGo, not self._isFromCuiling)
end

function HolyStripeSuitTipsView:_onClickEquipBtn()
	local petId = HolyStripeModel.instance:getCurrShowPetId()
	local holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(self._holyStripId)
	local isEquip = false

	for i, v in ipairs(self._equipList) do
		if v:getId() == self._holyStripId then
			isEquip = true

			break
		end
	end

	if isEquip == true then
		for i, v in ipairs(self._suitMo.wearIds) do
			if v == self._holyStripId then
				self._suitMo.wearIds[i] = -1

				break
			end
		end
	else
		local firstUnLoadPos = 1

		for i, v in ipairs(self._suitMo.wearIds) do
			if v == -1 then
				firstUnLoadPos = i

				break
			end
		end

		if #self._suitMo.wearIds >= 5 then
			self._suitMo.wearIds[firstUnLoadPos] = self._holyStripId
		else
			self._suitMo.wearIds[#self._suitMo.wearIds + 1] = self._holyStripId
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes)
	self:close()
end

return HolyStripeSuitTipsView
