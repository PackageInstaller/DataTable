-- chunkname: @modules/logic/scene/survivalsummaryact/SurvivalSummaryAct.lua

module("modules.logic.scene.survivalsummaryact.SurvivalSummaryAct", package.seeall)

local SurvivalSummaryAct = class("SurvivalSummaryAct", BaseScene)

function SurvivalSummaryAct:_createAllComps()
	self:_addComp("camera", SurvivalSceneCameraComp)
	self:_addComp("director", SurvivalSummaryActDirector)
	self:_addComp("block", SurvivalSummaryActBlock)
	self:_addComp("level", SurvivalShelterSceneLevel)
	self:_addComp("preloader", SurvivalSummaryActPreloader)
	self:_addComp("graphics", SurvivalShelterSceneGraphicsComp)
	self:_addComp("volume", SurvivalScenePPVolume)
	self:_addComp("fog", SurvivalShelterSceneFogComp)
	self:_addComp("ambient", SurvivalShelterSceneAmbientComp)
	self:_addComp("actProgress", SurvivalSummaryActProgress)
end

function SurvivalSummaryAct:onClose()
	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if not SurvivalMapHelper.instance:isSurvivalScene(nextSceneType) then
		SurvivalMapHelper.instance:clear()
	end

	SurvivalSummaryAct.super.onClose(self)
end

return SurvivalSummaryAct
