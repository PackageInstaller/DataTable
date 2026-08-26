-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/main/define/LaplaceForumViewDefine.lua

module("modules.logic.versionactivity3_4.laplaceforum.main.define.LaplaceForumViewDefine", package.seeall)

local LaplaceForumViewDefine = {}

function LaplaceForumViewDefine.init(module_views)
	module_views.LaplaceForumMainView = {
		destroy = 0,
		container = "LaplaceForumMainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/v3a4_laplacemainview.prefab",
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
	module_views.MiniPartyView = {
		bgBlur = 1,
		container = "MiniPartyViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/v3a4_miniparty_view.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.MiniPartyInviteView = {
		bgBlur = 1,
		container = "MiniPartyInviteViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/v3a4_miniparty_inviteview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.ObserverBoxView = {
		destroy = 0,
		container = "ObserverBoxViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/v3a4_observerboxview.prefab",
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
	module_views.TitleAppointmentView = {
		destroy = 0,
		container = "TitleAppointmentViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/v3a4_titleappointmentview.prefab",
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
	module_views.ChatRoomFingerGamePlayView = {
		destroy = 0,
		container = "ChatRoomFingerGamePlayViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_fingergameplayview.prefab",
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
	module_views.ChatRoomFingerGamePromptView = {
		destroy = 0,
		container = "ChatRoomFingerGamePromptViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_fingergamepromptview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ChatRoomFingerGameResultView = {
		bgBlur = 1,
		container = "ChatRoomFingerGameResultViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_fingergameresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ChatRoomNpcPlayerInfoView = {
		destroy = 0,
		container = "ChatRoomNpcPlayerInfoViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroomnpcplayerinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		customAnimBg = {
			"bg"
		}
	}
	module_views.ChatRoomNpcEasterEggView = {
		destroy = 0,
		container = "ChatRoomNpcEasterEggViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroomnpceastereggview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ChatRoomNpcQAndAView = {
		destroy = 0,
		container = "ChatRoomNpcQAndAViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroomnpcqandaview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ChatRoomLuckyRainView = {
		destroy = 0,
		container = "ChatRoomLuckyRainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroomluckyrainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	module_views.ChatRoomMainView = {
		destroy = 0,
		container = "ChatRoomMainViewContainer",
		mainRes = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroommainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			npcInfo = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroomscenenpcinfo.prefab",
			npcMaterial = "spine/xiaowu_character.mat",
			playerheadinfo = "ui/viewres/versionactivity_3_4/v3a4_laplace/chatroom/v3a4_chatroomsceneplayerheadinfo.prefab",
			joystick = "modules/party_game/ui/viewres/common/common_joystick.prefab"
		}
	}
end

return LaplaceForumViewDefine
