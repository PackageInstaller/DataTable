-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/view/TopuplotteryprizeView.lua

module("logic.extensions.topuplottery.view.TopuplotteryprizeView", package.seeall)

local TopuplotteryprizeView = class("TopuplotteryprizeView", ViewComponent)

function TopuplotteryprizeView:ctor()
	TopuplotteryprizeView.super.ctor(self)
end

function TopuplotteryprizeView:unbindEvents()
	TopuplotteryprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function TopuplotteryprizeView:bindEvents()
	TopuplotteryprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self._onClickCloseBtn, self)
end

function TopuplotteryprizeView:buildUI()
	TopuplotteryprizeView.super.buildUI(self)

	self._closeBtn = self:getGo("viewInfoGo/closeBtn")
	self._choiMatGo = self:getGo("viewInfoGo/choiMatGo")
	self._addImaGo = self:getGo("viewInfoGo/choiMatGo/addImaGo")

	local prizeCell = self:getGo("viewInfoGo/cellItem")
	local prizeTableView = self:getGo("viewInfoGo/cellItemSR")

	self._prizeList = ScrollerList.create(prizeTableView, prizeCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function TopuplotteryprizeView:onExit()
	TopuplotteryprizeView.super.onExit(self)
	self._prizeList:dispose()
	MaterialMgr.resetAll(self._choiMatGo)
end

function TopuplotteryprizeView:onEnter()
	TopuplotteryprizeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._configs = params[1]
	self._chooseConfig = params[2] or {}
	self._callback = params[3]

	self:_updateAll()
end

function TopuplotteryprizeView:_updateAll()
	self:resetChooseMat()
	self._prizeList:reloadData(self._configs)
end

function TopuplotteryprizeView:_updatePrizeCell(view, cell, data, tag)
	local iconGo = goutil.findChild(cell, "iconGo")
	local stageGo = goutil.findChild(cell, "stageGo")
	local buyBtnGo = goutil.findChild(cell, "buyBtn")

	MaterialMgr.setCellByCfg(data.prize, iconGo)
	stageGo:SetActive(data.prizeId == self._chooseConfig.prizeId)
	GameUtil.addClickHandler(buyBtnGo, function()
		if data.prizeId == self._chooseConfig.prizeId then
			FloatWordMgr.instance:show(lang("text_lottery_desc_28"))

			return
		end

		self:_onClickCellItem(data)
	end)
end

function TopuplotteryprizeView:_clearPrizeCell(cell)
	local iconGo = goutil.findChild(cell, "iconGo")
	local buyBtnGo = goutil.findChild(cell, "buyBtn")

	MaterialMgr.resetAll(iconGo)
	GameUtil.rmClickHandler(buyBtnGo)
end

function TopuplotteryprizeView:_onClickCellItem(prizeConfig)
	if not prizeConfig then
		return
	end

	local oldName, newName, choPrize

	for i = 1, #self._configs do
		if self._configs[i].prizeId == self._chooseConfig.prizeId then
			oldName = MaterialMgr.getMaterialsNameByCfg(self._configs[i].prize)

			local _, _, num = MaterialMgr.getMatParams(self._configs[i].prize)

			oldName = oldName .. "*" .. num
		end

		if self._configs[i].prizeId == prizeConfig.prizeId then
			newName = MaterialMgr.getMaterialsNameByCfg(self._configs[i].prize)

			local _, _, num = MaterialMgr.getMatParams(self._configs[i].prize)

			newName = newName .. "*" .. num
			choPrize = self._configs[i].prize
		end
	end

	local function callback()
		self._chooseConfig = prizeConfig

		self:resetChooseMat()
		self._prizeList:reloadData(self._configs)
	end

	if checknumber(self._chooseConfig.prizeId) <= 0 then
		TipsFacade:openPopupWindow(lang("text_lottery_wish_tips"), langPara("text_lottery_desc_48", newName), callback, nil, lang("confirm"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
	else
		TipsFacade:openPopupWindow(lang("text_lottery_desc_44"), langPara("text_lottery_desc_45", oldName, newName), callback, nil, lang("confirm"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
	end
end

function TopuplotteryprizeView:resetChooseMat()
	local choPrize = self._chooseConfig.prize

	if choPrize then
		MaterialMgr.setCellByCfg(choPrize, self._choiMatGo)
		GameUtil.SetActive(self._addImaGo, false)
	else
		MaterialMgr.resetAll(self._choiMatGo)
		GameUtil.SetActive(self._addImaGo, true)
	end
end

function TopuplotteryprizeView:_onClickCloseBtn()
	if not self._chooseConfig or checknumber(self._chooseConfig.prizeId) <= 0 then
		FloatWordMgr.instance:show(lang("请选择一个大奖"))

		return
	end

	self:close()
	GameUtil.callBack(self._callback, self._chooseConfig)
end

return TopuplotteryprizeView
