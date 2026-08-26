-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/TeamChessEffectPool.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessEffectPool", package.seeall)

local TeamChessEffectPool = class("TeamChessEffectPool")
local _uniqueIdCounter = 1
local _path2WrapPoolDict = {}
local _maxCount = 10
local _effectParentGo

function TeamChessEffectPool.dispose()
	if _path2WrapPoolDict ~= nil then
		for _, wrap in pairs(_path2WrapPoolDict) do
			wrap:dispose()
		end

		_path2WrapPoolDict = {}
	end
end

function TeamChessEffectPool.getEffect(effectType, callback, callbackObj)
	if _path2WrapPoolDict == nil then
		_path2WrapPoolDict = {}
	end

	local warpPool = _path2WrapPoolDict[effectType]

	if warpPool == nil then
		warpPool = LuaObjPool.New(_maxCount, function()
			return (TeamChessEffectPool._createWrap(effectType))
		end, function(effectWrap)
			if effectWrap ~= nil then
				effectWrap:onDestroy()
			end
		end, function(effectWrap)
			if effectWrap ~= nil then
				effectWrap:clear()
			end
		end)
		_path2WrapPoolDict[effectType] = warpPool
	end

	local effectWrap = warpPool:getObject()

	if effectWrap == nil then
		effectWrap = TeamChessEffectPool._createWrap(effectType)
	end

	effectWrap:setCallback(callback, callbackObj)

	return effectWrap
end

function TeamChessEffectPool.returnEffect(effectWrap)
	if effectWrap == nil then
		return
	end

	local warpPool = _path2WrapPoolDict[effectWrap.effectType]

	if warpPool ~= nil then
		warpPool:putObject(effectWrap)
	end
end

function TeamChessEffectPool.setPoolContainerGO(go)
	_effectParentGo = go
end

function TeamChessEffectPool.getPoolContainerGO()
	return _effectParentGo
end

function TeamChessEffectPool._createWrap(effectType)
	local go = gohelper.create3d(TeamChessEffectPool.getPoolContainerGO(), effectType)
	local effectWrap = MonoHelper.addLuaComOnceToGo(go, TeamChessEffectWrap)

	effectWrap:init(go)
	effectWrap:setUniqueId(_uniqueIdCounter)
	effectWrap:setEffectType(effectType)

	_uniqueIdCounter = _uniqueIdCounter + 1

	return effectWrap
end

return TeamChessEffectPool
