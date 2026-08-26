-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsTextureShake.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsTextureShake", package.seeall)

local StoryBgEffsTextureShake = class("StoryBgEffsTextureShake", StoryBgEffsBase)

function StoryBgEffsTextureShake:ctor()
	StoryBgEffsTextureShake.super.ctor(self)
end

function StoryBgEffsTextureShake:init(bgCo)
	StoryBgEffsTextureShake.super.init(self, bgCo)

	self._bgCo = bgCo
	self._prefabPath = "ui/viewres/story/bg/v3a6_screennoise.prefab"

	table.insert(self._resList, self._prefabPath)

	self._effLoaded = false
end

function StoryBgEffsTextureShake:start(callback, callbackObj)
	StoryBgEffsTextureShake.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:loadRes()
end

function StoryBgEffsTextureShake:_onOpenView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	end
end

function StoryBgEffsTextureShake:_onCloseView(viewName)
	local isSetTopView = StoryModel.instance:isSetTopView(viewName)

	if isSetTopView then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	end
end

local DEFAULT_TEXTURE_SHAKE_SPEED = 1
local DEFAULT_DISTORT1_FACTOR = 0.25
local DEFAULT_NOISE_BRIGHTNESS = 0.47
local DEFAULT_BLACKWHITE_SPEED = 0.05
local DEFAULT_BLACKWHITE_STRENGTH = 0.45
local DEFAULT_DISTORT2_SPEED = 0.02
local DEFAULT_DISTORT2_FACTOR = 0.1

local function _toNumber(value, defaultValue)
	local num = tonumber(value)

	return num or defaultValue
end

local function _toBool(value, defaultValue)
	if value == nil then
		return defaultValue
	end

	if type(value) == "boolean" then
		return value
	end

	if type(value) == "number" then
		return value ~= 0
	end

	if type(value) == "string" then
		return value == "1" or value == "true"
	end

	return defaultValue
end

local function _clamp(value, minValue, maxValue)
	if value < minValue then
		return minValue
	end

	if maxValue < value then
		return maxValue
	end

	return value
end

local function _normalizeMatName(name)
	if not name then
		return nil
	end

	return string.gsub(name, " %(Instance%)$", "")
end

