-- chunkname: @modules/logic/dungeon/view/map/DungeonMapSceneElements.lua

module("modules.logic.dungeon.view.map.DungeonMapSceneElements", package.seeall)

local DungeonMapSceneElements = class("DungeonMapSceneElements", BaseView)

function DungeonMapSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapSceneElements:addEvents()
	return
end

function DungeonMapSceneElements:removeEvents()
	return
end

function DungeonMapSceneElements:_editableInitView()
	self._elementList = self:getUserDataTb_()
	self._arrowList = self:getUserDataTb_()

	self:_initClick()
end

function DungeonMapSceneElements:_initClick()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self._click:AddClickDownListener(self._clickDownHandler, self)
	self._click:AddClickUpListener(self._clickUp, self)
end

function DungeonMapSceneElements:setElementDown(item)
	if not gohelper.isNil(self._mapScene._uiGo) then
		return
	end

	self._elementMouseDown = item
end

function DungeonMapSceneElements:_clickDownHandler()
	self._clickDown = true
end

function DungeonMapSceneElements:_clickUp()
	local element = self._elementMouseDown

	self._elementMouseDown = nil

	if self._clickDown and element and element:isValid() then
		element:onClick()
	end
end

function DungeonMapSceneElements:_setClickDown()
	self._clickDown = false
end

function DungeonMapSceneElements:_updateElementArrow()
	for k, v in pairs(self._elementList) do
		self:_updateArrow(v)
	end
end

function DungeonMapSceneElements:_updateArrow(elementComp)
	if not elementComp:showArrow() then
		return
	end

	local t = elementComp._transform
	local camera = CameraMgr.instance:getMainCamera()
	local pos = camera:WorldToViewportPoint(t.position)
	local x = pos.x
	local y = pos.y
	local isShow = x >= 0 and x <= 1 and y >= 0 and y <= 1
	local arrowItem = self._arrowList[elementComp:getElementId()]

	if not arrowItem then
		return
	end

	gohelper.setActive(arrowItem.go, not isShow)

	if isShow then
		return
	end

	local viewportX = math.max(0.02, math.min(x, 0.98))
	local viewportY = math.max(0.035, math.min(y, 0.965))
	local width = recthelper.getWidth(self._goarrow.transform)
	local height = recthelper.getHeight(self._goarrow.transform)

	recthelper.setAnchor(arrowItem.go.transform, width * (viewportX - 0.5), height * (viewportY - 0.5))

	local initRotation = arrowItem.initRotation

	if x >= 0 and x <= 1 then
		if y < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 180)

			return
		elseif y > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 0)

			return
		end
	end

	if y >= 0 and y <= 1 then
		if x < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 270)

			return
		elseif x > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 90)

			return
		end
	end

	local angle = 90 - Mathf.Atan2(y, x) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], angle)
end

function DungeonMapSceneElements:_changeMap()
	self:_stopShowSequence()
end

function DungeonMapSceneElements:_loadSceneFinish(param)
	self._mapCfg = param[1]
	self._sceneGo = param[2]
	self._mapScene = param[3]
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)
end

function DungeonMapSceneElements:_disposeScene()
	for k, v in pairs(self._elementList) do
		v:onDestroy()
	end

	self._elementList = self:getUserDataTb_()
	self._elementRoot = nil

	self:_stopShowSequence()
end

function DungeonMapSceneElements:onDisposeOldMap(viewName)
	if self.viewName == viewName then
		self:_disposeOldMap()
	end
end

function DungeonMapSceneElements:_disposeOldMap()
	for k, v in pairs(self._elementList) do
		v:onDestroy()
	end

	self._elementList = self:getUserDataTb_()

	for k, v in pairs(self._arrowList) do
		v.arrowClick:RemoveClickListener()
		gohelper.destroy(v.go)
	end

	self._arrowList = self:getUserDataTb_()

	self:_stopShowSequence()
end

function DungeonMapSceneElements:_initElements()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipInitElement) then
		return
	end

	self:_checkSkipShowElementAnim()
	self:_showElements(self._mapCfg.id)

	self._skipShowElementAnim = false
end

function DungeonMapSceneElements:_checkSkipShowElementAnim()
	self._skipShowElementAnim = GuideModel.instance:isDoingClickGuide() or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowElementAnim)
end

function DungeonMapSceneElements:_showElements(mapId)
	if gohelper.isNil(self._sceneGo) or self._lockShowElementAnim then
		return
	end

	local elementsList = self:_getElements(mapId)
	local newElements = DungeonMapModel.instance:getNewElements()
	local animElements = {}
	local normalElements = {}

	for i, config in ipairs(elementsList) do
		if config.showCamera == 1 and not self._skipShowElementAnim and (newElements and tabletool.indexOf(newElements, config.id) or self._forceShowElementAnim) then
			table.insert(animElements, config.id)
		else
			table.insert(normalElements, config)
		end
	end

	self:_showElementAnim(animElements, normalElements)
	DungeonMapModel.instance:clearNewElements()
