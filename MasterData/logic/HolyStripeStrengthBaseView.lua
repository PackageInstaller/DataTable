-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeStrengthBaseView.lua

module("logic.extensions.holystripe.view.HolyStripeStrengthBaseView", package.seeall)

local HolyStripeStrengthBaseView = class("HolyStripeStrengthBaseView", HolyStripeBagView)

HolyStripeStrengthBaseView.ViewType = {
	Cuiling = 2,
	Smelting = 3,
	Strength = 1
}

function HolyStripeStrengthBaseView:unbindEvents()
	HolyStripeStrengthBaseView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
end

function HolyStripeStrengthBaseView:bindEvents()
	HolyStripeStrengthBaseView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
end

function HolyStripeStrengthBaseView:buildUI()
	HolyStripeStrengthBaseView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._equipItemGo = self:getGo("leftView/item")
	self._btnRight = self:getBtn("leftView/btnRight")
	self._btnLeft = self:getBtn("leftView/btnLeft")
	self._txtItemName = self:getTxt("leftView/txtItemName")
	self._titleNameTxt = self:getTxt("leftTop/titleNameTxt")
	self._emptyGo = self:getGo("empty")
	self._smeltingGo = self:getGo("smelting")
	self._cuilingGo = self:getGo("cuiling")
	self._strengthenGo = self:getGo("strengthen")
end

function HolyStripeStrengthBaseView:onEnter()
	local params = self:getOpenParam()

	self._holyStripId = checknumber(self:getFirstParam())

	HolyStripeStrengthBaseView.super.onEnter(self)
	self:setViewType()
	self:_initData()
	self:_changeHolyStripId()
end

function HolyStripeStrengthBaseView:onExit()
	HolyStripeStrengthBaseView.super.onExit(self)
	MaterialMgr.resetAll(self._equipItemGo)
end

function HolyStripeStrengthBaseView:_onClickbtnClose()
	self:close()
end

function HolyStripeStrengthBaseView:_onClickbtnRight()
	if self._maxIndex <= 0 then
		return
	end

	self._equipIndex = self._equipIndex + 1

	if self._equipIndex > self._maxIndex then
		self._equipIndex = 1
	end

	self:_changeHolyStripId()
end

function HolyStripeStrengthBaseView:_onClickbtnLeft()
	if self._maxIndex <= 0 then
		return
	end

	self._equipIndex = self._equipIndex - 1

	if self._equipIndex < 1 then
		self._equipIndex = self._maxIndex
	end

	self:_changeHolyStripId()
end

function HolyStripeStrengthBaseView:_getPath()
	printError("重写！！！")
end

function HolyStripeStrengthBaseView:_setTitleName(str)
	self._titleNameTxt.text = lang(str)
end

function HolyStripeStrengthBaseView:_getSuitFilterGo()
	return self:getGo("tabCon/suitFitlerBtn")
end

function HolyStripeStrengthBaseView:_getSuitFilterBtn()
	return self:getBtn("tabCon/suitFitlerBtn/bg")
end

function HolyStripeStrengthBaseView:_getConditionSortGo()
	return self:getGo("tabCon/conditionSortBtn")
end

function HolyStripeStrengthBaseView:_getConditionSortBtn()
	return self:getBtn("tabCon/conditionSortBtn/bg")
end

function HolyStripeStrengthBaseView:_getConditionFilterGo()
	return self:getGo("tabCon/conditionFilterBtn")
end

function HolyStripeStrengthBaseView:_getConditionFilteBtn()
	return self:getGo("tabCon/conditionFilterBtn/bg")
end

function HolyStripeStrengthBaseView:_getPosFilterGo()
	return self:getGo("tabCon/posFilterBtn")
end

function HolyStripeStrengthBaseView:_getPosFilterBtn()
	return self:getBtn("tabCon/posFilterBtn/bg")
end

function HolyStripeStrengthBaseView:_getSuitFilterName()
	return self:getTxt("tabCon/suitFitlerBtn/bg/text")
end

function HolyStripeStrengthBaseView:_getPosFilterName()
	return self:getTxt("tabCon/posFilterBtn/bg/text")
end

function HolyStripeStrengthBaseView:_getConditionSortName()
	return self:getTxt("tabCon/conditionSortBtn/bg/text")
end

function HolyStripeStrengthBaseView:_getConditionFilteName()
	return self:getTxt("tabCon/conditionFilterBtn/bg/text")
end

function HolyStripeStrengthBaseView:_getQualityFilterGo()
	return self:getGo("tabCon/qualityFilterBtn")
end

function HolyStripeStrengthBaseView:_getQualityFilterBtn()
	return self:getBtn("tabCon/qualityFilterBtn/bg")
end

function HolyStripeStrengthBaseView:_getQualityFilterName()
	return self:getTxt("tabCon/qualityFilterBtn/bg/text")
end

function HolyStripeStrengthBaseView:_initData()
	local params = checknumber(self:getFirstParam())

	self._holyStripeMo = HolyStripeModel.instance:getHolyStripeMo(params)

	if self._holyStripeMo:getEquipPetId() < 0 then
		self._petId = nil
		self._maxIndex = 0

		return
	end

	self._petId = self._holyStripeMo:getEquipPetId()
	self._equipMos = HolyStripeModel.instance:getEquippedByPetId(self._petId)

	table.sort(self._equipMos, function(a, b)
		return a:getPosType() < b:getPosType()
	end)

	self._equipIndex = self._holyStripeMo:getPosType()
	self._maxIndex = #self._equipMos

	for i, mo in ipairs(self._equipMos) do
		if mo:getId() == self._holyStripId then
			self._equipIndex = i
			self._holyStripeMo = mo

			break
		end
	end
end

function HolyStripeStrengthBaseView:_setEquip()
	local proxy = MaterialMgr.setCellByMo(self._holyStripeMo, self._equipItemGo)

	if proxy then
		proxy.binder:setNumStr("")
	end

	self:_setItemName()
end

function HolyStripeStrengthBaseView:_changeHolyStripId()
	if self._maxIndex > 0 then
		self._holyStripeMo = self._equipMos[self._equipIndex]
		self._holyStripId = self._holyStripeMo:getId()
	end

	self:_setEquip()
end

function HolyStripeStrengthBaseView:setViewType()
	printError("重写！！！")
end

function HolyStripeStrengthBaseView:_setViewType(viewType)
	goutil.setActive(self._smeltingGo, viewType == HolyStripeStrengthBaseView.ViewType.Smelting)
	goutil.setActive(self._cuilingGo, viewType == HolyStripeStrengthBaseView.ViewType.Cuiling)
	goutil.setActive(self._strengthenGo, viewType == HolyStripeStrengthBaseView.ViewType.Strength)
end

function HolyStripeStrengthBaseView:_setItemName()
	self._txtItemName.text = MaterialMgr.getMaterialsName(MatType.HolyStripe, self._holyStripeMo:getDefineId())
end

return HolyStripeStrengthBaseView
