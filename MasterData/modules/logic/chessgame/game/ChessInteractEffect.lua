-- chunkname: @modules/logic/chessgame/game/ChessInteractEffect.lua

module("modules.logic.chessgame.game.ChessInteractEffect", package.seeall)

local ChessInteractEffect = class("ChessInteractEffect")

function ChessInteractEffect:ctor(interactObj)
	self._target = interactObj
	self.effectGoDict = {}
	self.assetItemList = {}
	self.loadedEffectTypeList = {}
end

function ChessInteractEffect:onAvatarLoaded()
	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	self.effectGoContainer = loader:getInstGO()
end

function ChessInteractEffect:showEffect(effectType)
	self.showEffectType = effectType

	if not self.effectGoDict[self.showEffectType] then
		self:loadEffect()

		return
	end

	self:_realShowEffect()
end

function ChessInteractEffect:_realShowEffect()
	local go = self.effectGoDict[self.showEffectType]

	gohelper.setActive(go, false)
	gohelper.setActive(go, true)
end

function ChessInteractEffect:loadEffect()
	local effectType = self.showEffectType

	if tabletool.indexOf(self.loadedEffectTypeList, effectType) then
		return
	end

	table.insert(self.loadedEffectTypeList, effectType)

	local path = ChessGameEnum.EffectPath[effectType]

	loadAbAsset(path, true, self._onLoadCallback, self)
end

function ChessInteractEffect:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		table.insert(self.assetItemList, assetItem)
		assetItem:Retain()

		local effectGO = gohelper.clone(assetItem:GetResource(), self.effectGoContainer)

		self.effectGoDict[self.showEffectType] = effectGO

		gohelper.setActive(effectGO, false)
		self:showEffect(self.showEffectType)
	end
end

function ChessInteractEffect:dispose()
	for _, effectType in ipairs(self.loadedEffectTypeList) do
		removeAssetLoadCb(ChessGameEnum.EffectPath[effectType], self._onLoadCallback, self)
	end

	for k, assetItem in ipairs(self.assetItemList) do
		assetItem:Release()

		self.assetItemList[k] = nil
	end

	self.assetItemList = {}

	for k, effectGO in pairs(self.effectGoDict) do
		if not gohelper.isNil(effectGO) then
			gohelper.destroy(effectGO)
		end

		self.effectGoDict[k] = nil
	end

	self.effectGoDict = {}
	self._target = nil
	self.effectGoContainer = nil
end

return ChessInteractEffect
