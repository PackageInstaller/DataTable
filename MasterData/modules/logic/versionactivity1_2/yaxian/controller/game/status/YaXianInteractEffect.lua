-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/status/YaXianInteractEffect.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractEffect", package.seeall)

local YaXianInteractEffect = class("YaXianInteractEffect", UserDataDispose)

YaXianInteractEffect.EffectPath = {
	[YaXianGameEnum.EffectType.Fight] = YaXianGameEnum.SceneResPath.FightEffect,
	[YaXianGameEnum.EffectType.Assassinate] = YaXianGameEnum.SceneResPath.AssassinateEffect,
	[YaXianGameEnum.EffectType.Die] = YaXianGameEnum.SceneResPath.DieEffect,
	[YaXianGameEnum.EffectType.FightSuccess] = YaXianGameEnum.SceneResPath.FightSuccessEffect,
	[YaXianGameEnum.EffectType.PlayerAssassinateEffect] = YaXianGameEnum.SceneResPath.PlayerAssassinateEffect
}
YaXianInteractEffect.EffectAudio = {
	[YaXianGameEnum.EffectType.Assassinate] = AudioEnum.YaXian.Assassinate,
	[YaXianGameEnum.EffectType.PlayerAssassinateEffect] = AudioEnum.YaXian.Assassinate,
	[YaXianGameEnum.EffectType.Fight] = AudioEnum.YaXian.Fight,
	[YaXianGameEnum.EffectType.Die] = AudioEnum.YaXian.Die
}

function YaXianInteractEffect:ctor()
	self:__onInit()
end

function YaXianInteractEffect:init(interactItem)
	self.interactItem = interactItem
	self.interactMo = interactItem.interactMo
	self.effectGoContainer = interactItem.effectGoContainer
	self.config = self.interactMo.config
	self.effectGoDict = self:getUserDataTb_()
	self.assetItemList = self:getUserDataTb_()
	self.loadedEffectList = {}
end

function YaXianInteractEffect:showEffect(effectType, doneCallback, callbackObj)
	if self.interactItem:isDelete() then
		if self.doneCallback then
			self.doneCallback(self.callbackObj)
		end

		return
	end

	self.showEffectType = self:getInputEffectType(effectType)
	self.doneCallback = doneCallback
	self.callbackObj = callbackObj

	if not self.effectGoDict[self.showEffectType] then
		self:loadEffect()

		return
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, false)
	self:_showEffect()
end

function YaXianInteractEffect:getInputEffectType(effectType)
	if effectType == YaXianGameEnum.EffectType.Assassinate and self.config.interactType == YaXianGameEnum.InteractType.Player then
		return YaXianGameEnum.EffectType.PlayerAssassinateEffect
	end

	return effectType
end

function YaXianInteractEffect:_showEffect()
	local go = self.effectGoDict[self.showEffectType]

	gohelper.setActive(go, false)
	gohelper.setActive(go, true)
	YaXianGameController.instance:playEffectAudio(YaXianInteractEffect.EffectAudio[self.showEffectType])
	TaskDispatcher.runDelay(self.onEffectDone, self, YaXianGameEnum.EffectDuration[self.showEffectType] or YaXianGameEnum.DefaultEffectDuration)
end

function YaXianInteractEffect:onEffectDone()
	local go = self.effectGoDict[self.showEffectType]

	gohelper.setActive(go, false)

	if self.showEffectType == YaXianGameEnum.EffectType.Die then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.DeleteInteractObj, self.interactItem.id)
	end

	if self.doneCallback then
		self.doneCallback(self.callbackObj)
	end
end

function YaXianInteractEffect:loadEffect()
	local effectType = self.showEffectType

	if tabletool.indexOf(self.loadedEffectList, effectType) then
		return
	end

	table.insert(self.loadedEffectList, effectType)

	local path = YaXianInteractEffect.EffectPath[effectType]

	loadAbAsset(path, true, self._onLoadCallback, self)
end

function YaXianInteractEffect:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		table.insert(self.assetItemList, assetItem)
		assetItem:Retain()

		local instanceGo = gohelper.clone(assetItem:GetResource(), self.effectGoContainer)

		self.effectGoDict[self.showEffectType] = instanceGo

		gohelper.setActive(instanceGo, false)
		self:showEffect(self.showEffectType, self.doneCallback, self.callbackObj)
	end
end

function YaXianInteractEffect:cancelTask()
	local go = self.effectGoDict[self.showEffectType]

	gohelper.setActive(go, false)
	TaskDispatcher.cancelTask(self.onEffectDone, self)
end

function YaXianInteractEffect:dispose()
	for _, effect in ipairs(self.loadedEffectList) do
		removeAssetLoadCb(YaXianInteractEffect.EffectPath[effect], self._onLoadCallback, self)
	end

	if self.assetItemList then
		for _, assetItem in ipairs(self.assetItemList) do
			assetItem:Release()
		end

		self.assetItemList = nil
	end

	self:cancelTask()
	self:__onDispose()
end

return YaXianInteractEffect
