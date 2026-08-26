-- chunkname: @modules/logic/postprocessing/PostProcessingMgr.lua

module("modules.logic.postprocessing.PostProcessingMgr", package.seeall)

local PostProcessingMgr = class("PostProcessingMgr")

PostProcessingMgr.PPEffectMaskType = typeof(UrpCustom.PPEffectMask)
PostProcessingMgr.PPCustomCamDataType = typeof(UrpCustom.CustomCameraData)
PostProcessingMgr.PPVolumeType = typeof(UnityEngine.Rendering.Volume)
PostProcessingMgr.PPVolumeWrapType = typeof(UrpCustom.PPVolumeWrap)
PostProcessingMgr.MainAllProfilePath = "ppassets/profiles/main_profile_all.asset"
PostProcessingMgr.MainHighProfilePath = "ppassets/profiles/main_profile_high.asset"
PostProcessingMgr.MainMiddleProfilePath = "ppassets/profiles/main_profile_middle.asset"
PostProcessingMgr.MainLowProfilePath = "ppassets/profiles/main_profile_low.asset"
PostProcessingMgr.MainLowBrightnessProfilePath = "ppassets/profiles/main_profile_low_brightness.asset"
PostProcessingMgr.CaptureResPath = "ppassets/capture.prefab"
PostProcessingMgr.DesamplingRate = {
	x8 = 8,
	x4 = 4,
	x1 = 1,
	x2 = 2
}
PostProcessingMgr.BlurMode = {
	FastBlur = 0,
	DetailBlur = 2,
	None = 3,
	MediumBlur = 1
}

function PostProcessingMgr:init(mainCameraGo, unitCameraGo, uiCameraGo)
	self._mainCameraGo = mainCameraGo
	self._mainCamera = mainCameraGo:GetComponent("Camera")
	self._mainCamData = mainCameraGo:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	self._unitCameraGo = unitCameraGo
	self._unitCamera = unitCameraGo:GetComponent("Camera")
	self._uiCameraGo = uiCameraGo
	self._uiCamera = uiCameraGo:GetComponent("Camera")
	self.useMirrorEffect = self._mainCamData.useMirrorEffect
	self._unitCamData = self._unitCameraGo:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	self._unitPPVolume = gohelper.findChildComponent(self._unitCameraGo, "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	self._highProfile = ConstAbCache.instance:getRes(PostProcessingMgr.MainHighProfilePath)
	self._middleProfile = ConstAbCache.instance:getRes(PostProcessingMgr.MainMiddleProfilePath)
	self._lowProfile = ConstAbCache.instance:getRes(PostProcessingMgr.MainLowProfilePath)
	self._lowBrightnessProfile = ConstAbCache.instance:getRes(PostProcessingMgr.MainLowBrightnessProfilePath)
	self._uiCamData = self._uiCameraGo:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	self._uiPPVolume = gohelper.findChildComponent(self._uiCameraGo, "PPUIVolume", PostProcessingMgr.PPVolumeWrapType)

	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._reopenWhileOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenFinishView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)

	local go = gohelper.clone(ConstAbCache.instance:getRes(PostProcessingMgr.CaptureResPath), gohelper.find("UIRoot/POPUP_TOP"), "CaptureView")

	self._capture = go:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	self._captureView = go

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterScene, self)

	self._closeRefreshViewBlurDict = {}
	self._viewNameBlurDict = {}
	self._fullViewCanBlur = {
		[ViewName.DungeonMapView] = true
	}

	self:initUIFourthLayer()
end

function PostProcessingMgr:initUIFourthLayer()
	local fourGo = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPFour")

	if fourGo then
		return
	end

	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	local goFour = gohelper.cloneInPlace(go, "POPUPFour")

	gohelper.setSiblingAfter(goFour, go)

	local canvas = goFour:GetComponent("Canvas")

	canvas.sortingOrder = 9

	gohelper.setLayer(goFour, UnityLayer.UIFour)

	local layermask = LayerMask.GetMask("UIFour")
	local uiCamera = CameraMgr.instance:getUICamera()

	PostProcessingMgr.setCameraLayerInt(uiCamera, layermask, true)
