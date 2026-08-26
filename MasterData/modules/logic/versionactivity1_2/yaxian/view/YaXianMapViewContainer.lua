-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianMapViewContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapViewContainer", package.seeall)

local YaXianMapViewContainer = class("YaXianMapViewContainer", BaseViewContainer)

function YaXianMapViewContainer:buildViews()
	local views = {}

	table.insert(views, YaXianMapView.New())
	table.insert(views, YaXianMapWindowView.New())
	table.insert(views, YaXianMapAudioView.New())
	table.insert(views, TabViewGroup.New(1, "#go_left"))

	return views
end

function YaXianMapViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				true
			}, HelpEnum.HelpId.YaxianChessHelp)
		}
	end
end

function YaXianMapViewContainer:onContainerInit()
	self:initViewParam()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.YaXian)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.YaXian
	})
	AudioMgr.instance:trigger(AudioEnum.YaXian.EnterYaXianMap)
end

function YaXianMapViewContainer:initViewParam()
	self.chapterId = self.viewParam and self.viewParam.chapterId

	if not self.chapterId then
		local lastCanFightEpisodeMo = YaXianModel.instance:getLastCanFightEpisodeMo()

		self.chapterId = lastCanFightEpisodeMo.config.chapterId
	end

	if not YaXianController.instance:checkChapterIsUnlock(self.chapterId) then
		self.chapterId = YaXianEnum.DefaultChapterId
	end
end

function YaXianMapViewContainer:changeChapterId(chapterId)
	if self.chapterId == chapterId then
		return
	end

	self.chapterId = chapterId

	YaXianController.instance:dispatchEvent(YaXianEvent.OnSelectChapterChange)
end

function YaXianMapViewContainer:setVisibleInternal(isVisible)
	if YaXianModel.instance:checkIsPlayingClickAnimation() then
		return
	end

	YaXianMapViewContainer.super.setVisibleInternal(self, isVisible)
end

return YaXianMapViewContainer
