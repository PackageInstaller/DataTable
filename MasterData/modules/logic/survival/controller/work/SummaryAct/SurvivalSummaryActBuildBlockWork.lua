-- chunkname: @modules/logic/survival/controller/work/SummaryAct/SurvivalSummaryActBuildBlockWork.lua

module("modules.logic.survival.controller.work.SummaryAct.SurvivalSummaryActBuildBlockWork", package.seeall)

local SurvivalSummaryActBuildBlockWork = class("SurvivalSummaryActBuildBlockWork", BaseWork)

function SurvivalSummaryActBuildBlockWork:ctor(param)
	self.mapCo = param.mapCo
	self.actMapId = self.mapCo.mapId
end

function SurvivalSummaryActBuildBlockWork:onStart()
	local scene = SurvivalMapHelper.instance:getScene()
	local goScene = scene:getSceneContainerGO()

	self.goBlockRoot = gohelper.create3d(goScene, "SummaryAct_BlockRoot")

	local mapCo = SurvivalConfig.instance:getShelterMapCo(self.actMapId)

	self.blocks = {}

	for i, v in ipairs(mapCo.allBlocks) do
		local blockCo = tabletool.copy(v)

		blockCo.pos = SurvivalHexNode.New(blockCo.pos.q, blockCo.pos.r + SurvivalModel.instance.summaryActPosOffset)

		local block = SurvivalShelterBlockEntity.Create(blockCo, self.goBlockRoot)

		table.insert(self.blocks, block)
	end

	self:onDone(true)
end

function SurvivalSummaryActBuildBlockWork:onDestroy()
	gohelper.destroy(self.goBlockRoot)
	SurvivalSummaryActBuildBlockWork.super.onDestroy(self)
end

return SurvivalSummaryActBuildBlockWork
