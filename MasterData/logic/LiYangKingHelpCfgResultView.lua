-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingHelpCfgResultView.lua

module("logic.extensions.liyangking.view.LiYangKingHelpCfgResultView", package.seeall)

local LiYangKingHelpCfgResultView = class("LiYangKingHelpCfgResultView", ViewComponent)

function LiYangKingHelpCfgResultView:ctor()
	LiYangKingHelpCfgResultView.super.ctor(self)
end

function LiYangKingHelpCfgResultView:unbindEvents()
	LiYangKingHelpCfgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAgain)
	GameUtil.rmClickHandler(self._btnHelpOther)
end

function LiYangKingHelpCfgResultView:bindEvents()
	LiYangKingHelpCfgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnAgain, self._onClickAgain, self)
	GameUtil.addClickHandler(self._btnHelpOther, self._onClickHelpOther, self)
end

function LiYangKingHelpCfgResultView:buildUI()
	LiYangKingHelpCfgResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnAgain = self:getGo("btnAgain")
	self._btnHelpOther = self:getGo("btnHelpOther")
	self._txt = self:getTxt("txt")
end

function LiYangKingHelpCfgResultView:onExit()
	LiYangKingHelpCfgResultView.super.onExit(self)
end

function LiYangKingHelpCfgResultView:onEnter()
	LiYangKingHelpCfgResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgInfoRes, self._onUpdate, self)

	self._curInfo = self:getFirstParam()
	self._activityId = self._curInfo.activityId

	local positionId = self._curInfo.positionId
	local defineId = self._curInfo.defineId
	local exploreCfg = LiYangKingConfig.instance:getChapter3ExploreCfgByPosId(self._activityId, positionId)
	local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, defineId)
	local showStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)

	LiYangKingController.instance:sendPM_PrinceLiyangClgInfoReq(self._activityId)
end

function LiYangKingHelpCfgResultView:_onUpdate()
	local state = self._curInfo.state
	local userName = self._curInfo.userName
	local positionId = self._curInfo.positionId
	local defineId = self._curInfo.defineId
	local exploreCfg = LiYangKingConfig.instance:getChapter3ExploreCfgByPosId(self._activityId, positionId)
	local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, defineId)
	local showStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
	local showStar = showStarCfg.showStrar
	local typeTitle = exploreCfg.title

	if state == 3 then
		self._txtTitle.text = "帮打失败"
		self._txt.text = string.format("您未能帮助%s完成%s星%s玩法的挑战！\n您可以选择重新挑战，也可以去帮其他玩家进行挑战。", userName, showStar, typeTitle)

		goutil.setActive(self._btnClose, false)
		goutil.setActive(self._btnAgain, true)
		goutil.setActive(self._btnHelpOther, true)
	elseif state == 4 then
		local rewardStr = exploreStarCfg.helpPrize
		local matType, matId, matNum = MaterialMgr.getMatParams(rewardStr)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		self._txtTitle.text = "帮打成功"

		local getCurMaxCanHelpNum = LiYangKingController.instance:getMaxCanHelpNum(self._activityId)
		local clgInfo = LiYangKingModel.instance:getClgInfo(self._activityId)
		local curHasHelpNum = clgInfo.helpPrizeTimes
		local firstEnterMaxStateKey = "LiYangKingHelpCfgResultView" .. getCurMaxCanHelpNum
		local isFirstEnterMaxState = GameUtil.getUserDayData(firstEnterMaxStateKey)

		if getCurMaxCanHelpNum <= curHasHelpNum and isFirstEnterMaxState then
			self._txt.text = string.format("您已成功帮助%s完成%s星%s玩法的挑战！帮打次数耗尽，暂未获得奖励", userName, showStar, typeTitle)
		else
			if getCurMaxCanHelpNum <= curHasHelpNum then
				GameUtil.saveUserDayData(firstEnterMaxStateKey, true)
			end

			self._txt.text = string.format("您已成功帮助%s完成%s星%s玩法的挑战！恭喜您获得%d个%s！", userName, showStar, typeTitle, matNum, matName)
		end

		goutil.setActive(self._btnClose, true)
		goutil.setActive(self._btnAgain, false)
		goutil.setActive(self._btnHelpOther, false)
	end
end

function LiYangKingHelpCfgResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

function LiYangKingHelpCfgResultView:_onClickAgain()
	self:close()
	UIJumper.instance:clear()

	local chapter3HelpFmtMo = LiYangKingController.instance:getChapter3HelpFmtMo()

	UIJumper.instance:pushOneStack(ViewName.CustomMissionView, nil, chapter3HelpFmtMo)
	BattleController.instance:endBattle()
end

function LiYangKingHelpCfgResultView:_onClickHelpOther()
	self:close()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.LiYangKingHelpCenterView, nil, self._activityId)
	BattleController.instance:endBattle()
end

return LiYangKingHelpCfgResultView
