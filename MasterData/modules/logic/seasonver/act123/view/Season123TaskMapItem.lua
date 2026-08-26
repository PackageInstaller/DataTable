-- chunkname: @modules/logic/seasonver/act123/view/Season123TaskMapItem.lua

module("modules.logic.seasonver.act123.view.Season123TaskMapItem", package.seeall)

local Season123TaskMapItem = class("Season123TaskMapItem", LuaCompBase)

function Season123TaskMapItem:ctor(param)
	self.param = param
end

function Season123TaskMapItem:init(go)
	self:__onInit()

	self.go = go
	self.stage = self.param.stage
	self.actId = self.param.actId
	self._goroot = gohelper.findChild(self.go, "root")
	self._simageicon = gohelper.findChildSingleImage(self.go, "root/#simage_icon")
	self._txtname = gohelper.findChildText(self.go, "root/#txt_name")
	self._imagechapternum = gohelper.findChildImage(self.go, "root/#image_chapternum")
	self._goprogress = gohelper.findChild(self.go, "root/#go_progress")
	self._gofinish = gohelper.findChild(self.go, "root/#image_finish")
	self._txttime = gohelper.findChildText(self.go, "root/#image_finish/#txt_time")
	self._canvasGroup = self.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.progressItemList = self:getUserDataTb_()

	for i = 1, 5 do
		local progressItem = {}

		progressItem.progressGO = gohelper.findChild(self._goprogress, "#go_progress" .. i)
		progressItem.darkIcon = gohelper.findChild(progressItem.progressGO, "dark")
		progressItem.lightIcon = gohelper.findChild(progressItem.progressGO, "light")
		progressItem.redIcon = gohelper.findChild(progressItem.progressGO, "red")

		table.insert(self.progressItemList, progressItem)
	end

	self.goreddot = gohelper.findChild(self.go, "root/#go_reddot")

	RedDotController.instance:addRedDot(self.goreddot, RedDotEnum.DotNode.Season123StageReward, self.stage)
end

function Season123TaskMapItem:addEventListeners()
	self.addEventCb(self, Season123Controller.instance, Season123Event.clickTaskMapItem, self.setScale, self)
end

function Season123TaskMapItem:removeEventListeners()
	self.removeEventCb(self, Season123Controller.instance, Season123Event.clickTaskMapItem, self.setScale, self)
end

function Season123TaskMapItem:onMapItemClick()
	if Season123TaskModel.instance.curStage == self.stage then
		return
	end

	Season123TaskModel.instance.curStage = self.stage

	local curTaskType = Season123TaskModel.instance.curTaskType

	if curTaskType == Activity123Enum.TaskRewardViewType then
		Season123TaskModel.instance:refreshList(curTaskType)
	end

	Season123Controller.instance:dispatchEvent(Season123Event.clickTaskMapItem)
end

function Season123TaskMapItem:refreshUI()
	local stageConfigList = Season123Config.instance:getStageCos(self.actId)
	local stageConfig = stageConfigList[self.stage]
	local seasonMO = Season123Model.instance:getActInfo(self.actId)
	local hasGetCount, totalRewardCount = seasonMO:getStageRewardCount(self.stage)
	local folder = Season123Model.instance:getSingleBgFolder()

	self._simageicon:LoadImage(ResUrl.getSeason123Icon(folder, "v1a7_season_pic_" .. self.stage))
	UISpriteSetMgr.instance:setSeason123Sprite(self._imagechapternum, "v1a7_season_num_" .. self.stage, true)

	self._txtname.text = stageConfig.name

	local stageMO = seasonMO.stageMap[self.stage]

	if stageMO then
		local minRoundCount = stageMO.minRound

		self._txttime.text = tostring(minRoundCount)

		gohelper.setActive(self._gofinish, minRoundCount > 0)
	else
		gohelper.setActive(self._gofinish, false)
	end

	for i = 1, totalRewardCount do
		gohelper.setActive(self.progressItemList[i].progressGO, true)
		gohelper.setActive(self.progressItemList[i].lightIcon, i <= hasGetCount and i ~= totalRewardCount)
		gohelper.setActive(self.progressItemList[i].darkIcon, hasGetCount < i and hasGetCount < totalRewardCount)
		gohelper.setActive(self.progressItemList[i].redIcon, i == hasGetCount and i == totalRewardCount)
	end

	for i = totalRewardCount + 1, #self.progressItemList do
		gohelper.setActive(self.progressItemList[i].progressGO, false)
	end

	self._canvasGroup.alpha = Season123TaskModel.instance.curStage == self.stage and 1 or 0.5

	local scale = Season123TaskModel.instance.curStage == self.stage and 1 or 0.7

	transformhelper.setLocalScale(self._goroot.transform, scale, scale, scale)
end

function Season123TaskMapItem:setScale()
	if Season123TaskModel.instance.curStage == self.stage then
		self.scaleTweenId = ZProj.TweenHelper.DOScale(self._goroot.transform, 1, 1, 1, 0.5)
		self.canvasTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self.go, self._canvasGroup.alpha, 1, 0.5)
	else
		self.scaleTweenId = ZProj.TweenHelper.DOScale(self._goroot.transform, 0.7, 0.7, 0.7, 0.5)
		self.canvasTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self.go, self._canvasGroup.alpha, 0.5, 0.5)
	end
end

function Season123TaskMapItem:onDestroy()
	self:__onDispose()

	if self.scaleTweenId then
		ZProj.TweenHelper.KillById(self.scaleTweenId)
	end

	if self.canvasTweenId then
		ZProj.TweenHelper.KillById(self.canvasTweenId)
	end
end

return Season123TaskMapItem
