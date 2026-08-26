-- chunkname: @modules/logic/rouge2/map/view/coin/Rouge2_MapCoinView.lua

module("modules.logic.rouge2.map.view.coin.Rouge2_MapCoinView", package.seeall)

local Rouge2_MapCoinView = class("Rouge2_MapCoinView", BaseView)

function Rouge2_MapCoinView:onInitView()
	self.goCoinContainer = gohelper.findChild(self.viewGO, "#go_coincontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapCoinView:addEvents()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfoCoin, self.refreshCoin, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRevivalCoin, self.refreshRevivalCoin, self)
	self._btnCoin:AddClickListener(self._btnCoinOnClick, self)
	self._btnRevival:AddClickListener(self._btnRevivalOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_MapCoinView:removeEvents()
	self._btnCoin:RemoveClickListener()
	self._btnRevival:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Rouge2_MapCoinView:_btnCoinOnClick()
	gohelper.setActive(self._goTips, true)

	self._txtTipsDesc.text = self._coinDesc
end

function Rouge2_MapCoinView:_btnRevivalOnClick()
	gohelper.setActive(self._goTips, true)

	self._txtTipsDesc.text = self._revivalCoinDesc
end

function Rouge2_MapCoinView:_btnCloseOnClick()
	gohelper.setActive(self._goTips, false)
end

function Rouge2_MapCoinView:_editableInitView()
	self.go = self.viewContainer:getResInst(Rouge2_Enum.ResPath.CoinView, self.goCoinContainer)
	self.goCoin = gohelper.findChild(self.go, "#go_Root/#go_Coin")
	self._txtcoinnum = gohelper.findChildText(self.goCoin, "#txt_coinnum")
	self.coinVx = gohelper.findChild(self.goCoin, "#go_vx_vitality")
	self._btnCoin = gohelper.findChildButtonWithAudio(self.goCoin, "#btn_click")
	self.goRevival = gohelper.findChild(self.go, "#go_Root/#go_Revival")
	self._txtrevivalnum = gohelper.findChildText(self.goRevival, "#txt_revivalnum")
	self.reviveVx = gohelper.findChild(self.goRevival, "#go_vx_vitality")
	self._btnRevival = gohelper.findChildButtonWithAudio(self.goRevival, "#btn_click")
	self._goTips = gohelper.findChild(self.go, "#go_Tips")
	self._txtTipsDesc = gohelper.findChildText(self.go, "#go_Tips/tips/#scroll_dec/viewport/content/#txt_dec")
	self._btnClose = gohelper.findChildButtonWithAudio(self.go, "#go_Tips/#btn_click")

	gohelper.setActive(self._goTips, false)

	self._coinDesc = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.CoinDesc].value2
	self._revivalCoinDesc = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.RevivalCoinDesc].value2
end

function Rouge2_MapCoinView:onOpen()
	self:refreshUI()
end

function Rouge2_MapCoinView:refreshUI()
	self:refreshCoin()
	self:refreshRevivalCoin()
end

function Rouge2_MapCoinView:refreshCoin()
	local rougeInfo = Rouge2_Model.instance:getRougeInfo()

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

			self:killCoinTween()

			self.coinTweenId = ZProj.TweenHelper.DOTweenFloat(self.preCoin, rougeInfo.coin, Rouge2_MapEnum.CoinChangeDuration, self.coinFrameCallback, self.coinDoneCallback, self)

			gohelper.setActive(self.coinVx, true)
			AudioMgr.instance:trigger(AudioEnum.UI.CoinChange)
		end
	end
end

function Rouge2_MapCoinView:coinFrameCallback(value)
	value = math.ceil(value)
	self._txtcoinnum.text = value
	self.preCoin = value
end

function Rouge2_MapCoinView:coinDoneCallback()
	gohelper.setActive(self.coinVx, false)

	self.coinTweenId = nil
end

function Rouge2_MapCoinView:killCoinTween()
	if self.coinTweenId then
		ZProj.TweenHelper.KillById(self.coinTweenId)

		self.coinTweenId = nil
	end
end

function Rouge2_MapCoinView:refreshRevivalCoin()
	local revivalCoin = Rouge2_Model.instance:getRevivalCoin()

	if revivalCoin then
		if not self.preRevivalCoin then
			self._txtrevivalnum.text = revivalCoin
			self.preRevivalCoin = revivalCoin
		else
			if revivalCoin == self.preRevivalCoin then
				self._txtrevivalnum.text = revivalCoin
				self.preRevivalCoin = revivalCoin

				return
			end

			self:killRevivalCoinTween()

			self.revivalCoinTweenId = ZProj.TweenHelper.DOTweenFloat(self.preRevivalCoin, revivalCoin, Rouge2_MapEnum.CoinChangeDuration, self.reviveFrameCallback, self.reviveDoneCallback, self)

			gohelper.setActive(self.reviveVx, true)
			AudioMgr.instance:trigger(AudioEnum.UI.CoinChange)
		end
	end
end

function Rouge2_MapCoinView:reviveFrameCallback(value)
	value = math.ceil(value)
	self._txtrevivalnum.text = value
	self.preRevivalCoin = value
end

function Rouge2_MapCoinView:reviveDoneCallback()
	gohelper.setActive(self.reviveVx, false)

	self.revivalCoinTweenId = nil
end

function Rouge2_MapCoinView:killRevivalCoinTween()
	if self.revivalCoinTweenId then
		ZProj.TweenHelper.KillById(self.revivalCoinTweenId)

		self.revivalCoinTweenId = nil
	end
end

function Rouge2_MapCoinView:onClose()
	self:killCoinTween()
	self:killRevivalCoinTween()
end

function Rouge2_MapCoinView:onDestroyView()
	self:killCoinTween()
	self:killRevivalCoinTween()
end

return Rouge2_MapCoinView
