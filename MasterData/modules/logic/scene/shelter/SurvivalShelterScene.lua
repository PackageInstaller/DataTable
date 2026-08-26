-- chunkname: @modules/logic/scene/shelter/SurvivalShelterScene.lua

module("modules.logic.scene.shelter.SurvivalShelterScene", package.seeall)

local SurvivalShelterScene = class("SurvivalShelterScene", BaseScene)

function SurvivalShelterScene:_createAllComps()
	self:_addComp("camera", SurvivalSceneCameraComp)
	self:_addComp("director", SurvivalShelterSceneDirector)
	self:_addComp("block", SurvivalShelterSceneMapBlock)
	self:_addComp("level", SurvivalShelterSceneLevel)
	self:_addComp("view", SurvivalShelterSceneViewComp)
	self:_addComp("preloader", SurvivalShelterScenePreloader)
	self:_addComp("unit", SurvivalShelterSceneMapUnitComp)
	self:_addComp("graphics", SurvivalShelterSceneGraphicsComp)
	self:_addComp("volume", SurvivalScenePPVolume)
	self:_addComp("path", SurvivalShelterScenePathComp)
	self:_addComp("fog", SurvivalShelterSceneFogComp)
	self:_addComp("ambient", SurvivalShelterSceneAmbientComp)
	self:_addComp("bubble", SurvivalBubbleComp)
end

function SurvivalShelterScene:onClose()
	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if not SurvivalMapHelper.instance:isSurvivalScene(nextSceneType) then
		SurvivalMapHelper.instance:clear()
	end

	SurvivalShelterScene.super.onClose(self)
end

return SurvivalShelterScene
