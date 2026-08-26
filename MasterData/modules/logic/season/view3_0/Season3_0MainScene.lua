-- chunkname: @modules/logic/season/view3_0/Season3_0MainScene.lua

module("modules.logic.season.view3_0.Season3_0MainScene", package.seeall)

local Season3_0MainScene = class("Season3_0MainScene", BaseView)

function Season3_0MainScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")
	self._listenerViews = {
		[ViewName.Season3_0MarketView] = 1,
		[ViewName.Season3_0SpecialMarketView] = 1
	}
	self.isFirst = true
	self.seasonCameraLocalPos = Vector3(0, 0, -3.9)
	self.seasonCameraOrthographicSize = 5
	self.focusCameraOrthographicSize = 2
	self.focusTime = 0.45
	self.cancelFocusTime = 0.45
	self.sectionCount = 5
	self._stageSetting = {}

	for i = 1, self.sectionCount do
		self._stageSetting[i] = {
			i
		}
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0MainScene:addEvents()
	return
end

function Season3_0MainScene:removeEvents()
	return
end

function Season3_0MainScene:_editableInitView()
	self._camera = CameraMgr.instance:getMainCamera()

	self:_initSceneRootNode()
	self:_addEvents()
end

function Season3_0MainScene:_addEvents()
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.ChangeCameraSize, self._onChangeCamera, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SelectRetail, self.focusRole, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
end

function Season3_0MainScene:_removeEvents()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.ChangeCameraSize, self._onChangeCamera, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SelectRetail, self.focusRole, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
end

function Season3_0MainScene:initCamera(isRetail)
	transformhelper.setLocalRotation(self._camera.transform, 0, 0, 0)

	if not self._tweenId then
		self._camera.orthographicSize = self.seasonCameraOrthographicSize
		self._camera.orthographic = true

		transformhelper.setLocalPos(self._camera.transform, self.seasonCameraLocalPos.x, self.seasonCameraLocalPos.y, self.seasonCameraLocalPos.z)
	end

	if isRetail == nil then
		isRetail = false
	end

	self:_showScenes(isRetail)
end

function Season3_0MainScene:resetCamera()
	self:doAudio(false)
end

function Season3_0MainScene:_onChangeCamera(isRetail)
	self:initCamera(isRetail)
end

function Season3_0MainScene:_showScenes(isRetail)
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

function Season3_0MainScene:showSceneAnim()
	local animationName, normalizedTime

	if self.isFirst then
		animationName = "open"
	end

	if self._isShowRetail then
		animationName = "go1"

		if self.isFirst then
			normalizedTime = 1
		end
	elseif not self.isFirst then
		animationName = "go2"
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

	self.isFirst = false
end

function Season3_0MainScene:_enterRetail()
	self:_refreshRoles()
end

function Season3_0MainScene:_onRefreshRetail()
	self:_refreshRoles(true)
end

function Season3_0MainScene:_refreshRoles(isOpen)
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

function Season3_0MainScene:_battleSuccessRefreshRoles(retails)
	for i = 1, 6 do
		gohelper.setActive(self["_gorole" .. i], false)
	end

	for _, v in pairs(retails) do
		local index = v.position

		gohelper.setActive(self["_gorole" .. index], true)
		self:_playRoleAni(index, UIAnimationName.Idle)
	end

	self.delayRetails = retails

	TaskDispatcher.runDelay(self._onDelayRefreshRoles, self, 1)
end

