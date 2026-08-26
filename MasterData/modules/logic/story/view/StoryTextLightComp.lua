-- chunkname: @modules/logic/story/view/StoryTextLightComp.lua

module("modules.logic.story.view.StoryTextLightComp", package.seeall)

local StoryTextLightComp = class("StoryTextLightComp", StoryCompBase)

function StoryTextLightComp:onInit()
	return
end

function StoryTextLightComp:playTextEffect(textComp, effectType)
	self:setTextComp(textComp)
	self:setVisible(true)

	if effectType == StoryEnum.PictureInType.SoftLight then
		self:showSoftLight(true)
	elseif effectType == StoryEnum.PictureInType.GostMagic then
		self:showGostMagic(true)
	end
end

function StoryTextLightComp:hideTextEffect()
	self:setVisible(false)
	self:showSoftLight(false)
	self:showGostMagic(false)
end

function StoryTextLightComp:setTextComp(textComp)
	self.textComp = textComp
	self.textGO = textComp.gameObject
	self.textTransform = textComp.transform
	self.customTxt = self.textComp:GetComponent(typeof(UnityEngine.UI.CustomText))
	self.isTmpText = self.customTxt == nil

	if self.isTmpText then
		self._conMat = self.textComp.fontMaterial
	end
end

function StoryTextLightComp:setVisible(isVisible)
	self._isVisible = isVisible
end

function StoryTextLightComp:showSoftLight(show)
	if not self.isTmpText then
		return
	end

	if show then
		StoryTool.enablePostProcess(true)
		self._conMat:EnableKeyword("UNDERLAY_ON")
		self._conMat:SetFloat("_BloomFactor", 2.5)

		self._conMat.renderQueue = 4995

		local color = Color.New(0, 0, 0, 0.75)

		self._conMat:SetColor("_UnderlayColor", color)
		self._conMat:SetFloat("_UnderlayOffsetX", 0.143)
		self._conMat:SetFloat("_UnderlayOffsetY", -0.1)
		self._conMat:SetFloat("_UnderlayDilate", 0.107)
		self._conMat:SetFloat("_UnderlaySoftness", 0.447)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)
	else
		self._conMat:DisableKeyword("UNDERLAY_ON")
		self._conMat:SetFloat("_BloomFactor", 0)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)
	end
end

function StoryTextLightComp:showGostMagic(show)
	if not self.isTmpText then
		return
	end

	if not show then
		return
	end

	StoryTool.enablePostProcess(true)
	self:_setDistortMaterial()
	self:_setGostGlitch()

	local txt = self.textComp.text
	local anchorFlag, posX, posY, realTxt = string.match(txt, "^(L?)(-?%d+),(-?%d+)#(.*)")

	if posX and posY then
		self.textComp.text = realTxt

		if anchorFlag == "L" then
			local rt = self.textComp.rectTransform

			rt.anchorMin = Vector2(0, rt.anchorMin.y)
			rt.anchorMax = Vector2(0, rt.anchorMax.y)

			self.textComp:ForceMeshUpdate()
			recthelper.setAnchor(self.textTransform, tonumber(posX) + self.textComp.preferredWidth * 0.5, tonumber(posY))
		else
			recthelper.setAnchor(self.textTransform, tonumber(posX), tonumber(posY))
		end
	end

	PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
	PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 6.45)
	PostProcessingMgr.instance:setUIPPValue("bloomThreshold", 1.2)
	PostProcessingMgr.instance:setUIPPValue("bloomPercent", 1)
	PostProcessingMgr.instance:setUIPPValue("localBloomFactor", 1)
	PostProcessingMgr.instance:setUIPPValue("bloomIntensity", 10)
	PostProcessingMgr.instance:setUIPPValue("bloomRTDownTimes", 1)
	PostProcessingMgr.instance:setUIPPValue("localBloomColor", Color.New(0.55, 0.61, 1, 1))
end

function StoryTextLightComp:_setGostGlitch()
	if not self._gostFontGlitchGo then
		self:_loadGostFontGlitch()

		return
	end

	local goGlitchLine = gohelper.findChild(self._gostFontGlitchGo, "part_up")

	self.textComp:ForceMeshUpdate()

	local textInfo = self.textComp.textInfo
	local lineCount = textInfo.lineCount

	for i = 0, lineCount - 1 do
		local lineInfo = textInfo.lineInfo[i]
		local scaleX = transformhelper.getLossyScale(self.textTransform)
		local lineWidth = lineInfo.length * scaleX
		local lineY = lineInfo.baseline
		local lineGo = i == 0 and goGlitchLine or gohelper.clone(goGlitchLine, self._gostFontGlitchGo)

		gohelper.setActive(lineGo, true)

		local rt = lineGo:GetComponent(typeof(UnityEngine.RectTransform))

		if rt then
			recthelper.setAnchor(rt, 0, lineY)
		else
			transformhelper.setLocalPosXY(lineGo.transform, 0, lineY)
		end

		local ps = lineGo:GetComponent(typeof(UnityEngine.ParticleSystem))

		if ps then
			local shapeModule = ps.shape
			local s = shapeModule.scale

			shapeModule.scale = Vector3(lineWidth, s.y, s.z)
		end
	end
end

local gostFontGlitchPath = "story/v3a7_fontglitch"

