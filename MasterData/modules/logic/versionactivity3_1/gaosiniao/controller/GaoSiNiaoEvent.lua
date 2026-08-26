-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/controller/GaoSiNiaoEvent.lua

module("modules.logic.versionactivity3_1.gaosiniao.controller.GaoSiNiaoEvent", package.seeall)

local GaoSiNiaoEvent = _M
local make = GameUtil.getUniqueTb()

GaoSiNiaoEvent.onReceiveGetAct210InfoReply = make()
GaoSiNiaoEvent.onReceiveAct210SaveEpisodeProgressReply = make()
GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply = make()
GaoSiNiaoEvent.onReceiveAct210ChooseEpisodeBranchReply = make()
GaoSiNiaoEvent.onReceiveAct210EpisodePush = make()

return GaoSiNiaoEvent
