-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EpisodeListCenter.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EpisodeListCenter", package.seeall)

local Season123_2_1EpisodeListCenter = class("Season123_2_1EpisodeListCenter", UserDataDispose)

function Season123_2_1EpisodeListCenter:ctor()
	self:__onInit()
end

function Season123_2_1EpisodeListCenter:dispose()
	self:__onDispose()
end

function Season123_2_1EpisodeListCenter:init(viewGO)
	self.viewGO = viewGO

	self:initComponent()
end

function Season123_2_1EpisodeListCenter:initComponent()
	self._txtpassround = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._txtmapname = gohelper.findChildText(self.viewGO, "#txt_mapname")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._tftime = self._gotime.transform
	self._goprogress = gohelper.findChild(self.viewGO, "progress")
	self._progressActives = self:getUserDataTb_()
	self._progressDeactives = self:getUserDataTb_()
	self._progressHard = self:getUserDataTb_()

	for i = 1, Activity123Enum.SeasonStageStepCount do
		self._progressActives[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/light", i))
		self._progressDeactives[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/dark", i))
		self._progressHard[i] = gohelper.findChild(self.viewGO, string.format("progress/#go_progress%s/red", i))
	end
end

function Season123_2_1EpisodeListCenter:initData(actId, stage)
	self._actId = actId
	self._stageId = stage
end

function Season123_2_1EpisodeListCenter:refreshUI()
	if not self._stageId then
		return
	end

	local stageCO = Season123Config.instance:getStageCo(self._actId, self._stageId)

	if stageCO then
		self._txtmapname.text = stageCO.name
	end

	self:refreshRound()
	self:refreshProgress()
end

function Season123_2_1EpisodeListCenter:refreshRound()
	local seasonMO = Season123Model.instance:getActInfo(self._actId)

	if seasonMO then
		local stageMO = seasonMO:getStageMO(self._stageId)

		if stageMO then
			local round = seasonMO:getTotalRound(self._stageId)

			gohelper.setActive(self._gotime, true)

			self._txtpassround.text = tostring(round)
		else
			gohelper.setActive(self._gotime, false)
		end
	else
		gohelper.setActive(self._gotime, false)
	end
end

Season123_2_1EpisodeListCenter.NoStarTimeAnchorY = -176
Season123_2_1EpisodeListCenter.WithStarTimeAnchorY = -86

function Season123_2_1EpisodeListCenter:refreshProgress()
	local isPass = Season123EpisodeListModel.instance:stageIsPassed()

	gohelper.setActive(self._goprogress, isPass)

	local isShowStar = isPass

	if isPass then
		local curStageStep, maxStep = Season123ProgressUtils.getStageProgressStep(self._actId, self._stageId)

		isShowStar = isShowStar and maxStep > 0

		for i = 1, Activity123Enum.SeasonStageStepCount do
			local isActive = i <= curStageStep
			local keepActive = i <= maxStep

			gohelper.setActive(self._progressActives[i], isActive and i < maxStep)
			gohelper.setActive(self._progressDeactives[i], not isActive and keepActive)
			gohelper.setActive(self._progressHard[i], i == maxStep and curStageStep == maxStep)
		end
	end

	if isShowStar then
		recthelper.setAnchorY(self._tftime, Season123_2_1EpisodeListCenter.WithStarTimeAnchorY)
	else
		recthelper.setAnchorY(self._tftime, Season123_2_1EpisodeListCenter.NoStarTimeAnchorY)
	end
end

return Season123_2_1EpisodeListCenter
