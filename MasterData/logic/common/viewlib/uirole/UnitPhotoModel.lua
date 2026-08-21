-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uirole/UnitPhotoModel.lua

module("logic.common.viewlib.uirole.UnitPhotoModel", package.seeall)

local M = class("UnitPhotoModel", UnitBase)

function M:getTag()
	return UnitTag.Player
end

function M:getLayer()
	return SceneLayer.UI3D_Value
end

function M:_initComponents()
	self:_addComponent("spine", UnitCompModel)
end

return M
