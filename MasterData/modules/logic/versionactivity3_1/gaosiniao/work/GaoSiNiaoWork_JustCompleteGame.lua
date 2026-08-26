-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_JustCompleteGame.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_JustCompleteGame", package.seeall)

local GaoSiNiaoWork_JustCompleteGame = class("GaoSiNiaoWork_JustCompleteGame", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_JustCompleteGame.s_create(episodeId)
	local work = GaoSiNiaoWork_JustCompleteGame.New()

	work._episodeId = episodeId

	return work
end

function GaoSiNiaoWork_JustCompleteGame:onStart()
	self:clearWork()
	GaoSiNiaoController.instance:completeGame(self._episodeId, nil, self._onCompleteGameDone, self)
	TaskDispatcher.runDelay(self._onTimeout, self, 10)
end

function GaoSiNiaoWork_JustCompleteGame:_onCompleteGameDone()
	GaoSiNiaoBattleModel.instance:setServerCompleted(true, self._episodeId)
	self:onSucc()
end

function GaoSiNiaoWork_JustCompleteGame:_onTimeout()
	self:onFail()
end

function GaoSiNiaoWork_JustCompleteGame:clearWork()
	TaskDispatcher.cancelTask(self._onTimeout, self)
	GaoSiNiaoWork_JustCompleteGame.super.clearWork(self)
end

return GaoSiNiaoWork_JustCompleteGame
