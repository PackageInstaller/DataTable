-- chunkname: @modules/logic/versionactivity3_3/arcade/view/currency/ArcadeCurrencyItem.lua

module("modules.logic.versionactivity3_3.arcade.view.currency.ArcadeCurrencyItem", package.seeall)

local ArcadeCurrencyItem = class("ArcadeCurrencyItem", ListScrollCellExtend)

function ArcadeCurrencyItem:onInitView()
	self._image = gohelper.findChildImage(self.viewGO, "#image")
	self._txt = gohelper.findChildText(self.viewGO, "content/#txt")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeCurrencyItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeCurrencyItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ArcadeCurrencyItem:_btnclickOnClick()
	local anchor = {
		x = -100,
		y = -250
	}
	local param = {
		currencyId = self._currencyId,
		root = self._parantClass._gotipview,
		AnchorPos = anchor,
		orignViewName = self._parantClass.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Currency, param)
end

function ArcadeCurrencyItem:_editableInitView()
	return
end

function ArcadeCurrencyItem:_editableAddEvents()
	return
end

function ArcadeCurrencyItem:_editableRemoveEvents()
	return
end

function ArcadeCurrencyItem:onUpdateMO(mo, isInGame, parant)
	self._currencyId = mo
	self._parantClass = parant

	local values = 0

	if isInGame then
		local currencyResId = mo
		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		values = characterMO and characterMO:getResourceCount(currencyResId) or 0
	else
		values = ArcadeOutSizeModel.instance:getAttrValues(mo)
	end

	self._txt.text = GameUtil.numberDisplay(values)

	local param = ArcadeEnum.CurrencyParams[mo]

	if param and not string.nilorempty(param.icon) then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._image, param.icon .. "_2")
	end
end

function ArcadeCurrencyItem:onSelect(isSelect)
	return
end

function ArcadeCurrencyItem:onDestroyView()
	return
end

return ArcadeCurrencyItem