local function _appendUniqueMat(matList, material)
	if not material then
		return
	end

	for i = 1, #matList do
		if matList[i] == material then
			return
		end
	end

	matList[#matList + 1] = material
end

function StoryBgEffsTextureShake:_findEffectNode(path)
	if self._effRootGo then
		local node = gohelper.findChild(self._effRootGo, path)

		if self._effRootGo then
			return self._effRootGo
		end

		if not self._effsGo then
			return nil
		end

		node = gohelper.findChild(self._effsGo, path)

		if self._effRootGo then
			return self._effRootGo
		end

		return gohelper.findChild(self._effsGo, "root/" .. path)
	end
end

function StoryBgEffsTextureShake:_getNodeMaterial(nodeGo)
	if gohelper.isNil(nodeGo) then
		return nil
	end

	local img = nodeGo:GetComponent(gohelper.Type_Image)

	if img and img.material then
		return img.material
	end

	local renderer = nodeGo:GetComponent(typeof(UnityEngine.Renderer))

	if renderer and renderer.material then
		return renderer.material
	end

	return nil
end

function StoryBgEffsTextureShake:_cacheEffectNodes()
	self._effRootGo = gohelper.findChild(self._effsGo, "root") or gohelper.findChild(self._effsGo, "v3a6_screennoise/root") or self._effsGo
	self._noise1Go = self:_findEffectNode("noise_1")
	self._noise2Go = self:_findEffectNode("noise_2")
	self._distort1Go = self:_findEffectNode("distort_1")
	self._distort2Go = self:_findEffectNode("distort_2")
	self._blackWhiteGo = self:_findEffectNode("blackwhite")
	self._rootAnimation = self._effRootGo and self._effRootGo:GetComponent(gohelper.Type_Animation)
	self._rootAnimator = self._effRootGo and self._effRootGo:GetComponent(gohelper.Type_Animator)
	self._noise1Mat = self:_getNodeMaterial(self._noise1Go)
	self._noise2Mat = self:_getNodeMaterial(self._noise2Go)
	self._distort1Mat = self:_getNodeMaterial(self._distort1Go)
	self._distort2Mat = self:_getNodeMaterial(self._distort2Go)
	self._blackWhiteMat = self:_getNodeMaterial(self._blackWhiteGo)

	self:_rebindRootMaterialPropsCtrl()
end

function StoryBgEffsTextureShake:_rebindRootMaterialPropsCtrl()
	if not self._effRootGo then
		local rootGo = self._effsGo

		if gohelper.isNil(rootGo) then
			return
		end

		local matPropsCtrl = rootGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		if not matPropsCtrl or not matPropsCtrl.mas then
			return
		end

		local instancedMatList = {}

		_appendUniqueMat(instancedMatList, self._noise1Mat)
		_appendUniqueMat(instancedMatList, self._noise2Mat)
		_appendUniqueMat(instancedMatList, self._distort1Mat)
		_appendUniqueMat(instancedMatList, self._distort2Mat)
		_appendUniqueMat(instancedMatList, self._blackWhiteMat)

		if #instancedMatList <= 0 then
			return
		end

		if not matPropsCtrl.mas.Count then
			local oldCount = 0
			local sourceMatNameList = {}

			for i = 0, oldCount - 1 do
				local sourceMat = matPropsCtrl.mas[i]

				sourceMatNameList[i + 1] = sourceMat and _normalizeMatName(sourceMat.name) or nil
			end

			matPropsCtrl.mas:Clear()

			if oldCount <= 0 then
				for i = 1, #instancedMatList do
					matPropsCtrl.mas:Add(instancedMatList[i])
				end

				return
			end

			local usedIndex = {}

			for i = 1, oldCount do
				local sourceName = sourceMatNameList[i]
				local pickIndex

				if sourceName then
					for j = 1, #instancedMatList do
						if not usedIndex[j] and _normalizeMatName(instancedMatList[j].name) == sourceName then
							pickIndex = j

							break
						end
					end
				end

				if not pickIndex then
					for j = 1, #instancedMatList do
						if not usedIndex[j] then
							pickIndex = j

							break
						end
					end
				end

				if pickIndex then
					usedIndex[pickIndex] = true

					matPropsCtrl.mas:Add(instancedMatList[pickIndex])
				end
			end
		end
	end
end

function StoryBgEffsTextureShake:_setNodeActive(nodeGo, isActive)
	if gohelper.isNil(nodeGo) then
		return
	end

	gohelper.setActive(nodeGo, isActive)
end

function StoryBgEffsTextureShake:_setMaterialFloat(material, propName, value)
	if not material or not material:HasProperty(propName) then
		return
	end

	material:SetFloat(propName, value)
end

function StoryBgEffsTextureShake:_setMaterialAlpha(material, alpha)
	if not material then
		return
	end

	if material:HasProperty("_MainColor") then
		local mainColor = material:GetColor("_MainColor")

		mainColor.a = alpha

		material:SetColor("_MainColor", mainColor)
	end

	if material:HasProperty("_OutSideColor") then
		local outSideColor = material:GetColor("_OutSideColor")

		outSideColor.a = 1 - alpha

		material:SetColor("_OutSideColor", outSideColor)
	end
end

function StoryBgEffsTextureShake:_applyEffectParams()
	local textureEffectCo

	if self._bgCo and self._bgCo.effDegree >= 0 and StoryTextureEffectTypeModel and StoryTextureEffectTypeModel.instance then
		textureEffectCo = StoryTextureEffectTypeModel.instance:getStoryTextureEffectByType(self._bgCo.effDegree)
	end

	local noiseVisible = _toBool(textureEffectCo and textureEffectCo.noiseVisible, true)
	local distort1Visible = _toBool(textureEffectCo and textureEffectCo.distort1Visible, true)
	local textureShakeSpeed = _toNumber(textureEffectCo and textureEffectCo.textureShakeSpeed, DEFAULT_TEXTURE_SHAKE_SPEED)
	local distort1Factor = _toNumber(textureEffectCo and textureEffectCo.distort1Factor, DEFAULT_DISTORT1_FACTOR)
	local noiseBrightness = _clamp(_toNumber(textureEffectCo and textureEffectCo.noiseBrightness, DEFAULT_NOISE_BRIGHTNESS), 0, 0.5)
	local blackWhiteVisible = _toBool(textureEffectCo and textureEffectCo.blackWhiteVisible, true)
	local blackWhiteSpeed = _toNumber(textureEffectCo and textureEffectCo.blackWhiteSpeed, DEFAULT_BLACKWHITE_SPEED)
	local blackWhiteStrength = _clamp(_toNumber(textureEffectCo and textureEffectCo.blackWhiteStrength, DEFAULT_BLACKWHITE_STRENGTH), 0, 0.5)
	local distort2Visible = _toBool(textureEffectCo and textureEffectCo.distort2Visible, true)
	local distort2Speed = _toNumber(textureEffectCo and textureEffectCo.distort2Speed, DEFAULT_DISTORT2_SPEED)
	local distort2Factor = _toNumber(textureEffectCo and textureEffectCo.distort2Factor, DEFAULT_DISTORT2_FACTOR)

	self:_setNodeActive(self._noise1Go, noiseVisible)
	self:_setNodeActive(self._noise2Go, noiseVisible)
	self:_setNodeActive(self._distort1Go, distort1Visible)
	self:_setNodeActive(self._blackWhiteGo, blackWhiteVisible)
	self:_setNodeActive(self._distort2Go, distort2Visible)

	if self._rootAnimation then
		self._animationState = self._rootAnimation:get_Item("v3a6_screennoise")
		self._animationState.speed = textureShakeSpeed
	end

	if self._rootAnimator then
		self._rootAnimator.speed = textureShakeSpeed
	end

	self:_setMaterialFloat(self._distort1Mat, "_Factor", distort1Factor)
	self:_setMaterialAlpha(self._noise1Mat, noiseBrightness)
	self:_setMaterialAlpha(self._noise2Mat, noiseBrightness)
	self:_setMaterialFloat(self._blackWhiteMat, "_Speed", blackWhiteSpeed)
	self:_setMaterialAlpha(self._blackWhiteMat, blackWhiteStrength)
	self:_setMaterialFloat(self._distort2Mat, "_Speed", distort2Speed)
	self:_setMaterialFloat(self._distort2Mat, "_Factor", distort2Factor)
end

function StoryBgEffsTextureShake:onLoadFinished()
	StoryBgEffsTextureShake.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	if self._prefabPath then
		local prefAssetItem = self._loader:getAssetItem(self._prefabPath)
		local bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()

		self._effsGo = gohelper.clone(prefAssetItem:GetResource(), bgImgGo)

		self:_cacheEffectNodes()
		self:_applyEffectParams()
	end
end

function StoryBgEffsTextureShake:reset(bgCo)
	StoryBgEffsTextureShake.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end

	self:_applyEffectParams()
end

function StoryBgEffsTextureShake:_onEffFinished()
	return
end

function StoryBgEffsTextureShake:destroy()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	StoryBgEffsTextureShake.super.destroy(self)

	if self._effsGo then
		gohelper.destroy(self._effsGo)

		self._effsGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsTextureShake
