-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130Map.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130Map", package.seeall)

local Activity130Map = class("Activity130Map", BaseView)

function Activity130Map:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130Map:addEvents()
	return
end

function Activity130Map:removeEvents()
	return
end

function Activity130Map:_editableInitView()
	self._elementList = self:getUserDataTb_()
	self._tempVector = Vector3()
	self._sceneIndex = 1
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self:_initMap()
	self:_addEvents()
end

function Activity130Map:_initMap()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Activity130Map")

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0.5, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)

	local mainUrls = string.split(Activity130Model.instance:getCurMapConfig().scenes, "#")
	local interactiveItemUrl = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_mapinteractiveitem.prefab"

	self._mapLoader = MultiAbLoader.New()

	for _, mainUrl in ipairs(mainUrls) do
		self._mapLoader:addPath(mainUrl .. ".prefab")
	end

	self._mapLoader:addPath(interactiveItemUrl)
	self._mapLoader:startLoad(function(multiAbLoader)
		self._mainPrefabs = {}
		self._elementRoots = {}

		for _, mainUrl in ipairs(mainUrls) do
			local mainAssetItem = self._mapLoader:getAssetItem(mainUrl .. ".prefab")
			local mainPrefab = mainAssetItem:GetResource(mainUrl .. ".prefab")
			local prefabGo = gohelper.clone(mainPrefab, self._sceneRoot)

			gohelper.setActive(prefabGo, false)
			table.insert(self._mainPrefabs, prefabGo)
		end

		local episodeId = Activity130Model.instance:getCurEpisodeId()
		local curSceneIndex = Activity130Model.instance:getEpisodeCurSceneIndex(episodeId)

		self._sceneGo = self._mainPrefabs[curSceneIndex]

		gohelper.setActive(self._sceneGo, true)

		self._sceneAnimator = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		self._sceneAnimator:Play("open", 0, 0)

		self._backgroundGo = gohelper.findChild(self._sceneGo, "root/BackGround")
		self._diffuseGo = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse")
		self._elementRoots[curSceneIndex] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(self._mainPrefabs[curSceneIndex], self._elementRoots[curSceneIndex])

		self._anim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		local interactAssetItem = self._mapLoader:getAssetItem(interactiveItemUrl)

		self._itemPrefab = interactAssetItem:GetResource(interactiveItemUrl)

		self:_initElements()

		self._sceneLoaded = true

		if self._needCheckInit then
			self:_checkInitElements()

			self._needCheckInit = false
		end
	end)
end

function Activity130Map:_initElements()
	self:_showElements()
end

function Activity130Map:_checkInitElements()
	if not self._sceneLoaded then
		self._needCheckInit = true

		return
	end

	self._needCheckInit = false

	local curMapInfo = Activity130Model.instance:getCurMapInfo()
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	if curMapInfo.progress == Activity130Enum.ProgressType.AfterStory then
		local co = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId)

		if co.afterStoryId > 0 and not StoryModel.instance:isStoryFinished(co.afterStoryId) then
			StoryController.instance:playStory(co.afterStoryId, nil, self._onStoryFinished, self)
		else
			self:_onStoryFinished()
		end

		return
	end

	local episodeCo = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId)

	if episodeCo.elements ~= "" then
		local elements = string.splitToNumber(episodeCo.elements, "#")

		for _, v in ipairs(elements) do
			for _, element in pairs(curMapInfo.act130Elements) do
				if element.elementId == v and not element.isFinish then
					self:_clickElement(nil, element)

					return
				end
			end
		end
	end

	for _, elementInfo in pairs(curMapInfo.act130Elements) do
		if not elementInfo.isFinish then
			if elementInfo:getType() == Activity130Enum.ElementType.CheckDecrypt then
				Activity130Controller.instance:dispatchEvent(Activity130Event.CheckDecrypt, elementInfo)

				return
			elseif #elementInfo.typeList >= elementInfo.index and elementInfo.index ~= 0 then
				self:_clickElement(nil, elementInfo)

				return
			elseif elementInfo.index == 0 and elementInfo.config.res == "" then
				self:_clickElement(nil, elementInfo)

				return
			end
		end
	end
end

function Activity130Map:_onStoryFinished()
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local co = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId)

	if co.afterStoryId > 0 then
		Activity130Rpc.instance:sendAct130StoryRequest(actId, episodeId)
	end

	local maxEpisode = Activity130Model.instance:getMaxUnlockEpisode()

	if episodeId == maxEpisode then
		self:_backToLevelView()
	end
end

function Activity130Map:_clickUp()
	local element = self._elementMouseDown

	self._elementMouseDown = nil

	if element and element:isValid() then
		element:onClick()
	end
end

function Activity130Map:_onGamepadKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
		local maxIndex = allRaycastHit.Length - 1

		for i = 0, maxIndex do
			local hitInfo = allRaycastHit[i]
			local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, Activity130MapElement)

			if comp then
				comp:onDown()

				return
			end
		end
	end
end

function Activity130Map:_onSceneClose()
	return
end