function Season3_0MainScene:_onDelayRefreshRoles()
	for _, v in pairs(self.delayRetails) do
		local index = v.position

		gohelper.setActive(self["_gorole" .. index], true)
		self:_playRoleAni(index, UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(self._refreshRoles, self, 0.33)
end

function Season3_0MainScene:_normalRefreshRoles(retails, noretail, isOpen)
	local t = {}

	for i = 1, 6 do
		t[i] = false
	end

	for _, v in pairs(retails) do
		local index = v.position
		local gorole = self["_gorole" .. index]

		t[index] = nil

		gohelper.setActive(gorole, true)

		if isOpen then
			self:_playRoleAni(index, UIAnimationName.Open, 0, 0)
		else
			self:_playRoleAni(index, UIAnimationName.Idle, 0, 0)
		end
	end

	for index, v in pairs(t) do
		local gorole = self["_gorole" .. index]

		if gorole then
			if isOpen and gorole.activeInHierarchy then
				self:_playRoleAni(index, UIAnimationName.Close, 0, 0)
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

function Season3_0MainScene:_enterMarket()
	gohelper.setActive(self._gospotlight, false)
	self:_refreshRoles()
end

function Season3_0MainScene:_initSceneRootNode()
	local mainTrans = self._camera.transform.parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Season3_0MainScene")

	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function Season3_0MainScene:_loadScene()
	if self._sceneGo then
		return
	end

	local setting = self.viewContainer:getSetting()
	local scenePath = setting.otherRes.scene

	self._sceneGo = self.viewContainer:getResInst(scenePath, self._sceneRoot)
	self._diffuseGO = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse")
	self._goroles = UnityEngine.GameObject.New("juese")

	gohelper.addChild(self._diffuseGO, self._goroles)
	transformhelper.setLocalPos(self._goroles.transform, 0, 0, 0)

	for i = 1, 6 do
		local rolePath = setting.otherRes[string.format("role%s", i)]

		if rolePath then
			local goKey = string.format("_gorole%s", i)

			self[goKey] = self.viewContainer:getResInst(rolePath, self._goroles)

			if self[goKey] then
				self[string.format("_aniRole%s", i)] = self[goKey]:GetComponent(typeof(UnityEngine.Animator))
			end
		end
	end

	for i = 1, self.sectionCount do
		local rolePath = setting.otherRes[string.format("section%s", i)]

		if rolePath then
			local goKey = string.format("_gosection%s", i)

			self[goKey] = self.viewContainer:getResInst(rolePath, self._diffuseGO)
		end
	end

	self:_loadSceneFinish()
end

function Season3_0MainScene:_loadSceneFinish()
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
	MainCameraMgr.instance:addView(ViewName.Season3_0MainView, self.autoInitMainViewCamera, self.resetCamera, self)
end

function Season3_0MainScene:autoInitMainViewCamera()
	self:initCamera(false)
end

function Season3_0MainScene:_initLevelupObjs()
	self._levelupObjs = {}

	for i = 1, self.sectionCount do
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

function Season3_0MainScene:showLevelObjs(stage)
	if not self._levelupObjs then
		self._waitShowLevelStage = stage

		return
	end

	if stage > self.sectionCount then
		self.viewContainer:playUI()

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

	self.viewContainer:stopUI()
end

function Season3_0MainScene:_hideLevelObjs(isDefault)
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

	self.viewContainer:playUI()
end

function Season3_0MainScene:_showStage()
	local stageId = Activity104Model.instance:getAct104CurStage()
	local setting = self:_getStageSetting(stageId)

	gohelper.setActive(self._gosection3part2, stageId < self.sectionCount - 1)

	for i = 1, self.sectionCount do
		self:_setGoSectionActive(i, false)
	end

	if setting then
		for k, v in pairs(setting) do
			self:_setGoSectionActive(v, true)
		end
	end
end

function Season3_0MainScene:_getStageSetting(stageId)
	return self._stageSetting[stageId] or self._stageSetting[#self._stageSetting]
end

function Season3_0MainScene:_setGoSectionActive(index, active)
	gohelper.setActive(self:_getGoSection(index), active)
end

function Season3_0MainScene:_getGoSection(index)
	return self["_gosection" .. index]
end

function Season3_0MainScene:onUpdateParam()
	self:_refreshView()
end

function Season3_0MainScene:onOpen()
	self:_loadScene()
end

function Season3_0MainScene:_refreshView()
	self:_showStage()
end

function Season3_0MainScene:focusRole(index)
	if not index then
		self:cancelFocus()

		return
	end

	self:killFocusTween()

	local goKey = string.format("_gorole%s", index)
	local goPos = gohelper.findChild(self[goKey], "vx")

	if not goPos then
		local transform = self[goKey].transform:GetChild(0)

		goPos = transform.gameObject
	end

	if not goPos then
		return
	end

	local x, y, z = transformhelper.getPos(goPos.transform)
	local time = self.focusTime

	self._camera.orthographic = true
	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._camera.transform, x, y - 5.8, 0, time, self.onMoveCompleted, self, nil, EaseType.OutCubic)
	self._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(self.seasonCameraOrthographicSize, self.focusCameraOrthographicSize, time, self._onSizeUpdate, nil, self, nil, EaseType.OutCubic)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Close)
	end
end

function Season3_0MainScene:cancelFocus()
	self:killFocusTween()

	local time = self.cancelFocusTime

	self._camera.orthographic = true
	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._camera.transform, self.seasonCameraLocalPos.x, self.seasonCameraLocalPos.y, self.seasonCameraLocalPos.z, time, self._onMoveCompleted, self, nil, EaseType.OutCubic)
	self._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(self.focusCameraOrthographicSize, self.seasonCameraOrthographicSize, time, self._onSizeUpdate, nil, self, nil, EaseType.OutCubic)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Open)
	end
end

function Season3_0MainScene:_onMoveCompleted()
	self:killFocusTween()
end

function Season3_0MainScene:_onSizeUpdate(val)
	self._camera.orthographicSize = val
end

function Season3_0MainScene:_onOpenFullViewFinish(viewName)
	if not string.find(viewName, "Season") then
		self:doAudio(false)
	end
end

function Season3_0MainScene:_onOpenViewFinish(viewName)
	if not self._listenerViews[viewName] then
		return
	end

	gohelper.setActive(self._goMask, false)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Close)
	end

	self:showSceneAnim()
end

function Season3_0MainScene:_onCloseViewFinish(viewName)
	if not self._listenerViews[viewName] then
		return
	end

	gohelper.setActive(self._goMask, true)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Idle)
	end
end

function Season3_0MainScene:onClose()
	self:_removeEvents()
end

function Season3_0MainScene:killFocusTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenSizeId then
		ZProj.TweenHelper.KillById(self._tweenSizeId)

		self._tweenSizeId = nil
	end
end

function Season3_0MainScene:doAudio(play)
	if self.isAudioPlay == play then
		return
	end

	self.isAudioPlay = play

	if play then
		-- block empty
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_combatnoise_bus)
	end
end

function Season3_0MainScene:_playRoleAni(index, animName, layer, normalizedTime)
	local anim = self["_aniRole" .. index]

	if not anim then
		return
	end

	if layer and normalizedTime then
		anim:Play(animName, layer, normalizedTime)
	else
		anim:Play(animName)
	end
end

function Season3_0MainScene:onDestroyView()
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

return Season3_0MainScene
