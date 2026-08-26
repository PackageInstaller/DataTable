-- chunkname: @modules/ugui/icon/common/CommonHeroCard.lua

module("modules.ugui.icon.common.CommonHeroCard", package.seeall)

local CommonHeroCard = class("CommonHeroCard", ListScrollCell)
local type_mask = typeof(UnityEngine.UI.Mask)
local GrayFactorMin = 0.001

function CommonHeroCard.create(go, reuseCase)
	local commonHeroCard = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommonHeroCard)

	commonHeroCard:setUseCase(reuseCase)

	return commonHeroCard
end

local spineCache = {}

function CommonHeroCard.put(reuseCase, skinId, guiSpine)
	if not reuseCase or not skinId or not guiSpine then
		if isDebugBuild then
			logError(string.format("put 参数为空 case{%s} skin{%s} spine{%s}", tostring(reuseCase), tostring(skinId), tostring(guiSpine)))
		end

		return
	end

	spineCache[reuseCase] = spineCache[reuseCase] or {}
	spineCache[reuseCase][skinId] = spineCache[reuseCase][skinId] or {}

	table.insert(spineCache[reuseCase][skinId], guiSpine)
end

function CommonHeroCard.get(reuseCase, skinId)
	if not reuseCase or not skinId then
		if isDebugBuild then
			logError(string.format("get 参数为空 case{%s} skin{%s}", tostring(reuseCase), tostring(skinId)))
		end

		return
	end

	local skinGuiSpines = spineCache[reuseCase]

	if skinGuiSpines then
		local guiSpines = skinGuiSpines[skinId]

		if guiSpines and #guiSpines > 0 then
			for i = #guiSpines, 1, -1 do
				local spine = table.remove(guiSpines, #guiSpines)

				if not gohelper.isNil(spine:getSpineGo()) then
					return spine
				end
			end
		end
	end
end

function CommonHeroCard.release(reuseCase, guiSpine)
	if not reuseCase or not guiSpine then
		if isDebugBuild then
			logError(string.format("release 参数为空 case{%s} spine{%s}", tostring(reuseCase), tostring(guiSpine)))
		end

		return
	end

	local skinGuiSpines = spineCache[reuseCase]

	if skinGuiSpines then
		for _, guiSpines in pairs(skinGuiSpines) do
			for i = #guiSpines, 1, -1 do
				if guiSpine == guiSpines[i] then
					table.remove(guiSpines, i)
				end
			end
		end
	end
end

function CommonHeroCard:init(go)
	self._go = go
	self._tr = go.transform
	self._imgIcon = gohelper.onceAddComponent(self._go, gohelper.Type_Image)
	self._spineGO = nil
	self._guiSpine = nil
end

function CommonHeroCard:setUseCase(needReuse)
	self._reuseCase = needReuse
end

function CommonHeroCard:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true

	if self._uiLimitSpine then
		local spineGraphic = self._uiLimitSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end
	end
end

function CommonHeroCard:setGrayScale(isGray)
	ZProj.UGUIHelper.SetGrayscale(self._go, isGray)
end

function CommonHeroCard:setGrayFactor(value)
	local prevGrayFactor = self._grayFactor

	self._grayFactor = value

	local isGrayBefore = prevGrayFactor and prevGrayFactor > GrayFactorMin

	if self._grayFactor then
		local isGrayNow = self._grayFactor > GrayFactorMin

		if (isGrayBefore and not isGrayNow or not isGrayBefore and isGrayNow) and self._skinConfig then
			self:onUpdateMO(self._skinConfig, true)
		end

		ZProj.UGUIHelper.SetGrayFactor(self._go, value)
	end
end

function CommonHeroCard:onUpdateMO(skinConfig, force)
	if skinConfig and skinConfig == self._skinConfig and not force then
		return
	end

	self:_checkPutSpineToPool(self._skinConfig)

	self._skinConfig = skinConfig
	self._limitedCO = self._skinConfig and lua_character_limited.configDict[self._skinConfig.id]

	if self._grayFactor then
		local isGray = self._grayFactor > GrayFactorMin
		local var_10_1 = self._limitedCO and (not string.nilorempty(self._limitedCO.spine) and not isGray or false)
		local showLimitedSpine = true

		goto label_10_0

		::label_10_0::

		if showLimitedSpine then
			local resPath = ResUrl.getRolesBustPrefab(self._limitedCO.spine)

			if self._uiLimitSpine then
				self._uiLimitSpine:setResPath(resPath, self._onSpineLoaded, self, true)
			else
				if self._reuseCase then
					self._uiLimitSpine = CommonHeroCard.get(self._reuseCase, self._skinConfig.id)

					if self._uiLimitSpine then
						self._limitSpineGO = self._uiLimitSpine._gameObj

						local x, y = recthelper.getAnchor(self._limitSpineGO.transform)

						gohelper.addChild(self._go, self._limitSpineGO)
						recthelper.setAnchor(self._limitSpineGO.transform, x, y)
					end
				end

				if not self._uiLimitSpine then
					self._limitSpineGO = gohelper.create2d(self._go, "LimitedSpine")
					self._uiLimitSpine = GuiSpine.Create(self._limitSpineGO, false)

					self._uiLimitSpine:setResPath(resPath, self._onSpineLoaded, self, true)
				end
			end

			gohelper.setActive(self._limitSpineGO, true)
			gohelper.setAsFirstSibling(self._limitSpineGO)

			if self._simageIcon then
				self._simageIcon:UnLoadImage()
			end

			self._imgIcon.enabled = true

			TaskDispatcher.runRepeat(self._checkAlphaClip, self, 0.05, 20)
		else
			TaskDispatcher.cancelTask(self._checkAlphaClip, self)

			self._simageIcon = self._simageIcon or gohelper.getSingleImage(self._go)

			local imageUrl = ResUrl.getHeadIconMiddle(self._skinConfig.retangleIcon)

			if self._simageIcon.curImageUrl ~= imageUrl then
				self._simageIcon:UnLoadImage()
			end

			self._simageIcon:LoadImage(imageUrl)
		end

		if showLimitedSpine then
			if not self._mask then
				self._mask = gohelper.onceAddComponent(self._go, type_mask)
				self._mask.showMaskGraphic = false
			end

			self._mask.enabled = true
		elseif self._mask then
			self._mask.enabled = false
		end
	end
end

function CommonHeroCard:onEnable()
	if self._uiLimitSpine then
		TaskDispatcher.runRepeat(self._checkAlphaClip, self, 0.05, 20)
	end
end

function CommonHeroCard:_checkAlphaClip()
	if not self._uiLimitSpine then
		TaskDispatcher.cancelTask(self._checkAlphaClip, self)

		return
	end

	local spineGraphic = self._uiLimitSpine:getSkeletonGraphic()

	if gohelper.isNil(spineGraphic) then
		return
	end

	if spineGraphic.color.a < 1 then
		ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)

		return
	end

	local parent = spineGraphic.transform.parent

	for i = 1, 5 do
		if parent == nil then
			return
		end

		local canvasGroup = parent:GetComponent(gohelper.Type_CanvasGroup)

		if canvasGroup and canvasGroup.alpha < 1 then
			ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)

			return
		end

		parent = parent.parent
	end
