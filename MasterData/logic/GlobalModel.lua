-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/model/GlobalModel.lua

module("logic.extensions.global.model.GlobalModel", package.seeall)

local GlobalModel = class("GlobalModel", BaseListModel)

GlobalModel.UIFadeTime = 0.5

function GlobalModel:ctor()
	GlobalModel.super.ctor(self)

	self.uiRoot = goutil.find("UIROOT")
	self.uiCanvas = self.uiRoot:GetComponent("Canvas")
	self.uiCameraGO = goutil.find("UICamera")
	self.uiCamera = self.uiCameraGO:GetComponent("Camera")
	self.eventSystem = goutil.find("EventSystem")
	self.uiCamera.orthographic = true
	self.uiCamera.orthographicSize = 1
	self.uiCamera.depth = 99.2
	self.isUIShow = true

	self:_initUIRootsDepth()
	self:_initAnimationCameras()

	self._strengths = nil
	self.isChangingSrength = nil
	self.currStrength = 0
	self._isHudVisible = 0
	self.gameStart = UnityEngine.GameObject.Find("UIROOT/GameStartBg/Image")
	UGUIToolHelper.activeScale = UGUIToolHelper.GetActiveScale(self.uiRoot)
	UGUIToolHelper.touchDragThreshold = 6 * UGUIToolHelper.GetDPIMul()
	self._isBuildAdaptationOverlayView = false

	self:_adjustCameraRect()
	self:_adjustWidthScreen()
	self:_initUIBlocking()
	GlobalDispatcher:addListener(GlobalNotify.SceneResolutionChange, self._adjustWidthScreen, self)
end

function GlobalModel:onReset()
	UIJumper.instance:clear()

	self._isChangingSrength = nil
	self._strengths = nil
	self.currStrength = 0

	self:showUI(true)

	self._isHudVisible = 1

	self:visibleMainCamera(true)
	self:visibleSceneHUDs(true)
	self:setUIInteractable(true)
	self:resetUINodes()
	GlobalModel.super.onReset(self)
end

function GlobalModel:_initAnimationCameras()
	local mainCam = goutil.find("MainCamera"):GetComponent("Camera")
	local groundCam = goutil.findChild(mainCam.transform, "GroundCamera"):GetComponent("Camera")
	local skillCam = goutil.find("SkillCamera"):GetComponent("Camera")
	local skillUICam = goutil.find("SkillUICamera"):GetComponent("Camera")
	local skillUICanvas = goutil.find("SkillCamera/FADEBACKGROUND"):GetComponent("Canvas")
	local hudLower = goutil.find("SkillUICamera/NAMEBAR")
	local hudHigher = goutil.cloneAndSetParent(hudLower, skillUICam.transform)

	self.groundCamera = groundCam
	self.skillCamera = skillCam
	self.mainCamera = mainCam
	self.skillUICamera = skillUICam
	self.skillUICanvas = skillUICanvas
	self.mainCamCullMask = self.mainCamera.cullingMask
	self.groundCamCullMask = self.groundCamera.cullingMask
	self.skillHUDLower = hudLower
	self.skillHUDHigher = hudHigher
	self.skillHUDLowerCanvas = hudLower:GetComponent("Canvas")
	self.skillHUDHigherCanvas = hudHigher:GetComponent("Canvas")
	self.skillHUDLowerCanvas.sortingOrder = -100
	self.skillHUDHigherCanvas.sortingOrder = -50
	self.skillHUDHigher.name = "HUDDamage"
	self.skillUICamera.orthographic = true
	self.skillUICamera.orthographicSize = 1
	self.skillUICamera.depth = 30
	self.skillCamera.depth = 40
	self.skillCameraCullMask = self.skillCamera.cullingMask

	self.skillUICamera.gameObject:SetActive(false)
	skillCam.gameObject:SetActive(false)
	AMPlayer.InitCamera(mainCam, skillCam)
end

function GlobalModel:_initUIRootsDepth()
	local cam = self.uiCameraGO:GetComponent("Camera")
	local tf = self.uiRoot.transform
	local childCnt = tf.childCount

	childCnt = childCnt - 1

	local canvas = self.uiRoot:GetComponent("Canvas")
	local order = canvas.sortingOrder

	order = order + 50

	for i = 0, childCnt do
		local child = tf:GetChild(i)
		local canvas = child:GetComponent("Canvas")

		canvas.overrideSorting = true
		canvas.sortingOrder = order
		order = order + 50
	end
