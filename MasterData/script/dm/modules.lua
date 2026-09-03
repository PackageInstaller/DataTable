-- chunkname: @/tmp/or_script/lua_compile/dm/modules.lua

return {
	__startup__ = {
		requires = {
			"dm.base.all",
			"dm.utils.AdjustUtils",
			"dm.utils.VideoSprite",
			"dm.utils.SpineResManager",
			"dm.ContextStartupCommand",
			"dm.assets.uicomponents.ButtonWidgets"
		},
		injections = {
			events = {
				{
					event = "EVT_CONTEXT_STARTUP",
					oneshot = true,
					command = "ContextStartupCommand"
				}
			},
			singletons = {
				"WaitingManager",
				"GameServerAgent"
			}
		}
	},
	launch = {
		requires = {
			"dm.launch.LaunchSceneMediator",
			"dm.gameplay.touch.TouchEffectWidget"
		},
		injections = {
			events = {
				{
					event = "EVT_SYNCHRONIZE_DIFF",
					command = "DiffCommand"
				},
				{
					event = "EVT_OPENURL",
					command = "OpenUrlCommand"
				}
			},
			views = {
				{
					node = "cc.Scene",
					name = "launchScene",
					mediator = "LaunchSceneMediator"
				}
			}
		},
		submodules = {
			{
				name = "gameupdateView",
				requires = {
					"dm.gameplay.commonModule.loading.LoadingWidget",
					"dm.gameplay.commonModule.loading.LoadingTask"
				},
				injections = {
					views = {
						{
							res = "asset/ui/Alert.csb",
							name = "AlertView",
							mediator = "AlertMediator"
						},
						{
							node = "cc.Node",
							name = "loadingView",
							mediator = "LoadingMediator"
						},
						{
							node = "cc.Node",
							name = "enterLoadingView",
							mediator = "EnterLoadingMediator"
						},
						{
							node = "cc.Node",
							name = "commonLoadingView",
							mediator = "CommonLoadingMediator"
						},
						{
							res = "asset/ui/NewHero.csb",
							name = "newHeroView",
							mediator = "NewHeroMediator"
						},
						{
							res = "asset/ui/NewHero.csb",
							name = "newShareView",
							mediator = "NewShareMediator"
						},
						{
							res = "asset/ui/NewSystem.csb",
							name = "NewSystemView",
							mediator = "NewSystemUnlockMediator"
						}
					}
				}
			},
			{
				name = "maskword",
				requires = {
					"dm.gameplay.maskword.service.MaskWordService",
					"dm.gameplay.maskword.controller.MaskWordSystem"
				},
				injections = {
					singletons = {
						"MaskWordSystem"
					},
					classes = {
						"MaskWordService"
					}
				}
			},
			{
				name = "share",
				requires = {
					"dm.gameplay.share.controller.ShareSystem",
					"dm.gameplay.share.service.ShareService",
					"dm.gameplay.share.model.Share"
				},
				injections = {
					singletons = {
						"ShareSystem",
						"Share"
					},
					classes = {
						"ShareService"
					},
					views = {
						{
							res = "asset/ui/Share.csb",
							name = "ShareView",
							mediator = "ShareMediator"
						}
					}
				}
			},
			{
				name = "login",
				requires = {
					"dm.launch.login.LoginService",
					"dm.launch.login.LoginSystem",
					"dm.launch.login.model.Login",
					"dm.launch.login.view.LoginMediator",
					"dm.launch.login.view.LoginServerListMediator",
					"dm.launch.login.view.ServerAnnounceMediator",
					"dm.launch.login.view.ServerAnnounceMediatorNew"
				},
				injections = {
					singletons = {
						"LoginSystem"
					},
					classes = {
						"LoginService"
					},
					views = {
						{
							res = "asset/ui/Login.csb",
							name = "loginView",
							mediator = "LoginMediator"
						},
						{
							res = "asset/ui/LoginQueue.csb",
							name = "loginQueueView",
							mediator = "LoginQueueMediator"
						},
						{
							res = "asset/ui/LoginServerList.csb",
							name = "LoginServerView",
							mediator = "LoginServerListMediator"
						},
						{
							res = "asset/ui/ServerAnnounce.csb",
							name = "serverAnnounceView",
							mediator = "ServerAnnounceMediator"
						},
						{
							res = "asset/ui/ServerAnnounceNew.csb",
							name = "serverAnnounceViewNew",
							mediator = "ServerAnnounceMediatorNew"
						}
					}
				}
			}
		}
	},
	login = {
		requires = {
			"dm.gameplay.base.init",
			"dm.utils.init",
			"dm.utils.AudioEngine"
		},
		injections = {},
		submodules = {
			{
				name = "setting",
				requires = {
					"dm.gameplay.setting.controller.SettingSystem",
					"dm.gameplay.setting.service.SettingService",
					"dm.gameplay.setting.controller.SettingCommands",
					"dm.gameplay.tabBtn.TabBtnWidget"
				},
				injections = {
					events = {
						{
							event = "EVT_ENTER_LAUNCH_SCENE",
							oneshot = true,
							command = "InitSettingsCommand"
						}
					},
					singletons = {
						"SettingSystem"
					},
					classes = {
						"SettingService"
					},
					views = {
						{
							res = "asset/ui/settingMain.csb",
							name = "settingView",
							mediator = "SettingMediator"
						},
						{
							res = "asset/ui/SettingCodeExchange.csb",
							name = "SettingCodeExchangeView",
							mediator = "SettingCodeExcMediator"
						},
						{
							res = "asset/ui/changeName.csb",
							name = "changeNameView",
							mediator = "ChangeNameMediator"
						},
						{
							res = "asset/ui/ChangeHeadImg.csb",
							name = "ChangeHeadImgView",
							mediator = "ChangeHeadImgMediator"
						},
						{
							res = "asset/ui/ExitGame.csb",
							name = "ExitGameView",
							mediator = "ExitGameMediator"
						},
						{
							res = "asset/ui/SetSexPopView.csb",
							name = "SetSexPopView",
							mediator = "SetSexPopMediator"
						},
						{
							res = "asset/ui/SetBirthdayPopView.csb",
							name = "SetBirthdayPopView",
							mediator = "SetBirthdayPopMediator"
						},
						{
							res = "asset/ui/SetAreaPopView.csb",
							name = "SetAreaPopView",
							mediator = "SetAreaPopMediator"
						},
						{
							res = "asset/ui/SetTagsPopView.csb",
							name = "SetTagsPopView",
							mediator = "SetTagsPopMediator"
						},
						{
							res = "asset/ui/BugFeedback.csb",
							name = "BugFeedbackView",
							mediator = "BugFeedbackMediator"
						},
						{
							res = "asset/ui/DownloadRes.csb",
							name = "SettingDownloadView",
							mediator = "SettingDownloadMediator"
						},
						{
							res = "asset/ui/DownloadRes.csb",
							name = "DownloadPackageView",
							mediator = "SettingDownloadPackageMediator"
						},
						{
							res = "asset/ui/resourceDownland.csb",
							name = "resourceDownloadPopView",
							mediator = "ResourceDownloadMediator"
						},
						{
							res = "asset/ui/setGameValue.csb",
							name = "GameValueSetView",
							mediator = "GameValueSetMediator"
						},
						{
							res = "asset/ui/Alert.csb",
							name = "DownloadAlertView",
							mediator = "DownloadAlertMediator"
						},
						{
							res = "asset/ui/StoreComments.csb",
							name = "StoreCommentsView",
							mediator = "SettingStoreCommentMediator"
						},
						{
							res = "asset/ui/SetHeroShow.csb",
							name = "SetHeroShowView",
							mediator = "SetHeroShowMediator"
						},
						{
							res = "asset/ui/SetHeroShowDetail.csb",
							name = "SetHeroShowDetailView",
							mediator = "SetHeroShowDetailMediator"
						},
						{
							res = "asset/ui/PlayerTitle.csb",
							name = "PlayerTitleView",
							mediator = "PlayerTitleMediator"
						}
					}
				}
			},
			{
				name = "redpoint",
				requires = {
					"dm.gameplay.redpoint.RedPointWidget",
					"dm.gameplay.redpoint.RedPointManager"
				},
				injections = {
					events = {
						{
							event = "EVT_REDPOINT_REFRESH",
							command = "RedPointRefreshCommond"
						}
					},
					singletons = {},
					classes = {},
					views = {}
				}
			},
			{
				name = "test",
				requires = {
					"dm.gameplay.tests.view.component.TestCell",
					"dm.gameplay.tests.view.component.TestMultiCell_1",
					"dm.gameplay.tests.view.component.TestMultiCell_2",
					"dm.gameplay.tests.view.component.TestMultiCell_3"
				},
				injections = {
					views = {
						{
							res = "asset/ui/Layer_test.csb",
							name = "TestView",
							mediator = "TestViewMediator"
						},
						{
							res = "asset/ui/Layer_testClipping.csb",
							name = "TestClippingNodeView",
							mediator = "TestClippingNodeMediator"
						},
						{
							res = "asset/ui/Layer_testEasyTab.csb",
							name = "TestEasyTabView",
							mediator = "TestEasyTabMediator"
						},
						{
							res = "asset/ui/Layer_testMultiCell.csb",
							name = "TestMultiCellView",
							mediator = "TestMultiCellMediator"
						},
						{
							res = "asset/ui/Layer_testTemp.csb",
							name = "TestTempView",
							mediator = "TestTempViewMediator"
						},
						{
							res = "asset/ui/Layer_testTemp.csb",
							name = "TestPageView",
							mediator = "TestPageViewUtilMediator"
						},
						{
							res = "asset/ui/Layer_testTemp.csb",
							name = "TestCollectionView",
							mediator = "TestCollectionViewUtilsMediator"
						},
						{
							res = "asset/ui/Layer_testTemp.csb",
							name = "TestLuaProfilerView",
							mediator = "TestLuaProfilerMediator"
						}
					}
				}
			}
		}
	},
	beforeLoading = {
		requires = {
			"dm.gameplay.develop.controller.RewardSystem",
			"dm.gameplay.develop.controller.DevelopSystem",
			"dm.gameplay.develop.service.DevelopService",
			"dm.gameplay.SystemKeeper",
			"dm.debug.debugBox.init",
			"dm.gameplay.currency.CurrencySystem",
			"dm.gameplay.currency.CurrencyService",
			"dm.gameplay.condition.Conditionkeeper"
		},
		injections = {
			events = {},
			singletons = {
				"DevelopSystem",
				"SystemKeeper",
				"RewardSystem",
				"DebugBox",
				"CurrencySystem",
				"CurrencyService",
				"Conditionkeeper"
			},
			classes = {
				"DevelopService"
			},
			views = {}
		},
		submodules = {}
	},
	gameplay = {
		requires = {},
		injections = {
			events = {},
			singletons = {},
			classes = {},
			views = {
				{
					node = "cc.Scene",
					name = "mainScene",
					mediator = "MainSceneMediator"
				}
			}
		},
		submodules = {
			{
				name = "herosort",
				requires = {
					"dm.gameplay.develop.model.hero.HeroSortFuncs"
				}
			},
			{
				name = "uicomponents",
				requires = {
					"dm.assets.uicomponents.ButtonWidgets",
					"dm.assets.uicomponents.LuaTableView"
				}
			},
			{
				name = "surprise",
				requires = {
					"dm.gameplay.surprise.SurprisePoint",
					"dm.gameplay.surprise.SurprisePointSystem",
					"dm.gameplay.surprise.SurprisePointService",
					"dm.gameplay.surprise.SurprisePointWidget"
				},
				injections = {
					singletons = {
						"SurprisePointSystem"
					},
					classes = {
						"SurprisePointService"
					}
				}
			},
			{
				name = "home",
				requires = {
					"dm.gameplay.home.view.home.PlayerInfoWidget",
					"dm.gameplay.home.view.home.NetInfoWidget",
					"dm.gameplay.tabBtn.PopTabBtnWidget",
					"dm.gameplay.tabBtn.CompositeTabBtnWidget",
					"dm.gameplay.home.controller.HomeSystem",
					"dm.gameplay.home.view.home.Navigation",
					"dm.gameplay.home.controller.AudioTimerSystem",
					"dm.gameplay.home.view.home.BoardHeroScreenWidget"
				},
				injections = {
					singletons = {
						"HomeSystem"
					},
					views = {
						{
							res = "asset/ui/MainScene.csb",
							name = "homeView",
							mediator = "HomeMediator"
						},
						{
							res = "asset/ui/SetBoardHero.csb",
							name = "SetBoardHeroView",
							mediator = "SetBoardHeroPopMediator"
						},
						{
							res = "asset/ui/SetHomeBgPop.csb",
							name = "SetHomeBgPopView",
							mediator = "SetHomeBgPopMediator"
						},
						{
							res = "asset/ui/DailyGiftView.csb",
							name = "DailyGiftView",
							mediator = "DailyGiftViewMediator"
						},
						{
							res = "asset/ui/HeroInteractionView.csb",
							name = "HeroInteractionView",
							mediator = "HeroInteractionViewMediator"
						},
						{
							res = "asset/ui/DebugBustShow.csb",
							name = "DebugBustShowView",
							mediator = "DebugBustShowViewMediator"
						},
						{
							res = "asset/ui/DebugBustShow2.csb",
							name = "DebugBustShowView2",
							mediator = "DebugBustShowViewMediator2"
						},
						{
							res = "asset/ui/DebugBustShow2.csb",
							name = "DebugBustShowView3",
							mediator = "DebugBustShowViewMediator3"
						},
						{
							res = "asset/ui/DebugBustShow2.csb",
							name = "DebugBustUnAwake",
							mediator = "DebugShowBustAniUnAwake"
						}
					}
				}
			},
			{
				name = "bag",
				requires = {
					"dm.gameplay.develop.service.BagService",
					"dm.gameplay.develop.controller.BagSystem"
				},
				injections = {
					singletons = {
						"BagSystem"
					},
					classes = {
						"BagService"
					},
					views = {
						{
							res = "asset/ui/bag.csb",
							name = "BagView",
							mediator = "BagMediator"
						},
						{
							res = "asset/ui/bagBatchUseSell.csb",
							name = "BagBatchUseSellView",
							mediator = "BagBatchUseSellMediator"
						},
						{
							res = "asset/ui/bagUseScroll.csb",
							name = "BagUseScrollView",
							mediator = "BagUseScrollMediator"
						},
						{
							res = "asset/ui/bagGiftChooseOne.csb",
							name = "BagGiftChooseOneView",
							mediator = "BagGiftChooseOneMediator"
						},
						{
							res = "asset/ui/bagSelectMaterial.csb",
							name = "BagSelectMaterialView",
							mediator = "BagSelectMaterialMediator"
						},
						{
							res = "asset/ui/bagURMap.csb",
							name = "BagURMapView",
							mediator = "BagURMapMediator"
						},
						{
							res = "asset/ui/bagURMapDetail.csb",
							name = "BagURMapViewDetailView",
							mediator = "BagURMapViewDetailMediator"
						},
						{
							res = "asset/ui/bagURMapReward.csb",
							name = "BagURMapRewardView",
							mediator = "BagURMapRewardMediator"
						},
						{
							res = "asset/ui/HeroShowTranlate.csb",
							name = "BagURExhangeView",
							mediator = "BagURExhangeMeditor"
						}
					}
				}
			},
			{
				name = "kernel",
				requires = {
					"dm.gameplay.develop.service.KernelService",
					"dm.gameplay.develop.controller.KernelSystem",
					"dm.gameplay.develop.model.kernel.KernelList"
				},
				injections = {
					singletons = {
						"KernelSystem",
						"KernelList"
					},
					classes = {
						"KernelService"
					},
					views = {}
				}
			},
			{
				name = "chat",
				requires = {
					"dm.gameplay.chat.ChatData",
					"dm.gameplay.chat.model.ChatMessage",
					"dm.gameplay.chat.model.Channel",
					"dm.gameplay.chat.model.Chat",
					"dm.gameplay.chat.view.PlayerVipWidget",
					"dm.gameplay.chat.view.ChatMessageWidget",
					"dm.gameplay.chat.view.ChatOperatorWidget",
					"dm.gameplay.chat.view.ChatFlowWidget",
					"dm.gameplay.chat.ChatService",
					"dm.gameplay.chat.ChatSystem",
					"dm.gameplay.chat.view.ChatCommonWidget"
				},
				injections = {
					singletons = {
						"ChatSystem"
					},
					classes = {
						"ChatService"
					},
					views = {
						{
							res = "asset/ui/SmallChat.csb",
							name = "SmallChat",
							mediator = "SmallChatMediator"
						},
						{
							res = "asset/ui/ChatMain.csb",
							name = "chatMainView",
							mediator = "ChatMainMediator"
						}
					}
				}
			},
			{
				name = "herostrength",
				requires = {
					"dm.gameplay.develop.service.HeroService",
					"dm.gameplay.develop.view.herostrength.RelationInfoWidget",
					"dm.gameplay.develop.view.herostrength.RelationHeroWidget",
					"dm.gameplay.develop.view.herostrength.SkillDescWidget",
					"dm.gameplay.develop.view.herostrength.SkillTipWidget",
					"dm.gameplay.develop.view.herostrength.SkillMaxDescWidget"
				},
				injections = {
					classes = {
						"HeroService"
					},
					views = {
						{
							res = "asset/ui/StrengthenLevel.csb",
							name = "HeroStrengthLevelView",
							mediator = "HeroStrengthLevelMediator"
						},
						{
							res = "asset/ui/Source.csb",
							name = "BuyEatItemTipView",
							mediator = "BuyEatItemTipMediator"
						},
						{
							res = "asset/ui/StrengthenEvolution.csb",
							name = "HeroStrengthEvolutionView",
							mediator = "HeroStrengthEvolutionMediator"
						},
						{
							res = "asset/ui/StrengthenStar.csb",
							name = "HeroStrengthStarView",
							mediator = "HeroStrengthStarMediator"
						},
						{
							res = "asset/ui/debrisChangeTip.csb",
							name = "DebrisChangeTipView",
							mediator = "DebrisChangeTipMediator"
						},
						{
							res = "asset/ui/StrengthenSkill.csb",
							name = "HeroStrengthSkillView",
							mediator = "HeroStrengthSkillMediator"
						},
						{
							res = "asset/ui/StrengthenEquip.csb",
							name = "HeroStrengthEquipView",
							mediator = "HeroStrengthEquipMediator"
						},
						{
							res = "asset/ui/SkillShowTip.csb",
							name = "SkillShowTipView",
							mediator = "SkillShowTipMediator"
						},
						{
							res = "asset/ui/HeroUpTip.csb",
							name = "HeroEvolutionUpTipView",
							mediator = "HeroEvolutionUpTipMediator"
						},
						{
							res = "asset/ui/HeroUpTip.csb",
							name = "HeroStarUpTipView",
							mediator = "HeroStarUpTipMediator"
						},
						{
							res = "asset/ui/HeroUpTip.csb",
							name = "HeroLevelUpTipView",
							mediator = "HeroLevelUpTipMediator"
						},
						{
							res = "asset/ui/HeroSound.csb",
							name = "HeroSoundView",
							mediator = "HeroSoundMediator"
						},
						{
							res = "asset/ui/HeroRelation.csb",
							name = "HeroRelationView",
							mediator = "HeroRelationMediator"
						},
						{
							res = "asset/ui/HeroRelationTip.csb",
							name = "HeroRelationChatView",
							mediator = "HeroRelationChatMediator"
						},
						{
							res = "asset/ui/RelationInfoTip.csb",
							name = "RelationInfoTipView",
							mediator = "RelationInfoTipMediator"
						},
						{
							res = "asset/ui/strengthen_soul.csb",
							name = "StrengthSoulView",
							mediator = "StrengthenSoulMediator"
						},
						{
							res = "asset/ui/strengthen_souluptip.csb",
							name = "HeroSoulUpView",
							mediator = "HeroSoulUpMediator"
						},
						{
							res = "asset/ui/strengthen_souldimonduptip.csb",
							name = "HeroSoulDimondUpTipView",
							mediator = "HeroSoulDimondUpTipMediator"
						},
						{
							res = "asset/ui/strengthen_soulinfotip.csb",
							name = "HeroSoulInfoTipView",
							mediator = "HeroSoulInfoTipMediator"
						},
						{
							res = "asset/ui/HeroEquipDressed.csb",
							name = "HeroEquipDressedView",
							mediator = "HeroEquipDressedMediator"
						},
						{
							res = "asset/ui/HeroStarSkill.csb",
							name = "HeroStarSkillView",
							mediator = "HeroStarSkillMediator"
						},
						{
							res = "asset/ui/MessageTask.csb",
							name = "MessageTaskView",
							mediator = "MessageTaskMediator"
						},
						{
							res = "asset/ui/HeroStarBox.csb",
							name = "HeroStarBoxView",
							mediator = "HeroStarBoxMediator"
						},
						{
							res = "asset/ui/HeroStarLevel.csb",
							name = "HeroStarLevelView",
							mediator = "HeroStarLevelMediator"
						},
						{
							res = "asset/ui/HeroStarItemSelect.csb",
							name = "HeroStarItemSelectView",
							mediator = "HeroStarItemSelectMediator"
						},
						{
							res = "asset/ui/StrengthenAwaken.csb",
							name = "HeroStrengthAwakenView",
							mediator = "HeroStrengthAwakenMediator"
						},
						{
							res = "asset/ui/StrengthenAwakenDetail.csb",
							name = "HeroStrengthAwakenDetailView",
							mediator = "HeroStrengthAwakenDetailMediator"
						},
						{
							res = "asset/ui/StrengthenAwakenSuccess.csb",
							name = "HeroStrengthAwakenSuccessView",
							mediator = "HeroStrengthAwakenSuccessMediator"
						},
						{
							res = "asset/ui/HeroShowTranlate.csb",
							name = "HeroGeneralFragmentView",
							mediator = "HeroGeneralFragmentMeditor"
						},
						{
							res = "asset/ui/HeroIdentityAwake.csb",
							name = "HeroIdentityAwakeView",
							mediator = "HeroIdentityAwakeMediator"
						},
						{
							res = "asset/ui/HeroIdentityAwakeSuccess.csb",
							name = "HeroIdentityAwakeSuccessView",
							mediator = "HeroIdentityAwakeSuccessMediator"
						}
					}
				}
			},
			{
				name = "currency",
				requires = {
					"dm.gameplay.currency.CurrencySystem",
					"dm.gameplay.currency.CurrencyService",
					"dm.gameplay.currency.view.CurrencyInfoWidget",
					"dm.gameplay.currency.view.CostNodeWidget"
				},
				injections = {
					singletons = {
						"CurrencySystem",
						"CurrencyService"
					},
					views = {
						{
							res = "asset/ui/CurrencyBuyLayer.csb",
							name = "CurrencyBuyPopView",
							mediator = "CurrencyBuyPopMediator"
						},
						{
							res = "asset/ui/NewCurrencyBuyLayer.csb",
							name = "NewCurrencyBuyPopView",
							mediator = "NewCurrencyBuyPopMediator"
						}
					}
				}
			},
			{
				name = "stage",
				requires = {
					"dm.gameplay.stage.model.StagePointBox",
					"dm.gameplay.stage.controller.StageSystem",
					"dm.gameplay.stage.service.StageService",
					"dm.gameplay.stage.view.component.ChapterUnlockWidget",
					"dm.gameplay.stage.view.component.ChapterBase",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterOneCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterTwoCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterThreeCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterFourCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterFiveCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterSixCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterSevenCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterEightCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterNightCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterTenCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterElevenCell",
					"dm.gameplay.stage.view.component.commonStageMap.ChapterTwelveCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteOneCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteTwoCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteThreeCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteFourCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteFiveCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteSixCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteSevenCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteEightCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteNightCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteTenCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteElevenCell",
					"dm.gameplay.stage.view.component.eliteStageMap.EliteTwelveCell"
				},
				injections = {
					singletons = {
						"StageSystem"
					},
					classes = {
						"StageService"
					},
					views = {
						{
							res = "asset/ui/BlockNormal.csb",
							name = "CommonStageMainView",
							mediator = "CommonStageMainViewMediator"
						},
						{
							res = "asset/ui/BlockTeam.csb",
							name = "StageTeamView",
							mediator = "StageTeamMediator"
						},
						{
							res = "asset/ui/ChangeTeamModelView.csb",
							name = "ChangeTeamModelView",
							mediator = "ChangeTeamModelMediator"
						},
						{
							res = "asset/ui/ChangeTeamMaster.csb",
							name = "ChangeMasterView",
							mediator = "ChangeTeamMasterMediator"
						},
						{
							res = "asset/ui/ChangeTeamTip.csb",
							name = "ChangeTeamView",
							mediator = "ChangeTeamMediator"
						},
						{
							res = "asset/ui/FightWinLayer.csb",
							name = "FightWinView",
							mediator = "FightWinPopViewMediator"
						},
						{
							res = "asset/ui/FightLoseLayer.csb",
							name = "FightLoseView",
							mediator = "FightLosePopViewMediator"
						},
						{
							res = "asset/ui/BlockFightWinLayer.csb",
							name = "StageWinPopView",
							mediator = "StageWinPopMediator"
						},
						{
							res = "asset/ui/FightStatisticPop.csb",
							name = "FightStatisticPopView",
							mediator = "FightStatisticPopMediator"
						},
						{
							res = "asset/ui/StatisticTips.csb",
							name = "StatisticTipsView",
							mediator = "StatisticTipsMediator"
						},
						{
							res = "asset/ui/BlockFightLoseLayer.csb",
							name = "StageLosePopView",
							mediator = "StageLosePopMediator"
						},
						{
							res = "asset/ui/BattleHeroShowLayer.csb",
							name = "battleShowHeroView",
							mediator = "BattleHeroShowPopMediator"
						},
						{
							res = "asset/ui/HeroStoryWinPop.csb",
							name = "HeroStoryWinPopView",
							mediator = "HeroStoryWinPopMediator"
						},
						{
							res = "asset/ui/StageReset.csb",
							name = "StageResetView",
							mediator = "StageResetPopViewMediator"
						},
						{
							res = "asset/ui/BlockSweepLayer.csb",
							name = "StageSweepView",
							mediator = "CommonStageSweepMediator"
						},
						{
							res = "asset/ui/SweepBoxPopLayer.csb",
							name = "SweepBoxPopView",
							mediator = "SweepBoxPopMediator"
						},
						{
							res = "asset/ui/BlockGoStoryPop.csb",
							name = "AlertGoStoryPopView",
							mediator = "AlertGoStoryPopMediator"
						},
						{
							res = "asset/ui/StagePointDetail.csb",
							name = "StagePointDetailView",
							mediator = "StagePointDetailMediator"
						},
						{
							res = "asset/ui/HeroStoryPointView.csb",
							name = "HeroStoryPointDetailView",
							mediator = "HeroStoryPointDetailMediator"
						},
						{
							res = "asset/ui/BlockSectionComplete.csb",
							name = "StageProgressPopView",
							mediator = "StageProgressPopMediator"
						},
						{
							res = "asset/ui/BlockShowRewardLayer.csb",
							name = "StageShowRewardView",
							mediator = "StageBoxRewardMediator"
						},
						{
							res = "asset/ui/BlockChapterView.csb",
							name = "CommonStageChapterView",
							mediator = "CommonStageChapterDetailMediator"
						},
						{
							res = "asset/ui/HeroStoryChapterView.csb",
							name = "HeroStoryChapterView",
							mediator = "HeroStoryChapterDetailMediator"
						},
						{
							res = "asset/ui/BlockMapCell1.csb",
							name = "ChapterOneCell"
						},
						{
							res = "asset/ui/BlockMapCell2.csb",
							name = "ChapterTwoCell"
						},
						{
							res = "asset/ui/BlockMapCell3.csb",
							name = "ChapterThreeCell"
						},
						{
							res = "asset/ui/BlockMapCell4.csb",
							name = "ChapterFourCell"
						},
						{
							res = "asset/ui/BlockMapCell5.csb",
							name = "ChapterFiveCell"
						},
						{
							res = "asset/ui/BlockMapCell6.csb",
							name = "ChapterSixCell"
						},
						{
							res = "asset/ui/BlockMapCell7.csb",
							name = "ChapterSevenCell"
						},
						{
							res = "asset/ui/BlockMapCell8.csb",
							name = "ChapterEightCell"
						},
						{
							res = "asset/ui/BlockMapCell9.csb",
							name = "ChapterNightCell"
						},
						{
							res = "asset/ui/BlockMapCell10.csb",
							name = "ChapterTenCell"
						},
						{
							res = "asset/ui/BlockMapCell11.csb",
							name = "ChapterElevenCell"
						},
						{
							res = "asset/ui/BlockMapCell12.csb",
							name = "ChapterTwelveCell"
						},
						{
							res = "asset/ui/EliteMapCell1.csb",
							name = "EliteOneCell"
						},
						{
							res = "asset/ui/EliteMapCell2.csb",
							name = "EliteTwoCell"
						},
						{
							res = "asset/ui/EliteMapCell3.csb",
							name = "EliteThreeCell"
						},
						{
							res = "asset/ui/EliteMapCell4.csb",
							name = "EliteFourCell"
						},
						{
							res = "asset/ui/EliteMapCell5.csb",
							name = "EliteFiveCell"
						},
						{
							res = "asset/ui/EliteMapCell6.csb",
							name = "EliteSixCell"
						},
						{
							res = "asset/ui/EliteMapCell7.csb",
							name = "EliteSevenCell"
						},
						{
							res = "asset/ui/EliteMapCell8.csb",
							name = "EliteEightCell"
						},
						{
							res = "asset/ui/EliteMapCell9.csb",
							name = "EliteNightCell"
						},
						{
							res = "asset/ui/EliteMapCell10.csb",
							name = "EliteTenCell"
						},
						{
							res = "asset/ui/EliteMapCell11.csb",
							name = "EliteElevenCell"
						},
						{
							res = "asset/ui/EliteMapCell12.csb",
							name = "EliteTwelveCell"
						},
						{
							res = "asset/ui/StoryBlockTeam.csb",
							name = "StoryStageTeamView",
							mediator = "StoryStageTeamMediator"
						}
					}
				}
			},
			{
				name = "heroshow",
				requires = {
					"dm.gameplay.develop.view.herocomponent.SortHeroListComponent",
					"dm.gameplay.develop.view.herocomponent.SortTsoulListComponent",
					"dm.gameplay.develop.view.herocomponent.SortHeroListNewComponent"
				},
				injections = {
					views = {
						{
							res = "asset/ui/HeroShowDetailsNew.csb",
							name = "HeroShowDetailsView",
							mediator = "HeroShowDetailsMediator"
						},
						{
							res = "asset/ui/HeroShowDetailsNew.csb",
							name = "HeroInfoView",
							mediator = "HeroShowDetailsMediator"
						},
						{
							res = "asset/ui/HeroShowMain.csb",
							name = "HeroShowMainView",
							mediator = "HeroShowMainMediator"
						},
						{
							res = "asset/ui/HeroListMain.csb",
							name = "HeroShowListView",
							mediator = "HeroShowListMediator"
						},
						{
							res = "asset/ui/HeroShowPic.csb",
							name = "HeroShowHeroPicView",
							mediator = "HeroShowHeroPicMediator"
						},
						{
							res = "asset/ui/HeroShowOwn.csb",
							name = "HeroShowOwnView",
							mediator = "HeroShowOwnMediator"
						},
						{
							res = "asset/ui/HeroShowNotOwn.csb",
							name = "HeroShowNotOwnView",
							mediator = "HeroShowNotOwnMediator"
						},
						{
							res = "asset/ui/HeroCardDesc.csb",
							name = "HeroCardView",
							mediator = "HeroCardDescMediator"
						},
						{
							res = "asset/ui/HeroRarityTip.csb",
							name = "HeroRarityTipView",
							mediator = "HeroRarityTipMediator"
						}
					}
				}
			},
			{
				name = "master",
				requires = {
					"dm.gameplay.develop.service.MasterService",
					"dm.gameplay.develop.view.master.MasterAttrShowTipWidget",
					"dm.gameplay.develop.view.master.MasterLeadStageSkillTip",
					"dm.gameplay.develop.view.master.MasterLeadStageKuang"
				},
				injections = {
					singletons = {
						"MasterService"
					},
					views = {
						{
							res = "asset/ui/MasterUpstarAni.csb",
							name = "MasterUpstarAniView",
							mediator = "MasterUpstarAniMediator"
						},
						{
							res = "asset/ui/MasterCultivateUI.csb",
							name = "MasterCultivateView",
							mediator = "MasterCultivateMediator"
						},
						{
							res = "asset/ui/debrisChangeTip.csb",
							name = "MasterDebrisChangeTipView",
							mediator = "MasterDebrisChangeTipMediator"
						},
						{
							res = "asset/ui/MasterEnter.csb",
							name = "MasterEnterView",
							mediator = "MasterEnterMediator"
						},
						{
							res = "asset/ui/NewHero.csb",
							name = "NewMasterView",
							mediator = "NewMasterMediator"
						},
						{
							res = "asset/ui/MasterBuyAuraItem.csb",
							name = "MasterBuyAuraItemView",
							mediator = "MasterBuyAuraItemMediator"
						},
						{
							res = "asset/ui/MasterEmblemQualityUp.csb",
							name = "MasterEmblemQualityUpView",
							mediator = "MasterEmblemQualityUpMediator"
						},
						{
							res = "asset/ui/MasterMain.csb",
							name = "MasterMainView",
							mediator = "MasterMainMediator"
						},
						{
							res = "asset/ui/MasterEmblem.csb",
							name = "MasterEmblemView",
							mediator = "MasterEmblemMediator"
						},
						{
							res = "asset/ui/MasterStar.csb",
							name = "MasterStarView",
							mediator = "MasterStarMediator"
						},
						{
							res = "asset/ui/MasterSkill.csb",
							name = "MasterSkillView",
							mediator = "MasterSkillMediator"
						},
						{
							res = "asset/ui/MasterLeaderSkillTips.csb",
							name = "MasterLeaderSkillView",
							mediator = "MasterLeaderSkillMediator"
						},
						{
							res = "asset/ui/MasterLeadStage.csb",
							name = "MasterLeadStageView",
							mediator = "MasterLeadStageMediator"
						},
						{
							res = "asset/ui/MasterLeadStageDetail.csb",
							name = "MasterLeadStageDetailView",
							mediator = "MasterLeadStageDetailMediator"
						},
						{
							res = "asset/ui/MasterCutIn.csb",
							name = "MasterCutInView",
							mediator = "MasterCutInMediator"
						},
						{
							res = "asset/ui/MasterLeadStageAwake.csb",
							name = "MasterLeadStageAwakeView",
							mediator = "MasterLeadStageAwakeMediator"
						}
					}
				}
			},
			{
				name = "equip",
				requires = {
					"dm.gameplay.develop.service.EquipService"
				},
				injections = {
					classes = {
						"EquipService"
					},
					views = {
						{
							res = "asset/ui/EquipMain.csb",
							name = "EquipMainView",
							mediator = "EquipMainMediator"
						},
						{
							res = "asset/ui/EquipStrengthen.csb",
							name = "EquipStrengthenView",
							mediator = "EquipStrengthenMediator"
						},
						{
							res = "asset/ui/EquipStar.csb",
							name = "EquipBreakView",
							mediator = "EquipStarMediator"
						},
						{
							res = "asset/ui/EquipStarUp.csb",
							name = "EquipStarUpView",
							mediator = "EquipStarUpMediator"
						},
						{
							res = "asset/ui/EquipSkillUp.csb",
							name = "EquipSkillUpView",
							mediator = "EquipSkillUpMediator"
						},
						{
							res = "asset/ui/EquipResolve.csb",
							name = "EquipResolveView",
							mediator = "EquipResolveMediator"
						},
						{
							res = "asset/ui/EquipStarLevel.csb",
							name = "EquipStarLevelView",
							mediator = "EquipStarLevelMediator"
						},
						{
							res = "asset/ui/EquipStarItemSelect.csb",
							name = "EquipStarItemSelectView",
							mediator = "EquipStarItemSelectMediator"
						},
						{
							res = "asset/ui/EquipStarBreak.csb",
							name = "EquipStarBreakView",
							mediator = "EquipStarBreakMediator"
						},
						{
							res = "asset/ui/EquipAllUpdate.csb",
							name = "EquipAllUpdateView",
							mediator = "EquipAllUpdateMediator"
						}
					}
				}
			},
			{
				name = "popup",
				requires = {
					"dm.gameplay.popup.PopupBgWidget",
					"dm.gameplay.popup.PopupNormalWidget"
				},
				injections = {
					views = {
						{
							res = "asset/ui/ItemTips.csb",
							name = "ItemTipsView",
							mediator = "ItemTipsMediator"
						},
						{
							res = "asset/ui/BuffTips.csb",
							name = "BuffTipsView",
							mediator = "BuffTipsMediator"
						},
						{
							res = "asset/ui/ItemBuffTips.csb",
							name = "ItemBuffTipsView",
							mediator = "ItemBuffTipsMediator"
						},
						{
							res = "asset/ui/ItemShowTips.csb",
							name = "ItemShowTipsView",
							mediator = "ItemShowTipsMediator"
						},
						{
							res = "asset/ui/EquipTips.csb",
							name = "EquipTipsView",
							mediator = "EquipTipsMediator"
						},
						{
							res = "asset/ui/Source.csb",
							name = "sourceView",
							mediator = "SourceMediator"
						},
						{
							res = "asset/ui/GetReward.csb",
							name = "getRewardView",
							mediator = "GetRewardMediator"
						},
						{
							res = "asset/ui/TSoulCompoundResult.csb",
							name = "TSoulCompoundResultView",
							mediator = "TSoulCompoundResultMediator"
						},
						{
							res = "asset/ui/Athletics.csb",
							name = "FunctionEntranceView",
							mediator = "FunctionEntranceMediator"
						},
						{
							res = "asset/ui/EntranceGodhand.csb",
							name = "EntranceGodhandView",
							mediator = "EntranceGodhandMediator"
						},
						{
							res = "asset/ui/PlayerLevelUp.csb",
							name = "PlayerLevelUpTipView",
							mediator = "PlayerLevelUpTipMediator"
						},
						{
							res = "asset/ui/NativeWebView.csb",
							name = "NativeWebView",
							mediator = "NativeWebViewMediator"
						},
						{
							res = "asset/ui/NativeContentView.csb",
							name = "NativeContentView",
							mediator = "NativeContentViewMediator"
						},
						{
							res = "asset/ui/ShowSomeWordTips.csb",
							name = "ShowSomeWordTipsView",
							mediator = "ShowSomeWordTipsMediator"
						},
						{
							res = "asset/ui/GameIntroduce.csb",
							name = "GameIntroduceView",
							mediator = "GameIntroduceMediator"
						},
						{
							res = "asset/ui/ComposeToEquipTips.csb",
							name = "ComposeToEquipTipsView",
							mediator = "ComposeToEquipTipsMediator"
						}
					}
				}
			},
			{
				name = "recruit",
				requires = {
					"dm.gameplay.recruit.controller.RecruitSystem",
					"dm.gameplay.recruit.service.RecruitService",
					"dm.gameplay.recruit.model.RecruitPool",
					"dm.gameplay.recruit.model.RecruitPoolManager"
				},
				injections = {
					singletons = {
						"RecruitSystem"
					},
					classes = {
						"RecruitService"
					},
					views = {
						{
							res = "asset/ui/RecruitHeroPreview.csb",
							name = "recruitHeroPreviewView",
							mediator = "RecruitHeroPreviewMediator"
						},
						{
							res = "asset/ui/RecruitHeroBox.csb",
							name = "recruitHeroBoxView",
							mediator = "RecruitHeroBoxMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "recruitHeroBoxDetailView",
							mediator = "RecruitHeroBoxDetailMediator"
						},
						{
							res = "asset/ui/RecruitMain.csb",
							name = "RecruitView",
							mediator = "RecruitMainMediator"
						},
						{
							res = "asset/ui/RecruitBuyCard.csb",
							name = "RecruitBuyView",
							mediator = "RecruitBuyCardMediator"
						},
						{
							res = "asset/ui/RecruitTip.csb",
							name = "RecruitTipView",
							mediator = "RecruitTipMediator"
						},
						{
							res = "asset/ui/RecruitCommonPreview.csb",
							name = "RecruitCommonPreviewView",
							mediator = "RecruitCommonPreviewMediator"
						},
						{
							res = "asset/ui/RecruitReward.csb",
							name = "RecruitRewardView",
							mediator = "RecruitRewardMediator"
						},
						{
							res = "asset/ui/RecruitMain_New.csb",
							name = "RecruitNewDrawCardView",
							mediator = "RecruitNewDrawCardMediator"
						},
						{
							res = "asset/ui/RecruitMainTSoul.csb",
							name = "RecruitNewTSDrawCardView",
							mediator = "RecruitNewTSDrawCardMediator"
						},
						{
							res = "asset/ui/RecruitResult.csb",
							name = "RecruitTSResultView",
							mediator = "RecruitTSResultMediator"
						},
						{
							res = "asset/ui/LimitRecruitBox.csb",
							name = "LimitRecruitBoxView",
							mediator = "LimitRecruitBoxMediator"
						},
						{
							res = "asset/ui/LimitRecruitRule.csb",
							name = "LimitRecruitRuleView",
							mediator = "LimitRecruitRuleMediator"
						}
					}
				}
			},
			{
				name = "stagePractice",
				requires = {
					"dm.gameplay.stagePractice.controller.StagePracticeSystem",
					"dm.gameplay.stagePractice.model.StagePractice",
					"dm.gameplay.stagePractice.model.StagePracticeMap",
					"dm.gameplay.stagePractice.model.StagePracticeRankList",
					"dm.gameplay.stagePractice.model.StagePracticeHero",
					"dm.gameplay.stagePractice.model.StagePracticePoint",
					"dm.gameplay.stagePractice.service.StagePracticeService",
					"dm.gameplay.stagePractice.model.StagePracticeEnemyHeroList",
					"dm.gameplay.stagePractice.model.StagePracticeEnemyHero"
				},
				injections = {
					singletons = {
						"StagePracticeSystem"
					},
					classes = {
						"StagePracticeService"
					},
					views = {
						{
							res = "asset/ui/StagePractice.csb",
							name = "StagePracticeMainView",
							mediator = "StagePracticeMediator"
						},
						{
							res = "asset/ui/StagePracticeTeam.csb",
							name = "StagePracticeTeamView",
							mediator = "StagePracticeTeamMediator"
						},
						{
							res = "asset/ui/StagePracticeGuideTip.csb",
							name = "StagePracticeGuideTipView",
							mediator = "StagePracticeGuideTipMediator"
						},
						{
							res = "asset/ui/StagePracticeWin.csb",
							name = "StagePracticeWinView",
							mediator = "StagePracticeWinMediator"
						},
						{
							res = "asset/ui/StagePracticeLose.csb",
							name = "StagePracticeLoseView",
							mediator = "StagePracticeLoseMediator"
						},
						{
							res = "asset/ui/StagePracticeComment.csb",
							name = "StagePracticeCommentView",
							mediator = "StagePracticeCommentMediator"
						},
						{
							res = "asset/ui/StagePracticeEnter.csb",
							name = "StagePracticeEnterView",
							mediator = "StagePracticeEnterMediator"
						},
						{
							res = "asset/ui/StagePracticeSpecialRule.csb",
							name = "StagePracticeSpecialRuleView",
							mediator = "StagePracticeSpecialRuleMediator"
						}
					}
				}
			},
			{
				name = "task",
				requires = {
					"dm.gameplay.task.controller.TaskSystem",
					"dm.gameplay.task.controller.TaskEvent",
					"dm.gameplay.task.service.TaskService",
					"dm.gameplay.task.model.TaskListModel"
				},
				injections = {
					singletons = {
						"TaskSystem",
						"TaskListModel"
					},
					classes = {
						"TaskService"
					},
					views = {
						{
							res = "asset/ui/taskMainUI.csb",
							name = "TaskMainView",
							mediator = "TaskMediator"
						},
						{
							res = "asset/ui/task_daily.csb",
							name = "TaskDailyView",
							mediator = "TaskDailyMediator"
						},
						{
							res = "asset/ui/task_develop.csb",
							name = "TaskGrowView",
							mediator = "TaskGrowMediator"
						},
						{
							res = "asset/ui/task_point.csb",
							name = "TaskStageView",
							mediator = "TaskStageMediator"
						},
						{
							res = "asset/ui/task_achievement.csb",
							name = "TaskAchieveView",
							mediator = "TaskAchieveMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "TaskBoxView",
							mediator = "TaskBoxMediator"
						},
						{
							res = "asset/ui/task_week_reward.csb",
							name = "TaskWeekView",
							mediator = "TaskWeekMediator"
						}
					}
				}
			},
			{
				name = "activity",
				requires = {
					"dm.gameplay.activity.model.ActivityList",
					"dm.gameplay.activity.controller.ActivitySystem",
					"dm.gameplay.activity.service.ActivityService",
					"dm.gameplay.activity.view.ActivityWidget",
					"dm.gameplay.activity.view.shuangdan.ActivityHolidayHero",
					"dm.gameplay.activity.view.worldBoss.WorldBossHero"
				},
				injections = {
					singletons = {
						"ActivitySystem"
					},
					classes = {
						"ActivityService"
					},
					views = {
						{
							res = "asset/ui/EightDayLogin.csb",
							name = "eightDayLoginView",
							mediator = "EightDayLoginMediator"
						},
						{
							res = "asset/ui/CommonEightDayLogin.csb",
							name = "commonEightDayLoginView",
							mediator = "CommonEightDayLoginMediator"
						},
						{
							res = "asset/ui/EliteTaskActivity.csb",
							name = "eliteTaskView",
							mediator = "EliteTaskActivityMediator"
						},
						{
							res = "asset/ui/Carnival.csb",
							name = "CarnivalView",
							mediator = "CarnivalMediator"
						},
						{
							res = "asset/ui/Activity.csb",
							name = "ActivityView",
							mediator = "ActivityMediator"
						},
						{
							res = "asset/ui/TaskActivity.csb",
							name = "TaskActivityView",
							mediator = "TaskActivityMediator"
						},
						{
							res = "asset/ui/ExchangeActivity.csb",
							name = "ExchangeActivityView",
							mediator = "ExchangeActivityMediator"
						},
						{
							res = "asset/ui/BannerActivity.csb",
							name = "BannerActivityView",
							mediator = "BannerActivityMediator"
						},
						{
							res = "asset/ui/GameBoardActivity.csb",
							name = "GameBoardActivityView",
							mediator = "GameBoardActivityMediator"
						},
						{
							res = "asset/ui/MonthCardActivity.csb",
							name = "MonthCardActivityView",
							mediator = "MonthCardActivityMediator"
						},
						{
							res = "asset/ui/MonthCardInfo.csb",
							name = "MCInfoPopView",
							mediator = "MCInfoPopMediator"
						},
						{
							res = "asset/ui/MCBuySuccess.csb",
							name = "MCBuySuccessView",
							mediator = "MCBuySuccessMediator"
						},
						{
							res = "asset/ui/ImageBoardActivity.csb",
							name = "ImageBoardActivityView",
							mediator = "ImageBoardActivityMediator"
						},
						{
							res = "asset/ui/LoginActivity.csb",
							name = "LoginActivityView",
							mediator = "LoginActivityMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "ActivityBoxView",
							mediator = "ActivityBoxMediator"
						},
						{
							res = "asset/ui/FreeStaminaActivity.csb",
							name = "FreeStaminaActivityView",
							mediator = "FreeStaminaActivityMediator"
						},
						{
							res = "asset/ui/ExtraRewardActivity.csb",
							name = "ExtraRewardActivityView",
							mediator = "ExtraRewardActivityMediator"
						},
						{
							res = "asset/ui/QuestionActivity.csb",
							name = "QuestionActivityView",
							mediator = "QuestionActivityMediator"
						},
						{
							res = "asset/ui/CommunityActivity.csb",
							name = "CommunityActivityView",
							mediator = "CommunityActivityMediator"
						},
						{
							res = "asset/ui/ActivityTaskMonthCard.csb",
							name = "ActivityTaskMonthCardView",
							mediator = "ActivityTaskMonthCardMediator"
						},
						{
							res = "asset/ui/ActivityTaskCollect.csb",
							name = "ActivityTaskCollectView",
							mediator = "ActivityTaskCollectMediator"
						},
						{
							res = "asset/ui/ActivityTaskCollect.csb",
							name = "ActivityTaskCollectStarView",
							mediator = "ActivityTaskCollectStarMediator"
						},
						{
							res = "asset/ui/ActivityTaskReached.csb",
							name = "ActivityTaskReachedView",
							mediator = "ActivityTaskReachedMediator"
						},
						{
							res = "asset/ui/ActivityExchange.csb",
							name = "ActivityExchangeView",
							mediator = "ActivityExchangeMediator"
						},
						{
							res = "asset/ui/ActivityLoginLover.csb",
							name = "ActivityLoginLoverView",
							mediator = "ActivityLoginLoverMediator"
						},
						{
							res = "asset/ui/ActivityExchangeTips.csb",
							name = "ActivityExchangeTipView",
							mediator = "ActivityExchangeTipMediator"
						},
						{
							res = "asset/ui/ActivityTaskStageStarNew.csb",
							name = "ActivityTaskStageStarView",
							mediator = "ActivityTaskStageStarMediator"
						},
						{
							res = "asset/ui/ActivityFocusOn.csb",
							name = "ActivityFocusOnView",
							mediator = "ActivityFocusOnMediator"
						},
						{
							res = "asset/ui/ActivityList.csb",
							name = "ActivityListiew",
							mediator = "ActivityListMediator"
						},
						{
							res = "asset/ui/ActivityHeroCollect.csb",
							name = "ActivityHeroCollectView",
							mediator = "ActivityHeroCollectMediator"
						},
						{
							res = "asset/ui/ActivityFateEncounters.csb",
							name = "ActivityFateEncountersView",
							mediator = "ActivityFateEncountersMediator"
						},
						{
							res = "asset/ui/ActivityBlockMain.csb",
							name = "ActivityBlockView",
							mediator = "ActivityBlockMediator"
						},
						{
							res = "asset/ui/ActivityBlockEggs.csb",
							name = "ActivityBlockEggView",
							mediator = "ActivityBlockEggMediator"
						},
						{
							res = "asset/ui/ActivityEggsReward.csb",
							name = "ActivityEggRewardView",
							mediator = "ActivityEggRewardMediator"
						},
						{
							res = "asset/ui/ActivityBlockTask.csb",
							name = "ActivityBlockTaskView",
							mediator = "ActivityBlockTaskMediator"
						},
						{
							res = "asset/ui/ActivityEggsSucc.csb",
							name = "ActivityEggSuccView",
							mediator = "ActivityEggSuccMediator"
						},
						{
							res = "asset/ui/ActivityTaskDaily.csb",
							name = "ActivityTaskDailyView",
							mediator = "ActivityTaskDailyMediator"
						},
						{
							res = "asset/ui/ActivityTaskAchievement.csb",
							name = "ActivityTaskAchievementView",
							mediator = "ActivityTaskAchievementMediator"
						},
						{
							res = "asset/ui/ActivityBlockTeam.csb",
							name = "ActivityBlockTeamView",
							mediator = "ActivityBlockTeamMediator"
						},
						{
							res = "asset/ui/ActivityPointDetail.csb",
							name = "ActivityPointDetailView",
							mediator = "ActivityPointDetailMediator"
						},
						{
							res = "asset/ui/ActivityStageFinish.csb",
							name = "ActivityStageFinishView",
							mediator = "ActivityStageFinishMediator"
						},
						{
							res = "asset/ui/ActivityStageUnFinish.csb",
							name = "ActivityStageUnFinishView",
							mediator = "ActivityStageUnFinishMediator"
						},
						{
							res = "asset/ui/ActivitySagaWin.csb",
							name = "ActivitySagaWinView",
							mediator = "ActivitySagaWinMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportStage.csb",
							name = "ActivitySagaSupportStageView",
							mediator = "ActivitySagaSupportStageMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportScoreReward.csb",
							name = "ActivitySagaSupportScoreRewardView",
							mediator = "ActivitySagaSupportScoreRewardMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportSchedule.csb",
							name = "ActivitySagaSupportScheduleView",
							mediator = "ActivitySagaSupportScheduleMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportRankReward.csb",
							name = "ActivitySagaSupportRankRewardView",
							mediator = "ActivitySagaSupportRankRewardMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportRank.csb",
							name = "ActivitySagaSupportRankView",
							mediator = "ActivitySagaSupportRankMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportClub.csb",
							name = "ActivitySagaSupportClubView",
							mediator = "ActivitySagaSupportClubMediator"
						},
						{
							res = "asset/ui/ActivityBlockSupportMain.csb",
							name = "ActivityBlockSupportView",
							mediator = "ActivityBlockSupportMediator"
						},
						{
							res = "asset/ui/bagBatchUseSell.csb",
							name = "ActivitySagaBatchUseSellView",
							mediator = "ActivitySagaBatchUseSellMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportMap.csb",
							name = "ActivitySagaSupportMapView",
							mediator = "ActivitySagaSupportMapMediator"
						},
						{
							res = "asset/ui/BlockSweepLayer.csb",
							name = "ActivityPointSweepView",
							mediator = "ActivityPointSweepMediator"
						},
						{
							res = "asset/ui/ActivityBlockSummer.csb",
							name = "ActivityBlockSummerView",
							mediator = "ActivityBlockSummerMediator"
						},
						{
							res = "asset/ui/ActivityBlockSummerExchange.csb",
							name = "ActivityBlockSummerExchangeView",
							mediator = "ActivityBlockSummerExchangeMediator"
						},
						{
							res = "asset/ui/RechargeActivity.csb",
							name = "RechargeActivityView",
							mediator = "RechargeActivityMediator"
						},
						{
							res = "asset/ui/RechargeTip.csb",
							name = "RechargeTipView",
							mediator = "RechargeTipMediator"
						},
						{
							res = "asset/ui/ActivityDrawCardFeedback.csb",
							name = "ActivityDrawCardFeedbackView",
							mediator = "ActivityDrawCardFeedbackMediator"
						},
						{
							res = "asset/ui/ActivityBlockSupportMainWxh.csb",
							name = "ActivityBlockSupportWxhView",
							mediator = "ActivityBlockSupportMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportStageWxh.csb",
							name = "ActivitySagaSupportStageWxhView",
							mediator = "ActivitySagaSupportStageWxhMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportScheduleWxh.csb",
							name = "ActivitySagaSupportScheduleWxhView",
							mediator = "ActivitySagaSupportScheduleMediator"
						},
						{
							res = "asset/ui/ActivitySagaSupportRankRewardWxh.csb",
							name = "ActivitySagaSupportRankRewardWxhView",
							mediator = "ActivitySagaSupportRankRewardWxhMediator"
						},
						{
							res = "asset/ui/ActivitySagaWinWxh.csb",
							name = "ActivitySagaWinWxhView",
							mediator = "ActivitySagaWinWxhMediator"
						},
						{
							res = "asset/ui/ActivityBlockWsj.csb",
							name = "ActivityBlockWsjView",
							mediator = "ActivityBlockWsjMediator"
						},
						{
							res = "asset/ui/ActivityBlockHalloweenMap.csb",
							name = "ActivityBlockMapWsjView",
							mediator = "ActivityBlockMapWsjMediator"
						},
						{
							res = "asset/ui/ActivityBlockMonsterShop.csb",
							name = "ActivityBlockMonsterShopView",
							mediator = "ActivityBlockMonsterShopMediator"
						},
						{
							res = "asset/ui/LoginWsjActivity.csb",
							name = "LoginActivityWsjView",
							mediator = "LoginActivityWsjMediator"
						},
						{
							res = "asset/ui/shopBuyUINormal.csb",
							name = "ActivityBlockMonsterShopBuyItemView",
							mediator = "ActivityBlockMonsterShopBuyItemMediator"
						},
						{
							res = "asset/ui/shopSellUI.csb",
							name = "ActivityBlockMonsterShopPopupView",
							mediator = "MonsterShopPopupMediator"
						},
						{
							res = "asset/ui/ActivityColorEggPopup.csb",
							name = "ActivityColorEggView",
							mediator = "ActivityColorEggMediator"
						},
						{
							res = "asset/ui/ActivityBlockSD.csb",
							name = "ActivityBlockHolidayView",
							mediator = "ActivityBlockHolidayMediator"
						},
						{
							res = "asset/ui/ActivityBlockSupportSd.csb",
							name = "ActivitySupportHolidayView",
							mediator = "ActivitySupportHolidayMediator"
						},
						{
							res = "asset/ui/ActivitySupportWinSd.csb",
							name = "ActivitySupportWinHolidayView",
							mediator = "ActivitySupportWinHolidayMediator"
						},
						{
							res = "asset/ui/ActivitySupportRewardSd.csb",
							name = "ActivitySupportRewardHolidayView",
							mediator = "ActivitySupportRewardHolidayMediator"
						},
						{
							res = "asset/ui/ActivitySupportRankSd.csb",
							name = "ActivitySupportRankHolidayView",
							mediator = "ActivitySupportRankHolidayMediator"
						},
						{
							res = "asset/ui/ActivitySupportPailianSd.csb",
							name = "ActivitySupportPailianHolidayView",
							mediator = "ActivitySupportPailianHolidayMediator"
						},
						{
							res = "asset/ui/ActivityBlockFudaiSd.csb",
							name = "ActivityBlockFudaiView",
							mediator = "ActivityBlockFudaiMediator"
						},
						{
							res = "asset/ui/ActivityFudaiPreview.csb",
							name = "ActivityBlockFudaiPreview",
							mediator = "ActivityBlockFudaiPreviewMeditor"
						},
						{
							res = "asset/ui/ActivityPuzzleGame.csb",
							name = "ActivityPuzzleGameView",
							mediator = "ActivityPuzzleGameMediator"
						},
						{
							res = "asset/ui/ActivityPuzzleGameTask.csb",
							name = "ActivityPuzzleGameTaskView",
							mediator = "ActivityPuzzleGameTaskMediator"
						},
						{
							res = "asset/ui/ActivityFudaiPreview.csb",
							name = "ActivityBlockFudaiPreview",
							mediator = "ActivityBlockFudaiPreviewMeditor"
						},
						{
							res = "asset/ui/ActivityBlockDetective.csb",
							name = "ActivityBlockDetectiveView",
							mediator = "ActivityBlockDectiveMediator"
						},
						{
							res = "asset/ui/ActivityBlockMusic.csb",
							name = "ActivityBlockMusicView",
							mediator = "ActivityBlockMusicMediator"
						},
						{
							res = "asset/ui/ActivityBakingMain.csb",
							name = "ActivityBakingMainView",
							mediator = "ActivityBakingMainMediator"
						},
						{
							res = "asset/ui/TimeShopActivityFoolsday.csb",
							name = "TimeShopActivityView",
							mediator = "TimeLimitShopActivityMediator"
						},
						{
							res = "asset/ui/ActivityLogin14Common.csb",
							name = "ActivityLogin14CommonView",
							mediator = "ActivityLogin14CommonMediator"
						},
						{
							res = "asset/ui/ActivityDoubleDrop.csb",
							name = "ResourceDoubleActivityView",
							mediator = "ResourceDoubleActivityMediator"
						},
						{
							res = "asset/ui/ActivityCollapsedMain.csb",
							name = "ActivityCollapsedMainView",
							mediator = "ActivityCollapsedMainMediator"
						},
						{
							res = "asset/ui/dreamChallengeBuffDetail.csb",
							name = "ActivityNpcRoleDetailView",
							mediator = "ActivityNpcRoleDetailMediator"
						},
						{
							res = "asset/ui/ActivityKnightMain.csb",
							name = "ActivityKnightMainView",
							mediator = "ActivityKnightMainMediator"
						},
						{
							res = "asset/ui/ActivitySunflowerMain.csb",
							name = "ActivitySunflowerMainView",
							mediator = "ActivitySunflowerMainMediator"
						},
						{
							res = "asset/ui/ActivityDailyCharge.csb",
							name = "ActivityDailyChargeView",
							mediator = "ActivityDailyChargeMediator"
						},
						{
							res = "asset/ui/ActivityReturn.csb",
							name = "ActivityReturnView",
							mediator = "ActivityReturnMediator"
						},
						{
							res = "asset/ui/ActivityReturnLetter.csb",
							name = "ActivityReturnLetterView",
							mediator = "ActivityReturnLetterMediator"
						},
						{
							res = "asset/ui/RewardBoxShow.csb",
							name = "ActivityReturnLetterRewardView",
							mediator = "ActivityReturnLetterRewardMediator"
						},
						{
							res = "asset/ui/ReturnActivityLogin.csb",
							name = "ReturnActivityLoginView",
							mediator = "ReturnActivityLoginMediator"
						},
						{
							res = "asset/ui/ReturnActivityTaskReached.csb",
							name = "ReturnActivityTaskReachedView",
							mediator = "ReturnActivityTaskReachedMediator"
						},
						{
							res = "asset/ui/ReturnShopActivity.csb",
							name = "ReturnShopActivityView",
							mediator = "ReturnShopActivityMediator"
						},
						{
							res = "asset/ui/ReturnHeroChange.csb",
							name = "ReturnHeroChangeView",
							mediator = "ReturnHeroChangeMediator"
						},
						{
							res = "asset/ui/ActivityFireMain.csb",
							name = "ActivityFireMainView",
							mediator = "ActivityFireMainMediator"
						},
						{
							res = "asset/ui/ActivityBlockZeroTask.csb",
							name = "ActivityBlockZeroTaskView",
							mediator = "ActivityBlockZeroTaskMediator"
						},
						{
							res = "asset/ui/ActivityZeroTaskDaily.csb",
							name = "ActivityZeroTaskDailyView",
							mediator = "ActivityZeroTaskDailyMediator"
						},
						{
							res = "asset/ui/ActivityZeroTaskAchievement.csb",
							name = "ActivityZeroTaskAchievementView",
							mediator = "ActivityZeroTaskAchievementMediator"
						},
						{
							res = "asset/ui/ActivityZeroMain.csb",
							name = "ActivityZeroMainView",
							mediator = "ActivityZeroMainMediator"
						},
						{
							res = "asset/ui/ActivityZeroSelectMap.csb",
							name = "ActivityZeroSelectMapView",
							mediator = "ActivityZeroSelectMapMediator"
						},
						{
							res = "asset/ui/ActivityPointDetail.csb",
							name = "ActivityZeroPointDetailView",
							mediator = "ActivityZeroPointDetailMediator"
						},
						{
							res = "asset/ui/ActivityZeroMap.csb",
							name = "ActivityZeroeMapView",
							mediator = "ActivityZeroMapMediator"
						},
						{
							res = "asset/ui/ActivityZeroMapUI.csb",
							name = "ActivityZeroMapUIView"
						},
						{
							res = "asset/ui/ActivityBlockZeroShop.csb",
							name = "ActivityBlockZeroShopView",
							mediator = "ActivityBlockZeroShopMediator"
						},
						{
							res = "asset/ui/ActivityZeroDiceStep.csb",
							name = "ActivityZeroDiceStepView",
							mediator = "ActivityZeroDiceStepMediator"
						},
						{
							res = "asset/ui/ActivityFemaleMain.csb",
							name = "ActivityFemaleMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityStoryBookMain.csb",
							name = "ActivityStoryBookMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityReZeroMain.csb",
							name = "ActivityReZeroMainView",
							mediator = "ActivityFireMainMediator"
						},
						{
							res = "asset/ui/ActivityDeepSeaMain.csb",
							name = "ActivityDeepSeaMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityMapNew.csb",
							name = "ActivityMapNewView",
							mediator = "ActivityMapNewMediator"
						},
						{
							res = "asset/ui/ActivityPointDetail_New.csb",
							name = "ActivityPointDetailNewView",
							mediator = "ActivityPointDetailNewMediator"
						},
						{
							res = "asset/ui/ActivitySummerReMain.csb",
							name = "ActivitySummerReMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityFireWorksMain.csb",
							name = "ActivityFireWorksMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityTerrorMain.csb",
							name = "ActivityTerrorMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityRiddleMain.csb",
							name = "ActivityRiddleMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityRiddleVote.csb",
							name = "ActivityRiddleVoteView",
							mediator = "ActivityRiddleVoteMediator"
						},
						{
							res = "asset/ui/ActivityMail.csb",
							name = "ActivityMailView",
							mediator = "ActivityMailMediator"
						},
						{
							res = "asset/ui/ActivityAnimalMain.csb",
							name = "ActivityAnimalMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityDuskMain.csb",
							name = "ActivityDuskMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivitySilentNightMain.csb",
							name = "ActivitySilentNightMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityPointDetailRule.csb",
							name = "ActivityPointDetailRuleView",
							mediator = "ActivityPointDetailRuleMediator"
						},
						{
							res = "asset/ui/ActivityDramaMain.csb",
							name = "ActivityDramaMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityOrientMain.csb",
							name = "ActivityFamilyMainView",
							mediator = "ActivityOrientMainMediator"
						},
						{
							res = "asset/ui/ActivityOrientMap.csb",
							name = "ActivityOrientMapView",
							mediator = "ActivityOrientMapMediator"
						},
						{
							res = "asset/ui/ActivityTrialRoad.csb",
							name = "ActivityTrialRoadView",
							mediator = "TrialRoadMainMediator"
						},
						{
							res = "asset/ui/ActivityMagicMain.csb",
							name = "ActivityMagicMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivitySamuraiMain.csb",
							name = "ActivitySamuraiMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityBento.csb",
							name = "ActivityBentoView",
							mediator = "ActivityBentoMediator"
						},
						{
							res = "asset/ui/ActivityBentoPopup.csb",
							name = "ActivityBentoPopupView",
							mediator = "ActivityBentoPopupMediator"
						},
						{
							res = "asset/ui/WorldBossMain.csb",
							name = "WorldBossMainView",
							mediator = "WorldBossMediator"
						},
						{
							res = "asset/ui/WorldBossRank.csb",
							name = "WorldBossRankView",
							mediator = "WorldBossRankMediator"
						},
						{
							res = "asset/ui/WorldBossReward.csb",
							name = "WorldBossRewardView",
							mediator = "WorldBossRewardMediator"
						},
						{
							res = "asset/ui/WorldBossFinish.csb",
							name = "WorldBossFinishView",
							mediator = "WorldBossFinishMediator"
						},
						{
							res = "asset/ui/WorldBossDetail.csb",
							name = "WorldBossDetailView",
							mediator = "WorldBossDetailMediator"
						},
						{
							res = "asset/ui/ArenaRule.csb",
							name = "WorldBossBuffView",
							mediator = "WorldBossBuffMediator"
						},
						{
							res = "asset/ui/ActivitySpringMain.csb",
							name = "ActivitySpringMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityEggTask.csb",
							name = "ActivityEggTaskView",
							mediator = "ActivityEggTaskMediator"
						},
						{
							res = "asset/ui/ActivityEasterMain.csb",
							name = "ActivityEasterMainView",
							mediator = "ActivityCommonMainMediator"
						},
						{
							res = "asset/ui/ActivityBlockSupportMainWxh.csb",
							name = "ActivityBlockSupportNewView",
							mediator = "ActivityBlockSupportNewMediator"
						},
						{
							res = "asset/ui/ActivityAIShop.csb",
							name = "ActivityAIShopView",
							mediator = "ActivityAIShopMediator"
						}
					}
				}
			},
			{
				name = "arena",
				requires = {
					"dm.gameplay.arena.controller.ArenaSystem",
					"dm.gameplay.arena.service.ArenaService"
				},
				injections = {
					singletons = {
						"ArenaSystem"
					},
					classes = {
						"ArenaService"
					},
					views = {
						{
							res = "asset/ui/Arena.csb",
							name = "ArenaView",
							mediator = "ArenaMediator"
						},
						{
							res = "asset/ui/ArenaRoleInfo.csb",
							name = "ArenaRoleView",
							mediator = "ArenaRoleInfoMediator"
						},
						{
							res = "asset/ui/ArenaQuickBattle.csb",
							name = "ArenaQuickBattleView",
							mediator = "ArenaQuickBattleMediator"
						},
						{
							res = "asset/ui/ArenaAward.csb",
							name = "ArenaAwardView",
							mediator = "ArenaAwardMediator"
						},
						{
							res = "asset/ui/ArenaRule.csb",
							name = "ArenaRuleView",
							mediator = "ArenaRuleMediator"
						},
						{
							res = "asset/ui/ArenaReportMain.csb",
							name = "ArenaReportMainView",
							mediator = "ArenaReportMainMediator"
						},
						{
							res = "asset/ui/ArenaBuyTimeDlg.csb",
							name = "ArenaBuyTimesView",
							mediator = "ArenaBuyTimesMediator"
						},
						{
							res = "asset/ui/ArenaVictory.csb",
							name = "ArenaVictoryView",
							mediator = "ArenaVictoryMediator"
						},
						{
							res = "asset/ui/ArenaTeamList.csb",
							name = "ArenaTeamListView",
							mediator = "ArenaTeamListMediator"
						},
						{
							res = "asset/ui/ArenaTeam.csb",
							name = "ArenaTeamView",
							mediator = "ArenaTeamMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "ArenaBoxView",
							mediator = "ArenaBoxMediator"
						},
						{
							res = "asset/ui/ArenaNewSeason.csb",
							name = "ArenaNormalNewSeasonView",
							mediator = "ArenaNormalNewSeasonMediator"
						}
					}
				}
			},
			{
				name = "newArena",
				requires = {
					"dm.gameplay.newArena.controller.ArenaNewSystem",
					"dm.gameplay.newArena.service.ArenaNewService"
				},
				injections = {
					singletons = {
						"ArenaNewSystem"
					},
					classes = {
						"ArenaNewService"
					},
					views = {
						{
							res = "asset/ui/NewArena.csb",
							name = "ArenaNewView",
							mediator = "ArenaNewMediator"
						},
						{
							res = "asset/ui/NewArenaTeamList.csb",
							name = "ArenaNewTeamListView",
							mediator = "ArenaNewTeamListMediator"
						},
						{
							res = "asset/ui/NewArenaTeam.csb",
							name = "ArenaNewTeamView",
							mediator = "ArenaNewTeamMediator"
						},
						{
							res = "asset/ui/NewArenaReward.csb",
							name = "ArenaNewRewardView",
							mediator = "ArenaNewRewardMediator"
						},
						{
							res = "asset/ui/NewArenaRivalInfo.csb",
							name = "ArenaNewRivalView",
							mediator = "ArenaNewRivalMediator"
						},
						{
							res = "asset/ui/NewArenaRank.csb",
							name = "ArenaNewRankView",
							mediator = "ArenaNewRankMediator"
						},
						{
							res = "asset/ui/NewArenaDefendTeam.csb",
							name = "ArenaNewDefendTeamView",
							mediator = "ArenaNewDefendTeamMediator"
						},
						{
							res = "asset/ui/NewArenaRecord.csb",
							name = "ArenaNewRecordView",
							mediator = "ArenaNewRecordMediator"
						},
						{
							res = "asset/ui/ArenaReportMain.csb",
							name = "ArenaNewReportMainView",
							mediator = "ArenaNewReportMainMediator"
						},
						{
							res = "asset/ui/ArenaQuickBattle.csb",
							name = "ArenaNewLoseView",
							mediator = "ArenaNewLoseMediator"
						},
						{
							res = "asset/ui/ArenaNewSeason.csb",
							name = "ArenaNewSeasonView",
							mediator = "ArenaNewSeasonMediator"
						}
					}
				}
			},
			{
				name = "petRace",
				requires = {
					"dm.gameplay.petRace.controller.PetRaceSystem",
					"dm.gameplay.petRace.service.PetRaceService",
					"dm.gameplay.petRace.view.component.PetRaceTeamCellForRegist",
					"dm.gameplay.petRace.view.component.PetRaceHeroIconCell",
					"dm.gameplay.petRace.view.component.PetRaceCostCell",
					"dm.gameplay.petRace.view.component.PetRaceRewardCell",
					"dm.gameplay.petRace.view.component.PetRaceOverCell",
					"dm.gameplay.petRace.view.component.PetRaceRegistRankCell",
					"dm.gameplay.petRace.view.component.PetRaceOverEightCell",
					"dm.gameplay.petRace.view.component.PetRaceTeamCellForSchedule",
					"dm.gameplay.petRace.view.component.PetRaceRegistLayer",
					"dm.gameplay.petRace.view.component.PetRacePrelimLayer",
					"dm.gameplay.petRace.view.component.PetRaceFinalEightLayer",
					"dm.gameplay.petRace.view.component.PetRaceOverLayer",
					"dm.gameplay.petRace.view.component.PetRaceScheduleCurrentLayer",
					"dm.gameplay.petRace.model.PetRace"
				},
				injections = {
					singletons = {
						"PetRaceSystem"
					},
					classes = {
						"PetRaceService",
						"PetRace"
					},
					views = {
						{
							res = "asset/ui/PetRace.csb",
							name = "PetRaceView",
							mediator = "PetRaceMediator"
						},
						{
							res = "asset/ui/Layer_beforRegist.csb",
							name = "PetRaceRegistLayer"
						},
						{
							res = "asset/ui/Layer_prelim.csb",
							name = "PetRacePrelimLayer"
						},
						{
							res = "asset/ui/Layer_final.csb",
							name = "PetRaceFinalEightLayer"
						},
						{
							res = "asset/ui/Layer_over.csb",
							name = "PetRaceOverLayer"
						},
						{
							res = "asset/ui/Layer_petRaceEmbattle_1.csb",
							name = "PetRaceEmbattleForRegistView",
							mediator = "PetRaceEmbattleForRegistMediator"
						},
						{
							res = "asset/ui/PetRaceMainSchedule.csb",
							name = "PetRaceMainScheduleView",
							mediator = "PetRaceMainScheduleMediator"
						},
						{
							res = "asset/ui/PetRaceSchedule.csb",
							name = "PetRaceScheduleView",
							mediator = "PetRaceScheduleMediator"
						},
						{
							res = "asset/ui/Layer_petRace_shout.csb",
							name = "PetRaceShoutView",
							mediator = "PetRaceShoutMediator"
						},
						{
							res = "asset/ui/Layer_petRaceEmbattle_2.csb",
							name = "PetRaceEmBattleForScheduleView",
							mediator = "PetRaceEmBattleForScheduleMediator"
						},
						{
							res = "asset/ui/Layer_petRaceEmbattle_3.csb",
							name = "PetRaceAllTeamEmBattleForScheduleView",
							mediator = "PetRaceAllTeamEmBattleForScheduleMediator"
						},
						{
							res = "asset/ui/Node_schedule_cell1.csb",
							name = "PetRaceCostCell"
						},
						{
							res = "asset/ui/Node_schedule_cell2.csb",
							name = "PetRaceRewardCell"
						},
						{
							res = "asset/ui/Node_schedule_overCell.csb",
							name = "PetRaceOverCell"
						},
						{
							res = "asset/ui/Node_regist_rankCell.csb",
							name = "PetRaceRegistRankCell"
						},
						{
							res = "asset/ui/Node_schedule_eight_overCell.csb",
							name = "PetRaceOverEightCell"
						},
						{
							res = "asset/ui/Node_petTeamCell.csb",
							name = "PetRaceTeamCellForSchedule"
						},
						{
							res = "asset/ui/PetRaceReport.csb",
							name = "PetRaceReportView",
							mediator = "PetRaceReportMediator"
						},
						{
							res = "asset/ui/PetRaceAward.csb",
							name = "PetRaceRewardView",
							mediator = "PetraceAwardMediator"
						},
						{
							res = "asset/ui/Layer_petRace_squad.csb",
							name = "PetRaceSquadView",
							mediator = "PetRaceSquadMediator"
						},
						{
							res = "asset/ui/Layer_petRace_final_squad.csb",
							name = "PetRaceFinalSquadView",
							mediator = "PetRaceFinalSquadMediator"
						},
						{
							res = "asset/ui/Layer_petRace_rule.csb",
							name = "PetRaceRuleView",
							mediator = "PetRaceRuleMediator"
						},
						{
							res = "asset/ui/Layer_schedule_current.csb",
							name = "PetRaceScheduleCurrentLayer"
						},
						{
							res = "asset/ui/Rank.csb",
							name = "PetRaceRankView",
							mediator = "PetRaceRankMediator"
						}
					}
				}
			},
			{
				name = "mail",
				requires = {
					"dm.gameplay.mail.controller.MailSystem",
					"dm.gameplay.mail.service.MailService",
					"dm.gameplay.mail.model.Mail"
				},
				injections = {
					singletons = {
						"MailSystem",
						"Mail"
					},
					classes = {
						"MailService"
					},
					views = {
						{
							res = "asset/ui/Mail.csb",
							name = "MailView",
							mediator = "MailMediator"
						}
					}
				}
			},
			{
				name = "wordpeace",
				requires = {
					"dm.gameplay.worldpeace.controller.WorldPeaceSystem",
					"dm.gameplay.worldpeace.service.WorldPeaceService",
					"dm.gameplay.worldpeace.view.WordPeaceGame",
					"dm.gameplay.worldpeace.view.WorldPeaceActionFactory",
					"dm.gameplay.worldpeace.view.WorldPeaceMemberFactory",
					"dm.gameplay.worldpeace.view.WorldPeaceMember",
					"dm.gameplay.worldpeace.view.WorldPeaceEnum",
					"dm.gameplay.worldpeace.view.WorldPeaceBall",
					"dm.gameplay.worldpeace.view.WorldPeaceBoss",
					"dm.gameplay.worldpeace.view.WorldPeaceClubBossBall",
					"dm.gameplay.worldpeace.view.WorldPeaceClubBossBoss",
					"dm.gameplay.worldpeace.view.worldboss.WordBossBoss",
					"dm.gameplay.worldpeace.view.worldboss.WorldBossBall",
					"dm.gameplay.worldpeace.view.WorldPeaceHandWidget",
					"dm.gameplay.worldpeace.view.worldboss.WorldBossHandWidget",
					"dm.gameplay.worldpeace.view.WorldPeaceCommondWidget",
					"dm.gameplay.worldpeace.view.WordPeaceNotic",
					"dm.gameplay.worldpeace.view.WordPeaceChatOperatorWidget",
					"dm.gameplay.worldpeace.model.BattleField",
					"dm.gameplay.worldpeace.model.Boll",
					"dm.gameplay.worldpeace.model.Boss",
					"dm.gameplay.worldpeace.model.MainPlayer",
					"dm.gameplay.worldpeace.model.WorldPeace",
					"dm.gameplay.worldpeace.model.WorldSwearChat",
					"dm.gameplay.worldpeace.model.WorldBoss"
				},
				injections = {
					singletons = {
						"WorldPeaceSystem"
					},
					classes = {
						"WorldPeaceService"
					},
					views = {
						{
							res = "asset/ui/WordPeaceMain.csb",
							name = "WorldPeaceMainView",
							mediator = "WorldPeaceMainMediator"
						},
						{
							res = "asset/ui/WordPeaceClubBossBattle.csb",
							name = "WorldPeaceBossStageOneView",
							mediator = "WorldPeaceBossStageOneMediator"
						},
						{
							res = "asset/ui/WordPeaceClubBossBattle.csb",
							name = "WorldPeaceBossStageTwoView",
							mediator = "WorldPeaceBossStageTwoMediator"
						},
						{
							res = "asset/ui/ClubBossRuleTip.csb",
							name = "ClubBossRuleTipsView",
							mediator = "ClubBossRuleTipsMediator"
						},
						{
							res = "asset/ui/ClubBossNewReward.csb",
							name = "ClubBossNewRewardView",
							mediator = "ClubBossNewRewardMediator"
						},
						{
							res = "asset/ui/WordPeaceBattle.csb",
							name = "WordPeaceBattleView",
							mediator = "WordPeaceBattleMediator"
						},
						{
							res = "asset/ui/WordPeaceTeam.csb",
							name = "WordPeaceTeamInfoView",
							mediator = "WordPeaceTeamInfoMediator"
						},
						{
							res = "asset/ui/WorldPeaceApply.csb",
							name = "WorldPeaceApplyView",
							mediator = "WorldPeaceApplyMediator"
						},
						{
							res = "asset/ui/WorldPeaceRank.csb",
							name = "WorldPeaceRankView",
							mediator = "WorldPeaceRankMediator"
						},
						{
							res = "asset/ui/WorldPeaceClubRank.csb",
							name = "WorldPeaceClubRankView",
							mediator = "WorldPeaceClubRankMediator"
						},
						{
							res = "asset/ui/WordPeaceHurtRank.csb",
							name = "WordPeaceHurtView",
							mediator = "WordPeaceHurtMediator"
						},
						{
							res = "asset/ui/WorldPeaceMemberRank.csb",
							name = "WorldPeaceMemberRankView",
							mediator = "WorldPeaceMemberRankMediator"
						},
						{
							res = "asset/ui/WorldPeaceReward.csb",
							name = "WorldPeaceRewardView",
							mediator = "WorldPeaceRewardMediator"
						},
						{
							res = "asset/ui/WorldPeaceRule.csb",
							name = "WorldPeaceRuleView",
							mediator = "WorldPeaceRuleMediator"
						},
						{
							res = "asset/ui/WordPeacePlayer.csb",
							name = "WordPeacePlayerInfoView",
							mediator = "WordPeacePlayerInfoMediator"
						},
						{
							res = "asset/ui/WorldPeaceTips.csb",
							name = "WorldPeaceTipsView",
							mediator = "WorldPeaceTipsMediator"
						},
						{
							res = "asset/ui/WordPeaceGuide.csb",
							name = "WordPeaceGuideView",
							mediator = "WordPeaceGuideMediator"
						},
						{
							res = "asset/ui/WorldPeaceTopRankTips.csb",
							name = "WorldPeaceTopRankTipsView",
							mediator = "WorldPeaceTopRankTipsMediator"
						},
						{
							res = "asset/ui/WorldPeaceMyRankTips.csb",
							name = "WorldPeaceMyRankTipsView",
							mediator = "WorldPeaceMyRankTipsMediator"
						},
						{
							res = "asset/ui/WordPeaceSwearMain.csb",
							name = "WordPeaceSwearMainView",
							mediator = "WordPeaceSwearMainMediator"
						},
						{
							res = "asset/ui/WordPeaceSwearDetail.csb",
							name = "WordPeaceSwearDetailView",
							mediator = "WordPeaceSwearDetailMediator"
						},
						{
							res = "asset/ui/WordPeaceChoseBoss.csb",
							name = "WordPeaceChoseBossView",
							mediator = "WordPeaceChoseBossMediator"
						},
						{
							res = "asset/ui/WorldSpaceSwearRule.csb",
							name = "WordPeaceSwearRuleView",
							mediator = "WordPeaceSwearRuleMediator"
						},
						{
							res = "asset/ui/clubNewHall.csb",
							name = "WordPeaceAssociationMainView",
							mediator = "WordPeaceAssociationMainMediator"
						},
						{
							res = "asset/ui/WordPeaceSelfRank.csb",
							name = "WordPeaceSelfRankView",
							mediator = "WordPeaceSelfRankMediator"
						},
						{
							res = "asset/ui/WordPeaceChatReward.csb",
							name = "WordPeaceChatRewardView",
							mediator = "WordPeaceChatRewardMediator"
						},
						{
							res = "asset/ui/WordPeaceSwearTips.csb",
							name = "WordPeaceSwearTipsView",
							mediator = "WordPeaceSwearTipsMediator"
						},
						{
							res = "asset/ui/WordBossFinish.csb",
							name = "WordBossFinishView",
							mediator = "WordBossFinishMediator"
						},
						{
							res = "asset/ui/WorldBossMatch.csb",
							name = "WorldBossMatchView",
							mediator = "WorldBossMatchMediator"
						},
						{
							res = "asset/ui/WordBossBattle.csb",
							name = "WordBossBattleView",
							mediator = "WordBossBattleMediator"
						},
						{
							res = "asset/ui/WorldPeaceTask.csb",
							name = "WorldPeaceTaskView",
							mediator = "WorldPeaceTaskMediator"
						}
					}
				}
			},
			{
				name = "building",
				requires = {
					"dm.gameplay.building.model.BuildingConfig",
					"dm.gameplay.building.service.BuildingService",
					"dm.gameplay.building.controller.BuildingSystem",
					"dm.gameplay.building.controller.BuildingShopSystem",
					"dm.gameplay.building.controller.BuildingEvent",
					"dm.gameplay.building.view.component.BuildingBuildCell",
					"dm.gameplay.building.view.component.BuildingDecorateComponent",
					"dm.gameplay.building.view.component.BuildingDecorate",
					"dm.gameplay.building.view.component.BuildingFloorComponent",
					"dm.gameplay.building.view.component.BuildingMapComponent",
					"dm.gameplay.building.view.component.BuildingTouchComponent",
					"dm.gameplay.building.view.component.BuildingMainComponent",
					"dm.gameplay.building.view.component.BuildingMapCell",
					"dm.gameplay.building.view.component.BuildingPutHeroCell",
					"dm.gameplay.building.view.component.BuildingTiledMapComponent",
					"dm.gameplay.building.view.component.BuildingTiledMap",
					"dm.gameplay.building.view.component.BuildingLockComponent",
					"dm.gameplay.building.view.component.BuildingSortHeroListComponent",
					"dm.gameplay.building.view.component.BuildingMapBuildArrow",
					"dm.gameplay.building.view.component.BuildingHero",
					"dm.gameplay.building.view.component.BuildingDecorateQueue",
					"dm.gameplay.building.view.component.BuildingLoot",
					"dm.gameplay.building.view.component.BuildingLootWidget",
					"dm.gameplay.building.model.BaseBuilding",
					"dm.gameplay.building.model.DecorateBuilding",
					"dm.gameplay.building.model.ResourceBuilding",
					"dm.gameplay.building.model.Room",
					"dm.gameplay.building.view.club.ClubBuildingTouchComponent",
					"dm.gameplay.building.view.club.ClubBuildingDecorateComponent",
					"dm.gameplay.building.view.club.ClubBuildingMainComponent"
				},
				injections = {
					singletons = {
						"BuildingSystem",
						"BuildingShopSystem"
					},
					classes = {
						"BuildingService"
					},
					views = {
						{
							res = "asset/ui/BuildingView.csb",
							name = "BuildingView",
							mediator = "BuildingMediator"
						},
						{
							res = "asset/ui/BuildingView.csb",
							name = "ClubBuildingView",
							mediator = "ClubBuildingMediator"
						},
						{
							res = "asset/ui/BuildingOverviewUI.csb",
							name = "BuildingOverviewView",
							mediator = "BuildingOverviewMediator"
						},
						{
							res = "asset/ui/BuildingUnlockRoom.csb",
							name = "BuildingUnlockRoomView",
							mediator = "BuildingUnlockRoomMediator"
						},
						{
							res = "asset/ui/BuildingBuildView.csb",
							name = "BuildingBuildView",
							mediator = "BuildingBuildMediator"
						},
						{
							res = "asset/ui/BuildingInfoUI.csb",
							name = "BuildingInfoView",
							mediator = "BuildingInfoMediator"
						},
						{
							res = "asset/ui/BuildingLvUpUI.csb",
							name = "BuildingLvUpView",
							mediator = "BuildingLvUpMediator"
						},
						{
							res = "asset/ui/BuildingOrcLvUpUI.csb",
							name = "BuildingOrcLvUpView",
							mediator = "BuildingOrcLvUpMediator"
						},
						{
							res = "asset/ui/BuildSubOrcInfo.csb",
							name = "BuildingSubOrcInfoView",
							mediator = "BuildingSubOrcInfoMediator"
						},
						{
							res = "asset/ui/BuildingLvUpSuc.csb",
							name = "BuildingLvUpSucView",
							mediator = "BuildingLvUpSucMediator"
						},
						{
							res = "asset/ui/BuildingCancelCheck.csb",
							name = "BuildingCancelCheckView",
							mediator = "BuildingCancelCheckMediator"
						},
						{
							res = "asset/ui/BuildingPutHeroView.csb",
							name = "BuildingPutHeroView",
							mediator = "BuildingPutHeroMediator"
						},
						{
							res = "asset/ui/BuildingAfkGift.csb",
							name = "BuildingAfkGiftView",
							mediator = "BuildingAfkGiftMediator"
						},
						{
							res = "asset/ui/BuildingPutHeroCell.csb",
							name = "BuildingPutHeroCell"
						},
						{
							res = "asset/ui/BuildingBuildCell.csb",
							name = "BuildingBuild"
						},
						{
							res = "asset/ui/BuildingMainView.csb",
							name = "BuildingMain"
						},
						{
							res = "asset/ui//BuildingMapCell.csb",
							name = "BuildingMapCell"
						},
						{
							res = "asset/ui/BuildingDecorateQueueNode.csb",
							name = "BuildingDecorateQueue"
						},
						{
							res = "asset/ui/BuildingLoveAddUI.csb",
							name = "BuildingLoveAddView",
							mediator = "BuildingLoveAddMediator"
						},
						{
							res = "asset/ui/BuildingQueueBuyCheck.csb",
							name = "BuildingQueueBuyCheckView",
							mediator = "BuildingQueueBuyCheckMediator"
						},
						{
							res = "asset/ui/BuildingQueueBuyUI.csb",
							name = "BuildingQueueBuyView",
							mediator = "BuildingQueueBuyMediator"
						},
						{
							res = "asset/ui/BuildingOneKeyGetRes.csb",
							name = "BuildingOneKeyGetResView",
							mediator = "BuildingOneKeyGetResMediator"
						}
					}
				}
			},
			{
				name = "maze",
				requires = {
					"dm.gameplay.maze.controller.MazeSystem",
					"dm.gameplay.maze.service.MazeService"
				},
				injections = {
					singletons = {
						"MazeSystem",
						"MazeService"
					},
					views = {
						{
							res = "asset/ui/MazeEnter.csb",
							name = "MazeEnterView",
							mediator = "MazeEnterMediator"
						},
						{
							res = "asset/ui/MazeMaster.csb",
							name = "MazeMasterView",
							mediator = "MazeMasterMediator"
						},
						{
							res = "asset/ui/MazeMain.csb",
							name = "MazeMainView",
							mediator = "MazeMainMediator"
						},
						{
							res = "asset/ui/MazeSkill.csb",
							name = "MazeMasterSkillView",
							mediator = "MazeMasterSkillMediator"
						},
						{
							res = "asset/ui/MazeNormalTeam.csb",
							name = "MazeTeamView",
							mediator = "MazeTeamMediator"
						},
						{
							res = "asset/ui/MazeHeroShop.csb",
							name = "MazeHeroShopView",
							mediator = "MazeHeroShopMediator"
						},
						{
							res = "asset/ui/MazeTreasureOwn.csb",
							name = "MazeTreasureOwnView",
							mediator = "MazeTreasureOwnMediator"
						},
						{
							res = "asset/ui/MazeHeroUp.csb",
							name = "MazeHeroUpView",
							mediator = "MazeHeroUpMediator"
						},
						{
							res = "asset/ui/MazeHeroUpSuc.csb",
							name = "MazeHeroUpSucView",
							mediator = "MazeHeroUpSucMediator"
						},
						{
							res = "asset/ui/MazeTreasureUseSuc.csb",
							name = "MazeTreasureUseSucView",
							mediator = "MazeTreasureUseSucMediator"
						},
						{
							res = "asset/ui/MazeMasterUpSuc.csb",
							name = "MazeMasterUpSucView",
							mediator = "MazeMasterUpSucMediator"
						},
						{
							res = "asset/ui/MazeTreasureBox.csb",
							name = "MazeTreasureBoxView",
							mediator = "MazeTreasureBoxMediator"
						},
						{
							res = "asset/ui/MazeHeroBox.csb",
							name = "MazeHeroBoxView",
							mediator = "MazeHeroBoxMediator"
						},
						{
							res = "asset/ui/MazeSeal.csb",
							name = "MazeSealView",
							mediator = "MazeSealMediator"
						},
						{
							res = "asset/ui/MazeTreasureExchange.csb",
							name = "MazeTreasureExchangeView",
							mediator = "MazeTreasureExchangeMediator"
						},
						{
							res = "asset/ui/MazeTreasureCopy.csb",
							name = "MazeTreasureCopyView",
							mediator = "MazeTreasureCopyMediator"
						},
						{
							res = "asset/ui/MazeTreasureShop.csb",
							name = "MazeTreasureShopView",
							mediator = "MazeTreasureShopMediator"
						},
						{
							res = "asset/ui/MazeTreasureGet.csb",
							name = "MazeTreasureGetView",
							mediator = "MazeTreasureGetMediator"
						},
						{
							res = "asset/ui/MazeEventMain.csb",
							name = "MazeEventMainView",
							mediator = "MazeEventMainMediator"
						},
						{
							res = "asset/ui/MazeEventInfo.csb",
							name = "MazeEventInfoView",
							mediator = "MazeEventInfoMediator"
						},
						{
							res = "asset/ui/MazeDp.csb",
							name = "MazeDpView",
							mediator = "MazeDpMediator"
						},
						{
							res = "asset/ui/MazeQuestion.csb",
							name = "MazeQuestionView",
							mediator = "MazeQuestionMediator"
						},
						{
							res = "asset/ui/MazeChapteBoss.csb",
							name = "MazeChapteBossView",
							mediator = "MazeChapteBossMediator"
						},
						{
							res = "asset/ui/MazeSuspectVotes.csb",
							name = "MazeSuspectVotesView",
							mediator = "MazeSuspectVotesMediator"
						},
						{
							res = "asset/ui/MazeMasterBuff.csb",
							name = "MazeMasterBuffView",
							mediator = "MazeMasterBuffMediator"
						}
					}
				}
			},
			{
				name = "club",
				requires = {
					"dm.gameplay.club.controller.ClubSystem",
					"dm.gameplay.club.controller.ClubBashenSystem",
					"dm.gameplay.club.service.ClubService",
					"dm.gameplay.club.view.ClubInfoWidget",
					"dm.gameplay.club.view.ClubMapButtonWidget"
				},
				injections = {
					singletons = {
						"ClubSystem",
						"ClubBashenSystem"
					},
					classes = {
						"ClubService"
					},
					views = {
						{
							res = "asset/ui/clubMain.csb",
							name = "ClubView",
							mediator = "ClubMediator"
						},
						{
							res = "asset/ui/clubApply.csb",
							name = "ClubApplyView",
							mediator = "ClubApplyMediator"
						},
						{
							res = "asset/ui/clubHall.csb",
							name = "ClubHallView",
							mediator = "ClubHallMediator"
						},
						{
							res = "asset/ui/clubCreateTip.csb",
							name = "CreateClubTipView",
							mediator = "CreateClubTipMediator"
						},
						{
							res = "asset/ui/clubIconSelectTip.csb",
							name = "ClubIconSelectTipView",
							mediator = "ClubIconSelectTipMediator"
						},
						{
							res = "asset/ui/clubWaringTip.csb",
							name = "ClubWaringTipView",
							mediator = "ClubWaringTipMediator"
						},
						{
							res = "asset/ui/clubBasicInfo.csb",
							name = "ClubBasicInfoView",
							mediator = "ClubBasicInfoMediator"
						},
						{
							res = "asset/ui/clubLog.csb",
							name = "ClubLogView",
							mediator = "ClubLogMediator"
						},
						{
							res = "asset/ui/clubBossTeam.csb",
							name = "ClubBossTeamView",
							mediator = "ClubBossTeamMediator"
						},
						{
							res = "asset/ui/ClubBashen.csb",
							name = "ClubBashenMainView",
							mediator = "ClubBashenMainMediator"
						},
						{
							res = "asset/ui/ClubBashenRecord.csb",
							name = "ClubBashenRecordView",
							mediator = "ClubBashenRecordMediator"
						},
						{
							res = "asset/ui/ClubBashenRule.csb",
							name = "ClubBashenRuleView",
							mediator = "ClubBashenRuleMediator"
						},
						{
							res = "asset/ui/ClubBashenRank.csb",
							name = "ClubBashenRankView",
							mediator = "ClubBashenRankMediator"
						},
						{
							res = "asset/ui/clubRank.csb",
							name = "ClubRankView",
							mediator = "ClubRankMediator"
						},
						{
							res = "asset/ui/clubInfoTip.csb",
							name = "ClubInfoTipView",
							mediator = "ClubInfoTipMediator"
						},
						{
							res = "asset/ui/clubWelcomeTip.csb",
							name = "ClubWelcomeTipView",
							mediator = "ClubWelcomeTipMediator"
						},
						{
							res = "asset/ui/clubMailTip.csb",
							name = "ClubMailTipView",
							mediator = "ClubMailTipMediator"
						},
						{
							res = "asset/ui/clubRankInfoTip.csb",
							name = "ClubMemberInfoTipView",
							mediator = "ClubMemberInfoTipMediator"
						},
						{
							res = "asset/ui/clubChangeNameTip.csb",
							name = "ClubChangeNameTipView",
							mediator = "ClubChangeNameTipMediator"
						},
						{
							res = "asset/ui/clubPositionManageTip.csb",
							name = "ClubPositionManageTipView",
							mediator = "ClubPositionManageTipMediator"
						},
						{
							res = "asset/ui/clubLimitTip.csb",
							name = "ClubAuditLimitTipView",
							mediator = "ClubAuditLimitTipMediator"
						},
						{
							res = "asset/ui/clubDonation.csb",
							name = "ClubDonationView",
							mediator = "ClubDonationMediator"
						},
						{
							res = "asset/ui/ClubTechnology.csb",
							name = "ClubTechnologyView",
							mediator = "ClubTechnologyMediator"
						},
						{
							res = "asset/ui/ClubBoss.csb",
							name = "ClubBossView",
							mediator = "ClubBossMediator"
						},
						{
							res = "asset/ui/ClubBossGainRewardTip.csb",
							name = "ClubBossGainRewardView",
							mediator = "ClubBossGainRewardMediator"
						},
						{
							res = "asset/ui/ClubBossShowAward.csb",
							name = "ClubBossShowRewardView",
							mediator = "ClubBossShowRewardMediator"
						},
						{
							res = "asset/ui/ClubBossShowAllBoss.csb",
							name = "ClubBossShowAllBossView",
							mediator = "ClubBossShowAllBossMediator"
						},
						{
							res = "asset/ui/ClubBossBattleWin.csb",
							name = "ClubBossShowBattleResultView",
							mediator = "ClubBossShowBattleResultMediator"
						},
						{
							res = "asset/ui/ClubBossIntegral.csb",
							name = "ClubBossActivityScoreView",
							mediator = "ClubBossActivityScoreMediator"
						},
						{
							res = "asset/ui/ClubResourcesBattle.csb",
							name = "ClubResourcesBattleView",
							mediator = "ClubResourcesBattleMediator"
						},
						{
							res = "asset/ui/ClubBossGainRewardTip.csb",
							name = "ClubResourcesBattleGainRewardView",
							mediator = "ClubResourcesBattleGainRewardMediator"
						},
						{
							res = "asset/ui/ClubBossRecord.csb",
							name = "ClubBossRecordView",
							mediator = "ClubBossRecordMediator"
						},
						{
							res = "asset/ui/clubNewHall.csb",
							name = "ClubNewHallView",
							mediator = "ClubNewHallMediator"
						},
						{
							res = "asset/ui/clubNewDaily.csb",
							name = "ClubDailyView",
							mediator = "ClubLogMediator"
						},
						{
							res = "asset/ui/clubNewAudit.csb",
							name = "ClubAuditView",
							mediator = "ClubAuditMediator"
						},
						{
							res = "asset/ui/clubNewInfo.csb",
							name = "ClubNewInfoView",
							mediator = "ClubNewInfoMediator"
						},
						{
							res = "asset/ui/clubNewTechnology.csb",
							name = "ClubNewTechnologyView",
							mediator = "ClubNewTechnologyMediator"
						},
						{
							res = "asset/ui/ClubMapView.csb",
							name = "ClubMainMapView",
							mediator = "ClubMapViewMediator"
						}
					}
				}
			},
			{
				name = "rank",
				requires = {
					"dm.gameplay.rank.controller.RankSystem",
					"dm.gameplay.rank.service.RankService"
				},
				injections = {
					singletons = {
						"RankSystem",
						"RankService"
					},
					views = {
						{
							res = "asset/ui/Rank.csb",
							name = "RankView",
							mediator = "RankMediator"
						},
						{
							res = "asset/ui/RankBest.csb",
							name = "RankBestView",
							mediator = "RankBestMediator"
						},
						{
							res = "asset/ui/RankReward.csb",
							name = "RankRewardView",
							mediator = "RankRewardMediator"
						},
						{
							res = "asset/ui/RankRewardTips.csb",
							name = "RankRewardTipsView",
							mediator = "RankRewardTipsMediator"
						}
					}
				}
			},
			{
				name = "reset",
				requires = {
					"dm.gameplay.reset.ResetSystem",
					"dm.gameplay.reset.ResetService"
				},
				injections = {
					singletons = {
						"ResetSystem"
					},
					classes = {
						"ResetService"
					}
				}
			},
			{
				name = "resourceDouble",
				requires = {
					"dm.gameplay.activity.view.resourceDouble.ResourceDoubleManager",
					"dm.gameplay.activity.view.resourceDouble.ResourceDoubleWidget"
				},
				injections = {
					events = {
						{
							event = "EVT_RESOURCEDOUBLE_REFRESH",
							command = "ResourceDoubleRefreshCommond"
						}
					},
					singletons = {},
					classes = {},
					views = {}
				}
			},
			{
				name = "push",
				requires = {
					"dm.gameplay.push.PushSystem",
					"dm.gameplay.push.PushService"
				},
				injections = {
					singletons = {
						"PushSystem"
					},
					classes = {
						"PushService"
					}
				}
			},
			{
				name = "friend",
				requires = {
					"dm.gameplay.friend.controller.FriendSystem",
					"dm.gameplay.friend.service.FriendService",
					"dm.gameplay.friend.view.FriendChatWidget"
				},
				injections = {
					singletons = {
						"FriendSystem"
					},
					classes = {
						"FriendService"
					},
					views = {
						{
							res = "asset/ui/FriendMain.csb",
							name = "FriendMainView",
							mediator = "FriendMainMediator"
						},
						{
							res = "asset/ui/FriendList.csb",
							name = "FriendListView",
							mediator = "FriendListMediator"
						},
						{
							res = "asset/ui/FriendFind.csb",
							name = "FriendFindView",
							mediator = "FriendFindMediator"
						},
						{
							res = "asset/ui/FriendApply.csb",
							name = "FriendApplyView",
							mediator = "FriendApplyMediator"
						},
						{
							res = "asset/ui/FriendAddPop.csb",
							name = "FriendAddPopView",
							mediator = "FriendAddPopMediator"
						},
						{
							res = "asset/ui/FriendInfo.csb",
							name = "FriendInfoPopView",
							mediator = "FriendInfoPopMediator"
						},
						{
							res = "asset/ui/FriendBlack.csb",
							name = "FriendBlcakView",
							mediator = "FriendBlackMediator"
						}
					}
				}
			},
			{
				name = "friendpvp",
				requires = {
					"dm.gameplay.friendPvp.controller.FriendPvpSystem",
					"dm.gameplay.friendPvp.service.FriendPvpService",
					"dm.gameplay.friendPvp.view.FriendPvpMediator",
					"dm.gameplay.friendPvp.view.FriendPvpInviteWidget",
					"dm.gameplay.friendPvp.view.FriendPvpInvitePopWidget",
					"dm.gameplay.friendPvp.view.FriendPvpWinMediator",
					"dm.gameplay.friendPvp.view.FriendPvpLoseMediator"
				},
				injections = {
					singletons = {
						"FriendPvpSystem"
					},
					classes = {
						"FriendPvpService"
					},
					views = {
						{
							res = "asset/ui/FriendPvpView.csb",
							name = "FriendPvpView",
							mediator = "FriendPvpMediator"
						},
						{
							res = "asset/ui/FriendPvpWin.csb",
							name = "FriendPvpWinView",
							mediator = "FriendPvpWinMediator"
						},
						{
							res = "asset/ui/FriendPvpLose.csb",
							name = "FriendPvpLoseView",
							mediator = "FriendPvpLoseMediator"
						}
					}
				}
			},
			{
				name = "gallery",
				requires = {
					"dm.gameplay.gallery.controller.GallerySystem",
					"dm.gameplay.gallery.service.GalleryService",
					"dm.gameplay.gallery.view.GalleryGiftCellWidget"
				},
				injections = {
					singletons = {
						"GallerySystem"
					},
					classes = {
						"GalleryService"
					},
					views = {
						{
							res = "asset/ui/GalleryMain.csb",
							name = "GalleryMainView",
							mediator = "GalleryMainMediator"
						},
						{
							res = "asset/ui/GalleryPartner.csb",
							name = "GalleryPartnerView",
							mediator = "GalleryPartnerMediator"
						},
						{
							res = "asset/ui/GalleryPartnerInfo.csb",
							name = "GalleryPartnerInfoView",
							mediator = "GalleryPartnerInfoMediator"
						},
						{
							res = "asset/ui/GalleryPartnerPast.csb",
							name = "GalleryPartnerPastView",
							mediator = "GalleryPartnerPastMediator"
						},
						{
							res = "asset/ui/GalleryPartnerReward.csb",
							name = "GalleryPartnerRewardView",
							mediator = "GalleryPartnerRewardMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "GalleryRewardBoxView",
							mediator = "GalleryRewardBoxMediator"
						},
						{
							res = "asset/ui/GalleryMemory.csb",
							name = "GalleryMemoryView",
							mediator = "GalleryMemoryMediator"
						},
						{
							res = "asset/ui/GalleryMemoryPack.csb",
							name = "GalleryMemoryPackView",
							mediator = "GalleryMemoryPackMediator"
						},
						{
							res = "asset/ui/GalleryMemoryList.csb",
							name = "GalleryMemoryListView",
							mediator = "GalleryMemoryListMediator"
						},
						{
							res = "asset/ui/GalleryMemoryInfo.csb",
							name = "GalleryMemoryInfoView",
							mediator = "GalleryMemoryInfoMediator"
						},
						{
							res = "asset/ui/GalleryAlbum.csb",
							name = "GalleryAlbumView",
							mediator = "GalleryAlbumMediator"
						},
						{
							res = "asset/ui/GalleryAlbumShots.csb",
							name = "GalleryAlbumShotsView",
							mediator = "GalleryAlbumShotsMediator"
						},
						{
							res = "asset/ui/GalleryAlbumInfo.csb",
							name = "GalleryAlbumInfoView",
							mediator = "GalleryAlbumInfoMediator"
						},
						{
							res = "asset/ui/GalleryDate.csb",
							name = "GalleryDateView",
							mediator = "GalleryDateMediator"
						},
						{
							res = "asset/ui/GalleryLoveUp.csb",
							name = "GalleryLoveUpView",
							mediator = "GalleryLoveUpMediator"
						},
						{
							res = "asset/ui/GalleryLegend.csb",
							name = "GalleryLegendView",
							mediator = "GalleryLegendMediator"
						},
						{
							res = "asset/ui/GalleryLegendInfo.csb",
							name = "GalleryLegendInfoView",
							mediator = "GalleryLegendInfoMediator"
						},
						{
							res = "asset/ui/GalleryMessage.csb",
							name = "GalleryMessageView",
							mediator = "GalleryMessageMediator"
						},
						{
							res = "asset/ui/GalleryMessageInfo.csb",
							name = "GalleryMessageInfoView",
							mediator = "GalleryMessageInfoMediator"
						},
						{
							res = "asset/ui/GalleryMessageUnlock.csb",
							name = "GalleryMessageUnlockView",
							mediator = "GalleryMessageUnlockMediator"
						},
						{
							res = "asset/ui/GalleryMessageItemTips.csb",
							name = "GalleryMessageTipView",
							mediator = "GalleryMessageTipMediator"
						},
						{
							res = "asset/ui/GalleryBook.csb",
							name = "GalleryBookView",
							mediator = "GalleryBookMediator"
						},
						{
							res = "asset/ui/GalleryPartnerNew.csb",
							name = "GalleryPartnerNewView",
							mediator = "GalleryPartnerNewMediator"
						},
						{
							res = "asset/ui/GalleryPartnerInfoNew.csb",
							name = "GalleryPartnerInfoNewView",
							mediator = "GalleryPartnerInfoNewMediator"
						},
						{
							res = "asset/ui/GalleryGiftWidget.csb",
							name = "GalleryGiftCellView",
							mediator = "GalleryGiftCellMediator"
						}
					}
				}
			},
			{
				name = "surface",
				requires = {
					"dm.gameplay.surface.controller.SurfaceSystem",
					"dm.gameplay.surface.service.SurfaceService"
				},
				injections = {
					singletons = {
						"SurfaceSystem"
					},
					classes = {
						"SurfaceService"
					},
					views = {
						{
							res = "asset/ui/Surface.csb",
							name = "SurfaceView",
							mediator = "SurfaceMediator"
						},
						{
							res = "asset/ui/GetSurface.csb",
							name = "GetSurfaceView",
							mediator = "GetSurfaceMediator"
						}
					}
				}
			},
			{
				name = "recharge",
				requires = {
					"dm.gameplay.recharge.controller.RechargeAndVipSystem",
					"dm.gameplay.recharge.service.RechargeAndVipService",
					"dm.gameplay.recharge.model.RechargeAndVipModel"
				},
				injections = {
					singletons = {
						"RechargeAndVipSystem",
						"RechargeAndVipModel"
					},
					classes = {
						"RechargeAndVipService"
					},
					views = {
						{
							res = "asset/ui/FirstRecharge.csb",
							name = "FirstRechargeView",
							mediator = "FirstRechargeMediator"
						}
					}
				}
			},
			{
				name = "story",
				requires = {
					"dm.gameplay.story.all"
				},
				injections = {
					singletons = {
						"story.StoryDirector"
					},
					classes = {
						"StoryService"
					}
				}
			},
			{
				name = "guide",
				requires = {
					"dm.gameplay.guide.GuideSystem",
					"dm.gameplay.guide.GuideWidget",
					"dm.gameplay.guide.GuideText",
					"dm.gameplay.guide.GuideDrag"
				},
				injections = {
					singletons = {
						"GuideSystem"
					},
					views = {}
				}
			},
			{
				name = "customdata",
				requires = {
					"dm.gameplay.customdata.CustomData",
					"dm.gameplay.customdata.CustomDataService",
					"dm.gameplay.customdata.CustomDataSystem"
				},
				injections = {
					singletons = {
						"CustomDataSystem"
					},
					classes = {
						"CustomDataService"
					}
				}
			},
			{
				name = "monthSignIn",
				requires = {
					"dm.gameplay.monthSignIn.controller.MonthSignInSystem",
					"dm.gameplay.monthSignIn.service.MonthSignInService"
				},
				injections = {
					singletons = {
						"MonthSignInSystem"
					},
					classes = {
						"MonthSignInService"
					},
					views = {
						{
							res = "asset/ui/MonthSignIn.csb",
							name = "MonthSignInView",
							mediator = "MonthSignInMediator"
						},
						{
							res = "asset/ui/MonthSignRewardBox.csb",
							name = "MonthSignRewardBoxView",
							mediator = "MSPopRewardBoxMediator"
						},
						{
							res = "asset/ui/MonthSignInWsj.csb",
							name = "MonthSignInWsjView",
							mediator = "MonthSignInMediator"
						},
						{
							res = "asset/ui/MonthSignInSd.csb",
							name = "MonthSignInHolidayView",
							mediator = "MonthSignInMediator"
						}
					}
				}
			},
			{
				name = "shop",
				requires = {
					"dm.gameplay.shop.controller.ShopSystem",
					"dm.gameplay.shop.service.ShopService",
					"dm.gameplay.shop.view.ShopWidget"
				},
				injections = {
					singletons = {
						"ShopSystem"
					},
					classes = {
						"ShopService"
					},
					views = {
						{
							res = "asset/ui/shopMainUI.csb",
							name = "ShopView",
							mediator = "ShopMainMediator"
						},
						{
							res = "asset/ui/shopRecharge.csb",
							name = "ShopRechargeView",
							mediator = "ShopRechargeMediator"
						},
						{
							res = "asset/ui/shopSellUI.csb",
							name = "ShopSellView",
							mediator = "ShopSellMediator"
						},
						{
							res = "asset/ui/shopPackage.csb",
							name = "ShopPackageView",
							mediator = "ShopPackageMediator"
						},
						{
							res = "asset/ui/shopBuyUI.csb",
							name = "ShopBuyView",
							mediator = "ShopBuyMediator"
						},
						{
							res = "asset/ui/shopRefreshUI.csb",
							name = "ShopRefreshView",
							mediator = "ShopRefreshMediator"
						},
						{
							res = "asset/ui/shopDebris.csb",
							name = "ShopDebrisView",
							mediator = "ShopDebrisMediator"
						},
						{
							res = "asset/ui/shopDebrisSell.csb",
							name = "ShopDebrisSellView",
							mediator = "ShopDebrisSellMediator"
						},
						{
							res = "asset/ui/shopPackageMain.csb",
							name = "ShopPackageMainView",
							mediator = "ShopPackageMainMediator"
						},
						{
							res = "asset/ui/shopNormal.csb",
							name = "ShopNormalView",
							mediator = "ShopNormalMediator"
						},
						{
							res = "asset/ui/shopSurface.csb",
							name = "ShopSurfaceView",
							mediator = "ShopSurfaceMediator"
						},
						{
							res = "asset/ui/shopSurfaceNew.csb",
							name = "ShopSurfaceNewView",
							mediator = "ShopSurfaceNewMediator"
						},
						{
							res = "asset/ui/shopPackageMain.csb",
							name = "ShopResetView",
							mediator = "ShopResetMediator"
						},
						{
							res = "asset/ui/shopRecommend.csb",
							name = "ShopRecommendView",
							mediator = "ShopRecommendMediator"
						},
						{
							res = "asset/ui/shopBuyUINormal.csb",
							name = "ShopBuyNormalView",
							mediator = "ShopBuyNormalMediator"
						},
						{
							res = "asset/ui/shopBuySurface.csb",
							name = "ShopBuySurfaceView",
							mediator = "ShopBuySurfaceMediator"
						},
						{
							res = "asset/ui/shopBuyUIMonthCard.csb",
							name = "ShopBuyMonthCardView",
							mediator = "ShopBuyMonthCardMediator"
						},
						{
							res = "asset/ui/shopBuyUIMonthCardF.csb",
							name = "ShopBuyMonthCardFView",
							mediator = "ShopBuyMonthCardFMediator"
						},
						{
							res = "asset/ui/shopBuyUIPackage.csb",
							name = "ShopBuyPackageView",
							mediator = "ShopBuyPackageMediator"
						},
						{
							res = "asset/ui/shopMonthCard.csb",
							name = "ShopMonthCardView",
							mediator = "ShopMonthCardMediator"
						},
						{
							res = "asset/ui/shopCoopExchange.csb",
							name = "ShopCoopExchangeView",
							mediator = "ShopCoopExchangeMediator"
						},
						{
							res = "asset/ui/shopBuyUINormal.csb",
							name = "ShopCoopExchangeBuyView",
							mediator = "ShopCoopExchangeBuyMediator"
						},
						{
							res = "asset/ui/shopURExchange.csb",
							name = "ShopURExchangeView",
							mediator = "ShopURExchangeMediator"
						},
						{
							res = "asset/ui/ShopPushPackage.csb",
							name = "ShopPushPackageView",
							mediator = "ShopPushPackageMediator"
						}
					}
				}
			},
			{
				name = "spStage",
				requires = {
					"dm.gameplay.spStage.controller.SpStageSystem",
					"dm.gameplay.spStage.service.SpStageService",
					"dm.gameplay.spStage.model.SpStage"
				},
				injections = {
					singletons = {
						"SpStageSystem"
					},
					classes = {
						"SpStageService"
					},
					views = {
						{
							res = "asset/ui/SpecialStageMain.csb",
							name = "SpStageMainView",
							mediator = "SpStageMainMediator"
						},
						{
							res = "asset/ui/SpecialStageRule.csb",
							name = "SpStageRuleView",
							mediator = "SpStageRuleMediator"
						},
						{
							res = "asset/ui/SpecialStageDft.csb",
							name = "SpStageDftView",
							mediator = "SpStageDftMediator"
						},
						{
							res = "asset/ui/SpecialStageRank.csb",
							name = "SpStageRankView",
							mediator = "SpStageRankMediator"
						},
						{
							res = "asset/ui/SpecialStageSweep.csb",
							name = "SpStageSweepView",
							mediator = "SpStageSweepMediator"
						},
						{
							res = "asset/ui/SpecialStageFinish.csb",
							name = "SpStageFinishView",
							mediator = "SpStageFinishMediator"
						},
						{
							res = "asset/ui/SpStageGetBuff.csb",
							name = "SpStageGetBuffView",
							mediator = "SpStageGetBuffMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "SpStageBoxView",
							mediator = "SpStageBoxMediator"
						}
					}
				}
			},
			{
				name = "commonModule",
				requires = {},
				injections = {
					views = {
						{
							res = "asset/ui/PlayerInfo.csb",
							name = "PlayerInfoView",
							mediator = "PlayerInfoMediator"
						}
					}
				}
			},
			{
				name = "explore",
				requires = {
					"dm.gameplay.explore.controller.ExploreSystem",
					"dm.gameplay.explore.service.ExploreService",
					"dm.gameplay.explore.model.Explore",
					"dm.gameplay.explore.model.ExploreEquipItem",
					"dm.gameplay.explore.model.ExploreBag",
					"dm.gameplay.explore.model.ExploreMap",
					"dm.gameplay.explore.model.ExploreType",
					"dm.gameplay.explore.model.ExploreMapTask",
					"dm.gameplay.explore.model.ExploreObject",
					"dm.gameplay.explore.model.ExploreCase",
					"dm.gameplay.explore.model.ExploreCaseEndAction",
					"dm.gameplay.explore.model.ExploreCaseFactor",
					"dm.gameplay.explore.model.ExploreZombieHero"
				},
				injections = {
					singletons = {
						"ExploreSystem"
					},
					classes = {
						"ExploreService",
						"Explore",
						"ExploreMap",
						"ExploreBag",
						"ExploreType",
						"ExploreCaseEndAction"
					},
					views = {
						{
							res = "asset/ui/Layer_exploreMap.csb",
							name = "ExploreMapView",
							mediator = "ExploreMapViewMediator"
						},
						{
							res = "asset/ui/Layer_exploreMapUI.csb",
							name = "ExploreMapUIView"
						},
						{
							res = "asset/ui/Layer_explore_talk.csb",
							name = "ExploreTalkView"
						},
						{
							res = "asset/ui/Layer_explore_rewardBar.csb",
							name = "ExploreRewardBar"
						},
						{
							res = "asset/ui/Layer_explore.csb",
							name = "ExploreView",
							mediator = "ExploreMediator"
						},
						{
							res = "asset/ui/Layer_exploreStage.csb",
							name = "ExploreStageView",
							mediator = "ExploreStageMediator"
						},
						{
							res = "asset/ui/Layer_exploreInfo.csb",
							name = "ExplorePointInfo",
							mediator = "ExplorePointInfoMediator"
						},
						{
							res = "asset/ui/Layer_exploreTeam.csb",
							name = "ExploreTeamView",
							mediator = "ExploreTeamMediator"
						},
						{
							res = "asset/ui/Layer_exploreRule.csb",
							name = "ExplorePointRule",
							mediator = "ExplorePointRuleMediator"
						},
						{
							res = "asset/ui/Layer_exploreDPTask.csb",
							name = "ExploreDPTaskView",
							mediator = "ExplorePointTaskMediator"
						},
						{
							res = "asset/ui/RewardBox.csb",
							name = "ExploreRewardBoxView",
							mediator = "ExplorePointBoxMediator"
						},
						{
							res = "asset/ui/Layer_exploreBag.csb",
							name = "ExploreBagView",
							mediator = "ExploreBagMediator"
						},
						{
							res = "asset/ui/Layer_exploreZombie.csb",
							name = "ExploreZombieView",
							mediator = "ExploreMapZombieMediator"
						},
						{
							res = "asset/ui/Layer_exploreAddPower.csb",
							name = "ExploreAddPowerView",
							mediator = "ExploreMapAddPowerMediator"
						},
						{
							res = "asset/ui/Layer_exploreCaseAlert.csb",
							name = "ExploreCaseAlertView",
							mediator = "ExploreMapCaseAlertMediator"
						},
						{
							res = "asset/ui/Layer_exploreShop.csb",
							name = "ExploreShopView",
							mediator = "ExploreShopMediator"
						},
						{
							res = "asset/ui/Layer_exploreBattleFinish.csb",
							name = "ExploreBattleFinishView",
							mediator = "ExploreBattleFinishMediator"
						},
						{
							res = "asset/ui/Layer_exploreLog.csb",
							name = "ExploreLogView",
							mediator = "ExploreLogMediator"
						},
						{
							res = "asset/ui/Layer_exploreTinyMap.csb",
							name = "ExploreTinyView",
							mediator = "ExploreTinyMapMediator"
						},
						{
							res = "asset/ui/Layer_exploreVictory.csb",
							name = "ExploreVictoryView",
							mediator = "ExploreVictoryMediator"
						},
						{
							res = "asset/ui/Layer_exploreFinish.csb",
							name = "ExploreFinishView",
							mediator = "ExploreFinishMediator"
						},
						{
							res = "asset/ui/BlockSweepLayer.csb",
							name = "ExploreSweepView",
							mediator = "ExploreSweepMediator"
						}
					}
				}
			},
			{
				name = "tower",
				requires = {
					"dm.gameplay.tower.controller.TowerSystem",
					"dm.gameplay.tower.service.TowerService",
					"dm.gameplay.tower.model.TowerModel",
					"dm.gameplay.tower.model.Tower",
					"dm.gameplay.tower.model.TowerBase",
					"dm.gameplay.tower.model.TowerMaster",
					"dm.gameplay.tower.model.TowerPoint",
					"dm.gameplay.tower.model.TowerEnemy",
					"dm.gameplay.tower.model.TowerHero"
				},
				injections = {
					singletons = {
						"TowerSystem",
						"TowerModel",
						"Tower"
					},
					classes = {
						"TowerService"
					},
					views = {
						{
							res = "asset/ui/TowerMain.csb",
							name = "TowerMainView",
							mediator = "TowerMainMediator"
						},
						{
							res = "asset/ui/TowerBegin.csb",
							name = "TowerBeginView",
							mediator = "TowerBeginMediator"
						},
						{
							res = "asset/ui/TowerChooseRole.csb",
							name = "TowerChooseRoleView",
							mediator = "TowerChooseRoleMediator"
						},
						{
							res = "asset/ui/TowerGetHeroBuff.csb",
							name = "TowerGetHeroBuffView",
							mediator = "TowerGetHeroBuffMediator"
						},
						{
							res = "asset/ui/TowerPoint.csb",
							name = "TowerPointView",
							mediator = "TowerPointMediator"
						},
						{
							res = "asset/ui/TowerBattleLose.csb",
							name = "TowerBattleLoseView",
							mediator = "TowerBattleLoseMediator"
						},
						{
							res = "asset/ui/TowerBattleWin.csb",
							name = "TowerBattleWinView",
							mediator = "TowerBattleWinMediator"
						},
						{
							res = "asset/ui/TowerPartnerSelect.csb",
							name = "TowerPartnerSelectView",
							mediator = "TowerPartnerSelectMediator"
						},
						{
							res = "asset/ui/TowerMasterShowDetails.csb",
							name = "TowerMasterShowDetailsView",
							mediator = "TowerMasterShowDetailsMediator"
						},
						{
							res = "asset/ui/TowerHeroShowDetails.csb",
							name = "TowerHeroShowDetailsView",
							mediator = "TowerHeroShowDetailsMediator"
						},
						{
							res = "asset/ui/TowerTeam.csb",
							name = "TowerTeamView",
							mediator = "TowerTeamMediator"
						},
						{
							res = "asset/ui/TowerAward.csb",
							name = "TowerAwardView",
							mediator = "TowerAwardMediator"
						},
						{
							res = "asset/ui/TowerEnemy.csb",
							name = "TowerEnemyView",
							mediator = "TowerEnemyMediator"
						},
						{
							res = "asset/ui/TowerBuff.csb",
							name = "TowerBuffView",
							mediator = "TowerBuffMediator"
						},
						{
							res = "asset/ui/TowerTeamBattle.csb",
							name = "TowerTeamBattleView",
							mediator = "TowerTeamBattleMediator"
						},
						{
							res = "asset/ui/TowerStrengthAward.csb",
							name = "TowerStrengthAwardView",
							mediator = "TowerStrengthAwardMediator"
						},
						{
							res = "asset/ui/TowerStrength.csb",
							name = "TowerStrengthView",
							mediator = "TowerStrengthMediator"
						},
						{
							res = "asset/ui/TowerBuffChoose.csb",
							name = "TowerBuffChooseView",
							mediator = "TowerBuffChooseMediator"
						},
						{
							res = "asset/ui/TowerCardsChoose.csb",
							name = "TowerCardsChooseView",
							mediator = "TowerCardsChooseMediator"
						},
						{
							res = "asset/ui/TowerChallengeEnd.csb",
							name = "TowerChallengeEndView",
							mediator = "TowerChallengeEndMediator"
						},
						{
							res = "asset/ui/TowerStrengthEndTip.csb",
							name = "TowerStrengthEndTipView",
							mediator = "TowerStrengthEndTipMediator"
						}
					}
				}
			},
			{
				name = "crusade",
				requires = {
					"dm.gameplay.crusade.controller.CrusadeSystem",
					"dm.gameplay.crusade.service.CrusadeService",
					"dm.gameplay.crusade.model.Crusade"
				},
				injections = {
					singletons = {
						"CrusadeSystem",
						"Crusade"
					},
					classes = {
						"CrusadeService"
					},
					views = {
						{
							res = "asset/ui/CrusadeMain.csb",
							name = "CrusadeMainView",
							mediator = "CrusadeMainMediator"
						},
						{
							res = "asset/ui/CrusadePowerView.csb",
							name = "CrusadePowerView",
							mediator = "CrusadePowerMediator"
						},
						{
							res = "asset/ui/CrusadePassFloor.csb",
							name = "CrusadePassFloorView",
							mediator = "CrusadePassFloorMediator"
						},
						{
							res = "asset/ui/CrusadeAward.csb",
							name = "CrusadeAwardView",
							mediator = "CrusadeAwardMediator"
						},
						{
							res = "asset/ui/CrusadeBattleWin.csb",
							name = "CrusadeBattleWinView",
							mediator = "CrusadeBattleWinMediator"
						},
						{
							res = "asset/ui/CrusadeSweepTip.csb",
							name = "CrusadeSweepTipView",
							mediator = "CrusadeSweepTipMediator"
						},
						{
							res = "asset/ui/CrusadeSweepResult.csb",
							name = "CrusadeSweepResultView",
							mediator = "CrusadeSweepResultMediator"
						},
						{
							res = "asset/ui/CrusadeWorldRule.csb",
							name = "CrusadeWorldRuleView",
							mediator = "CrusadeWorldRuleMediator"
						},
						{
							res = "asset/ui/CrusadeAlert.csb",
							name = "CrusadeAlertView",
							mediator = "CrusadeAlertMediator"
						}
					}
				}
			},
			{
				name = "rtpvp",
				requires = {
					"dm.gameplay.rtpvp.service.RTPVPAgent",
					"dm.gameplay.rtpvp.service.RTPVPService",
					"dm.gameplay.rtpvp.controller.RTPVPController",
					"dm.gameplay.rtpvp.view.RTPVPMediator",
					"dm.gameplay.rtpvp.view.RTPVPBattleMainMediator",
					"dm.gameplay.rtpvp.view.RTPVPBattleResultMediator",
					"dm.gameplay.rtpvp.view.RTPVPDelegate",
					"dm.gameplay.rtpvp.view.RTPVPNetTipsMediator"
				},
				injections = {
					singletons = {
						"RTPVPController",
						"RTPVPService",
						"RTPVPAgent"
					},
					classes = {
						"RTPVPDelegate"
					},
					views = {
						{
							node = "cc.Node",
							name = "rtpvpMatch",
							mediator = "RTPVPMediator"
						},
						{
							node = "cc.Node",
							name = "rtpvpBattle",
							mediator = "RTPVPBattleMainMediator"
						},
						{
							node = "cc.Node",
							name = "rtpvpResult",
							mediator = "RTPVPBattleResultMediator"
						},
						{
							res = "asset/ui/RTPVPNetTips.csb",
							name = "RTPVPNetTipsView",
							mediator = "RTPVPNetTipsMediator"
						},
						{
							node = "cc.Node",
							name = "rtpvpRobotBattle",
							mediator = "RTPVPRobotBattleMediator"
						}
					}
				}
			},
			{
				name = "pass",
				requires = {
					"dm.gameplay.pass.controller.PassSystem",
					"dm.gameplay.pass.service.PassService",
					"dm.gameplay.pass.model.PassListModel",
					"dm.gameplay.pass.model.PassReward",
					"dm.gameplay.pass.model.PassExchange",
					"dm.gameplay.pass.view.PassWidget"
				},
				injections = {
					singletons = {
						"PassSystem",
						"PassListModel"
					},
					classes = {
						"PassService"
					},
					views = {
						{
							res = "asset/ui/PassMain.csb",
							name = "PassMainView",
							mediator = "PassMainMediator"
						},
						{
							res = "asset/ui/PassReward.csb",
							name = "PassAwardView",
							mediator = "PassAwardMediator"
						},
						{
							res = "asset/ui/PassShop.csb",
							name = "PassExchangeView",
							mediator = "PassExchangeMediator"
						},
						{
							res = "asset/ui/PassShop.csb",
							name = "PassShopView",
							mediator = "PassShopMediator"
						},
						{
							res = "asset/ui/PassTask.csb",
							name = "PassTaskView",
							mediator = "PassTaskMediator"
						},
						{
							res = "asset/ui/PassBuy.csb",
							name = "PassBuyView",
							mediator = "PassBuyMediator"
						},
						{
							res = "asset/ui/PassBuyLevel.csb",
							name = "PassBuyLevelView",
							mediator = "PassBuyLevelMediator"
						},
						{
							res = "asset/ui/PassLevelUp.csb",
							name = "PassLevelUpView",
							mediator = "PassLevelUpMediator"
						},
						{
							res = "asset/ui/PassRewardsPreview.csb",
							name = "PassRewardsPreviewView",
							mediator = "PassRewardsPreviewMediator"
						},
						{
							res = "asset/ui/shopBuyUINormal.csb",
							name = "PassBuyItemView",
							mediator = "PassBuyItemMediator"
						},
						{
							res = "asset/ui/RecruitBuyCard.csb",
							name = "PassDelayExpView",
							mediator = "PassDelayExpMediator"
						}
					}
				}
			},
			{
				name = "payOff",
				requires = {
					"dm.gameplay.payoff.service.PayOffService",
					"dm.gameplay.payoff.controller.PayOffSystem",
					"dm.gameplay.payoff.model.PayModel"
				},
				injections = {
					singletons = {
						"PayOffSystem",
						"PayModel"
					},
					classes = {
						"PayOffService"
					}
				}
			},
			{
				name = "dreamChallenge",
				requires = {
					"dm.gameplay.dreamChallenge.controller.DreamChallengeSystem",
					"dm.gameplay.dreamChallenge.service.DreamChallengeService",
					"dm.gameplay.dreamChallenge.model.DreamChallenge",
					"dm.gameplay.dreamChallenge.model.DreamChallengePoint",
					"dm.gameplay.dreamChallenge.model.DreamChallengeMap",
					"dm.gameplay.dreamChallenge.view.TreeView"
				},
				injections = {
					singletons = {
						"DreamChallengeSystem",
						"DreamChallenge"
					},
					classes = {
						"DreamChallengeService"
					},
					views = {
						{
							res = "asset/ui/dreamChallengeMain.csb",
							name = "DreamChallengeMainView",
							mediator = "DreamChallengeMainMediator"
						},
						{
							res = "asset/ui/dreamChallengeTeam.csb",
							name = "DreamChallengeTeamView",
							mediator = "DreamChallengeTeamMediator"
						},
						{
							res = "asset/ui/dreamChallengeBattleEnd.csb",
							name = "DreamChallengeBattleEndView",
							mediator = "DreamChallengeBattleEndMediator"
						},
						{
							res = "asset/ui/dreamChallengeBuffDetail.csb",
							name = "DreamChallengeBuffDetailView",
							mediator = "DreamChallengeBuffDetailMediator"
						},
						{
							res = "asset/ui/dreamChallengeDetail.csb",
							name = "DreamChallengeDetailView",
							mediator = "DreamChallengeDetailMediator"
						},
						{
							res = "asset/ui/dreamChallengePoint.csb",
							name = "DreamChallengePointView",
							mediator = "DreamChallengePointMediator"
						},
						{
							res = "asset/ui/dreamChallengePass.csb",
							name = "DreamChallengePassView",
							mediator = "DreamChallengePassMediator"
						}
					}
				}
			},
			{
				name = "dreamHouse",
				requires = {
					"dm.gameplay.dreamHouse.controller.DreamHouseSystem",
					"dm.gameplay.dreamHouse.service.DreamHouseService",
					"dm.gameplay.dreamHouse.model.DreamHouse",
					"dm.gameplay.dreamHouse.model.DreamHousePoint",
					"dm.gameplay.dreamHouse.model.DreamHouseMap"
				},
				injections = {
					singletons = {
						"DreamHouseSystem",
						"DreamHouse"
					},
					classes = {
						"DreamHouseService"
					},
					views = {
						{
							res = "asset/ui/dreamHouseMain.csb",
							name = "DreamHouseMainView",
							mediator = "DreamHouseMainMediator"
						},
						{
							res = "asset/ui/dreamHouseTeam.csb",
							name = "DreamHouseTeamView",
							mediator = "DreamHouseTeamMediator"
						},
						{
							res = "asset/ui/dreamHouseBattleEnd.csb",
							name = "DreamHouseBattleEndView",
							mediator = "DreamHouseBattleEndMediator"
						},
						{
							res = "asset/ui/dreamHouseDetail.csb",
							name = "DreamHouseDetailView",
							mediator = "DreamHouseDetailMediator"
						},
						{
							res = "asset/ui/dreamHousePass.csb",
							name = "DreamHousePassView",
							mediator = "DreamHousePassMediator"
						}
					}
				}
			},
			{
				name = "team",
				requires = {
					"dm.gameplay.team.controller.TeamSystem"
				},
				injections = {
					singletons = {
						"TeamSystem"
					},
					classes = {
						"TeamService"
					},
					views = {
						{
							res = "asset/ui/MainTeamLayer.csb",
							name = "MainTeamView",
							mediator = "MainTeamMediator"
						}
					}
				}
			},
			{
				name = "miniGame",
				requires = {
					"dm.gameplay.miniGame.controller.MiniGameSystem"
				},
				injections = {
					singletons = {
						"MiniGameSystem"
					},
					views = {
						{
							res = "asset/ui/Darts.csb",
							name = "DartsView",
							mediator = "DartsMediator"
						},
						{
							res = "asset/ui/MiniGameRewards.csb",
							name = "MiniGameRewardView",
							mediator = "MiniGameRewardListMediator"
						},
						{
							res = "asset/ui/MiniGameQuitConfirm.csb",
							name = "MiniGameQuitConfirmView",
							mediator = "MiniGameQuitConfirmMediator"
						},
						{
							res = "asset/ui/MiniGamePassGame.csb",
							name = "MiniGamePassGameView",
							mediator = "MiniGamePassGameMediator"
						},
						{
							res = "asset/ui/MiniGameRank.csb",
							name = "MiniGameRankView",
							mediator = "MiniGameRankMediator"
						},
						{
							res = "asset/ui/MiniGameResult.csb",
							name = "MiniGameResultView",
							mediator = "MiniGameResultMediator"
						},
						{
							res = "asset/ui/Jump.csb",
							name = "JumpView",
							mediator = "JumpMediator"
						},
						{
							res = "asset/ui/miniplaneActivityLimitTip.csb",
							name = "PlaneWarActivityLimitTipView",
							mediator = "PlaneWarActivityLimitTipMediator"
						},
						{
							res = "asset/ui/miniplaneWaringTip.csb",
							name = "PlaneWarWarningView",
							mediator = "PlaneWarWarningMediator"
						},
						{
							res = "asset/ui/miniplaneStage.csb",
							name = "PlaneWarStageView",
							mediator = "PlaneWarStageMediator"
						},
						{
							res = "asset/ui/miniplaneActivity.csb",
							name = "PlaneWarActivityView",
							mediator = "PlaneWarActivityMediator"
						},
						{
							res = "asset/ui/miniplaneActivity.csb",
							name = "PlaneWarClubView",
							mediator = "PlaneWarClubMediator"
						},
						{
							res = "asset/ui/miniplaneGame.csb",
							name = "PlaneWarGameView",
							mediator = "PlaneWarGameMediator"
						},
						{
							res = "asset/ui/miniplaneActivityResult.csb",
							name = "PlaneWarActivityResultView",
							mediator = "PlaneWarActivityResultMediator"
						},
						{
							res = "asset/ui/miniplaneActivityResult.csb",
							name = "PlaneWarClubGameResultView",
							mediator = "PlaneWarClubGameResultMediator"
						},
						{
							res = "asset/ui/miniplaneStageWin.csb",
							name = "PlaneWarStageWinView",
							mediator = "PlaneWarStageWinMediator"
						},
						{
							res = "asset/ui/miniplaneStagePasue.csb",
							name = "PlaneWarStagePauseView",
							mediator = "PlaneWarStagePauseMediator"
						},
						{
							res = "asset/ui/miniplaneRule.csb",
							name = "PlaneWarRuleTipView",
							mediator = "PlaneWarRuleTipMediator"
						},
						{
							res = "asset/ui/miniplaneStageBuyTimes.csb",
							name = "PlaneWarStageBuyTimesView",
							mediator = "PlaneWarResultBuyTimesMediator"
						},
						{
							res = "asset/ui/miniplaneActivityBuyTimes.csb",
							name = "PlaneWarActivityBuyTimesView",
							mediator = "PlaneWarActivityBuyTimesMediator"
						},
						{
							res = "asset/ui/miniplaneActivityBuyTimes.csb",
							name = "ClubGameBuyTimesView",
							mediator = "ClubGameBuyTimesMediator"
						},
						{
							res = "asset/ui/miniplaneActivityPasue.csb",
							name = "PlaneWarActivityPauseView",
							mediator = "PlaneWarActivityPauseMediator"
						},
						{
							res = "asset/ui/miniplaneActivityPasue.csb",
							name = "PlaneWarClubGamePauseView",
							mediator = "PlaneWarClubGamePauseMediator"
						},
						{
							res = "asset/ui/miniplaneActivityRewards.csb",
							name = "PlaneWarRewardListTipView",
							mediator = "PlaneWarRewardListTipMediator"
						},
						{
							res = "asset/ui/miniplaneClubRewards.csb",
							name = "PlaneWarClubGameRewardsTipView",
							mediator = "PlaneWarClubGameRewardsTipMediator"
						}
					}
				}
			},
			{
				name = "cooperateBoss",
				requires = {
					"dm.gameplay.cooperateBoss.controller.CooperateBossSystem",
					"dm.gameplay.cooperateBoss.model.CooperateBoss",
					"dm.gameplay.cooperateBoss.service.CooperateBossService"
				},
				injections = {
					singletons = {
						"CooperateBossSystem",
						"CooperateBoss"
					},
					classes = {
						"CooperateBossService"
					},
					views = {
						{
							res = "asset/ui/CooperateBossMain.csb",
							name = "CooperateBossMainView",
							mediator = "CooperateBossMainMediator"
						},
						{
							res = "asset/ui/CooperateBossBattleEnd.csb",
							name = "CooperateBossBattleEndView",
							mediator = "CooperateBossBattleEndMediator"
						},
						{
							res = "asset/ui/CooperateBossFight.csb",
							name = "CooperateBossFightView",
							mediator = "CooperateBossFightMediator"
						},
						{
							res = "asset/ui/CooperateBossInvite.csb",
							name = "CooperateBossInviteView",
							mediator = "CooperateBossInviteMediator"
						},
						{
							res = "asset/ui/CooperateBossInviteFriend.csb",
							name = "CooperateBossInviteFriendView",
							mediator = "CooperateBossInviteFriendMediator"
						},
						{
							res = "asset/ui/CooperateBossBuyTime.csb",
							name = "CooperateBossBuyTimeView",
							mediator = "CooperateBossBuyTimeMediator"
						},
						{
							res = "asset/ui/CooperateBossTeam.csb",
							name = "CooperateBossTeamView",
							mediator = "CooperateBossTeamMediator"
						}
					}
				}
			},
			{
				name = "rtpk",
				requires = {
					"dm.gameplay.rtpk.controller.RTPKSystem",
					"dm.gameplay.rtpk.service.RTPKService"
				},
				injections = {
					singletons = {
						"RTPKSystem"
					},
					classes = {
						"RTPKService"
					},
					views = {
						{
							res = "asset/ui/RtpkRankReward.csb",
							name = "RTPKRewardView",
							mediator = "RTPKRewardViewMediator"
						},
						{
							res = "asset/ui/RtpkRank.csb",
							name = "RTPKRankView",
							mediator = "RTPKRankViewMediator"
						},
						{
							res = "asset/ui/RtpkTeam.csb",
							name = "RTPKTeamView",
							mediator = "RTPKTeamMediator"
						},
						{
							res = "asset/ui/RTPKMain.csb",
							name = "RTPKMainView",
							mediator = "RTPKMainMediator"
						},
						{
							res = "asset/ui/RTPKMatch.csb",
							name = "RTPKMatchView",
							mediator = "RTPKMatchMediator"
						},
						{
							res = "asset/ui/ArenaReportMain.csb",
							name = "RTPKReportView",
							mediator = "RTPKReportViewMediator"
						},
						{
							res = "asset/ui/RTPKBuffDetail.csb",
							name = "RTPKBuffDetailView",
							mediator = "RTPKBuffDetailMediator"
						},
						{
							res = "asset/ui/RTPKResult.csb",
							name = "RTPKResultView",
							mediator = "RTPKResultMediator"
						},
						{
							res = "asset/ui/RTPKNewSeason.csb",
							name = "RTPKNewSeasonTipsView",
							mediator = "RTPKNewSeasonTipsMediator"
						},
						{
							res = "asset/ui/RTPKEmoji.csb",
							name = "RTPKEmojiView",
							mediator = "RTPKEmojiMediator"
						}
					}
				}
			},
			{
				name = "leadStageArena",
				requires = {
					"dm.gameplay.leadStageArena.controller.LeadStageArenaSystem",
					"dm.gameplay.leadStageArena.service.LeadStageArenaService",
					"dm.gameplay.leadStageArena.model.LeadStageArenaHero"
				},
				injections = {
					singletons = {
						"LeadStageArenaSystem"
					},
					classes = {
						"LeadStageArenaService"
					},
					views = {
						{
							res = "asset/ui/LeadStageAreaMain.csb",
							name = "LeadStageArenaMainView",
							mediator = "LeadStageArenaMainMediator"
						},
						{
							res = "asset/ui/LeadStageAreaRank.csb",
							name = "LeadStageArenaRankView",
							mediator = "LeadStageArenaRankViewMediator"
						},
						{
							res = "asset/ui/LeadStageArenaPlayerInfo.csb",
							name = "LeadStageArenaPlayerInfoView",
							mediator = "LeadStageArenaPlayerInfoViewMediator"
						},
						{
							res = "asset/ui/leadStageAreaLoading.csb",
							name = "LeadStageArenaLoadingView",
							mediator = "LeadStageArenaLoadingMediator"
						},
						{
							res = "asset/ui/LeadStageAreaRival.csb",
							name = "LeadStageArenaRivalView",
							mediator = "LeadStageArenaRivalMediator"
						},
						{
							res = "asset/ui/StageAreaFreshRival.csb",
							name = "LeadStageArenaFreshRivalView",
							mediator = "LeadStageArenaFreshRivalMediator"
						},
						{
							res = "asset/ui/LeadStageAreaTeamList.csb",
							name = "LeadStageArenaTeamListView",
							mediator = "LeadStageArenaTeamListMediator"
						},
						{
							res = "asset/ui/LeadStageAreaBattleFinish.csb",
							name = "LeadStageAreaBattleFinishView",
							mediator = "LeadStageAreaBattleFinishMediator"
						},
						{
							res = "asset/ui/LeadStageArenaTeam.csb",
							name = "LeadStageArenaTeamView",
							mediator = "LeadStageArenaTeamMediator"
						},
						{
							res = "asset/ui/ArenaReportMain.csb",
							name = "LeadStageArenaReportView",
							mediator = "LeadStageArenaReportViewMediator"
						},
						{
							res = "asset/ui/LeadStageArenaReward.csb",
							name = "LeadStageArenaRewardView",
							mediator = "LeadStageArenaRewardViewMediator"
						}
					}
				}
			},
			{
				name = "TSoul",
				requires = {
					"dm.gameplay.tsoul.service.TSoulService"
				},
				injections = {
					classes = {
						"TSoulService"
					},
					views = {
						{
							res = "asset/ui/TSoulMain.csb",
							name = "TSoulMainView",
							mediator = "TSoulMainMediator"
						},
						{
							res = "asset/ui/TSoulCompound.csb",
							name = "TSoulCompoundView",
							mediator = "TSoulCompoundMediator"
						},
						{
							res = "asset/ui/TSoulChange.csb",
							name = "TSoulChangeView",
							mediator = "TSoulChangeMediator"
						},
						{
							res = "asset/ui/TSoulItemTip.csb",
							name = "TSoulTipView",
							mediator = "TSoulTipMediator"
						},
						{
							res = "asset/ui/TSoulIntensify.csb",
							name = "TSoulIntensifyView",
							mediator = "TSoulIntensifyMediator"
						},
						{
							res = "asset/ui/TSoulIntensifySucc.csb",
							name = "TSoulIntensifySuccView",
							mediator = "TSoulIntensifySuccMediator"
						},
						{
							res = "asset/ui/TSoulSuit.csb",
							name = "TSoulSuitView",
							mediator = "TSoulSuitMediator"
						}
					}
				}
			},
			{
				name = "mazeTower",
				requires = {
					"dm.gameplay.mazeTower.controller.MazeTowerSystem",
					"dm.gameplay.mazeTower.service.MazeTowerService"
				},
				injections = {
					singletons = {
						"MazeTowerSystem"
					},
					classes = {
						"MazeTowerService"
					},
					views = {
						{
							res = "asset/ui/MazeTowerMain.csb",
							name = "MazeTowerMainView",
							mediator = "MazeTowerMainMediator"
						},
						{
							res = "asset/ui/MazeTowerMap.csb",
							name = "MazeTowerMapView",
							mediator = "MazeTowerMapMediator"
						},
						{
							res = "asset/ui/MazeTowerRank.csb",
							name = "MazeTowerRankView",
							mediator = "MazeTowerRankMediator"
						},
						{
							res = "asset/ui/MazeTowerReward.csb",
							name = "MazeTowerRewardView",
							mediator = "MazeTowerRewardMediator"
						},
						{
							res = "asset/ui/MazeTowerChallenge.csb",
							name = "MazeTowerChallengeView",
							mediator = "MazeTowerChallengeMediator"
						},
						{
							res = "asset/ui/MazeTowerFinish.csb",
							name = "MazeTowerFinishView",
							mediator = "MazeTowerFinishMediator"
						},
						{
							res = "asset/ui/MazeTowerPass.csb",
							name = "MazeTowerPassView",
							mediator = "MazeTowerPassMediator"
						}
					}
				}
			}
		}
	},
	battle = {
		requires = {
			"dm.battle.logic.all",
			"dm.battle.interactor.all",
			"dm.battle.builder.all",
			"dm.battle.view.BattleSceneMediator"
		},
		injections = {
			views = {
				{
					node = "cc.Scene",
					name = "battleScene",
					mediator = "BattleSceneMediator"
				}
			}
		},
		submodules = {
			{
				name = "regularBattleView",
				requires = {
					"dm.battle.view.BattleViewContext",
					"dm.battle.view.BattleUIMediator",
					"dm.battle.view.BattleMainMediator",
					"dm.battle.view.ClubBossBattleMainMediator",
					"dm.battle.view.DreamBattleMainMediator"
				},
				injections = {
					views = {
						{
							res = "asset/ui/PausePopUi.csb",
							name = "battlePauseView",
							mediator = "BattlePauseMediator"
						},
						{
							res = "asset/ui/BattleBossComingPopUi.csb",
							name = "battleBossComeView",
							mediator = "BattleBossComeMediator"
						},
						{
							res = "asset/ui/BattleProfessionalRestraintTip.csb",
							name = "battlerofessionalRestraintView",
							mediator = "BattlerofessionalRestraintMediator"
						},
						{
							node = "cc.Node",
							name = "battlePlayer",
							mediator = "BattleMainMediator"
						},
						{
							node = "cc.Node",
							name = "ClubBossBattleView",
							mediator = "ClubBossBattleMainMediator"
						},
						{
							node = "cc.Node",
							name = "DreamBattleView",
							mediator = "DreamBattleMainMediator"
						},
						{
							node = "cc.Node",
							name = "BattleItemShowView",
							mediator = "BattleItemMediator"
						}
					}
				}
			}
		}
	}
}
