-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/controller/GaoSiNiaoController.lua

module("modules.logic.versionactivity3_1.gaosiniao.controller.GaoSiNiaoController", package.seeall)

local GaoSiNiaoController = class("GaoSiNiaoController", BaseController)

function GaoSiNiaoController:onInit()
	self._sys = GaoSiNiaoSysModel.instance
	self._battle = GaoSiNiaoBattleModel.instance

	self:reInit()
end

function GaoSiNiaoController:reInit()
	GameUtil.onDestroyViewMember(self, "_enterFlow")
	GameUtil.onDestroyViewMember(self, "_exitFlow")
end

function GaoSiNiaoController:onInitFinish()
	return
end

function GaoSiNiaoController:addConstEvents()
	return
end

function GaoSiNiaoController:enterLevelView()
	GaoSiNiaoRpc.instance:sendGetAct210InfoRequest(self._enterLevelViewOnSvrCb, self)
end

function GaoSiNiaoController:_enterLevelViewOnSvrCb(_, resultCode)
	if resultCode ~= 0 then
		logError("GaoSiNiaoController:enterLevelView resultCode=" .. tostring(resultCode))

		return
	end

	ViewMgr.instance:openView(ViewName.V3a1_GaoSiNiao_LevelView)
end

function GaoSiNiaoController:enterGame(episodeId)
	GameUtil.onDestroyViewMember(self, "_enterFlow")

	self._enterFlow = GaoSiNiaoEnterFlow.New()

	self._enterFlow:registerDoneListener(self._onEnterFlowRegisterDoneCb, self)
	self._enterFlow:start(episodeId)
end

function GaoSiNiaoController:_onEnterFlowRegisterDoneCb()
	if not self._enterFlow then
		return
	end

	local gameId = self._enterFlow:gameId()
	local episodeId = self._enterFlow:episodeId()

	if gameId == 0 then
		self:exitGame(episodeId)
	end
end

function GaoSiNiaoController:completeGame(episodeId, progress, callback, cbObj)
	episodeId = episodeId or self._battle:episodeId()

	return GaoSiNiaoRpc.instance:sendAct210FinishEpisodeRequest(episodeId, progress, callback, cbObj)
end

function GaoSiNiaoController:exitGame(episodeId)
	GameUtil.onDestroyViewMember(self, "_exitFlow")

	self._exitFlow = GaoSiNiaoExitFlow.New()

	self._exitFlow:start(episodeId)
end

function GaoSiNiaoController:actId()
	return self._sys:actId()
end

function GaoSiNiaoController:taskType()
	return self._sys:taskType()
end

function GaoSiNiaoController:config()
	return self._sys:config()
end

GaoSiNiaoController.instance = GaoSiNiaoController.New()

return GaoSiNiaoController
