-- chunkname: @modules/logic/season/view/SeasonMainScene.lua

module("modules.logic.season.view.SeasonMainScene", package.seeall)

local SeasonMainScene = class("SeasonMainScene", BaseView)

function SeasonMainScene:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._gotoptipsbg = gohelper.findChild(self.viewGO, "#go_main/#go_toptipsbg")
	self._focusSetting = {
		{
			x = -3.02,
			y = 0.05
		},
		{
			x = -0.26,
			y = -0.61
		},
		{
			x = 2.17,
			y = -0.38
		},
		{
			x = -2.14,
			y = -0.82
		},
		{
			x = -3.28,
			y = -1.33
		},
		{
			x = 1.58,
			y = -1.33
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
		[ViewName.SeasonMarketView] = 1
	}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonMainScene:addEvents()
	return
end

function SeasonMainScene:removeEvents()
	return
end

SeasonMainScene.SeasonCameraOrthographicSize = 3.85
SeasonMainScene.SeasonCameraLocalPos = Vector2(-0.65, -0.28)
SeasonMainScene.FocusCameraOrthographicSize = 2
SeasonMainScene.FocusTime = 0.45
SeasonMainScene.CancelFocusTime = 0.45
SeasonMainScene.BlockKey = "SeasonMainScene"

function SeasonMainScene:_editableInitView()
	self._camera = CameraMgr.instance:getMainCamera()

	self:_initSceneRootNode()
	self:_loadScene()
	self:_addEvents()
end

function SeasonMainScene:_addEvents()
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.ChangeCameraSize, self._onChangeCamera, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SelectRetail, self.focusRole, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function SeasonMainScene:initCamera()
	local isFirst = false

	if not self._initCamaraParam then
		self._initCamaraParam = {}
		self._initCamaraParam.orthographic = self._camera.orthographic
		self._initCamaraParam.orthographicSize = self._camera.orthographicSize

		local pos = {}

		pos.x, pos.y, pos.z = transformhelper.getLocalPos(self._camera.transform)
		self._initCamaraParam.pos = pos
		isFirst = true
	end

	transformhelper.setLocalRotation(self._camera.transform, 0, 0, 0)
	self:_showScenes(isFirst)
end

function SeasonMainScene:resetCamera()
	if not self._initCamaraParam then
		return
	end

	self._camera.orthographicSize = self._initCamaraParam.orthographicSize
	self._camera.orthographic = self._initCamaraParam.orthographic

	transformhelper.setLocalPos(self._camera.transform, self._initCamaraParam.pos.x, self._initCamaraParam.pos.y, self._initCamaraParam.pos.z)
end

function SeasonMainScene:_onChangeCamera(isRetail)
	self._isShowRetail = isRetail

	self:initCamera()
end

function SeasonMainScene:_showScenes(isFirst)
	if not self._sceneGo then
		return
	end

	TaskDispatcher.cancelTask(self._showScenes, self)

	if self._isShowRetail then
		if not isFirst then
			self._sceneAnim:Play("go1")
		end

		self:_enterRetail()
	else
		if not isFirst then
			self._sceneAnim:Play("go2")
		end

		self:_enterMarket()
	end
end

function SeasonMainScene:_enterRetail()
	self._camera.orthographicSize = SeasonMainScene.SeasonCameraOrthographicSize
	self._camera.orthographic = true

	transformhelper.setLocalPos(self._camera.transform, SeasonMainScene.SeasonCameraLocalPos.x, SeasonMainScene.SeasonCameraLocalPos.y, 0)
	self:_refreshRoles()
end

function SeasonMainScene:_onRefreshRetail()
	self:_refreshRoles(true)
end

function SeasonMainScene:_refreshRoles(isOpen)
	UIBlockMgr.instance:endBlock(SeasonMainScene.BlockKey)
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

function SeasonMainScene:_battleSuccessRefreshRoles(retails)
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
	UIBlockMgr.instance:startBlock(SeasonMainScene.BlockKey)
end

function SeasonMainScene:_onDelayRefreshRoles()
	for _, v in pairs(self.delayRetails) do
		local index = v.position

		gohelper.setActive(self["_gorole" .. index], true)
		self["_aniRole" .. index]:Play(UIAnimationName.Close, 0, 0)
	end

	TaskDispatcher.runDelay(self._refreshRoles, self, 0.33)
end

function SeasonMainScene:_normalRefreshRoles(retails, noretail, isOpen)
	local t = {}

	for i = 1, 6 do
		t[i] = false
	end

	for _, v in pairs(retails) do
		local index = v.position

		t[index] = nil

		gohelper.setActive(self["_gorole" .. index], true)

		if isOpen then
			self["_aniRole" .. index]:Play(UIAnimationName.Open, 0, 0)
		else
			self["_aniRole" .. index]:Play(UIAnimationName.Idle, 0, 0)
		end
	end

	for k, v in pairs(t) do
		if isOpen and self["_gorole" .. k].activeInHierarchy then
			self["_aniRole" .. k]:Play(UIAnimationName.Close, 0, 0)
		else
			gohelper.setActive(self["_gorole" .. k], false)
		end
	end

	if noretail then
		gohelper.setActive(self._gospotlight, true)
		self._animspotlight:Play(UIAnimationName.Open, 0, 0)

		return
	end

	if isOpen and self._gospotlight.activeInHierarchy then
		self._animspotlight:Play(UIAnimationName.Close, 0, 0)

		return
	end

	gohelper.setActive(self._gospotlight, false)
end

function SeasonMainScene:_enterMarket()
	gohelper.setActive(self._gospotlight, false)
	self:_refreshRoles()

	self._camera.orthographicSize = SeasonMainScene.SeasonCameraOrthographicSize
	self._camera.orthographic = true

	transformhelper.setLocalPos(self._camera.transform, SeasonMainScene.SeasonCameraLocalPos.x, SeasonMainScene.SeasonCameraLocalPos.y, 0)
end

function SeasonMainScene:_initSceneRootNode()
	local mainTrans = self._camera.transform.parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("SeasonMainScene")

	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function SeasonMainScene:_loadScene()
	self._mapLoader = MultiAbLoader.New()
	self._scenePath = "scenes/m_s15_sjwf_1_1/scene_prefab/m_s15_sjwf_1_1_p.prefab"

	self._mapLoader:addPath(self._scenePath)
	self._mapLoader:startLoad(self._loadSceneFinish, self)
end

function SeasonMainScene:_loadSceneFinish()
	local mainPrefab = self._mapLoader:getAssetItem(self._scenePath):GetResource(self._scenePath)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot)
	self._goroles = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/juese")
	self._gorole1 = gohelper.findChild(self._goroles, "m_sjwf_xiaogou_L")
	self._gorole2 = gohelper.findChild(self._goroles, "m_sjwf_meilanni_R")
	self._gorole3 = gohelper.findChild(self._goroles, "m_sjwf_xingti_R")
	self._gorole4 = gohelper.findChild(self._goroles, "m_sjwf_meilanni_L")
	self._gorole5 = gohelper.findChild(self._goroles, "m_sjwf_xingti_L")
	self._gorole6 = gohelper.findChild(self._goroles, "m_sjwf_xiaogou_R")

	for i = 1, 6 do
		self[string.format("_aniRole%s", i)] = self[string.format("_gorole%s", i)]:GetComponent(typeof(UnityEngine.Animator))
	end

	self._gosection1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section01")
	self._gosection2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section02")
	self._gosection3 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section03")
	self._gosection3part1 = gohelper.findChild(self._gosection3, "m_s15_sjwf_shu_b")

	gohelper.setActive(self._gosection3part1, true)

	self._gosection3part2 = gohelper.findChild(self._gosection3, "m_s15_sjwf_zz_l_l")
	self._gosection4 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section04")
	self._gosection5 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section05")
	self._gosection6 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/section06")
	self._gospotlight = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/spotlight")
	self._animspotlight = self._gospotlight:GetComponent(typeof(UnityEngine.Animator))
	self._sceneAnim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	self._goMask = gohelper.findChild(self._sceneGo, "root/BackGround/#mask")
	self._aniMask = self._goMask:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goroles, false)
	gohelper.setActive(self._gospotlight, false)
	self:_refreshView()
	self:_initLevelupObjs()
	self:initCamera()
