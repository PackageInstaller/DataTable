-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheCurrencyComp.lua

module("modules.logic.sodache.view.inside.comp.SodacheCurrencyComp", package.seeall)

local SodacheCurrencyComp = class("SodacheCurrencyComp", LuaCompBase)

function SodacheCurrencyComp:ctor(param)
	if param then
		self._bagType = param.bagType or SodacheEnum.BagType.Inside
	end
end

function SodacheCurrencyComp:init(go)
	self._txtCoinNum = gohelper.findChildTextMesh(go, "#go_container/#go_currency/#btn_currency/content/#txt")
	self._image = gohelper.findChildImage(go, "#go_container/#go_currency/#btn_currency/#image")
	self._animCoin = gohelper.findChildAnim(go, "#go_container/#go_currency")

	UISpriteSetMgr.instance:setSodache2Sprite(self._image, SodacheUtil.getCurrencyIcon())
	self:_refreshView()
end

function SodacheCurrencyComp:addEventListeners()
	SodacheController.instance:registerCallback(SodacheEvent.OnBagUpdate, self._refreshView, self)
end

function SodacheCurrencyComp:removeEventListeners()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnBagUpdate, self._refreshView, self)
end

function SodacheCurrencyComp:_refreshView()
	self._bagMo = SodacheModel.instance:getOutsideMo():getBag(self._bagType)
	self._quantity = self._bagMo:getItemQuantity(SodacheEnum.CurrencyId.Coin)
	self._txtCoinNum.text = self._quantity
end

function SodacheCurrencyComp:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function SodacheCurrencyComp:setCount(value)
	self._txtCoinNum.text = value
end

function SodacheCurrencyComp:playAddAnim(value)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil

		self:_endCall()
	end

	self._animCoin:Play("add", 0, 0)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._quantity - value, self._quantity, 1.5, self._frameCall, self._endCall, self)
end

function SodacheCurrencyComp:_frameCall(value)
	self._txtCoinNum.text = math.floor(value)
end

function SodacheCurrencyComp:_endCall()
	self._txtCoinNum.text = self._quantity

	self._bagMo:clearCoinChange()
end

return SodacheCurrencyComp
