-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/state/YaXianStateBattle.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateBattle", package.seeall)

local YaXianStateBattle = class("YaXianStateBattle", YaXianStateBase)

function YaXianStateBattle:start()
	self.stateType = YaXianGameEnum.GameStateType.Battle

	logNormal("YaXianStateBattle start")

	if YaXianGameModel.instance:gameIsLoadDone() then
		self:startBattle()
	else
		YaXianGameController.instance:registerCallback(YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)
	end
end

function YaXianStateBattle:onGameLoadDone()
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)
	self:startBattle()
end

function YaXianStateBattle:startBattle()
	self.playerInteractItem = YaXianGameController.instance:getPlayerInteractItem()
	self.enemyInteractItem = YaXianGameController.instance:getInteractItem(self.originData.interactId)

	AudioMgr.instance:trigger(AudioEnum.YaXian.Fight)
	self.playerInteractItem:showEffect(YaXianGameEnum.EffectType.Fight)
	self.enemyInteractItem:showEffect(YaXianGameEnum.EffectType.Fight, self.openTipView, self)
end

function YaXianStateBattle:openTipView()
	ViewMgr.instance:openView(ViewName.YaXianGameTipView, {
		interactId = self.originData.interactId
	})
end

function YaXianStateBattle:dispose()
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)
	self.playerInteractItem:cancelEffectTask()
	self.enemyInteractItem:cancelEffectTask()
	YaXianStateBattle.super.dispose(self)
end

return YaXianStateBattle
