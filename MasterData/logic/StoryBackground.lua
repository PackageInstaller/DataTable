-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/background/StoryBackground.lua

module("logic.extensions.story.view.background.StoryBackground", package.seeall)

local StoryBackground = class("StoryBackground")

StoryBackground.PaletteShaderEnable = false

function StoryBackground:ctor(rawImageNode, view, effNode, uiCamera)
	self._effNode = effNode
	self._view = view
	self._uiCamera = uiCamera
	self._rawImageNode = rawImageNode
	self._canvasGroup = rawImageNode:GetComponent("CanvasGroup")
	self._background = rawImageNode:GetComponent("RawImage")
	self._tweenIn = rawImageNode:GetComponent(UnityTweensType.UITweenFadeTo)
	self._tweenOut = rawImageNode:GetComponent(UnityTweensType.UITweenFadeOut)
	self._tweenIn.time = StoryConst.FadeIn_Time
	self._tweenOut.time = StoryConst.FadeOut_Time
	self._loadResCount = 0
	self._bgImgExistes = nil
	self._anchorMinWithImg = Vector2.New(0.5, 0.5)
	self._anchorMaxWithImg = Vector2.New(0.5, 0.5)
	self._sizeDeltaWithImg = Vector2.New(1600, 720)
	self._anchorMinWithEmptyImg = Vector2.New(0, 0)
	self._anchorMaxWithEmptyImg = Vector2.New(1, 1)
	self._sizeDeltaWithEmptyImg = Vector2.New(0, 0)
end

function StoryBackground:onEnter()
	self._canvasGroup.alpha = 0
	self._loadResCount = 0

	self._tweenIn:AddListener(self._onTweenInFinish, self)
	self._tweenOut:AddListener(self._onTweenOutFinish, self)
end

function StoryBackground:onExit()
	self._tweenIn:RemoveListener()
	self._tweenOut:RemoveListener()
	self._tweenIn:Stop()
	self._tweenOut:Stop()

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	if self._effResLoader then
		GameUtil.unloadMultiResLoaderResource(self._effResLoader)

		self._effResLoader = nil
	end

	self:stopEffect()
	self:_unblurScreen()

	self._loadResCount = 0
	self._texturePath = nil
	self._loadedCallback = nil
	self._loadedCallbackTarget = nil
	self._fadeInCallback = nil
	self._fadeInCallbackTarget = nil
	self._fadeOutCallback = nil
	self._fadeOutCallbackTarget = nil
	self._bgImgExistes = nil
	self._currConfig = nil

	self:_clearMatRes()
end

function StoryBackground:setLoadedCallback(callback, target)
	self._loadedCallback = callback
	self._loadedCallbackTarget = target
end

function StoryBackground:isEqual(config)
	if not self._currConfig then
		return
	end

	local bgImg = self:_getImageBg(self._currConfig)
	local nextBgImg = self:_getImageBg(config)

	if bgImg ~= nextBgImg then
		return
	end

	return config.bgEff == self._currConfig.bgEff
end

function StoryBackground:isEmpty()
	local bgImg = self:_getImageBg(self._currConfig)

	return not bgImg or #bgImg == 0 or bgImg == StoryConst.Story_BG_None
end

function StoryBackground:isNeeedSwitch(isFirst)
	if StoryController.instance.firstStoryId and not TaskController.instance:hasDoFirstTaskTarget() and StoryController.instance.isFirstltPlayStoryBg then
		StoryController.instance.isFirstltPlayStoryBg = nil

		return
	end

	local bgImg = self:_getImageBg(self._currConfig)

	if isFirst then
		return bgImg and #bgImg > 0 and bgImg ~= StoryConst.Story_BG_None and bgImg ~= StoryConst.Story_BG_Black and bgImg ~= StoryConst.Story_BG_Gray and bgImg ~= StoryConst.Story_BG_SceneBlur
	else
		return bgImg and #bgImg > 0 and bgImg ~= StoryConst.Story_BG_None and bgImg ~= StoryConst.Story_BG_Black and bgImg ~= StoryConst.Story_BG_Gray
	end
end

