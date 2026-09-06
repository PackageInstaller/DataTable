-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunnorresultView.lua

module("logic.extensions.divinekunlun.view.DivinekunlunnorresultView", package.seeall)

local DivinekunlunnorresultView = class("DivinekunlunnorresultView", ViewComponent)

function DivinekunlunnorresultView:ctor()
	DivinekunlunnorresultView.super.ctor(self)
end

function DivinekunlunnorresultView:unbindEvents()
	DivinekunlunnorresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivinekunlunnorresultView:bindEvents()
	DivinekunlunnorresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function DivinekunlunnorresultView:buildUI()
	DivinekunlunnorresultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtRecord = self:getTxt("txtRecord")
	self._txtCurr = self:getTxt("txtCurr")
end

function DivinekunlunnorresultView:onExit()
	DivinekunlunnorresultView.super.onExit(self)
end

function DivinekunlunnorresultView:onEnter()
	DivinekunlunnorresultView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local pb = DivineKunlunModel.instance:getNorFightPb(self._activityId) or {}
	local info = DivineKunlunModel.instance:getInfo(self._activityId) or {}

	if not info.dailyNormalStageInfo then
		local dailyNormalStageInfo = {}
		local map = {}

		for i, v in ipairs(dailyNormalStageInfo) do
			map[v.left] = v.right
		end

		if not dailyNormalStageInfo[pb.stageArrIndex + 1] then
			self._txtCurr.text = langPara("本次挑战连击次数：%s", checknumber(pb.score))
			self._txtRecord.text = langPara("本关历史连击次数：%s", checknumber(dailyNormalStageInfo[pb.stageArrIndex + 1].right))
		end
	end
end

function DivinekunlunnorresultView:_onClickSure()
	BattleController.instance:endBattle()
	self:close()
end

return DivinekunlunnorresultView
