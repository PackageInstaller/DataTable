-- chunkname: @modules/logic/season/view1_2/Season1_2MainScene.lua

module("modules.logic.season.view1_2.Season1_2MainScene", package.seeall)

local Season1_2MainScene = class("Season1_2MainScene", BaseView)

function Season1_2MainScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")
	self._focusSetting = {
		{
			x = -4.56,
			y = -1.32
		},
		{
			x = 0.95,
			y = 0.98
		},
		{
			x = 0.61,
			y = -1.46
		},
		{
			x = 3.4,
			y = -0.78
		},
		{
			x = -2.05,
			y = -2.6
		},
		{
			x = 1.09,
			y = -2.48
		}
	}
	self._stageSetting = {
		{
			1
		},
		{
			1,
			2
		},
		{
			2,
			3
		},
		{
			2,
			3,
			4
		},
		{
			2,
			3,
			4,
			5
		},
		{
			2,
			3,
			4,
			5,
			6
		}
	}
	self._listenerViews = {
		[ViewName.Season1_2MarketView] = 1,
		[ViewName.Season1_2SpecialMarketView] = 1
	}
	self.isFirst = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2MainScene:addEvents()
	return
end

function Season1_2MainScene:removeEvents()
	return
end

Season1_2MainScene.SeasonCameraOrthographicSize = 3.85
Season1_2MainScene.SeasonCameraLocalPos = Vector2(-0.65, -0.28)
Season1_2MainScene.FocusCameraOrthographicSize = 2
Season1_2MainScene.FocusTime = 0.45
Season1_2MainScene.CancelFocusTime = 0.45

function Season1_2MainScene:_editableInitView()
	self._camera = CameraMgr.instance:getMainCamera()

	self:_initSceneRootNode()
	self:_loadScene()
	self:_addEvents()
end

function Season1_2MainScene:_addEvents()
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.ChangeCameraSize, self._onChangeCamera, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SelectRetail, self.focusRole, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
end

function Season1_2MainScene:_removeEvents()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.ChangeCameraSize, self._onChangeCamera, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SelectRetail, self.focusRole, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
end

function Season1_2MainScene:initCamera(isRetail)
	transformhelper.setLocalRotation(self._camera.transform, 0, 0, 0)

	if not self._tweenId then
		self._camera.orthographicSize = Season1_2MainScene.SeasonCameraOrthographicSize
		self._camera.orthographic = true

		transformhelper.setLocalPos(self._camera.transform, Season1_2MainScene.SeasonCameraLocalPos.x, Season1_2MainScene.SeasonCameraLocalPos.y, 0)
	end

	if isRetail == nil then
		isRetail = false
	end

	self:_showScenes(isRetail)
end

function Season1_2MainScene:resetCamera()
	if not self._initCamaraParam then
		return
	end

	self._initCamaraParam = nil

	self:doAudio(false)
end

function Season1_2MainScene:_onChangeCamera(isRetail)
	self:initCamera(isRetail)
end

function Season1_2MainScene:_showScenes(isRetail)
	if not self._sceneGo then
		return
	end

	if self._isShowRetail == isRetail then
		return
	end

	self._isShowRetail = isRetail

	local animationName, normalizedTime

	if self.isFirst then
		animationName = "open"
	end

	if self._isShowRetail then
		animationName = "go1"

		if self.isFirst then
			normalizedTime = 1
		end

		self:_enterRetail()
	else
		if not self.isFirst then
			animationName = "go2"
		end

		self:_enterMarket()
	end

	for k, v in pairs(self._listenerViews) do
		if ViewMgr.instance:isOpen(k) then
			normalizedTime = 1

			break
		end
	end

	if self._sceneAnim and animationName then
		if normalizedTime then
			self._sceneAnim:Play(animationName, 0, normalizedTime)
		else
			self._sceneAnim:Play(animationName)
		end
	end

	self:doAudio(true)

	self.isFirst = false
end

function Season1_2MainScene:_enterRetail()
	self:_refreshRoles()
