-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryViewModel.lua

module("logic.extensions.story.view.StoryViewModel", package.seeall)

local StoryViewModel = class("StoryViewModel")
local colorId = UnityEngine.Shader.PropertyToID("_MainColor")

StoryViewModel.currSortingOrder = 0

function StoryViewModel:ctor(direction, charactor, imageNode, cam, uiCamera)
	self._imageNode = imageNode
	self._charactor = charactor
	self._uiCamera = uiCamera
	self._camera = cam
	self._direction = direction

	self:_initNodes()

	self._imagePath = nil
	self._isLoadingImg = nil
	self._isLoadingSpine = nil
	self._isLoadingEff = nil
	self._cacheSpineGos = nil
	self._cacheEffGos = nil
	self._resLoader = nil
	self._currShowObj = nil
	self._currShowEff = nil
	self._resEffLoader = nil
	self._transitionOut = nil
end

function StoryViewModel:onEnter()
	self._bigImgGo:SetActive(false)

	self._uiLayer = SceneLayer.UI3DEx_Value
	self._resLoader = MultiResLoader.New()
end

function StoryViewModel:onExit()
	self._currStory = nil
	self._uiLayer = nil
	self._currStoryConfig = nil

	self._bigImg:ClearImage()

	if self._cacheSpineGos ~= nil then
		for k, v in pairs(self._cacheSpineGos) do
			goutil.destroy(v, true)
		end
	end

	if self._cacheEffGos ~= nil then
		for k, v in pairs(self._cacheEffGos) do
			goutil.destroy(v, true)
		end
	end

	GameUtil.unloadMultiResLoaderResource(self._resLoader)
	GameUtil.unloadMultiResLoaderResource(self._resEffLoader)
	Framework.DynImageCache.Instance:ReleaseAllUnused()

	self._imagePath = nil
	self._isLoadingImg = nil
	self._isLoadingSpine = nil
	self._isLoadingEff = nil
	self._cacheSpineGos = nil
	self._cacheEffGos = nil
	self._resLoader = nil
	self._currShowObj = nil
	self._currShowEff = nil
	self._resEffLoader = nil
	self._lastTransitionOut = nil
	self._transitioningOut = nil
end

function StoryViewModel:setStory(story, storyConfig)
	self._lastTransitionOut = self._transitioningOut
	self._currStory = story
	self._dispearOver = self._currStory.disappear_over
	self._currStoryConfig = storyConfig

	if not self._currStoryConfig then
		self:setObject(nil)
	else
		if self._currStory and self._currStory.outStragety and #self._currStory.outStragety then
			self._transitioningOut = self._currStory.outStragety
		end

		if self._currStoryConfig and string.find(self._currStoryConfig.id, ".png") then
			self:_showImage()
		else
			self:_showModel()
		end
	end

	self:_playEffect()
end

function StoryViewModel:isDisappear_over()
	return self._dispearOver
end

function StoryViewModel:setColor(color)
	self._color = color

	if self._currShowObj then
		self:_setColorRGB(self._currShowObj, color, color, color)
	end
end

function StoryViewModel:isLoadingRes()
	return self._isLoadingImg or self._isLoadingSpine or self._isLoadingEff
end

function StoryViewModel:_initNodes()
	self._charactorParent = goutil.findChild(self._charactor, "Parent")
	self._effParent = goutil.findChild(self._charactor, "ParentEffect")
	self._bigImg = goutil.findChild(self._imageNode, "BigImg"):GetComponent(typeof(Framework.ImageBigBG))
	self._bigImgGo = self._bigImg.gameObject
	self._bigImgGraphic = self._bigImgGo:GetComponent("Image")
end

function StoryViewModel:setObject(go, transition)
	self._isTransitionIn = false

	local preGo = self._currShowObj

	self._currShowObj = go

	if self._currShowObj then
		if not self._currShowObj.activeSelf then
			self._currShowObj:SetActive(true)
		end

		self:_updateTransform()

		local spine = self._currShowObj:GetComponent(UnitCompSpine.SkeletonAnimationType)

		if spine then
			GoUtil.SetSortingOrder(self._currShowObj, StoryViewModel.currSortingOrder)

			StoryViewModel.currSortingOrder = StoryViewModel.currSortingOrder + 1

			local player = StorySpinePlayer.New()

			player.needResetOnStart = true

			player:setSpine(spine, StoryConst.getStoryModelActions(self._currStory), self._currStory.direction == StoryConst.DirRight)
		end
	end

	if transition == nil then
		transition = true
	end

	self:_exchangeObject(preGo, go, transition)

	if self._currShowObj then
		self:_startPerform(self._currShowObj, self._currStory.performed, self._currStory.performedParams or {})
	end
