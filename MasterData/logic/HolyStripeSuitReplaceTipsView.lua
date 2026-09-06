-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitReplaceTipsView.lua

module("logic.extensions.holystripe.view.HolyStripeSuitReplaceTipsView", package.seeall)

local HolyStripeSuitReplaceTipsView = class("HolyStripeSuitReplaceTipsView", ViewComponent)

function HolyStripeSuitReplaceTipsView:buildUI()
	HolyStripeSuitReplaceTipsView.super.buildUI(self)

	self._btnClose = self:getGo("Btn_Close")
	self._btnCancel = self:getGo("Btns/BtnCancel")
	self._btnSure = self:getGo("Btns/BtnSure")
	self._tableView = self:getGo("holyStripeList")
	self._tableCell = self:getGo("holyStripeList/holyStripeCell")
	self._tableList = ItemGroup.New(self._tableView, self._tableCell)
	self._txtTips = self:getTxt("txtTips")
	self._toggleDayTips = self:getToggle("Toggle")
end

function HolyStripeSuitReplaceTipsView:bindEvents()
	HolyStripeSuitReplaceTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function HolyStripeSuitReplaceTipsView:unbindEvents()
	HolyStripeSuitReplaceTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function HolyStripeSuitReplaceTipsView:onEnter()
	HolyStripeSuitReplaceTipsView.super.onEnter()

	local param = self:getOpenParam()

	self._suitId = param[1]
	self._petId = HolyStripeModel.instance:getCurrShowPetId()
	self._suitMo = HolyStripeModel.instance:getSuitMo(self._suitId)

	local needExchangeData = {}

	for i, v in ipairs(self._suitMo.wearIds) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(v)

		if mo and checknumber(mo:getEquipPetId()) > 0 and mo:getEquipPetId() ~= self._curPetId then
			table.insert(needExchangeData, mo)
		end
	end

	self._toggleDayTips.isOn = false

	self._tableList:updateWithMoArray(needExchangeData, self._updateCell, self)

	self._txtTips.text = langPara("有%d个灵纹正在被使用，是否继续装备？", #needExchangeData)
end

function HolyStripeSuitReplaceTipsView:onExit()
	HolyStripeSuitReplaceTipsView.super.onExit()
	self._tableList:dispose(self._clearCell, self)
end

function HolyStripeSuitReplaceTipsView:_updateCell(cell, data, index)
	local go = cell.mainGO
	local holyStripeCon = goutil.findChild(go, "holyStripeCon")
	local petCon = goutil.findChild(go, "petCon")
	local proxy = MaterialMgr.setCellByGId(MatType.HolyStripe, data:getId(), holyStripeCon)

	if proxy then
		proxy.binder:setNum(0)
	end

	MaterialMgr.setCellByGId(MatType.Pet, data:getEquipPetId(), petCon)
end

function HolyStripeSuitReplaceTipsView:_clearCell(cell)
	local go = cell.mainGO
	local holyStripeCon = goutil.findChild(go, "holyStripeCon")
	local petCon = goutil.findChild(go, "petCon")

	MaterialMgr.resetAll(holyStripeCon)
	MaterialMgr.resetAll(petCon)
end

function HolyStripeSuitReplaceTipsView:_onClickSure()
	if self._toggleDayTips.isOn == true then
		HolyStripeModel.instance:saveSuitReplaceTip()
	end

	HolyStripeAgent.instance:sendPM_HolyStripeWearSuitReq(self._petId, self._suitId)
	self:close()
end

return HolyStripeSuitReplaceTipsView
