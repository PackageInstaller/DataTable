-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/entry/GaoSiNiaoEntryFlow_WorkBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoEntryFlow_WorkBase", package.seeall)

local GaoSiNiaoEntryFlow_WorkBase = class("GaoSiNiaoEntryFlow_WorkBase", GaoSiNiaoWorkBase)

function GaoSiNiaoEntryFlow_WorkBase:episodeId()
	return self.root:episodeId()
end

function GaoSiNiaoEntryFlow_WorkBase:restartBattle()
	GaoSiNiaoBattleModel.instance:restart(self:episodeId())
end

function GaoSiNiaoEntryFlow_WorkBase:insertWork(work)
	return self.root:insertWork(work)
end

return GaoSiNiaoEntryFlow_WorkBase
