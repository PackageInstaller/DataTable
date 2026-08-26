-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131Map.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131Map", package.seeall)

local Activity131Map = class("Activity131Map", BaseView)

function Activity131Map:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131Map:addEvents()
	return
end

function Activity131Map:removeEvents()
	return
end

function Activity131Map:_editableInitView()
	self._elementList = self:getUserDataTb_()
	self._tempVector = Vector3()
	self._sceneIndex = 1
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self:_initMap()
	self:_addEvents()
end

function Activity131Map:_initMap()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Activity131Map")

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0.5, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)

	local mainUrls = string.split(Activity131Model.instance:getCurMapConfig().scenes, "#")
	local interactiveItemUrl = "ui/viewres/versionactivity_1_4/v1a4_6role/v1a4_role6_mapinteractiveitem.prefab"

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

		local episodeId = Activity131Model.instance:getCurEpisodeId()
		local curSceneIndex = Activity131Model.instance:getEpisodeCurSceneIndex(episodeId)

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

function Activity131Map:_initElements()
	self:_showElements()
end

function Activity131Map:_checkInitElements()
	if not self._sceneLoaded then
		self._needCheckInit = true

		return
	end

	self._needCheckInit = false

	local curMapInfo = Activity131Model.instance:getCurMapInfo()
	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local episodeId = Activity131Model.instance:getCurEpisodeId()

	if curMapInfo.progress == Activity131Enum.ProgressType.AfterStory then
		Activity131Controller.instance:dispatchEvent(Activity131Event.ShowFinish)

		return
	end

	local episodeCo = Activity131Config.instance:getActivity131EpisodeCo(actId, episodeId)

	if episodeCo.elements ~= "" then
		local elements = string.splitToNumber(episodeCo.elements, "#")

		for _, v in ipairs(elements) do
			for _, element in pairs(curMapInfo.act131Elements) do
				if element.elementId == v and not element.isFinish then
					self:_clickElement(nil, element)

					return
				end
			end
		end
	end

	for _, elementInfo in pairs(curMapInfo.act131Elements) do
		if not elementInfo.isFinish then
			if #elementInfo.typeList >= elementInfo.index and elementInfo.index ~= 0 then
				self:_clickElement(nil, elementInfo)

				return
			elseif elementInfo.index == 0 and elementInfo.config.res == "" then
				self:_clickElement(nil, elementInfo)

				return
			end
		end
	end
end

function Activity131Map:_clickUp()
	local element = self._elementMouseDown

	self._elementMouseDown = nil

	if element and element:isValid() then
		element:onClick()
	end
end

function Activity131Map:_onGamepadKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
		local maxIndex = allRaycastHit.Length - 1

		for i = 0, maxIndex do
			local hitInfo = allRaycastHit[i]
			local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, Activity131MapElement)

			if comp then
				comp:onDown()

				return
			end
		end
	end
end

function Activity131Map:_onSceneClose()
	return
end

function Activity131Map:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	transformhelper.setLocalRotation(camera.transform, 0, 0, 0)

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.4 * scale
end

function Activity131Map:onOpen()
	self:playAmbientAudio()
	MainCameraMgr.instance:addView(ViewName.Activity131GameView, self._initCamera, nil, self)
end

function Activity131Map:onClose()
	self:_clearElements()
	self:_removeEvents()
	self:closeAmbientSound()
end

function Activity131Map:_clearElements()
	for k, v in pairs(self._elementList) do
		v:dispose(true)
	end

	self._elementList = self:getUserDataTb_()
end

function Activity131Map:_showElements()
	local episodeId = Activity131Model.instance:getCurEpisodeId()
	local elementsList = Activity131Model.instance:getEpisodeElements(episodeId)
	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local resStat = {}

	for i, v in ipairs(elementsList) do
		local resName = Activity131Config.instance:getActivity131ElementCo(actId, v.elementId).res

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
		local resName = Activity131Config.instance:getActivity131ElementCo(actId, info.elementId).res
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
		local resName = Activity131Config.instance:getActivity131ElementCo(actId, info.elementId).res
		local statList = resStat[resName]

		if statList then
			if not #statList then
				local statValue = 0

				self:_addElement(info, statValue <= 1)
			end
		end
	end
end

