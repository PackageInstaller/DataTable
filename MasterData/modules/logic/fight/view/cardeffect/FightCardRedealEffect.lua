-- chunkname: @modules/logic/fight/view/cardeffect/FightCardRedealEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardRedealEffect", package.seeall)

local FightCardRedealEffect = class("FightCardRedealEffect", BaseWork)
local DissolveKeyWorkVariant = "UNITY_UI_DISSOLVE"
local DissolveMatPath = "ui/materials/dynamic/kapairongjie.mat"

function FightCardRedealEffect:onStart(context)
	FightCardRedealEffect.super.onStart(self, context)

	if self.context.oldCards and #self.context.oldCards > 0 then
		self._paramDict = {}
		self._loadingDissolveMat = true

		loadAbAsset(DissolveMatPath, false, self._onLoadDissolveMat, self)
		TaskDispatcher.runDelay(self._delayDone, self, 1.3 / FightModel.instance:getUISpeed())
	else
		logError("手牌变更失败，没有数据")
		TaskDispatcher.runDelay(self._delayDone, self, 0.5 / FightModel.instance:getUISpeed())
	end
end

function FightCardRedealEffect:_onLoadDissolveMat(assetItem)
	self._loadingDissolveMat = nil

	if assetItem.IsLoadSuccess then
		self._dissolveMat = UnityEngine.GameObject.Instantiate(assetItem:GetResource())

		self:_setupDissolveMat()
		self:_playDissolveMat()
	end

	self:_playEffects()
end

function FightCardRedealEffect:_playEffects()
	self._effectGOList = {}
	self._effectLoaderList = {}

	local oldCards = self.context.oldCards

	for cardIndex, changeInfo in ipairs(self.context.oldCards) do
		local handCardItem = self.context.handCardItemList[cardIndex]

		if not handCardItem.go.activeInHierarchy then
			self:onDone(true)

			return
		end
	end

	for cardIndex, changeInfo in ipairs(self.context.oldCards) do
		local handCardItem = self.context.handCardItemList[cardIndex]
		local oldCardInfo = oldCards[cardIndex]
		local oldCardLv = FightCardDataHelper.getSkillLv(oldCardInfo.uid, oldCardInfo.skillId)
		local changeEffectGO = gohelper.findChild(handCardItem.go, "changeEffect") or gohelper.create2d(handCardItem.go, "changeEffect")
		local effectLoader = PrefabInstantiate.Create(changeEffectGO)

		self._paramDict[effectLoader] = {
			oldCardLv = oldCardLv
		}

		effectLoader:startLoad(FightPreloadOthersWork.ClothSkillEffectPath, self._onClothSkillEffectLoaded, self)
		table.insert(self._effectGOList, changeEffectGO)
		table.insert(self._effectLoaderList, effectLoader)
	end
end

function FightCardRedealEffect:_onClothSkillEffectLoaded(effectLoader)
	local param = self._paramDict[effectLoader]
	local oldCardLv = param.oldCardLv
	local levelGO = gohelper.findChild(effectLoader:getInstGO(), tostring(oldCardLv))
	local effectTimeScale = gohelper.onceAddComponent(levelGO, typeof(ZProj.EffectTimeScale))

	effectTimeScale:SetTimeScale(FightModel.instance:getUISpeed())
	gohelper.setActive(levelGO, true)
end

function FightCardRedealEffect:_setupDissolveMat()
	self._imgMaskMatDict = {}
	self._imgMaskCloneDict = {}

	for cardIndex, changeInfo in ipairs(self.context.oldCards) do
		local handCardItem = self.context.handCardItemList[cardIndex]
		local forAnimGO = gohelper.findChild(handCardItem.go, "foranim")
		local imgList = {}

		FightCardRedealEffect._getChildActiveImage(forAnimGO, imgList)

		for _, img in ipairs(imgList) do
			if img.material == img.defaultMaterial then
				self._needSetMatNilDict = self._needSetMatNilDict or {}
				self._needSetMatNilDict[img] = true
				img.material = self._dissolveMat
			else
				self._imgMaskMatDict[img] = img.material
				img.material = UnityEngine.GameObject.Instantiate(img.material)

				img.material:EnableKeyword(DissolveKeyWorkVariant)
				img.material:SetVector("_OutSideColor", Vector4.New(0, 0, 0, 1))
				img.material:SetVector("_InSideColor", Vector4.New(0, 0, 0, 1))

				self._imgMaskCloneDict[img] = img.material
			end
		end
	end
