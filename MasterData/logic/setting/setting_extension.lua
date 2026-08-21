-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/setting/setting_extension.lua

local setting_extension = {
	[-1] = {
		models = {
			"LoginModel",
			"MainSettingModel"
		},
		agents = {
			"LoginAgent"
		},
		controllers = {
			"LoginController",
			"UserPerformanceSampler"
		}
	},
	[0] = {
		configs = {
			"ConstConfig",
			"CriwareAudioConfig",
			"GraphicTextConfig",
			"CharacterAudioConfig",
			"LoadingConfig",
			"ItemCommonSortConfig",
			"StorySceneConfig",
			"ExpressionConfig",
			"WordConfig"
		},
		controllers = {
			"CriwareAudioController",
			"NewNoticeController",
			"MainPopController"
		},
		models = {
			"NewNoticeModel"
		}
	},
	{
		agents = {
			"UserAgent"
		}
	},
	{
		models = {
			"ItemModel",
			"BackpackBaseModel",
			"MainBackpackModel",
			"GainItemModel",
			"RoomBackpackModel",
			"CurrencyExchangeModel"
		},
		agents = {
			"BackpackAgent"
		},
		configs = {
			"BackpackConfig",
			"CurrencyExchangeConfig",
			"BackpackOtherConfig",
			"ComposeConfig"
		},
		controllers = {
			"ItemController",
			"MainBackpackController",
			"RoomBackpackController",
			"CurrencyExchangeController"
		}
	},
	{
		agents = {
			"BattleAgent"
		},
		models = {
			"BattleCampAdjustmentModel",
			"BattleCalculateModel",
			"BattleViewStateModel",
			"BattleExternalDataModel"
		},
		configs = {
			"ModelConfig",
			"TerrainConfig",
			"ActiveSkillConfig",
			"BuffConfig",
			"BattleConfig",
			"EffectConfig",
			"LightConfig",
			"CameraConfig",
			"SceneConfig",
			"VideoConfig",
			"CameraShakeConfig",
			"DungeonBattleInfoConfig",
			"AttributeDefineConfig",
			"PianoMusicConfig"
		},
		controllers = {
			"BattleReconnectController"
		}
	},
	{
		models = {
			"TeamModel"
		},
		agents = {
			"TeamAgent"
		},
		configs = {
			"TeamConfig"
		},
		controllers = {}
	},
	{
		models = {
			"DungeonEntranceModel",
			"DungeonMainLineChapterModel",
			"DungeonModel",
			"DungeonMaterialChapterModel",
			"DungeonTeachingChapterModel",
			"DungeonEquipExploreChapterModel",
			"ClimbingTowerDarkModel",
			"ClimbingTowerModel",
			"DungeonControlModel"
		},
		agents = {
			"DungeonAgent"
		},
		configs = {
			"DungeonEntranceConfig",
			"DungeonConfig",
			"RewardConfig",
			"ClimbingTowerConfig"
		},
		controllers = {
			"DungeonController",
			"ClimbingTowerController",
			"MaterialDungeonController",
			"MainlineDungeonController",
			"EquipDungeonController"
		}
	},
	{
		models = {
			"BattleAttrHackModel",
			"HacktoolMo"
		},
		agents = {
			"HackToolAgent"
		},
		configs = {},
		controllers = {}
	},
	{
		models = {
			"HeroDepotModel",
			"SkillEnhanceModel",
			"HeroFavorStorageModel",
			"CharacterSystemModel",
			"CharacterPreviewModel"
		},
		agents = {
			"HeroDepotAgent"
		},
		configs = {
			"HeroSortRuleConfig",
			"HeroFilterRuleConfig",
			"CharacterConfig",
			"CharacterExpConfig",
			"CharacterUnlockContentConfig",
			"PastInfoConfig",
			"CutImageConfig",
			"CharacterPreviewConfig"
		},
		controllers = {
			"HeroDepotController",
			"CharacterSystemController"
		}
	},
	{
		models = {
			"PlayerModel",
			"HealthExchangeModel",
			"PlayerCourseModel",
			"PlayerCreateModel",
			"PlayerLocalStorgeModel",
			"MasterTrainingTaskModel",
			"HeroDetailInfoModel"
		},
		agents = {
			"PlayerAgent",
			"HealthExchangeAgent",
			"PlayerCourseAgent"
		},
		configs = {
			"PlayerConfig",
			"PlayerCourseConfig",
			"MasterTrainingTaskConfig"
		},
		controllers = {
			"PrefaceController",
			"PlayerController",
			"PlayerCourseController",
			"PlayerCreateController"
		}
	},
	{
		models = {
			"TacitModel"
		},
		agents = {
			"TacitAgent"
		},
		configs = {
			"TacitConfig"
		}
	},
	{
		models = {
			"ContractModel"
		},
		agents = {
			"ContractAgent"
		},
		configs = {
			"HeroPieceConfig",
			"HeroBreakConfig",
			"UniversalHeroItemConfig"
		},
		controllers = {
			"ContractControll"
		}
	},
	{
		models = {
			"CharacterAuthorityModel"
		},
		agents = {
			"HeroPowerAgent"
		},
		configs = {
			"HeroPowerConfig"
		}
	},
	{
		models = {
			"CharacterInformationModel"
		},
		configs = {},
		controllers = {
			"CharacterInformationController"
		}
	},
	{
		models = {
			"HeroSkinModel"
		},
		agents = {
			"HeroSkinAgent"
		},
		configs = {
			"HeroSkinConfig"
		},
		controllers = {}
	},
	{
		models = {
			"RoguelikeModel",
			"RogueExploreModel"
		},
		agents = {
			"RoguelikeAgent",
			"RogueExploreAgent",
			"RogueEquipAgent",
			"RogueGameAgent",
			"RogueJudgeAgent",
			"RoguePropAgent",
			"RogueTaskAgent"
		},
		configs = {
			"RoguelikeConfig",
			"RogueConstConfig"
		},
		controllers = {
			"RoguelikeController",
			"RogueJudgeController"
		}
	},
	{
		models = {
			"HouseModel",
			"HouseWorkerModel",
			"HouseNavigationModel",
			"TradingModel",
			"HeroHouseFeatureModel",
			"HouseMainStateModel",
			"HouseMainRoomModel",
			"LivingFacilitiesZoneModel",
			"LivingFacilitiesFurniThemeModel",
			"HouseFurnitureModel",
			"SupervisorModel",
			"ManufactureModel",
			"ContainmentModel",
			"ContainmentReportModel",
			"ProtomerModel",
			"HouseTaskModel",
			"RoomFurnitureEditModel"
		},
		agents = {
			"HouseAgent",
			"TradingAgent",
			"ContainmentZoneAgent",
			"LivingFacilitiesAgent",
			"SupervisorAgent",
			"ManufactureAgent"
		},
		configs = {
			"HouseConfig",
			"TradingConfig",
			"ContainmentConfig",
			"LivingFacilitiesConfig",
			"SupervisorConfig",
			"ManufactureConfig"
		},
		controllers = {
			"HouseController",
			"HouseGMController",
			"HouseMainController",
			"HouseFocusController",
			"LivingFacilitiesFurnitureController",
			"LivingFacilitiesZoneController",
			"ContainmentController",
			"HouseTaskController"
		}
	},
	{
		agents = {
			"GuideAgent",
			"NewbieTaskAgent"
		},
		configs = {
			"GuideConfig",
			"NewbieTaskConfig"
		},
		models = {
			"GuideModel",
			"NewbieTaskModel"
		},
		controllers = {
			"GuideController",
			"GuideStepController",
			"NewbieTaskController"
		}
	},
	{
		agents = {
			"EquipmentAgent"
		},
		configs = {
			"EquipmentConfig"
		},
		models = {
			"EquipSuitModel",
			"EquipIntensifyRecycleModel",
			"EquipIntensifyModel"
		},
		controllers = {
			"EquipController",
			"EquipIntensifyController"
		}
	},
	{
		agents = {
			"EchoItemAgent"
		},
		configs = {
			"EchoItemConfig"
		},
		models = {
			"EchoItemModel"
		},
		controllers = {
			"EchoItemController",
			"EchoItemMainController"
		}
	},
	{
		agents = {
			"RetrieveAgent"
		},
		configs = {
			"RetrieveConfig",
			"EchoCardPackConfig"
		},
		models = {
			"RetrieveModel",
			"RetrieveLogModel"
		},
		controllers = {
			"RetrieveController",
			"EchoCardPackController"
		}
	},
	{
		agents = {
			"ActivityAgent",
			"WelfareSigninAgent",
			"RoleExperienceAgent"
		},
		configs = {
			"WelfareSigninConfig",
			"WelfareConfig",
			"RoleExperienceConfig",
			"ActivityConfig",
			"WeekendSupplyConfig",
			"PowerChallengeConfig",
			"MultipleDropConfig"
		},
		models = {
			"ActivityModel",
			"WelfareSigninModel",
			"ActTaskRewardModel",
			"PowerChallengeModel",
			"MultipleDropModel"
		},
		controllers = {
			"ActivityController",
			"SigninController",
			"ActTaskRewardController",
			"PowerChallengeController",
			"MultipleDropController"
		}
	},
	{
		agents = {
			"MailAgent"
		},
		configs = {
			"MailConfig"
		},
		models = {
			"MailMoList"
		},
		controllers = {}
	},
	{
		agents = {
			"SystemOpenAgent"
		},
		configs = {
			"SystemOpenConfig"
		},
		models = {
			"SystemOpenModel"
		},
		controllers = {
			"SystemOpenController"
		}
	},
	{
		agents = {
			"StoreAgent"
		},
		configs = {
			"StoreConfig"
		},
		models = {
			"StoreModel",
			"PushGiftPackageModel"
		},
		controllers = {
			"StoreController",
			"StoreRechargeController",
			"PushGiftPackageController"
		}
	},
	{
		agents = {
			"ThinkingAgent"
		},
		configs = {
			"ThinkingConfig"
		},
		models = {
			"ThinkingModel"
		},
		controllers = {
			"ThinkingController"
		}
	},
	{
		agents = {
			"TextDetectAgent"
		}
	},
	{
		agents = {
			"TaskAgent"
		},
		configs = {
			"TaskConfig",
			"ActivityTaskConfig"
		},
		models = {
			"TaskModel"
		},
		controllers = {
			"MainUITaskController"
		}
	},
	{
		agents = {
			"AchievementAgent",
			"MonumentAgent"
		},
		configs = {
			"AchievementConfig",
			"MonumentConfig"
		},
		models = {
			"AchievementModel",
			"MonumentModel",
			"MaskModel"
		},
		controllers = {
			"AchievementController",
			"MonumentController"
		}
	},
	{
		agents = {
			"RedDotAgent"
		},
		configs = {
			"RedDotConfig"
		},
		models = {
			"RedDotModel"
		},
		controllers = {
			"RedDotController"
		}
	},
	{
		agents = {
			"FriendAgent",
			"ReportAgent"
		},
		configs = {},
		models = {
			"FriendModel"
		},
		controllers = {
			"FriendController"
		}
	},
	{
		agents = {
			"ChatAgent"
		},
		configs = {
			"ChatConfig"
		},
		models = {
			"ChatModel",
			"ChatHistoryModel"
		},
		controllers = {
			"ChatController"
		}
	},
	{
		agents = {
			"GalleryAgent"
		},
		configs = {
			"HandbookConfig"
		},
		models = {
			"GalleryModel"
		},
		controllers = {
			"HandbookController"
		}
	},
	{
		agents = {
			"GroupActivityAgent"
		},
		configs = {
			"TimeLimitActivityConfig",
			"FootBallConfig"
		},
		models = {
			"TimeLimitActivityModel",
			"FootballModel"
		}
	},
	{
		agents = {
			"RankAgent"
		},
		configs = {
			"RankConfig"
		},
		models = {
			"RankNetModel"
		},
		controllers = {
			"RankController"
		}
	},
	{
		agents = {
			"FootballAgent"
		}
	},
	{
		agents = {
			"AirWorkShopAtkAgent"
		},
		configs = {
			"AirWorkShopConfig"
		},
		models = {
			"AirWorkShopChallengeModel",
			"AirWorkShopFreeModel",
			"AirWorkShopRecordModel",
			"AirWorkMapModel",
			"AirWorkShopStatisticsModel",
			"AirWorkShopModel",
			"AirWorkShopDefSceneModel",
			"LeaveMsgModel",
			"AirWorkShopStoreModel"
		},
		controllers = {
			"AirWorkShopController",
			"AirWorkBattleResultController"
		}
	},
	{
		agents = {
			"AirWorkShopDefAgent"
		}
	},
	{
		agents = {
			"SurveyAgent"
		},
		configs = {
			"SurveyConfig"
		},
		models = {
			"SurveyModel"
		}
	},
	{
		agents = {
			"SeasonAgent"
		},
		configs = {
			"SeasonConfig"
		},
		models = {
			"SeasonModel"
		},
		controllers = {
			"SeasonController",
			"SeasonTopTipsController"
		}
	},
	{
		agents = {
			"AirtightRoomAgent"
		},
		models = {
			"AirtightRoomModel"
		},
		controllers = {
			"AirtightRoomController"
		}
	},
	{
		agents = {
			"BattleRecordAgent"
		},
		models = {
			"BattleRecordModel"
		}
	},
	{
		agents = {
			"NotifyAgent"
		}
	},
	{
		agents = {
			"ChamberAgent"
		},
		configs = {
			"ChamberConfig"
		},
		models = {
			"ChamberModel"
		}
	},
	{
		agents = {
			"ControlActionAgent"
		},
		configs = {
			"ControlActionConfig"
		},
		models = {
			"ControlActionModel"
		}
	},
	{
		agents = {
			"SpecialtrainingAgent"
		},
		configs = {
			"SpecialtrainingConfig"
		},
		models = {
			"SpecialtrainingModel"
		}
	},
	{
		agents = {
			"CharacterPreinstallAgent"
		},
		configs = {
			"CharacterPreinstallConfig"
		},
		models = {
			"CharacterPreinstallModle"
		},
		controllers = {
			"CharacterPreinstallController"
		}
	},
	{
		agents = {
			"ClawDollAgent"
		},
		configs = {
			"ClawDollConfig"
		},
		models = {
			"ClawDollModel"
		},
		controllers = {
			"ClawDollController"
		}
	},
	{
		agents = {
			"StoreRechargeAgent"
		},
		configs = {
			"StoreRechargeConfig"
		},
		models = {
			"StoreRechargeModel"
		}
	},
	{
		agents = {
			"MonthSignInAgent"
		},
		configs = {
			"MonthSigninConfig"
		},
		models = {
			"MonthSigninModel"
		},
		controllers = {
			"MonthSigninController"
		}
	},
	[256] = {
		models = {},
		agents = {},
		configs = {},
		controllers = {
			"TestController"
		}
	},
	[257] = {
		models = {
			"ShareModel"
		},
		agents = {},
		configs = {},
		controllers = {
			"ToolTipsController",
			"ViewBlackFadeController"
		}
	},
	[258] = {
		models = {
			"SystemJumpModel"
		},
		agents = {},
		configs = {
			"SystemJumpConfig"
		},
		controllers = {
			"SystemJumpController"
		}
	},
	[260] = {
		models = {},
		agents = {},
		configs = {},
		controllers = {
			"GainItemController",
			"ItemConvertController",
			"PlayerAttributeGainTipsController"
		}
	},
	[262] = {
		models = {
			"MainUIModel"
		},
		agents = {},
		configs = {
			"MainPerformConfig"
		},
		controllers = {
			"MainUIController"
		}
	},
	[263] = {
		models = {
			"MoneyModel",
			"EnergyRecoverModel"
		},
		agents = {},
		configs = {},
		controllers = {
			"MoneyController"
		}
	},
	[264] = {
		models = {},
		agents = {},
		configs = {},
		controllers = {
			"MsgBoardController"
		}
	},
	[265] = {
		models = {
			"SystemSideTipModel"
		},
		agents = {},
		configs = {},
		controllers = {
			"SystemSideTipController"
		}
	},
	[266] = {
		models = {
			"LoginPopUpsModel"
		},
		agents = {},
		configs = {
			"LoginPopUpsConfig"
		},
		controllers = {
			"LoginPopUpsController"
		}
	},
	[267] = {
		models = {},
		agents = {},
		configs = {},
		controllers = {
			"MarqueeController"
		}
	},
	[268] = {
		models = {
			"TipsBlockModel"
		},
		agents = {},
		configs = {},
		controllers = {
			"TipsBlockController"
		}
	},
	[269] = {
		configs = {},
		models = {},
		controllers = {
			"StoryController",
			"StoryVoiceController"
		}
	},
	[270] = {
		configs = {
			"ActivityIntegralDropConfig"
		},
		models = {
			"ActivityIntegralDropModel"
		},
		controllers = {
			"ActivityIntegralDropController"
		}
	},
	[271] = {
		configs = {
			"MainUIActBannerConfig"
		},
		models = {
			"MainUIActBannerModel"
		}
	}
}

return setting_extension