function Activity131Map:_addElement(elementInfo, fadeIn)
	local elementComp = self._elementList[elementInfo.elementId]

	if elementComp then
		elementComp:updateInfo(elementInfo)

		return
	end

	local episodeId = Activity131Model.instance:getCurEpisodeId()
	local curSceneIndex = Activity131Model.instance:getEpisodeCurSceneIndex(episodeId)
	local go = gohelper.findChild(self._elementRoots[curSceneIndex], tostring(elementInfo.elementId))

	if not go then
		go = UnityEngine.GameObject.New(tostring(elementInfo.elementId))

		gohelper.addChild(self._elementRoots[curSceneIndex], go)
	else
		MonoHelper.removeLuaComFromGo(go, Activity131MapElement)
		gohelper.destroyAllChildren(go)
	end

	elementComp = MonoHelper.addLuaComOnceToGo(go, Activity131MapElement, {
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
end

function Activity131Map:_removeElement(elementInfo, fadeOut)
	local id = elementInfo.elementId
	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	self._elementList[id] = nil

	elementComp:updateInfo(elementInfo)
	elementComp:disappear(fadeOut)
end

function Activity131Map:setElementDown(item)
	if ViewMgr.instance:isOpen(ViewName.Activity131DialogView) then
		return
	end

	self._elementMouseDown = item
end

function Activity131Map:setScenePosSafety(targetPos, tween)
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

function Activity131Map:onUpdateParam()
	return
end

function Activity131Map:_playEnterAnim()
	self._isPlayAnim = true

	self:_onPlayEnterAnim()
end

function Activity131Map:_setInitPos(tween)
	if not self._mapCfg then
		return
	end

	local pos = self._mapCfg.initPos
	local posParam = string.splitToNumber(pos, "#")

	self:setScenePosSafety(Vector3(posParam[1], posParam[2], 0), tween)
end

function Activity131Map:_onShowFinishAnimDone()
	self:_showElements()
end

function Activity131Map:_OnDialogReply(id)
	local elementComp = self._elementList[id]

	if not elementComp then
		return
	end

	self:_OnClickElement(elementComp)
end

function Activity131Map:_OnGuideClickElement(id)
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

function Activity131Map:_OnClickElement(mapElement)
	self:_clickElement(mapElement)
end

function Activity131Map:_clickElement(mapElement, info)
	if mapElement then
		if not mapElement._info then
			local elementInfo = info
			local id = elementInfo.elementId
			local type = elementInfo:getType()

			if type == Activity131Enum.ElementType.Battle then
				Activity131Controller.instance:dispatchEvent(Activity131Event.TriggerBattleElement, elementInfo)
			elseif type == Activity131Enum.ElementType.General then
				local audioId = tonumber(elementInfo.config.param)

				AudioMgr.instance:trigger(audioId)

				local actId = VersionActivity1_4Enum.ActivityId.Role6
				local episodeId = Activity131Model.instance:getCurEpisodeId()

				Activity131Rpc.instance:sendAct131GeneralRequest(actId, episodeId, id)
			elseif type == Activity131Enum.ElementType.Respawn then
				-- block empty
			elseif type == Activity131Enum.ElementType.Dialog then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
				Activity131Controller.instance:openActivity131DialogView(elementInfo)
			elseif type == Activity131Enum.ElementType.TaskTip then
				Activity131Controller.instance:dispatchEvent(Activity131Event.RefreshTaskTip, elementInfo)
			elseif type == Activity131Enum.ElementType.SetValue then
				Activity131Controller.instance:dispatchEvent(Activity131Event.UnlockCollect, elementInfo)
			elseif type == Activity131Enum.ElementType.ChangeScene then
				local index = tonumber(string.split(elementInfo.config.param, "#")[elementInfo.index + 1])

				self:_changeScene(index, elementInfo)
			elseif type == Activity131Enum.ElementType.LogStart or type == Activity131Enum.ElementType.LogEnd then
				Activity131Controller.instance:dispatchEvent(Activity131Event.TriggerLogElement, elementInfo)
			end
		end
	end
end

function Activity131Map:_changeScene(index, elementInfo)
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
		local actId = VersionActivity1_4Enum.ActivityId.Role6
		local episodeId = Activity131Model.instance:getCurEpisodeId()

		Activity131Rpc.instance:sendAct131GeneralRequest(actId, episodeId, elementInfo.elementId, self._onGeneralSuccess, self)
	end
end

function Activity131Map:_onRestartSet()
	self:_clearElements()
	self:_changeScene(1)
	self:_showElements()
end

function Activity131Map:_onGeneralSuccess()
	self:_showElements()
end

function Activity131Map:_addEvents()
	self._click:AddClickUpListener(self._clickUp, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self._onGamepadKeyDown, self)
	end

	self.addEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, self._showElements, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnElementUpdate, self._showElements, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._showElements, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnClickElement, self._OnClickElement, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.AutoStartElement, self._checkInitElements, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._checkInitElements, self)
end

function Activity131Map:_removeEvents()
	if self._click then
		self._click:RemoveClickUpListener()
	end

	if GamepadController.instance:isOpen() then
		self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self._onGamepadKeyDown, self)
	end

	self.removeEventCb(self, MainController.instance, MainEvent.OnSceneClose, self._onSceneClose, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, self._showElements, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnElementUpdate, self._showElements, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._showElements, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnClickElement, self._OnClickElement, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.AutoStartElement, self._checkInitElements, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._checkInitElements, self)
end

function Activity131Map:onDestroyView()
	gohelper.destroy(self._sceneRoot)

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end
end

function Activity131Map:playAmbientAudio()
	self:closeAmbientSound()
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_on)

	self._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.ActivityMapAmbientBgm)
end

function Activity131Map:closeAmbientSound()
	if self._ambientAudioId then
		AudioMgr.instance:stopPlayingID(self._ambientAudioId)
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_activityvol_off)

		self._ambientAudioId = nil
	end
end

return Activity131Map
