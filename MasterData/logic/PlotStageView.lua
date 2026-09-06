-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotStageView.lua

module("logic.extensions.plotcopy.view.PlotStageView", package.seeall)

local PlotStageView = class("PlotStageView", StageViewBase)
local PlayerPrefs = UnityEngine.PlayerPrefs
local StoryType = {
	btnStory1 = 1,
	openCopyMissionView = 3,
	btnStory2 = 2
}

function PlotStageView:ctor()
	PlotStageView.super.ctor(self)

	self._storyType = StoryType.openCopyMissionView
end

function PlotStageView:buildUI()
	PlotStageView.super.buildUI(self)

	self._imgArrow = self:getGo("main/top/perfectPass/imgArrow")
	self._txtPerfect = self:getGo("main/top/perfectPass/txtPerfect"):GetComponent(goutil.Type_UIText)
end

function PlotStageView:bindEvents()
	PlotStageView.super.bindEvents(self)
	self._btnStory:AddClickListener(self._onClickStory, self)
end

function PlotStageView:unbindEvents()
	PlotStageView.super.unbindEvents(self)
	self._btnStory:RemoveClickListener()
end

function PlotStageView:onEnter()
	PlotStageView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
	self:_initPlayStoryBtn()
end

function PlotStageView:onExit()
	PlotStageView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)
end

function PlotStageView:_onEndStory(storyId)
	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	if storyId == cfg.beforeBattleId and self._storyType == StoryType.openCopyMissionView then
		printInfo("剧情动画播完了！")

		local key = self:_getStoryKey()

		PlayerPrefs.SetInt(key, 1)
		self:_openCopyMissionView()
	end
end

function PlotStageView:_onClickStart()
	local isEnough = PlotCopyModel.instance:isPowerEnough(self._chapterId, self._stageId)
	local isPass = PlotCopyModel.instance:isStagePassed(self._chapterId, self._stageId)

	if not isEnough and isPass then
		ViewMgr.instance:open(ViewName.RecoveryTili)

		return
	end

	if self:_isPlayStory() then
		local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

		if cfg.beforeBattleId > 0 then
			self._storyType = StoryType.openCopyMissionView

			GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.beforeBattleId, StoryModel.StoryType.PlotCopy)
		else
			self:_openCopyMissionView()
		end
	else
		self:_openCopyMissionView()
	end
end

function PlotStageView:_getStoryKey()
	return RoleModel.instance:getUserId() .. CopyConst.playStoryBeforeFmt .. self._chapterId .. self._stageId
end

function PlotStageView:_isPlayStory()
	local name = self:_getStoryKey()
	local nameValue = PlayerPrefs.GetInt(name)

	if nameValue == 0 then
		return true
	else
		return false
	end
end

function PlotStageView:_initPlayStoryBtn()
	self._isShowBtnStory = false

	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)
	local name = RoleModel.instance:getUserId() .. CopyConst.playStoryBeforeFmt .. self._chapterId .. self._stageId
	local nameValue = PlayerPrefs.GetInt(name)

	isShowBtnStory = nameValue ~= 0 and cfg.beforeBattleId > 0

	local name2 = RoleModel.instance:getUserId() .. CopyConst.playStoryInBattle .. self._chapterId .. self._stageId
	local nameValue2 = PlayerPrefs.GetInt(name2)

	self._isShowBtnStory = self._isShowBtnStory or nameValue2 ~= 0 and cfg.afterBattleId > 0

	self._btnStory.gameObject:SetActive(self._isShowBtnStory)
end

function PlotStageView:_onClickStory()
	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	if cfg.beforeBattleId > 0 then
		self._storyType = StoryType.btnStory1

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.beforeBattleId, StoryModel.StoryType.PlotCopy)
	end

	if cfg.afterBattleId > 0 then
		self._storyType = StoryType.btnStory2

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.afterBattleId, StoryModel.StoryType.PlotCopy)
	end
end

function PlotStageView:_refreshView()
	PlotStageView.super._refreshView(self)
	self._perfectPass:SetActive(true)
	self._imgArrow:SetActive(self._teamIsPerfectPass)

	local cfgStage = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	self._txtPerfect.text = string.format("完美通关：阵亡精灵不超过%d个", (cfgStage or nil) and checknumber(string.split(cfgStage.perfectPassCondition, "$")[2]))
end

function PlotStageView:_updateRewardList(cfgTeam)
	if not self._teamIsPerfectPass and not PlotCopyModel.instance:isStagePerfectPass(self._chapterId, self._stageId) then
		local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

		if cfg and not string.nilorempty(cfg.perfectPassMp) then
			local perfectItems = string.split(cfg.perfectPassMp, "#")
			local length = #perfectItems

			for i = 1, length do
				local index = #self._curViewDatas + 1

				self._curViewDatas[index] = self._curViewDatas[index] or {}
				self._curViewDatas[index].rewardStr = perfectItems[i]
				self._curViewDatas[index].isPerfect = true
				self._curViewDatas[index].isFirst = false
				self._curViewDatas[index].isProb = false
			end
		end
	end

	PlotStageView.super._updateRewardList(self, cfgTeam)
end

return PlotStageView