end

function StoryViewModel:hideObject()
	if self._currShowObj and self._currShowObj.activeSelf then
		self._currShowObj:SetActive(false)
	end

	self._lastTransitionOut = nil
end

function StoryViewModel:playEffect(effect, position)
	if self._currShowEff then
		self._currShowEff:SetActive(false)
	end

	if not effect or #effect == 0 then
		return
	end

	self._resEffLoader = self._resEffLoader or MultiResLoader.New()

	local go

	if self._cacheEffGos then
		go = self._cacheEffGos[effect]
	end

	if not go then
		local resPath = StoryConst.StoryPath_Effects .. effect

		self._resEffLoader:addResPath(resPath)

		self._resEffLoader.loadedCount = 0
		self._isLoadingEff = true

		self._resEffLoader:load(function(self)
			local res = self._resEffLoader:getResource(resPath)

			if not res then
				return
			end

			local prefab = res:GetMainAsset()

			if not prefab then
				return
			end

			local effectGO = goutil.clone(prefab)

			if not effectGO then
				return
			end

			self._cacheEffGos = self._cacheEffGos or {}
			self._cacheEffGos[effect] = effectGO

			Framework.GameObjectUtil.SetLayerRecursively(effectGO, self._uiLayer)
			self:_onEffectResourcesLoaded(effectGO, position)
		end, nil, self)
	else
		self:_onEffectResourcesLoaded(go, position)
	end
end