end

function DungeonMapSceneElements:_getElements(mapId)
	return DungeonMapModel.instance:getElements(mapId)
end

function DungeonMapSceneElements:_showElement(mapId, elementId)
	if gohelper.isNil(self._sceneGo) or self._lockShowElementAnim then
		return
	end

	local elementsList = self:_getElements(mapId)
	local newElements = DungeonMapModel.instance:getNewElements()
	local animElements = {}

	for i, config in ipairs(elementsList) do
		if config.showCamera == 1 and not self._skipShowElementAnim and elementId == config.id then
			animElements[1] = config.id

			break
		end
	end

	if #animElements > 0 then
		local normalElements = {}

		self:_showElementAnim(animElements, normalElements)
		DungeonMapModel.instance:clearNewElements()
	end
end

function DungeonMapSceneElements:_addElement(elementConfig)
	if self._elementList[elementConfig.id] then
		return
	end

	local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

	gohelper.addChild(self._elementRoot, go)

	local elementComp = MonoHelper.addLuaComOnceToGo(go, DungeonMapElement, {
		elementConfig,
		self._mapScene,
		self
	})

	self._elementList[elementConfig.id] = elementComp

	if elementComp:showArrow() then
		local itemPath = self.viewContainer:getSetting().otherRes[5]
		local itemGo = self:getResInst(itemPath, self._goarrow)
		local rotationGo = gohelper.findChild(itemGo, "mesh")
		local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
		local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

		arrowClick:AddClickListener(self._arrowClick, self, elementConfig.id)

		self._arrowList[elementConfig.id] = {
			go = itemGo,
			rotationTrans = rotationGo.transform,
			initRotation = {
				rx,
				ry,
				rz
			},
			arrowClick = arrowClick
		}

		self:_updateArrow(elementComp)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementAdd, elementConfig.id)
end

function DungeonMapSceneElements:_arrowClick(id)
	self._elementMouseDown = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	self:_focusElementById(id)
end

function DungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementList[id]

	if elementComp then
		elementComp:setFinish()
	end

	self._elementList[id] = nil

	local arrowItem = self._arrowList[id]

	if arrowItem then
		arrowItem.arrowClick:RemoveClickListener()

		self._arrowList[id] = nil

		gohelper.destroy(arrowItem.go)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementRemove, id)
end

function DungeonMapSceneElements:getElementComp(id)
	return self._elementList[id]
end

function DungeonMapSceneElements:onOpen()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self._onGamepadKeyDown, self)
	end

	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnNormalDungeonInitElements, self._initElements, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self._disposeScene, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self._loadSceneFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, self._updateElementArrow, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnSetClickDown, self._setClickDown, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self._beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self._endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideShowElementAnim, self._guideShowElementAnim, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideStopShowElementAnim, self._guideStopShowElementAnim, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideStartShowElementAnim, self._guideStartShowElementAnim, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideShowSingleElementAnim, self._guideShowSingleElementAnim, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnClickElement, self.clickElement, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, self._checkActElement, self)
end

function DungeonMapSceneElements:_onGamepadKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
		local maxIndex = allRaycastHit.Length - 1

		for i = 0, maxIndex do
			local hitInfo = allRaycastHit[i]
			local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, DungeonMapElement)

			if comp == nil then
				comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, DungeonMapFinishElement)
			end

			if comp then
				comp:onDown()

				return
			end
		end
	end
end