end

function GlobalModel:_adjustCameraRect()
	CameraRectSetter.CalcRect(self.skillCamera)
end

function GlobalModel:_adjustWidthScreen()
	if BootstrapAdaptationoverlayview then
		BootstrapAdaptationoverlayview.updatePos()
	end
end

function GlobalModel:onEnterScene(sceneType)
	if sceneType == SceneType.Battle then
		if not self.isUIShow then
			self:showUI(true)

			self.isUIShow = nil
		end
	elseif not self.isUIShow then
		self:showUI(nil)

		self.isUIShow = nil
	end
end

function GlobalModel:visibleSceneHUDs(visible)
	if not self.uiRoot then
		return
	end

	if visible then
		self._isHudVisible = self._isHudVisible - 1

		if self._isHudVisible <= 0 then
			SceneRoot2DMgr.instance:show()
		end
	else
		self._isHudVisible = self._isHudVisible + 1

		if self._isHudVisible == 1 then
			SceneRoot2DMgr.instance:hide()
		end
	end
end

function GlobalModel:setSceneHUDsAlpha(alpha)
	if not self._hudCanvasGroup then
		return
	end

	self._hudCanvasGroup.alpha = alpha
end

function GlobalModel:fadeInHuds(tweenTime)
	if not self._hudCanvasGroup then
		return
	end

	UnityTweens.UITweenFadeTo.StopTween(self._hudCanvasGroup.gameObject)

	if self._hudCanvasGroup.alpha <= 0 and tweenTime and tweenTime > 0 then
		UnityTweens.UITweenFadeTo.StartTween(self._hudCanvasGroup.gameObject, 1, tweenTime, UnityTweens.EaseType.easeOutSine)
	else
		self._hudCanvasGroup.alpha = 1
	end
end

function GlobalModel:fadeOutHuds(tweenTime)
	if not self._hudCanvasGroup then
		return
	end

	UnityTweens.UITweenFadeTo.StopTween(self._hudCanvasGroup.gameObject)

	if self._hudCanvasGroup.alpha > 0 and tweenTime and tweenTime > 0 then
		UnityTweens.UITweenFadeTo.StartTween(self._hudCanvasGroup.gameObject, 0, tweenTime, UnityTweens.EaseType.easeOutSine)
	else
		self._hudCanvasGroup.alpha = 0
	end
end

function GlobalModel:visibleMainCamera(visible)
	self.mainCamera.cullingMask = visible and self.mainCamCullMask or 0
end

function GlobalModel:visibleSkillCamera(visible)
	self.skillCamera.cullingMask = visible and self.skillCameraCullMask or 0
end

function GlobalModel:visibleSceneCameras(visible)
	self:visibleMainCamera(visible)
	self:visibleSkillCamera(visible)
end

function GlobalModel:isUIShowing()
	return self.isUIShow
end

function GlobalModel:_initUIBlocking()
	if not self.uiRoot then
		return
	end

	local topMost = goutil.findChild(self.uiRoot, "TOPMOST")

	self._uiBlockGo = goutil.create("___ui_click_block___", true)

	goutil.addChildToParent(self._uiBlockGo, topMost)
	GameUtil.expandRectTransform(self._uiBlockGo.transform)

	local img = goutil.addComponentOnce(self._uiBlockGo, typeof(UnityEngine.UI.Image))

	img.color = parsecolor("#00000000")

	GameUtil.SetActive(self._uiBlockGo, false)
end

function GlobalModel:setUIBlocking(isActive)
	if not self._uiBlockGo then
		return
	end

	GameUtil.SetActive(self._uiBlockGo, isActive)
	self._uiBlockGo.transform:SetAsLastSibling()
end

function GlobalModel:setUIInteractable(interactable)
	if not self.uiRoot then
		return
	end

	local canvasGroup = self.uiRoot:GetComponent("CanvasGroup")

	canvasGroup.interactable = interactable

	ViewBlockMgr.instance:blockClick(not interactable)
end

function GlobalModel:onlyShowUINode(nodeName)
	if not self.uiRoot then
		return
	end

	local transform = self.uiRoot.transform
	local nodeCount = transform.childCount - 1

	for i = 0, nodeCount do
		local go = transform:GetChild(i).gameObject

		if go.name == nodeName then
			go:SetActive(true)
		else
			go:SetActive(false)
		end
	end
