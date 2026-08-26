-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzBattleModel.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzBattleModel", package.seeall)

local WmzBattleModel = class("WmzBattleModel", Activity220SimpleBaseModel)

function WmzBattleModel:ctor(...)
	WmzBattleModel.super.ctor(self, ...)
end

function WmzBattleModel:onInit()
	WmzBattleMapMO.default_ctor(self, "_mapMO")

	self._trackMO = WmzBattleTrackMO.New()

	self:reInit()
end

function WmzBattleModel:reInit()
	WmzBattleModel.super.reInit(self)
	self:clear()
	self:_internal_set_configInst(WmzConfig.instance)
end

function WmzBattleModel:clear()
	self._episodeId = 0
	self._isWin = false

	if self._dragContext then
		self._dragContext:clear()
	else
		self._dragContext = WmzMapDragContext.New()
	end
end

function WmzBattleModel:restart(episodeId)
	episodeId = episodeId or self._episodeId
	self._isWin = false
	self._episodeId = episodeId

	self._dragContext:clear()
	self._mapMO:restartByEpisodeId(episodeId)
end

function WmzBattleModel:episodeId()
	return self._episodeId
end

function WmzBattleModel:mapMO()
	return self._mapMO
end

function WmzBattleModel:dragContext()
	return self._dragContext
end

function WmzBattleModel:trackMO()
	return self._trackMO
end

function WmzBattleModel:isWin()
	return self._isWin
end

function WmzBattleModel:setIsWin(bWin, optEpisodeId)
	if optEpisodeId ~= nil and optEpisodeId ~= self._episodeId then
		return
	end

	self._isWin = bWin
end

function WmzBattleModel:track_act_WMZ_operation(eOperationType, ...)
	self._trackMO:track_act_WMZ_operation(self._mapMO, eOperationType, ...)
end

WmzBattleModel.instance = WmzBattleModel.New()

return WmzBattleModel
