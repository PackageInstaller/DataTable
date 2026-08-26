-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/entry/GaoSiNiaoEnterFlow.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoEnterFlow", package.seeall)

local GaoSiNiaoEnterFlow = class("GaoSiNiaoEnterFlow", GaoSiNiaoEntryFlowBase)

function GaoSiNiaoEnterFlow:onStart()
	local episodeId = self:episodeId()

	self:addWork(GaoSiNiaoWork_PlayStory.s_create(self:preStoryId()))

	if self:gameId() == 0 then
		self:addWork(GaoSiNiaoWork_JustCompleteGame.s_create(episodeId))
	else
		self:addWork(GaoSiNiaoWork_EnterGameView.s_create(ViewName.V3a1_GaoSiNiao_GameView))
	end
end

return GaoSiNiaoEnterFlow
