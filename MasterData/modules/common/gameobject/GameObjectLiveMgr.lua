-- chunkname: @modules/common/gameobject/GameObjectLiveMgr.lua

module("modules.common.gameobject.GameObjectLiveMgr", package.seeall)

local GameObjectLiveMgr = class("GameObjectLiveMgr")

GameObjectLiveMgr.instance = GameObjectLiveMgr.New()

LuaEventSystem.addEventMechanism(GameObjectLiveMgr.instance)

return GameObjectLiveMgr
