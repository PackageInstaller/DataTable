-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingDeFmtExView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingDeFmtExView", package.seeall)

local YoungChampionKingDeFmtExView = class("YoungChampionKingDeFmtExView", ViewComponent)

function YoungChampionKingDeFmtExView:ctor()
	YoungChampionKingDeFmtExView.super.ctor(self)
end

function YoungChampionKingDeFmtExView:unbindEvents()
	YoungChampionKingDeFmtExView.super.unbindEvents(self)
end

function YoungChampionKingDeFmtExView:bindEvents()
	YoungChampionKingDeFmtExView.super.bindEvents(self)
end

function YoungChampionKingDeFmtExView:buildUI()
	YoungChampionKingDeFmtExView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
end

function YoungChampionKingDeFmtExView:onExit()
	YoungChampionKingDeFmtExView.super.onExit(self)
end

function YoungChampionKingDeFmtExView:onEnter()
	YoungChampionKingDeFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self._enterStepId = self.customFmtMo.enterStepId
	self._txtTips.text = self._enterStepId == YoungChampionKingEnum.Qualify_Step_Id and "在战区预选赛被挑战时，以此防守阵型应战" or self._enterStepId == YoungChampionKingEnum.Score_Match_Step_Id and "在战区积分赛被挑战时，以此防守阵型应战" or self._enterStepId >= YoungChampionKingEnum.War_Zone_Start_Step_Id and self._enterStepId <= YoungChampionKingEnum.Champion_End_Step_Id and "全服赛战斗时间内未准备，将以此阵型托管完成战斗" or ""
end

return YoungChampionKingDeFmtExView
