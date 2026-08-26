-- chunkname: @modules/logic/scene/survivalcollectionroom/SurvivalCollectionRoomScene.lua

module("modules.logic.scene.survivalcollectionroom.SurvivalCollectionRoomScene", package.seeall)

local SurvivalCollectionRoomScene = class("SurvivalCollectionRoomScene", BaseScene)

function SurvivalCollectionRoomScene:_createAllComps()
	self:_addComp("director", SurvivalCollectionRoomDirector)
	self:_addComp("preloader", SurvivalCollectionRoomPreloader)
	self:_addComp("level", SurvivalShelterSceneLevel)
	self:_addComp("block", SurvivalCollectionRoomBlock)
	self:_addComp("unit", SurvivaCollectionRoomUnitComp)
	self:_addComp("path", SurvivalShelterScenePathComp)
	self:_addComp("camera", SurvivalSceneCameraComp)
	self:_addComp("graphics", SurvivalShelterSceneGraphicsComp)
	self:_addComp("volume", SurvivalScenePPVolume)
	self:_addComp("fog", SurvivalShelterSceneFogComp)
	self:_addComp("ambient", SurvivalShelterSceneAmbientComp)
end

function SurvivalCollectionRoomScene:onClose()
	local nextSceneType = GameSceneMgr.instance:getNextSceneType()

	if not SurvivalMapHelper.instance:isSurvivalScene(nextSceneType) then
		SurvivalMapHelper.instance:clear()
	end

	SurvivalCollectionRoomScene.super.onClose(self)
end

return SurvivalCollectionRoomScene
