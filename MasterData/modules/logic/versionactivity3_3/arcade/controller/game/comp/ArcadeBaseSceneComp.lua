-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeBaseSceneComp.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeBaseSceneComp", package.seeall)

local ArcadeBaseSceneComp = class("ArcadeBaseSceneComp", LuaCompBase)

function ArcadeBaseSceneComp:ctor(param)
	self._scene = param.scene
	self._compName = param.compName
end

function ArcadeBaseSceneComp:init(go)
	self.go = go
	self.trans = go.transform

	self:onInit()

	self._initialized = true
end

function ArcadeBaseSceneComp:getCompName()
	return self._compName
end

function ArcadeBaseSceneComp:getGO()
	return self.go
end

function ArcadeBaseSceneComp:getTrans()
	return self.trans
end

function ArcadeBaseSceneComp:clear()
	if not self._initialized then
		return
	end

	self._initialized = false
	self._scene = nil
	self._compName = nil

	self:onClear()
end

function ArcadeBaseSceneComp:onInit()
	return
end

function ArcadeBaseSceneComp:onPreGameStart()
	return
end

function ArcadeBaseSceneComp:onClear()
	return
end

function ArcadeBaseSceneComp:onDestroy()
	self:clear()
end

return ArcadeBaseSceneComp
