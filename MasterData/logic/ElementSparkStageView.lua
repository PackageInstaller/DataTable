-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkStageView.lua

module("logic.extensions.elementspark.view.ElementSparkStageView", package.seeall)

local ElementSparkStageView = class("ElementSparkStageView", ViewComponent)

function ElementSparkStageView:ctor()
	ElementSparkStageView.super.ctor(self)
end

function ElementSparkStageView:unbindEvents()
	ElementSparkStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ElementSparkStageView:bindEvents()
	ElementSparkStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ElementSparkStageView:buildUI()
	ElementSparkStageView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._container = self:getGo("container")
	self._stageGo = self:getGo("stage")
end

function ElementSparkStageView:onExit()
	ElementSparkStageView.super.onExit(self)
end

function ElementSparkStageView:onEnter()
	ElementSparkStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onStoryPlayFinished, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._stageType = ElementSparkController.instance:getActivityStage()

	if self._stageType == GameEnum.ElementSparkStageType.Notopen then
		FloatWordMgr.instance:show("未在活动时间内")
		self:close()
	end

	if self._stageType > 0 then
		if not self._stageType then
			local stageId = 1
			local storyId = ElementSparkConfig.instance:getStoryCfg(self._activityId, stageId).storyId

			if self._stageType == GameEnum.ElementSparkStageType.Signup then
				local key = GameEnum.ElementSparkStageType.Signup .. "_" .. self._activityId

				if not GameUtil.getUserData(key) then
					self:_playStory(key, storyId)
				end

				self:showTabAt(self._container, ViewName.ElementSparkSignUpView, self._stageType)
			elseif self._stageType == GameEnum.ElementSparkStageType.RandomAssigned then
				self:showTabAt(self._container, ViewName.ElementSparkSignUpView, self._stageType)
			elseif self._stageType == GameEnum.ElementSparkStageType.Battle then
				local key = GameEnum.ElementSparkStageType.Battle .. "_" .. self._activityId

				if not GameUtil.getUserData(key) then
					self:_playStory(key, storyId)
				end

				self:showTabAt(self._container, ViewName.ElementSparkSignUpView, self._stageType)
			elseif self._stageType == GameEnum.ElementSparkStageType.Result then
				local key = GameEnum.ElementSparkStageType.Result .. "_" .. self._activityId

				if not GameUtil.getUserData(key) then
					local isWinnerCamp = ElementSparkController.instance:isWinnerCamp()

					if isWinnerCamp then
						storyId = ElementSparkConfig.instance:getStoryCfg(self._activityId, self._stageType).winStoryId
					end

					local isNoCamp = ElementSparkModel.instance:getMyCampId() <= 0

					if isNoCamp then
						storyId = ElementSparkConfig.instance:getStoryCfg(self._activityId, self._stageType).noCampStoryId
					end

					self:_playStory(key, storyId)
				end

				self:showTabAt(self._container, ViewName.ElementSparkSignUpView, self._stageType)
			end

			self._maxStage = 3

			local stage = Mathf.Clamp(self._stageType, 1, self._maxStage)

			for i = 1, self._maxStage do
				local bg = self:getGo("stage/state_" .. i .. "/bg")
				local txtTime = self:getTxt("stage/state_" .. i .. "/txtTime")
				local lock = self:getGo("stage/state_" .. i .. "/lock")

				txtTime.text = ElementSparkController.instance:getStageDescTxt(i)

				local isLock = stage < i

				GameUtil.SetActive(bg, not isLock)
				GameUtil.SetActive(lock, isLock)
			end
		end
	end
end

function ElementSparkStageView:_onStoryPlayFinished()
	if self._stageType == GameEnum.ElementSparkStageType.Battle then
		local list = {}
		local cfgs = {
			{
				tipDesc = "<size=20>每个阵营初始都有自己的根据地，可以通过攻占与己方阵营领地十字相连的地块，打通到龙蛋之间的道路\n地块占领后将持续自动获得阵营积分，占领地块后指挥官可升级地块，增加可派遣的守军数量，强化守军全属性</size>",
				picturePath = "board_yuansuhuozhong_107"
			},
			{
				tipDesc = "<size=20>地图中，有资源地与酒馆，将其周围的地块全部占领后视为占领。资源地将持续产生阵营积分、个人积分、酒馆积分，需要玩家前往根据地内领取；酒馆中可以租借精灵，在挑战时上阵</size>",
				picturePath = "board_yuansuhuozhong_105"
			},
			{
				tipDesc = "<size=20>地图中心为龙蛋，将龙蛋周围的地块占领，即可获得该龙蛋的归属权。获得龙蛋归属权可以获得阵营积分、个人积分以及酒馆积分，与此同时，根据阵营占领龙蛋周边地块的数量，还会额外自动产出不同的阵营积分，阵营积分最高的势力将最终获得胜利！</size>",
				picturePath = "board_yuansuhuozhong_106"
			}
		}

		for i, v in ipairs(cfgs) do
			local info = {}

			info.url = string.format("ui/bigbg/elementspark/%s.png", v.picturePath)
			info.desc = v.tipDesc

			table.insert(list, info)
		end

		TipsFacade.instance:openImageRuleView(list)
	end
end

function ElementSparkStageView:_playStory(key, id)
	GameUtil.saveUserData(key, true)
	StoryController.instance:startStory(id)
end

function ElementSparkStageView:_onClickTip()
	TipsFacade.instance:openRulesView("ElemenstSpark_rule")
end

function ElementSparkStageView:_onClickClose()
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.ElementSpark then
		self:close()
	else
		ElementSparkSceneController.instance:levevScene()
	end
end

return ElementSparkStageView
