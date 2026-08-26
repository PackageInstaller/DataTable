-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/comp/Va3ChessInteractEffect.lua

module("modules.logic.versionactivity1_3.va3chess.game.comp.Va3ChessInteractEffect", package.seeall)

local Va3ChessInteractEffect = class("Va3ChessInteractEffect")

function Va3ChessInteractEffect:ctor(interactObj)
	self._target = interactObj
	self.effectGoDict = {}
	self.assetItemList = {}
	self.loadedEffectTypeList = {}
end

function Va3ChessInteractEffect:onAvatarLoaded()
	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local avatarGO = loader:getInstGO()

	self._target.avatar.goLostTarget = gohelper.findChild(avatarGO, "piecea/vx_vertigo")
	self.effectGoContainer = avatarGO

	self:refreshSearchFailed()
end

function Va3ChessInteractEffect:refreshSearchFailed()
	if self._target.originData and self._target.originData.data and self._target.avatar and self._target.avatar.goLostTarget then
		gohelper.setActive(self._target.avatar.goLostTarget, self._target.originData.data.lostTarget)
	end
end

function Va3ChessInteractEffect:showEffect(effectType)
	self.showEffectType = effectType

	if not self.effectGoDict[self.showEffectType] then
		self:loadEffect()

		return
	end

	self:_realShowEffect()
end

function Va3ChessInteractEffect:_realShowEffect()
	local go = self.effectGoDict[self.showEffectType]

	gohelper.setActive(go, false)
	gohelper.setActive(go, true)

	if self.showEffectType == Va3ChessEnum.EffectType.ArrowHit then
		local audioId
		local interactType = self._target.objType

		AudioMgr.instance:trigger((interactType == Va3ChessEnum.InteractType.Player or interactType == Va3ChessEnum.InteractType.AssistPlayer) and AudioEnum.chess_activity142.ArrowHitPlayer or AudioEnum.chess_activity142.MonsterBeHit)
	end
end

function Va3ChessInteractEffect:loadEffect()
	local effectType = self.showEffectType

	if tabletool.indexOf(self.loadedEffectTypeList, effectType) then
		return
	end

	table.insert(self.loadedEffectTypeList, effectType)

	local path = Va3ChessEnum.EffectPath[effectType]

	loadAbAsset(path, true, self._onLoadCallback, self)
end

function Va3ChessInteractEffect:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		table.insert(self.assetItemList, assetItem)
		assetItem:Retain()

		local effectGO = gohelper.clone(assetItem:GetResource(), self.effectGoContainer)

		self.effectGoDict[self.showEffectType] = effectGO

		gohelper.setActive(effectGO, false)
		self:showEffect(self.showEffectType)
	end
end

function Va3ChessInteractEffect:dispose()
	for _, effectType in ipairs(self.loadedEffectTypeList) do
		removeAssetLoadCb(Va3ChessEnum.EffectPath[effectType], self._onLoadCallback, self)
	end

	for k, assetItem in ipairs(self.assetItemList) do
		assetItem:Release()
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

return Va3ChessInteractEffect
