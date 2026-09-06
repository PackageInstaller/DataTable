-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/lmvcext/LMVCExt.lua

function ViewComponent:getLangList()
	return nil
end

function ViewComponent:loadLangText()
	local txtList = self:getLangList()

	if not txtList or #txtList < 1 then
		return
	end

	for i = 1, #txtList do
		local txt = goutil.findChildTextComponent(self.mainGO, txtList[i].goPath)

		txt.text = lang(txtList[i].lang)
	end
end

function ViewComponent:getBigBgList()
	return nil
end

function ViewComponent:loadBigBg()
	local bgList = self:getBigBgList()

	if not bgList or #bgList < 1 then
		return
	end

	if not self._bigImages then
		self._bigImages = {}

		for i = 1, #bgList do
			local go = goutil.findChild(self.mainGO, bgList[i].goPath)

			if enableLog then
				local imageComp = go:GetComponent(goutil.Type_UIImage)

				if not goutil.isNil(imageComp.sprite) then
					printError("Sprite should not be referenced by BigImageBg GameObject! goPath=", bgList[i].goPath, self.mainGO.name)
				end
			end

			local img = Framework.ImageBigBG.Get(go)

			table.insert(self._bigImages, img)
		end
	end

	for i = 1, #self._bigImages do
		self._bigImages[i]:SetImage(langpath(bgList[i].imageUrl), nil)
	end
end

function ViewComponent:unloadBigBg()
	if not self._bigImages then
		return
	end

	for i = 1, #self._bigImages do
		self._bigImages[i]:ClearImage()
	end
end

function ViewComponent:close()
	if self._viewPresentor then
		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end
end

function ViewComponent:getTxt(goPath)
	return goutil.findChildTextComponent(self.mainGO, goPath)
end

function ViewComponent:getImg(goPath)
	return goutil.findChildImageComponent(self.mainGO, goPath)
end

function ViewComponent:closeTab()
	self._curStackName = nil
	self.tabPresentor = nil
end

function ViewComponent:isOpen()
	if self._viewPresentor then
		return self._viewPresentor:isOpen()
	end

	return false
end

function ViewComponent:showTabAt(parent, childViewName, ...)
	if string.nilorempty(self._curStackName) and string.nilorempty(childViewName) then
		return
	end

	if self._curStackName ~= childViewName then
		if not string.nilorempty(self._curStackName) then
			ViewMgr.instance:close(self._curStackName)
		end

		self._curStackName = childViewName
		self.tabPresentor = nil

		if not string.nilorempty(self._curStackName) then
			self.tabPresentor = ViewMgr.instance:openAt(parent, self._curStackName, self._viewPresentor, ...)
		end
	elseif not string.nilorempty(self._curStackName) and not ViewMgr.instance:isOpen(self._curStackName) then
		self.tabPresentor = ViewMgr.instance:openAt(parent, self._curStackName, self._viewPresentor, ...)
	end
end