end

function PostProcessingMgr:getCaptureView()
	return self._captureView
end

function PostProcessingMgr:setViewBlur(viewName, blur)
	self._viewNameBlurDict[viewName] = blur

	self:_refreshViewBlur()
end

function PostProcessingMgr:_getViewBlur(viewName)
	if self._viewNameBlurDict[viewName] then
		return self._viewNameBlurDict[viewName]
	end

	local viewSetting = ViewMgr.instance:getSetting(viewName)

	return viewSetting.bgBlur
end

function PostProcessingMgr:_reopenWhileOpen(viewName)
	self:_refreshPopUpBlur(viewName, true, true, ViewEvent.OnOpenView)
	self:_refreshViewBlur(ViewEvent.ReOpenWhileOpen)
	self:_adjustMask(viewName)
end

function PostProcessingMgr:_onOpenView(viewName)
	if viewName == "LoginView" or viewName == "SimulateLoginView" then
		self:setUnitActive(false)
	else
		self:_refreshPopUpBlur(viewName, true, false, ViewEvent.OnOpenView)
		self:_refreshViewBlur(ViewEvent.OnOpenView)
		self:_adjustMask(viewName)
	end
end

function PostProcessingMgr:_onScreenResize()
	self:_refreshViewBlur()
end

function PostProcessingMgr:_adjustMask(viewName, checkModalOpenFinish)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewNameList, 1, -1 do
		local oneViewName = openViewNameList[i]

		if ViewMgr.instance:isModal(oneViewName) then
			if not checkModalOpenFinish or ViewMgr.instance:isOpenFinish(oneViewName) then
				ViewModalMaskMgr.instance:_adjustMask(oneViewName)

				return
			end
		elseif ViewMgr.instance:isFull(oneViewName) then
			return
		end
	end
end

function PostProcessingMgr:_onOpenFinishView(viewName)
	if viewName == ViewName.MessageBoxView and StoryController.instance._curStoryId == 100717 then
		return
	end

	if viewName == "LoginView" or viewName == "SimulateLoginView" then
		self:setUnitActive(false)
	else
		self:_refreshFourthLayer(false)
		self:_refreshViewBlur(ViewEvent.OnOpenViewFinish)
	end
end

function PostProcessingMgr:_onCloseView(viewName)
	if BlurEnum.IgnoreCloseView[viewName] then
		return
	end

	self:_refreshPopUpBlur(viewName, false, false, ViewEvent.OnCloseView)
	self:_closeRefreshViewBlur(ViewEvent.OnCloseView, viewName)
	self:_adjustMask(viewName, true)
end

function PostProcessingMgr:_onCloseViewFinish(viewName)
	self:_refreshPopUpBlur(viewName, false, false, ViewEvent.OnCloseViewFinish)
	self:_closeRefreshViewBlur(ViewEvent.OnCloseViewFinish, viewName)
	self:_adjustMask(viewName, true)
end

function PostProcessingMgr:setCloseSkipRefreshBlur(viewName, value)
	self._closeRefreshViewBlurDict[viewName] = value
end

function PostProcessingMgr:forceRefreshCloseBlur()
	self:_refreshViewBlur(ViewEvent.OnCloseViewFinish)
end

function PostProcessingMgr:_closeRefreshViewBlur(viewEvent, viewName)
	if self._closeRefreshViewBlurDict[viewName] then
		if viewEvent == ViewEvent.OnCloseViewFinish then
			self._closeRefreshViewBlurDict[viewName] = nil
		end

		return
	end

	self:_refreshViewBlur(viewEvent)
end

function PostProcessingMgr:_refreshViewBlur(viewEvent)
	local blurType, viewName, blurParam, hideUI = self:_judgeBlur()

	self:setUIBlurActive(blurType or 0, blurParam, hideUI, viewEvent)
