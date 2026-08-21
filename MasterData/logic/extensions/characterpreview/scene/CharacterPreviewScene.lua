-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewScene.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewScene", package.seeall)

local M = class("CharacterPreviewScene", SceneBaseSpacx)

function M:_initComponents()
	self:_addComponent("stage", CharacterPreviewSceneStage)
	self:_addComponent("camera", SceneCamera)
	self:_addComponent("airtightMgr", CharacterPreviewAirtightMgr)
	self:_addComponent("light", CharacterPreviewSceneLight)
end

function M:getSceneType()
	return SceneType.CharacterPreview
end

return M
