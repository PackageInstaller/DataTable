-- chunkname: @modules/logic/fight/system/work/FigthWorkCardDistributeEffectByRefrigerator.lua

module("modules.logic.fight.system.work.FigthWorkCardDistributeEffectByRefrigerator", package.seeall)

local FigthWorkCardDistributeEffectByRefrigerator = class("FigthWorkCardDistributeEffectByRefrigerator", FightWorkItem)

function FigthWorkCardDistributeEffectByRefrigerator:onConstructor(handCardItemList, distributeData)
	self.handCardItemList = handCardItemList
	self.distributeData = distributeData
end

function FigthWorkCardDistributeEffectByRefrigerator:onStart()
	self.cardItem = self.handCardItemList[#self.handCardItemList]

	gohelper.setActive(self.cardItem._forAnimGO, false)

	self.obj = self.cardItem.go

	local url = "ui/viewres/fight/fightcardfresheffect.prefab"

	self:com_loadAsset(url, self.onLoadAsset)
	self:cancelFightWorkSafeTimer()
end

function FigthWorkCardDistributeEffectByRefrigerator:onLoadAsset(success, assetItem)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local effect = gohelper.clone(resObj, self.obj)

	self.effect = effect

	local effect_in = gohelper.findChild(effect, "effect_in")

	gohelper.setActive(effect_in, true)
	self:com_registTimer(self.showCard, 0.933)
	self:com_registTimer(self.finishWork, 1.833)
end

function FigthWorkCardDistributeEffectByRefrigerator:showCard()
	gohelper.setActive(self.cardItem._forAnimGO, true)
end

function FigthWorkCardDistributeEffectByRefrigerator:onDestructor()
	if self.cardItem then
		gohelper.setActive(self.cardItem._forAnimGO, true)
	end

	if self.effect then
		gohelper.destroy(self.effect)
	end
end

return FigthWorkCardDistributeEffectByRefrigerator