end

function PostProcessingMgr:_refreshFreezeBlur()
	local blurType, viewName, blurParam, hideUI = self:_judgeBlur()

	self:setUIBlurActive(2, blurParam, hideUI)
end

function PostProcessingMgr:_judgeBlur()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #viewNameList, 1, -1 do
		local viewName = viewNameList[i]
		local viewSetting = ViewMgr.instance:getSetting(viewName)

		if viewSetting.layer == UILayerName.PopUp then
			return false
		end

		local bgBlur = self:_getViewBlur(viewName)

		if bgBlur and bgBlur > 0 then
			local blurParam = {
				blurMode = viewSetting.blurMode,
				blurFactor = viewSetting.blurFactor,
				desampleRate = viewSetting.desampleRate,
				reduceRate = viewSetting.reduceRate,
				blurIterations = viewSetting.blurIterations
			}

			return bgBlur, viewName, blurParam, viewSetting.hideUI
		end

		if viewSetting.viewType == ViewType.Full then
			return false
		end
	end

	return false
end

function PostProcessingMgr:_refreshPopUpBlur(viewName, isOpen, isReOpen, viewEvent)
	if viewEvent == ViewEvent.OnCloseView then
		self:_resetCloseView(viewName)
	end

	self:_refreshFourthLayer(true)

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local blur, blurViewName = self:_judgeBlur()

	if blur then
		self:_refreshPopUpBlurIsBlur(viewName, isOpen, blurViewName)
	else
		self:_refreshPopUpBlurNotBlur(viewName, isOpen)
	end

	if viewEvent == ViewEvent.OnCloseViewFinish then
		self:_refreshFourthLayer(false)
	end
end

function PostProcessingMgr:_resetCloseView(closeViewName)
	local popUpFourGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPFour")
	local fourTransform = popUpFourGO.transform
	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local oneViewContainer = ViewMgr.instance:getContainer(closeViewName)
	local oneViewGO = oneViewContainer and oneViewContainer.viewGO

	if oneViewGO then
		if not oneViewGO.transform.parent then
			local oneViewParentTr

			if oneViewParentTr == fourTransform then
				gohelper.addChild(popUpTopGO, oneViewGO)
				self:_setChildCanvasLayer(oneViewGO, UnityLayer.UITop, false)
			end
		end
	end
end

function PostProcessingMgr:_refreshFourthLayer(reset)
	local popUpFourGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPFour")
	local fourTransform = popUpFourGO.transform
	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")

	if reset then
		TaskDispatcher.cancelTask(self._changeTopCaptureView, self)

		local viewMask = gohelper.findChild(popUpFourGO, "ViewMask")

		if viewMask then
			gohelper.addChild(popUpTopGO, viewMask)
			gohelper.setAsFirstSibling(viewMask)
		end

		local captureView = gohelper.findChild(popUpFourGO, "CaptureView")

		if captureView then
			gohelper.addChild(popUpTopGO, captureView)
			gohelper.setAsFirstSibling(captureView)
		end
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local len = #viewNameList

	for i = 1, len do
		local one = viewNameList[i]
		local oneViewContainer = ViewMgr.instance:getContainer(one)
		local oneViewGO = oneViewContainer and oneViewContainer.viewGO

		if oneViewGO then
			if not oneViewGO.transform.parent then
				local oneViewParentTr

				if reset then
					self._autoBloomActive = false

					if oneViewParentTr == fourTransform then
						gohelper.addChild(popUpTopGO, oneViewGO)
						self:_setChildCanvasLayer(oneViewGO, UnityLayer.UITop, false)
					end
				else
					local bloomViewType = CharacterVoiceEnum.NormalBloomView[one]

					if i == len and bloomViewType then
						if bloomViewType == CharacterVoiceEnum.NormalBloomViewType.Capture then
							self._delayChangeViewGo = oneViewGO

							TaskDispatcher.cancelTask(self._changeTopCaptureView, self)
							TaskDispatcher.runDelay(self._changeTopCaptureView, self, 0.1)
						elseif oneViewGO then
							gohelper.addChild(popUpFourGO, oneViewGO)
							self:_setChildCanvasLayer(oneViewGO, UnityLayer.UIFour, false)
						end

						self._autoBloomActive = bloomViewType == CharacterVoiceEnum.NormalBloomViewType.CustomOpen and self._customOpenBloom or true
					end
				end
			end
		end
	end
