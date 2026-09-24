-- chunkname: @modules/logic/versionactivity4_0/concertlimit/define/ConcertLimitViewDefine.lua

module("modules.logic.versionactivity4_0.concertlimit.define.ConcertLimitViewDefine", package.seeall)

local ConcertLimitViewDefine = {}

function ConcertLimitViewDefine.init(module_views)
	module_views.ConcertLimitMainView = {
		destroy = 0,
		container = "ConcertLimitMainViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_concert/v4a0_concert_mainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CandyRoomMainView = {
		destroy = 0,
		container = "CandyRoomMainViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_candy/v4a0_candy_mainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		otherRes = {
			rewardItemPath = "ui/viewres/versionactivity_4_0/v4a0_candy/v4a0_candy_mainrewarditem.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.CandyRoomPanelView = {
		destroy = 0,
		container = "CandyRoomPanelViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_candy/v4a0_candy_oncepanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.CandyRoomSkinView = {
		destroy = 0,
		container = "CandyRoomSkinViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_candy/v4a0_candy_skinpanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.CandyRoomRewardDetailView = {
		destroy = 0,
		container = "CandyRoomRewardDetailViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_candy/v4a0_candy_rewardspanelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		otherRes = {
			rewardItemPath = "ui/viewres/versionactivity_4_0/v4a0_candy/v4a0_candy_panelrewarditem.prefab"
		}
	}
	module_views.MusicGameEnterView = {
		destroy = 0,
		container = "MusicGameEnterViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_concert/v4a0_concert_enterview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.MusicGameMainView = {
		destroy = 0,
		container = "MusicGameMainViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_concert/v4a0_concert_gameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.MusicGameResultView = {
		destroy = 0,
		container = "MusicGameResultViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_concert/v4a0_concert_gameresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ActFlipView = {
		destroy = 0,
		container = "ActFlipViewContainer",
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_concert/v4a0_concert_flipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.ActFlipRewardTipsView = {
		destroy = 0,
		container = "ActFlipRewardTipsViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_4_0/v4a0_concert/v4a0_concert_fliprewardview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
end

return ConcertLimitViewDefine