end

function GlobalModel:resetUINodes()
	if not self.uiRoot then
		return
	end

	local transform = self.uiRoot.transform
	local nodeCount = transform.childCount - 1

	for i = 0, nodeCount do
		local go = transform:GetChild(i).gameObject

		go:SetActive(true)
	end
end

function GlobalModel:showUI(show, tweenTime)
	if not self.uiRoot then
		return
	end

	if not show then
		UIEffectManager.instance:setVisible(false)

		local canvasGroup = self.uiRoot:GetComponent("CanvasGroup")

		canvasGroup.interactable = false
		canvasGroup.blocksRaycasts = false

		SceneRoot2DMgr.instance:hide()

		self._skillUIVisible = self.skillUICamera.gameObject.activeSelf

		if self._skillUIVisible then
			self.skillUICamera.gameObject:SetActive(false)
		end

		self.isUIShow = nil

		UnityTweens.UITweenFadeTo.StopTween(self.uiRoot)

		if canvasGroup.alpha > 0 and tweenTime and tweenTime > 0 then
			UnityTweens.UITweenFadeTo.StartTween(self.uiRoot, 0, tweenTime, UnityTweens.EaseType.easeOutSine)
		else
			canvasGroup.alpha = 0
		end

		local rayCasters = self.uiRoot:GetComponentsInChildren(typeof(UnityEngine.UI.GraphicRaycaster), true)

		for i = 0, rayCasters.Length - 1 do
			rayCasters[i].enabled = false
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnUIVisible, false)
	else
		UIEffectManager.instance:setVisible(true)

		local canvasGroup = self.uiRoot:GetComponent("CanvasGroup")

		canvasGroup.interactable = true
		canvasGroup.blocksRaycasts = true

		if self._isHudVisible <= 0 then
			SceneRoot2DMgr.instance:show()
		end

		local top = self:getTopView()

		if top then
			self:checkShowGrayMask()
		end

		self.isUIShow = true

		if self._skillUIVisible then
			self.skillUICamera.gameObject:SetActive(true)
		end

		UnityTweens.UITweenFadeTo.StopTween(self.uiRoot)

		if canvasGroup.alpha <= 0 and tweenTime and tweenTime > 0 then
			UnityTweens.UITweenFadeTo.StartTween(self.uiRoot, 1, tweenTime, UnityTweens.EaseType.easeOutSine)
		else
			canvasGroup.alpha = 1
		end

		local rayCasters = self.uiRoot:GetComponentsInChildren(typeof(UnityEngine.UI.GraphicRaycaster), true)

		for i = 0, rayCasters.Length - 1 do
			rayCasters[i].enabled = true
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnUIVisible, true)
	end
end

function GlobalModel:checkViewNeedShowGrayMask(view)
	local grayMaskGo = ViewMgr.instance._grayMaskGO

	if grayMaskGo then
		if ViewSetting.instance:isModal(view.viewName) and view.mainGO and view.mainGO.activeSelf then
			grayMaskGo:SetActive(true)
			view:setGrayMaskGO(grayMaskGo)
		else
			grayMaskGo:SetActive(false)
		end
	end
end

function GlobalModel:checkShowGrayMask()
	local grayMaskGo = ViewMgr.instance._grayMaskGO

	if grayMaskGo then
		local views = self:getSortingViews(true)
		local hit

		for i = 1, #views do
			if ViewSetting.instance:isModal(views[i].viewName) and ViewMgr.instance:isOpen(views[i].viewName) then
				if views[i].priority then
					if views[i].mainGO and views[i].mainGO.activeSelf then
						grayMaskGo:SetActive(true)
						views[i]:setGrayMaskGO(grayMaskGo)

						hit = true

						break
					end
				else
					grayMaskGo:SetActive(true)
					views[i]:setGrayMaskGO(grayMaskGo)

					hit = true

					break
				end
			end
		end

		if not hit then
			grayMaskGo:SetActive(false)
		end
	end
end

function GlobalModel:getTopView()
	local views = self:getSortingViews()

	return views[1]
end

function GlobalModel:isTopView(view)
	local topView = self:getTopView()

	if topView and topView.parentPresentor then
		topView = topView.parentPresentor
	end

	if view and view.parentPresentor then
		view = view.parentPresentor
	end

	if view == topView then
		return true
	end

	return GlobalModel.isUppon(view, topView)
end

