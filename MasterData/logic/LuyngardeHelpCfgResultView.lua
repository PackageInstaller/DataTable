-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeHelpCfgResultView.lua

module("logic.extensions.luyngarde.view.LuyngardeHelpCfgResultView", package.seeall)

local LuyngardeHelpCfgResultView = class("LuyngardeHelpCfgResultView", ViewComponent)

function LuyngardeHelpCfgResultView:ctor()
	LuyngardeHelpCfgResultView.super.ctor(self)
end

function LuyngardeHelpCfgResultView:unbindEvents()
	LuyngardeHelpCfgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAgain)
	GameUtil.rmClickHandler(self._btnHelpOther)
end

function LuyngardeHelpCfgResultView:bindEvents()
	LuyngardeHelpCfgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnAgain, self._onClickAgain, self)
	GameUtil.addClickHandler(self._btnHelpOther, self._onClickHelpOther, self)
end

function LuyngardeHelpCfgResultView:buildUI()
	LuyngardeHelpCfgResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnAgain = self:getGo("btnAgain")
	self._btnHelpOther = self:getGo("btnHelpOther")
	self._txt = self:getTxt("txt")
end

function LuyngardeHelpCfgResultView:onExit()
	LuyngardeHelpCfgResultView.super.onExit(self)
end

function LuyngardeHelpCfgResultView:onEnter()
	LuyngardeHelpCfgResultView.super.onEnter(self)

	self._curInfo = self:getFirstParam()
	self._activityId = self._curInfo.activityId

	local state = self._curInfo.state
	local userName = self._curInfo.userName
	local positionId = self._curInfo.positionId
	local defineId = self._curInfo.defineId
	local exploreCfg = LuyngardeConfig.instance:getChapter3ExploreCfgByPosId(self._activityId, positionId)
	local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self._activityId, defineId)
	local showStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
	local showStar = showStarCfg.showStrar
	local typeTitle = exploreCfg.title

	if state == 3 then
		self._txtTitle.text = "帮打失败"
		self._txt.text = string.format("您未能帮助%s完成%s星%s玩法的挑战！\n您可以选择重新挑战，也可以去帮其他玩家进行挑战。", userName, showStar, typeTitle)

		goutil.setActive(self._btnClose, false)
		goutil.setActive(self._btnAgain, true)
		goutil.setActive(self._btnHelpOther, true)
	elseif state == 4 then
		self._txtTitle.text = "帮打成功"

		local getScore = exploreStarCfg.helpScore

		self._txt.text = string.format("您已成功帮助%s完成%s星%s玩法的挑战！恭喜您获得%s大神积分！", userName, showStar, typeTitle, getScore)

		goutil.setActive(self._btnClose, true)
		goutil.setActive(self._btnAgain, false)
		goutil.setActive(self._btnHelpOther, false)
	end
end

function LuyngardeHelpCfgResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

function LuyngardeHelpCfgResultView:_onClickAgain()
	self:close()
	UIJumper.instance:clear()

	local chapter3HelpFmtMo = LuyngardeController.instance:getChapter3HelpFmtMo()

	UIJumper.instance:pushOneStack(ViewName.CustomMissionView, nil, chapter3HelpFmtMo)
	BattleController.instance:endBattle()
end

function LuyngardeHelpCfgResultView:_onClickHelpOther()
	self:close()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.LuyngardeHelpCenterView, nil, self._activityId)
	BattleController.instance:endBattle()
end

return LuyngardeHelpCfgResultView
