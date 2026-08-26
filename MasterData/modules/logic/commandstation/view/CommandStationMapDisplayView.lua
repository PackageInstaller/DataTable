-- chunkname: @modules/logic/commandstation/view/CommandStationMapDisplayView.lua

module("modules.logic.commandstation.view.CommandStationMapDisplayView", package.seeall)

local CommandStationMapDisplayView = class("CommandStationMapDisplayView", BaseView)

function CommandStationMapDisplayView:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "map/#go_map")
	self._goevents = gohelper.findChild(self.viewGO, "map/#go_events")
	self._gomaptag = gohelper.findChild(self.viewGO, "#go_maptag")
	self._txttag = gohelper.findChildText(self.viewGO, "#go_maptag/#txt_tag")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapDisplayView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CommandStationMapDisplayView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CommandStationMapDisplayView:_btncloseOnClick()
	self:closeThis()
end

function CommandStationMapDisplayView:_editableInitView()
	self._decorationList = self:getUserDataTb_()
	self._rawImage = gohelper.onceAddComponent(self._gomap, gohelper.Type_RawImage)

	gohelper.setActive(self._rawImage, false)
	MainSceneSwitchCameraController.instance:clear()
end

function CommandStationMapDisplayView:onUpdateParam()
	return
end

function CommandStationMapDisplayView.getScenePath(param)
	local plotId = tonumber(param)
	local plotConfig = lua_copost_plot_map.configDict[plotId]

	if not plotConfig then
		logError("plotId is not exist")

		return
	end

	local timeId = plotConfig.time
	local timeGroupConfig = CommandStationConfig.instance:getTimeGroupByTimeId(timeId)
	local sceneId = timeGroupConfig.sceneId
	local sceneConfig = CommandStationConfig.instance:getSceneConfig(sceneId)
	local scenePath = sceneConfig.scene

	return scenePath, plotConfig, timeId
end

function CommandStationMapDisplayView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)

	local scenePath, plotConfig, timeId = CommandStationMapDisplayView.getScenePath(self.viewParam)

	if not scenePath then
		return
	end

	self._plotConfig = plotConfig
	self._timeId = timeId

	local showMapName = not string.nilorempty(plotConfig.mapName)

	if showMapName then
		self._txttag.text = plotConfig.mapName
	end

	gohelper.setActive(self._gomaptag, showMapName)

	local switchSceneId = MainSceneSwitchEnum.CustomScene.CommandStation
	local customSceneInfo = MainSceneSwitchEnum.getCustomSceneInfo[switchSceneId]

	customSceneInfo[1] = scenePath
	customSceneInfo[2] = SLFramework.FileHelper.GetFileName(scenePath, false)
	customSceneInfo[3] = customSceneInfo[2]
	self._scenePath, self._sceneInsName, self._sceneResName = customSceneInfo[1], customSceneInfo[2], customSceneInfo[3]

	MainSceneSwitchCameraController.instance:showScene(switchSceneId, self._showSceneFinished, self)
end

function CommandStationMapDisplayView:_delayShowScene()
	self:_initCamera()
	self:_initScene()
	gohelper.setActive(self._rawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, self._rt)
end

function CommandStationMapDisplayView:_showSceneFinished(rt)
	self._rt = rt

	TaskDispatcher.cancelTask(self._delayShowScene, self)
	TaskDispatcher.runDelay(self._delayShowScene, self, 0)
end

function CommandStationMapDisplayView:_initScene()
	local sceneGo = MainSceneSwitchCameraDisplayController.instance:getSceneGo(self._sceneInsName)

	if sceneGo then
		CommandStationMapModel.instance:setSceneGo(sceneGo)

		local pos = self._plotConfig.centerPoint

		transformhelper.setLocalPosXY(sceneGo.transform, pos[1], pos[2])

		local scale = self._plotConfig.scale

		transformhelper.setLocalScale(sceneGo.transform, scale[1] or 1, scale[2] or 1, 1)
		self:_addDecoration(sceneGo, self._plotConfig.time)
		self:_updateEventItems()
	end
end

function CommandStationMapDisplayView:_updateEventItems()
	local list = {}
	local timeId = self._timeId
	local characterList = CommandStationConfig.instance:getEventList(timeId, nil, CommandStationEnum.EventCategoryKey.Character)

	tabletool.addValues(list, characterList)
	self:_addEventItems(list, 0)