end

function SeasonMainScene:_initLevelupObjs()
	self._levelupObjs = {}

	local nodePaths = {
		"#yunduo",
		"#caihong",
		"m_s15_sjwf_shu_b",
		"#diaozi",
		"#hudie",
		"#jiaoshui",
		"m_s15_sjwf_zz_l_b"
	}

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
			end

			for _, v in pairs(nodePaths) do
				obj = gohelper.findChild(gosection, string.format("%s/leveup", v))

				if obj then
					table.insert(list, obj)
				end
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

function SeasonMainScene:showLevelObjs(stage)
	if not self._levelupObjs then
		self._waitShowLevelStage = stage

		return
	end

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

	local container = ViewMgr.instance:getContainer(ViewName.SeasonMainView)

	if container then
		container:stopUI(false)
	end
end

function SeasonMainScene:_hideLevelObjs(isDefault)
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

	local container = ViewMgr.instance:getContainer(ViewName.SeasonMainView)

	if container then
		container:playUI(true)
	end
end

function SeasonMainScene:_showStage()
	local stageId = Activity104Model.instance:getAct104CurStage()
	local setting = self:_getStageSetting(stageId)

	if stageId == 3 or stageId == 4 then
		gohelper.setActive(self._gosection3part2, true)
	else
		gohelper.setActive(self._gosection3part2, false)
	end

	for i = 1, 6 do
		self:_setGoSectionActive(i, false)
	end

	if setting then
		for k, v in pairs(setting) do
			self:_setGoSectionActive(v, true)
		end
	end