end

function PostProcessingMgr:_changeTopCaptureView()
	local popUpFourGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPFour")
	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local viewMask = gohelper.findChild(popUpTopGO, "ViewMask")

	if viewMask then
		gohelper.addChild(popUpFourGO, viewMask)
		gohelper.setAsFirstSibling(viewMask)
	end

	local captureView = gohelper.findChild(popUpTopGO, "CaptureView")

	if captureView then
		gohelper.addChild(popUpFourGO, captureView)
		gohelper.setAsFirstSibling(captureView)
	end

	if self._delayChangeViewGo then
		local oneViewGO = self._delayChangeViewGo

		self._delayChangeViewGo = nil

		gohelper.addChild(popUpFourGO, oneViewGO)
		self:_setChildCanvasLayer(oneViewGO, UnityLayer.UIFour, false)
	end
end

function PostProcessingMgr:_refreshPopUpBlurIsBlur(viewName, isOpen, blurViewName)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local popUpBlurGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local index = 1
	local lastViewGO

	for i = 1, #viewNameList do
		local one = viewNameList[i]
		local oneViewSetting = ViewMgr.instance:getSetting(one)

		if oneViewSetting.layer == "POPUP_TOP" then
			local parentGO = (one == blurViewName or (one == blurViewName or nil) and true) and popUpTopGO or popUpBlurGO
			local oneViewGO = ViewMgr.instance:getContainer(one).viewGO

			if oneViewGO then
				if not oneViewGO.transform.parent then
					local oneViewParentTr

					if oneViewParentTr == popUpTopGO.transform or oneViewParentTr == popUpBlurGO.transform then
						if self:_isKeepTop(i, viewNameList, blurViewName) then
							parentGO = popUpTopGO
						end

						gohelper.addChild(parentGO, oneViewGO)
						self:_setChildCanvasLayer(oneViewGO, (parentGO == popUpTopGO or nil) and (UnityLayer.UITop or UnityLayer.UIThird), false)

						if parentGO == popUpTopGO then
							lastViewGO = oneViewGO

							gohelper.setSibling(oneViewGO, index)

							index = index + 1
						else
							gohelper.setAsLastSibling(oneViewGO)
						end
					end
				end
			end
		end
	end

	if lastViewGO then
		gohelper.setAsLastSibling(lastViewGO)
	end
end

function PostProcessingMgr:_isKeepTop(index, viewNameList, blurViewName)
	local viewName = viewNameList[index]
	local overrideViewName = viewNameList[index + 1]
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if viewContainer and (string.find(viewName, "HeroGroupFightView") or isTypeOf(viewContainer, HeroGroupFightViewContainer)) and overrideViewName == ViewName.HeroGroupCareerTipView then
		return true
	end

	if viewName == ViewName.RoomInitBuildingView and overrideViewName == ViewName.RoomFormulaView and blurViewName == ViewName.RoomFormulaView then
		return true
	end

	if viewName == ViewName.AssassinStatsView and (overrideViewName == ViewName.CharacterTipView and blurViewName == ViewName.CharacterTipView or overrideViewName == ViewName.SkillTipView and blurViewName == ViewName.SkillTipView) then
		return true
	end

	return false
end