end

function FightCardRedealEffect._getChildActiveImage(parentGO, imgList)
	if parentGO.activeInHierarchy and parentGO:GetComponent(typeof(UnityEngine.RectTransform)) then
		local img = parentGO:GetComponent(gohelper.Type_Image)

		if img then
			table.insert(imgList, img)
		end

		local tr = parentGO.transform
		local childCount = tr.childCount

		for i = 0, childCount - 1 do
			local child = tr:GetChild(i)

			FightCardRedealEffect._getChildActiveImage(child.gameObject, imgList)
		end
	end
end

function FightCardRedealEffect:_playDissolveMat()
	local originValue = MaterialUtil.getPropValueFromMat(self._dissolveMat, "_DissolveOffset", "Vector4")
	local tempVector4 = Vector4.New(0.07, originValue.y, originValue.z, originValue.w)

	MaterialUtil.setPropValue(self._dissolveMat, "_DissolveOffset", "Vector4", tempVector4)

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0.07, 1.7526, 0.6, function(value)
		tempVector4.x = value

		MaterialUtil.setPropValue(self._dissolveMat, "_DissolveOffset", "Vector4", tempVector4)

		if self._imgMaskCloneDict then
			for _, mat in pairs(self._imgMaskCloneDict) do
				MaterialUtil.setPropValue(mat, "_DissolveOffset", "Vector4", tempVector4)
			end
		end
	end, function()
		if self.context.newCards then
			for cardIndex, changeInfo in ipairs(self.context.newCards) do
				local handCardItem = self.context.handCardItemList[cardIndex]

				if handCardItem then
					handCardItem:updateItem(cardIndex, changeInfo)
				end
			end
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(1.7526, 0.07, 0.6, function(value)
			tempVector4.x = value

			MaterialUtil.setPropValue(self._dissolveMat, "_DissolveOffset", "Vector4", tempVector4)

			if self._imgMaskCloneDict then
				for _, mat in pairs(self._imgMaskCloneDict) do
					MaterialUtil.setPropValue(mat, "_DissolveOffset", "Vector4", tempVector4)
				end
			end
		end)
	end)
end

function FightCardRedealEffect:_delayDone()
	if self._lockGO then
		gohelper.setActive(self._lockGO, true)

		self._lockGO = nil
	end

	self:onDone(true)
end

function FightCardRedealEffect:clearWork()
	if self._loadingDissolveMat then
		removeAssetLoadCb(DissolveMatPath, self._onLoadDissolveMat, self)
	end

	TaskDispatcher.cancelTask(self._delayDone, self)
	self:_removeEffect()
	self:_removeDissolveMat()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if self._dissolveMat then
		gohelper.destroy(self._dissolveMat)
	end

	self._imgMaskMatDict = nil
	self._dissolveMat = nil
	self._tweenId = nil
	self._lockGO = nil
	self._paramDict = nil
end

function FightCardRedealEffect:_removeDissolveMat()
	if self._imgMaskMatDict then
		for img, mat in pairs(self._imgMaskMatDict) do
			img.material = mat
			self._imgMaskMatDict[img] = nil
		end
	end

	if self._imgMaskCloneDict then
		for key, mat in pairs(self._imgMaskCloneDict) do
			gohelper.destroy(mat)

			self._imgMaskCloneDict[key] = nil
		end
	end

	if self._needSetMatNilDict then
		for img, _ in pairs(self._needSetMatNilDict) do
			img.material = nil
			self._needSetMatNilDict[img] = nil
		end
	end

	self._needSetMatNilDict = nil
	self._imgMaskCloneDict = nil
	self._imgMaskMatDict = nil
end

function FightCardRedealEffect:_removeEffect()
	if self._effectLoaderList then
		for _, prefabInstantiate in ipairs(self._effectLoaderList) do
			prefabInstantiate:dispose()
		end
	end

	if self._effectGOList then
		for _, go in ipairs(self._effectGOList) do
			gohelper.destroy(go)
		end
	end

	self._effectGOList = nil
	self._effectLoaderList = nil
end

return FightCardRedealEffect