function ViewComponent:_setTopGoldBar(goldBarCon, goldBarStr)
	local btn_list = {}
	local list = string.split(goldBarStr, "#")

	for i, v in ipairs(list) do
		table.insert(btn_list, {
			showAdd = true,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(goldBarCon, self._viewPresentor, btn_list, false)
end

function ViewComponent:_removeAllGEvent()
	if self.__eventList then
		for i, obj in ipairs(self.__eventList) do
			GlobalDispatcher:removeListener(obj.eventName, obj.handler, obj.handlerObj)
		end

		self.__eventList = nil
	end
end

function ViewComponent:addGEvent(eventName, handler, handlerObj, priority)
	self.__eventList = self.__eventList or {}
	handlerObj = handlerObj or self
	priority = priority or NotifyPriority.Normal

	local obj = {}

	obj.eventName = eventName
	obj.handler = handler
	obj.handlerObj = handlerObj

	table.insert(self.__eventList, obj)
	GlobalDispatcher:addListener(eventName, handler, handlerObj, priority)
end

function ViewComponent:_clearAllViewEffect()
	if self.__viewEffectList then
		for i, v in ipairs(self.__viewEffectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self.__viewEffectList = nil
	end
end

function ViewComponent:playViewEffect(effPath, effParentGO, clipGO, loop, x, y, finishHandle, loadedHandler)
	if loop == nil then
		loop = true
	end

	if x == nil then
		x = 0
	end

	if y == nil then
		y = 0
	end

	effParentGO = effParentGO or self.mainGO

	local function _finishHandle(handlerTarget, eff)
		GameUtil.callBack(finishHandle, handlerTarget, eff)
		self:stopViewEffect(eff)
	end

	local function _loadedHandler(handlerTarget, eff)
		if clipGO then
			eff:setClipping(clipGO:GetComponent(goutil.Type_RectTransform))
		else
			eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
		end

		eff:setParent(effParentGO.transform)
		eff:setLocalPos(x, y, 0)
		eff:setScale(1, 1, 1)
		eff:setLocalEulerAngle(0, 0, 0)
		GameUtil.callBack(loadedHandler, handlerTarget, eff)
	end

	local effect = UIEffectManager.instance:playEffect(self, effPath, effParentGO, x, y, loop, false, _finishHandle, _loadedHandler, nil)

	self.__viewEffectList = self.__viewEffectList or {}

	table.insert(self.__viewEffectList, effect)

	return effect
end

function ViewComponent:stopViewEffect(effect)
	UIEffectManager.instance:stopEffect(effect)

	if self.__viewEffectList then
		for i, v in ipairs(self.__viewEffectList) do
			if v == effect then
				table.remove(self.__viewEffectList, i)

				break
			end
		end
	end
end

function ViewComponent:playViewEffectUniGo(effPath, effParentGO, clipGo, loop, finishHandle, loadedHandler)
	if self.__viewEffectList then
		for i, v in ipairs(self.__viewEffectList) do
			if v.widget == effParentGO then
				return v
			end
		end
	end

	return self:playViewEffect(effPath, effParentGO, clipGo, loop, 0, 0, finishHandle, loadedHandler)
end

function ViewComponent:stopViewEffectUniGo(effParentGO)
	if self.__viewEffectList then
		for i, v in ipairs(self.__viewEffectList) do
			if v.widget == effParentGO then
				table.remove(self.__viewEffectList, i)
				UIEffectManager.instance:stopEffect(v)

				break
			end
		end
	end
end

function ViewPresentor:open(param)
	if self.priority then
		ViewPriorityMgr.instance:onOpenView(self)
	end

	self.parentGO = nil
	self.parentPresentor = ViewMgr.instance:getAndClearViewParentPresentor(self.viewName)
	self._openParam = param

	if not self._isResLoaded and self._opType ~= ViewPresentor.kViewOpOpen then
		self._opType = ViewPresentor.kViewOpOpen

		self:loadViewResources()

		return
	end

	if self._status == ViewPresentor.kViewStatusBuild then
		local vCount = #self._views

		for i = 1, vCount do
			local tempView = self._views[i]

			tempView:buildUI()
			tempView:bindEvents()

			tempView.isViewBuilt = true
			self._status = ViewPresentor.kViewStatusClose
		end
	end

	if self._status == ViewPresentor.kViewStatusClose then
		self:_doOpen()
	else
		self._opType = self._status == ViewPresentor.kViewStatusClosing and ViewPresentor.kViewOpOpen or self._status == ViewPresentor.kViewStatusIniting and ViewPresentor.kViewOpOpen or ViewPresentor.kViewOpNone
	end

	if self.viewName == ViewName.MainUI then
		ResGcMgr.instance:delayTryGc(0.1)
	end
end

local ViewPresentor_close = ViewPresentor.close

function ViewPresentor:close()
	self:_hideWaitingView()
	ViewPresentor_close(self)
end

function ViewPresentor:getViewByName(name)
	local target

	for i = 1, #self._views do
		if self._views[i].__cname == name then
			return self._views[i]
		end
	end

	return nil
end

function ViewPresentor:_setMainCameraVisible(_viewName, _state)
	if not _viewName or not _state then
		return
	end

	if ViewPresentor.kOnEnter == _state then
		if _viewName == ViewName.MainUI or _viewName == ViewName.Popupwindow or _viewName == ViewName.chat then
			GlobalModel.instance:visibleMainCamera(true)
		end
	elseif ViewPresentor.kOnEnterFinished == _state then
		if ViewSetting.instance:isFullScreen(_viewName) and _viewName ~= ViewName.VideoPlaying then
			GlobalModel.instance:visibleMainCamera(false)
		end
	elseif ViewPresentor.kOnExit == _state and _viewName ~= ViewName.MainUI then
		GlobalModel.instance:visibleMainCamera(true)
	end
end

function ViewPresentor:_onVisualEvent(name)
	if not self._views then
		return
	end

	local vCount = #self._views

	for i = 1, vCount do
		if ViewPresentor.kOnEnter == name then
			self:_setMainCameraVisible(self.viewName, ViewPresentor.kOnEnter)
			self._views[i]:onEnter()
			self._views[i]:loadBigBg()
			self._views[i]:loadLangText()
		elseif ViewPresentor.kOnEnterFinished == name then
			self._views[i]:onEnterFinished()
			self:_setMainCameraVisible(self.viewName, ViewPresentor.kOnEnterFinished)
		elseif ViewPresentor.kOnExit == name then
			self._views[i]:_removeAllGEvent()
			self._views[i]:_clearAllViewEffect()
			self._views[i]:onExit()
			self._views[i]:closeTab()
			self:_onPresentorExit()
			self:_setMainCameraVisible(self.viewName, ViewPresentor.kOnExit)
		elseif ViewPresentor.kOnExitFinished == name then
			self._views[i]:onExitFinished()
			self._views[i]:unloadBigBg()
		elseif ViewPresentor.kOnResumeFinished == name then
			self._views[i]:onResumeFinished()
		end
	end

	if ViewPresentor.kOnExitFinished == name then
		self:_unloadTempResources()
	end
end

function ViewPresentor:_onPresentorExit()
	if self.parentGO ~= nil then
		local rootNode = self.parentPresentor and ViewMgr.instance:getRoot(self.parentPresentor:attachToWhichRoot()) or ViewMgr.instance:getRoot(self:attachToWhichRoot())

		if rootNode then
			self:setCurParent(rootNode)
		end
	end

	self.parentGO = nil
	self.parentPresentor = nil
end

function ViewPresentor:playEnterAnimation()
	local cur = 1.1

	GameUtil.setLocalScale(self.mainGO, cur, cur, 1)

	self.tween = TweenUtil.ValueTo(cur, 1, 0.2, function(val)
		GameUtil.setLocalScale(self.mainGO, val, val, 1)
	end, function()
		self.tween = nil

		self:_onEnterAnimationDone()
	end, self)
end

function ViewPresentor:playCloseAnimation()
	self:addBlockClick()

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	local co = ViewSetting.instance:getViewConfig(self.viewName)

	if co == nil then
		self:_onCloseAnimationDone()
		self:cutBlockClick()
	elseif co.showMode == ViewSetting.kWindowEx or co.showMode == ViewSetting.kModalWindowEx or co.showMode == ViewSetting.kFullScreenWindowEx or co.showMode == ViewSetting.kNormalViewEx or co.showMode == ViewSetting.kModalViewEx or co.showMode == ViewSetting.kFullScreenViewEx then
		local cur = 1

		GameUtil.setLocalScale(self.mainGO, cur, cur, 1)

		self.tween = TweenUtil.ValueTo(cur, 0.8, 0.2, function(val)
			GameUtil.setLocalScale(self.mainGO, val, val, 1)
		end, function()
			self.tween = nil

			self:_onCloseAnimationDone()
			self:cutBlockClick()
		end, self, DG.Tweening.Ease.InBack)
	else
		self:_onCloseAnimationDone()
		self:cutBlockClick()
	end
end

function ViewPresentor:_doOpen()
	self._opType = ViewPresentor.kViewOpNone
	self._status = ViewPresentor.kViewStatusOpening

	self:addToParent()
	self:_loadTempResources()
end

function ViewPresentor:_doClose()
	self._opType = ViewPresentor.kViewOpNone
	self._status = ViewPresentor.kViewStatusClosing

	self:_onVisualEvent(ViewPresentor.kOnExit)
	self:playCloseAnimation()
end

function ViewPresentor:_onEnterAnimationDone()
	self:_onVisualEvent(ViewPresentor.kOnEnterFinished)

	self._status = ViewPresentor.kViewStatusOpen

	GlobalDispatcher:dispatch(GlobalNotify.OnViewOpenDone, self)

	if self._opType == ViewPresentor.kViewOpClose then
		self:_doClose()
	end
end

function ViewPresentor:_onCloseAnimationDone()
	self:_onVisualEvent(ViewPresentor.kOnExitFinished)

	self._status = ViewPresentor.kViewStatusClose

	self:hideSelf()

	if self.closeCallBack then
		self.closeCallBack()

		self.closeCallBack = nil
	end

	if self._opType == ViewPresentor.kViewOpOpen then
		self:_doOpen()
	else
		self._openParam = nil

		self:setCurParent(nil)
		GlobalDispatcher:dispatch(GlobalNotify.OnViewClose, self)
		GlobalModel.instance:checkShowGrayMask()
	end

	if self.priority then
		ViewPriorityMgr.instance:popPriorityViewsList(self)
		ViewPriorityMgr.instance:handleViewsPriority()
	end
end

ViewPresentor.__FLAG_KEY = 1000

function ViewPresentor:getWattingKey()
	ViewPresentor.__FLAG_KEY = ViewPresentor.__FLAG_KEY + 1

	return ViewPresentor.__FLAG_KEY
end

function ViewPresentor:addBlockClick()
	ViewPresentor._loadingBlockNum = ViewPresentor._loadingBlockNum + 1

	ViewBlockMgr.instance:blockClick(true, kBlockKeyViewLoading)
end

function ViewPresentor:cutBlockClick()
	ViewPresentor._loadingBlockNum = ViewPresentor._loadingBlockNum - 1

	if ViewPresentor._loadingBlockNum < 1 then
		ViewBlockMgr.instance:blockClick(false, kBlockKeyViewLoading)
	end
end

function ViewPresentor:loadViewResources(_callBack)
	self.localDispatcher = ExtensionMgr.instance:getExtDispatcher(ViewSetting.instance:getExtId(self.viewName))

	if ViewSetting.instance:isModal(self.viewName) or ViewSetting.instance:isFullScreen(self.viewName) then
		self:addBlockClick()

		if self.isBlocking == true then
			self:cutBlockClick()
		end

		self.isBlocking = true
	end

	if ViewName.isBlockWaitingViewOnLoad(self.viewName) == false then
		if enableLog then
			printInfo("ViewPresentor:loadViewResources() - 开始加载view资源,显示转菊花界面(WaitingView),viewName=" .. self.viewName)
		end

		self:_hideWaitingView()

		self.curr_flag = self:getWattingKey()

		WaitingView.instance:show("", self.curr_flag)
	end

	local toloadList = self:dependWhatResources()

	if toloadList and #toloadList then
		self._preCreateCallBack = _callBack

		if enableDebug then
			for i, v in ipairs(toloadList) do
				if string.lower(v) ~= v then
					error("ViewPresentor:dependWhatResources不能存在大写字母:" .. v)
				end

				if string.gsub(v, "%s+", "") ~= v then
					error("ViewPresentor:dependWhatResources不能存在 空格 :" .. v)
				end
			end
		end

		self._resLoader = MultiResLoader.New()

		self._resLoader:setResPaths(toloadList)
		self._resLoader:load(ViewPresentor._onViewResourcesLoaded, nil, self)
	else
		self:_onViewResourcesLoaded(nil)
	end
end

function ViewPresentor:_hideWaitingView()
	if self.curr_flag then
		WaitingView.instance:hide(self.curr_flag)

		self.curr_flag = nil
	end
end

function ViewPresentor:_onViewResourcesLoaded(loader)
	if ViewName.isBlockWaitingViewOnLoad(self.viewName) == false then
		if enableLog then
			printInfo("ViewPresentor:_onViewResourcesLoaded() - 加载view资源结束,隐藏转菊花界面(WaitingView),viewName=" .. self.viewName)
		end

		self:_hideWaitingView()
	end

	if self._isResLoaded then
		return
	end

	self._isResLoaded = true

	if loader then
		self._resDict = {}

		local resources = loader:getResources()

		for k, v in pairs(resources) do
			self._resDict[k] = v

			v:Retain()
		end

		loader:clear()
	end

	self._resLoader = nil

	if ViewSetting.instance:isModal(self.viewName) or ViewSetting.instance:isFullScreen(self.viewName) then
		self:cutBlockClick()
	end

	self.isBlocking = false

	if not self.mainGO then
		local resList = self:dependWhatResources()

		if resList and #resList > 0 then
			self.mainGO = self:getResInstance(resList[1])
		end
	end

	self:addToParent()

	self._views = self:buildViews()

	if self._views then
		local vCount = #self._views

		for i = 1, vCount do
			local tempView = self._views[i]

			tempView.mainGO = self.mainGO

			tempView:setViewPresentor(self)

			local _isPreLoading = CommonPreloader.instance:isPreLoading()
			local _index = table.indexof(CommonResPath.frequentViewsNotBuildUI, self.viewName)

			if _isPreLoading and _index and not CommonPreloader.instance:isViewPreLoadDone(self.viewName) then
				self._status = ViewPresentor.kViewStatusBuild
			else
				tempView:buildUI()
				tempView:bindEvents()

				tempView.isViewBuilt = true
			end
		end
	end

	if self.mainGO then
		self:hideSelf()
	end

	if self._status ~= ViewPresentor.kViewStatusBuild then
		self._status = ViewPresentor.kViewStatusClose

		if self._opType == ViewPresentor.kViewOpOpen then
			self:_doOpen()
		elseif self._opType == ViewPresentor.kViewOpClose then
			self._opType = ViewPresentor.kViewOpNone
			self._status = ViewPresentor.kViewStatusClose

			if self.priority then
				ViewPriorityMgr.instance:popPriorityViewsList(self)
				ViewPriorityMgr.instance:handleViewsPriority()
			end
		end
	end

	ViewCheck.instance:recordCostTime(self.viewName)

	if self._preCreateCallBack then
		self._preCreateCallBack(self.viewName)
	end
end

function ViewPresentor:addToParent()
	if not goutil.isNil(self.mainGO) then
		local parent = self.parentGO

		if self.parentGO == nil then
			parent = self:getParentNode()
		end

		if goutil.isNil(parent) or self.mainGO.transform.parent ~= parent.transform then
			goutil.addChildToParent(self.mainGO, parent)
			GameUtil.setLocalPos(self.mainGO.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		end
	end
end

function ViewPresentor:showSelf()
	goutil.setActive(self.mainGO, true)
end

function ViewPresentor:hideSelf()
	goutil.setActive(self.mainGO, false)
end

function ViewPresentor:getParentNode()
	local parent = ViewMgr.instance:getCustomViewAttachNode(self.viewName)

	if parent then
		return parent
	end

	return ViewMgr.instance:getRoot(self:attachToWhichRoot())
end

function ViewPresentor:setCurParent(go)
	self.parentGO = go

	self:addToParent()
end

function ViewPresentor:_onViewClosed(presentor)
	if self.parentPresentor == presentor then
		self.parentPresentor = nil

		UIStateManager.instance:popByName(self.viewName)
	end
end

function ViewPresentor:getResInstance(path)
	local res = self._resDict[path]

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			local go_instance_start_time = os.clock()
			local go = goutil.clone(prefab)
			local instance_time, _ = math.modf((os.clock() - go_instance_start_time) * 1000)

			if self.viewName then
				ViewCheck.instance:recordInstanceTime(self.viewName, instance_time)
			end

			if go then
				CameraRectSetter.CalcRect(go)
			end

			return go
		end
	end

	return nil
end

function ViewPresentor:getTempResources()
	return
end

function ViewPresentor:_loadTempResources()
	self:_unloadTempResources()

	local resources = self:getTempResources()

	if not resources or #resources == 0 then
		self:_onTempResourcesLoaded()
	else
		self._tempResLoader = MultiResLoader.New()

		self._tempResLoader:setResPaths(resources)
		self._tempResLoader:load(self._onTempResourcesLoaded, nil, self)
	end
end

function ViewPresentor:_unloadTempResources()
	if self._tempResLoader then
		GameUtil.unloadMultiResLoaderResource(self._tempResLoader, true)

		self._tempResLoader = nil
	end
end

function ViewPresentor:_onTempResourcesLoaded()
	self.mainGO.transform:SetAsLastSibling()
	self:showSelf()
	self:_onVisualEvent(ViewPresentor.kOnEnter)
	self:_adjustGrayGO()
	self:playEnterAnimation()

	if self.priority then
		ViewPriorityMgr.instance:handleViewsPriority()
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnViewOpen, self)
	GlobalModel.instance:checkShowGrayMask()
end

function ViewPresentor:destroy()
	ViewMgr.instance:closeDynCloseList(self.viewName)
	self:_hideWaitingView()

	if self._views then
		local vCount = #self._views

		for i = 1, vCount do
			if self._views[i].isViewBuilt then
				self._views[i].isViewBuilt = nil

				self._views[i]:unbindEvents()
				self._views[i]:destroyUI()
			end
		end
	end

	if self._resDict then
		for k, v in pairs(self._resDict) do
			v:Release()
		end

		self._resDict = nil
	end

	if self._resLoader then
		self._resLoader:clear()

		self._resLoader = nil
	end

	if self.isBlocking == true then
		self:cutBlockClick()

		self.isBlocking = false
	end

	CommonPreloader.instance:setPreCreateFrequentViewsDone(self.viewName)
	goutil.destroy(self.mainGO)

	if self._views then
		local vCount = #self._views

		for i = 1, vCount do
			local view = self._views[i]

			for k, v in pairs(view) do
				view[k] = nil
			end

			self._views[i] = nil
		end
	end
end

function BaseAgent:_initDispatcher(extId)
	return
end

function BaseAgent:getDispatcher()
	return GlobalDispatcher
end

function BaseAgent:addEventOnce(eventName, handler, handlerObj, errHandler)
	local func

	function func(status, msg)
		self:rmEvent(eventName, func)

		if status == 0 then
			if handler ~= nil then
				if handlerObj ~= nil then
					handler(handlerObj, msg, status)
				else
					handler(msg, status)
				end
			end
		elseif errHandler ~= nil then
			if handlerObj ~= nil then
				errHandler(handlerObj, msg, status)
			else
				errHandler(msg, status)
			end
		end
	end

	self.eventPool = self.eventPool or {}

	if self.eventPool[eventName] then
		self:rmEvent(eventName, self.eventPool[eventName])
	end

	self.eventPool[eventName] = func

	self:addListener(eventName, func)

	return func
end

function BaseAgent:addHandler(eventName, sucHandler, handlerObj, errHandler)
	local function func(status, msg)
		if status == 0 then
			if handlerObj then
				GameUtil.callBack(sucHandler, handlerObj, msg, status)
			else
				GameUtil.callBack(sucHandler, msg, status)
			end
		elseif errHandler ~= nil then
			if handlerObj then
				GameUtil.callBack(errHandler, handlerObj, msg, status)
			else
				GameUtil.callBack(errHandler, msg, status)
			end
		end
	end

	self:addListener(eventName, func)

	return func
end

function BaseAgent:removeHandler(eventName, func)
	self:rmEvent(eventName, func)
end

function BaseAgent:checkChangeSet(msg)
	return (BaseAgent.tryGetChangeSetId(msg))
end

function BaseAgent:setShowChangeSetFunc(func)
	self.showFunc = func
end

function BaseAgent:showChangeSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		print(">>>>>>>>>物品准备弹出：找到下发 changeSetId =", changeSetId, msgName, self.showFunc)

		if self.showFunc == nil then
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		else
			GameUtil.callBack(self.showFunc, changeSetId, msgName)
		end
	end
end

BaseAgent.ChangeSetId = "changeSetId"

function BaseAgent.tryGetChangeSetId(pbMsg)
	local changeSetId = -1

	if pbMsg ~= nil and type(pbMsg) == "table" then
		if pbMsg._fields ~= nil and _G.next(pbMsg._fields) ~= nil then
			for k, v in pairs(pbMsg._fields) do
				if k.name == BaseAgent.ChangeSetId then
					return checknumber(v)
				elseif not v or type(v) ~= "table" then
					-- block empty
				else
					changeSetId = BaseAgent.tryGetChangeSetId(v)

					if changeSetId > -1 then
						return changeSetId
					end
				end
			end
		else
			for k, v in ipairs(pbMsg) do
				if not v or type(v) ~= "table" then
					-- block empty
				else
					changeSetId = BaseAgent.tryGetChangeSetId(v)

					if changeSetId > -1 then
						return changeSetId
					end
				end
			end
		end
	end

	return -1
end

function BaseAgent:rmEvent(notifyName, handler, handlerObj, isRemoveAllHandler)
	self:getDispatcher():removeListener(notifyName, handler, handlerObj, isRemoveAllHandler)

	if self.eventPool then
		self.eventPool[notifyName] = nil
	end
end

function BaseAgent:addListener(notifyName, handler, handlerObj, priority)
	self:getDispatcher():addListener(notifyName, handler, handlerObj, priority)
end

function BaseAgent:dispatch(notifyName, ...)
	self:getDispatcher():dispatch(notifyName, ...)
end

function BaseAgent:reset()
	if self.eventPool then
		for notifyName, func in pairs(self.eventPool) do
			self:rmEvent(notifyName, func)
		end
	end

	self.eventPool = nil
end

function ViewMgr:setDynCloseList(childName, parentName)
	self.dynCloseList = self.dynCloseList or {}
	self.dynCloseList[childName] = parentName
end

function ViewMgr:getDyParent(childName)
	if self.dynCloseList then
		return self.dynCloseList[childName]
	end

	return nil
end

function ViewMgr:closeDynCloseList(parentName)
	local tem

	if self.dynCloseList then
		for k, v in pairs(self.dynCloseList) do
			if v == parentName then
				tem = tem or {}

				table.insert(tem, k)
				self:close(k)
			end
		end

		if tem then
			for i, childName in ipairs(tem) do
				self.dynCloseList[childName] = nil
			end
		end
	end

	return tem
end

local viewmgrClose = ViewMgr.close

function ViewMgr:close(name, backMode)
	if enableDebug then
		local debugStr = debug.traceback("", 2)
		local len = #debugStr

		if len > 370 then
			debugStr = "</color>" .. debugStr
		end

		print("<color='#00ffff'>>>>>###关闭</color>", name, debugStr)
	end

	self:closeDynCloseList(name)
	viewmgrClose(self, name, backMode)
end

local viewmgrOpen = ViewMgr.open

function ViewMgr:open(name, ...)
	if enableDebug then
		local debugStr = debug.traceback("", 2)
		local len = #debugStr

		if len > 370 then
			debugStr = "</color>" .. debugStr
		end

		print("<color='#ff00ff'>>>>>###打开</color>", name, debugStr)
	end

	local presentorName = ViewSetting.instance:getPresentorName(name)

	if presentorName then
		ViewCheck.instance:recordStartTime(name)
		viewmgrOpen(self, name, ...)

		local presentor = self._views[name]

		if presentor._status == ViewPresentor.kViewStatusIniting or presentor._status == ViewPresentor.kViewStatusOpening or presentor._status == ViewPresentor.kViewStatusOpen then
			GlobalDispatcher:dispatch(GlobalNotify.OnViewOpenStart, presentor)
		end

		return presentor
	else
		printError(">>>>>>> 打开界面错误，不存在界面名：", name)

		return nil
	end
end

function ViewMgr:openAt(parentGo, name, parentPresentor, ...)
	local presentorName = ViewSetting.instance:getPresentorName(name)

	if presentorName then
		UIStateManager.instance:popByName(name)
		self:registerNotifyView(name)

		if parentPresentor then
			ViewMgr.instance:setDynCloseList(name, parentPresentor.viewName)
		end

		self:markViewParentPresentor(name, parentPresentor)

		local presentor = self:open(name, ...)

		if presentor then
			presentor:setCurParent(parentGo)
		end

		return presentor
	else
		printError(">>>>>>> 打开界面错误，不存在界面名：", name)

		return nil
	end
end

function ViewMgr:markViewParentPresentor(name, parentPresentor)
	self.markParentMap = self.markParentMap or {}
	self.markParentMap[name] = parentPresentor
end

function ViewMgr:getAndClearViewParentPresentor(name)
	if self.markParentMap then
		self.markParentMap[name] = nil

		return self.markParentMap[name]
	end

	return nil
end

function ViewMgr:setPermanent(name, prmanent)
	if prmanent then
		self._pernamentUIs = self._pernamentUIs or {}
		self._pernamentUIs[name] = true
	elseif self._pernamentUIs then
		self._pernamentUIs[name] = nil
	end
end

function ViewMgr:isPermanent(name)
	if not self._pernamentUIs then
		return
	end

	return self._pernamentUIs[name]
end

function ViewMgr:closeAllViews()
	local temp = {}

	for k, v in pairs(self._curOpenViews) do
		if not self:isPermanent(k) then
			temp[k] = v
		end
	end

	for k, v in pairs(temp) do
		self:close(k)
	end

	temp = nil
	self.markParentMap = nil
end

function ViewMgr:setCustomViewAttachNode(viewName, node)
	self._customAttachRootNodes = self._customAttachRootNodes or {}
	self._customAttachRootNodes[viewName] = node

	local presentor = self._views[viewName]

	if presentor and not goutil.isNil(presentor.mainGO) then
		presentor:addToParent()
	end
end

function ViewMgr:getCustomViewAttachNode(viewName)
	printInfo("======ViewMgr:getCustomViewAttachNode====" .. viewName)

	if not self._customAttachRootNodes then
		return
	end

	return self._customAttachRootNodes[viewName]
end

function ViewMgr:setIngorePriority(viewName, ingore)
	self._ingorePriorityViews = self._ingorePriorityViews or {}
	self._ingorePriorityViews[viewName] = ingore
end

function ViewMgr:isIngorePriority(viewName)
	if not self._ingorePriorityViews then
		return
	end

	return self._ingorePriorityViews[viewName]
end

function ViewMgr:onClickGrayMask()
	if self._grayMaskGO.activeSelf then
		local parent = self._grayMaskGO.transform.parent
		local sibIdx = self._grayMaskGO.transform:GetSiblingIndex()
		local cnt = #self._curOpenModalViews

		for i = cnt, 1, -1 do
			local viewName = self._curOpenModalViews[i]
			local view = self._views[viewName]

			if ViewSetting.instance:isModal(viewName) and self:isOpen(viewName) and view.mainGO and view.mainGO.activeSelf then
				local goParent = view.mainGO.transform.parent
				local goSib = view.mainGO.transform:GetSiblingIndex()

				if goParent == parent and sibIdx == goSib - 1 then
					view:onClickOutside()

					break
				end
			end
		end
	end
end

function ViewMgr:registerNotifyView(viewName)
	self._notifyViews = self._notifyViews or {}
	self._notifyViews[viewName] = true
end

function ViewMgr:isNotifyView(viewName)
	if self._notifyViews then
		return self._notifyViews[viewName]
	end
end

function ViewMgr:getViewPresentor(name)
	if not name then
		return
	end

	return self._views[name]
end

local ViewMgr_Destroy = ViewMgr.destroy

function ViewMgr:destroy(name)
	GlobalDispatcher:dispatch(GlobalNotify.OnViewDestroy, name)
	ViewMgr_Destroy(self, name)
	GlobalDispatcher:dispatch(GlobalNotify.OnViewDestroyFinished, name)
end

function ExtensionMgr:_handleMsg(extId, cmd, status, structName, msg)
	GMController.instance:handleMsg(extId, cmd, structName, msg, status)
	MissionMsgBlockController.instance:tryUnBlockMsg(extId, cmd, status)

	local agents = self:getAgents(extId)

	if agents then
		local handler
		local count = #agents

		for i = 1, count do
			local msgName = "handle" .. structName

			handler = agents[i][msgName]

			if agents[i][msgName] then
				local ci = -1
				local csFunc = agents[i].checkChangeSet

				if csFunc ~= nil then
					ci = GameUtil.callBack(csFunc, agents[i], msg)

					if ci ~= nil and ci >= 0 then
						MaterialController.instance:setChangeSetByExtId(ci, extId, cmd)
					end
				end

				trycall(handler, agents[i], status, msg)

				local showFunc = agents[i].showChangeSet

				if showFunc ~= nil then
					trycall(showFunc, agents[i], ci, msgName)
				end

				break
			end
		end

		if not handler then
			printWarn("No handler for proto structName=" .. structName)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandleMsgExtension, extId, cmd, status)
end

function NetConnMgr:sendMsg(msg, connType)
	local structName = msg._cname
	local extCmd = self._requestExtAndCmdMap[structName]

	if extCmd then
		connType = connType or ConnectionType.Logic

		local data = msg:SerializeToString()

		if (self._msgSendFilter or nil) and (self._msgSendFilterObj and self._msgSendFilter(self._msgSendFilterObj, extCmd[1], extCmd[2], data, connType) or self._msgSendFilter(extCmd[1], extCmd[2], data, connType)) then
			if enableLog and not self:isIgnored(extCmd[1], extCmd[2]) then
				local dumpStr = self:_dumpMsg(msg)

				printInfo(string.format("--->SendMsg,structName = %s, msg=%s", structName, dumpStr))
				GMController.instance:sendMsg(extCmd[1], extCmd[2], structName, msg)
			end

			self._socketMgr:SendProtoMsg(extCmd[1], extCmd[2], data, connType)
			MissionMsgBlockController.instance:tryBlockMsg(extCmd[1], extCmd[2])
		end
	else
		printError(LogTag.NETWORK, "Cannot find extId and cmd for structName=" .. structName)
	end
end

function string.trim(input)
	return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end

local _grayScale = 0.3

local function _grayOutlineImpl(go, map)
	if go == nil or goutil.isNil(go) then
		return
	end

	local text = go:GetComponent(goutil.Type_UIText)

	if text then
		local outlineEx = go:GetComponent(ComponentType.OutlineEx)

		if outlineEx then
			local id = go:GetInstanceID()

			map[id] = map[id] or {
				textR = text.color.r,
				textG = text.color.g,
				textB = text.color.b,
				textA = text.color.a,
				outlineR = outlineEx.OutlineColor.r,
				outlineG = outlineEx.OutlineColor.g,
				outlineB = outlineEx.OutlineColor.b,
				outlineA = outlineEx.OutlineColor.a
			}

			local saved = map[id]
			local textGray = (saved.textR + saved.textG + saved.textB) / 3 * _grayScale
			local outlineGray = (saved.outlineR + saved.outlineG + saved.outlineB) / 3 * _grayScale

			Game.TextUtil.SetColorRGBA(text, textGray, textGray, textGray, saved.textA)
			outlineEx:SetColorRGBA(outlineGray, outlineGray, outlineGray, saved.outlineA)

			return
		end
	end

	local childCount = go.transform.childCount

	for i = 0, childCount - 1 do
		_grayOutlineImpl(go.transform:GetChild(i).gameObject, map)
	end
end

local function _restoreOutlineImpl(go, map)
	if go == nil or goutil.isNil(go) then
		return
	end

	local id = go:GetInstanceID()
	local saved = map[id]

	if saved then
		local text = go:GetComponent(goutil.Type_UIText)

		if text then
			Game.TextUtil.SetColorRGBA(text, saved.textR, saved.textG, saved.textB, saved.textA)

			local outlineEx = go:GetComponent(ComponentType.OutlineEx)

			if outlineEx then
				outlineEx:SetColorRGBA(saved.outlineR, saved.outlineG, saved.outlineB, saved.outlineA)
			end
		end

		map[id] = nil

		return
	end

	local childCount = go.transform.childCount

	for i = 0, childCount - 1 do
		_restoreOutlineImpl(go.transform:GetChild(i).gameObject, map)
	end
end

function ViewComponent:SetGray(go, isGray)
	if goutil.isNil(go) then
		return
	end

	self._grayOutlineMap = self._grayOutlineMap or {}

	GameUtil.SetGray(go, isGray)

	if isGray then
		_grayOutlineImpl(go, self._grayOutlineMap)
	else
		_restoreOutlineImpl(go, self._grayOutlineMap)
	end
end

return {}