function PostProcessingMgr:_refreshPopUpBlurNotBlur(viewName, isOpen)
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local popUpBlurGO = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local index = 1
	local lastViewGO

	for i = 1, #viewNameList do
		local one = viewNameList[i]
		local oneViewSetting = ViewMgr.instance:getSetting(one)

		if oneViewSetting.layer == "POPUP_TOP" then
			local oneViewGO = ViewMgr.instance:getContainer(one).viewGO

			if oneViewGO then
				if not oneViewGO.transform.parent then
					local oneViewParentTr

					if oneViewParentTr == popUpTopGO.transform or oneViewParentTr == popUpBlurGO.transform then
						gohelper.addChild(popUpTopGO, oneViewGO)
						self:_setChildCanvasLayer(oneViewGO, UnityLayer.UITop, false)

						lastViewGO = oneViewGO

						gohelper.setSibling(oneViewGO, index)

						index = index + 1
					end
				end
			end
		end
	end

	if lastViewGO and isOpen then
		gohelper.setAsLastSibling(lastViewGO)
	end

	PostProcessingMgr.instance:dispatchEvent(PostProcessingEvent.onRefreshPopUpBlurNotBlur, isOpen)
end

function PostProcessingMgr:_setChildCanvasLayer(parentGO, layer, recursive)
	if not parentGO then
		return
	end

	local childCanvasList = parentGO:GetComponentsInChildren(typeof(UnityEngine.Canvas), true)

	if childCanvasList then
		local iter = childCanvasList:GetEnumerator()

		while iter:MoveNext() do
			if not LuaUtil.strEndswith(iter.Current.gameObject.name, "_uicanvas") then
				gohelper.setLayer(iter.Current.gameObject, layer, recursive)
			end
		end
	end
end

function PostProcessingMgr:_isBlurView(viewName)
	local viewSetting = ViewMgr.instance:getSetting(viewName)

	if viewSetting and viewSetting.bgBlur and viewSetting.bgBlur > 0 then
		return true
	end

	return false
end

function PostProcessingMgr:_hasBlurViewOpened()
	local list = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(list) do
		if self:_isBlurView(viewName) then
			return true
		end
	end

	return false
end

function PostProcessingMgr:setUIActive(active)
	self._uiCamData.usePostProcess = active
end

function PostProcessingMgr:setUnitActive(active)
	self._unitCamData.usePostProcess = active
end

function PostProcessingMgr:setUIBlur(enable, keep, blurParam)
	if blurParam then
		if not blurParam.blurMode then
			local blurMode = PostProcessingMgr.BlurMode.MediumBlur

			if blurParam then
				if not blurParam.blurFactor then
					local blurFactor = 0.4

					if blurParam then
						if not blurParam.desampleRate then
							local desampleRate = PostProcessingMgr.DesamplingRate.x8

							if blurParam then
								if not blurParam.reduceRate then
									local reduceRate = PostProcessingMgr.DesamplingRate.x4

									if blurParam then
										if not blurParam.blurIterations then
											local blurIterations = 3
											local sceneType = GameSceneMgr.instance:getCurSceneType()

											if enable then
												self:setBlurMode(blurMode)
												self:setDesamplingRate((keep or nil) and (PostProcessingMgr.DesamplingRate.x1 or PostProcessingMgr.DesamplingRate.x8))
												self:setDesamplingRate(desampleRate)
												self:setBlurIterations(blurIterations)
												self:setReduceRate(reduceRate)
												self:setBlurFactor(blurFactor)
												self._capture:SetKeepCapture(keep)

												if not keep then
													self:setBlurWeight(1)
													self._capture:Capture()
												end
											end

											self._capture.enabled = enable
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function PostProcessingMgr:IsGaussianFreezeStatus()
	return self._capture.enabled and not self._capture.keepToScreen
end

function PostProcessingMgr:setBlurMode(blurMode)
	self._capture:SetBlurMode(blurMode)
end

function PostProcessingMgr:setBlurFactor(factor)
	self._capture.blurFactor = math.max(0, math.min(1, factor))
end

function PostProcessingMgr:setBlurWeight(weight)
	if not self:IsGaussianFreezeStatus() then
		self._capture.blurWeight = math.max(0, math.min(1, weight))
	end
