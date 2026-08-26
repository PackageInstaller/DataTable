-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/entry/GaoSiNiaoExitFlow.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoExitFlow", package.seeall)

local GaoSiNiaoExitFlow = class("GaoSiNiaoExitFlow", GaoSiNiaoEntryFlowBase)

function GaoSiNiaoExitFlow:onStart()
	self:addWork(GaoSiNiaoWork_PlayStory.s_create(self:postStoryId()))
	self:addWork(GaoSiNiaoWork_OpenView.s_create(ViewName.V3a1_GaoSiNiao_LevelView))
	self:addWork(GaoSiNiaoWork_CloseView.s_create(ViewName.V3a1_GaoSiNiao_GameView))
	self:addWork(GaoSiNiaoWork_WaitCloseView.s_create(ViewName.StoryBackgroundView))
	self:addWork(GaoSiNiaoWork_WaitViewOnTheTop.s_create(ViewName.V3a1_GaoSiNiao_LevelView))
	self:addWork(GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView.New())
end

return GaoSiNiaoExitFlow
