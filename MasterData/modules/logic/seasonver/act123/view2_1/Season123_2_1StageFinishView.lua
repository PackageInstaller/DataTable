-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StageFinishView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StageFinishView", package.seeall)

local Season123_2_1StageFinishView = class("Season123_2_1StageFinishView", BaseView)

function Season123_2_1StageFinishView:onInitView()
	self._txtmapname = gohelper.findChildText(self.viewGO, "#go_progress/#txt_mapname")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._gonew = gohelper.findChild(self.viewGO, "#go_time/#txt_time/#go_new")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1StageFinishView:addEvents()
	return
end

function Season123_2_1StageFinishView:removeEvents()
	return
end

function Season123_2_1StageFinishView:_editableInitView()
	self.userId = PlayerModel.instance:getMyUserId()
	self._progressActives = self:getUserDataTb_()
	self._progressDeactives = self:getUserDataTb_()
	self._progressHard = self:getUserDataTb_()
	self._animProgress = self:getUserDataTb_()

	for i = 1, Activity123Enum.SeasonStageStepCount do
		local go = gohelper.findChild(self.viewGO, "#go_progress/progress/#go_progress" .. i)

		self._progressActives[i] = gohelper.findChild(go, "light")
		self._progressDeactives[i] = gohelper.findChild(go, "dark")
		self._progressHard[i] = gohelper.findChild(go, "red")
		self._animProgress[i] = go:GetComponent(gohelper.Type_Animator)
	end
end

function Season123_2_1StageFinishView:onDestroyView()
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
end

function Season123_2_1StageFinishView:onOpen()
	self._actId = self.viewParam.actId
	self._stageId = self.viewParam.stage

	self:refreshUI()
	TaskDispatcher.runDelay(self.lightStar, self, 0.1)
end

function Season123_2_1StageFinishView:onClose()
	TaskDispatcher.cancelTask(self.lightStar, self)
	TaskDispatcher.cancelTask(self.light, self)
	TaskDispatcher.cancelTask(self.handleDelayAnimTransition, self)
end

function Season123_2_1StageFinishView:refreshUI()
	local stageCO = Season123Config.instance:getStageCo(self._actId, self._stageId)

	if stageCO then
		self._txtmapname.text = stageCO.name
	end

	local seasonMO = Season123Model.instance:getActInfo(self._actId)

	if seasonMO then
		local totalRound = seasonMO:getTotalRound(self._stageId)

		self._txttime.text = tostring(totalRound)
	end
end

function Season123_2_1StageFinishView:handleDelayAnimTransition()
	if self:firstPassStage(self._actId, self._stageId) then
		Season123Controller.instance:openSeasonStoryPagePopView(self._actId, self._stageId)
		self:setAlreadyPass(self._actId, self._stageId)
	else
		Season123Controller.instance:dispatchEvent(Season123Event.StageFinishWithoutStory)
	end

	self:closeThis()
end

function Season123_2_1StageFinishView:lightStar()
	self.curStageStep, self.maxStep = Season123ProgressUtils.getStageProgressStep(self._actId, self._stageId)
	self.lightCnt = 1

	for i = 1, #self._progressDeactives do
		gohelper.setActive(self._progressDeactives[i], i <= self.maxStep)
	end

	TaskDispatcher.runRepeat(self.light, self, 0.1, self.curStageStep)
	TaskDispatcher.runDelay(self.handleDelayAnimTransition, self, 2)
end

function Season123_2_1StageFinishView:light()
	self._animProgress[self.lightCnt]:Play("unlock")
	gohelper.setActive(self._progressActives[self.lightCnt], self.lightCnt <= self.curStageStep and self.lightCnt < self.maxStep)
	gohelper.setActive(self._progressHard[self.lightCnt], self.lightCnt == self.maxStep)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_star)

	if self.lightCnt < self.curStageStep then
		self.lightCnt = self.lightCnt + 1
	elseif self.lightCnt == self.curStageStep then
		self.lightCnt = nil
	end
end

function Season123_2_1StageFinishView:firstPassStage(actId, stage)
	local key = self:getPassKey(actId, stage)

	if not string.nilorempty(key) then
		local rs = PlayerPrefsHelper.getString(key, "")

		return string.nilorempty(rs)
	end
end

function Season123_2_1StageFinishView:setAlreadyPass(actId, stage)
	local key = self:getPassKey(actId, stage)

	if not string.nilorempty(key) then
		PlayerPrefsHelper.setString(key, "1")
	end
end

function Season123_2_1StageFinishView:getPassKey(actId, stage)
	return "FirstPassStage" .. tostring(self.userId) .. "#" .. tostring(actId) .. tostring(stage)
end

return Season123_2_1StageFinishView
