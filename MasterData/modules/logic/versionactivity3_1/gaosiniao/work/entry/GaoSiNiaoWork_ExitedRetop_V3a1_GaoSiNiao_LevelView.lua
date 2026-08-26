-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/entry/GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.entry.GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView", package.seeall)

local GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView = class("GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView", GaoSiNiaoEntryFlow_WorkBase)
local kViewName = ViewName.V3a1_GaoSiNiao_LevelView

function GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView:_getV3a1_GaoSiNiao_LevelViewObj()
	local viewContainer = ViewMgr.instance:getContainer(kViewName)

	if not viewContainer then
		return nil
	end

	return viewContainer:mainView()
end

function GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView:onStart()
	self:clearWork()

	local viewObj_V3a1_GaoSiNiao_LevelView = self:_getV3a1_GaoSiNiao_LevelViewObj()

	if not viewObj_V3a1_GaoSiNiao_LevelView then
		logWarn("viewObj is invalid")

		return self:onSucc()
	end

	if not GaoSiNiaoBattleModel.instance:isServerCompleted() then
		return self:onSucc()
	end

	viewObj_V3a1_GaoSiNiao_LevelView:setActive_btnEndlessGo(false)

	local flow = V3a1_GaoSiNiao_LevelView_OpenFinishFlow.New()

	self:insertWork(GaoSiNiaoWork_WaitFlowDone.s_create(flow, viewObj_V3a1_GaoSiNiao_LevelView))
	self:onSucc()
end

return GaoSiNiaoWork_ExitedRetop_V3a1_GaoSiNiao_LevelView