function DungeonMapSceneElements:clickElement(id)
	if self:_isShowElementAnim() then
		return
	end

	local mapElement = self._elementList[tonumber(id)]

	if not mapElement then
		return
	end

	local config = mapElement._config

	self:_focusElementById(config.id)

	if config.type == DungeonEnum.ElementType.UnlockEpisode then
		local list = string.splitToNumber(config.param, "#")

		for i, id in ipairs(list) do
			local element = DungeonMapModel.instance:getElementById(id)

			if element then
				return
			end
		end

		DungeonRpc.instance:sendMapElementRequest(config.id)
	elseif config.type == DungeonEnum.ElementType.UnLockExplore then
		local guideMO = GuideModel.instance:getById(14500)

		if not guideMO then
			logError("密室解锁指引没有接取！！")
		end

		if guideMO and guideMO.isFinish or not guideMO and GuideController.instance:isForbidGuides() then
			DungeonRpc.instance:sendMapElementRequest(config.id)

			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnClickExploreElement)
	elseif config.type == DungeonEnum.ElementType.BossStory then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		if not DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) then
			VersionActivity2_8DungeonBossController.instance:openVersionActivity2_8BossStoryEnterView()
		else
			logError("boss剧情已经通关了")
		end
	elseif config.type == DungeonEnum.ElementType.ToughBattle then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		ToughBattleModel.instance:setIsJumpActElement(false)

		local actId = tonumber(config.param) or 0

		if actId == 0 then
			if ToughBattleModel.instance:isStoryFinish() then
				DungeonRpc.instance:sendMapElementRequest(config.id, nil, function(cmd, resultCode, msg)
					if resultCode ~= 0 then
						return
					end

					DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
				end)
			else
				local info = ToughBattleModel.instance:getStoryInfo()

				if info.openChallenge then
					ViewMgr.instance:openView(ViewName.ToughBattleMapView, {
						mode = ToughBattleEnum.Mode.Story
					})
				else
					ViewMgr.instance:openView(ViewName.ToughBattleEnterView, {
						mode = ToughBattleEnum.Mode.Story
					})
				end
			end
		else
			Activity158Rpc.instance:sendGet158InfosRequest(actId, self.onRecvToughInfo, self)
		end

		return
	elseif config.type == DungeonEnum.ElementType.HeroInvitation then
		local storyId = tonumber(config.param)

		StoryController.instance:playStory(storyId, nil, function()
			DungeonRpc.instance:sendMapElementRequest(config.id)
		end)
	elseif config.type == DungeonEnum.ElementType.Investigate then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		DungeonRpc.instance:sendMapElementRequest(config.id)
	elseif config.type == DungeonEnum.ElementType.FairyLand then
		FairyLandController.instance:openFairyLandView()
	else
		local item = self._mapScene:getInteractiveItem()

		item:_OnClickElement(mapElement)
	end
end

function DungeonMapSceneElements:onRecvToughInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local info = ToughBattleModel.instance:getActInfo()

		if info.openChallenge then
			ViewMgr.instance:openView(ViewName.ToughBattleActMapView, {
				mode = ToughBattleEnum.Mode.Act
			})
		else
			ViewMgr.instance:openView(ViewName.ToughBattleActEnterView, {
				mode = ToughBattleEnum.Mode.Act
			})
		end
	end
end

function DungeonMapSceneElements:_checkActElement()
	if not self._mapCfg or ToughBattleEnum.MapId_7_30 ~= self._mapCfg.id then
		return
	end

	if ToughBattleModel.instance:getActIsOnline() then
		if not self._elementList[ToughBattleEnum.ActElementId] then
			self:_addElementById(ToughBattleEnum.ActElementId)
		end
	elseif self._elementList[ToughBattleEnum.ActElementId] then
		self:_removeElement(ToughBattleEnum.ActElementId)
	end
end

function DungeonMapSceneElements:_setEpisodeListVisible(value)
	gohelper.setActive(self._goarrow, value)
end

function DungeonMapSceneElements:_onFinishGuide(guideId)
	if self._lockShowElementAnim and guideId == 129 then
		self._lockShowElementAnim = nil

		GuideModel.instance:clearFlagByGuideId(guideId)
		self:_initElements()
	end
end

function DungeonMapSceneElements:_beginShowRewardView()
	self._showRewardView = true
end

function DungeonMapSceneElements:_endShowRewardView()
	self._showRewardView = false

	if self._needRemoveElementId then
		TaskDispatcher.runDelay(self._removeElementAfterShowReward, self, DungeonEnum.RefreshTimeAfterShowReward)
		TaskDispatcher.runDelay(self._showNewElements, self, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		return
	end

	self:_showNewElements()
end

function DungeonMapSceneElements:_removeElementAfterShowReward()
	local id = self._needRemoveElementId

	self._needRemoveElementId = nil

	self:_removeElement(id)
end

function DungeonMapSceneElements:_guideStartShowElementAnim()
	self._lockShowElementAnim = false
	self._forceShowElementAnim = true

	self:_showElements(self._mapCfg.id)

	self._forceShowElementAnim = false
end

function DungeonMapSceneElements:_guideShowSingleElementAnim(elementIdStr)
	local elementId = tonumber(elementIdStr)

	self._lockShowElementAnim = false
	self._forceShowElementAnim = true

	self:_showElement(self._mapCfg.id, elementId)

	self._forceShowElementAnim = false
	self._forceShowElementId = elementId
end

function DungeonMapSceneElements:_guideShowElementAnim()
	self._lockShowElementAnim = true
end

function DungeonMapSceneElements:_guideStopShowElementAnim()
	if not self:_isShowElementAnim() then
		return
	end

	self:_stopShowSequence()
	self:_initElements()
end

function DungeonMapSceneElements:_OnClickGuidepost()
	if not self._guidepostGo then
		return
	end

	local x, y = transformhelper.getLocalPos(self._guidepostGo.transform)

	x = self._mapMaxX - x + self._viewWidth / 2
	y = self._mapMinY - y - self._viewHeight / 2 + 2

	self:setScenePosSafety(Vector3(x, y, 0), true)
end

function DungeonMapSceneElements:_showNewElements()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipInitElement) then
		return
	end

	local newElements = DungeonMapModel.instance:getNewElements()

	if newElements then
		self:_showElements(self._mapCfg.id)
	end
