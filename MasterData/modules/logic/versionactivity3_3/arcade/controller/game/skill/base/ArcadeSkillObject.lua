-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillObject.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillObject", package.seeall)

local ArcadeSkillObject = class("ArcadeSkillObject")
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall
local _ObjInstanceIdx = 0

local function _getInstanceIdx()
	_ObjInstanceIdx = _ObjInstanceIdx + 1

	return _ObjInstanceIdx
end

function ArcadeSkillObject:ctor()
	self._instanceID_ = _getInstanceIdx()
end

function ArcadeSkillObject:getInstanceID()
	return self._instanceID_
end

function ArcadeSkillObject:tryCallFunc(func, params)
	local isOk, result = xpcall(func, __G__TRACKBACK__, self, params)

	return isOk, result
end

function ArcadeSkillObject:tryCallMethodName(method)
	local isOk, result = xpcall(self[method], __G__TRACKBACK__, self)

	return isOk, result
end

return ArcadeSkillObject