function StoryBackground:prepareBackgroundResources(storyConfig, callback, target)
	self._loadedCallback = callback
	self._loadedCallbackTarget = target
	self._currConfig = storyConfig
	self._loadResCount = 0

	self:_calculateNeedLoadResCount(storyConfig)

	if not StoryModel.instance.isPlayingAnimStory then
		SceneFacade.instance:showSceneObjects(true)
		GlobalModel.instance:visibleMainCamera(true)

		if self:isNeedHideSceneCameras() then
			SceneFacade.instance:showOthersPlayers(false)
		end
	end

	local loadResCount = self._loadResCount
	local bgImg = self:_getImageBg(storyConfig)

	if not self:_isEmptyImage(bgImg) then
		self:_showBackgroundImage(bgImg)
	else
		self:_showEmptyImage(bgImg)
	end

	if storyConfig.bgEff and #storyConfig.bgEff > 0 and storyConfig.bgEff ~= StoryConst.Story_Effect_None then
		self:_showEffect(storyConfig.bgEff)
	elseif storyConfig.bgEff == StoryConst.Story_Effect_None then
		self:stopEffect()
	end

	if loadResCount == 0 then
		self:_onAllResourceLoaded()
	end
end

function StoryBackground:_isEmptyImage(bgImg)
	if not bgImg or #bgImg == 0 or bgImg == StoryConst.Story_BG_None or bgImg == StoryConst.Story_BG_SceneBlur or bgImg == StoryConst.Story_BG_Black or bgImg == StoryConst.Story_BG_Gray then
		return true
	end
end

function StoryBackground:_onAllResourceLoaded()
	if self._loadResCount == 0 and self._loadedCallback then
		if self._loadedCallbackTarget then
			self._loadedCallback(self._loadedCallbackTarget)
		else
			self._loadedCallback()
		end
	end
end

function StoryBackground:startFadeBackGround(fadeInCallback, fadeInCallbackTarget, fade)
	self._fadeInCallback = fadeInCallback
	self._fadeInCallbackTarget = fadeInCallbackTarget

	self:_startTweenIn(fade)
end

function StoryBackground:_calculateNeedLoadResCount(storyConfig)
	if storyConfig.bgImg == StoryConst.Story_BG_None then
		return
	end

	local bgImg = self:_getImageBg(storyConfig)

	if bgImg == StoryConst.Story_BG_SceneBlur or not self:_isEmptyImage(bgImg) then
		self._loadResCount = self._loadResCount + 1
	end

	if storyConfig.bgEff and #storyConfig.bgEff > 0 and storyConfig.bgEff ~= StoryConst.Story_Effect_None then
		self._loadResCount = self._loadResCount + 1
	end
end

function StoryBackground:_showBackgroundImage(texturePath)
	self._resLoader = self._resLoader or MultiResLoader.New()

	local rect = self._background.gameObject:GetComponent(goutil.Type_RectTransform)

	rect.anchorMin = self._anchorMinWithImg
	rect.anchorMax = self._anchorMaxWithImg
	rect.sizeDelta = self._sizeDeltaWithImg

	self:setColorRGBA(1, 1, 1, 1)

	self._bgImgExistes = true
	self._canvasGroup.alpha = 0

	self._background.transform:SetAsLastSibling()

	self._texturePath = StoryConst.StoryPath_BigImgBg .. texturePath

	if not string.find(self._texturePath, ".png") then
		self._texturePath = self._texturePath .. ".png"
	end

	self._resLoader:addResPath(self._texturePath)

	self._resLoader.loadedCount = 0

	self._resLoader:load(self._onImageResourcesLoaded, nil, self)
end

function StoryBackground:_createBackgroundMat(_call_back)
	if self.mat_res then
		return
	end

	self._matResLoader = MultiResLoader.New()
	self.matResourcesList = {}

	table.insert(self.matResourcesList, "ui/skinlib/ui_color_model_change.mat")
	table.insert(self.matResourcesList, "ui/skinlib/ui_story_color.mat")
	self._matResLoader:setResPaths(self.matResourcesList)
	self._matResLoader:load(function()
		self.mat_res = {}

		for i = 1, #self.matResourcesList do
			if i == 1 then
				self.mat_res.ui_color_model_change = self._matResLoader:getResource(self.matResourcesList[i])
			elseif i == 2 then
				self.mat_res.ui_story_color = self._matResLoader:getResource(self.matResourcesList[i])
			end
		end

		if _call_back then
			_call_back()
		end
	end, nil, self)
