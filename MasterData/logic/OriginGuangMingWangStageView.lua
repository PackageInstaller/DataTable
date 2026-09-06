-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originguangmingwang/view/OriginGuangMingWangStageView.lua

module("logic.extensions.originguangmingwang.view.OriginGuangMingWangStageView", package.seeall)

local OriginGuangMingWangStageView = class("OriginGuangMingWangStageView", OriginDiShiTianStageView)

function OriginGuangMingWangStageView:ctor()
	OriginGuangMingWangStageView.super.ctor(self)
end

function OriginGuangMingWangStageView:unbindEvents()
	OriginGuangMingWangStageView.super.unbindEvents(self)
end

function OriginGuangMingWangStageView:bindEvents()
	OriginGuangMingWangStageView.super.bindEvents(self)
end

function OriginGuangMingWangStageView:buildUI()
	OriginGuangMingWangStageView.super.buildUI(self)
end

function OriginGuangMingWangStageView:onExit()
	OriginGuangMingWangStageView.super.onExit(self)
end

function OriginGuangMingWangStageView:onEnter()
	OriginGuangMingWangStageView.super.onEnter(self)
end

function OriginGuangMingWangStageView:_onClickStage(stageId)
	local stageCfg = OriginDiShiTianConfig.instance:getStageCfg(self._activityId, stageId)

	if not string.nilorempty(stageCfg.openTime) then
		local unLockTime = GameUtil.string2time(stageCfg.openTime)

		if unLockTime > ServerTime.now() then
			local date = GameUtil.string2date(stageCfg.openTime)

			FloatWordMgr.instance:show(langPara("%d.%d开启", date.month, date.day))

			return
		end
	end

	if stageId > self._curStageId + 1 then
		FloatWordMgr.instance:show(lang("未通关前置关卡"))
	elseif stageId <= self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		OriginDiShiTianController.instance:openMissionView(self._activityId, stageId, ViewName.OriginGuangMingWangFmtView, ViewName.OriginGuangMingWangResultView)
	end
end

function OriginGuangMingWangStageView:getScoreDesc(score)
	return langPara("至少触发%d次双曜效果", score)
end

return OriginGuangMingWangStageView
