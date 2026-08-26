-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonMapScene.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapScene", package.seeall)

local VersionActivity1_2DungeonMapScene = class("VersionActivity1_2DungeonMapScene", VersionActivity1_2DungeonMapBaseScene)

function VersionActivity1_2DungeonMapScene:onInitView()
	self._gotaskitem = gohelper.findChildClickWithAudio(self.viewGO, "#go_tasklist/#go_taskitem", AudioEnum.UI.play_ui_main_shield)
	self._focusBtnStateOff = gohelper.findChild(self.viewGO, "#btn_4/icon/#go_off")
	self._focusBtnStateOn = gohelper.findChild(self.viewGO, "#btn_4/icon/#go_on")
	self._btn4 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_4")

	VersionActivity1_2DungeonMapScene.super.onInitView(self)
end

function VersionActivity1_2DungeonMapScene:onOpen()
	self._btn4:AddClickListener(self._onClickBtn4, self)
	self.addClickCb(self, self._gotaskitem, self._onClickDaily, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet116InfosReply, self._onReceiveGet116InfosReply, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.addElementItem, self._onAddElementItem, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceivePutTrapReply, self._onReceivePutTrapReply, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, self._onReceiveUpgradeElementReply, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusMap, self._onFocusMap, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.selectEpisodeItem, self._selectEpisodeItem, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.clickDailyEpisode, self._clickDailyEpisode, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckElement, self._onRecheckElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	VersionActivity1_2DungeonMapScene.super.onOpen(self)
	self:_showDailyBtn()
	self:_showFocusBtn()
end

function VersionActivity1_2DungeonMapScene:_onReceiveGet116InfosReply()
	local elements = self.viewContainer.mapSceneElement
	local list = elements and elements._elementList

	if list then
		for i, v in pairs(list) do
			local elementConfig = v._config

			if elementConfig and elementConfig.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
				self:_onReceiveUpgradeElementReply(elementConfig.id)
			end
		end
	end
end

function VersionActivity1_2DungeonMapScene:_clickDailyEpisode(elementId)
	if self._dailyEpisodeItems then
		for i, v in ipairs(self._dailyEpisodeItems) do
			if v.viewGO.activeInHierarchy and v._elementConfig.type == DungeonEnum.ElementType.DailyEpisode and elementId == v._elementConfig.id then
				v:_onClick()

				break
			end
		end
	end
end

function VersionActivity1_2DungeonMapScene:reopenViewParamPrecessed()
	if self.viewParam.focusCamp then
		self:_onClickBtn4()
	end
end

function VersionActivity1_2DungeonMapScene.getFocusBtnUnlockAniState()
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2FocusBtnUnlockAni, 0)
end

function VersionActivity1_2DungeonMapScene.setFocusBtnUnlockAniState(value)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2FocusBtnUnlockAni, value or 1)
end

function VersionActivity1_2DungeonMapScene:_showFocusBtn()
	local showBtn = DungeonMapModel.instance:getElementById(12101021)

	gohelper.setActive(self._btn4.gameObject, showBtn)

	if showBtn and VersionActivity1_2DungeonMapScene.getFocusBtnUnlockAniState() == 0 then
		VersionActivity1_2DungeonMapScene.setFocusBtnUnlockAniState(1)
		gohelper.onceAddComponent(self._btn4.gameObject, typeof(UnityEngine.Animator)):Play("unlock")
	end
end

function VersionActivity1_2DungeonMapScene:_showFocusBtnState()
	if self._sceneGo then
		local posx, posy = transformhelper.getLocalPos(self._sceneGo.transform)
		local on = not (math.abs(-88 - posx) >= 10 or math.abs(24 - posy) >= 7)

		gohelper.setActive(self._focusBtnStateOn, on)
		gohelper.setActive(self._focusBtnStateOff, not on)

		self._focusing = on
	end
end

function VersionActivity1_2DungeonMapScene:_onLoadSceneFinish()
	MainCameraMgr.instance:addView(ViewName.VersionActivity1_2DungeonView, self._initCamera, nil, self)
end

