-- chunkname: @modules/logic/main/controller/MainEvent.lua

module("modules.logic.main.controller.MainEvent", package.seeall)

local MainEvent = _M

MainEvent.OnFirstEnterMain = GameUtil.getEventId()
MainEvent.OnMainPopupFlowFinish = GameUtil.getEventId()
MainEvent.OnDailyPopupFlowFinish = GameUtil.getEventId()
MainEvent.OnFuncUnlockRefresh = GameUtil.getEventId()
MainEvent.OnReceiveAddFaithEvent = GameUtil.getEventId()
MainEvent.OnClickSwitchRole = GameUtil.getEventId()
MainEvent.OnSceneClose = GameUtil.getEventId()
MainEvent.OnShowSceneNewbieOpen = GameUtil.getEventId()
MainEvent.ShowMainView = GameUtil.getEventId()
MainEvent.SetMainViewVisible = GameUtil.getEventId()
MainEvent.NotifySetMainViewVisible = GameUtil.getEventId()
MainEvent.ChangeMainHeroSkin = GameUtil.getEventId()
MainEvent.ClickDown = GameUtil.getEventId()
MainEvent.GuideSetDelayTime = GameUtil.getEventId()
MainEvent.ForceStopVoice = GameUtil.getEventId()
MainEvent.PlayOpenAnim = GameUtil.getEventId()
MainEvent.ManuallyOpenMainView = GameUtil.getEventId()
MainEvent.OnMainThumbnailGreetingFinish = GameUtil.getEventId()
MainEvent.OnShowMainThumbnailView = GameUtil.getEventId()
MainEvent.SetMainViewRootVisible = GameUtil.getEventId()
MainEvent.HeroShowInScene = GameUtil.getEventId()
MainEvent.OnPlayViewAnim = GameUtil.getEventId()
MainEvent.SetHeroInScene = GameUtil.getEventId()
MainEvent.OnChangeGMBtnStatus = GameUtil.getEventId()
MainEvent.FocusBGMDevice = GameUtil.getEventId()
MainEvent.FocusBGMDeviceReset = GameUtil.getEventId()
MainEvent.OnRefreshSummonTuziRed = GameUtil.getEventId()

return MainEvent