function Activity130Map:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	transformhelper.setLocalRotation(camera.transform, 0, 0, 0)

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.4 * scale
end

function Activity130Map:onOpen()
	self:playAmbientAudio()
	MainCameraMgr.instance:addView(ViewName.Activity130GameView, self._initCamera, nil, self)
end

function Activity130Map:onClose()
	self:_clearElements()
	self:_removeEvents()
	self:closeAmbientSound()
end

function Activity130Map:_clearElements()
	for _, v in pairs(self._elementList) do
		v:dispose()
	end

	self._elementList = self:getUserDataTb_()
end

function Activity130Map:_showElements()
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local elementsList = Activity130Model.instance:getEpisodeElements(episodeId)
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local resStat = {}

	for i, v in ipairs(elementsList) do
		local resName = Activity130Config.instance:getActivity130ElementCo(actId, v.elementId).res

		if not string.nilorempty(resName) then
			if not resStat[resName] then
				local t = {}

				if v:isAvailable() or self._elementList[v.elementId] then
					table.insert(t, v)
				end

				resStat[resName] = t
			end
		end
	end

	local addList = {}

	for i = #elementsList, 1, -1 do
		local info = elementsList[i]
		local resName = Activity130Config.instance:getActivity130ElementCo(actId, info.elementId).res
		local statList = resStat[resName]

		if statList then
			if not #statList then
				local statValue = 0

				if not info:isAvailable() then
					self:_removeElement(info, statValue <= 1)
				else
					table.insert(addList, info)
				end
			end
		end
	end

	for i = #addList, 1, -1 do
		local info = addList[i]
		local resName = Activity130Config.instance:getActivity130ElementCo(actId, info.elementId).res
		local statList = resStat[resName]

		if statList then
			if not #statList then
				local statValue = 0

				self:_addElement(info, statValue <= 1)
			end
		end
	end
end

function Activity130Map:_addElement(elementInfo, fadeIn)
	local elementComp = self._elementList[elementInfo.elementId]

	if elementComp then
		elementComp:updateInfo(elementInfo)

		return
	end

	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local curSceneIndex = Activity130Model.instance:getEpisodeCurSceneIndex(episodeId)
	local go = gohelper.findChild(self._elementRoots[curSceneIndex], tostring(elementInfo.elementId))

	if not go then
		go = UnityEngine.GameObject.New(tostring(elementInfo.elementId))

		gohelper.addChild(self._elementRoots[curSceneIndex], go)
	else
		MonoHelper.removeLuaComFromGo(go, Activity130MapElement)
		gohelper.destroyAllChildren(go)
	end

	elementComp = MonoHelper.addLuaComOnceToGo(go, Activity130MapElement, {
		elementInfo,
		self
	})
	self._elementList[elementInfo.elementId] = elementComp

	local resName = elementComp:getResName()

	if string.nilorempty(resName) then
		return
	end

	local resGo = gohelper.findChild(self._diffuseGo, resName)
	local itemGo

	if not resGo then
		resGo = gohelper.findChild(self._backgroundGo, resName)
		itemGo = resGo
	end

	if not resGo then
		logError(string.format("元件id: %s no resGo:%s", elementInfo.elementId, resName))

		return
	end

	local resGox, resGoy, resGoz = transformhelper.getPos(resGo.transform)

	itemGo = itemGo or gohelper.clone(resGo, go, resName)

	gohelper.setActive(resGo, false)
	transformhelper.setPos(itemGo.transform, resGox, resGoy, resGoz)
	gohelper.setLayer(itemGo, UnityLayer.Scene, true)
	elementComp:setItemGo(itemGo, fadeIn)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnAddElement, elementInfo.elementId)
end

function Activity130Map:_removeElement(elementInfo, fadeOut)
	local id = elementInfo.elementId
	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	self._elementList[id] = nil

	elementComp:updateInfo(elementInfo)
	elementComp:disappear(fadeOut)
end

function Activity130Map:setElementDown(item)
	if ViewMgr.instance:isOpen(ViewName.Activity130DialogView) then
		return
	end

	self._elementMouseDown = item
end

function Activity130Map:setScenePosSafety(targetPos, tween)
	if not self._sceneGo then
		return
	end

	if targetPos.x < self._mapMinX then
		targetPos.x = self._mapMinX
	elseif targetPos.x > self._mapMaxX then
		targetPos.x = self._mapMaxX
	end

	if targetPos.y < self._mapMinY then
		targetPos.y = self._mapMinY
	elseif targetPos.y > self._mapMaxY then
		targetPos.y = self._mapMaxY
	end

	if tween then
		ZProj.TweenHelper.DOLocalMove(self._sceneGo.transform, targetPos.x, targetPos.y, 0, 0.26)
	else
		self._sceneGo.transform.localPosition = targetPos
	end
end

function Activity130Map:onUpdateParam()
	return
end

function Activity130Map:_playEnterAnim()
	self._isPlayAnim = true

	self:_onPlayEnterAnim()
end

function Activity130Map:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function Activity130Map:_onShowFinishAnimDone()
	self:_showElements()