end

function CommandStationMapDisplayView:_addEventItems(list, normalCatetoryMaxIndex)
	local path = self.viewContainer:getSetting().otherRes[1]
	local category

	for i, v in ipairs(list) do
		category = i <= normalCatetoryMaxIndex and CommandStationEnum.EventCategory.Normal or CommandStationEnum.EventCategory.Character

		local go = self:getResInst(path, self._goevents)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommandStationMapItem)

		item:setFollowParams(MainSceneSwitchCameraController.instance:getMainCamera())
		item:onUpdateMO(v, category)
	end
end

function CommandStationMapDisplayView:_addDecoration(sceneGo, timeId)
	for k, v in pairs(self._decorationList) do
		gohelper.destroy(v)

		self._decorationList[k] = nil
	end

	local config = lua_copost_time_point_event.configDict[timeId]
	local coordinatesId = config and config.coordinatesId

	if not coordinatesId then
		return
	end

	for i, id in ipairs(coordinatesId) do
		local coordinateConfig = lua_copost_decoration_coordinates.configDict[id]

		if coordinateConfig then
			local decorationId = coordinateConfig.decorationId
			local decorationConfig = lua_copost_decoration.configDict[decorationId]

			if decorationConfig then
				local go = UnityEngine.GameObject.New(tostring(id))

				gohelper.addChild(sceneGo, go)
				table.insert(self._decorationList, go)

				local pos = coordinateConfig.coordinates
				local scale = coordinateConfig.scale
				local rotate = coordinateConfig.rotate

				transformhelper.setLocalPos(go.transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
				transformhelper.setLocalScale(go.transform, scale[1] or 1, scale[2] or 1, scale[3] or 1)

				if #rotate == 3 then
					transformhelper.setLocalRotation(go.transform, rotate[1] or 0, rotate[2] or 0, rotate[3] or 0)
				end

				local loader = PrefabInstantiate.Create(go)

				loader:startLoad(decorationConfig.decoration, function()
					if #rotate == 3 then
						local go = loader:getInstGO()
						local render = go:GetComponent(typeof(UnityEngine.Renderer))
						local mat = render.sharedMaterial

						mat:DisableKeyword("_BILLBOARD")
					end
				end)
			else
				logError(string.format("can not find decoration config, id = %s", decorationId))
			end
		else
			logError(string.format("can not find decoration coordinate config, id = %s", id))
		end
	end
end

function CommandStationMapDisplayView:_initCamera()
	self._targetOrghographic = false
	self._targetFov = CommandStationMapSceneView.getFov(CommandStationEnum.CameraFov)
	self._targetPosZ = -7.5
	self._targetRotation = CommandStationEnum.CameraRotation + 360

	local camera = MainSceneSwitchCameraController.instance:getMainCamera()

	camera.orthographic = self._targetOrghographic
	camera.fieldOfView = self._targetFov

	local mainGo = MainSceneSwitchCameraController.instance:getCameraTraceGO()

	transformhelper.setLocalPos(mainGo.transform, 0, 0, self._targetPosZ)
	transformhelper.setLocalRotation(mainGo.transform, self._targetRotation, 0, 0)
	self:_setBlur()
end

function CommandStationMapDisplayView:_setBlur()
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofFactor", 1)
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofDistance", 0)
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofSampleScale", Vector4(0.1, 0.1, 2, 0))
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofRT1Scale", 1)
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofRT2Scale", 1)
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofRT3Scale", 2)
	MainSceneSwitchCameraController.instance:setUnitPPValue("dofTotalScale", 1)
	MainSceneSwitchCameraController.instance:setUnitPPValue("rolesStoryMaskActive", false)
	MainSceneSwitchCameraController.instance:setUnitPPValue("bloomActive", false)
end

function CommandStationMapDisplayView:onClose()
	MainSceneSwitchCameraController.instance:clear()
	TaskDispatcher.cancelTask(self._delayShowScene, self)
	CommandStationMapModel.instance:clearSceneInfo()
end

function CommandStationMapDisplayView:onDestroyView()
	return
end

return CommandStationMapDisplayView
