-- chunkname: @modules/logic/bgmswitch/define/BGMSwitchEvent.lua

module("modules.logic.bgmswitch.define.BGMSwitchEvent", package.seeall)

local BGMSwitchEvent = _M

BGMSwitchEvent.ItemSelected = GameUtil.getEventId()
BGMSwitchEvent.FilterClassSelect = GameUtil.getEventId()
BGMSwitchEvent.SetPlayingBgm = GameUtil.getEventId()
BGMSwitchEvent.RandomFinished = GameUtil.getEventId()
BGMSwitchEvent.SelectPlayGear = GameUtil.getEventId()
BGMSwitchEvent.FilterItemSelect = GameUtil.getEventId()
BGMSwitchEvent.BgmSwitched = GameUtil.getEventId()
BGMSwitchEvent.BgmFavorite = GameUtil.getEventId()
BGMSwitchEvent.BgmUpdated = GameUtil.getEventId()
BGMSwitchEvent.BGMSwitchClose = GameUtil.getEventId()
BGMSwitchEvent.BgmMarkRead = GameUtil.getEventId()
BGMSwitchEvent.ClickBgmEntranceInGuide = GameUtil.getEventId()
BGMSwitchEvent.BgmDevicePlayNoise = GameUtil.getEventId()
BGMSwitchEvent.PlayShakingAni = GameUtil.getEventId()
BGMSwitchEvent.BGMDeviceShowNormalView = GameUtil.getEventId()
BGMSwitchEvent.ToggleEggForGuide = GameUtil.getEventId()
BGMSwitchEvent.SwitchGearByGuide = GameUtil.getEventId()
BGMSwitchEvent.OnPlayMainBgm = GameUtil.getEventId()
BGMSwitchEvent.SlideValueUpdate = GameUtil.getEventId()
BGMSwitchEvent.BgmProgressEnd = GameUtil.getEventId()

return BGMSwitchEvent