function VersionActivity1_2DungeonMapScene:_onFocusMap(targetPos)
	self:setScenePosSafety(targetPos, true)
end

function VersionActivity1_2DungeonMapScene:_disposeScene()
	self:_closeAllDailyEpisode()
	VersionActivity1_2DungeonMapScene.super._disposeScene(self)
end

function VersionActivity1_2DungeonMapScene:_showDailyBtn()
	self._curDailyItem = nil

	local showBtn = false

	if self._dailyEpisodeItems then
		table.sort(self._dailyEpisodeItems, VersionActivity1_2DungeonMapScene.sortDailyEpisode)

		for i, v in ipairs(self._dailyEpisodeItems) do
			if v.viewGO.activeInHierarchy then
				showBtn = true

				local info = gohelper.findChildText(self._gotaskitem.gameObject, "bg/info")

				info.text = formatLuaLang("versionactivity_1_2_daily_episode_btn", v._episodeConfig.name)

				local image = gohelper.findChildImage(self._gotaskitem.gameObject, "bg/icon")
				local imageName

				if v._elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
					imageName = "zhuxianditu_renwuicon_1020"

					if TimeUtil.getDayFirstLoginRed("act1_2DailySpEpisode" .. v._elementConfig.id) then
						TimeUtil.setDayFirstLoginRed("act1_2DailySpEpisode" .. v._elementConfig.id)

						local posArr = string.splitToNumber(v._elementConfig.pos, "#")
						local tarPos = Vector3(-posArr[1], -posArr[2] - 3, 0)

						VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusMap, tarPos)
					end
				else
					imageName = "zhuxianditu_renwuicon_20"
				end

				UISpriteSetMgr.instance:setUiFBSprite(image, imageName)

				self._curDailyItem = v

				break
			end
		end
	end

	gohelper.setActive(self._gotaskitem.gameObject, showBtn)
end

function VersionActivity1_2DungeonMapScene.sortDailyEpisode(item1, item2)
	local type1 = item1._elementConfig.type
	local type2 = item2._elementConfig.type

	if type1 == DungeonEnum.ElementType.Activity1_2Fight and type2 == DungeonEnum.ElementType.Activity1_2Fight then
		return item1._elementConfig.id < item2._elementConfig.id
	elseif type1 == DungeonEnum.ElementType.Activity1_2Fight and type2 == DungeonEnum.ElementType.DailyEpisode then
		return true
	elseif type1 == DungeonEnum.ElementType.DailyEpisode and type2 == DungeonEnum.ElementType.Activity1_2Fight then
		return false
	else
		local config1 = lua_activity116_episode_sp.configDict[item1._episodeConfig.id]
		local config2 = lua_activity116_episode_sp.configDict[item2._episodeConfig.id]

		return config1.refreshDay < config2.refreshDay
	end
end

function VersionActivity1_2DungeonMapScene:_onClickDaily()
	if self._curDailyItem then
		self._curDailyItem:_onClick()
	end
end

function VersionActivity1_2DungeonMapScene:_onAddElementItem(elementId)
	local elementObj = gohelper.findChild(self._sceneGo, "elementRoot/" .. elementId)

	self:_detectElementNeedSetPos(elementId)

	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if elementConfig.type == DungeonEnum.ElementType.DailyEpisode or elementConfig.type == DungeonEnum.ElementType.Activity1_2Fight then
		self._dailyEpisodeItems = self._dailyEpisodeItems or {}

		local tarObj = gohelper.findChild(elementObj, "effect1/root")
		local childItem

		if elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
			childItem = self:openSubView(VersionActivity_1_2_MapElementItem, tarObj, nil, elementId)

			table.insert(self._dailyEpisodeItems, childItem)
		else
			childItem = self:openSubView(VersionActivity_1_2_MapElement105Item, tarObj, nil, elementId)

			table.insert(self._dailyEpisodeItems, 1, childItem)
		end

		self:_showDailyBtn()
	elseif elementConfig.type == DungeonEnum.ElementType.Activity1_2Building_Trap then
		self:_showTrapObj()
	elseif elementConfig.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		self:_onReceiveUpgradeElementReply(elementId)
	end

	if elementId == 12101021 then
		self:_showFocusBtn()
	end

	local x, y, z = transformhelper.getLocalPos(elementObj.transform)

	transformhelper.setLocalPos(elementObj.transform, x, y, -20)