end

function CommonHeroCard:_checkPutSpineToPool(prevSkinConfig)
	if self._uiLimitSpine then
		if not gohelper.isNil(self._uiLimitSpine:getSpineGo()) then
			gohelper.setActive(self._limitSpineGO, false)

			if self._reuseCase and prevSkinConfig then
				CommonHeroCard.put(self._reuseCase, prevSkinConfig.id, self._uiLimitSpine)

				self._uiLimitSpine = nil
				self._limitSpineGO = nil
			end
		else
			self._uiLimitSpine:doClear()

			if not gohelper.isNil(self._limitSpineGO) then
				gohelper.destroy(self._limitSpineGO)
			end

			self._uiLimitSpine = nil
			self._limitSpineGO = nil
		end
	end
end

function CommonHeroCard:_onSpineLoaded()
	if not self._limitedCO.spineParam[1] then
		if not self._limitedCO.spineParam[2] then
			local posY = 0

			if not self._limitedCO.spineParam[3] then
				local scale = 1
				local spineTr = self._uiLimitSpine:getSpineTr()

				recthelper.setAnchor(spineTr, recthelper.getAnchor(self._tr))
				recthelper.setWidth(spineTr, recthelper.getWidth(self._tr))
				recthelper.setHeight(spineTr, recthelper.getHeight(self._tr))
				recthelper.setAnchor(spineTr, self._limitedCO.spineParam[1], posY)
				transformhelper.setLocalScale(spineTr, scale, scale, 1)
				self:setSpineRaycastTarget(self._raycastTarget)
			end
		end
	end
end

function CommonHeroCard:onDestroy()
	TaskDispatcher.cancelTask(self._checkAlphaClip, self)

	if self._reuseCase then
		if not self._uiLimitSpine then
			local limitSpineGO = gohelper.findChild(self._go, "LimitedSpine")

			if limitSpineGO then
				self._uiLimitSpine = MonoHelper.getLuaComFromGo(limitSpineGO, GuiSpine)
			end
		end

		if self._uiLimitSpine then
			CommonHeroCard.release(self._reuseCase, self._uiLimitSpine)
		end
	end

	if self._uiLimitSpine then
		self._uiLimitSpine:doClear()

		self._uiLimitSpine = nil
	end

	if self._simageIcon then
		self._simageIcon:UnLoadImage()

		self._simageIcon = nil
	end
end

return CommonHeroCard
