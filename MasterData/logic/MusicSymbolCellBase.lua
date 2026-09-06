-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/symbolcell/MusicSymbolCellBase.lua

module("logic.extensions.playmusic.view.symbolcell.MusicSymbolCellBase", package.seeall)

local MusicSymbolCellBase = class("MusicSymbolCellBase")

function MusicSymbolCellBase:ctor(entityId)
	self._entityId = entityId

	self:reset()
end

function MusicSymbolCellBase:reset()
	self._mainGo = nil
	self._symbolId = 0
	self._deltaTime = 0
	self._curHitTimeRatio = 0
	self._isHit = false
end

function MusicSymbolCellBase:dispose()
	self._entityId = nil

	self:reset()
end

function MusicSymbolCellBase:onTicking(deltaTime)
	self._deltaTime = self._deltaTime + deltaTime
end

function MusicSymbolCellBase:init(mainGo, symbolId)
	self._mainGo = mainGo
	self._symbolId = symbolId
end

function MusicSymbolCellBase:getEntityId()
	return self._entityId
end

function MusicSymbolCellBase:getGameObject()
	return self._mainGo
end

function MusicSymbolCellBase:getSymbolId()
	return self._symbolId
end

function MusicSymbolCellBase:getCurHitTimeRatio()
	return self._curHitTimeRatio
end

function MusicSymbolCellBase:isHit()
	return self._isHit
end

return MusicSymbolCellBase