end

function PostProcessingMgr:setDesamplingRate(rate)
	self._capture.desamplingRate = rate
end

function PostProcessingMgr:setReduceRate(rate)
	self._capture.reduteRate = rate
end

function PostProcessingMgr:setBlurIterations(blurIterations)
	self._capture.blurIterations = blurIterations
end

function PostProcessingMgr:setUIBloom(active)
	self._uiBloomActive = active
end

function PostProcessingMgr:setCustomOpenBloom(value)
	self._autoBloomActive = value
	self._customOpenBloom = value
end

function PostProcessingMgr:setIgnoreUIBlur(Ignore)
	self._isIgnoreUIBlur = Ignore
end

function PostProcessingMgr:getIgnoreUIBlur()
	return self._isIgnoreUIBlur
end

function PostProcessingMgr:setUIBlurActive(activeType, blurParam, hideUI, viewEvent)
	if self._isIgnoreUIBlur then
		return
	end

	if self._uiCamData and self._unitCamData and self._capture then
		local mainCamera = CameraMgr.instance:getMainCamera()
		local uiCamera = CameraMgr.instance:getUICamera()
		local sceneType = GameSceneMgr.instance:getCurSceneType()
		local noBlur = activeType == false or activeType == 0

		if noBlur then
			if viewEvent ~= ViewEvent.OnCloseView then
				self._uiCamData.usePostProcess = false
			end

			self._unitCamData.usePostProcess = sceneType ~= SceneType.Room

			self:setUIPPValue("bloomActive", false)
			self:setUIPPValue("localMaskActive", false)
			self:setUIPPValue("LocalMaskActive", false)
			self:setFreezeVisble(true)
			self:setUIBlur(false)
		else
			self._uiCamData.usePostProcess = true
			self._unitCamData.usePostProcess = (activeType == 2 or activeType == 4) and sceneType ~= SceneType.Room and sceneType ~= SceneType.PartyGameLobby

			self:setUIPPValue("bloomActive", false)
			self:setUIPPValue("localMaskActive", activeType == 2 or activeType == 4)
			self:setUIPPValue("LocalMaskActive", activeType == 2 or activeType == 4)
			self:setFreezeVisble(true, hideUI)
			self:setUIBlur(true, activeType == 3 or activeType == 4, blurParam)

			if activeType == 1 then
				TaskDispatcher.runDelay(self.setFreezeVisbleBack, self, 0)
			end
		end

		if self._uiBloomActive or self._autoBloomActive then
			self._uiCamData.usePostProcess = true

			self:setUIPPValue("bloomActive", true)
			self:setUIPPValue("localBloomActive", false)
		end
	end
end

function PostProcessingMgr:setFreezeVisbleBack()
	self:setFreezeVisble(false)
end

function PostProcessingMgr:setFreezeVisble(visble, hideUI)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()

	if visble == false then
		if self._capture and not self._capture:isCaptureComplete() then
			visble = true
		end

		if not self:IsGaussianFreezeStatus() then
			visble = true
		end
	end

	self._unitCamera.enabled = visble

	PostProcessingMgr.setCameraLayer(mainCamera, "UI3D", visble)
	PostProcessingMgr.setCameraLayer(mainCamera, "Scene", visble)
	PostProcessingMgr.setCameraLayer(mainCamera, "SceneOpaque", visble)
	PostProcessingMgr.setCameraLayer(uiCamera, "UI", visble and not hideUI)
end

function PostProcessingMgr.setCameraLayer(camera, layer, isRendering)
	local layermask = LayerMask.GetMask(layer)

	PostProcessingMgr.setCameraLayerInt(camera, layermask, isRendering)
end

function PostProcessingMgr.setCameraLayerInt(camera, layermask, isRendering)
	local cullingMask = camera.cullingMask

	cullingMask = isRendering and bit.bor(cullingMask, layermask) or bit.band(cullingMask, bit.bnot(layermask))
	camera.cullingMask = cullingMask
