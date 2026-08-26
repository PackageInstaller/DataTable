-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/work/YaXianInteractEffectWork.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.work.YaXianInteractEffectWork", package.seeall)

local YaXianInteractEffectWork = class("YaXianInteractEffectWork", BaseWork)

function YaXianInteractEffectWork:ctor(killInteractId, effectType)
	self.interactItem = YaXianGameController.instance:getInteractItem(killInteractId)
	self.effectType = effectType
end

function YaXianInteractEffectWork:onStart()
	self.interactItem:showEffect(self.effectType, self.effectDoneCallback, self)
end

function YaXianInteractEffectWork:effectDoneCallback()
	self:onDone(true)
end

function YaXianInteractEffectWork:clearWork()
	self.interactItem:cancelEffectTask()
end

return YaXianInteractEffectWork
