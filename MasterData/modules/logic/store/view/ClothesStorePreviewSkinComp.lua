-- chunkname: @modules/logic/store/view/ClothesStorePreviewSkinComp.lua

module("modules.logic.store.view.ClothesStorePreviewSkinComp", package.seeall)

local ClothesStorePreviewSkinComp = class("ClothesStorePreviewSkinComp", LuaCompBase)
local spineDefaultSize = {
	500,
	780
}

function ClothesStorePreviewSkinComp:init(go)
	self.viewGO = go
	self.transform = go.transform
	self._goskincontainer = gohelper.findChild(self.viewGO, "bg/characterSpine/#go_skincontainer")
	self._gol2dRoot = gohelper.findChild(self.viewGO, "bg/characterSpine/#go_skincontainer/#go_l2d")
	self._simagel2d = gohelper.findChildSingleImage(self._gol2dRoot, "#simage_l2d")
	self._gobigspine = gohelper.findChild(self._gol2dRoot, "#go_spinecontainer/#go_spine")
	self._gospinecontainer = gohelper.findChild(self._gol2dRoot, "#go_spinecontainer")
	self._go2dRoot = gohelper.findChild(self.viewGO, "bg/characterSpine/#go_skincontainer/#go_2d")
	self._simage2d = gohelper.findChildSingleImage(self._go2dRoot, "#simage_skin")
	self._go2dspine = gohelper.findChild(self._go2dRoot, "#go_spinecontainer/#go_spine")
	self._go2dspinecontainer = gohelper.findChild(self._go2dRoot, "#go_spinecontainer")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "#txt_characterName")
	self._txtskinName = gohelper.findChildText(self.viewGO, "#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "#txt_skinNameEn")
	self.special2dBgScale = {
		[305305] = 2,
		[310504] = 0.954,
		[312003] = 2,
		[311003] = 2,
		[308303] = 2,
		[314403] = 1.5
	}
end

function ClothesStorePreviewSkinComp:addEventListeners()
	self.addEventCb(self, StoreController.instance, StoreEvent.OnPlaySkinVideo, self._onPlaySkinVideo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
end

function ClothesStorePreviewSkinComp:removeEventListeners()
	self.removeEventCb(self, StoreController.instance, StoreEvent.OnPlaySkinVideo, self._onPlaySkinVideo, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
end

function ClothesStorePreviewSkinComp:_onOpenFullView()
	self:stopVoice()
end

function ClothesStorePreviewSkinComp:_onPlaySkinVideo(goodsMo)
	if not goodsMo then
		return
	end

	self:stopVoice()
end

function ClothesStorePreviewSkinComp:setSmallSpineGO(gosmallspine)
	self._gosmallspine = gosmallspine
end

function ClothesStorePreviewSkinComp:setGoods(mo)
	self.goodsMO = mo
	self.showLive2d = StoreClothesGoodsItemListModel.instance:getIsLive2d()

	self:refreshView()
end

function ClothesStorePreviewSkinComp:refreshView()
	if not self.goodsMO then
		return
	end

	local product = self.goodsMO.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	self:refreshBg(self.showLive2d)
	self:refreshSmallSpine()
	self:refreshInfo()
end

function ClothesStorePreviewSkinComp:refreshBg(showLive2d)
	self:clearSkin()
	self:setGOActive(self._gol2dRoot, showLive2d)
	gohelper.setActive(self._go2dRoot, not showLive2d)
	recthelper.setAnchor(self._goskincontainer.transform, 0, 0)

	if showLive2d then
		self:refreshLive2d()
	else
		self:refresh2d()
	end
end

function ClothesStorePreviewSkinComp:setGOActive(go, isActive)
	if not go then
		return
	end

	gohelper.setActive(go, true)

	if isActive then
		transformhelper.setLocalPos(go.transform, 0, 0, 0)
	else
		transformhelper.setLocalPos(go.transform, 99999, 99999, 0)
	end
end

function ClothesStorePreviewSkinComp:refreshInfo()
	local heroConfig = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self._txtcharacterName.text = heroConfig.name

	gohelper.setActive(self._txtskinName.gameObject, true)
	gohelper.setActive(self._txtskinNameEn.gameObject, true)

	self._txtskinName.text = "— " .. self.skinCo.characterSkin
	self._txtskinNameEn.text = self.skinCo.characterSkinNameEng
end

function ClothesStorePreviewSkinComp:setBloomView(viewName)
	self._bloomView = viewName
end

function ClothesStorePreviewSkinComp:refreshLive2d()
	local live2dbg = self.skinCo.live2dbg

	self._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(live2dbg))

	if self._uiSpine == nil then
		self._uiSpine = GuiModelAgent.Create(self._gobigspine, true)

		if self._bloomView then
			self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self._bloomView)
		end

		self._uiSpine:setResPath(self.skinCo, self._onUISpineLoaded, self, CharacterVoiceEnum.NormalFullScreenEffectCameraSize)
	else
		self:_onUISpineLoaded()
	end
end

function ClothesStorePreviewSkinComp:_onUISpineLoaded()
	local offsetStr = self.skinCo.skinSwitchLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	if self._uiSpine then
		CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	end

	local scale = tonumber(offsets[3]) * 1

	transformhelper.setLocalScale(self._gobigspine.transform, scale, scale, scale)
	TaskDispatcher.cancelTask(self._tryPlayVoice, self)
	TaskDispatcher.runDelay(self._tryPlayVoice, self, 0.3)
end

function ClothesStorePreviewSkinComp:_tryPlayVoice()
	local voiceConfigs = HeroModel.instance:getHeroAllVoice(self.skinCo.characterId, self.skinCo.id)

	if not voiceConfigs or next(voiceConfigs) == nil then
		return
	end

	local ignoreVoiveType = {
		[CharacterEnum.VoiceType.MainViewSpecialInteraction] = 1,
		[CharacterEnum.VoiceType.MainViewSpecialRespond] = 1,
		[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = 1
	}
	local keys = {}

	for k, v in pairs(voiceConfigs) do
		if not ignoreVoiveType[v.type] then
			table.insert(keys, k)
		end
	end

	local randomKey = keys[math.random(1, #keys)]
	local voiceConfig = voiceConfigs[randomKey]

	if self._uiSpine then
		self._uiSpine:playVoice(voiceConfig)
	end
end

function ClothesStorePreviewSkinComp:stopVoice()
	if not self._uiSpine then
		return
	end

	self._uiSpine:stopVoice()
end

function ClothesStorePreviewSkinComp:refresh2d()
	if self:isUniqueSkin() and not string.nilorempty(self.skinCo.skin2dParams) then
		self._simage2d:LoadImage(ResUrl.getSkin2dBg(self.skinCo.id), self._loadedImage, self)
	else
		self._simage2d:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)
	end

	self:load2dSkinSpine(self.skinCo.skin2dParams)
end

function ClothesStorePreviewSkinComp:load2dSkinSpine(params)
	if string.nilorempty(params) then
		gohelper.setActive(self._go2dspine, false)

		return
	end

	gohelper.setActive(self._go2dspine, true)

	local spineData = self:filterSpineParams(params)

	if spineData.spinePath == self._cur2dSpinePath then
		return
	end

	self._cur2dSpinePath = spineData.spinePath
	self.skin2dSpine = self.skin2dSpine or GuiSpine.Create(self._go2dspine, false)

	local spineRootRect = self._go2dspine.transform

	recthelper.setWidth(spineRootRect, spineDefaultSize[1])
	transformhelper.setLocalPos(spineRootRect, spineData.spinePos[1], spineData.spinePos[2], 0)
	transformhelper.setLocalScale(spineRootRect, spineData.spineScale, spineData.spineScale, spineData.spineScale)
	self.skin2dSpine:setResPath(self._cur2dSpinePath, self._onSkinSpineLoaded, self, true)
end

function ClothesStorePreviewSkinComp:_onSkinSpineLoaded()
	local spineTr = self.skin2dSpine:getSpineTr()
	local rootTrans = spineTr.parent

	recthelper.setWidth(spineTr, recthelper.getWidth(rootTrans))
	recthelper.setHeight(spineTr, recthelper.getHeight(rootTrans))
end

function ClothesStorePreviewSkinComp:filterSpineParams(params)
	local data = {}
	local spineParam = string.split(params, "#")

	data.spinePath = spineParam[1]
	data.spinePos = spineParam[2] and string.splitToNumber(spineParam[2], ",") or {
		0,
		0
	}
	data.spineScale = spineParam[3] and tonumber(spineParam[3]) or 1

	return data
end

function ClothesStorePreviewSkinComp:refreshSmallSpine()
	self._goSpine = self._goSpine or GuiSpine.Create(self._gosmallspine, false)

	self._goSpine:stopVoice()
	self._goSpine:setResPath(ResUrl.getSpineUIPrefab(self.skinCo.spine), self._onSpineLoaded, self, true)

	local offsets = SkinConfig.instance:getSkinOffset(self.skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gosmallspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gosmallspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function ClothesStorePreviewSkinComp:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simage2d.gameObject)

	local offsetStr = self.skinCo.skinViewImgOffset

	if not self.special2dBgScale[self.skinCo.id] then
		local defaultScale = 1

		if not string.nilorempty(offsetStr) then
			local offsets = string.splitToNumber(offsetStr, "#")

			recthelper.setAnchor(self._simage2d.transform, tonumber(offsets[1]), tonumber(offsets[2]))

			local scale = tonumber(offsets[3]) * defaultScale

			transformhelper.setLocalScale(self._simage2d.transform, scale, scale, scale)
		else
			recthelper.setAnchor(self._simage2d.transform, -150, -150)
			transformhelper.setLocalScale(self._simage2d.transform, 0.6, 0.6, 0.6)
		end
	end
end

function ClothesStorePreviewSkinComp:clearSkin()
	TaskDispatcher.cancelTask(self._tryPlayVoice, self)
	self:stopVoice()
	self._simagel2d:UnLoadImage()
	self._simage2d:UnLoadImage()

	if self._goSpine then
		self._goSpine:stopVoice()
		self._goSpine:doClear()

		self._goSpine = nil
	end

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function ClothesStorePreviewSkinComp:isUniqueSkin()
	return self.goodsMO.config.skinLevel == 2
end

function ClothesStorePreviewSkinComp:onDestroy()
	self:clearSkin()
end

return ClothesStorePreviewSkinComp