function StoryViewModel:_onEffectResourcesLoaded(effectGO, position)
	self._isLoadingEff = nil

	if self._currShowEff then
		self._currShowEff:SetActive(false)
	end

	self._currShowEff = effectGO

	if self._currShowEff then
		self._currShowEff:SetActive(true)
		self._currShowEff.transform:SetParent(self._effParent.transform)

		if position then
			Framework.TransformUtil.SetLocalPos(effectGO.transform, position[1] or 0, position[2] or 0, position[3] or 0)
			Framework.TransformUtil.SetLocalScale(effectGO.transform, 1, 1, 1)

			local lossyScale = effectGO.transform.lossyScale
			local sx = lossyScale.x
			local sy = lossyScale.y
			local sz = lossyScale.z

			sx = (position[4] or 1) / sx
			sy = (position[5] or 1) / sy
			sz = (position[6] or 1) / sz

			Framework.TransformUtil.SetLocalScale(effectGO.transform, sx, sy, sz)
		else
			Framework.TransformUtil.SetLocalPos(effectGO.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalScale(effectGO.transform, 1, 1, 1)
		end
	end
end

function StoryViewModel:_updateTransform()
	UnityTweens.UITweenFadeTo.StopTween(self._currShowObj)
	UnityTweens.TweenPosition.StopTween(self._currShowObj)

	local position = self._currStory.position and #self._currStory.position > 0 and self._currStory.position or self._currStoryConfig.position

	if position then
		Framework.TransformUtil.SetLocalPos(self._currShowObj.transform, position[1], position[2], position[3] or 0)
	else
		Framework.TransformUtil.SetLocalPos(self._currShowObj.transform, 0, 0, 0)
	end

	local scale = self._currStory.scale and self._currStory.scale > 0 and self._currStory.scale or self._currStoryConfig.scale

	if scale == 0 then
		Framework.TransformUtil.SetLocalScale(self._currShowObj.transform, 1, 1, 1)
	else
		local scaleY = math.abs(scale)

		Framework.TransformUtil.SetLocalScale(self._currShowObj.transform, scale, scaleY, scaleY)
	end
end

function StoryViewModel:_showImage()
	self._bigImgGo:SetActive(true)

	if self._imagePath ~= self._currStoryConfig.id then
		self._imagePath = self._currStoryConfig.id
		self._isLoadingImg = true

		self._bigImg:ClearImage()

		local bigImg = self._bigImg
		local modelObj = self

		uGuiUtil.setSpriteToImage(self._bigImg, uGuiUtil.SpriteType.BigBg, StoryConst.StoryPath_BigImg .. self._currStoryConfig.id, function(width, height)
			bigImg:GetComponent("RectTransform").sizeDelta = Vector2.New(width, height)

			modelObj:_onImageLoadedFinish()
		end)
	elseif not self._isLoadingImg then
		self:_onImageLoadedFinish()
	end
end

function StoryViewModel:_onImageLoadedFinish()
	self._isLoadingImg = nil

	self:setObject(self._bigImgGo)
end

function StoryViewModel:_showModel()
	local go

	if self._currStoryConfig then
		local modelPath = self._currStoryConfig.id

		if self._cacheSpineGos and modelPath then
			go = self._cacheSpineGos[modelPath]
		end

		if not go then
			local resPath = StoryConst.getSpineUrl(modelPath)

			self._resLoader:addResPath(resPath)

			self._resLoader.loadedCount = 0

			local storyView = self

			self._isLoadingSpine = true

			self._resLoader:load(function()
				self._isLoadingSpine = nil

				local skeletonGO = storyView:_getSpineInstance(resPath)

				if skeletonGO then
					local billboard = skeletonGO:GetComponent("Billboard")

					if billboard then
						billboard.enabled = false
					end

					local skeletonAnimation = skeletonGO:GetComponent(UnitCompSpine.SkeletonAnimationType)

					skeletonAnimation:Initialize(false)

					storyView._cacheSpineGos = storyView._cacheSpineGos or {}
					storyView._cacheSpineGos[modelPath] = skeletonGO
					skeletonGO.layer = storyView._uiLayer

					skeletonGO.transform:SetParent(storyView._charactorParent.transform)
					storyView:setObject(skeletonGO)
				end
			end)
		else
			self:setObject(go)
		end
	end
end

function StoryViewModel:_playEffect()
	if self._currStory and self._currStory.direction and self._currStory.effect and #self._currStory.effect > 0 then
		self:playEffect(self._currStory.effect, self._currStory.effPos)

		return
	end

	self:playEffect(nil)
end

function StoryViewModel:_getSpineInstance(path)
	local res = self._resLoader:getResource(path)

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			return goutil.clone(prefab)
		end
	end

	return nil
end

function StoryViewModel:_exchangeObject(fadeGo, showGo, transition)
	if not self._color then
		if fadeGo ~= showGo then
			if showGo then
				self:_setColorRGBA(showGo, self._color, self._color, self._color, 1)

				if transition then
					self:_transitionIn(showGo, self._currStory.inStragety)
				end
			end

			if fadeGo then
				self:_setColorRGBA(fadeGo, self._color, self._color, self._color, 1)

				if transition then
					self:_transitionOut(fadeGo, self._lastTransitionOut)

					self._lastTransitionOut = nil
				end
			end
		elseif showGo then
			UnityTweens.UITweenFadeTo.StopTween(showGo)
			self:_setColorRGBA(showGo, self._color, self._color, self._color, 1)
		end
	end
end

function StoryViewModel:_transitionIn(go, stragety)
	self._isTransitionIn = false

	if not self._color then
		if stragety and #stragety == 0 then
			stragety = nil
		end

		stragety = stragety or StoryConst.Story_FadeIn

		local cfgs = string.split(stragety, ",")

		if not cfgs[1] then
			if cfgs[1] == StoryConst.Story_FadeIn then
				if not cfgs[2] then
					local sTime = 0.2

					UnityTweens.UITweenShake.StopTween(go)
					UnityTweens.UITweenFadeTo.StopTween(go)
					UnityTweens.TweenPosition.StopTween(go)
					self:_setColorRGBA(go, self._color, self._color, self._color, 0)
					UnityTweens.UITweenFadeTo.StartTween(go, 1, sTime, UnityTweens.EaseType.easeOutSine)
				end
			else
				self._isTransitionIn = true

				local sTime = checknumber(cfgs[2])

				if sTime == 0 then
					sTime = 0.5
				end

				self:_setColorRGBA(go, self._color, self._color, self._color, 1)

				local px, py, pz = self:_getOffScreenPosition(go)
				local destPos = go.transform.position

				UnityTweens.UITweenShake.StopTween(go)
				UnityTweens.UITweenFadeTo.StopTween(go)
				UnityTweens.TweenPosition.StopTween(go)
				Framework.TransformUtil.SetPos(go.transform, px, py, pz)

				local tsIn = UnityTweens.TweenPosition.StartTween(go, Vector3.New(px, py, pz), destPos, sTime, UnityTweens.EaseType.easeOutSine, 0, UnityTweens.CoordSpace.World):AddListener(self._onTransitionInFinished, self)
			end
		end
	end
end

function StoryViewModel:_onTransitionInFinished()
	self._isTransitionIn = false

	self:_startPerform(self._currShowObj, self._currStory.performed, self._currStory.performedParams or {})
end

function StoryViewModel:_transitionOut(go, stragety)
	if not self._color then
		if stragety and #stragety == 0 then
			stragety = nil
		end

		stragety = stragety or StoryConst.Story_FadeOut

		local cfgs = string.split(stragety, ",")

		if not cfgs[1] then
			if cfgs[1] == StoryConst.Story_FadeOut then
				if not cfgs[2] then
					local sTime = 0.1

					UnityTweens.UITweenFadeTo.StopTween(go)
					UnityTweens.TweenPosition.StopTween(go)
					UnityTweens.UITweenShake.StopTween(go)
					UnityTweens.TweenScale.StopTween(go)
					self:_setColorRGBA(go, self._color, self._color, self._color, 1)
					UnityTweens.UITweenFadeTo.StartTween(go, 0, sTime, UnityTweens.EaseType.easeOutSine)
				end
			else
				local sTime = checknumber(cfgs[2])

				if sTime == 0 then
					sTime = 0.5
				end

				self:_setColorRGBA(go, self._color, self._color, self._color, 1)

				local px, py, pz = self:_getOffScreenPosition(go)
				local startPos = go.transform.position

				UnityTweens.UITweenShake.StopTween(go)
				UnityTweens.UITweenFadeTo.StopTween(go)
				UnityTweens.TweenScale.StopTween(go)
				UnityTweens.TweenPosition.StopTween(go)
				UnityTweens.TweenPosition.StartTween(go, startPos, Vector3.New(px, py, pz), sTime, UnityTweens.EaseType.easeOutSine, 0, UnityTweens.CoordSpace.World)
			end
		end
	end
end

function StoryViewModel:_startPerform(go, perform, params)
	UnityTweens.UITweenShake.StopTween(go)
	UnityTweens.TweenScale.StopTween(go)

	if perform == StoryConst.Story_Shake then
		if self._isTransitionIn then
			return
		end

		local shake = UnityTweens.UITweenShake:StartTween(Vector3.New(params[1] or 1, params[2] or 1, 0), params[3] or 0.01, params[4] or 1)

		shake.loopType = params[5] and UnityTweens.LoopType.loop or UnityTweens.LoopType.none
	elseif perform == StoryConst.Story_ScaneIn or perform == StoryConst.Story_ScaneOut then
		local scaleFrom = self._currStoryConfig.scale * params[1]
		local scaleTo = self._currStoryConfig.scale * params[2]

		UnityTweens.TweenScale:StartTween(Vector3.New(scaleFrom, scaleFrom, scaleFrom), Vector3.New(scaleTo, scaleTo, scaleTo), params[3] or 0.5)
	elseif perform == StoryConst.Story_Move then
		local posFrom = Vector3.New(params[1], params[2], params[3])
		local var_26_2 = Vector3.New(params[4], params[5], params[6])

		UnityTweens.TweenPosition:StartTween(posFrom, posTo, params[7] or 0.5)
	end
end

function StoryViewModel:_setColorRGB(go, r, g, b)
	if go == self._bigImgGo then
		UGUIToolHelper.SetColorRGB(self._bigImgGraphic, r, g, b)
	else
		GoUtil.SetColorRGB(go, colorId, r, g, b)
	end
end

function StoryViewModel:_setColorRGBA(go, r, g, b, a)
	if go == self._bigImgGo then
		UGUIToolHelper.SetColorRGBA(self._bigImgGraphic, r, g, b, a)
	else
		GoUtil.SetColorRGBA(go, colorId, r, g, b, a)
	end
end

function StoryViewModel:_getOffScreenPosition(go)
	local dir = 0

	dir = self._direction == StoryConst.DirLeft and 0 or self._direction == StoryConst.DirRight and 1 or 2

	local px, py, pz = Framework.TransformUtil.GetPos(go.transform, nil, nil, nil)
	local var_29_0, var_29_1, var_29_2 = GoUtil.GetOffScreenPosition(self._camera, go, dir, nil, nil, nil)

	return var_29_0, var_29_1, var_29_2
end

return StoryViewModel
