-- chunkname: @modules/logic/fight/view/FightDouQuQuCoinView.lua

module("modules.logic.fight.view.FightDouQuQuCoinView", package.seeall)

local FightDouQuQuCoinView = class("FightDouQuQuCoinView", FightBaseView)

function FightDouQuQuCoinView:onInitView()
	self.coinText = gohelper.findChildText(self.viewGO, "root/#txt_CoinCnt1")
	self.changeText = gohelper.findChildText(self.viewGO, "root/#txt_num")
	self.addEffect = gohelper.findChild(self.viewGO, "root/#add")
	self.subEffect = gohelper.findChild(self.viewGO, "root/#subtract")

	gohelper.setActive(self.addEffect, false)
	gohelper.setActive(self.subEffect, false)

	self.changeText.text = ""
end

function FightDouQuQuCoinView:addEvents()
	self:com_registFightEvent(FightEvent.UpdateFightParam, self.onUpdateFightParam)
end

function FightDouQuQuCoinView:onUpdateFightParam(keyId, oldValue, currValue, offset)
	if keyId ~= FightParamData.ParamKey.ACT191_COIN then
		return
	end

	self.changeText.text = -offset

	gohelper.setActive(self.subEffect, false)
	gohelper.setActive(self.subEffect, true)
	self:com_registSingleTimer(self.hideEffect, 1)
	self:com_scrollNumTween(self.coinText, oldValue, currValue, 0.5)
end

function FightDouQuQuCoinView:hideEffect()
	gohelper.setActive(self.subEffect, false)

	self.changeText.text = ""
end

function FightDouQuQuCoinView:refreshData()
	self.coinText.text = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_COIN]
end

function FightDouQuQuCoinView:onOpen()
	self:refreshData()
end

return FightDouQuQuCoinView
