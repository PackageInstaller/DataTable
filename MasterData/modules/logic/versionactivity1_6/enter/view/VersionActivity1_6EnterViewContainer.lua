-- chunkname: @modules/logic/versionactivity1_6/enter/view/VersionActivity1_6EnterViewContainer.lua

module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterViewContainer", package.seeall)

local VersionActivity1_6EnterViewContainer = class("VersionActivity1_6EnterViewContainer", BaseViewContainer)

function VersionActivity1_6EnterViewContainer:buildViews()
	self._subViewGroup = TabViewGroup.New(2, "#go_subview")

	return {
		TabViewGroup.New(1, "#go_topleft"),
		self._subViewGroup,
		VersionActivity1_6EnterView.New()
	}
end

function VersionActivity1_6EnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif tabContainerId == 2 then
		local multView = {}

		multView[#multView + 1] = Va1_6DungeonEnterView.New()
		multView[#multView + 1] = V1a6_CachotEnterView.New()
		multView[#multView + 1] = ReactivityEnterview.New()
		multView[#multView + 1] = Va1_6QuNiangEnterView.New()
		multView[#multView + 1] = Va1_6GeTianEnterView.New()
		multView[#multView + 1] = V1a6_BossRush_EnterView.New()
		multView[#multView + 1] = Va1_6SeasonEnterView.New()
		multView[#multView + 1] = RoleStoryEnterView.New()
		multView[#multView + 1] = V1a6_ExploreEnterView.New()

		return multView
	end
end

function VersionActivity1_6EnterViewContainer:selectActTab(jumpTabId, actTabItem)
	self:modifyBgm(actTabItem.actId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, jumpTabId)
end

function VersionActivity1_6EnterViewContainer:onContainerInit()
	ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)
end

function VersionActivity1_6EnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function VersionActivity1_6EnterViewContainer:modifyBgm(actId)
	local modifyFunc = self["onModifyBgmAct" .. actId]

	if modifyFunc then
		modifyFunc(self)

		return
	end

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	bgmId = bgmId ~= 0 and bgmId or AudioEnum.Bgm.Act1_6DungeonBgm1

	if self._curBgmId == bgmId then
		return
	end

	self._curBgmId = bgmId

	if bgmId == AudioEnum.Bgm.Activity128LevelViewBgm then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_6Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm, nil, nil, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	else
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_6Main, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

return VersionActivity1_6EnterViewContainer
