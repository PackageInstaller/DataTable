-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActBlock.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActBlock", package.seeall)

local SurvivalSummaryActBlock = class("SurvivalSummaryActBlock", BaseSceneComp)

function SurvivalSummaryActBlock:init()
	self:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
end

function SurvivalSummaryActBlock:_onPreloadFinish()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)

	local sceneGo = self:getCurScene():getSceneContainerGO()

	self.blockRoot = gohelper.create3d(sceneGo, "BlockRoot")

	local mapId = SurvivalModel.instance:getSummaryActMapId()
	local mapCo = SurvivalConfig.instance:getShelterMapCo(mapId)

	self.blocks = {}

	for i, v in ipairs(mapCo.allBlocks) do
		local block = SurvivalShelterBlockEntity.Create(v, self.blockRoot)

		table.insert(self.blocks, block)
	end

	self:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function SurvivalSummaryActBlock:onSceneClose()
	self:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, self._onPreloadFinish, self)
	gohelper.destroy(self.blockRoot)

	self.blocks = {}
end

return SurvivalSummaryActBlock
