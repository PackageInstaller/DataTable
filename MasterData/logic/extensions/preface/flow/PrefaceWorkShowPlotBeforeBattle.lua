-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceWorkShowPlotBeforeBattle.lua

module("logic.extensions.preface.flow.PrefaceWorkShowPlotBeforeBattle", package.seeall)

local M = class("PrefaceWorkShowPlotBeforeBattle", WorkBase)
local kStorySaveKey = "kStorySaveKey"

function M:onEnter(context)
	self._plotCode = context.model:getPlotCodeBeforeBattle()

	local isShowPlot = context.model:isShowPlot()

	if isShowPlot and self._plotCode and self._plotCode > 0 then
		local saveKey = string.format("%s_%s_%s", kStorySaveKey, PlayerModel.instance:getId(), self._plotCode)
		local playState = Astral.LocalStorage.Instance:GetInt(saveKey)

		if playState == 0 then
			StoryMgr.instance:startSingle(self._plotCode, false, self._onPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
			LoadingFacade.instance:hideLoading()
		else
			self:_onPlotFinish()
		end
	else
		self:_onPlotFinish()
	end
end

function M:onExit(isInterrupt)
	return
end

function M:_onPlotFinish()
	if self._plotCode and self._plotCode > 0 then
		local saveKey = string.format("%s_%s_%s", kStorySaveKey, PlayerModel.instance:getId(), self._plotCode)

		Astral.LocalStorage.Instance:SetInt(saveKey, 1)
	end

	self:onDone(WorkResult.Succeed)
end

return M