function StoryTextLightComp:_loadGostFontGlitch()
	if self._gostFontLoader then
		return
	end

	local path = ResUrl.getEffect(gostFontGlitchPath)

	self._gostFontLoader = MultiAbLoader.New()

	self._gostFontLoader:addPath(path)
	self._gostFontLoader:startLoad(self._onGostFontGlitchLoaded, self)
end

function StoryTextLightComp:_onGostFontGlitchLoaded(loader)
	local path = ResUrl.getEffect(gostFontGlitchPath)
	local assetItem = loader:getAssetItem(path)

	self._gostFontGlitchGo = gohelper.clone(assetItem:GetResource(path), self.textGO)

	gohelper.setActive(self._gostFontGlitchGo, true)
	self:_setGostGlitch()
end

local distortMatPath = "font/meshpro/outline_material/hwzs_dynamic_distort.mat"

function StoryTextLightComp:_setDistortMaterial()
	if self._distortMat then
		self:_startGlitchAmountAnim()

		return
	end

	if not self._distortMatLoader then
		self._distortMatLoader = MultiAbLoader.New()

		self._distortMatLoader:addPath(distortMatPath)
		self._distortMatLoader:startLoad(self._onDistortMatLoaded, self)
	end
end

function StoryTextLightComp:_onDistortMatLoaded(loader)
	local assetItem = loader:getAssetItem(distortMatPath)
	local res = assetItem and assetItem:GetResource(distortMatPath)

	self._distortMat = UnityEngine.Object.Instantiate(res)

	self:_startGlitchAmountAnim()
end

function StoryTextLightComp:_startGlitchAmountAnim()
	self:_clearGlitchAmountTween()
	self:_setTmpFontMaterial(self._distortMat)
	self._conMat:EnableKeyword("UNDERLAY_ON")
	self._conMat:SetFloat("_BloomFactor", 2.5)

	self._conMat.renderQueue = 4995

	self:_glitchAmountUpdate(3.5)

	self._glitchAmountTweenId = ZProj.TweenHelper.DOTweenFloat(3.5, 1.8, 1.5, self._glitchAmountUpdate, self._glitchAmountEnd, self, nil, EaseType.Linear)
end

function StoryTextLightComp:_glitchAmountUpdate(value)
	if self._conMat then
		local glitchAmountId = UnityEngine.Shader.PropertyToID("_GlitchAmount")

		self._conMat:SetFloat(glitchAmountId, value)
	end
end

function StoryTextLightComp:_glitchAmountEnd()
	return
end

function StoryTextLightComp:_clearGlitchAmountTween()
	if self._glitchAmountTweenId then
		ZProj.TweenHelper.KillById(self._glitchAmountTweenId)

		self._glitchAmountTweenId = nil
	end
end

function StoryTextLightComp:showGlitch(show)
	self:setVisible(show)

	if self.isTmpText then
		return
	end

	if show then
		StoryTool.enablePostProcess(true)

		if not self._goGlitch then
			self._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			self._effLoader = MultiAbLoader.New()

			self._effLoader:addPath(self._glitchPath)
			self._effLoader:startLoad(self._glitchEffLoaded, self)
		else
			self:setCustomParticleVisible(true)
			gohelper.setActive(self._goGlitch, true)
		end
	else
		gohelper.setActive(self._goGlitch, false)
		self:setCustomParticleVisible(false)
	end
end

function StoryTextLightComp:setCustomParticleVisible(visible)
	if not self.customTxt then
		return
	end

	self.customTxt.isSetParticleShapeMesh = visible
	self.customTxt.isSetParticleCount = visible
end

function StoryTextLightComp:_glitchEffLoaded(loader)
	local glitchAssetItem = loader:getAssetItem(self._glitchPath)

	self._goGlitch = gohelper.clone(glitchAssetItem:GetResource(self._glitchPath), self.textGO)

	gohelper.setActive(self._goGlitch, true)

	local goGlitchUp = gohelper.findChild(self._goGlitch, "part_up")
	local goGlitchDown = gohelper.findChild(self._goGlitch, "part_down")
	local goScreen = gohelper.findChild(self._goGlitch, "part_screen")

	gohelper.setActive(goGlitchUp, false)
	gohelper.setActive(goGlitchDown, false)
	gohelper.setActive(goScreen, true)

	if self.customTxt then
		self.customTxt.particle = goScreen:GetComponent(typeof(UnityEngine.ParticleSystem))
	end

	self:showGlitch(self._isVisible)
end

function StoryTextLightComp:_setTmpFontMaterial(material)
	if not self.isTmpText then
		return
	end

	if material and not gohelper.isNil(self.textComp) then
		self.textComp.fontMaterial = material
		self._conMat = material
	end
end

function StoryTextLightComp:clear()
	if self._effLoader then
		self._effLoader:dispose()

		self._effLoader = nil
	end

	if self._distortMatLoader then
		self._distortMatLoader:dispose()

		self._distortMatLoader = nil
	end

	if self._gostFontLoader then
		self._gostFontLoader:dispose()

		self._gostFontLoader = nil
	end

	self:_clearGlitchAmountTween()
end

function StoryTextLightComp:onDestroy()
	self:clear()
end

return StoryTextLightComp