end

function Season1_2MainScene:_onRefreshRetail()
	self:_refreshRoles(true)
end

function Season1_2MainScene:_refreshRoles(isOpen)
	TaskDispatcher.cancelTask(self._refreshRoles, self)

	if not self._isShowRetail then
		gohelper.setActive(self._goroles, false)

		return
	end

	gohelper.setActive(self._goroles, true)

	local retails = Activity104Model.instance:getAct104Retails()
	local noretail = retails == nil or #retails == 0
	local lastRetails = Activity104Model.instance:getLastRetails()

	if noretail and lastRetails then
		self:_battleSuccessRefreshRoles(lastRetails)

		return
	end

	self:_normalRefreshRoles(retails, noretail, isOpen)
end

function Season1_2MainScene:_battleSuccessRefreshRoles(retails)
	for i = 1, 6 do
		gohelper.setActive(self["_gorole" .. i], false)
	end

	for _, v in pairs(retails) do
		local index = v.position

		gohelper.setActive(self["_gorole" .. index], true)
		self["_aniRole" .. index]:Play(UIAnimationName.Idle)
	end

	self.delayRetails = retails

	TaskDispatcher.runDelay(self._onDelayRefreshRoles, self, 1)
end

function Season1_2MainScene:_onDelayRefreshRoles()
	for _, v in pairs(self.delayRetails) do
		local index = v.position

		gohelper.setActive(self["_gorole" .. index], true)
		self["_aniRole" .. index]:Play(UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(self._refreshRoles, self, 0.33)
end

function Season1_2MainScene:_normalRefreshRoles(retails, noretail, isOpen)
	local t = {}

	for i = 1, 6 do
		t[i] = false
	end

	for _, v in pairs(retails) do
		local index = v.position
		local gorole = self["_gorole" .. index]
		local aniRole = self["_aniRole" .. index]

		t[index] = nil

		gohelper.setActive(gorole, true)

		if aniRole then
			if isOpen then
				aniRole:Play(UIAnimationName.Open, 0, 0)
			else
				aniRole:Play(UIAnimationName.Idle, 0, 0)
			end
		end
	end

	for index, v in pairs(t) do
		local gorole = self["_gorole" .. index]

		if gorole then
			local aniRole = self["_aniRole" .. index]

			if isOpen and gorole.activeInHierarchy then
				if aniRole then
					aniRole:Play(UIAnimationName.Close, 0, 0)
				end
			else
				gohelper.setActive(gorole, false)
			end
		end
	end

	if noretail then
		gohelper.setActive(self._gospotlight, true)

		if self._animspotlight then
			self._animspotlight:Play(UIAnimationName.Open, 0, 0)
		end

		return
	end

	if isOpen and self._gospotlight and self._gospotlight.activeInHierarchy then
		self._animspotlight:Play(UIAnimationName.Close, 0, 0)

		return
	end

	gohelper.setActive(self._gospotlight, false)
end

function Season1_2MainScene:_enterMarket()
	gohelper.setActive(self._gospotlight, false)
	self:_refreshRoles()
end

function Season1_2MainScene:_initSceneRootNode()
	local mainTrans = self._camera.transform.parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Season1_2MainScene")

	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function Season1_2MainScene:_loadScene()
	self._mapLoader = MultiAbLoader.New()
	self._scenePath = "scenes/m_s15_sj_yfyt_1_2/scene_prefab/m_s15_sj_yfyt_a.prefab"

	self._mapLoader:addPath(self._scenePath)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function Season1_2MainScene:_loadSceneFinish()
	local mainPrefab = self._mapLoader:getAssetItem(self._scenePath):GetResource(self._scenePath)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot)
	self._goroles = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/juese")
	self._gorole1 = gohelper.findChild(self._goroles, "jiexika_a_1")
	self._gorole2 = gohelper.findChild(self._goroles, "yaxian_a_2")
	self._gorole3 = gohelper.findChild(self._goroles, "kongbutong_3")
	self._gorole4 = gohelper.findChild(self._goroles, "jiexika_b_4")
	self._gorole5 = gohelper.findChild(self._goroles, "jinmier_5")
	self._gorole6 = gohelper.findChild(self._goroles, "yaxian_b_6")

	for i = 1, 6 do
		local gorole = self[string.format("_gorole%s", i)]

		if gorole then
			self[string.format("_aniRole%s", i)] = gorole:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	self._gosection1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section01")
	self._gosection2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section02")
	self._gosection3 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section03")
	self._gosection3part1 = gohelper.findChild(self._gosection3, "m_s15_sj_yfyt_shu_a")
	self._gosection3part2 = gohelper.findChild(self._gosection3, "m_s15_sj_yfyt_lzhizhu_b")
	self._gosection4 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section04")
	self._gosection5 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section05")
	self._gosection6 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section06")
	self._gospotlight = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/scanlight")

	if self._gospotlight then
		self._animspotlight = self._gospotlight:GetComponent(typeof(UnityEngine.Animator))
	end

	self._sceneAnim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	self._goMask = gohelper.findChild(self._sceneGo, "root/BackGround/#mask")

	if self._goMask then
		self._aniMask = self._goMask:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(self._goroles, false)
	gohelper.setActive(self._gospotlight, false)
	self:_refreshView()
	self:_initLevelupObjs()
	MainCameraMgr.instance:addView(ViewName.Season1_2MainView, self.autoInitMainViewCamera, self.resetCamera, self)