end

function VersionActivity1_2DungeonMapScene:_onReceivePutTrapReply()
	self:_showTrapObj()
end

function VersionActivity1_2DungeonMapScene:_onReceiveUpgradeElementReply(elementId)
	local haveNextLevel = VersionActivity1_2DungeonModel.instance:haveNextLevel(elementId)

	self:_setElementShowState(elementId, haveNextLevel and 1 or 2)
end

function VersionActivity1_2DungeonMapScene:_reBuildElement(elementId)
	self.viewContainer.mapSceneElement:_removeElement(elementId)
	self.viewContainer.mapSceneElement:_addElementById(elementId)
end

function VersionActivity1_2DungeonMapScene:_selectEpisodeItem(config)
	self._curSelectconfig = config
end

function VersionActivity1_2DungeonMapScene:_onRemoveTrapAniDone()
	if self._curTrap then
		gohelper.destroy(self._curTrap)

		self._curTrap = nil
	end
end

function VersionActivity1_2DungeonMapScene:_showTrapObj()
	local trapId = VersionActivity1_2DungeonModel.instance:getTrapPutting()

	if self._curTrap then
		if not trapId then
			gohelper.onceAddComponent(self._curTrap, typeof(UnityEngine.Animator)):Play("close")
			TaskDispatcher.runDelay(self._onRemoveTrapAniDone, self, 1)

			self._lastTrapId = nil
		else
			TaskDispatcher.cancelTask(self._onRemoveTrapAniDone, self)
			gohelper.destroy(self._curTrap)

			self._curTrap = nil
		end
	end

	if trapId then
		if trapId == 10301 then
			local url = "scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_b.prefab"

			self:com_loadAsset(url, self._onTrapLoaded)
		elseif trapId == 10302 then
			local url = "scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_c.prefab"

			self:com_loadAsset(url, self._onTrapLoaded)
		elseif trapId == 10303 then
			local url = "scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_a.prefab"

			self:com_loadAsset(url, self._onTrapLoaded)
		end
	end

	local elementObj = gohelper.findChild(self._sceneGo, "elementRoot/" .. 12101051)

	if elementObj then
		self:_setElementShowState(12101051, trapId and 2 or 1)
	end
end

function VersionActivity1_2DungeonMapScene:_setElementShowState(elementId, index)
	local elementObj = gohelper.findChild(self._sceneGo, "elementRoot/" .. elementId)

	if not gohelper.isNil(elementObj) then
		local child1 = gohelper.findChild(elementObj, "effect1")
		local child2 = gohelper.findChild(elementObj, "effect2")

		if not gohelper.isNil(elementObj) and not gohelper.isNil(elementObj) then
			if index == 1 then
				if not gohelper.isNil(child1) then
					transformhelper.setLocalPos(child1.transform, 0, 0, 0)
				end

				if not gohelper.isNil(child2) then
					transformhelper.setLocalPos(child2.transform, 40000, 0, 0)
				end
			else
				if not gohelper.isNil(child1) then
					transformhelper.setLocalPos(child1.transform, 40000, 0, 0)
				end

				if not gohelper.isNil(child2) then
					transformhelper.setLocalPos(child2.transform, 0, 0, 0)
				end
			end

			local elementConfig = lua_chapter_map_element.configDict[elementId]

			if elementConfig and elementConfig.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
				local buildingData = VersionActivity1_2DungeonModel.instance:getElementData(elementId)

				self:_setUpgradeBuildingData(buildingData, child1)
				self:_setUpgradeBuildingData(buildingData, child2)
			end
		end
	end
end