end

function SeasonMainScene:_getStageSetting(stageId)
	return self._stageSetting[stageId] or self._stageSetting[6]
end

function SeasonMainScene:_setGoSectionActive(index, active)
	gohelper.setActive(self:_getGoSection(index), active)
end

function SeasonMainScene:_getGoSection(index)
	return self["_gosection" .. index]
end

function SeasonMainScene:onUpdateParam()
	self:_refreshView()
end

function SeasonMainScene:onOpen()
	return
end

function SeasonMainScene:_refreshView()
	self:_showStage()
end

function SeasonMainScene:focusRole(index)
	if not index then
		self:cancelFocus()

		return
	end

	self:killFocusTween()

	local setting = self._focusSetting[index]

	if not setting then
		return
	end

	local time = SeasonMainScene.FocusTime

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._camera.transform, setting.x, setting.y, 0, time, self._onMoveCompleted, self, nil, EaseType.OutCubic)
	self._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(SeasonMainScene.SeasonCameraOrthographicSize, SeasonMainScene.FocusCameraOrthographicSize, time, self._onSizeUpdate, nil, self, nil, EaseType.OutCubic)

	self._aniMask:Play(UIAnimationName.Close)
end

function SeasonMainScene:cancelFocus()
	self:killFocusTween()

	local time = SeasonMainScene.CancelFocusTime

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self._camera.transform, SeasonMainScene.SeasonCameraLocalPos.x, SeasonMainScene.SeasonCameraLocalPos.y, 0, time, self._onMoveCompleted, self, nil, EaseType.OutCubic)
	self._tweenSizeId = ZProj.TweenHelper.DOTweenFloat(SeasonMainScene.FocusCameraOrthographicSize, SeasonMainScene.SeasonCameraOrthographicSize, time, self._onSizeUpdate, nil, self, nil, EaseType.OutCubic)

	self._aniMask:Play(UIAnimationName.Open)
end

function SeasonMainScene:_onMoveCompleted()
	return
end

function SeasonMainScene:_onSizeUpdate(val)
	self._camera.orthographicSize = val
end

function SeasonMainScene:_onOpenViewFinish(viewName)
	if not self._listenerViews[viewName] then
		return
	end

	gohelper.setActive(self._goMask, false)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Close)
	end
end

function SeasonMainScene:_onCloseViewFinish(viewName)
	if not self._listenerViews[viewName] then
		return
	end

	gohelper.setActive(self._goMask, true)

	if self._aniMask then
		self._aniMask:Play(UIAnimationName.Idle)
	end
end

function SeasonMainScene:onClose()
	self:resetCamera()
	self:_removeEvents()
end

function SeasonMainScene:_removeEvents()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.ChangeCameraSize, self._onChangeCamera, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SelectRetail, self.focusRole, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function SeasonMainScene:killFocusTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._tweenSizeId then
		ZProj.TweenHelper.KillById(self._tweenSizeId)

		self._tweenSizeId = nil
	end
end

function SeasonMainScene:onDestroyView()
	UIBlockMgr.instance:endBlock(SeasonMainScene.BlockKey)
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

return SeasonMainScene
