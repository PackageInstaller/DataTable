-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/controller/HeroDepotController.lua

module("logic.extensions.characterdepot.controller.HeroDepotController", package.seeall)

local M = class("HeroDepotController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.CLEAR_RECORD_DATA_EVENT, self._cearlFilterRecord, self)
end

function M:_cearlFilterRecord(name, type)
	CharacterUtil.clearFilterRecord(type)
end

M.instance = M.New()

return M