end

function StoryBackground:_getMatShaderInfo()
	if not self._currConfig then
		return
	end

	local shader_name = self._currConfig[44]
	local shader_param = self._currConfig[45]

	if (not shader_name or not shader_param) and self._currConfig.speakAsides and self._currConfig.speakAsides[1] then
		shader_name = self._currConfig.speakAsides[1][44]
		shader_param = self._currConfig.speakAsides[1][45]
	end

	return {
		shader_name = shader_name,
		shader_param = shader_param
	}
end

function StoryBackground:_testShaderInfo(shader_info)
	self.counttest = self.counttest or 0
	self.counttest = self.counttest + 1

	if self.counttest % 2 == 0 then
		shader_info.shader_name = shader_info.shader_name or "ui_color_model_change"
		shader_info.shader_param = shader_info.shader_param or "0,0,1,0.22,1,0,1,0,0,0,0,0,0,0.94,0.1,1,1,1"
	else
		shader_info.shader_name = shader_info.shader_name or "ui_story_color"
		shader_info.shader_param = shader_info.shader_param or "0.537,0.309,1,3.04,1"
	end

	return shader_info
end

function StoryBackground:_updateMat(texture)
	local shader_info = self:_getMatShaderInfo()

	if shader_info.shader_name and shader_info.shader_param and self.mat_res and self.mat_res[shader_info.shader_name] then
		self._background.material = self.mat_res[shader_info.shader_name]:GetMainAsset()
	else
		return
	end

	self._background.texture = nil

	self._background.material:SetTexture("_MainTex", texture)

	local param_array = string.split(shader_info.shader_param, ",")
	local shader_param_tb = {}

	if shader_info.shader_name == "ui_color_model_change" then
		if #param_array ~= 18 then
			printError("ui_color_model_change param error=", #param_array)

			return
		end

		shader_param_tb = {
			RFromOldR = param_array[1],
			RFromOldG = param_array[2],
			RFromOldB = param_array[3],
			GFromOldR = param_array[4],
			GFromOldG = param_array[5],
			GFromOldB = param_array[6],
			BFromOldR = param_array[7],
			BFromOldG = param_array[8],
			BFromOldB = param_array[9],
			_AddR = param_array[10],
			_AddG = param_array[11],
			_AddB = param_array[12],
			_LockExtremeValue = param_array[13],
			_LockExtremeMax = param_array[14],
			_LockExtremeMin = param_array[15],
			_Contrast = param_array[16],
			_Light = param_array[17],
			_Enable = param_array[18]
		}
	elseif shader_info.shader_name == "ui_story_color" then
		if #param_array ~= 5 then
			printError("ui_story_color param error=", #param_array)

			return
		end

		shader_param_tb = {
			_ColorChangeR = param_array[1],
			_ColorChangeG = param_array[2],
			_ColorChangeB = param_array[3],
			_Light = param_array[4],
			_Enable = param_array[5]
		}
	end

	for k, v in pairs(shader_param_tb) do
		self._background.material:SetFloat(k, tonumber(v))
	end

	return true
end

function StoryBackground:_clearMatRes()
	if self._matResLoader then
		GameUtil.unloadMultiResLoaderResource(self._matResLoader)

		self._matResLoader = nil
	end

	if self.mat_res then
		for shader_name, v in pairs(self.mat_res) do
			if self.mat_res[shader_name] ~= nil then
				self.mat_res[shader_name] = nil
			end
		end

		self.mat_res = nil
	end
end

function StoryBackground:_onImageResourcesLoaded(loader)
	local texture
	local res = self._resLoader:getResource(self._texturePath)

	if res then
		texture = res:GetMainAsset()
	end

	self._loadResCount = self._loadResCount - 1

	if not StoryBackground.PaletteShaderEnable then
		self._background.texture = texture
	else
		local shader_info = self:_getMatShaderInfo()

		if shader_info.shader_name then
			if self.mat_res then
				if not self:_updateMat(texture) then
					self:_setOrdinaryTex(texture)
				end
			else
				self:_createBackgroundMat(function()
					if not self:_updateMat(texture) then
						self:_setOrdinaryTex(texture)
					end
				end)
			end
		else
			self:_setOrdinaryTex(texture)
		end
	end

	self:_onAllResourceLoaded()
end

function StoryBackground:_setOrdinaryTex(texture)
	if not texture then
		return
	end

	if self._background.material and self._background.material:HasProperty("_Enable") then
		self._background.material:SetFloat("_Enable", 0)
	end

	self._background.texture = texture
end

function StoryBackground:_showEmptyImage(bgImg)
	self._canvasGroup.alpha = 0

	local rect = self._background.gameObject:GetComponent(goutil.Type_RectTransform)

	rect.anchorMin = self._anchorMinWithEmptyImg
	rect.anchorMax = self._anchorMaxWithEmptyImg
	rect.sizeDelta = self._sizeDeltaWithEmptyImg

	self._background.transform:SetAsLastSibling()

	if bgImg == StoryConst.Story_BG_None then
		self._background.texture = nil
		self._bgImgExistes = nil
	elseif bgImg == StoryConst.Story_BG_SceneBlur then
		self._background.texture = nil

		self:_blurScreen()
	elseif bgImg == StoryConst.Story_BG_Black then
		self._bgImgExistes = true
		self._background.texture = nil

		self:setColorRGBA(0, 0, 0, 1)
	elseif bgImg == StoryConst.Story_BG_Gray then
		self._bgImgExistes = true
		self._background.texture = nil

		self:setColorRGBA(0, 0, 0, 0.5)
	end
end

function StoryBackground:_getImageBg(currConfig)
	return currConfig.bgImg
end

function StoryBackground:onSceneLoadedStart()
	self:_unblurScreen()
end

function StoryBackground:_blurScreen()
	local mainCam, animCam

	if AnimationPlayer.instance:isPlayingAnim() then
		animCam = goutil.find("ui_anim_camera_create")
	end

	if not animCam then
		local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

		mainCam = mainCamera:getCamera().gameObject
	else
		mainCam = animCam
	end

	self._bgImgExistes = true

	self:setColorRGBA(0.8823529411764706, 0.8823529411764706, 0.8823529411764706, 1)

	self._blurCamera = mainCam

	local compCam = mainCam:GetComponent(typeof(UnityEngine.Camera))

	if StoryBackground.PaletteShaderEnable and self._background.material and self._background.material:HasProperty("_Enable") then
		self._background.material:SetFloat("_Enable", 0)
	end

	compCam.cullingMask = GoUtil.MaskLayer(compCam.cullingMask, SceneLayer.Ground3D_Value)

	if self._blurCamera then
		print("self._blurCamera name = " .. self._blurCamera.transform.name)

		if AMBlurScreenEffect.finalTexture then
			self._background.texture = AMBlurScreenEffect.finalTexture

			self:_onCaptureScreenFinish()
		else
			local ef = AMBlurScreenEffect.BlurWithRawImage(mainCam, self._background, 0.2, 1, 3, 0.98)

			ef:AddListener(self._onCaptureScreenFinish, self)
		end
	end
end

function StoryBackground:_onCaptureScreenFinish(tex)
	self._loadResCount = self._loadResCount - 1

	self:_onAllResourceLoaded()

	if self._blurCamera then
		self._blurCamera:GetComponent(typeof(UnityEngine.Camera)).orthographicSize = CitySceneCameraEx.orthographicSize
	end
end

function StoryBackground:_unblurScreen()
	if self._blurCamera then
		if StoryBackgroundCtrl.lockBlurScreen == 0 then
			AMBlurScreenEffect.UnBlur(self._blurCamera)
		end

		local compCam = self._blurCamera:GetComponent(typeof(UnityEngine.Camera))

		compCam.cullingMask = GoUtil.UnMaskLayer(compCam.cullingMask, SceneLayer.Ground3D_Value)
		self._blurCamera = nil
	end
end

function StoryBackground:isNeedHideSceneCameras()
	local bgImg = self:_getImageBg(self._currConfig)

	if bgImg == StoryConst.Story_BG_SceneBlur or bgImg == StoryConst.Story_BG_Black or not self:_isEmptyImage(bgImg) then
		return true
	end
end

function StoryBackground:_startTweenIn(fade)
	if self._effectIns then
		self._effectIns:SetActive(true)
	end

	self._tweenIn:Stop()
	self._tweenOut:Stop()

	if self._bgImgExistes then
		if fade and (TaskController.instance:hasDoFirstTaskTarget() or not StoryController.instance.firstStoryId) then
			self._canvasGroup.alpha = 0

			self._tweenIn:Begin()
		else
			self._canvasGroup.alpha = 1

			self:_onTweenInFinish()
		end
	else
		self._canvasGroup.alpha = 0

		self:_onTweenInFinish()
	end
end

function StoryBackground:_showEffect(effPath, posX, posY)
	self._effResLoader = self._effResLoader or MultiResLoader.New()

	self:stopEffect()
	Framework.TransformUtil.SetLocalPos(self._effNode.transform, posX or 0, posY or 0, 0)

	self._effPath = StoryConst.StoryPath_Effects .. effPath

	self._effResLoader:addResPath(self._effPath)

	self._effResLoader.loadedCount = 0

	self._effResLoader:load(self._onEffResourcesLoaded, nil, self)
end

function StoryBackground:_onEffResourcesLoaded(loader)
	self._loadResCount = self._loadResCount - 1

	local res = self._effResLoader:getResource(self._effPath)
	local prefab = res:GetMainAsset()

	self._effectIns = goutil.clone(prefab)

	local x, y, z = UGUIToolHelper.UGUIToUnityPositionInCenter(self._uiCamera, self._effNode:GetComponent(goutil.Type_RectTransform), nil, ofsX or 0, ofsY or 0, nil, nil, nil)

	if self._effectIns then
		if self._effectIns == SceneLayer.UI1_Value then
			Framework.GameObjectUtil.SetLayerRecursively(self._effectIns, SceneLayer.UI_Value)
		end

		Framework.TransformUtil.SetPos(self._effectIns.transform, x, y, self._uiCamera.nearClipPlane + 0.2)
		self._effectIns:SetActive(false)
		GoUtil.SetSortingOrder(self._effectIns, 10010)
	end

	self:_onAllResourceLoaded()
end

function StoryBackground:getBgEffIns()
	return self._effectIns
end

function StoryBackground:stopEffect()
	if self._effectIns then
		goutil.destroy(self._effectIns, true)

		self._effectIns = nil
		self._effPath = nil
	end
end

function StoryBackground:setCanvasAlpha(a)
	self._canvasGroup.alpha = a
end

function StoryBackground:setColorRGBA(r, g, b, a)
	UGUIToolHelper.SetColorRGBA(self._background, r, g, b, a)
end

function StoryBackground:isLoading()
	return self._loadResCount > 0
end

function StoryBackground:hideBackground(callback, target)
	self._fadeOutCallback = callback
	self._fadeOutCallbackTarget = target

	self._tweenIn:Stop()
	self._tweenOut:Stop()
	self:stopEffect()

	if self._bgImgExistes then
		self._tweenOut:Begin()
	else
		self:_onTweenOutFinish()
	end
end

function StoryBackground:_onTweenInFinish()
	if not StoryModel.instance.isPlayingAnimStory and self:isNeedHideSceneCameras() then
		SceneFacade.instance:showSceneObjects(false)
		GlobalModel.instance:visibleMainCamera(false)
	end

	if self._fadeInCallback then
		if self._fadeInCallbackTarget then
			self._fadeInCallback(self._fadeInCallbackTarget)
		else
			self._fadeInCallback()
		end
	end
end

function StoryBackground:_onTweenOutFinish()
	if self._fadeOutCallback then
		if self._fadeOutCallbackTarget then
			self._fadeOutCallback(self._fadeOutCallbackTarget)
		else
			self._fadeOutCallback()
		end
	end
end

return StoryBackground
