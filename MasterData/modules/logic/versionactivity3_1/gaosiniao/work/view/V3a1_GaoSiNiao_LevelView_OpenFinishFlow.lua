-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/view/V3a1_GaoSiNiao_LevelView_OpenFinishFlow.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.view.V3a1_GaoSiNiao_LevelView_OpenFinishFlow", package.seeall)

local V3a1_GaoSiNiao_LevelView_OpenFinishFlow = class("V3a1_GaoSiNiao_LevelView_OpenFinishFlow", GaoSiNiaoViewFlowBase)

function V3a1_GaoSiNiao_LevelView_OpenFinishFlow:onStart()
	self:addWork(V3a1_GaoSiNiao_LevelViewWork_UnlockPathAnim.New())
	self:addWork(V3a1_GaoSiNiao_LevelViewWork_DisactivePathAnim.New())
	self:addWork(V3a1_GaoSiNiao_LevelViewWork_UnlockEndlessAnim.New())
end

return V3a1_GaoSiNiao_LevelView_OpenFinishFlow
