-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/RetrieveScene.lua

module("logic.extensions.retrieve.scene.RetrieveScene", package.seeall)

local M = class("RetrieveScene", SceneBaseSpacx)

function M:_initComponents()
	self:_addComponent("stage", RetrieveSceneStage)
	self:_addComponent("camera", RetrieveSceneCamera)
	self:_addComponent("light", RetrieveSceneLight)
	self:_addComponent("pickerHandler", RetrieveScenePickerHandler)
end

function M:onEnter(sceneId, bornX, bornZ)
	M.super.onEnter(self, sceneId, bornX, bornZ)
end

function M:onEnterFinished()
	M.super.onEnterFinished(self)
end

function M:onExit()
	M.super.onExit(self)
	CriwareAudioFacade.instance:stopVoice()
end

function M:getSceneType()
	return SceneType.Retrieve
end

return M
