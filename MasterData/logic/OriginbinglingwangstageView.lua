-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originbinglingwang/view/OriginbinglingwangstageView.lua

module("logic.extensions.originbinglingwang.view.OriginbinglingwangstageView", package.seeall)

local OriginbinglingwangstageView = class("OriginbinglingwangstageView", YinZhiClgStageView)

function OriginbinglingwangstageView:ctor()
	OriginbinglingwangstageView.super.ctor(self)
end

function OriginbinglingwangstageView:unbindEvents()
	OriginbinglingwangstageView.super.unbindEvents(self)
end

function OriginbinglingwangstageView:bindEvents()
	OriginbinglingwangstageView.super.bindEvents(self)
end

function OriginbinglingwangstageView:buildUI()
	OriginbinglingwangstageView.super.buildUI(self)
end

function OriginbinglingwangstageView:onExit()
	OriginbinglingwangstageView.super.onExit(self)
end

function OriginbinglingwangstageView:onEnter()
	OriginbinglingwangstageView.super.onEnter(self)
end

function OriginbinglingwangstageView:_onClickEnter(cfg)
	YinZhiClgController.instance:openMissionview(self._activityId, cfg.phaseId, cfg.stageId, ViewName.OriginbinglingwangresultView)
end

return OriginbinglingwangstageView