function VersionActivity1_2DungeonMapScene:_setUpgradeBuildingData(buildingData, obj)
	for i = 1, 2 do
		local txtObj = gohelper.findChild(obj, string.format("root/ani/icon%d/anim/txt_lv", i))

		if txtObj then
			local txt = txtObj:GetComponent(typeof(TMPro.TextMeshPro))

			if buildingData then
				txt.text = "Lv. " .. buildingData.level

				if not VersionActivity1_2DungeonModel.instance:haveNextLevel(buildingData.elementId) then
					txt.text = "Lv. Max"
				end
			else
				txt.text = "Lv. 0"
			end
		end
	end
end

function VersionActivity1_2DungeonMapScene:_onTrapLoaded(loader)
	local tarPrefab = loader:GetResource()
	local elementRoot = gohelper.findChild(self._sceneGo, "elementRoot")
	local trapObj = gohelper.clone(tarPrefab, elementRoot)
	local trapId = VersionActivity1_2DungeonModel.instance:getTrapPutting()
	local config = lua_activity116_building.configDict[trapId]
	local elementObj = gohelper.findChild(self._sceneGo, "elementRoot/" .. config.elementId)

	if elementObj then
		local x, y, z = transformhelper.getLocalPos(elementObj.transform)

		transformhelper.setLocalPos(trapObj.transform, x, y - 1, -40)
	end

	self._curTrap = trapObj

	if self._lastTrapId ~= trapId then
		gohelper.onceAddComponent(trapObj, typeof(UnityEngine.Animator)):Play("open")
	else
		gohelper.onceAddComponent(trapObj, typeof(UnityEngine.Animator)):Play("idle")
	end

	self._lastTrapId = trapId
end

function VersionActivity1_2DungeonMapScene:_loadSceneFinish()
	self:_closeAllDailyEpisode()
	VersionActivity1_2DungeonMapScene.super._loadSceneFinish(self)
	self:showBridge()
	self:_showElementLightBg()
	self:_showTentState()
	self:_showTower()
	self:_hideCar()
	self:_showFocusBtnState()
end

function VersionActivity1_2DungeonMapScene:_showTower()
	if not self._curSelectconfig then
		return
	end

	local showTower = self._curSelectconfig.id == 1210113 or self._curSelectconfig.id == 1210114
	local tower1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_p")
	local tower2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_zhedang_dt")

	gohelper.setActive(tower1, showTower)
	gohelper.setActive(tower2, showTower)
end

function VersionActivity1_2DungeonMapScene:_hideCar()
	if not self._curSelectconfig then
		return
	end

	if self._curSelectconfig.id == 1210106 then
		local car = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_u")
		local car1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_k")
		local pass = DungeonModel.instance:hasPassLevelAndStory(1210106)

		gohelper.setActive(car, pass)
		gohelper.setActive(car1, not pass)
	end
end

function VersionActivity1_2DungeonMapScene:_showTentState()
	local tent = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_t")

	gohelper.setActive(tent, not DungeonMapModel.instance:elementIsFinished(12101101))
end