end

function Season1_2MainScene:autoInitMainViewCamera()
	self:initCamera(false)
end

function Season1_2MainScene:_initLevelupObjs()
	self._levelupObjs = {}

	for i = 1, 6 do
		local gosection = self:_getGoSection(i)

		if gosection then
			local list = self._levelupObjs[i]

			if not list then
				list = {}
				self._levelupObjs[i] = list
			end

			local obj = gohelper.findChild(gosection, "leveup")

			if obj then
				table.insert(list, obj)
				gohelper.setActive(obj, false)
			end
		end
	end

	if self._waitShowLevelStage then
		self:showLevelObjs(self._waitShowLevelStage)

		self._waitShowLevelStage = nil
	else
		self:_hideLevelObjs(true)
	end
end

function Season1_2MainScene:showLevelObjs(stage)
	if not self._levelupObjs then
		self._waitShowLevelStage = stage

		return
	end

	self._sceneAnim:Play(UIAnimationName.Open, 0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_map_upgrade)
	self:_hideLevelObjs(true)
	TaskDispatcher.runDelay(self._hideLevelObjs, self, 1.8)

	local curSetting = self:_getStageSetting(stage)
	local lastSetting = self:_getStageSetting(stage - 1)
	local dict = {}

	if lastSetting then
		for _, v in pairs(lastSetting) do
			dict[v] = true
		end
	end

	if curSetting then
		for _, v in pairs(curSetting) do
			if not dict[v] then
				local objs = self._levelupObjs[v]

				if objs then
					for _, obj in pairs(objs) do
						gohelper.setActive(obj, true)
					end
				end
			end
		end
	end

	local container = ViewMgr.instance:getContainer(ViewName.Season1_2MainView)

	if container then
		container:stopUI(false)
	end
end

function Season1_2MainScene:_hideLevelObjs(isDefault)
	TaskDispatcher.cancelTask(self._hideLevelObjs, self)

	if self._levelupObjs then
		for _, objs in pairs(self._levelupObjs) do
			for _, obj in pairs(objs) do
				gohelper.setActive(obj, false)
			end
		end
	end

	if isDefault then
		return
	end

	local container = ViewMgr.instance:getContainer(ViewName.Season1_2MainView)

	if container then
		container:playUI(true)
	end
end