end

function DungeonMapSceneElements:_focusElementById(id)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, id)
end

function DungeonMapSceneElements:_addElementById(id)
	local config = lua_chapter_map_element.configDict[id]

	self:_addElement(config)
end

function DungeonMapSceneElements._doAddElement(params)
	local self, id = params[1], params[2]

	self:_addElementById(id)

	local elementConfig = lua_chapter_map_element.configDict[id]
	local comp = self._elementList[elementConfig.id]

	if not comp then
		return
	end

	comp:setWenHaoAnim("wenhao_a_001_camerin")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function DungeonMapSceneElements._doFocusElement(params)
	local self, id = params[1], params[2]

	self._tweenTime = 1

	self:_focusElementById(id)

	self._tweenTime = nil
end

function DungeonMapSceneElements._addAnimElementDone(params)
	local self = params[1]
	local normalElements = params[2]

	for i, v in ipairs(normalElements) do
		self:_addElement(v)
	end

	self:_onAddAnimElementDone()
end

function DungeonMapSceneElements:_onAddAnimElementDone()
	for _, element in pairs(self._elementList) do
		element:_onAddAnimDone()
	end

	local elementId = DungeonMapModel.instance:getFocusElementId()

	if elementId then
		DungeonMapModel.instance:setFocusElementId(nil)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, elementId)
	end
end

function DungeonMapSceneElements._doSetInitPos(params)
	DungeonController.instance:dispatchEvent(DungeonEvent.GuideShowElementAnimFinish)
end

function DungeonMapSceneElements:_stopShowSequence()
	if self._showSequence then
		self._showSequence:unregisterDoneListener(self._stopShowSequence, self)
		self._showSequence:destroy()

		self._showSequence = nil

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.UseBlock) then
			UIBlockMgr.instance:endBlock("DungeonMapSceneElements UseBlock")
		end
	end
end

function DungeonMapSceneElements:_showElementAnim(elements, normalElements)
	if not elements or #elements <= 0 then
		DungeonMapSceneElements._addAnimElementDone({
			self,
			normalElements
		})

		return
	end

	self:_stopShowSequence()

	self._showSequence = FlowSequence.New()

	self._showSequence:addWork(TimerWork.New(0.8))
	table.sort(elements)

	for i, id in ipairs(elements) do
		self._showSequence:addWork(FunctionWork.New(DungeonMapSceneElements._doFocusElement, {
			self,
			id
		}))
		self._showSequence:addWork(TimerWork.New(1.2))
		self._showSequence:addWork(FunctionWork.New(DungeonMapSceneElements._doAddElement, {
			self,
			id
		}))
		self._showSequence:addWork(TimerWork.New(1))
	end

	self._showSequence:addWork(TimerWork.New(0.5))
	self._showSequence:addWork(FunctionWork.New(DungeonMapSceneElements._addAnimElementDone, {
		self,
		normalElements
	}))
	self._showSequence:addWork(FunctionWork.New(DungeonMapSceneElements._doSetInitPos, {
		self
	}))
	self._showSequence:registerDoneListener(self._stopShowSequence, self)
	self._showSequence:start()

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.UseBlock) then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DungeonMapSceneElements UseBlock")
	end
end

function DungeonMapSceneElements:_isShowElementAnim()
	return self._showSequence and self._showSequence.status == WorkStatus.Running
end

function DungeonMapSceneElements:_OnRemoveElement(id)
	if not self._showRewardView then
		self:_removeElement(id)
		self:_showNewElements()
	else
		self._needRemoveElementId = id
	end
end

function DungeonMapSceneElements:onClose()
	return
end

function DungeonMapSceneElements:onDestroyView()
	self:_disposeOldMap()
	self._click:RemoveClickDownListener()
	self._click:RemoveClickUpListener()
	DungeonMapModel.instance:clearNewElements()
	TaskDispatcher.cancelTask(self._removeElementAfterShowReward, self)
	TaskDispatcher.cancelTask(self._showNewElements, self)
end

return DungeonMapSceneElements