function VersionActivity1_2DungeonMapScene:_showElementLightBg()
	self._lightBgDic = self:getUserDataTb_()

	local resList = {}

	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_a.prefab")
	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_b.prefab")
	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_c.prefab")
	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_d.prefab")
	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_e.prefab")
	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_f.prefab")
	table.insert(resList, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_g.prefab")
	self:com_loadListAsset(resList, self._onLightBgLoaded, self._onLightBgLoadFinish)
end

function VersionActivity1_2DungeonMapScene:_onLightBgLoaded(loader)
	local tarPrefab = loader:GetResource()
	local elementRoot = gohelper.findChild(self._sceneGo, "elementRoot")
	local lightBg = gohelper.clone(tarPrefab, elementRoot)

	gohelper.setActive(lightBg, false)
	transformhelper.setLocalPos(lightBg.transform, 0, 0, -4)

	self._lightBgDic[loader.ResPath] = lightBg
end

function VersionActivity1_2DungeonMapScene:_onLightBgLoadFinish()
	self:_addMapLight()
end

function VersionActivity1_2DungeonMapScene:_detectElementNeedSetPos(elementId)
	local configDic = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(elementId)

	if configDic then
		for k, v in pairs(configDic) do
			if not string.nilorempty(v.lightBgUrl) and self._lightBgDic[v.lightBgUrl] then
				local filterEpisode = string.splitToNumber(v.filterEpisode, "#")

				for index, value in ipairs(filterEpisode) do
					if value == self._curSelectconfig.id then
						return
					end
				end

				gohelper.setActive(self._lightBgDic[v.lightBgUrl], true)

				local elementObj = gohelper.findChild(self._sceneGo, "elementRoot/" .. elementId)

				if elementObj then
					local x, y, z = transformhelper.getLocalPos(elementObj.transform)

					transformhelper.setLocalPos(elementObj.transform, x, y, -20)
				end

				return
			end
		end
	end
end

function VersionActivity1_2DungeonMapScene:_closeAllDailyEpisode()
	if self._dailyEpisodeItems then
		for i, v in ipairs(self._dailyEpisodeItems) do
			self:destroySubView(v)
		end

		self._dailyEpisodeItems = {}
	end
end

function VersionActivity1_2DungeonMapScene:showBridge()
	local bridge = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_o")

	gohelper.setActive(bridge, DungeonMapModel.instance:elementIsFinished(12101011))

	local bridge2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_f")

	gohelper.setActive(bridge2, true)
end

function VersionActivity1_2DungeonMapScene:_OnRemoveElement(elementId)
	if elementId == 12101011 then
		self:showBridge()
	end

	if self._dailyEpisodeItems then
		for i, v in ipairs(self._dailyEpisodeItems) do
			local elementConfig = v._elementConfig

			if elementConfig.type == DungeonEnum.ElementType.Activity1_2Fight and elementConfig.id == elementId then
				local subView = table.remove(self._dailyEpisodeItems, i)

				break
			end
		end
	end

	self:_showDailyBtn()
end

function VersionActivity1_2DungeonMapScene:getInteractiveItem()
	return self.viewContainer.mapView:openMapInteractiveItem()
end

function VersionActivity1_2DungeonMapScene:createInteractiveItem()
	self._uiGo = gohelper.clone(self._itemPrefab, self._sceneCanvasGo)
	self._interactiveItem = MonoHelper.addLuaComOnceToGo(self._uiGo, DungeonMapInteractiveItem)

	self._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(self._uiGo, false)
end

function VersionActivity1_2DungeonMapScene:buildLoadRes(allResPath, mapCfg)
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(allResPath, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")

	local mapRes = ResUrl.getDungeonMapRes(mapCfg.res)

	table.insert(allResPath, mapRes)
	table.insert(allResPath, "scenes/m_s14_hddt_hd02/scene_prefab/activity1_2dungeon_map_audio.prefab")
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(allResPath, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_fog.prefab")
end

function VersionActivity1_2DungeonMapScene:_onClickBtn4()
	if self._focusing then
		GameFacade.showToast(ToastEnum.Activity1_2FocusBtnClick)

		return
	end

	self._focusing = true

	gohelper.setActive(self._focusBtnStateOn, true)
	gohelper.setActive(self._focusBtnStateOff, false)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusMap, Vector3(-85, 25, 0))
end

function VersionActivity1_2DungeonMapScene:_onRecheckElement(elementId, isGM)
	local elementCo = lua_chapter_map_element.configDict[elementId]

	if not self.viewParam.chapterId then
		local chapterId = self.viewContainer:_getChapterId()

		if not DungeonController.instance:isNeedRecheckInteractive(elementCo) then
			DungeonController.instance:onRecheckElement(elementId, self.viewParam.chapterId)

			return
		end

		local item = self:getInteractiveItem()
		local pos = self._sceneTrans.localPosition

		DungeonController.instance:onRecheckElement(elementId, self.viewParam.chapterId, item, pos, isGM)
	end
end

function VersionActivity1_2DungeonMapScene:onClose()
	self._btn4:RemoveClickListener()
	TaskDispatcher.cancelTask(self._onRemoveTrapAniDone, self)
	VersionActivity1_2DungeonMapScene.super.onClose(self)
end

return VersionActivity1_2DungeonMapScene