end

function PostProcessingMgr:getUnitPPValue(key)
	if self._unitPPVolume then
		return self._unitPPVolume[key]
	end
end

function PostProcessingMgr:setUnitPPValue(key, value)
	if self._unitPPVolume then
		self._unitPPVolume.refresh = true
		self._unitPPVolume[key] = value
	end
end

function PostProcessingMgr:setLocalBloomColor(color)
	self:setUnitPPValue("localBloomColor", color)
end

function PostProcessingMgr:getLocalBloomColor()
	if self._unitPPVolume then
		return self._unitPPVolume.localBloomColor
	end
end

function PostProcessingMgr:setLocalBloomActive(active)
	self:setUnitPPValue("localBloomActive", active)
end

function PostProcessingMgr:getFlickerSceneFactor()
	if self._unitPPVolume then
		return self._unitPPVolume.flickerSceneFactor
	end
end

function PostProcessingMgr:setFlickerSceneFactor(value)
	self:setUnitPPValue("flickerSceneFactor", value)
end

function PostProcessingMgr:getUIPPValue(key)
	if self._uiPPVolume then
		return self._uiPPVolume[key]
	end
end

function PostProcessingMgr:setUIPPValue(key, value)
	if self._uiPPVolume then
		self._uiPPVolume.refresh = true
		self._uiPPVolume[key] = value

		self._uiPPVolume:UpdateImmediately()
	end
end

function PostProcessingMgr:_onEnterScene(sceneType, sceneId)
	if self:IsGaussianFreezeStatus() then
		self:setUIBlurActive(1)
	end

	self:setPPMaskType(sceneType ~= SceneType.Fight)
end

function PostProcessingMgr:setRenderShadow(renderShadow)
	self._mainCamData.renderShadow = renderShadow
end

function PostProcessingMgr:setLayerCullDistance(layerIndex, distance)
	self._mainCamData:SetCullLayerDistance(layerIndex, distance)
end

function PostProcessingMgr:clearLayerCullDistance()
	self._mainCamData:ClearCullLayer()
end

function PostProcessingMgr:setPPMaskType(useSingleMask)
	self:setUnitPPValue("rolesStoryMaskActive", useSingleMask)
	self:setUnitPPValue("RolesStoryMaskActive", useSingleMask)
	self:setUnitPPValue("rgbSplitStrength", 0)
	self:setUnitPPValue("RgbSplitStrength", 0)
	self:setUnitPPValue("radialBlurLevel", 1)
	self:setUnitPPValue("RadialBlurLevel", 1)
	self:setUnitPPValue("dofFactor", 0)
	self:setUnitPPValue("DofFactor", 0)
end

function PostProcessingMgr:setMainPPLevel(grade)
	self._ppGrade = grade

	local targetProfile = self:getProfile()

	self:setProfile(targetProfile)
end

function PostProcessingMgr:getProfile()
	local grade = self._ppGrade
	local targetProfile = self._highProfile

	if grade == ModuleEnum.Performance.High then
		targetProfile = self._highProfile
	elseif grade == ModuleEnum.Performance.Middle then
		targetProfile = self._middleProfile
	elseif grade == ModuleEnum.Performance.Low then
		local eyeModeActive = EyeProtectionModeMgr.instance:getEyeModeActive()
		local factor = EyeProtectionModeMgr.instance:getFactorValue()

		targetProfile = eyeModeActive and factor < 1 and self._lowBrightnessProfile or self._lowProfile
	end

	return targetProfile
end

function PostProcessingMgr:setProfile(profile)
	self._unitPPVolume:SetProfile(profile)
end

function PostProcessingMgr:getUnitProfile()
	return self._unitPPVolume.PPVolume.sharedProfile
end

function PostProcessingMgr:ClearPPRenderRts()
	return
end

PostProcessingMgr.instance = PostProcessingMgr.New()

LuaEventSystem.addEventMechanism(PostProcessingMgr.instance)

return PostProcessingMgr
