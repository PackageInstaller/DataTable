-- chunkname: @modules/logic/commandstation/view/CommandStationEnterSceneView.lua

module("modules.logic.commandstation.view.CommandStationEnterSceneView", package.seeall)

local CommandStationEnterSceneView = class("CommandStationEnterSceneView", BaseView)

function CommandStationEnterSceneView:onInitView()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("CommandStationEnterScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function CommandStationEnterSceneView:onOpen()
	self:loadMap()
end

function CommandStationEnterSceneView:loadMap()
	if self._mapLoader then
		if self._mapLoader.isLoading then
			self._mapLoader:dispose()
		else
			self._oldMapLoader = self._mapLoader
		end
	end

	local stage = 1

	if stage == 1 then
		if not ToughBattleEnum.MapId_stage1 then
			local mapId = ToughBattleEnum.MapId_stage2

			self._mapCfg = lua_chapter_map.configDict[mapId]
			self._mapLoader = MultiAbLoader.New()

			local allResPath = {}

			self:buildLoadRes(allResPath, self._mapCfg, stage)

			self._sceneUrl = allResPath[1]
			self._mapLightUrl = allResPath[2]
			self._mapEffectUrl = allResPath[3]

			self._mapLoader:addPath(self._sceneUrl)
			self._mapLoader:addPath(self._mapLightUrl)

			if self._mapEffectUrl then
				self._mapLoader:addPath(self._mapEffectUrl)
			end

			self._mapLoader:startLoad(self._loadSceneFinish, self)
		end
	end
end

function CommandStationEnterSceneView:buildLoadRes(allResPath, mapCfg, stage)
	table.insert(allResPath, ResUrl.getDungeonMapRes(mapCfg.res))
	table.insert(allResPath, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	if stage == 2 then
		table.insert(allResPath, "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect3.prefab")
	end
end

function CommandStationEnterSceneView:_loadSceneFinish()
	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil

		gohelper.destroy(self._sceneGo)
	end

	local assetUrl = self._sceneUrl
	local assetItem = self._mapLoader:getAssetItem(assetUrl)
	local mainPrefab = assetItem:GetResource(assetUrl)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, self._mapCfg.id)
	self._sceneTrans = self._sceneGo.transform

	transformhelper.setLocalPos(self._sceneTrans, -40.33, 20.35, 3.6)
end

function CommandStationEnterSceneView:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)
end

function CommandStationEnterSceneView:onDestroyView()
	if self._oldMapLoader then
		self._oldMapLoader:dispose()

		self._oldMapLoader = nil
	end

	if self._mapLoader then
		self._mapLoader:dispose()

		self._mapLoader = nil
	end

	gohelper.destroy(self._sceneRoot)
end

return CommandStationEnterSceneView
