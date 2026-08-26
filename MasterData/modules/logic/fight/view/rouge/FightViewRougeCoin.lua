-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeCoin.lua

module("modules.logic.fight.view.rouge.FightViewRougeCoin", package.seeall)

local FightViewRougeCoin = class("FightViewRougeCoin", BaseViewExtended)

function FightViewRougeCoin:onInitView()
	self._coinText = gohelper.findChildText(self.viewGO, "#txt_num")
	self._addCoinEffect = gohelper.findChild(self.viewGO, "obtain")
	self._minCoinEffect = gohelper.findChild(self.viewGO, "without")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRougeCoin:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.ResonanceLevel, self._onResonanceLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.PolarizationLevel, self._onPolarizationLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeCoinChange, self._onRougeCoinChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._onRespBeginFight, self)
end

function FightViewRougeCoin:removeEvents()
	return
end

function FightViewRougeCoin:_editableInitView()
	return
end

function FightViewRougeCoin:onRefreshViewParam()
	return
end

function FightViewRougeCoin:_onRespBeginFight()
	self:_refreshCoin()
end

function FightViewRougeCoin:_onResonanceLevel()
	self:_refreshCoin()
end

function FightViewRougeCoin:_onPolarizationLevel()
	self:_refreshCoin()
end

function FightViewRougeCoin:_cancelCoinTimer()
	TaskDispatcher.cancelTask(self._hideCoinEffect, self)
end

function FightViewRougeCoin:_hideCoinEffect()
	gohelper.setActive(self._addCoinEffect, false)
	gohelper.setActive(self._minCoinEffect, false)
end

function FightViewRougeCoin:_onRougeCoinChange(offset)
	self:_cancelCoinTimer()
	self:_refreshCoin()
	TaskDispatcher.runDelay(self._hideCoinEffect, self, 0.6)

	if offset > 0 then
		gohelper.setActive(self._addCoinEffect, true)
		gohelper.setActive(self._minCoinEffect, false)
	else
		gohelper.setActive(self._addCoinEffect, false)
		gohelper.setActive(self._minCoinEffect, true)
	end
end

function FightViewRougeCoin:onOpen()
	self:_refreshCoin()
end

function FightViewRougeCoin:_refreshData()
	self:_refreshCoin()
end

function FightViewRougeCoin:_refreshCoin()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local showCoin = episode_config and episode_config.type == DungeonEnum.EpisodeType.Rouge

	gohelper.setActive(self.viewGO, showCoin)

	self._coinText.text = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	if showCoin then
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeCoin)
	else
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeCoin)
	end
end

function FightViewRougeCoin:onClose()
	self:_cancelCoinTimer()
end

function FightViewRougeCoin:onDestroyView()
	return
end

return FightViewRougeCoin
