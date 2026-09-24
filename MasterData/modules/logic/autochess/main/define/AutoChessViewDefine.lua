-- chunkname: @modules/logic/autochess/main/define/AutoChessViewDefine.lua

module("modules.logic.autochess.main.define.AutoChessViewDefine", package.seeall)

local AutoChessViewDefine = class("AutoChessViewDefine")

function AutoChessViewDefine.init(module_views)
	module_views.AutoChessMainView = {
		destroy = 0,
		container = "AutoChessMainViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessmainview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.BadgeItem,
			AutoChessStrEnum.ResPath.WarningItem
		}
	}
	module_views.AutoChessLeaderShowView = {
		destroy = 0,
		container = "AutoChessLeaderShowViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleadershowview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			AutoChessStrEnum.ResPath.LeaderCard
		}
	}
	module_views.AutoChessLeaderNextView = {
		destroy = 0,
		container = "AutoChessLeaderNextViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessleadernextview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		otherRes = {
			AutoChessStrEnum.ResPath.LeaderItem
		}
	}
	module_views.AutoChessCourseView = {
		destroy = 0,
		container = "AutoChessCourseViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscourseview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.BadgeItem
		}
	}
	module_views.AutoChessBadgeView = {
		destroy = 0,
		container = "AutoChessBadgeViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbadgeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.BadgeItem
		}
	}
	module_views.AutoChessLevelView = {
		destroy = 0,
		container = "AutoChessLevelViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesslevelview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.LevelItem
		}
	}
	module_views.AutoChessTaskView = {
		destroy = 0,
		container = "AutoChessTaskViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesstaskview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessTaskItem.prefabPath,
			AutoChessStrEnum.ResPath.WarningItem
		}
	}
	module_views.AutoChessRankUpView = {
		destroy = 0,
		container = "AutoChessRankUpViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbadgeupgradeview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			AutoChessStrEnum.ResPath.BadgeItem
		}
	}
	module_views.AutoChessFriendBattleView = {
		destroy = 0,
		container = "AutoChessFriendBattleViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvpenterview.prefab",
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
	module_views.AutoChessFriendBattleRecordView = {
		destroy = 0,
		container = "AutoChessFriendBattleRecordViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessrecordview.prefab",
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
	module_views.AutoChessFriendListView = {
		destroy = 0,
		container = "AutoChessFriendListViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessfriendlistview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.AutoChessHandBookView = {
		destroy = 0,
		container = "AutoChessHandBookViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessbookview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.ChessCard,
			AutoChessStrEnum.ResPath.LeaderCard
		}
	}
	module_views.AutoChessHandbookPreviewView = {
		bgBlur = 1,
		container = "AutoChessHandbookPreviewViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessbooklevelpreview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Default,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.ChessCard
		}
	}
	module_views.AutoChessCultivateView = {
		destroy = 0,
		container = "AutoChessCultivateViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscultivateview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.WarningItem
		}
	}
	module_views.AutoChessBossBookView = {
		destroy = 0,
		container = "AutoChessBossBookViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessbossbookview.prefab",
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
	module_views.AutoChessSpecialBookView = {
		destroy = 0,
		container = "AutoChessSpecialBookViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessspecialbookview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.CollectionItem,
			AutoChessStrEnum.ResPath.LeaderCard,
			AutoChessStrEnum.ResPath.WarningItem
		}
	}
	module_views.AutoChessCardpackView = {
		destroy = 0,
		container = "AutoChessCardpackViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochesscardpackview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.CardPackItem,
			AutoChessStrEnum.ResPath.LeaderCard,
			AutoChessStrEnum.ResPath.CollectionItem,
			AutoChessStrEnum.ResPath.WarningItem
		}
	}
	module_views.AutoChessGameView = {
		destroy = 0,
		container = "AutoChessGameViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessgameview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		otherRes = {
			AutoChessStrEnum.ResPath.ChessEntity,
			AutoChessStrEnum.ResPath.LeaderEntity
		}
	}
	module_views.AutoChessForcePickView = {
		destroy = 0,
		container = "AutoChessForcePickViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessforcepickview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			AutoChessStrEnum.ResPath.ChessCard
		}
	}
	module_views.AutoChessMallView = {
		destroy = 0,
		container = "AutoChessMallViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessmallview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	module_views.AutoChessMallInfoView = {
		destroy = 0,
		container = "AutoChessMallInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessmallinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			AutoChessStrEnum.ResPath.ChessCard
		}
	}
	module_views.AutoChessMallLevelUpView = {
		destroy = 0,
		container = "AutoChessMallLevelUpViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessstorelevelup.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AutoChessResultView = {
		destroy = 0,
		container = "AutoChessResultViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessresultview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AutoChessPvpSettleView = {
		destroy = 0,
		container = "AutoChessPvpSettleViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvpsettleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			AutoChessStrEnum.ResPath.BadgeItem
		}
	}
	module_views.AutoChessPveSettleView = {
		destroy = 0,
		container = "AutoChessPveSettleViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvesettleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.AutoChessPveFirstSettleView = {
		destroy = 0,
		container = "AutoChessPveFirstSettleViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesspvefirstsettleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AutoChessStartFightView = {
		destroy = 0,
		container = "AutoChessStartFightViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/autochessenteranimview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.AutoChessCrazyModeTipView = {
		destroy = 0,
		container = "AutoChessCrazyModeTipViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesscrazymodetipview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal
	}
	module_views.AutoChessLeaderBuffView = {
		destroy = 0,
		container = "AutoChessLeaderBuffViewContainer",
		maskAlpha = 0,
		bgBlur = 0,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessleaderbuffview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AutoChessCrazySettleView = {
		destroy = 0,
		container = "AutoChessCrazySettleViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesscrazysettleview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal
	}
	module_views.AutoChessBeginView = {
		destroy = 0,
		container = "AutoChessBeginViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochessbeginview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.LeaderItem,
			AutoChessStrEnum.ResPath.CardPackItem
		}
	}
	module_views.AutoChessCollectionView = {
		destroy = 0,
		container = "AutoChessCollectionViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesscollectionview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			AutoChessStrEnum.ResPath.CollectionItem
		}
	}
	module_views.AutoChessWarnUpView = {
		destroy = 0,
		container = "AutoChessWarnUpViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/game/autochesswarnupview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		otherRes = {
			AutoChessStrEnum.ResPath.WarningItem,
			AutoChessStrEnum.ResPath.CardPackItem,
			AutoChessStrEnum.ResPath.CollectionItem,
			AutoChessStrEnum.ResPath.LeaderCard
		}
	}
	module_views.AutoChessAdventureView = {
		destroy = 0,
		container = "AutoChessAdventureViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/v4a0/autochessadventureview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.AutoChessCardpackInfoView = {
		destroy = 0,
		container = "AutoChessCardpackInfoViewContainer",
		bgBlur = 1,
		mainRes = "ui/viewres/versionactivity_2_5/autochess/v4a0/autochesscardpackinfoview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Modal,
		anim = ViewAnim.Internal
	}
	module_views.AutoChessLeaderSelectView = {
		destroy = 0,
		container = "AutoChessLeaderSelectViewContainer",
		mainRes = "ui/viewres/versionactivity_2_5/autochess/v4a0/autochessleaderselectview.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Internal,
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		},
		otherRes = {
			AutoChessStrEnum.ResPath.LeaderSelectItem
		}
	}
end

return AutoChessViewDefine
