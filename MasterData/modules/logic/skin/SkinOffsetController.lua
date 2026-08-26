-- chunkname: @modules/logic/skin/SkinOffsetController.lua

module("modules.logic.skin.SkinOffsetController", package.seeall)

local SkinOffsetController = class("SkinOffsetController", BaseController)

SkinOffsetController.Event = {
	OnSelectSkinChange = 1
}
SkinOffsetController.instance = SkinOffsetController.New()

LuaEventSystem.addEventMechanism(SkinOffsetController.instance)
SkinOffsetController.instance:__onInit()

return SkinOffsetController
