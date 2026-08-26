-- chunkname: @modules/logic/sodache/view/outside/SodacheCardDetailView.lua

module("modules.logic.sodache.view.outside.SodacheCardDetailView", package.seeall)

local SodacheCardDetailView = class("SodacheCardDetailView", BaseView)

function SodacheCardDetailView:onInitView()
	self._goCardInfoLeft = gohelper.findChild(self.viewGO, "#go_CardInfoLeft")
	self._goCardBG = gohelper.findChild(self.viewGO, "Right/Card/#go_CardBG")
	self._goEffectNormal = gohelper.findChild(self.viewGO, "Right/Card/#go_EffectNormal")
	self._goEffectMax = gohelper.findChild(self.viewGO, "Right/Card/#go_EffectMax")
	self._goCardItem = gohelper.findChild(self.viewGO, "Right/Card/#go_CardItem")
	self._goBottom = gohelper.findChild(self.viewGO, "Right/#go_Bottom")
	self._goCost = gohelper.findChild(self.viewGO, "Right/#go_Bottom/#go_Cost")
	self._simageCard = gohelper.findChildSingleImage(self.viewGO, "Right/#go_Bottom/#go_Cost/#simage_Card")
	self._txtCardCost = gohelper.findChildText(self.viewGO, "Right/#go_Bottom/#go_Cost/#txt_CardCost")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheCardDetailView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function SodacheCardDetailView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function SodacheCardDetailView:_btnLeftOnClick()
	if self.index > 1 then
		self.index = self.index - 1
		self.cardMo = self.cardMoList[self.index]

		self:refreshUI()
	end
end

function SodacheCardDetailView:_btnRightOnClick()
	if self.index < self.cardCnt then
		self.index = self.index + 1
		self.cardMo = self.cardMoList[self.index]

		self:refreshUI()
	end
end

function SodacheCardDetailView:_btnCloseOnClick()
	self:closeThis()
end

function SodacheCardDetailView:_editableInitView()
	self.cardInfoLeft = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCardInfoLeft, SodacheCardInfoLeft)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCardItem, SodacheCardItem)
end

function SodacheCardDetailView:onOpen()
	self.cardMo = self.viewParam.cardMo
	self.cardMoList = self.viewParam.cardMoList
	self.subView = self.viewParam.subView

	if self.subView then
		self.subView.viewParam = self.viewParam

		self:addChildView(self.subView)
	end

	if self.cardMoList then
		self.cardCnt = #self.cardMoList
		self.index = tabletool.indexOf(self.cardMoList, self.cardMo)

		if not self.index then
			logError("传参错误，参数cardMoList中找不到参数cardMo")
		end
	end

	if self.cardMo then
		self.config = self.cardMo.serverMo.itemCo

		self:refreshUI()
	end
end

function SodacheCardDetailView:refreshUI()
	self.cardInfoLeft:setData(self.cardMo)
	self.cardItem:updateMo(self.cardMo)
	gohelper.setActive(self._btnLeft, self.index and self.index > 1)
	gohelper.setActive(self._btnRight, self.index and self.index < self.cardCnt)

	local outSideMo = SodacheModel.instance:getOutsideMo()
	local relicMo = outSideMo.relicBox:getRelicMo(self.config.id)

	if relicMo then
		local isMax = relicMo.level == relicMo.maxLevel

		gohelper.setActive(self._goEffectNormal, not isMax)
		gohelper.setActive(self._goEffectMax, isMax)
	else
		gohelper.setActive(self._goEffectNormal, false)
		gohelper.setActive(self._goEffectMax, false)
	end
end

return SodacheCardDetailView