function GlobalModel:getSortingViews(withNotify)
	local views = {}

	for k, v in pairs(ViewMgr.instance._views) do
		if v._status == ViewPresentor.kViewStatusClosing or ViewMgr.instance:isOpen(v.viewName) then
			local root = v:attachToWhichRoot()

			if withNotify or root ~= ViewRootType.Notify and root ~= ViewRootType.NotifyTop and not ViewMgr.instance:isNotifyView(v.viewName) then
				table.insert(views, v)
			end
		end
	end

	table.sort(views, function(first, second)
		return GlobalModel.isUppon(first, second)
	end)

	return views
end

function GlobalModel:getViewByName(name)
	for k, v in pairs(ViewMgr.instance._views) do
		if v.viewName == name then
			return v
		end
	end
end

function GlobalModel.isUppon(first, second)
	local fn, sn = "", ""

	if first.parentPresentor then
		fn = first.viewName
		first = first.parentPresentor
	end

	if second.parentPresentor then
		sn = second.viewName
		second = second.parentPresentor
	end

	if first == second then
		return false
	end

	if (first.viewName == ViewName.Story or first.viewName == ViewName.UnlockView) and first.fadingOut then
		return false
	end

	if (second.viewName == ViewName.Story or second.viewName == ViewName.UnlockView) and second.fadingOut then
		return false
	end

	local firstpPriority = first.priority
	local secondPriority = second.priority

	if firstpPriority and secondPriority then
		if secondPriority < firstpPriority then
			return true
		end

		return false
	end

	if first.mainGO and goutil.isNil(first.mainGO) then
		printError("first界面预制已经被销毁，但是界面还没关闭，名字=" .. (first.viewName or ""), "有Parent时selfName:", fn)
	end

	if second.mainGO and goutil.isNil(second.mainGO) then
		printError("second界面预制已经被销毁，但是界面还没关闭，名字=" .. (second.viewName or ""), "有Parent时selfName:", sn)
	end

	if first.mainGO and second.mainGO and (first.mainGO.transform:IsChildOf(second.mainGO.transform) or second.mainGO.transform:IsChildOf(first.mainGO.transform)) then
		return false
	end

	local firstTopNode = first:attachToWhichRoot()
	local secondTopNode = second:attachToWhichRoot()

	if firstTopNode and not secondTopNode then
		return false
	end

	if not firstTopNode and secondTopNode then
		return true
	end

	if firstTopNode and secondTopNode then
		if firstTopNode < secondTopNode then
			return false
		end

		if secondTopNode < firstTopNode then
			return true
		end

		if firstTopNode == secondTopNode then
			local firstGo = first.mainGO
			local secondGo = second.mainGO

			if not firstGo and secondGo then
				return true
			end

			if firstGo and not secondGo then
				return false
			end

			if firstGo and secondGo then
				local firstIdx = firstGo.transform:GetSiblingIndex()
				local secondIdx = secondGo.transform:GetSiblingIndex()

				if firstIdx < secondIdx then
					return false
				end

				if secondIdx < firstIdx then
					return true
				end
			end
		end

		return false
	end

	if not firstTopNode and not secondTopNode then
		if first.mainGO and second.mainGO then
			local canVas0 = first.mainGO:GetComponent("Canvas")
			local canVas1 = second.mainGO:GetComponent("Canvas")

			if canVas0 and canVas1 and canVas0.sortingOrder > canVas1.sortingOrder then
				return true
			end

			return false
		elseif first.mainGO and not second.mainGO then
			return true
		elseif not first.mainGO and second.mainGO then
			return false
		end
	end

	return false
end

function GlobalModel:onPlayerStrengthChange(strength)
	self._strengths = self._strengths or {}

	table.insert(self._strengths, strength)
end

function GlobalModel:popStrength()
	if self._strengths then
		local cnt = #self._strengths

		while cnt > 0 do
			local strength = self._strengths[cnt]

			table.remove(self._strengths)

			cnt = cnt - 1

			if strength > self.currStrength then
				self._strengths = {}

				return strength
			end
		end
	end

	return 0
end

function GlobalModel:getCurrStrength()
	if self.currStrength == 0 then
		self.currStrength = RoleModel.instance:getMaxPower()
	end

	return self.currStrength
end

function GlobalModel:cleartCurrStrengths()
	self._strengths = nil
end

GlobalModel.instance = GlobalModel.New()

return GlobalModel