end

function Activity130Map:_OnDialogReply(id)
	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	self:_OnClickElement(elementComp)
end

function Activity130Map:_OnGuideClickElement(id)
	local elementId = tonumber(id)

	if not elementId then
		return
	end

	local elementComp = self._elementList[elementId]

	if not elementComp then
		return
	end

	self:_OnClickElement(elementComp)
end

function Activity130Map:_OnClickElement(mapElement)
	self:_clickElement(mapElement)
end

function Activity130Map:_backToLevelView()
	self:closeThis()
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)
end

function Activity130Map:_clickElement(mapElement, info)
	if mapElement then
		if not mapElement._info then
			local elementInfo = info
			local id = elementInfo.elementId
			local type = elementInfo:getType()

			if type == Activity130Enum.ElementType.Battle then
				-- block empty
			elseif type == Activity130Enum.ElementType.General then
				local audioId = tonumber(elementInfo.config.param)

				AudioMgr.instance:trigger(audioId)

				local actId = VersionActivity1_4Enum.ActivityId.Role37
				local episodeId = Activity130Model.instance:getCurEpisodeId()

				Activity130Rpc.instance:sendAct130GeneralRequest(actId, episodeId, id)
			elseif type == Activity130Enum.ElementType.Respawn then
				-- block empty
			elseif type == Activity130Enum.ElementType.Dialog then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)

				local data = {}

				data.elementInfo = elementInfo
				data.isClient = false

				Activity130Controller.instance:openActivity130DialogView(data)
			elseif type == Activity130Enum.ElementType.TaskTip then
				Activity130Controller.instance:dispatchEvent(Activity130Event.RefreshTaskTip, elementInfo)
			elseif type == Activity130Enum.ElementType.SetValue then
				Activity130Controller.instance:dispatchEvent(Activity130Event.UnlockCollect, elementInfo)
			elseif type == Activity130Enum.ElementType.UnlockDecrypt then
				Activity130Controller.instance:dispatchEvent(Activity130Event.UnlockDecrypt, elementInfo)
			elseif type == Activity130Enum.ElementType.CheckDecrypt then
				Activity130Controller.instance:dispatchEvent(Activity130Event.CheckDecrypt, elementInfo)
			elseif type == Activity130Enum.ElementType.ChangeScene then
				local index = tonumber(string.split(elementInfo.config.param, "#")[elementInfo.index + 1])

				self:_changeScene(index, elementInfo)
			end
		end
	end
end

function Activity130Map:_changeScene(index, elementInfo)
	if not self._mainPrefabs[index] then
		logError("配置了一个不存在的场景标记！请检查配置")

		return
	end

	gohelper.setActive(self._sceneGo, false)

	self._sceneGo = self._mainPrefabs[index]

	gohelper.setActive(self._sceneGo, true)

	self._backgroundGo = gohelper.findChild(self._sceneGo, "root/BackGround")
	self._diffuseGo = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse")

	if not self._elementRoots[index] then
		self._elementRoots[index] = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(self._sceneGo, self._elementRoots[index])
	end

	self._anim = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	if elementInfo and elementInfo.elementId then
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local episodeId = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130GeneralRequest(actId, episodeId, elementInfo.elementId, self._onGeneralSuccess, self)
	end
end

function Activity130Map:_onRestartSet()
	self:_clearElements()
	self:_changeScene(1)
	self:_showElements()
end

function Activity130Map:_onGeneralSuccess(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	self:_showElements()
end

function Activity130Map:_addEvents()
	self._click:AddClickUpListener(self._clickUp, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self._onGamepadKeyDown, self)
	end

	self.addEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, self._showElements, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnElementUpdate, self._showElements, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._showElements, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnClickElement, self._OnClickElement, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.AutoStartElement, self._checkInitElements, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._checkInitElements, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.NewEpisodeUnlock, self._backToLevelView, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.GuideClickElement, self._OnGuideClickElement, self)
end

function Activity130Map:_removeEvents()
	if self._click then
		self._click:RemoveClickUpListener()
	end

	if GamepadController.instance:isOpen() then
		self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self._onGamepadKeyDown, self)
	end

	self.removeEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, self._showElements, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnElementUpdate, self._showElements, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._showElements, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnClickElement, self._OnClickElement, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.AutoStartElement, self._checkInitElements, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._checkInitElements, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.NewEpisodeUnlock, self._backToLevelView, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.GuideClickElement, self._OnGuideClickElement, self)
end

function Activity130Map:onDestroyView()
	gohelper.destroy(self._sceneRoot)

	if self._mapLoader then
		self._mapLoader:dispose()
	end
end

function Activity130Map:playAmbientAudio()
	self:closeAmbientSound()
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_on)

	self._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.ActivityMapAmbientBgm)
end

function Activity130Map:closeAmbientSound()
	if self._ambientAudioId then
		AudioMgr.instance:stopPlayingID(self._ambientAudioId)
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_off)

		self._ambientAudioId = nil
	end
end

return Activity130Map
