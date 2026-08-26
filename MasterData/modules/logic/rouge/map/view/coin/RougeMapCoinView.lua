-- chunkname: @modules/logic/rouge/map/view/coin/RougeMapCoinView.lua

module("modules.logic.rouge.map.view.coin.RougeMapCoinView", package.seeall)

local RougeMapCoinView = class("RougeMapCoinView", BaseView)

function RougeMapCoinView:onInitView()
	self.goCoinContainer = gohelper.findChild(self.viewGO, "#go_coincontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapCoinView:addEvents()
	return
end

function RougeMapCoinView:removeEvents()
	return
end

function RougeMapCoinView:_editableInitView()
	self.goCoin = self.viewContainer:getResInst(RougeEnum.ResPath.CoinView, self.goCoinContainer)
	self._txtcoinnum = gohelper.findChildText(self.goCoin, "#txt_coinnum")
	self.coinVx = gohelper.findChild(self.goCoin, "#go_vx_vitality")

	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, self.refreshUI, self)
end

function RougeMapCoinView:onOpen()
	self:refreshUI()
end

function RougeMapCoinView:refreshUI()
	self:refreshCoin()
end

function RougeMapCoinView:refreshCoin()
	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo then
		if not self.preCoin then
			self._txtcoinnum.text = rougeInfo.coin
			self.preCoin = rougeInfo.coin
		else
			local coin = rougeInfo.coin

			if coin == self.preCoin then
				self._txtcoinnum.text = rougeInfo.coin
				self.preCoin = rougeInfo.coin

				return
			end

			self:killTween()

			self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.preCoin, rougeInfo.coin, RougeMapEnum.CoinChangeDuration, self.frameCallback, self.doneCallback, self)

			gohelper.setActive(self.coinVx, true)
			AudioMgr.instance:trigger(AudioEnum.UI.CoinChange)
		end
	end
end

function RougeMapCoinView:frameCallback(value)
	value = math.ceil(value)
	self._txtcoinnum.text = value
	self.preCoin = value
end

function RougeMapCoinView:doneCallback()
	gohelper.setActive(self.coinVx, false)

	self.tweenId = nil
end

function RougeMapCoinView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function RougeMapCoinView:onClose()
	self:killTween()

	local rougeInfo = RougeModel.instance:getRougeInfo()

	if rougeInfo then
		self.preCoin = rougeInfo.coin
	end
end

function RougeMapCoinView:onDestroyView()
	self:killTween()
end

return RougeMapCoinView
