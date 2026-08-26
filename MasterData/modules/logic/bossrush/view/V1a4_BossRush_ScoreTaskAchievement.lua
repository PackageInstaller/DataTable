-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScoreTaskAchievement.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievement", package.seeall)

local V1a4_BossRush_ScoreTaskAchievement = class("V1a4_BossRush_ScoreTaskAchievement", BaseView)

function V1a4_BossRush_ScoreTaskAchievement:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/#go_AssessIcon")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Left/Score/#txt_ScoreNum")
	self._scrollScoreList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ScoreList")
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Block")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_ScoreTaskAchievement:addEvents()
	return
end

function V1a4_BossRush_ScoreTaskAchievement:removeEvents()
	return
end

function V1a4_BossRush_ScoreTaskAchievement:_editableInitView()
	self._txtScoreNum.text = ""

	self._simageFullBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_score_fullbg"))
	self:_initAssessIcon()
end

function V1a4_BossRush_ScoreTaskAchievement:_initAssessIcon()
	local itemClass = V1a4_BossRush_Task_AssessIcon
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, self._goAssessIcon, itemClass.__cname)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function V1a4_BossRush_ScoreTaskAchievement:onUpdateParam()
	return
end

function V1a4_BossRush_ScoreTaskAchievement:onOpen()
	self:setActiveBlock(false)

	self._isStartBlockOnce = nil
	self._isEndBlockOnce = nil

	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setStaticData(false)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshRight, self)
	BossRushController.instance:sendGetTaskInfoRequest()
	self:_refreshLeft()
end

function V1a4_BossRush_ScoreTaskAchievement:onClose()
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, self._refreshRight, self)
end

function V1a4_BossRush_ScoreTaskAchievement:_refresh()
	self:_refreshLeft()
	self:_refreshRight()
end

function V1a4_BossRush_ScoreTaskAchievement:_refreshLeft()
	local viewParam = self.viewParam
	local stage = viewParam.stage
	local highestPoint = BossRushModel.instance:getHighestPoint(stage)

	self._assessIcon:setData(stage, highestPoint)

	self._txtScoreNum.text = BossRushConfig.instance:getScoreStr(highestPoint)
end

function V1a4_BossRush_ScoreTaskAchievement:_refreshRight()
	local viewParam = self.viewParam
	local stage = viewParam.stage
	local dataList = BossRushModel.instance:getTaskMoListByStage(stage)

	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setList(dataList)
end

function V1a4_BossRush_ScoreTaskAchievement:setActiveBlock(isActive, isOnce)
	if isOnce then
		if isActive then
			if self._isStartBlockOnce then
				return
			end

			self._isStartBlockOnce = true
		else
			if self._isEndBlockOnce then
				return
			end

			self._isEndBlockOnce = true
		end
	end

	gohelper.setActive(self._goBlock, isActive)
end

return V1a4_BossRush_ScoreTaskAchievement