function Season1_2MainScene:_showStage()
	local stageId = Activity104Model.instance:getAct104CurStage()
	local setting = self:_getStageSetting(stageId)

	gohelper.setActive(self._gosection3part2, stageId < 5)

	for i = 1, 6 do
		self:_setGoSectionActive(i, false)
	end

	if setting then
		for k, v in pairs(setting) do
			self:_setGoSectionActive(v, true)
		end
	end
end

function Season1_2MainScene:_getStageSetting(stageId)
	return self._stageSetting[stageId] or self._stageSetting[6]
end

function Season1_2MainScene:_setGoSectionActive(index, active)
	gohelper.setActive(self:_getGoSection(index), active)
end

function Season1_2MainScene:_getGoSection(index)
	return self["_gosection" .. index]
end

function Season1_2MainScene:onUpdateParam()
	self:_refreshView()
end

function Season1_2MainScene:onOpen()
	return
end

function Season1_2MainScene:_refreshView()
	self:_showStage()
end

function Season1_2MainScene:focusRole(index)
	if not index then
		self:cancelFocus()

		return
	end

	self:killFocusTween()

	local setting = self._focusSetting[index]

	if not setting then
		return
	end

	local time = Season1_2MainScene.FocusTime

	self._camera.orthographic = true
	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._camera.transform, setting.x, setting.y, 0, time, self.onMoveCompleted, self, nil, EaseType.OutCubic)
	self._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(Season1_2MainScene.SeasonCameraOrthographicSize, Season1_2MainScene.FocusCameraOrthographicSize, time, self._onSizeUpdate, nil, self, nil, EaseType.OutCubic)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Close)
	end
end

function Season1_2MainScene:cancelFocus()
	self:killFocusTween()

	local time = Season1_2MainScene.CancelFocusTime

	self._camera.orthographic = true
	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._camera.transform, Season1_2MainScene.SeasonCameraLocalPos.x, Season1_2MainScene.SeasonCameraLocalPos.y, 0, time, self._onMoveCompleted, self, nil, EaseType.OutCubic)
	self._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(Season1_2MainScene.FocusCameraOrthographicSize, Season1_2MainScene.SeasonCameraOrthographicSize, time, self._onSizeUpdate, nil, self, nil, EaseType.OutCubic)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Open)
	end
end

function Season1_2MainScene:_onMoveCompleted()
	self:killFocusTween()
end

function Season1_2MainScene:_onSizeUpdate(val)
	self._camera.orthographicSize = val
end

function Season1_2MainScene:_onOpenFullViewFinish(viewName)
	self._listenerFullViews = self._listenerFullViews or {
		[ViewName.Season1_2MainView] = 1,
		[ViewName.Season1_2RetailView] = 1
	}

	if not self._listenerFullViews[viewName] then
		self:doAudio(false)
	end
end

function Season1_2MainScene:_onOpenViewFinish(viewName)
	if not self._listenerViews[viewName] then
		return
	end

	gohelper.setActive(self._goMask, false)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Close)
	end
end

function Season1_2MainScene:_onCloseViewFinish(viewName)
	if not self._listenerViews[viewName] then
		return
	end

	gohelper.setActive(self._goMask, true)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Idle)
	end
end

function Season1_2MainScene:onClose()
	self:_removeEvents()
end

function Season1_2MainScene:killFocusTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenSizeId then
		ZProj.TweenHelper.KillById(self._tweenSizeId)

		self._tweenSizeId = nil
	end
end

function Season1_2MainScene:doAudio(play)
	if self.isAudioPlay == play then
		return
	end

	self.isAudioPlay = play

	if play then
		AudioMgr.instance:trigger(AudioEnum.UI.play_activity_seasonmainamb_1_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function Season1_2MainScene:onDestroyView()
	self:killFocusTween()
	TaskDispatcher.cancelTask(self._refreshRoles, self)
	TaskDispatcher.cancelTask(self._hideLevelObjs, self)
	TaskDispatcher.cancelTask(self._onDelayRefreshRoles, self)
	gohelper.destroy(self._sceneRoot)

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end
end

return Season1_2MainScene
