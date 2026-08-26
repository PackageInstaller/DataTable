-- chunkname: @modules/logic/dungeon/view/map/DungeonMapSceneDecorate.lua

module("modules.logic.dungeon.view.map.DungeonMapSceneDecorate", package.seeall)

local DungeonMapSceneDecorate = class("DungeonMapSceneDecorate", BaseView)

function DungeonMapSceneDecorate:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapSceneDecorate:addEvents()
	return
end

function DungeonMapSceneDecorate:removeEvents()
	return
end

local decorateMap = {
	[113] = {
		{
			elementId = 1133101,
			res = "scenes/v3a7_m_s08_hddt/prefab/v3a7_m_s08_hddt_zhansun_1.prefab",
			episodeId = 1310
		},
		{
			elementId = 1133102,
			res = "scenes/v3a7_m_s08_hddt/prefab/v3a7_m_s08_hddt_zhansun_1_2.prefab",
			episodeId = 11312
		},
		{
			elementId = 1133104,
			res = "scenes/v3a7_m_s08_hddt/prefab/v3a7_m_s08_hddt_zhansun_1_3.prefab",
			episodeId = 1314
		},
		{
			elementId = 1133105,
			res = "scenes/v3a7_m_s08_hddt/prefab/v3a7_m_s08_hddt_zhansun_1_4.prefab",
			episodeId = 11317
		},
		{
			elementId = 1133106,
			res = "scenes/v3a7_m_s08_hddt/prefab/v3a7_m_s08_hddt_zhansun_1_5.prefab",
			episodeId = 11318
		},
		{
			res = "scenes/v3a7_m_s08_hddt/prefab/v3a7_m_s08_hddt_zhansun_1_6.prefab",
			episodeId = 1321
		}
	}
}

function DungeonMapSceneDecorate:_editableInitView()
	self._loader = nil
end

function DungeonMapSceneDecorate:onOpen()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self._disposeScene, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self._disposeScene, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self._loadSceneFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function DungeonMapSceneDecorate:_onUpdateDungeonInfo()
	if self._episodeConfig then
		self:_showDecorate(self._episodeConfig.chapterId, self._episodeConfig.id)
	end
end

function DungeonMapSceneDecorate:_disposeScene()
	self._sceneGo = nil
	self._episodeConfig = nil
	self._decorateConfig = nil

	gohelper.destroy(self._decorateGo)

	self._decorateGo = nil
end

function DungeonMapSceneDecorate:_loadSceneFinish(param)
	self._sceneGo = param[2]
	self._episodeConfig = param.episodeConfig

	self:_showDecorate(self._episodeConfig.chapterId, self._episodeConfig.id)
end

function DungeonMapSceneDecorate:_showDecorate(chapterId, episodeId)
	local decorateConfig = self:_getDecorateConfig(chapterId, episodeId)

	if not decorateConfig then
		return
	end

	if not self._sceneGo then
		return
	end

	if decorateConfig == self._decorateConfig and not gohelper.isNil(self._decorateGo) then
		return
	end

	gohelper.destroy(self._decorateGo)

	self._decorateGo = UnityEngine.GameObject.New("decorate")

	gohelper.addChild(self._sceneGo, self._decorateGo)

	local elementRoot = gohelper.findChild(self._sceneGo, "elementRoot")

	if elementRoot then
		gohelper.setSiblingBefore(self._decorateGo, elementRoot)
	end

	local loader = PrefabInstantiate.Create(self._decorateGo)

	loader:startLoad(decorateConfig.res)

	self._decorateConfig = decorateConfig
end

function DungeonMapSceneDecorate:_getDecorateConfig(chapterId, episodeId)
	local configList = decorateMap[chapterId]

	if not configList then
		return
	end

	for i = #configList, 1, -1 do
		local config = configList[i]
		local episodeFinished = DungeonModel.instance:hasPassLevelAndStory(config.episodeId)
		local elementFinished = not config.elementId or DungeonMapModel.instance:elementIsFinished(config.elementId)
		local normalEpisodeId = DungeonConfig.instance:getNormalEpisodeIdBySimple(config.episodeId) or config.episodeId

		if episodeFinished and elementFinished and normalEpisodeId <= episodeId then
			return config
		end
	end
end

function DungeonMapSceneDecorate:onClose()
	gohelper.destroy(self._decorateGo)

	self._decorateGo = nil
end

function DungeonMapSceneDecorate:onDestroyView()
	return
end

return DungeonMapSceneDecorate
