-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActPreloader.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActPreloader", package.seeall)

local SurvivalSummaryActPreloader = class("SurvivalSummaryActPreloader", SurvivalShelterScenePreloader)

function SurvivalSummaryActPreloader:init(sceneId, levelId)
	self._loader = MultiAbLoader.New()

	if not GameResMgr.IsFromEditorDir then
		local list = {}

		self._loader:setPathList(list)
		self._loader:addPath(self:getMapBlockAbPath())
	else
		local list = {}

		tabletool.addValues(list, self:getSummaryActBlock())
		self._loader:setPathList(list)
	end

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local roleRes = survivalShelterRoleMo:getRoleModelRes()

	self._loader:addPath(roleRes)

	local npcList = SurvivalMapModel.instance.resultData:getFirstNpcMos()

	for k, v in ipairs(npcList) do
		local renown = SurvivalConfig.instance:getNpcRenown(v.id)

		if renown then
			self._loader:addPath(v.co.resource)
		end
	end

	self._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for k, v in pairs(SurvivalShelterScenePathComp.ResPaths) do
		self._loader:addPath(v)
	end

	self._loader:startLoad(self._onPreloadFinish, self)
end

function SurvivalSummaryActPreloader:getSummaryActBlock()
	local mapId = SurvivalModel.instance:getSummaryActMapId()
	local mapCo_SummaryAct = SurvivalConfig.instance:getShelterMapCo(mapId)

	return (tabletool.copy(mapCo_SummaryAct.allBlockPaths))
end

function SurvivalSummaryActPreloader:onSceneClose(sceneId, levelId)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return SurvivalSummaryActPreloader
