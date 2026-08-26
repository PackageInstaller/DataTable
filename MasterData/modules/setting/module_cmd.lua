-- chunkname: @modules/setting/module_cmd.lua

local module_cmd = {
	[-12977] = {
		"Achievement",
		"GetAchievementInfoRequest",
		"GetAchievementInfoReply"
	},
	[-23802] = {
		"Achievement",
		"UpdateAchievementPush"
	},
	[4196] = {
		"Achievement",
		"ShowAchievementRequest",
		"ShowAchievementReply"
	},
	[-6711] = {
		"Achievement",
		"ReadNewAchievementRequest",
		"ReadNewAchievementReply"
	},
	[-26993] = {
		"Activity101",
		"Get101InfosRequest",
		"Get101InfosReply"
	},
	[-26057] = {
		"Activity101",
		"Get101BonusRequest",
		"Get101BonusReply"
	},
	[-20678] = {
		"Activity101",
		"Get101SpBonusRequest",
		"Get101SpBonusReply"
	},
	[23918] = {
		"Activity101",
		"Get101OnceBonusRequest",
		"Get101OnceBonusReply"
	},
	[2973] = {
		"Activity101",
		"GetAct186SpBonusInfoRequest",
		"GetAct186SpBonusInfoReply"
	},
	[833] = {
		"Activity101",
		"AcceptAct186SpBonusRequest",
		"AcceptAct186SpBonusReply"
	},
	[22643] = {
		"Activity101",
		"Get101BonusListRequest",
		"Get101BonusListReply"
	},
	[30322] = {
		"Activity104",
		"Get104InfosRequest",
		"Get104InfosReply"
	},
	[-1274] = {
		"Activity104",
		"BeforeStartAct104BattleRequest",
		"BeforeStartAct104BattleReply"
	},
	[17779] = {
		"Activity104",
		"StartAct104BattleRequest",
		"StartAct104BattleReply"
	},
	[-18639] = {
		"Activity104",
		"Act104BattleFinishPush"
	},
	[2686] = {
		"Activity104",
		"Activity104ItemChangePush"
	},
	[-14612] = {
		"Activity104",
		"RefreshRetailRequest",
		"RefreshRetailReply"
	},
	[-1592] = {
		"Activity104",
		"OptionalActivity104EquipRequest",
		"OptionalActivity104EquipReply"
	},
	[984] = {
		"Activity104",
		"ComposeActivity104EquipRequest",
		"ComposeActivity104EquipReply"
	},
	[-7999] = {
		"Activity104",
		"ChangeFightGroupRequest",
		"ChangeFightGroupReply"
	},
	[13866] = {
		"Activity104",
		"MarkActivity104StoryRequest",
		"MarkActivity104StoryReply"
	},
	[-10333] = {
		"Activity104",
		"MarkEpisodeAfterStoryRequest",
		"MarkEpisodeAfterStoryReply"
	},
	[-20690] = {
		"Activity104",
		"GetUnlockActivity104EquipIdsRequest",
		"GetUnlockActivity104EquipIdsReply"
	},
	[15428] = {
		"Activity104",
		"MarkPopSummaryRequest",
		"MarkPopSummaryReply"
	},
	[-2869] = {
		"Activity106",
		"Get106InfosRequest",
		"Get106InfosReply"
	},
	[-18609] = {
		"Activity106",
		"Get106OrderBonusRequest",
		"Get106OrderBonusReply"
	},
	[13419] = {
		"Activity106",
		"Update106OrderPush"
	},
	[7894] = {
		"Activity107",
		"Get107GoodsInfoRequest",
		"Get107GoodsInfoReply"
	},
	[-21126] = {
		"Activity107",
		"Buy107GoodsRequest",
		"Buy107GoodsReply"
	},
	[-24330] = {
		"Activity108",
		"Get108InfosRequest",
		"Get108InfosReply"
	},
	[10808] = {
		"Activity108",
		"ResetMapRequest",
		"ResetMapReply"
	},
	[-32535] = {
		"Activity108",
		"DialogEventSelectRequest",
		"DialogEventSelectReply"
	},
	[-14999] = {
		"Activity108",
		"EnterFightEventRequest",
		"EnterFightEventReply"
	},
	[-29682] = {
		"Activity108",
		"EpisodeConfirmRequest",
		"EpisodeConfirmReply"
	},
	[-23394] = {
		"Activity108",
		"Get108BonusRequest",
		"Get108BonusReply"
	},
	[30819] = {
		"Activity108",
		"EpisodeUpdatePush"
	},
	[23622] = {
		"Activity108",
		"InfoUpdatePush"
	},
	[1846] = {
		"Activity109",
		"GetAct109InfoRequest",
		"GetAct109InfoReply"
	},
	[-31295] = {
		"Activity109",
		"Act109StartEpisodeRequest",
		"Act109StartEpisodeReply"
	},
	[-31881] = {
		"Activity109",
		"Act109BeginRoundRequest",
		"Act109BeginRoundReply"
	},
	[9766] = {
		"Activity109",
		"Act109StepPush"
	},
	[-5338] = {
		"Activity109",
		"Act109UseItemRequest",
		"Act109UseItemReply"
	},
	[-17629] = {
		"Activity109",
		"Act109EventEndRequest",
		"Act109EventEndReply"
	},
	[-11262] = {
		"Activity109",
		"Act109AbortRequest",
		"Act109AbortReply"
	},
	[-8822] = {
		"Activity109",
		"Act109MarkNewEpisodeRedDotRequest",
		"Act109MarkNewEpisodeRedDotReply"
	},
	[13648] = {
		"Activity111",
		"Get111InfosRequest",
		"Get111InfosReply"
	},
	[-14565] = {
		"Activity111",
		"FinishEpisodeRequest",
		"FinishEpisodeReply"
	},
	[8892] = {
		"Activity111",
		"Act111InfoPush"
	},
	[-24063] = {
		"Activity111",
		"PushBoxTaskPush"
	},
	[-18283] = {
		"Activity111",
		"ReceiveTaskRewardRequest",
		"ReceiveTaskRewardReply"
	},
	[-32204] = {
		"Activity111",
		"MarkRedDot1039Request",
		"MarkRedDot1039Reply"
	},
	[32753] = {
		"Activity112",
		"Get112InfosRequest",
		"Get112InfosReply"
	},
	[-25227] = {
		"Activity112",
		"Exchange112Request",
		"Exchange112Reply"
	},
	[22629] = {
		"Activity112",
		"Act112TaskPush"
	},
	[-3038] = {
		"Activity112",
		"ReceiveAct112TaskRewardRequest",
		"ReceiveAct112TaskRewardReply"
	},
	[4268] = {
		"Activity113",
		"GetAct113InfoRequest",
		"GetAct113InfoReply"
	},
	[-27785] = {
		"Activity113",
		"GetAct113MilestoneBonusRequest",
		"GetAct113MilestoneBonusReply"
	},
	[5427] = {
		"Activity114",
		"Get114InfosRequest",
		"Get114InfosReply"
	},
	[19490] = {
		"Activity114",
		"Act114InfoPush"
	},
	[7849] = {
		"Activity114",
		"Act114TaskPush"
	},
	[31526] = {
		"Activity114",
		"ReceiveAct114TaskRewardRequest",
		"ReceiveAct114TaskRewardReply"
	},
	[3165] = {
		"Activity114",
		"Act114EducateRequest",
		"Act114EducateReply"
	},
	[32560] = {
		"Activity114",
		"Act114TravelRequest",
		"Act114TravelReply"
	},
	[1707] = {
		"Activity114",
		"Act114MeetingRequest",
		"Act114MeetingReply"
	},
	[-2540] = {
		"Activity114",
		"CheckEventRequest",
		"CheckEventReply"
	},
	[-22464] = {
		"Activity114",
		"Act114RestRequest",
		"Act114RestReply"
	},
	[9961] = {
		"Activity114",
		"Act114KeyDayRequest",
		"Act114KeyDayReply"
	},
	[-16126] = {
		"Activity114",
		"Act114TestRequest",
		"Act114TestReply"
	},
	[-20795] = {
		"Activity114",
		"Act114ResetRequest",
		"Act114ResetReply"
	},
	[-27471] = {
		"Activity114",
		"BeforeAct114BattleRequest",
		"BeforeAct114BattleReply"
	},
	[-29606] = {
		"Activity114",
		"EnterSchoolRequest",
		"EnterSchoolReply"
	},
	[-18936] = {
		"Activity114",
		"MarkRoundStoryRequest",
		"MarkRoundStoryReply"
	},
	[-18774] = {
		"Activity114",
		"MarkMeetingPlayUnlockRequest",
		"MarkMeetingPlayUnlockReply"
	},
	[-11825] = {
		"Activity114",
		"MarkTravelPlayUnlockRequest",
		"MarkTravelPlayUnlockReply"
	},
	[11617] = {
		"Activity114",
		"MarkUnlockNewPhotoRedDotRequest",
		"MarkUnlockNewPhotoRedDotReply"
	},
	[28720] = {
		"Activity115",
		"GetAct115InfoRequest",
		"GetAct115InfoReply"
	},
	[15835] = {
		"Activity115",
		"Act115StartEpisodeRequest",
		"Act115StartEpisodeReply"
	},
	[27921] = {
		"Activity115",
		"Act115BeginRoundRequest",
		"Act115BeginRoundReply"
	},
	[-7872] = {
		"Activity115",
		"Act115StepPush"
	},
	[30269] = {
		"Activity115",
		"Act115EventEndRequest",
		"Act115EventEndReply"
	},
	[-10916] = {
		"Activity115",
		"Act115AbortRequest",
		"Act115AbortReply"
	},
	[2795] = {
		"Activity115",
		"Act115BonusRequest",
		"Act115BonusReply"
	},
	[8688] = {
		"Activity115",
		"Act115UseSkillRequest",
		"Act115UseSkillReply"
	},
	[7324] = {
		"Activity115",
		"Act115RevertRequest",
		"Act115RevertReply"
	},
	[-21899] = {
		"Activity116",
		"Get116InfosRequest",
		"Get116InfosReply"
	},
	[-25784] = {
		"Activity116",
		"UpgradeElementRequest",
		"UpgradeElementReply"
	},
	[15069] = {
		"Activity116",
		"BuildTrapRequest",
		"BuildTrapReply"
	},
	[14118] = {
		"Activity116",
		"PutTrapRequest",
		"PutTrapReply"
	},
	[9013] = {
		"Activity116",
		"Act116InfoUpdatePush"
	},
	[-29804] = {
		"Activity117",
		"Act117InfoRequest",
		"Act117InfoReply"
	},
	[14376] = {
		"Activity117",
		"Act117NegotiateRequest",
		"Act117NegotiateReply"
	},
	[-22850] = {
		"Activity117",
		"Act117DealRequest",
		"Act117DealReply"
	},
	[5295] = {
		"Activity117",
		"Act117GetBonusRequest",
		"Act117GetBonusReply"
	},
	[-25980] = {
		"Activity117",
		"Act117OrderPush"
	},
	[-22168] = {
		"Activity120",
		"GetAct120InfoRequest",
		"GetAct120InfoReply"
	},
	[9363] = {
		"Activity120",
		"Act120StartEpisodeRequest",
		"Act120StartEpisodeReply"
	},
	[17865] = {
		"Activity120",
		"Act120BeginRoundRequest",
		"Act120BeginRoundReply"
	},
	[11256] = {
		"Activity120",
		"Act120StepPush"
	},
	[32440] = {
		"Activity120",
		"Act120UseItemRequest",
		"Act120UseItemReply"
	},
	[-16139] = {
		"Activity120",
		"Act120EventEndRequest",
		"Act120EventEndReply"
	},
	[23316] = {
		"Activity120",
		"Act120AbortRequest",
		"Act120AbortReply"
	},
	[13764] = {
		"Activity120",
		"Act120CheckPointRequest",
		"Act120CheckPointReply"
	},
	[-11247] = {
		"Activity121",
		"Get121InfosRequest",
		"Get121InfosReply"
	},
	[28173] = {
		"Activity121",
		"Get121BonusRequest",
		"Get121BonusReply"
	},
	[22721] = {
		"Activity121",
		"Act121UpdatePush"
	},
	[7858] = {
		"Activity122",
		"GetAct122InfosRequest",
		"GetAct122InfosReply"
	},
	[-14505] = {
		"Activity122",
		"Act122StartEpisodeRequest",
		"Act122StartEpisodeReply"
	},
	[26509] = {
		"Activity122",
		"Act122BeginRoundRequest",
		"Act122BeginRoundReply"
	},
	[-7568] = {
		"Activity122",
		"Act122StepPush"
	},
	[22268] = {
		"Activity122",
		"Act122UseItemRequest",
		"Act122UseItemReply"
	},
	[-24135] = {
		"Activity122",
		"Act122EventEndRequest",
		"Act122EventEndReply"
	},
	[21080] = {
		"Activity122",
		"Act122AbortRequest",
		"Act122AbortReply"
	},
	[22408] = {
		"Activity122",
		"Act122CheckPointRequest",
		"Act122CheckPointReply"
	},
	[26963] = {
		"Activity123",
		"Get123InfosRequest",
		"Get123InfosReply"
	},
	[5437] = {
		"Activity123",
		"Act123EnterStageRequest",
		"Act123EnterStageReply"
	},
	[26358] = {
		"Activity123",
		"Act123EndStageRequest",
		"Act123EndStageReply"
	},
	[31797] = {
		"Activity123",
		"StartAct123BattleRequest",
		"StartAct123BattleReply"
	},
	[25811] = {
		"Activity123",
		"Act123BattleFinishPush"
	},
	[31376] = {
		"Activity123",
		"Act123ChangeFightGroupRequest",
		"Act123ChangeFightGroupReply"
	},
	[-9259] = {
		"Activity123",
		"Act123ItemChangePush"
	},
	[-28955] = {
		"Activity123",
		"ComposeAct123EquipRequest",
		"ComposeAct123EquipReply"
	},
	[-6834] = {
		"Activity123",
		"DecomposeAct123EquipRequest",
		"DecomposeAct123EquipReply"
	},
	[18145] = {
		"Activity123",
		"Act123OpenCardBagRequest",
		"Act123OpenCardBagReply"
	},
	[22939] = {
		"Activity123",
		"GetUnlockAct123EquipIdsRequest",
		"GetUnlockAct123EquipIdsReply"
	},
	[-20124] = {
		"Activity123",
		"Act123ResetOtherStageRequest",
		"Act123ResetOtherStageReply"
	},
	[-10037] = {
		"Activity123",
		"Act123ResetHighLayerRequest",
		"Act123ResetHighLayerReply"
	},
	[-26242] = {
		"Activity123",
		"GetAct123StageRecordRequest",
		"GetAct123StageRecordReply"
	},
	[-28000] = {
		"Activity123",
		"Act123ReceiveStageBonusRequest",
		"Act123ReceiveStageBonusReply"
	},
	[-19468] = {
		"Activity124",
		"GetAct124InfosRequest",
		"GetAct124InfosReply"
	},
	[-11346] = {
		"Activity124",
		"FinishAct124EpisodeRequest",
		"FinishAct124EpisodeReply"
	},
	[14028] = {
		"Activity124",
		"ReceiveAct124RewardRequest",
		"ReceiveAct124RewardReply"
	},
	[-363] = {
		"Activity125",
		"GetAct125InfosRequest",
		"GetAct125InfosReply"
	},
	[27792] = {
		"Activity125",
		"FinishAct125EpisodeRequest",
		"FinishAct125EpisodeReply"
	},
	[18742] = {
		"Activity126",
		"Get126InfosRequest",
		"Get126InfosReply"
	},
	[15535] = {
		"Activity126",
		"UpdateProgressRequest",
		"UpdateProgressReply"
	},
	[-26545] = {
		"Activity126",
		"ResetProgressRequest",
		"ResetProgressReply"
	},
	[-27255] = {
		"Activity126",
		"HoroscopeRequest",
		"HoroscopeReply"
	},
	[25001] = {
		"Activity126",
		"GetHoroscopeRequest",
		"GetHoroscopeReply"
	},
	[-9786] = {
		"Activity126",
		"UnlockBuffRequest",
		"UnlockBuffReply"
	},
	[15060] = {
		"Activity126",
		"ExchangeStarPush"
	},
	[4439] = {
		"Activity126",
		"Act126InfoUpdatePush"
	},
	[3463] = {
		"Activity126",
		"EnterFightRequest",
		"EnterFightReply"
	},
	[-8584] = {
		"Activity128",
		"Get128InfosRequest",
		"Get128InfosReply"
	},
	[10535] = {
		"Activity128",
		"Act128GetTotalRewardsRequest",
		"Act128GetTotalRewardsReply"
	},
	[21046] = {
		"Activity128",
		"Act128GetTotalSingleRewardRequest",
		"Act128GetTotalSingleRewardReply"
	},
	[28752] = {
		"Activity128",
		"Act128DoublePointRequest",
		"Act128DoublePointReply"
	},
	[14305] = {
		"Activity128",
		"Act128SpFirstHalfSelectItemRequest",
		"Act128SpFirstHalfSelectItemReply"
	},
	[-12945] = {
		"Activity128",
		"Act128ChangeActModeRequest",
		"Act128ChangeActModeReply"
	},
	[-18168] = {
		"Activity128",
		"GetGalleryInfosRequest",
		"GetGalleryInfosReply"
	},
	[31065] = {
		"Activity128",
		"Act128GetExpRequest",
		"Act128GetExpReply"
	},
	[-31645] = {
		"Activity128",
		"Act128GetMilestoneBonusRequest",
		"Act128GetMilestoneBonusReply"
	},
	[31423] = {
		"Activity128",
		"SetAct128TeamRequest",
		"SetAct128TeamReply"
	},
	[20854] = {
		"Activity128",
		"ResetAct128TeamRequest",
		"ResetAct128TeamReply"
	},
	[10521] = {
		"Activity129",
		"Get129InfosRequest",
		"Get129InfosReply"
	},
	[-7795] = {
		"Activity129",
		"Act129LotteryRequest",
		"Act129LotteryReply"
	},
	[10289] = {
		"Activity130",
		"Get130InfosRequest",
		"Get130InfosReply"
	},
	[-7457] = {
		"Activity130",
		"Act130StoryRequest",
		"Act130StoryReply"
	},
	[-28196] = {
		"Activity130",
		"Act130GeneralRequest",
		"Act130GeneralReply"
	},
	[2062] = {
		"Activity130",
		"Act130DialogRequest",
		"Act130DialogReply"
	},
	[-3616] = {
		"Activity130",
		"Act130DialogHistoryRequest",
		"Act130DialogHistoryReply"
	},
	[27742] = {
		"Activity130",
		"Act130ElementsPush"
	},
	[-1204] = {
		"Activity130",
		"Act130RestartEpisodeRequest",
		"Act130RestartEpisodeReply"
	},
	[1862] = {
		"Activity130",
		"Act130StartGameRequest",
		"Act130StartGameReply"
	},
	[29394] = {
		"Activity131",
		"Get131InfosRequest",
		"Get131InfosReply"
	},
	[24193] = {
		"Activity131",
		"Act131StoryRequest",
		"Act131StoryReply"
	},
	[32254] = {
		"Activity131",
		"Act131GeneralRequest",
		"Act131GeneralReply"
	},
	[-2064] = {
		"Activity131",
		"Act131DialogRequest",
		"Act131DialogReply"
	},
	[-4222] = {
		"Activity131",
		"Act131DialogHistoryRequest",
		"Act131DialogHistoryReply"
	},
	[-28559] = {
		"Activity131",
		"Act131ElementsPush"
	},
	[-21202] = {
		"Activity131",
		"Act131RestartEpisodeRequest",
		"Act131RestartEpisodeReply"
	},
	[-18289] = {
		"Activity131",
		"BeforeAct131BattleRequest",
		"BeforeAct131BattleReply"
	},
	[-17037] = {
		"Activity132",
		"Get132InfosRequest",
		"Get132InfosReply"
	},
	[-24320] = {
		"Activity132",
		"Act132UnlockRequest",
		"Act132UnlockReply"
	},
	[20875] = {
		"Activity133",
		"Get133InfosRequest",
		"Get133InfosReply"
	},
	[-3221] = {
		"Activity133",
		"Act133BonusRequest",
		"Act133BonusReply"
	},
	[-13011] = {
		"Activity134",
		"Get134InfosRequest",
		"Get134InfosReply"
	},
	[28429] = {
		"Activity134",
		"Act134BonusRequest",
		"Act134BonusReply"
	},
	[15422] = {
		"Activity136",
		"Get136InfoRequest",
		"Get136InfoReply"
	},
	[-28758] = {
		"Activity136",
		"Act136SelectRequest",
		"Act136SelectReply"
	},
	[-14374] = {
		"Activity139",
		"Get139InfosRequest",
		"Get139InfosReply"
	},
	[-6069] = {
		"Activity139",
		"Act139DispatchRequest",
		"Act139DispatchReply"
	},
	[-31272] = {
		"Activity139",
		"Act139InterruptDispatchRequest",
		"Act139InterruptDispatchReply"
	},
	[10570] = {
		"Activity139",
		"Act139GainSubHeroTaskRewardRequest",
		"Act139GainSubHeroTaskRewardReply"
	},
	[20864] = {
		"Activity139",
		"Act139GainHeroTaskRewardRequest",
		"Act139GainHeroTaskRewardReply"
	},
	[27166] = {
		"Activity139",
		"Act139GainExploreRewardRequest",
		"Act139GainExploreRewardReply"
	},
	[-14606] = {
		"Activity140",
		"Get140InfosRequest",
		"Get140InfosReply"
	},
	[-17469] = {
		"Activity140",
		"Act140BuildRequest",
		"Act140BuildReply"
	},
	[26527] = {
		"Activity140",
		"Act140SelectBuildRequest",
		"Act140SelectBuildReply"
	},
	[16620] = {
		"Activity140",
		"Act140GainProgressRewardRequest",
		"Act140GainProgressRewardReply"
	},
	[22768] = {
		"Activity142",
		"GetAct142InfoRequest",
		"GetAct142InfoReply"
	},
	[-15717] = {
		"Activity142",
		"Act142StartEpisodeRequest",
		"Act142StartEpisodeReply"
	},
	[-15919] = {
		"Activity142",
		"Act142BeginRoundRequest",
		"Act142BeginRoundReply"
	},
	[1536] = {
		"Activity142",
		"Act142StepPush"
	},
	[14272] = {
		"Activity142",
		"Act142UseItemRequest",
		"Act142UseItemReply"
	},
	[-25859] = {
		"Activity142",
		"Act142EventEndRequest",
		"Act142EventEndReply"
	},
	[12828] = {
		"Activity142",
		"Act142AbortRequest",
		"Act142AbortReply"
	},
	[-20020] = {
		"Activity142",
		"Act142CheckPointRequest",
		"Act142CheckPointReply"
	},
	[-22685] = {
		"Activity142",
		"GetAct142CollectionsRequest",
		"GetAct142CollectionsReply"
	},
	[-20206] = {
		"Activity142",
		"Act142UseFireballRequest",
		"Act142UseFireballReply"
	},
	[-3722] = {
		"Activity144",
		"Get144InfosRequest",
		"Get144InfosReply"
	},
	[26927] = {
		"Activity144",
		"Act144EnterEpisodeRequest",
		"Act144EnterEpisodeReply"
	},
	[11649] = {
		"Activity144",
		"Act144SelectOptionRequest",
		"Act144SelectOptionReply"
	},
	[-14555] = {
		"Activity144",
		"Act144NextDayRequest",
		"Act144NextDayReply"
	},
	[-27070] = {
		"Activity144",
		"Act144SettleEpisodeRequest",
		"Act144SettleEpisodeReply"
	},
	[-8467] = {
		"Activity144",
		"Act144SettlePush"
	},
	[4340] = {
		"Activity144",
		"Act144UpgradeEquipRequest",
		"Act144UpgradeEquipReply"
	},
	[-17502] = {
		"Activity144",
		"Act144EpisodePush"
	},
	[14545] = {
		"Activity144",
		"Act144ItemChangePush"
	},
	[15383] = {
		"Activity145",
		"Get145InfosRequest",
		"Get145InfosReply"
	},
	[-11349] = {
		"Activity145",
		"Act145RemoveTaskRequest",
		"Act145RemoveTaskReply"
	},
	[-2076] = {
		"Activity145",
		"Act145GameRequest",
		"Act145GameReply"
	},
	[-2750] = {
		"Activity145",
		"Act145GetRewardsRequest",
		"Act145GetRewardsReply"
	},
	[1642] = {
		"Activity145",
		"Act145ClearGameRecordRequest",
		"Act145ClearGameRecordReply"
	},
	[5462] = {
		"Activity145",
		"Act145InfoUpdatePush"
	},
	[-31048] = {
		"Activity146",
		"GetAct146InfosRequest",
		"GetAct146InfosReply"
	},
	[28598] = {
		"Activity146",
		"FinishAct146EpisodeRequest",
		"FinishAct146EpisodeReply"
	},
	[-26948] = {
		"Activity146",
		"Act146EpisodeBonusRequest",
		"Act146EpisodeBonusReply"
	},
	[-11943] = {
		"Activity147",
		"GetAct147InfosRequest",
		"GetAct147InfosReply"
	},
	[2682] = {
		"Activity147",
		"BuyAct147GoodsRequest",
		"BuyAct147GoodsReply"
	},
	[-2225] = {
		"Activity148",
		"Get148InfoRequest",
		"Get148InfoReply"
	},
	[17709] = {
		"Activity148",
		"Act148UpLevelRequest",
		"Act148UpLevelReply"
	},
	[-15520] = {
		"Activity148",
		"Act148DownLevelRequest",
		"Act148DownLevelReply"
	},
	[27891] = {
		"Activity148",
		"Act148ResetRequest",
		"Act148ResetReply"
	},
	[26545] = {
		"Activity149",
		"Get149InfoRequest",
		"Get149InfoReply"
	},
	[13168] = {
		"Activity149",
		"Act149GetScoreRewardsRequest",
		"Act149GetScoreRewardsReply"
	},
	[21493] = {
		"Activity149",
		"Act149GainDailyBonusRequest",
		"Act149GainDailyBonusReply"
	},
	[-24667] = {
		"Activity152",
		"Get152InfoRequest",
		"Get152InfoReply"
	},
	[-937] = {
		"Activity152",
		"Act152AcceptPresentRequest",
		"Act152AcceptPresentReply"
	},
	[17814] = {
		"Activity153",
		"Get153InfosRequest",
		"Get153InfosReply"
	},
	[15607] = {
		"Activity153",
		"Act153CountChangePush"
	},
	[-28617] = {
		"Activity154",
		"Get154InfosRequest",
		"Get154InfosReply"
	},
	[14316] = {
		"Activity154",
		"Answer154PuzzleRequest",
		"Answer154PuzzleReply"
	},
	[28604] = {
		"Activity157",
		"Get157InfoRequest",
		"Get157InfoReply"
	},
	[-15633] = {
		"Activity157",
		"Act157UnlockComponentRequest",
		"Act157UnlockComponentReply"
	},
	[4356] = {
		"Activity157",
		"Act157GainMilestoneRewardRequest",
		"Act157GainMilestoneRewardReply"
	},
	[-18361] = {
		"Activity157",
		"Act157AcceptProductionRequest",
		"Act157AcceptProductionReply"
	},
	[31445] = {
		"Activity157",
		"Act157CompoundRequest",
		"Act157CompoundReply"
	},
	[-3692] = {
		"Activity157",
		"ProductionInfoChangePush"
	},
	[-17733] = {
		"Activity158",
		"Get158InfosRequest",
		"Get158InfosReply"
	},
	[-28563] = {
		"Activity158",
		"Act158StartChallengeRequest",
		"Act158StartChallengeReply"
	},
	[26834] = {
		"Activity158",
		"Act158AbandonChallengeRequest",
		"Act158AbandonChallengeReply"
	},
	[5915] = {
		"Activity159",
		"Get159InfosRequest",
		"Get159InfosReply"
	},
	[6851] = {
		"Activity159",
		"Get159BonusRequest",
		"Get159BonusReply"
	},
	[2832] = {
		"Activity160",
		"Act160GetInfoRequest",
		"Act160GetInfoReply"
	},
	[-921] = {
		"Activity160",
		"Act160UpdatePush"
	},
	[-16953] = {
		"Activity160",
		"Act160FinishMissionRequest",
		"Act160FinishMissionReply"
	},
	[-2254] = {
		"Activity161",
		"Act161GetInfoRequest",
		"Act161GetInfoReply"
	},
	[-10638] = {
		"Activity161",
		"Act161RefreshElementsRequest",
		"Act161RefreshElementsReply"
	},
	[2458] = {
		"Activity161",
		"Act161GainMilestoneRewardRequest",
		"Act161GainMilestoneRewardReply"
	},
	[-22574] = {
		"Activity161",
		"Act161CdBeginPush"
	},
	[-7081] = {
		"Activity163",
		"Get163InfosRequest",
		"Get163InfosReply"
	},
	[18011] = {
		"Activity163",
		"Act163StartEvidenceRequest",
		"Act163StartEvidenceReply"
	},
	[1790] = {
		"Activity163",
		"Act163EvidenceOperationRequest",
		"Act163EvidenceOperationReply"
	},
	[-15754] = {
		"Activity163",
		"Act163InfoPush"
	},
	[-1041] = {
		"Activity163",
		"Act163ReadClueRequest",
		"Act163ReadClueReply"
	},
	[2168] = {
		"Activity164",
		"GetAct164InfoRequest",
		"GetAct164InfoReply"
	},
	[24739] = {
		"Activity164",
		"Act164StartEpisodeRequest",
		"Act164StartEpisodeReply"
	},
	[-7910] = {
		"Activity164",
		"Act164ReStartEpisodeRequest",
		"Act164ReStartEpisodeReply"
	},
	[15833] = {
		"Activity164",
		"Act164BeginRoundRequest",
		"Act164BeginRoundReply"
	},
	[-8184] = {
		"Activity164",
		"Act164StepPush"
	},
	[7542] = {
		"Activity164",
		"Act164RollbackRequest",
		"Act164RollbackReply"
	},
	[2340] = {
		"Activity164",
		"Act164AbortRequest",
		"Act164AbortReply"
	},
	[-22598] = {
		"Activity165",
		"Act165GetInfoRequest",
		"Act165GetInfoReply"
	},
	[14459] = {
		"Activity165",
		"Act165ModifyKeywordRequest",
		"Act165ModifyKeywordReply"
	},
	[25422] = {
		"Activity165",
		"Act165GenerateEndingRequest",
		"Act165GenerateEndingReply"
	},
	[-30189] = {
		"Activity165",
		"Act165RestartRequest",
		"Act165RestartReply"
	},
	[-14814] = {
		"Activity165",
		"Act165GainMilestoneRewardRequest",
		"Act165GainMilestoneRewardReply"
	},
	[-15302] = {
		"Activity166",
		"Get166InfosRequest",
		"Get166InfosReply"
	},
	[32361] = {
		"Activity166",
		"Act166EnterBaseRequest",
		"Act166EnterBaseReply"
	},
	[3153] = {
		"Activity166",
		"Act166AnalyInfoRequest",
		"Act166AnalyInfoReply"
	},
	[-4154] = {
		"Activity166",
		"Act166ReceiveInfoBonusRequest",
		"Act166ReceiveInfoBonusReply"
	},
	[-29728] = {
		"Activity166",
		"Act166ReceiveInformationBonusRequest",
		"Act166ReceiveInformationBonusReply"
	},
	[-30845] = {
		"Activity166",
		"Act166SetTalentSkillRequest",
		"Act166SetTalentSkillReply"
	},
	[10499] = {
		"Activity166",
		"StartAct166BattleRequest",
		"StartAct166BattleReply"
	},
	[-17983] = {
		"Activity166",
		"Act166BattleFinishPush"
	},
	[-2224] = {
		"Activity166",
		"Act166InfoPush"
	},
	[-17908] = {
		"Activity166",
		"Act166TalentPush"
	},
	[-26690] = {
		"Activity167",
		"GetAct167InfoRequest",
		"GetAct167InfoReply"
	},
	[-11063] = {
		"Activity167",
		"Act167StartEpisodeRequest",
		"Act167StartEpisodeReply"
	},
	[-2368] = {
		"Activity167",
		"Act167ReStartEpisodeRequest",
		"Act167ReStartEpisodeReply"
	},
	[28799] = {
		"Activity167",
		"Act167BeginRoundRequest",
		"Act167BeginRoundReply"
	},
	[12590] = {
		"Activity167",
		"Act167StepPush"
	},
	[28316] = {
		"Activity167",
		"Act167RollbackRequest",
		"Act167RollbackReply"
	},
	[31754] = {
		"Activity167",
		"Act167AbortRequest",
		"Act167AbortReply"
	},
	[22908] = {
		"Activity168",
		"Get168InfosRequest",
		"Get168InfosReply"
	},
	[-28779] = {
		"Activity168",
		"Act168StoryRequest",
		"Act168StoryReply"
	},
	[-22021] = {
		"Activity168",
		"Act168EnterEpisodeRequest",
		"Act168EnterEpisodeReply"
	},
	[-23618] = {
		"Activity168",
		"StartAct168BattleRequest",
		"StartAct168BattleReply"
	},
	[-31739] = {
		"Activity168",
		"Act168BattleFinishPush"
	},
	[-25115] = {
		"Activity168",
		"Act168GameMoveRequest",
		"Act168GameMoveReply"
	},
	[-22186] = {
		"Activity168",
		"Act168GameSelectOptionRequest",
		"Act168GameSelectOptionReply"
	},
	[-14381] = {
		"Activity168",
		"Act168GameComposeItemRequest",
		"Act168GameComposeItemReply"
	},
	[-8385] = {
		"Activity168",
		"Act168GameSettleRequest",
		"Act168GameSettleReply"
	},
	[-31791] = {
		"Activity168",
		"Act168EpisodePush"
	},
	[-24909] = {
		"Activity168",
		"Act168GameSettlePush"
	},
	[27543] = {
		"Activity168",
		"Act168GameItemChangePush"
	},
	[23882] = {
		"Activity169",
		"Get169InfoRequest",
		"Get169InfoReply"
	},
	[23477] = {
		"Activity169",
		"Act169SummonRequest",
		"Act169SummonReply"
	},
	[-12678] = {
		"Activity170",
		"Get170InfoRequest",
		"Get170InfoReply"
	},
	[-10011] = {
		"Activity170",
		"Act170SummonRequest",
		"Act170SummonReply"
	},
	[-13259] = {
		"Activity170",
		"Act170SaveRequest",
		"Act170SaveReply"
	},
	[-24346] = {
		"Activity170",
		"Act170SelectRequest",
		"Act170SelectReply"
	},
	[24028] = {
		"Activity171",
		"Get171InfoRequest",
		"Get171InfoReply"
	},
	[-12042] = {
		"Activity172",
		"GetAct172InfoRequest",
		"GetAct172InfoReply"
	},
	[29852] = {
		"Activity172",
		"Act172UseItemTaskIdsUpdatePush"
	},
	[12410] = {
		"Activity174",
		"GetAct174InfoRequest",
		"GetAct174InfoReply"
	},
	[28062] = {
		"Activity174",
		"Start174GameRequest",
		"Start174GameReply"
	},
	[-19768] = {
		"Activity174",
		"Fresh174ShopRequest",
		"Fresh174ShopReply"
	},
	[9911] = {
		"Activity174",
		"BuyIn174ShopRequest",
		"BuyIn174ShopReply"
	},
	[28763] = {
		"Activity174",
		"ChangeAct174TeamRequest",
		"ChangeAct174TeamReply"
	},
	[-4857] = {
		"Activity174",
		"SwitchAct174TeamRequest",
		"SwitchAct174TeamReply"
	},
	[13863] = {
		"Activity174",
		"SelectAct174ForceBagRequest",
		"SelectAct174ForceBagReply"
	},
	[-11557] = {
		"Activity174",
		"StartAct174FightMatchRequest",
		"StartAct174FightMatchReply"
	},
	[-3546] = {
		"Activity174",
		"BetHpBeforeAct174FightRequest",
		"BetHpBeforeAct174FightReply"
	},
	[5452] = {
		"Activity174",
		"EnterEndLessAct174FightRequest",
		"EnterEndLessAct174FightReply"
	},
	[-15713] = {
		"Activity174",
		"EndAct174GameRequest",
		"EndAct174GameReply"
	},
	[-23570] = {
		"Activity174",
		"StartAct174FightRequest",
		"StartAct174FightReply"
	},
	[7549] = {
		"Activity174",
		"EnterNextAct174FightRequest",
		"EnterNextAct174FightReply"
	},
	[30516] = {
		"Activity174",
		"ChangeSeasonEndAct174Request",
		"ChangeSeasonEndAct174Reply"
	},
	[2747] = {
		"Activity174",
		"ViewFightAct174Request",
		"ViewFightAct174Reply"
	},
	[11396] = {
		"Activity174",
		"TempAct174Request",
		"TempAct174Reply"
	},
	[13867] = {
		"Activity174",
		"Act174GameInfoUpdatePush"
	},
	[-21661] = {
		"Activity174",
		"Act174TriggerEffectPush"
	},
	[24040] = {
		"Activity174",
		"Act174FightRoundInfo"
	},
	[-4207] = {
		"Activity178",
		"GetAct178InfoRequest",
		"GetAct178InfoReply"
	},
	[-23603] = {
		"Activity178",
		"Act178StartEpisodeRequest",
		"Act178StartEpisodeReply"
	},
	[-4938] = {
		"Activity178",
		"Act178EndEpisodeRequest",
		"Act178EndEpisodeReply"
	},
	[1205] = {
		"Activity178",
		"Act178EndRoundRequest",
		"Act178EndRoundReply"
	},
	[-13420] = {
		"Activity178",
		"Act178RestRequest",
		"Act178RestReply"
	},
	[15513] = {
		"Activity178",
		"Act178ResetRequest",
		"Act178ResetReply"
	},
	[-19286] = {
		"Activity178",
		"Act178UnlockTalentRequest",
		"Act178UnlockTalentReply"
	},
	[20710] = {
		"Activity178",
		"Act178BuildRequest",
		"Act178BuildReply"
	},
	[-17381] = {
		"Activity178",
		"Act178GetRewardRequest",
		"Act178GetRewardReply"
	},
	[656] = {
		"Activity178",
		"Act178InteractRequest",
		"Act178InteractReply"
	},
	[-15705] = {
		"Activity178",
		"Act178CurrencyChangePush"
	},
	[-28834] = {
		"Activity178",
		"Act178GuideAddGrainRequest",
		"Act178GuideAddGrainReply"
	},
	[17118] = {
		"Activity179",
		"Get179InfosRequest",
		"Get179InfosReply"
	},
	[20711] = {
		"Activity179",
		"Set179ScoreRequest",
		"Set179ScoreReply"
	},
	[16886] = {
		"Activity180",
		"Get180InfosRequest",
		"Get180InfosReply"
	},
	[6703] = {
		"Activity180",
		"Act180EnterEpisodeRequest",
		"Act180EnterEpisodeReply"
	},
	[-28087] = {
		"Activity180",
		"Act180StoryRequest",
		"Act180StoryReply"
	},
	[-29661] = {
		"Activity180",
		"Act180GameFinishRequest",
		"Act180GameFinishReply"
	},
	[-2735] = {
		"Activity180",
		"Act180SaveGameRequest",
		"Act180SaveGameReply"
	},
	[-29435] = {
		"Activity180",
		"Act180EpisodePush"
	},
	[-29545] = {
		"Activity181",
		"Get181InfosRequest",
		"Get181InfosReply"
	},
	[-28609] = {
		"Activity181",
		"Get181BonusRequest",
		"Get181BonusReply"
	},
	[18242] = {
		"Activity181",
		"Get181SpBonusRequest",
		"Get181SpBonusReply"
	},
	[-1800] = {
		"Activity182",
		"GetAct182InfoRequest",
		"GetAct182InfoReply"
	},
	[-5479] = {
		"Activity182",
		"GetAct182RandomMasterRequest",
		"GetAct182RandomMasterReply"
	},
	[-5049] = {
		"Activity182",
		"Act182RefreshMasterRequest",
		"Act182RefreshMasterReply"
	},
	[19288] = {
		"Activity182",
		"Act182InfoPush"
	},
	[8829] = {
		"Activity182",
		"Act182GetRankRewardRequest",
		"Act182GetRankRewardReply"
	},
	[7730] = {
		"Activity182",
		"Act182RefreshBossRequest",
		"Act182RefreshBossReply"
	},
	[5446] = {
		"Activity182",
		"Act182ChooseCardpackRequest",
		"Act182ChooseCardpackReply"
	},
	[-6229] = {
		"Activity182",
		"Act182SaveSnapshotRequest",
		"Act182SaveSnapshotReply"
	},
	[10800] = {
		"Activity182",
		"Act182GetHasSnapshotFriendRequest",
		"Act182GetHasSnapshotFriendReply"
	},
	[-31641] = {
		"Activity182",
		"Act182GetFriendSnapshotsRequest",
		"Act182GetFriendSnapshotsReply"
	},
	[15304] = {
		"Activity182",
		"Act182GetFriendFightRecordsRequest",
		"Act182GetFriendFightRecordsReply"
	},
	[32155] = {
		"Activity182",
		"Act182GetFriendFightMessageRequest",
		"Act182GetFriendFightMessageReply"
	},
	[-29530] = {
		"Activity183",
		"Act183GetInfoRequest",
		"Act183GetInfoReply"
	},
	[-22390] = {
		"Activity183",
		"Act183ResetGroupRequest",
		"Act183ResetGroupReply"
	},
	[-31354] = {
		"Activity183",
		"Act183ResetEpisodeRequest",
		"Act183ResetEpisodeReply"
	},
	[25151] = {
		"Activity183",
		"Act183ChooseRepressRequest",
		"Act183ChooseRepressReply"
	},
	[18745] = {
		"Activity183",
		"Act183GetRecordRequest",
		"Act183GetRecordReply"
	},
	[32533] = {
		"Activity183",
		"Act183ReplaceResultRequest",
		"Act183ReplaceResultReply"
	},
	[6016] = {
		"Activity183",
		"Act183BadgeNumUpdatePush"
	},
	[28311] = {
		"Activity183",
		"Act183BattleFinishPush"
	},
	[22652] = {
		"Activity184",
		"GetAct184InfoRequest",
		"GetAct184InfoReply"
	},
	[29050] = {
		"Activity184",
		"Act184FinishEpisodeRequest",
		"Act184FinishEpisodeReply"
	},
	[11405] = {
		"Activity184",
		"Act184EpisodePush"
	},
	[-30658] = {
		"Activity185",
		"GetAct185InfoRequest",
		"GetAct185InfoReply"
	},
	[28444] = {
		"Activity185",
		"Act185FinishEpisodeRequest",
		"Act185FinishEpisodeReply"
	},
	[21615] = {
		"Activity185",
		"Act185EpisodePush"
	},
	[-18432] = {
		"Activity186",
		"GetAct186InfoRequest",
		"GetAct186InfoReply"
	},
	[24488] = {
		"Activity186",
		"FinishAct186TaskRequest",
		"FinishAct186TaskReply"
	},
	[-16127] = {
		"Activity186",
		"FinishAllAct186TaskRequest",
		"FinishAllAct186TaskReply"
	},
	[7369] = {
		"Activity186",
		"GetAct186MilestoneRewardRequest",
		"GetAct186MilestoneRewardReply"
	},
	[-21421] = {
		"Activity186",
		"GetAct186DailyCollectionRequest",
		"GetAct186DailyCollectionReply"
	},
	[22683] = {
		"Activity186",
		"Act186TaskPush"
	},
	[5773] = {
		"Activity186",
		"Act186LikePush"
	},
	[-19790] = {
		"Activity186",
		"FinishAct186ATypeGameRequest",
		"FinishAct186ATypeGameReply"
	},
	[19272] = {
		"Activity186",
		"Act186BTypeGamePlayRequest",
		"Act186BTypeGamePlayReply"
	},
	[9139] = {
		"Activity186",
		"FinishAct186BTypeGameRequest",
		"FinishAct186BTypeGameReply"
	},
	[9280] = {
		"Activity186",
		"GetAct186OnceBonusRequest",
		"GetAct186OnceBonusReply"
	},
	[13770] = {
		"Activity187",
		"Get187InfoRequest",
		"Get187InfoReply"
	},
	[18257] = {
		"Activity187",
		"Act187FinishGameRequest",
		"Act187FinishGameReply"
	},
	[16875] = {
		"Activity187",
		"Act187AcceptRewardRequest",
		"Act187AcceptRewardReply"
	},
	[6020] = {
		"Activity188",
		"GetAct188InfoRequest",
		"GetAct188InfoReply"
	},
	[-23233] = {
		"Activity188",
		"Act188EnterEpisodeRequest",
		"Act188EnterEpisodeReply"
	},
	[28505] = {
		"Activity188",
		"Act188StoryRequest",
		"Act188StoryReply"
	},
	[-13291] = {
		"Activity188",
		"Act188EpisodePush"
	},
	[-30066] = {
		"Activity188",
		"Act188ReverseCardRequest",
		"Act188ReverseCardReply"
	},
	[-7800] = {
		"Activity188",
		"Act188StepPush"
	},
	[18246] = {
		"Activity189",
		"GetAct189InfoRequest",
		"GetAct189InfoReply"
	},
	[12102] = {
		"Activity189",
		"GetAct189OnceBonusRequest",
		"GetAct189OnceBonusReply"
	},
	[-16010] = {
		"Activity190",
		"GetAct190InfoRequest",
		"GetAct190InfoReply"
	},
	[11476] = {
		"Activity190",
		"Act190FinishEpisodeRequest",
		"Act190FinishEpisodeReply"
	},
	[-19422] = {
		"Activity190",
		"Act190ChooseEpisodeBranchRequest",
		"Act190ChooseEpisodeBranchReply"
	},
	[-20185] = {
		"Activity190",
		"Act190EpisodePush"
	},
	[-3784] = {
		"Activity191",
		"GetAct191InfoRequest",
		"GetAct191InfoReply"
	},
	[-30084] = {
		"Activity191",
		"Start191GameRequest",
		"Start191GameReply"
	},
	[5592] = {
		"Activity191",
		"Select191InitBuildRequest",
		"Select191InitBuildReply"
	},
	[-7238] = {
		"Activity191",
		"Select191NodeRequest",
		"Select191NodeReply"
	},
	[-12378] = {
		"Activity191",
		"Fresh191ShopRequest",
		"Fresh191ShopReply"
	},
	[17301] = {
		"Activity191",
		"BuyIn191ShopRequest",
		"BuyIn191ShopReply"
	},
	[23419] = {
		"Activity191",
		"Leave191ShopRequest",
		"Leave191ShopReply"
	},
	[-14426] = {
		"Activity191",
		"Select191EnhanceRequest",
		"Select191EnhanceReply"
	},
	[4862] = {
		"Activity191",
		"Fresh191EnhanceRequest",
		"Fresh191EnhanceReply"
	},
	[-2310] = {
		"Activity191",
		"Gain191RewardEventRequest",
		"Gain191RewardEventReply"
	},
	[1209] = {
		"Activity191",
		"ChangeAct191TeamRequest",
		"ChangeAct191TeamReply"
	},
	[-31907] = {
		"Activity191",
		"EndAct191GameRequest",
		"EndAct191GameReply"
	},
	[32370] = {
		"Activity191",
		"Select191ReplaceEventRequest",
		"Select191ReplaceEventReply"
	},
	[16745] = {
		"Activity191",
		"End191ReplaceEventRequest",
		"End191ReplaceEventReply"
	},
	[4048] = {
		"Activity191",
		"Select191UpgradeEventRequest",
		"Select191UpgradeEventReply"
	},
	[-11548] = {
		"Activity191",
		"Select191UseHeroFacetsIdRequest",
		"Select191UseHeroFacetsIdReply"
	},
	[26889] = {
		"Activity191",
		"Act191GameInfoUpdatePush"
	},
	[-1407] = {
		"Activity191",
		"Act191TriggerEffectPush"
	},
	[8442] = {
		"Activity192",
		"GetAct192InfoRequest",
		"GetAct192InfoReply"
	},
	[10264] = {
		"Activity192",
		"Act192FinishEpisodeRequest",
		"Act192FinishEpisodeReply"
	},
	[4710] = {
		"Activity192",
		"Act192ChooseEpisodeBranchRequest",
		"Act192ChooseEpisodeBranchReply"
	},
	[235] = {
		"Activity192",
		"Act192EpisodePush"
	},
	[-23311] = {
		"Activity194",
		"Act194GetInfosRequest",
		"Act194GetInfosReply"
	},
	[23897] = {
		"Activity194",
		"Act194EnterEpisodeRequest",
		"Act194EnterEpisodeReply"
	},
	[14653] = {
		"Activity194",
		"Act194FinishStoryEpisodeRequest",
		"Act194FinishStoryEpisodeReply"
	},
	[18791] = {
		"Activity194",
		"Act194GetEpisodeInfoRequest",
		"Act194GetEpisodeInfoReply"
	},
	[28706] = {
		"Activity194",
		"Act194SendTeamExploreRequest",
		"Act194SendTeamExploreReply"
	},
	[16878] = {
		"Activity194",
		"Act194UseItemRequest",
		"Act194UseItemReply"
	},
	[31417] = {
		"Activity194",
		"Act194NextRoundRequest",
		"Act194NextRoundReply"
	},
	[-29821] = {
		"Activity194",
		"Act194WithdrawTeamRequest",
		"Act194WithdrawTeamReply"
	},
	[-11106] = {
		"Activity194",
		"Act194ResetEpisodeRequest",
		"Act194ResetEpisodeReply"
	},
	[-3534] = {
		"Activity194",
		"Act194SkipEpisodeRequest",
		"Act194SkipEpisodeReply"
	},
	[-25247] = {
		"Activity194",
		"Act194EpisodeRecordsPush"
	},
	[-1701] = {
		"Activity194",
		"Act194EpisodeInfoPush"
	},
	[-31055] = {
		"Activity194",
		"Act194NewEventInfosPush"
	},
	[8304] = {
		"Activity194",
		"Act194EpisodeFinishPush"
	},
	[8714] = {
		"Activity196",
		"Get196InfoRequest",
		"Get196InfoReply"
	},
	[-30315] = {
		"Activity196",
		"Act196GainRequest",
		"Act196GainReply"
	},
	[-20116] = {
		"Activity197",
		"Get197InfoRequest",
		"Get197InfoReply"
	},
	[-11674] = {
		"Activity197",
		"Act197RummageRequest",
		"Act197RummageReply"
	},
	[12439] = {
		"Activity197",
		"Act197ExploreRequest",
		"Act197ExploreReply"
	},
	[15033] = {
		"Activity198",
		"Act198CanGetPush"
	},
	[-22439] = {
		"Activity198",
		"Act198GainRequest",
		"Act198GainReply"
	},
	[14267] = {
		"Activity199",
		"Act199GainRequest",
		"Act199GainReply"
	},
	[-12240] = {
		"Activity199",
		"Get199InfoRequest",
		"Get199InfoReply"
	},
	[-5040] = {
		"Activity201",
		"Get201InfoRequest",
		"Get201InfoReply"
	},
	[4332] = {
		"Activity203",
		"GetAct203InfoRequest",
		"GetAct203InfoReply"
	},
	[30829] = {
		"Activity203",
		"Act203SaveEpisodeProgressRequest",
		"Act203SaveEpisodeProgressReply"
	},
	[-11542] = {
		"Activity203",
		"Act203FinishEpisodeRequest",
		"Act203FinishEpisodeReply"
	},
	[4792] = {
		"Activity203",
		"Act203ChooseEpisodeBranchRequest",
		"Act203ChooseEpisodeBranchReply"
	},
	[-29699] = {
		"Activity203",
		"Act203EpisodePush"
	},
	[16558] = {
		"Activity204",
		"GetAct204InfoRequest",
		"GetAct204InfoReply"
	},
	[-18186] = {
		"Activity204",
		"FinishAct204TaskRequest",
		"FinishAct204TaskReply"
	},
	[7351] = {
		"Activity204",
		"GetAct204MilestoneRewardRequest",
		"GetAct204MilestoneRewardReply"
	},
	[-21439] = {
		"Activity204",
		"GetAct204DailyCollectionRequest",
		"GetAct204DailyCollectionReply"
	},
	[2793] = {
		"Activity204",
		"Act204TaskPush"
	},
	[18862] = {
		"Activity204",
		"GetAct204OnceBonusRequest",
		"GetAct204OnceBonusReply"
	},
	[-32240] = {
		"Activity205",
		"Act205GetInfoRequest",
		"Act205GetInfoReply"
	},
	[23306] = {
		"Activity205",
		"Act205GetGameInfoRequest",
		"Act205GetGameInfoReply"
	},
	[-29217] = {
		"Activity205",
		"Act205FinishGameRequest",
		"Act205FinishGameReply"
	},
	[-25724] = {
		"Activity205",
		"Act205InfoPush"
	},
	[28210] = {
		"Activity206",
		"Act206GetInfoRequest",
		"Act206GetInfoReply"
	},
	[27112] = {
		"Activity206",
		"Act206ChooseDirectionRequest",
		"Act206ChooseDirectionReply"
	},
	[14477] = {
		"Activity206",
		"Act206GetBonusRequest",
		"Act206GetBonusReply"
	},
	[-346] = {
		"Activity206",
		"Act206InfoPush"
	},
	[-74] = {
		"Activity208",
		"GetAct208InfoRequest",
		"GetAct208InfoReply"
	},
	[-25484] = {
		"Activity208",
		"Act208ReceiveBonusRequest",
		"Act208ReceiveBonusReply"
	},
	[12152] = {
		"Activity209",
		"GetAct209InfoRequest",
		"GetAct209InfoReply"
	},
	[10252] = {
		"Activity209",
		"Act209InfoPush"
	},
	[-22104] = {
		"Activity210",
		"GetAct210InfoRequest",
		"GetAct210InfoReply"
	},
	[-407] = {
		"Activity210",
		"Act210SaveEpisodeProgressRequest",
		"Act210SaveEpisodeProgressReply"
	},
	[-29722] = {
		"Activity210",
		"Act210FinishEpisodeRequest",
		"Act210FinishEpisodeReply"
	},
	[-26444] = {
		"Activity210",
		"Act210ChooseEpisodeBranchRequest",
		"Act210ChooseEpisodeBranchReply"
	},
	[14457] = {
		"Activity210",
		"Act210EpisodePush"
	},
	[-9878] = {
		"Activity211",
		"GetAct211InfoRequest",
		"GetAct211InfoReply"
	},
	[11659] = {
		"Activity211",
		"Act211SaveEpisodeProgressRequest",
		"Act211SaveEpisodeProgressReply"
	},
	[-30328] = {
		"Activity211",
		"Act211FinishEpisodeRequest",
		"Act211FinishEpisodeReply"
	},
	[-14378] = {
		"Activity211",
		"Act211ChooseEpisodeBranchRequest",
		"Act211ChooseEpisodeBranchReply"
	},
	[24667] = {
		"Activity211",
		"Act211EpisodePush"
	},
	[2348] = {
		"Activity212",
		"GetAct212InfoRequest",
		"GetAct212InfoReply"
	},
	[-20022] = {
		"Activity212",
		"Act212ReceiveBonusRequest",
		"Act212ReceiveBonusReply"
	},
	[28059] = {
		"Activity212",
		"Act212BonusPush"
	},
	[-26510] = {
		"Activity215",
		"GetAct215InfoRequest",
		"GetAct215InfoReply"
	},
	[-13943] = {
		"Activity215",
		"SubmitAct215ItemRequest",
		"SubmitAct215ItemReply"
	},
	[2749] = {
		"Activity215",
		"GetAct215MilestoneBonusRequest",
		"GetAct215MilestoneBonusReply"
	},
	[25318] = {
		"Activity215",
		"Act215InfoPush"
	},
	[19667] = {
		"Activity215",
		"RefreshAct215LastViewItemRequest",
		"RefreshAct215LastViewItemReply"
	},
	[-14284] = {
		"Activity216",
		"GetAct216InfoRequest",
		"GetAct216InfoReply"
	},
	[-26212] = {
		"Activity216",
		"FinishAct216TaskRequest",
		"FinishAct216TaskReply"
	},
	[-14840] = {
		"Activity216",
		"Act216InfoPush"
	},
	[-26481] = {
		"Activity216",
		"Act216TaskPush"
	},
	[29940] = {
		"Activity216",
		"GetAct216OnceBonusRequest",
		"GetAct216OnceBonusReply"
	},
	[27639] = {
		"Activity217",
		"Get217InfosRequest",
		"Get217InfosReply"
	},
	[10905] = {
		"Activity217",
		"Act217CountChangePush"
	},
	[21408] = {
		"Activity218",
		"Get218InfoRequest",
		"Get218InfoReply"
	},
	[-4697] = {
		"Activity218",
		"Act218FinishGameRequest",
		"Act218FinishGameReply"
	},
	[-10815] = {
		"Activity218",
		"Act218AcceptRewardRequest",
		"Act218AcceptRewardReply"
	},
	[-11862] = {
		"Activity220",
		"GetAct220InfoRequest",
		"GetAct220InfoReply"
	},
	[4555] = {
		"Activity220",
		"Act220SaveEpisodeProgressRequest",
		"Act220SaveEpisodeProgressReply"
	},
	[15816] = {
		"Activity220",
		"Act220FinishEpisodeRequest",
		"Act220FinishEpisodeReply"
	},
	[-21482] = {
		"Activity220",
		"Act220ChooseEpisodeBranchRequest",
		"Act220ChooseEpisodeBranchReply"
	},
	[23707] = {
		"Activity220",
		"Act220EpisodePush"
	},
	[-7276] = {
		"Activity221",
		"Get221InfoRequest",
		"Get221InfoReply"
	},
	[-25473] = {
		"Activity221",
		"Act221SummonRequest",
		"Act221SummonReply"
	},
	[25728] = {
		"Activity221",
		"Act221SelectRequest",
		"Act221SelectReply"
	},
	[24816] = {
		"Activity223",
		"GetAct223InfoRequest",
		"GetAct223InfoReply"
	},
	[6515] = {
		"Activity223",
		"Act223InviteRequest",
		"Act223InviteReply"
	},
	[-13057] = {
		"Activity223",
		"Act223HandleInviteRequest",
		"Act223HandleInviteReply"
	},
	[-28494] = {
		"Activity224",
		"GetAct224InfoRequest",
		"GetAct224InfoReply"
	},
	[-3472] = {
		"Activity224",
		"ReceiveAct224BonusRequest",
		"ReceiveAct224BonusReply"
	},
	[-16268] = {
		"Activity225",
		"GetAct225InfoRequest",
		"GetAct225InfoReply"
	},
	[-23485] = {
		"Activity225",
		"Act225EnterChatRoomRequest",
		"Act225EnterChatRoomReply"
	},
	[4274] = {
		"Activity225",
		"Act225LeaveChatRoomRequest",
		"Act225LeaveChatRoomReply"
	},
	[29672] = {
		"Activity225",
		"Act225ChatRequest",
		"Act225ChatReply"
	},
	[-14884] = {
		"Activity225",
		"Act225ChatPush"
	},
	[4127] = {
		"Activity225",
		"Act225MoveRequest",
		"Act225MoveReply"
	},
	[12761] = {
		"Activity225",
		"Act225ChatRoomPush"
	},
	[8742] = {
		"Activity225",
		"Act225ApplyFriendRequest",
		"Act225ApplyFriendReply"
	},
	[-12647] = {
		"Activity225",
		"Act225RedEnvelopeRainStartRequest",
		"Act225RedEnvelopeRainStartReply"
	},
	[-23236] = {
		"Activity225",
		"Act225RedEnvelopeRainSettleRequest",
		"Act225RedEnvelopeRainSettleReply"
	},
	[6829] = {
		"Activity225",
		"Act225QAndARequest",
		"Act225QAndAReply"
	},
	[2664] = {
		"Activity225",
		"Act225RockPaperScissorsRequest",
		"Act225RockPaperScissorsReply"
	},
	[-29731] = {
		"Activity225",
		"Act225BonusSceneRequest",
		"Act225BonusSceneReply"
	},
	[-4042] = {
		"Activity226",
		"GetAct226InfoRequest",
		"GetAct226InfoReply"
	},
	[-11404] = {
		"Activity226",
		"ReceiveAct226BonusRequest",
		"ReceiveAct226BonusReply"
	},
	[20410] = {
		"Activity228",
		"GetAct228InfoRequest",
		"GetAct228InfoReply"
	},
	[-20609] = {
		"Activity228",
		"Act228FlipGridRequest",
		"Act228FlipGridGridReply"
	},
	[-12929] = {
		"Activity228",
		"Act228GetFinalBonusRequest",
		"Act228GetFinalBonusReply"
	},
	[32636] = {
		"Activity229",
		"GetAct229InfoRequest",
		"GetAct229InfoReply"
	},
	[15591] = {
		"Activity229",
		"Act229ResetStageRequest",
		"Act229ResetStageReply"
	},
	[29242] = {
		"Activity229",
		"StartAct229BattleRequest",
		"StartAct229BattleReply"
	},
	[-1727] = {
		"Activity229",
		"Act229BattleFinishPush"
	},
	[8867] = {
		"Activity229",
		"Act229ModifyStageSubIdRequest",
		"Act229ModifyStageSubIdReply"
	},
	[-15977] = {
		"Activity229",
		"Act229ModifySkillRequest",
		"Act229ModifySkillReply"
	},
	[-7978] = {
		"Activity229",
		"Act229StageTeamSubIdPush"
	},
	[10606] = {
		"Activity231",
		"GetAct231InfoRequest",
		"GetAct231InfoReply"
	},
	[3798] = {
		"Activity231",
		"Act231BuyResearcherRequest",
		"Act231BuyResearcherReply"
	},
	[-20997] = {
		"Activity231",
		"Act231UnlockSeatRequest",
		"Act231UnlockSeatReply"
	},
	[21853] = {
		"Activity231",
		"Act231StartResearchRequest",
		"Act231StartResearchReply"
	},
	[-26736] = {
		"Activity231",
		"Act231FinishResearchRequest",
		"Act231FinishResearchReply"
	},
	[26061] = {
		"Activity231",
		"Act231PauseResearchRequest",
		"Act231PauseResearchReply"
	},
	[244] = {
		"Activity231",
		"Act231ContinueResearchRequest",
		"Act231ContinueResearchReply"
	},
	[-14125] = {
		"Activity231",
		"Act231RecordPlaySecondRequest",
		"Act231RecordPlaySecondReply"
	},
	[20280] = {
		"Activity231",
		"Act231MissionPush"
	},
	[-15260] = {
		"Activity233",
		"GetAct233BpInfoRequest",
		"GetAct233BpInfoReply"
	},
	[21759] = {
		"Activity233",
		"GetAct233BpBonusRequest",
		"GetAct233BpBonusReply"
	},
	[-11625] = {
		"Activity233",
		"Act233BpScoreUpdatePush"
	},
	[-5694] = {
		"Activity233",
		"Act233BpPayRequest",
		"Act233BpPayReply"
	},
	[3420] = {
		"Activity234",
		"Get234InfoRequest",
		"Get234InfoReply"
	},
	[1123] = {
		"Activity234",
		"Act234FinishGameRequest",
		"Act234FinishGameReply"
	},
	[18055] = {
		"Activity234",
		"Act234ExploreRequest",
		"Act234ExploreReply"
	},
	[-29827] = {
		"Activity234",
		"Act234AcceptRewardRequest",
		"Act234AcceptRewardReply"
	},
	[-6026] = {
		"Activity235",
		"GetAct235InfoRequest",
		"GetAct235InfoReply"
	},
	[20473] = {
		"Activity235",
		"ActivePreparationRequest",
		"ActivePreparationReply"
	},
	[-19456] = {
		"Activity235",
		"FinishMiniGameRequest",
		"FinishMiniGameReply"
	},
	[6200] = {
		"Activity236",
		"GetAct236InfoRequest",
		"GetAct236InfoReply"
	},
	[30249] = {
		"Activity236",
		"Act236GetAutoGainRewardRequest",
		"Act236GetAutoGainRewardReply"
	},
	[-5541] = {
		"Activity236",
		"Act236UpdateInfoPush"
	},
	[30652] = {
		"Activity238",
		"GetAct238InfoRequest",
		"GetAct238InfoReply"
	},
	[1152] = {
		"Activity238",
		"Act238AnswerRequest",
		"Act238AnswerReply"
	},
	[18871] = {
		"Activity238",
		"Act238BonusRequest",
		"Act238BonusReply"
	},
	[-22658] = {
		"Activity239",
		"GetAct239InfoRequest",
		"GetAct239InfoReply"
	},
	[-15000] = {
		"Activity239",
		"Act239BonusRequest",
		"Act239BonusReply"
	},
	[-22802] = {
		"Activity240",
		"Act240GetInfoRequest",
		"Act240GetInfoReply"
	},
	[5098] = {
		"Activity240",
		"Act240SignInRequest",
		"Act240SignInReply"
	},
	[26560] = {
		"Activity240",
		"Act240BackdateRequest",
		"Act240BackdateReply"
	},
	[-27888] = {
		"Activity241",
		"Act241GetInfoRequest",
		"Act241GetInfoReply"
	},
	[-18174] = {
		"Activity241",
		"Act241VoteRequest",
		"Act241VoteReply"
	},
	[-1749] = {
		"Activity241",
		"Act241GetBonusRequest",
		"Act241GetBonusReply"
	},
	[-20236] = {
		"Activity243",
		"GetAct243InfoRequest",
		"GetAct243InfoReply"
	},
	[-3635] = {
		"Activity243",
		"Act243ReportEpisodeRequest",
		"Act243ReportEpisodeReply"
	},
	[-10918] = {
		"Activity243",
		"Act243UpgradeGiftRequest",
		"Act243UpgradeGiftReply"
	},
	[22017] = {
		"Activity243",
		"Act243UnlockRacerRequest",
		"Act243UnlockRacerReply"
	},
	[-3384] = {
		"Activity243",
		"Act243InfoPush"
	},
	[-14582] = {
		"Activity",
		"GetActivityInfosRequest",
		"GetActivityInfosReply"
	},
	[-8777] = {
		"Activity",
		"GetActivityInfosWithParamRequest",
		"GetActivityInfosWithParamReply"
	},
	[-12293] = {
		"Activity",
		"UpdateActivityPush"
	},
	[7215] = {
		"Activity",
		"EndActivityPush"
	},
	[2821] = {
		"Activity",
		"ActivityNewStageReadRequest",
		"ActivityNewStageReadReply"
	},
	[-5324] = {
		"Activity",
		"UnlockPermanentRequest",
		"UnlockPermanentReply"
	},
	[-25429] = {
		"Antique",
		"GetAntiqueInfoRequest",
		"GetAntiqueInfoReply"
	},
	[13506] = {
		"Antique",
		"AntiqueUpdatePush"
	},
	[30677] = {
		"ArcadeInSide",
		"ArcadeGetInSideInfoRequest",
		"ArcadeGetInSideInfoReply"
	},
	[-7818] = {
		"ArcadeInSide",
		"ArcadeSaveGameRequest",
		"ArcadeSaveGameReply"
	},
	[10456] = {
		"ArcadeInSide",
		"ArcadeSettleGameRequest",
		"ArcadeSettleGameReply"
	},
	[29943] = {
		"ArcadeOutSide",
		"ArcadeGetOutSideInfoRequest",
		"ArcadeGetOutSideInfoReply"
	},
	[-12046] = {
		"ArcadeOutSide",
		"ArcadePlayerMoveRequest",
		"ArcadePlayerMoveReply"
	},
	[-15315] = {
		"ArcadeOutSide",
		"ArcadeSwitchCharacterRequest",
		"ArcadeSwitchCharacterReply"
	},
	[9854] = {
		"ArcadeOutSide",
		"ArcadeTalentUpgradeRequest",
		"ArcadeTalentUpgradeReply"
	},
	[28626] = {
		"ArcadeOutSide",
		"ArcadeGainRewardRequest",
		"ArcadeGainRewardReply"
	},
	[-6994] = {
		"ArcadeOutSide",
		"ArcadeInteractionRequest",
		"ArcadeInteractionReply"
	},
	[20714] = {
		"ArcadeOutSide",
		"ArcadeClearNewBookRequest",
		"ArcadeClearNewBookReply"
	},
	[4399] = {
		"ArcadeOutSide",
		"ArcadeAttrChangePush"
	},
	[-3207] = {
		"ArcadeOutSide",
		"ArcadeCloseRewardPanelRequest",
		"ArcadeCloseRewardPanelReply"
	},
	[-415] = {
		"AssassinOutSide",
		"GetAssassinOutSideInfoRequest",
		"GetAssassinOutSideInfoReply"
	},
	[-20386] = {
		"AssassinOutSide",
		"BuildingLevelUpRequest",
		"BuildingLevelUpReply"
	},
	[-18575] = {
		"AssassinOutSide",
		"InteractiveRequest",
		"InteractiveReply"
	},
	[28888] = {
		"AssassinOutSide",
		"HeroTransferCareerRequest",
		"HeroTransferCareerReply"
	},
	[-3308] = {
		"AssassinOutSide",
		"EquipHeroItemRequest",
		"EquipHeroItemReply"
	},
	[16004] = {
		"AssassinOutSide",
		"AssassinOutSideUnlockPush"
	},
	[268] = {
		"AssassinOutSide",
		"AssassinUnlockLibraryPush"
	},
	[8985] = {
		"AssassinOutSide",
		"GetAssassinLibraryInfoRequest",
		"GetAssassinLibraryInfoReply"
	},
	[13077] = {
		"AssassinScene",
		"EnterAssassinSceneRequest",
		"EnterAssassinSceneReply"
	},
	[-17527] = {
		"AssassinScene",
		"HeroMoveRequest",
		"HeroMoveReply"
	},
	[14378] = {
		"AssassinScene",
		"HeroAttackRequest",
		"HeroAttackReply"
	},
	[31575] = {
		"AssassinScene",
		"HeroAssassinRequest",
		"HeroAssassinReply"
	},
	[22096] = {
		"AssassinScene",
		"HeroInteractiveRequest",
		"HeroInteractiveReply"
	},
	[-11507] = {
		"AssassinScene",
		"FinishUserTurnRequest",
		"FinishUserTurnReply"
	},
	[-8312] = {
		"AssassinScene",
		"RecoverSceneRequest",
		"RecoverSceneReply"
	},
	[-32213] = {
		"AssassinScene",
		"NextRoundRequest",
		"NextRoundReply"
	},
	[21131] = {
		"AssassinScene",
		"SummonMonsterPush"
	},
	[-20788] = {
		"AssassinScene",
		"NewInteractivePush"
	},
	[-1527] = {
		"AssassinScene",
		"MissionUpdatePush"
	},
	[20559] = {
		"AssassinScene",
		"MonsterUpdatePush"
	},
	[14951] = {
		"AssassinScene",
		"FinishMissionRequest",
		"FinishMissionReply"
	},
	[25279] = {
		"AssassinScene",
		"GameStatePush"
	},
	[26295] = {
		"AssassinScene",
		"ReturnAssassinSceneRequest",
		"ReturnAssassinSceneReply"
	},
	[26450] = {
		"AssassinScene",
		"GainItemPush"
	},
	[-15136] = {
		"AssassinScene",
		"UseAssassinItemRequest",
		"UseAssassinItemReply"
	},
	[10246] = {
		"AssassinScene",
		"AssassinChangingMapPush"
	},
	[15132] = {
		"AssassinScene",
		"RestartAssassinSceneRequest",
		"RestartAssassinSceneReply"
	},
	[-2873] = {
		"AssassinScene",
		"GiveUpAssassinSceneRequest",
		"GiveUpAssassinSceneReply"
	},
	[-12019] = {
		"AssassinScene",
		"AssassinChangeMapRequest",
		"AssassinChangeMapReply"
	},
	[-26475] = {
		"AssassinScene",
		"AssassinUseSkillRequest",
		"AssassinUseSkillReply"
	},
	[-29244] = {
		"AssassinScene",
		"EnterBattleGridRequest",
		"EnterBattleGridReply"
	},
	[-32619] = {
		"AssassinScene",
		"HeroUpdatePush"
	},
	[27511] = {
		"Atomic",
		"AtomicGetInfoRequest",
		"AtomicGetInfoReply"
	},
	[-8806] = {
		"Atomic",
		"AtomicUpdateInfoPush"
	},
	[12330] = {
		"Atomic",
		"AtomicUpdateAlarmPush"
	},
	[27579] = {
		"Atomic",
		"AtomicMapSetCurrElementRequest",
		"AtomicMapSetCurrElementReply"
	},
	[-2365] = {
		"Atomic",
		"AtomicMapInteractRequest",
		"AtomicMapInteractReply"
	},
	[14492] = {
		"Atomic",
		"AtomicUpdateEmergencyTimeRequest",
		"AtomicUpdateEmergencyTimeReply"
	},
	[-7326] = {
		"Atomic",
		"AtomicMapSaveElementRequest",
		"AtomicMapSaveElementReply"
	},
	[5718] = {
		"Atomic",
		"AtomicMapElementUpdatePush"
	},
	[32140] = {
		"Atomic",
		"AtomicMapUpdatePush"
	},
	[19045] = {
		"Atomic",
		"AtomicPolygonUpdatePush"
	},
	[10949] = {
		"Atomic",
		"AtomicTalentNodeUnlockRequest",
		"AtomicTalentNodeUnlockReply"
	},
	[-13706] = {
		"Atomic",
		"AtomicTalentResetRequest",
		"AtomicTalentResetReply"
	},
	[17683] = {
		"Atomic",
		"AtomicTalentSkillChooseRequest",
		"AtomicTalentSkillChooseReply"
	},
	[28822] = {
		"Atomic",
		"AtomicTalentUpdatePush"
	},
	[16444] = {
		"Atomic",
		"AtomicFightResultPush"
	},
	[1452] = {
		"Atomic",
		"AtomicUnlockLibraryPush"
	},
	[4686] = {
		"Atomic",
		"AtomicHotfix1Request",
		"AtomicHotfix1Reply"
	},
	[4687] = {
		"Atomic",
		"AtomicHotfix2Request",
		"AtomicHotfix2Reply"
	},
	[-24562] = {
		"Atomic",
		"AtomicHotfix1Push"
	},
	[-24561] = {
		"Atomic",
		"AtomicHotfix2Push"
	},
	[-10819] = {
		"AutoChess",
		"AutoChessGetSceneRequest",
		"AutoChessGetSceneReply"
	},
	[17595] = {
		"AutoChess",
		"AutoChessEnterSceneRequest",
		"AutoChessEnterSceneReply"
	},
	[22591] = {
		"AutoChess",
		"AutoChessEnterFightRequest",
		"AutoChessEnterFightReply"
	},
	[-15531] = {
		"AutoChess",
		"AutoChessBuyChessRequest",
		"AutoChessBuyChessReply"
	},
	[20447] = {
		"AutoChess",
		"AutoChessBuildRequest",
		"AutoChessBuildReply"
	},
	[-17148] = {
		"AutoChess",
		"AutoChessRefreshMallRequest",
		"AutoChessRefreshMallReply"
	},
	[13119] = {
		"AutoChess",
		"AutoChessFreezeItemRequest",
		"AutoChessFreezeItemReply"
	},
	[10984] = {
		"AutoChess",
		"AutoChessMallRegionSelectItemRequest",
		"AutoChessMallRegionSelectItemReply"
	},
	[26503] = {
		"AutoChess",
		"AutoChessUseMasterSkillRequest",
		"AutoChessUseMasterSkillReply"
	},
	[10043] = {
		"AutoChess",
		"AutoChessUseSkillRequest",
		"AutoChessUseSkillReply"
	},
	[3715] = {
		"AutoChess",
		"AutoChessPreviewFightRequest",
		"AutoChessPreviewFightReply"
	},
	[-3457] = {
		"AutoChess",
		"AutoChessGiveUpRequest",
		"AutoChessGiveUpReply"
	},
	[-3067] = {
		"AutoChess",
		"AutoChessEnterFriendFightSceneRequest",
		"AutoChessEnterFriendFightSceneReply"
	},
	[-10420] = {
		"AutoChess",
		"AutoChessMallUpgradePush"
	},
	[1693] = {
		"AutoChess",
		"AutoChessScenePush"
	},
	[-4024] = {
		"AutoChess",
		"AutoChessRoundSettlePush"
	},
	[-32448] = {
		"AutoChess",
		"AutoChessSettlePush"
	},
	[20297] = {
		"Banner",
		"GetBannerInfoRequest",
		"GetBannerInfoReply"
	},
	[-9413] = {
		"Banner",
		"SetBannerNotShowRequest",
		"SetBannerNotShowReply"
	},
	[265] = {
		"Bgm",
		"SetUseBgmRequest",
		"SetUseBgmReply"
	},
	[18537] = {
		"Bgm",
		"SetFavoriteBgmRequest",
		"SetFavoriteBgmReply"
	},
	[-30839] = {
		"Bgm",
		"GetBgmInfoRequest",
		"GetBgmInfoReply"
	},
	[2848] = {
		"Bgm",
		"UpdateBgmPush"
	},
	[-15015] = {
		"Bgm",
		"ReadBgmRequest",
		"ReadBgmReply"
	},
	[15341] = {
		"BossFight",
		"BossFightResetChapterRequest",
		"BossFightResetChapterReply"
	},
	[-5055] = {
		"Bp",
		"GetBpInfoRequest",
		"GetBpInfoReply"
	},
	[30844] = {
		"Bp",
		"GetBpBonusRequest",
		"GetBpBonusReply"
	},
	[-27276] = {
		"Bp",
		"BpScoreUpdatePush"
	},
	[4063] = {
		"Bp",
		"BpPayPush"
	},
	[2877] = {
		"Bp",
		"BpBuyLevelRequset",
		"BpBuyLevelReply"
	},
	[28489] = {
		"Bp",
		"BpMarkFirstShowRequest",
		"BpMarkFirstShowReply"
	},
	[14599] = {
		"Bp",
		"BpOpenPush"
	},
	[-1196] = {
		"Bp",
		"GetSelfSelectBonusRequest",
		"GetSelfSelectBonusReply"
	},
	[31537] = {
		"Charge",
		"GetChargeInfoRequest",
		"GetChargeInfoReply"
	},
	[-5087] = {
		"Charge",
		"NewOrderRequest",
		"NewOrderReply"
	},
	[7728] = {
		"Charge",
		"OrderCompletePush"
	},
	[5799] = {
		"Charge",
		"GetMonthCardInfoRequest",
		"GetMonthCardInfoReply"
	},
	[-4190] = {
		"Charge",
		"GetMonthCardBonusRequest",
		"GetMonthCardBonusReply"
	},
	[9556] = {
		"Charge",
		"SandboxChargeRequset",
		"SandboxChargeReply"
	},
	[23467] = {
		"Charge",
		"ReadChargeNewRequest",
		"ReadChargeNewReply"
	},
	[-17743] = {
		"ChargePush",
		"GetChargePushInfoRequest",
		"GetChargePushInfoReply"
	},
	[-20283] = {
		"ChargePush",
		"GetChargePushPush"
	},
	[15268] = {
		"ChargePush",
		"RecordChargePushRequest",
		"RecordChargePushReply"
	},
	[-29022] = {
		"Chat",
		"SendMsgRequest",
		"SendMsgReply"
	},
	[-25586] = {
		"Chat",
		"DeleteOfflineMsgRequest",
		"DeleteOfflineMsgReply"
	},
	[-8392] = {
		"Chat",
		"ChatMsgPush"
	},
	[27727] = {
		"Chat",
		"GetReportTypeRequest",
		"GetReportTypeReply"
	},
	[22157] = {
		"Chat",
		"ReportRequest",
		"ReportReply"
	},
	[21901] = {
		"Chat",
		"WordTestRequest",
		"WordTestReply"
	},
	[19527] = {
		"CommandPost",
		"GetCommandPostInfoRequest",
		"GetCommandPostInfoReply"
	},
	[22910] = {
		"CommandPost",
		"FinishCommandPostEventRequest",
		"FinishCommandPostEventReply"
	},
	[-4117] = {
		"CommandPost",
		"CommandPostDispatchRequest",
		"CommandPostDispatchReply"
	},
	[7554] = {
		"CommandPost",
		"CommandPostBonusRequest",
		"CommandPostBonusReply"
	},
	[-12877] = {
		"CommandPost",
		"CommandPostPaperRequest",
		"CommandPostPaperReply"
	},
	[26907] = {
		"CommandPost",
		"CommandPostBonusAllRequest",
		"CommandPostBonusAllReply"
	},
	[-16743] = {
		"CommandPost",
		"CommandPostEventReadRequest",
		"CommandPostEventReadReply"
	},
	[-24924] = {
		"CommandPost",
		"CommandPostCharacterReadRequest",
		"CommandPostCharacterReadReply"
	},
	[24032] = {
		"Common",
		"GetServerTimeRequest",
		"GetServerTimeReply"
	},
	[-17001] = {
		"Critter",
		"CritterGetInfoRequest",
		"CritterGetInfoReply"
	},
	[32183] = {
		"Critter",
		"StartTrainCritterRequest",
		"StartTrainCritterReply"
	},
	[-3479] = {
		"Critter",
		"SelectEventOptionRequest",
		"SelectEventOptionReply"
	},
	[-22476] = {
		"Critter",
		"SelectMultiEventOptionRequest",
		"SelectMultiEventOptionReply"
	},
	[-13681] = {
		"Critter",
		"FastForwardTrainRequest",
		"FastForwardTrainReply"
	},
	[-5398] = {
		"Critter",
		"FinishTrainCritterRequest",
		"FinishTrainCritterReply"
	},
	[-26080] = {
		"Critter",
		"BanishCritterRequest",
		"BanishCritterReply"
	},
	[3574] = {
		"Critter",
		"SummonCritterInfoRequest",
		"SummonCritterInfoReply"
	},
	[20426] = {
		"Critter",
		"SummonCritterRequest",
		"SummonCritterReply"
	},
	[15444] = {
		"Critter",
		"LockCritterRequest",
		"LockCritterReply"
	},
	[15207] = {
		"Critter",
		"ResetSummonCritterPoolRequest",
		"ResetSummonCritterPoolReply"
	},
	[26456] = {
		"Critter",
		"GainGuideCritterRequest",
		"GainGuideCritterReply"
	},
	[17494] = {
		"Critter",
		"IncubateCritterRequest",
		"IncubateCritterReply"
	},
	[29879] = {
		"Critter",
		"CritterInfoPush"
	},
	[-30888] = {
		"Critter",
		"IncubateCritterPreviewRequest",
		"IncubateCritterPreviewReply"
	},
	[9634] = {
		"Critter",
		"GetCritterBookInfoRequest",
		"GetCritterBookInfoReply"
	},
	[-7262] = {
		"Critter",
		"SetCritterBookBackgroundRequest",
		"SetCritterBookBackgroundReply"
	},
	[10565] = {
		"Critter",
		"SetCritterBookUseSpecialSkinRequest",
		"SetCritterBookUseSpecialSkinReply"
	},
	[-11391] = {
		"Critter",
		"CancelTrainRequest",
		"CancelTrainReply"
	},
	[-3961] = {
		"Critter",
		"MarkCritterBookNewReadRequest",
		"MarkCritterBookNewReadReply"
	},
	[-31095] = {
		"Critter",
		"RefreshCritterMoodRequest",
		"RefreshCritterMoodReply"
	},
	[19075] = {
		"Critter",
		"GetRealCritterAttributeRequest",
		"GetRealCritterAttributeReply"
	},
	[21213] = {
		"Critter",
		"RefreshBuildingCritterAttibutesRequest",
		"RefreshBuildingCritterAttibutesReply"
	},
	[-21885] = {
		"Critter",
		"RealCritterAttributePush"
	},
	[18841] = {
		"Critter",
		"StartTrainCritterPreviewRequest",
		"StartTrainCritterPreviewReply"
	},
	[-27965] = {
		"Critter",
		"CritterRenameRequest",
		"CritterRenameReply"
	},
	[20931] = {
		"Currency",
		"GetCurrencyListRequest",
		"GetCurrencyListReply"
	},
	[19309] = {
		"Currency",
		"CurrencyChangePush"
	},
	[-4123] = {
		"Currency",
		"GetBuyPowerInfoRequest",
		"GetBuyPowerInfoReply"
	},
	[5177] = {
		"Currency",
		"BuyPowerRequest",
		"BuyPowerReply"
	},
	[-20133] = {
		"Currency",
		"ExchangeDiamondRequest",
		"ExchangeDiamondReply"
	},
	[20144] = {
		"Currency",
		"ExchangeSameCurrencyRequest",
		"ExchangeSameCurrencyReply"
	},
	[25023] = {
		"Currency",
		"PopExchangeSameCurrencyRequest",
		"PopExchangeSameCurrencyReply"
	},
	[-15619] = {
		"Dialog",
		"GetDialogInfoRequest",
		"GetDialogInfoReply"
	},
	[21980] = {
		"Dialog",
		"RecordDialogInfoRequest",
		"RecordDialogInfoReplay"
	},
	[-32593] = {
		"DiceHero",
		"DiceHeroGetInfoRequest",
		"DiceHeroGetInfoReply"
	},
	[-20618] = {
		"DiceHero",
		"DiceHeroEnterStoryRequest",
		"DiceHeroEnterStoryReply"
	},
	[-11236] = {
		"DiceHero",
		"DiceHeroGetRewardRequest",
		"DiceHeroGetRewardReply"
	},
	[7481] = {
		"DiceHero",
		"DiceHeroEnterFightRequest",
		"DiceHeroEnterFightReply"
	},
	[-30111] = {
		"DiceHero",
		"DiceHeroResetDiceRequest",
		"DiceHeroResetDiceReply"
	},
	[21466] = {
		"DiceHero",
		"DiceHeroConfirmDiceRequest",
		"DiceHeroConfirmDiceReply"
	},
	[-1341] = {
		"DiceHero",
		"DiceHeroUseSkillRequest",
		"DiceHeroUseSkillReply"
	},
	[-24426] = {
		"DiceHero",
		"DiceHeroEndRoundRequest",
		"DiceHeroEndRoundReply"
	},
	[-28885] = {
		"DiceHero",
		"DiceGiveUpRequest",
		"DiceGiveUpReply"
	},
	[-27668] = {
		"DiceHero",
		"DiceFightSettlePush"
	},
	[-30467] = {
		"Dispatch",
		"GetDispatchInfoRequest",
		"GetDispatchInfoReply"
	},
	[29553] = {
		"Dispatch",
		"DispatchRequest",
		"DispatchReply"
	},
	[-1090] = {
		"Dispatch",
		"InterruptDispatchRequest",
		"InterruptDispatchReply"
	},
	[-4591] = {
		"Dungeon",
		"GetDungeonRequest",
		"GetDungeonReply"
	},
	[6132] = {
		"Dungeon",
		"DungeonUpdatePush"
	},
	[4912] = {
		"Dungeon",
		"DungeonInfosPush"
	},
	[3231] = {
		"Dungeon",
		"StartDungeonRequest",
		"StartDungeonReply"
	},
	[30408] = {
		"Dungeon",
		"EndDungeonRequest",
		"EndDungeonReply"
	},
	[31240] = {
		"Dungeon",
		"EndDungeonPush"
	},
	[31241] = {
		"Dungeon",
		"MapElementRequest",
		"MapElementReply"
	},
	[-7127] = {
		"Dungeon",
		"ChapterMapUpdatePush"
	},
	[19027] = {
		"Dungeon",
		"ChapterMapElementUpdatePush"
	},
	[18768] = {
		"Dungeon",
		"GetPointRewardRequest",
		"GetPointRewardReply"
	},
	[-16686] = {
		"Dungeon",
		"GetEpisodeHeroRecommendRequest",
		"GetEpisodeHeroRecommendReply"
	},
	[3355] = {
		"Dungeon",
		"EquipSpDungeonUpdatePush"
	},
	[8595] = {
		"Dungeon",
		"RewardPointUpdatePush"
	},
	[16056] = {
		"Dungeon",
		"InstructionDungeonRewardRequest",
		"InstructionDungeonRewardReply"
	},
	[19970] = {
		"Dungeon",
		"InstructionDungeonFinalRewardRequest",
		"InstructionDungeonFinalRewardReply"
	},
	[5087] = {
		"Dungeon",
		"InstructionDungeonInfoRequest",
		"InstructionDungeonInfoReply"
	},
	[2547] = {
		"Dungeon",
		"InstructionDungeonInfoPush"
	},
	[26245] = {
		"Dungeon",
		"InstructionDungeonOpenRequest",
		"InstructionDungeonOpenReply"
	},
	[12399] = {
		"Dungeon",
		"CoverDungeonRecordRequest",
		"CoverDungeonRecordReply"
	},
	[-31764] = {
		"Dungeon",
		"PuzzleFinishRequest",
		"PuzzleFinishReply"
	},
	[20143] = {
		"Dungeon",
		"SavePuzzleProgressRequest",
		"SavePuzzleProgressReply"
	},
	[15392] = {
		"Dungeon",
		"GetPuzzleProgressRequest",
		"GetPuzzleProgressReply"
	},
	[-24665] = {
		"Dungeon",
		"RefreshAssistRequest",
		"RefreshAssistReply"
	},
	[1424] = {
		"Dungeon",
		"GetMainDramaRewardRequest",
		"GetMainDramaRewardReply"
	},
	[-24868] = {
		"Dungeon",
		"MainDramaRewardInfo"
	},
	[-24600] = {
		"Dungeon",
		"GetMapElementRecordRequest",
		"GetMapElementRecordReply"
	},
	[15973] = {
		"Equip",
		"GetEquipInfoRequest",
		"GetEquipInfoReply"
	},
	[-19172] = {
		"Equip",
		"EquipUpdatePush"
	},
	[-12052] = {
		"Equip",
		"EquipDeletePush"
	},
	[-20485] = {
		"Equip",
		"EquipStrengthenRequest",
		"EquipStrengthenReply"
	},
	[-2] = {
		"Equip",
		"EquipBreakRequest",
		"EquipBreakReply"
	},
	[18434] = {
		"Equip",
		"EquipLockRequest",
		"EquipLockReply"
	},
	[-10161] = {
		"Equip",
		"EquipComposeRequest",
		"EquipComposeReply"
	},
	[9144] = {
		"Equip",
		"EquipDecomposeRequest",
		"EquipDecomposeReply"
	},
	[-1422] = {
		"Equip",
		"EquipRefineRequest",
		"EquipRefineReply"
	},
	[29371] = {
		"Explore",
		"GetExploreInfoRequest",
		"GetExploreInfoReply"
	},
	[-28635] = {
		"Explore",
		"GetExploreSimpleInfoRequest",
		"GetExploreSimpleInfoReply"
	},
	[6164] = {
		"Explore",
		"ChangeMapRequest",
		"ChangeMapReply"
	},
	[13574] = {
		"Explore",
		"ExploreMoveRequest",
		"ExploreMoveReply"
	},
	[-6261] = {
		"Explore",
		"ExploreUseItemRequest",
		"ExploreUseItemReply"
	},
	[-188] = {
		"Explore",
		"ExploreItemChangePush"
	},
	[-27767] = {
		"Explore",
		"ExploreInteractRequest",
		"ExploreInteractReply"
	},
	[-7016] = {
		"Explore",
		"ExploreItemInteractRequest",
		"ExploreItemInteractReply"
	},
	[-28513] = {
		"Explore",
		"ExploreStepPush"
	},
	[-11406] = {
		"Explore",
		"ResetExploreRequest",
		"ResetExploreReply"
	},
	[18442] = {
		"Fairyland",
		"GetFairylandInfoRequest",
		"GetFairylandInfoReply"
	},
	[-13963] = {
		"Fairyland",
		"ResolvePuzzleRequest",
		"ResolvePuzzleReply"
	},
	[32762] = {
		"Fairyland",
		"RecordDialogRequest",
		"RecordDialogReply"
	},
	[-1260] = {
		"Fairyland",
		"RecordElementRequest",
		"RecordElementReply"
	},
	[-30438] = {
		"Fight",
		"BeginFightRequest",
		"BeginFightReply"
	},
	[-5451] = {
		"Fight",
		"TestFightRequest",
		"TestFightReply"
	},
	[30146] = {
		"Fight",
		"TestFightIdRequest",
		"TestFightIdReply"
	},
	[-2028] = {
		"Fight",
		"MoveCardRequest",
		"MoveCardReply"
	},
	[17166] = {
		"Fight",
		"ResetRoundRequest",
		"ResetRoundReply"
	},
	[13744] = {
		"Fight",
		"BeginRoundRequest",
		"BeginRoundReply"
	},
	[-9054] = {
		"Fight",
		"EndRoundRequest",
		"EndRoundReply"
	},
	[-25567] = {
		"Fight",
		"ChangeSubHeroRequest",
		"ChangeSubHeroReply"
	},
	[25565] = {
		"Fight",
		"ChangeSubHeroExSkillRequest",
		"ChangeSubHeroExSkillReply"
	},
	[9206] = {
		"Fight",
		"ReconnectFightRequest",
		"ReconnectFightReply"
	},
	[-19063] = {
		"Fight",
		"CardInfoPush"
	},
	[5078] = {
		"Fight",
		"TeamInfoPush"
	},
	[12300] = {
		"Fight",
		"EndFightRequest",
		"EndFightReply"
	},
	[13644] = {
		"Fight",
		"EndFightPush"
	},
	[29544] = {
		"Fight",
		"FightWavePush"
	},
	[-9399] = {
		"Fight",
		"UseClothSkillRequest",
		"UseClothSkillReply"
	},
	[30262] = {
		"Fight",
		"RedealCardInfoPush"
	},
	[-3100] = {
		"Fight",
		"AutoRoundRequest",
		"AutoRoundReply"
	},
	[-149] = {
		"Fight",
		"GetFightOperRequest",
		"GetFightOperReply"
	},
	[-16575] = {
		"Fight",
		"GetFightRecordGroupRequest",
		"GetFightRecordGroupReply"
	},
	[25708] = {
		"Fight",
		"EntityInfoRequest",
		"EntityInfoReply"
	},
	[-13070] = {
		"Fight",
		"GetFightCardDeckInfoRequest",
		"GetFightCardDeckInfoReply"
	},
	[-18830] = {
		"Fight",
		"GetEntityDetailInfosRequest",
		"GetEntityDetailInfosReply"
	},
	[30317] = {
		"Fight",
		"GetFightRecordAllRequest",
		"GetFightRecordAllReply"
	},
	[-12599] = {
		"Fight",
		"FightWithRecordAllRequest",
		"FightWithRecordAllReply"
	},
	[-22747] = {
		"Fight",
		"GetFightCardDeckDetailInfoRequest",
		"GetFightCardDeckDetailInfoReply"
	},
	[15330] = {
		"Fight",
		"GetGMFightTeamDetailInfosRequest",
		"GetGMFightTeamDetailInfosReply"
	},
	[2347] = {
		"Fight",
		"GetGMFightLogRequest",
		"GetGMFightLogReply"
	},
	[-8980] = {
		"FightTool",
		"EnterCustomFightRequest",
		"EnterCustomFightReply"
	},
	[-11219] = {
		"Fishing",
		"GetFishingInfoRequest",
		"GetFishingInfoReply"
	},
	[-6609] = {
		"Fishing",
		"GetOtherFishingInfoRequest",
		"GetOtherFishingInfoReply"
	},
	[1441] = {
		"Fishing",
		"FishingRequest",
		"FishingReply"
	},
	[24055] = {
		"Fishing",
		"GetFishingBonusRequest",
		"GetFishingBonusReply"
	},
	[-13006] = {
		"Fishing",
		"ChangeFishingCurrencyRequest",
		"ChangeFishingCurrencyReply"
	},
	[-25524] = {
		"Fishing",
		"GetFishingFriendsRequest",
		"GetFishingFriendsReply"
	},
	[28363] = {
		"Friend",
		"GetApplyListRequest",
		"GetApplyListReply"
	},
	[-29265] = {
		"Friend",
		"ApplyRequest",
		"ApplyReply"
	},
	[16251] = {
		"Friend",
		"HandleApplyRequest",
		"HandleApplyReply"
	},
	[17247] = {
		"Friend",
		"RejectAllRequest",
		"RejectAllReply"
	},
	[-30711] = {
		"Friend",
		"GetFriendInfoListRequest",
		"GetFriendInfoListReply"
	},
	[-13109] = {
		"Friend",
		"AddBlacklistRequest",
		"AddBlacklistReply"
	},
	[-27760] = {
		"Friend",
		"RemoveBlacklistRequest",
		"RemoveBlacklistReply"
	},
	[19215] = {
		"Friend",
		"RemoveFriendRequest",
		"RemoveFriendReply"
	},
	[-4417] = {
		"Friend",
		"SearchRequest",
		"SearchReply"
	},
	[-15262] = {
		"Friend",
		"GetBlacklistRequest",
		"GetBlacklistReply"
	},
	[-8216] = {
		"Friend",
		"BlacklistChangePush"
	},
	[4486] = {
		"Friend",
		"AgreeAllRequest",
		"AgreeAllReply"
	},
	[-25504] = {
		"Friend",
		"LoadFriendInfosRequest",
		"LoadFriendInfosReply"
	},
	[23207] = {
		"Friend",
		"FriendChangePush"
	},
	[-17850] = {
		"Friend",
		"FriendDescChangeRequest",
		"FriendDescChangeReply"
	},
	[25751] = {
		"Friend",
		"GetRecommendedFriendsRequest",
		"GetRecommendedFriendsReply"
	},
	[-22437] = {
		"GlobalVote",
		"GlobalVoteGetInfoRequest",
		"GlobalVoteGetInfoReply"
	},
	[9762] = {
		"GM",
		"GMRequest",
		"GMReply"
	},
	[-22917] = {
		"GM",
		"GpuCpuLogRequest",
		"GpuCpuLogReply"
	},
	[-6139] = {
		"GM",
		"TestGMTextReply"
	},
	[-5833] = {
		"GM",
		"GMSummonResultPush"
	},
	[3036] = {
		"GM",
		"FightTipsMessagePush"
	},
	[28434] = {
		"GM",
		"ServerErrorInfoPush"
	},
	[19592] = {
		"GM",
		"GmModuleRequest",
		"GmModuleReply"
	},
	[18894] = {
		"Guide",
		"FinishGuideRequest",
		"FinishGuideReply"
	},
	[-11849] = {
		"Guide",
		"UpdateGuidePush"
	},
	[2105] = {
		"Guide",
		"GetGuideInfoRequest",
		"GetGuideInfoReply"
	},
	[19177] = {
		"Handbook",
		"GetHandbookInfoRequest",
		"GetHandbookInfoReply"
	},
	[-29895] = {
		"Handbook",
		"HandbookReadRequest",
		"HandbookReadReply"
	},
	[-11453] = {
		"HeroGroup",
		"GetHeroGroupListRequest",
		"GetHeroGroupListReply"
	},
	[31018] = {
		"HeroGroup",
		"UpdateHeroGroupRequest",
		"UpdateHeroGroupReply"
	},
	[-27977] = {
		"HeroGroup",
		"SetHeroGroupEquipRequest",
		"SetHeroGroupEquipReply"
	},
	[-31069] = {
		"HeroGroup",
		"SetHeroGroupSnapshotRequest",
		"SetHeroGroupSnapshotReply"
	},
	[-24283] = {
		"HeroGroup",
		"SetHeroGroupSnapshotBatchRequest",
		"SetHeroGroupSnapshotBatchReply"
	},
	[-8854] = {
		"HeroGroup",
		"UpdateHeroGroupPush"
	},
	[32460] = {
		"HeroGroup",
		"GetHeroGroupCommonListRequest",
		"GetHeroGroupCommonListReply"
	},
	[-1459] = {
		"HeroGroup",
		"ChangeHeroGroupSelectRequest",
		"ChangeHeroGroupSelectReply"
	},
	[28378] = {
		"HeroGroup",
		"UpdateHeroGroupNameRequest",
		"UpdateHeroGroupNameReply"
	},
	[2131] = {
		"HeroGroup",
		"GetHeroGroupSnapshotListRequest",
		"GetHeroGroupSnapshotListReply"
	},
	[30458] = {
		"HeroGroup",
		"DeleteHeroGroupRequest",
		"DeleteHeroGroupReply"
	},
	[26866] = {
		"HeroGroup",
		"UpdateHeroGroupSortRequest",
		"UpdateHeroGroupSortReply"
	},
	[18790] = {
		"HeroGroup",
		"CheckHeroGroupNameRequest",
		"CheckHeroGroupNameReply"
	},
	[1402] = {
		"HeroGroup",
		"UpdateHeroGroupSnapshotPush"
	},
	[-27005] = {
		"HeroInvitation",
		"GetHeroInvitationInfoRequest",
		"GetHeroInvitationInfoReply"
	},
	[23159] = {
		"HeroInvitation",
		"GainInviteRewardRequest",
		"GainInviteRewardReply"
	},
	[-8734] = {
		"HeroInvitation",
		"GainFinalInviteRewardRequest",
		"GainFinalInviteRewardReply"
	},
	[-3787] = {
		"Hero",
		"HeroInfoListRequest",
		"HeroInfoListReply"
	},
	[-25616] = {
		"Hero",
		"HeroUpdatePush"
	},
	[18068] = {
		"Hero",
		"HeroUpgradeSkillRequest",
		"HeroUpgradeSkillReply"
	},
	[24554] = {
		"Hero",
		"HeroLevelUpRequest",
		"HeroLevelUpReply"
	},
	[-25186] = {
		"Hero",
		"HeroRankUpRequest",
		"HeroRankUpReply"
	},
	[5793] = {
		"Hero",
		"UseSkinRequest",
		"UseSkinReply"
	},
	[-22399] = {
		"Hero",
		"HeroSkinGainPush"
	},
	[-29069] = {
		"Hero",
		"UnMarkIsNewRequest",
		"UnMarkIsNewReply"
	},
	[21281] = {
		"Hero",
		"UnlockVoiceRequest",
		"UnlockVoiceReply"
	},
	[14170] = {
		"Hero",
		"ItemUnlockRequest",
		"ItemUnlockReply"
	},
	[15468] = {
		"Hero",
		"HeroGainPush"
	},
	[-21872] = {
		"Hero",
		"HeroTouchRequest",
		"HeroTouchReply"
	},
	[5242] = {
		"Hero",
		"HeroTalentUpRequest",
		"HeroTalentUpReply"
	},
	[-15329] = {
		"Hero",
		"PutTalentCubeRequest",
		"PutTalentCubeReply"
	},
	[-20353] = {
		"Hero",
		"TakeoffAllTalentCubeRequest",
		"TakeoffAllTalentCubeReply"
	},
	[29077] = {
		"Hero",
		"PutTalentSchemeRequest",
		"PutTalentSchemeReply"
	},
	[17942] = {
		"Hero",
		"HeroDefaultEquipRequest",
		"HeroDefaultEquipReply"
	},
	[2331] = {
		"Hero",
		"RenameTalentTemplateRequest",
		"RenameTalentTemplateReply"
	},
	[29648] = {
		"Hero",
		"UseTalentTemplateRequest",
		"UseTalentTemplateReply"
	},
	[-3085] = {
		"Hero",
		"UnlockTalentStyleRequest",
		"UnlockTalentStyleReply"
	},
	[15173] = {
		"Hero",
		"UseTalentStyleRequest",
		"UseTalentStyleReply"
	},
	[-24940] = {
		"Hero",
		"TalentStyleReadRequest",
		"TalentStyleReadReply"
	},
	[28886] = {
		"Hero",
		"MarkHeroFavorRequest",
		"MarkHeroFavorReply"
	},
	[-29459] = {
		"Hero",
		"HeroLevelUpUpdatePush"
	},
	[13693] = {
		"Hero",
		"HeroTalentUpUpdatePush"
	},
	[31906] = {
		"Hero",
		"HeroTalentStyleStatRequest",
		"HeroTalentStyleStatReply"
	},
	[9532] = {
		"Hero",
		"DestinyLevelUpRequest",
		"DestinyLevelUpReply"
	},
	[387] = {
		"Hero",
		"DestinyRankUpRequest",
		"DestinyRankUpReply"
	},
	[-32300] = {
		"Hero",
		"DestinyStoneUnlockRequest",
		"DestinyStoneUnlockReply"
	},
	[6261] = {
		"Hero",
		"DestinyStoneUseRequest",
		"DestinyStoneUseReply"
	},
	[-23957] = {
		"Hero",
		"HeroRedDotReadRequest",
		"HeroRedDotReadReply"
	},
	[-21471] = {
		"Hero",
		"PutTalentCubeBatchRequest",
		"PutTalentCubeBatchReply"
	},
	[13914] = {
		"Hero",
		"ChoiceHero3124TalentTreeRequest",
		"ChoiceHero3124TalentTreeReply"
	},
	[5714] = {
		"Hero",
		"ResetHero3124TalentTreeRequest",
		"ResetHero3124TalentTreeReply"
	},
	[29963] = {
		"Hero",
		"ChoiceHero3123WeaponRequest",
		"ChoiceHero3123WeaponReply"
	},
	[-8715] = {
		"Hero",
		"CancelHero3124TalentTreeRequest",
		"CancelHero3124TalentTreeReply"
	},
	[-27537] = {
		"HeroStory",
		"GetHeroStoryRequest",
		"GetHeroStoryReply"
	},
	[-613] = {
		"HeroStory",
		"UnlocHeroStoryRequest",
		"UnlocHeroStoryReply"
	},
	[-15210] = {
		"HeroStory",
		"GetHeroStoryBonusRequest",
		"GetHeroStoryBonusReply"
	},
	[16434] = {
		"HeroStory",
		"HeroStoryUpdatePush"
	},
	[26102] = {
		"HeroStory",
		"UpdateHeroStoryStatusRequest",
		"UpdateHeroStoryStatusReply"
	},
	[-22201] = {
		"HeroStory",
		"ExchangeTicketRequest",
		"ExchangeTicketReply"
	},
	[-19101] = {
		"HeroStory",
		"GetScoreBonusRequest",
		"GetScoreBonusReply"
	},
	[23850] = {
		"HeroStory",
		"GetChallengeBonusRequest",
		"GetChallengeBonusReply"
	},
	[-19029] = {
		"HeroStory",
		"HeroStoryScorePush"
	},
	[12499] = {
		"HeroStory",
		"HeroStoryTicketPush"
	},
	[8174] = {
		"HeroStory",
		"HeroStoryWeekTaskPush"
	},
	[7790] = {
		"HeroStory",
		"HeroStoryWeekTaskGetRequest",
		"HeroStoryWeekTaskGetReply"
	},
	[25343] = {
		"HeroStory",
		"HeroStoryDispatchRequest",
		"HeroStoryDispatchReply"
	},
	[-1160] = {
		"HeroStory",
		"HeroStoryDispatchCompleteRequest",
		"HeroStoryDispatchCompleteReply"
	},
	[21226] = {
		"HeroStory",
		"HeroStoryDispatchResetRequest",
		"HeroStoryDispatchResetReply"
	},
	[-23569] = {
		"HeroStory",
		"HeroStoryPlotFinishRequest",
		"HeroStoryPlotFinishReply"
	},
	[-8789] = {
		"HeroStory",
		"HeroStoryCommonTaskRequest",
		"HeroStoryCommonTaskReply"
	},
	[-7309] = {
		"Investigate",
		"GetInvestigateRequest",
		"GetInvestigateReply"
	},
	[-8458] = {
		"Investigate",
		"PutClueRequest",
		"PutClueReply"
	},
	[5187] = {
		"Investigate",
		"InvestigateInfoPush"
	},
	[29707] = {
		"Item",
		"GetItemListRequest",
		"GetItemListReply"
	},
	[16437] = {
		"Item",
		"ItemChangePush"
	},
	[-14948] = {
		"Item",
		"UseItemRequest",
		"UseItemReply"
	},
	[-32183] = {
		"Item",
		"UsePowerItemRequest",
		"UsePowerItemReply"
	},
	[-1659] = {
		"Item",
		"UsePowerItemListRequest",
		"UsePowerItemListReply"
	},
	[8367] = {
		"Item",
		"AutoUseExpirePowerItemRequest",
		"AutoUseExpirePowerItemReply"
	},
	[18761] = {
		"Item",
		"GetPowerMakerInfoRequest",
		"GetPowerMakerInfoReply"
	},
	[8246] = {
		"Item",
		"MarkReadSubType21Request",
		"MarkReadSubType21Reply"
	},
	[25074] = {
		"Item",
		"UseInsightItemRequest",
		"UseInsightItemReply"
	},
	[-7612] = {
		"Item",
		"UseTalentItemRequest",
		"UseTalentItemReply"
	},
	[13187] = {
		"Mail",
		"GetAllMailsRequest",
		"GetAllMailsReply"
	},
	[-6896] = {
		"Mail",
		"ReadMailRequest",
		"ReadMailReply"
	},
	[-13995] = {
		"Mail",
		"ReadMailBatchRequest",
		"ReadMailBatchReply"
	},
	[21057] = {
		"Mail",
		"NewMailPush"
	},
	[23229] = {
		"Mail",
		"DeleteMailsPush"
	},
	[-2516] = {
		"Mail",
		"DeleteMailBatchRequest",
		"DeleteMailBatchReply"
	},
	[-22306] = {
		"Mail",
		"MarkMailJumpRequest",
		"MarkMailJumpReply"
	},
	[339] = {
		"Mail",
		"AutoReadMailPush"
	},
	[27872] = {
		"Mail",
		"MailLockRequest",
		"MailLockReply"
	},
	[1969] = {
		"Match3WarChess",
		"GetMatch3WarChessFacadeInfoRequest",
		"GetMatch3WarChessFacadeInfoReply"
	},
	[4715] = {
		"Match3WarChess",
		"StartMatch3WarChessInfoRequest",
		"StartMatch3WarChessInfoReply"
	},
	[5610] = {
		"Match3WarChess",
		"Match3ChessBoardSwapRequest",
		"Match3ChessBoardSwapReply"
	},
	[-12951] = {
		"Match3WarChess",
		"GetMatch3WarChessTaskRewardRequest",
		"GetMatch3WarChessTaskRewardReply"
	},
	[-27491] = {
		"Match3WarChess",
		"GetMatch3WarChessInfoRequest",
		"GetMatch3WarChessInfoReply"
	},
	[-30676] = {
		"Match3WarChess",
		"RefreshMatch3WarChessInfoRequest",
		"RefreshMatch3WarChessInfoReply"
	},
	[22389] = {
		"Material",
		"MaterialChangePush"
	},
	[25533] = {
		"Milestone",
		"GetMilestoneInfoRequest",
		"GetMilestoneInfoReply"
	},
	[-8328] = {
		"Milestone",
		"GetMilestoneBonusRequest",
		"GetMilestoneBonusReply"
	},
	[-32123] = {
		"NecrologistStory",
		"GetNecrologistStoryRequest",
		"GetNecrologistStoryReply"
	},
	[2792] = {
		"NecrologistStory",
		"UpdateNecrologistStoryRequest",
		"UpdateNecrologistStoryReply"
	},
	[-9909] = {
		"NecrologistStory",
		"FinishNecrologistStoryModeRequest",
		"FinishNecrologistStoryModeReply"
	},
	[23853] = {
		"Odyssey",
		"OdysseyGetInfoRequest",
		"OdysseyGetInfoReply"
	},
	[-176] = {
		"Odyssey",
		"OdysseyUpdateInfoPush"
	},
	[-31076] = {
		"Odyssey",
		"OdysseyUpdateLevelPush"
	},
	[21875] = {
		"Odyssey",
		"OdysseyHotfixRequest",
		"OdysseyHotfixReply"
	},
	[-18893] = {
		"Odyssey",
		"OdysseyHotfixPush"
	},
	[30961] = {
		"Odyssey",
		"OdysseyMapSetCurrElementRequest",
		"OdysseyMapSetCurrElementReply"
	},
	[-11399] = {
		"Odyssey",
		"OdysseyMapInteractRequest",
		"OdysseyMapInteractReply"
	},
	[31148] = {
		"Odyssey",
		"OdysseyMapUpdateElementPush"
	},
	[-28798] = {
		"Odyssey",
		"OdysseyMapUpdatePush"
	},
	[15809] = {
		"Odyssey",
		"OdysseyBagUpdateItemNewFlagRequest",
		"OdysseyBagUpdateItemNewFlagReply"
	},
	[5466] = {
		"Odyssey",
		"OdysseyBagGetItemPush"
	},
	[-25268] = {
		"Odyssey",
		"OdysseyTalentNodeLevelUpRequest",
		"OdysseyTalentNodeLevelUpReply"
	},
	[-9889] = {
		"Odyssey",
		"OdysseyTalentNodeLevelDownRequest",
		"OdysseyTalentNodeLevelDownReply"
	},
	[-17147] = {
		"Odyssey",
		"OdysseyTalentAllResetRequest",
		"OdysseyTalentAllResetReply"
	},
	[3540] = {
		"Odyssey",
		"OdysseyTalentCassandraTreeChoiceRequest",
		"OdysseyTalentCassandraTreeChoiceReply"
	},
	[-17233] = {
		"Odyssey",
		"OdysseyTalentCassandraTreeCancelRequest",
		"OdysseyTalentCassandraTreeCancelReply"
	},
	[30348] = {
		"Odyssey",
		"OdysseyTalentCassandraTreeResetRequest",
		"OdysseyTalentCassandraTreeResetReply"
	},
	[25238] = {
		"Odyssey",
		"OdysseyTalentPointUpdatePush"
	},
	[-21433] = {
		"Odyssey",
		"OdysseyFormSwitchRequest",
		"OdysseyFormSwitchReply"
	},
	[-13276] = {
		"Odyssey",
		"OdysseyFormSaveRequest",
		"OdysseyFormSaveReply"
	},
	[4418] = {
		"Odyssey",
		"OdysseyFightReligionDiscloseRequest",
		"OdysseyFightReligionDiscloseReply"
	},
	[-1721] = {
		"Odyssey",
		"OdysseyFightReligionMemberUpdatePush"
	},
	[30522] = {
		"Odyssey",
		"OdysseyFightMercenarySetDropRequest",
		"OdysseyFightMercenarySetDropReply"
	},
	[-6648] = {
		"Odyssey",
		"OdysseyFightMercenaryRefreshRequest",
		"OdysseyFightMercenaryRefreshReply"
	},
	[18204] = {
		"Odyssey",
		"OdysseyFightMercenaryUpdatePush"
	},
	[16804] = {
		"Odyssey",
		"OdysseyFightSettlePush"
	},
	[-2175] = {
		"Open",
		"GetOpenInfoRequest",
		"GetOpenInfoReply"
	},
	[-7688] = {
		"Open",
		"UpdateOpenPush"
	},
	[-30710] = {
		"PartyCloth",
		"GetPartyClothSummonPoolInfoRequest",
		"GetPartyClothSummonPoolInfoReply"
	},
	[5700] = {
		"PartyCloth",
		"SummonPartyClothRequest",
		"SummonPartyClothReply"
	},
	[6577] = {
		"PartyCloth",
		"GetPartyClothInfoRequest",
		"GetPartyClothInfoReply"
	},
	[9254] = {
		"PartyCloth",
		"GetPartyWearInfoRequest",
		"GetPartyWearInfoReply"
	},
	[-21721] = {
		"PartyCloth",
		"WearPartyClothsRequest",
		"WearPartyClothsReply"
	},
	[22600] = {
		"PartyCloth",
		"PartyClothHotfix1Request",
		"PartyClothHotfix1Reply"
	},
	[22601] = {
		"PartyCloth",
		"PartyClothHotfix2Request",
		"PartyClothHotfix2Reply"
	},
	[22602] = {
		"PartyCloth",
		"PartyClothHotfix3Request",
		"PartyClothHotfix3Reply"
	},
	[21256] = {
		"PartyCloth",
		"PartyClothHotfix1Push"
	},
	[21257] = {
		"PartyCloth",
		"PartyClothHotfix2Push"
	},
	[21258] = {
		"PartyCloth",
		"PartyClothHotfix3Push"
	},
	[22047] = {
		"PartyMatch",
		"MatchStatusPush"
	},
	[-27609] = {
		"PartyMatch",
		"MatchInfoPush"
	},
	[12311] = {
		"PartyMatch",
		"MatchFailPush"
	},
	[-12229] = {
		"PartyMatch",
		"SingleStartPartyMatchRequest",
		"SingleStartPartyMatchReply"
	},
	[-13639] = {
		"PartyMatch",
		"StartPartyMatchRequest",
		"StartPartyMatchReply"
	},
	[18481] = {
		"PartyMatch",
		"CancelPartyMatchRequest",
		"CancelPartyMatchReply"
	},
	[-25196] = {
		"PartyMatch",
		"PartyNeedLogoutPush"
	},
	[-6927] = {
		"PartyMatch",
		"TriggerPartyResultRequest",
		"TriggerPartyResultReply"
	},
	[-16527] = {
		"PartyMatch",
		"PartyServerListRequest",
		"PartyServerListReply"
	},
	[-1010] = {
		"PartyMatch",
		"PartyMatchHotfix1Request",
		"PartyMatchHotfix1Reply"
	},
	[-1009] = {
		"PartyMatch",
		"PartyMatchHotfix2Request",
		"PartyMatchHotfix2Reply"
	},
	[-1008] = {
		"PartyMatch",
		"PartyMatchHotfix3Request",
		"PartyMatchHotfix3Reply"
	},
	[27086] = {
		"PartyMatch",
		"PartyMatchHotfix1Push"
	},
	[27087] = {
		"PartyMatch",
		"PartyMatchHotfix2Push"
	},
	[27088] = {
		"PartyMatch",
		"PartyMatchHotfix3Push"
	},
	[-13257] = {
		"PartyOutSide",
		"GetPartyOutSideInfoRequest",
		"GetPartyOutSideInfoReply"
	},
	[10222] = {
		"PartyOutSide",
		"PartyOutSideHotfix1Request",
		"PartyOutSideHotfix1Reply"
	},
	[10223] = {
		"PartyOutSide",
		"PartyOutSideHotfix2Request",
		"PartyOutSideHotfix2Reply"
	},
	[10224] = {
		"PartyOutSide",
		"PartyOutSideHotfix3Request",
		"PartyOutSideHotfix3Reply"
	},
	[-31314] = {
		"PartyOutSide",
		"PartyOutSideHotfix1Push"
	},
	[-31313] = {
		"PartyOutSide",
		"PartyOutSideHotfix2Push"
	},
	[-31312] = {
		"PartyOutSide",
		"PartyOutSideHotfix3Push"
	},
	[-10945] = {
		"PartyRoom",
		"CreatePartyRoomRequest",
		"CreatePartyRoomReply"
	},
	[29845] = {
		"PartyRoom",
		"CheckPartyRoomInfoRequest",
		"CheckPartyRoomInfoReply"
	},
	[-8233] = {
		"PartyRoom",
		"GetPartyRoomInfoRequest",
		"GetPartyRoomInfoReply"
	},
	[-13696] = {
		"PartyRoom",
		"ClearAndRefreshPartyRoomInfoRequest",
		"ClearAndRefreshPartyRoomInfoReply"
	},
	[-13386] = {
		"PartyRoom",
		"UpdatePartyClientVersionRequest",
		"UpdatePartyClientVersionReply"
	},
	[22967] = {
		"PartyRoom",
		"ClearSuccessMatchInfoRequest",
		"ClearSuccessMatchInfoReply"
	},
	[26011] = {
		"PartyRoom",
		"JoinPartyRoomRequest",
		"JoinPartyRoomReply"
	},
	[-10827] = {
		"PartyRoom",
		"ChangePartyRoomStatusRequest",
		"ChangePartyRoomStatusReply"
	},
	[-6843] = {
		"PartyRoom",
		"ExitPartyRoomRequest",
		"ExitPartyRoomReply"
	},
	[-5236] = {
		"PartyRoom",
		"ChangeRoomOwnerRequest",
		"ChangeRoomOwnerReply"
	},
	[25541] = {
		"PartyRoom",
		"KickOutPlayerRequest",
		"KickOutPlayerReply"
	},
	[-18487] = {
		"PartyRoom",
		"GetInviteListRequest",
		"GetInviteListReply"
	},
	[-13599] = {
		"PartyRoom",
		"ResetPartyInviteStateRequest",
		"ResetPartyInviteStateReply"
	},
	[-12539] = {
		"PartyRoom",
		"InviteFriendRequest",
		"InviteFriendReply"
	},
	[26583] = {
		"PartyRoom",
		"RefuseInviteRequest",
		"RefuseInviteReply"
	},
	[29029] = {
		"PartyRoom",
		"PartyRoomInteractRequest",
		"PartyRoomInteractReply"
	},
	[-28454] = {
		"PartyRoom",
		"PartyRoomPosSyncRequest",
		"PartyRoomPosSyncReply"
	},
	[21689] = {
		"PartyRoom",
		"UploadPartyClothInfoRequest",
		"UploadPartyClothInfoReply"
	},
	[17209] = {
		"PartyRoom",
		"GetUploadPartyClothInfoPush"
	},
	[20126] = {
		"PartyRoom",
		"GetInteractionPush"
	},
	[-17203] = {
		"PartyRoom",
		"GetPosSyncPush"
	},
	[865] = {
		"PartyRoom",
		"GetKickedOutPush"
	},
	[-27523] = {
		"PartyRoom",
		"GetPartyInvitePush"
	},
	[24903] = {
		"PartyRoom",
		"GetPartyInviteRefusePush"
	},
	[-8218] = {
		"PartyRoom",
		"PartyRoomInfoPush"
	},
	[-5234] = {
		"PartyRoom",
		"PartyRoomHotfix1Request",
		"PartyRoomHotfix1Reply"
	},
	[-5233] = {
		"PartyRoom",
		"PartyRoomHotfix2Request",
		"PartyRoomHotfix2Reply"
	},
	[-5232] = {
		"PartyRoom",
		"PartyRoomHotfix3Request",
		"PartyRoomHotfix3Reply"
	},
	[6478] = {
		"PartyRoom",
		"PartyRoomHotfix1Push"
	},
	[6479] = {
		"PartyRoom",
		"PartyRoomHotfix2Push"
	},
	[6480] = {
		"PartyRoom",
		"PartyRoomHotfix3Push"
	},
	[20523] = {
		"PlayerCard",
		"GetPlayerCardInfoRequest",
		"GetPlayerCardInfoReply"
	},
	[6733] = {
		"PlayerCard",
		"GetOtherPlayerCardInfoRequest",
		"GetOtherPlayerCardInfoReply"
	},
	[-161] = {
		"PlayerCard",
		"PlayerCardInfoPush"
	},
	[12266] = {
		"PlayerCard",
		"SetPlayerCardShowSettingRequest",
		"SetPlayerCardShowSettingReply"
	},
	[-7074] = {
		"PlayerCard",
		"SetPlayerCardProgressSettingRequest",
		"SetPlayerCardProgressSettingReply"
	},
	[-1308] = {
		"PlayerCard",
		"SetPlayerCardBaseSettingRequest",
		"SetPlayerCardBaseSettingReply"
	},
	[-9736] = {
		"PlayerCard",
		"SetPlayerCardHeroCoverRequest",
		"SetPlayerCardHeroCoverReply"
	},
	[-20930] = {
		"PlayerCard",
		"SetPlayerCardThemeRequest",
		"SetPlayerCardThemeReply"
	},
	[25845] = {
		"PlayerCard",
		"SetPlayerCardShowAchievementRequest",
		"SetPlayerCardShowAchievementReply"
	},
	[18728] = {
		"PlayerCard",
		"SetPlayerCardCritterRequest",
		"SetPlayerCardCritterReply"
	},
	[6526] = {
		"PlayerCard",
		"SetPlayerCardBadgeRequest",
		"SetPlayerCardBadgeReply"
	},
	[14839] = {
		"Player",
		"GetPlayerInfoRequest",
		"GetPlayerInfoReply"
	},
	[9183] = {
		"Player",
		"CreatePlayerRequest",
		"CreatePlayerReply"
	},
	[9719] = {
		"Player",
		"PlayerInfoPush"
	},
	[-20970] = {
		"Player",
		"RenameRequest",
		"RenameReply"
	},
	[32124] = {
		"Player",
		"SetSignatureRequest",
		"SetSignatureReply"
	},
	[30017] = {
		"Player",
		"SetBirthdayRequest",
		"SetBirthdayReply"
	},
	[-2529] = {
		"Player",
		"SetPortraitRequest",
		"SetPortraitReply"
	},
	[27344] = {
		"Player",
		"SetShowHeroUniqueIdsRequest",
		"SetShowHeroUniqueIdsReply"
	},
	[-13331] = {
		"Player",
		"GetSimplePropertyRequest",
		"GetSimplePropertyReply"
	},
	[25593] = {
		"Player",
		"SetSimplePropertyRequest",
		"SetSimplePropertyReply"
	},
	[25325] = {
		"Player",
		"SimplePropertyPush"
	},
	[23876] = {
		"Player",
		"GetClothInfoRequest",
		"GetClothInfoReply"
	},
	[-2085] = {
		"Player",
		"ClothUpdatePush"
	},
	[9743] = {
		"Player",
		"ServerResultCodePush"
	},
	[-19751] = {
		"Player",
		"GetOtherPlayerInfoRequest",
		"GetOtherPlayerInfoReply"
	},
	[260] = {
		"Player",
		"SetCharacterAgeRequest",
		"SetCharacterAgeReply"
	},
	[-16517] = {
		"Player",
		"UseCdKeyRequset",
		"UseCdKeyReply"
	},
	[-2446] = {
		"Player",
		"MarkMainThumbnailRequest",
		"MarkMainThumbnailReply"
	},
	[10752] = {
		"Player",
		"SetPlayerBgRequest",
		"SetPlayerBgReply"
	},
	[7644] = {
		"Player",
		"GetAssistBonusRequest",
		"GetAssistBonusReply"
	},
	[14655] = {
		"Player",
		"ReceiveAssistBonusRequest",
		"ReceiveAssistBonusReply"
	},
	[-17678] = {
		"Player",
		"SetMainSceneSkinRequest",
		"SetMainSceneSkinReply"
	},
	[27886] = {
		"Player",
		"SetUiStyleSkinRequest",
		"SetUiStyleSkinReply"
	},
	[26644] = {
		"RedDot",
		"GetRedDotInfosRequest",
		"GetRedDotInfosReply"
	},
	[28651] = {
		"RedDot",
		"UpdateRedDotPush"
	},
	[-20810] = {
		"RedDot",
		"ShowRedDotRequest",
		"ShowRedDotReply"
	},
	[5590] = {
		"Rogue",
		"GetRogueStateRequest",
		"GetRogueStateReply"
	},
	[5808] = {
		"Rogue",
		"GetRogueInfoRequest",
		"GetRogueInfoReply"
	},
	[6838] = {
		"Rogue",
		"GetRogueScoreRewardRequest",
		"GetRogueScoreRewardReply"
	},
	[-26515] = {
		"Rogue",
		"AbortRogueRequest",
		"AbortRogueReply"
	},
	[-5549] = {
		"Rogue",
		"EnterRogueRequest",
		"EnterRogueReply"
	},
	[18725] = {
		"Rogue",
		"RogueEventStartRequest",
		"RogueEventStartReply"
	},
	[-12969] = {
		"Rogue",
		"RogueEventSelectRequest",
		"RogueEventSelectReply"
	},
	[29166] = {
		"Rogue",
		"RogueEventEndRequest",
		"RogueEventEndReply"
	},
	[20654] = {
		"Rogue",
		"RogueEventFightRewardRequest",
		"RogueEventFightRewardReply"
	},
	[-17373] = {
		"Rogue",
		"RogueEventCollectionRequest",
		"RogueEventCollectionReply"
	},
	[6792] = {
		"Rogue",
		"RogueGroupChangeRequest",
		"RogueGroupChangeReply"
	},
	[10989] = {
		"Rogue",
		"RogueGroupIdxChangeRequest",
		"RogueGroupIdxChangeReply"
	},
	[-6396] = {
		"Rogue",
		"RogueGroupStarUpgradeRequest",
		"RogueGroupStarUpgradeReply"
	},
	[12130] = {
		"Rogue",
		"RogueCollectionEnchantRequest",
		"RogueCollectionEnchantReply"
	},
	[-25535] = {
		"Rogue",
		"BuyRogueGoodsRequest",
		"BuyRogueGoodsReply"
	},
	[-8597] = {
		"Rogue",
		"RogueCollectionNewRequest",
		"RogueCollectionNewReply"
	},
	[-4314] = {
		"Rogue",
		"RogueReadEndingRequest",
		"RogueReadEndingReply"
	},
	[-23723] = {
		"Rogue",
		"RogueReturnRequest",
		"RogueReturnReply"
	},
	[-4746] = {
		"Rogue",
		"RogueStatePush"
	},
	[12225] = {
		"Rogue",
		"RogueInfoPush"
	},
	[9850] = {
		"Rogue",
		"RogueEventUpdatePush"
	},
	[24102] = {
		"Rogue",
		"RogueFightResultPush"
	},
	[21487] = {
		"Rogue",
		"RogueCollectionsPush"
	},
	[5032] = {
		"Rogue",
		"RogueTeamInfoPush"
	},
	[30781] = {
		"Rogue",
		"RogueGoodsInfoPush"
	},
	[-12130] = {
		"Rogue",
		"RogueCoinPush"
	},
	[-12224] = {
		"Rogue",
		"RogueCurrencyPush"
	},
	[-18551] = {
		"Rogue",
		"RogueHeartPush"
	},
	[-24180] = {
		"Rogue",
		"RogueEndPush"
	},
	[2145] = {
		"Rogue",
		"RogueCollectionGetPush"
	},
	[-7877] = {
		"Rogue",
		"RogueLifeChangePush"
	},
	[3693] = {
		"Rogue",
		"RogueCollectionUnlockPush"
	},
	[19031] = {
		"Room",
		"GetRoomInfoRequest",
		"GetRoomInfoReply"
	},
	[9263] = {
		"Room",
		"GetBlockPermanentInfoRequest",
		"GetBlockPermanentInfoReply"
	},
	[24678] = {
		"Room",
		"UseBlockRequest",
		"UseBlockReply"
	},
	[26478] = {
		"Room",
		"ResetRoomRequest",
		"ResetRoomReply"
	},
	[20681] = {
		"Room",
		"UseBuildingRequest",
		"UseBuildingReply"
	},
	[-25652] = {
		"Room",
		"UnUseBuildingRequest",
		"UnUseBuildingReply"
	},
	[22011] = {
		"Room",
		"BuildingGainPush"
	},
	[11304] = {
		"Room",
		"GetRoomObInfoRequest",
		"GetRoomObInfoReply"
	},
	[30905] = {
		"Room",
		"RoomConfirmRequest",
		"RoomConfirmReply"
	},
	[27427] = {
		"Room",
		"RoomRevertRequest",
		"RoomRevertReply"
	},
	[-14005] = {
		"Room",
		"StartProductionLineRequest",
		"StartProductionLineReply"
	},
	[-29380] = {
		"Room",
		"GainProductionLineRequest",
		"GainProductionLineReply"
	},
	[-2109] = {
		"Room",
		"FormulaGainPush"
	},
	[-8412] = {
		"Room",
		"ProductionLineLvUpRequest",
		"ProductionLineLvUpReply"
	},
	[4262] = {
		"Room",
		"ProductionLineAccelerateRequest",
		"ProductionLineAccelerateReply"
	},
	[-8438] = {
		"Room",
		"GetOtherRoomObInfoRequest",
		"GetOtherRoomObInfoReply"
	},
	[17896] = {
		"Room",
		"RoomLevelUpRequest",
		"RoomLevelUpReply"
	},
	[6697] = {
		"Room",
		"ProductionLineInfoRequest",
		"ProductionLineInfoReply"
	},
	[868] = {
		"Room",
		"BlockPackageGainPush"
	},
	[-24943] = {
		"Room",
		"GetBlockPackageInfoRequset",
		"GetBlockPackageInfoReply"
	},
	[-8792] = {
		"Room",
		"GetBuildingInfoRequest",
		"GetBuildingInfoReply"
	},
	[-11703] = {
		"Room",
		"UnUseBlockRequest",
		"UnUseBlockReply"
	},
	[-19082] = {
		"Room",
		"UpdateRoomHeroDataRequest",
		"UpdateRoomHeroDataReply"
	},
	[-16648] = {
		"Room",
		"HideBuildingReddotRequset",
		"HideBuildingReddotReply"
	},
	[19233] = {
		"Room",
		"HideBlockPackageReddotRequest",
		"HideBlockPackageReddotReply"
	},
	[729] = {
		"Room",
		"GainSpecialBlockPush"
	},
	[-26364] = {
		"Room",
		"GainRoomHeroFaithRequest",
		"GainRoomHeroFaithReply"
	},
	[-13534] = {
		"Room",
		"GetCharacterInteractionBonusRequest",
		"GetCharacterInteractionBonusReply"
	},
	[-32217] = {
		"Room",
		"GetCharacterInteractionInfoRequest",
		"GetCharacterInteractionInfoReply"
	},
	[18441] = {
		"Room",
		"StartCharacterInteractionRequest",
		"StartCharacterInteractionReply"
	},
	[-7919] = {
		"Room",
		"GetRoomThemeCollectionBonusRequest",
		"GetRoomThemeCollectionBonusReply"
	},
	[-1022] = {
		"Room",
		"GetRoomPlanInfoRequest",
		"GetRoomPlanInfoReply"
	},
	[28188] = {
		"Room",
		"GetRoomPlanDetailsRequest",
		"GetRoomPlanDetailsReply"
	},
	[-26910] = {
		"Room",
		"SetRoomPlanRequest",
		"SetRoomPlanReply"
	},
	[-22397] = {
		"Room",
		"SetRoomPlanNameRequest",
		"SetRoomPlanNameReply"
	},
	[32609] = {
		"Room",
		"SetRoomPlanCoverRequest",
		"SetRoomPlanCoverReply"
	},
	[21027] = {
		"Room",
		"UseRoomPlanRequest",
		"UseRoomPlanReply"
	},
	[-31192] = {
		"Room",
		"SwitchRoomPlanRequest",
		"SwitchRoomPlanReply"
	},
	[17449] = {
		"Room",
		"DeleteRoomPlanRequest",
		"DeleteRoomPlanReply"
	},
	[20691] = {
		"Room",
		"CopyOtherRoomPlanRequest",
		"CopyOtherRoomPlanReply"
	},
	[11134] = {
		"Room",
		"GetRoomShareRequest",
		"GetRoomShareReply"
	},
	[-20629] = {
		"Room",
		"UseRoomShareRequest",
		"UseRoomShareReply"
	},
	[18377] = {
		"Room",
		"ShareRoomPlanRequest",
		"ShareRoomPlanReply"
	},
	[-7631] = {
		"Room",
		"DeleteRoomShareRequest",
		"DeleteRoomShareReply"
	},
	[16295] = {
		"Room",
		"ReportRoomRequest",
		"ReportRoomReply"
	},
	[1881] = {
		"Room",
		"BuildingLevelUpPush"
	},
	[27999] = {
		"Room",
		"SetWaterTypeRequest",
		"SetWaterTypeReply"
	},
	[8868] = {
		"Room",
		"SetBlockColorRequest",
		"SetBlockColorReply"
	},
	[14540] = {
		"Room",
		"SetRoomSkinRequest",
		"SetRoomSkinReply"
	},
	[-20068] = {
		"Room",
		"ReadRoomSkinRequest",
		"ReadRoomSkinReply"
	},
	[21087] = {
		"Room",
		"GenerateRoadRequest",
		"GenerateRoadReply"
	},
	[31911] = {
		"Room",
		"DeleteRoadRequest",
		"DeleteRoadReply"
	},
	[-19129] = {
		"Room",
		"AllotCritterRequest",
		"AllotCritterReply"
	},
	[-16566] = {
		"Room",
		"AllotVehicleRequest",
		"AllotVehicleReply"
	},
	[26485] = {
		"Room",
		"GetManufactureInfoRequest",
		"GetManufactureInfoReply"
	},
	[24157] = {
		"Room",
		"GetFrozenItemInfoRequest",
		"GetFrozenItemInfoReply"
	},
	[-8345] = {
		"Room",
		"BuyManufactureBuildingRequest",
		"BuyManufactureBuildingInfoReply"
	},
	[9019] = {
		"Room",
		"DispatchCritterRequest",
		"DispatchCritterReply"
	},
	[-4843] = {
		"Room",
		"ManuBuildingUpgradeRequest",
		"ManuBuildingUpgradeReply"
	},
	[11426] = {
		"Room",
		"SelectSlotProductionPlanRequest",
		"SelectSlotProductionPlanReply"
	},
	[-28110] = {
		"Room",
		"ManufactureAccelerateRequest",
		"ManufactureAccelerateReply"
	},
	[-29511] = {
		"Room",
		"ReapFinishSlotRequest",
		"ReapFinishSlotReply"
	},
	[-3984] = {
		"Room",
		"BatchDispatchCrittersRequest",
		"BatchDispatchCrittersReply"
	},
	[7436] = {
		"Room",
		"RouseCrittersRequest",
		"RouseCrittersReply"
	},
	[11962] = {
		"Room",
		"BatchAddProctionsRequest",
		"BatchAddProctionsReply"
	},
	[-15511] = {
		"Room",
		"GainGuideBuildingRequest",
		"GainGuideBuildingReply"
	},
	[-18192] = {
		"Room",
		"AccelerateGuidePlanRequest",
		"AccelerateGuidePlanReply"
	},
	[-24167] = {
		"Room",
		"ManuBuildingInfoPush"
	},
	[27181] = {
		"Room",
		"BuyRestSlotRequest",
		"BuyRestSlotReply"
	},
	[29967] = {
		"Room",
		"ChangeRestCritterRequest",
		"ChangeRestCritterReply"
	},
	[2989] = {
		"Room",
		"UnloadRestBuildingCrittersRequest",
		"UnloadRestBuildingCrittersReply"
	},
	[9606] = {
		"Room",
		"ReplaceRestBuildingCrittersRequest",
		"ReplaceRestBuildingCrittersReply"
	},
	[16959] = {
		"Room",
		"FeedCritterRequest",
		"FeedCritterReply"
	},
	[-5323] = {
		"Room",
		"RestBuildingInfoPush"
	},
	[22400] = {
		"Room",
		"RoadInfoPush"
	},
	[-23690] = {
		"Room",
		"GetOrderInfoRequest",
		"GetOrderInfoReply"
	},
	[-25557] = {
		"Room",
		"FinishOrderRequest",
		"FinishOrderReply"
	},
	[2899] = {
		"Room",
		"LockOrderRequest",
		"LockOrderReply"
	},
	[-30668] = {
		"Room",
		"RefreshPurchaseOrderRequest",
		"RefreshPurchaseOrderReply"
	},
	[29723] = {
		"Room",
		"ChangePurchaseOrderTraceStateRequest",
		"ChangePurchaseOrderTraceStateReply"
	},
	[-10435] = {
		"Room",
		"GetTradeTaskInfoRequest",
		"GetTradeTaskInfoReply"
	},
	[-28361] = {
		"Room",
		"ReadNewTradeTaskRequest",
		"ReadNewTradeTaskReply"
	},
	[-19678] = {
		"Room",
		"GetTradeSupportBonusRequest",
		"GetTradeSupportBonusReply"
	},
	[17851] = {
		"Room",
		"TradeLevelUpRequest",
		"TradeLevelUpReply"
	},
	[-1903] = {
		"Room",
		"TradeTaskPush"
	},
	[-30500] = {
		"Room",
		"GetTradeTaskExtraBonusRequest",
		"GetTradeTaskExtraBonusReply"
	},
	[-17971] = {
		"Room",
		"GetRoomLogRequest",
		"GetRoomLogReply"
	},
	[15059] = {
		"Room",
		"ReadRoomLogNewRequest",
		"ReadRoomLogNewReply"
	},
	[-19643] = {
		"Rouge2",
		"GetRouge2InfoRequest",
		"GetRouge2InfoReply"
	},
	[4586] = {
		"Rouge2",
		"EnterRouge2SelectDifficultyRequest",
		"EnterRouge2SelectDifficultyReply"
	},
	[-19479] = {
		"Rouge2",
		"EnterRouge2SelectCareerRequest",
		"EnterRouge2SelectCareerReply"
	},
	[-28999] = {
		"Rouge2",
		"Rouge2AddCareerAttrPointRequest",
		"Rouge2AddCareerAttrPointReply"
	},
	[-10582] = {
		"Rouge2",
		"Rouge2EquipCareerActiveSkillRequest",
		"Rouge2EquipCareerActiveSkillReply"
	},
	[26872] = {
		"Rouge2",
		"Rouge2RoundMoveRequest",
		"Rouge2RoundMoveReply"
	},
	[-12494] = {
		"Rouge2",
		"Rouge2ChoiceEventRequest",
		"Rouge2ChoiceEventReply"
	},
	[23537] = {
		"Rouge2",
		"Rouge2BuyGoodsRequest",
		"Rouge2BuyGoodsReply"
	},
	[-28966] = {
		"Rouge2",
		"Rouge2StealGoodsRequest",
		"Rouge2StealGoodsReply"
	},
	[-27816] = {
		"Rouge2",
		"Rouge2EndShopEventRequest",
		"Rouge2EndShopEventReply"
	},
	[-7090] = {
		"Rouge2",
		"Rouge2ShopRefreshRequest",
		"Rouge2ShopRefreshReply"
	},
	[5502] = {
		"Rouge2",
		"Rouge2StealGoodsEnterFightRequest",
		"Rouge2StealGoodsEnterFightReply"
	},
	[4058] = {
		"Rouge2",
		"Rouge2SelectDropRequest",
		"Rouge2SelectDropReply"
	},
	[5609] = {
		"Rouge2",
		"Rouge2RefreshDropRequest",
		"Rouge2RefreshDropReply"
	},
	[31123] = {
		"Rouge2",
		"Rouge2SelectLostCollectionRequest",
		"Rouge2SelectLostCollectionReply"
	},
	[4370] = {
		"Rouge2",
		"Rouge2SelectBandMemberRequest",
		"Rouge2SelectBandMemberReply"
	},
	[-5580] = {
		"Rouge2",
		"Rouge2RemoveBandMemberRequest",
		"Rouge2RemoveBandMemberReply"
	},
	[21989] = {
		"Rouge2",
		"Rouge2EndBandRequest",
		"Rouge2EndBandReply"
	},
	[-9298] = {
		"Rouge2",
		"Rouge2EndCheckRequest",
		"Rouge2EndCheckReply"
	},
	[14503] = {
		"Rouge2",
		"Rouge2ReRollCheckRequest",
		"Rouge2ReRollCheckReply"
	},
	[-4728] = {
		"Rouge2",
		"Rouge2SelectUpdateCollectionRequest",
		"Rouge2SelectUpdateCollectionReply"
	},
	[-30080] = {
		"Rouge2",
		"Rouge2GainCareer1RewardRequest",
		"Rouge2GainCareer1RewardReply"
	},
	[5942] = {
		"Rouge2",
		"Rouge2PieceMoveRequest",
		"Rouge2PieceMoveReply"
	},
	[-10197] = {
		"Rouge2",
		"Rouge2PieceTalkSelectRequest",
		"Rouge2PieceTalkSelectReply"
	},
	[-24462] = {
		"Rouge2",
		"Rouge2LeaveMiddleLayerRequest",
		"Rouge2LeaveMiddleLayerReply"
	},
	[8624] = {
		"Rouge2",
		"Rouge2EndRequest",
		"Rouge2EndReply"
	},
	[-27375] = {
		"Rouge2",
		"Rouge2AbortRequest",
		"Rouge2AbortReply"
	},
	[9603] = {
		"Rouge2",
		"Rouge2MonsterFixAttrRequest",
		"Rouge2MonsterFixAttrReply"
	},
	[-25421] = {
		"Rouge2",
		"Rouge2SummonerActiveTalentRequest",
		"Rouge2SummonerActiveTalentReply"
	},
	[-2726] = {
		"Rouge2",
		"Rouge2SummonerResetTalentRequest",
		"Rouge2SummonerResetTalentReply"
	},
	[983] = {
		"Rouge2",
		"Rouge2SetSystemIdRequest",
		"Rouge2SetSystemIdReply"
	},
	[15354] = {
		"Rouge2",
		"Rouge2GainCareerAttrDropRequest",
		"Rouge2GainCareerAttrDropReply"
	},
	[22080] = {
		"Rouge2",
		"Rouge2LayerMapInfoPush"
	},
	[-31227] = {
		"Rouge2",
		"Rouge2UpdateCoinPush"
	},
	[-7426] = {
		"Rouge2",
		"Rouge2UpdateRevivalCoinPush"
	},
	[4698] = {
		"Rouge2",
		"Rouge2EntrustInfoPush"
	},
	[-11355] = {
		"Rouge2",
		"Rouge2InfoPush"
	},
	[18755] = {
		"Rouge2",
		"Rouge2CheckInfoPush"
	},
	[21431] = {
		"Rouge2",
		"Rouge2AttrUpdatePush"
	},
	[8096] = {
		"Rouge2",
		"Rouge2BagItemRemovePush"
	},
	[-29099] = {
		"Rouge2",
		"Rouge2BagItemUpdatePush"
	},
	[-28769] = {
		"Rouge2Outside",
		"GetRouge2OutsideInfoRequest",
		"GetRouge2OutsideInfoReply"
	},
	[17597] = {
		"Rouge2Outside",
		"Rouge2ActiveGeniusRequest",
		"Rouge2ActiveGeniusReply"
	},
	[-31205] = {
		"Rouge2Outside",
		"Rouge2RewardRequest",
		"Rouge2RewardReply"
	},
	[31420] = {
		"Rouge2Outside",
		"Rouge2UpdateRewardPointPush"
	},
	[5113] = {
		"Rouge2Outside",
		"Rouge2AlchemyRequest",
		"Rouge2AlchemyReply"
	},
	[-20225] = {
		"Rouge2Outside",
		"Rouge2CancelAlchemyRequest",
		"Rouge2CancelAlchemyReply"
	},
	[16545] = {
		"Rouge2Outside",
		"Rouge2GetUnlockCollectionsRequest",
		"Rouge2GetUnlockCollectionsReply"
	},
	[30370] = {
		"Rouge2Outside",
		"Rouge2UpdateGeniusPointPush"
	},
	[16362] = {
		"Rouge2Outside",
		"Rouge2SaveContextRequest",
		"Rouge2SaveContextReply"
	},
	[-32592] = {
		"Rouge2Outside",
		"Rouge2ChoiceSaveRequest",
		"Rouge2ChoiceSaveReply"
	},
	[22226] = {
		"Rouge2Outside",
		"Rouge2BossRewardRequest",
		"Rouge2BossRewardReply"
	},
	[-7647] = {
		"Rouge",
		"GetRougeInfoRequest",
		"GetRougeInfoReply"
	},
	[-23930] = {
		"Rouge",
		"EnterRougeSelectDifficultyRequest",
		"EnterRougeSelectDifficultyReply"
	},
	[-14216] = {
		"Rouge",
		"EnterRougeSelectRewardRequest",
		"EnterRougeSelectRewardReply"
	},
	[29092] = {
		"Rouge",
		"EnterRougeSelectStyleRequest",
		"EnterRougeSelectStyleReply"
	},
	[-20935] = {
		"Rouge",
		"EnterRougeSelectHeroesRequest",
		"EnterRougeSelectHeroesReply"
	},
	[19976] = {
		"Rouge",
		"RougeGroupChangeRequest",
		"RougeGroupChangeReply"
	},
	[-21985] = {
		"Rouge",
		"RougeMonsterFixAttrRequest",
		"RougeMonsterFixAttrReply"
	},
	[-25580] = {
		"Rouge",
		"RougeRoundMoveRequest",
		"RougeRoundMoveReply"
	},
	[25184] = {
		"Rouge",
		"RougeChoiceEventRequest",
		"RougeChoiceEventReply"
	},
	[3551] = {
		"Rouge",
		"RougeBuyGoodsRequest",
		"RougeBuyGoodsReply"
	},
	[-29626] = {
		"Rouge",
		"RougeEndShopEventRequest",
		"RougeEndShopEventReply"
	},
	[30588] = {
		"Rouge",
		"RougeShopRefreshRequest",
		"RougeShopRefreshReply"
	},
	[-2744] = {
		"Rouge",
		"RougeSelectDropRequest",
		"RougeSelectDropReply"
	},
	[25309] = {
		"Rouge",
		"RougeRandomDropRequest",
		"RougeRandomDropReply"
	},
	[-4691] = {
		"Rouge",
		"RougeSelectHealRequest",
		"RougeSelectHealReply"
	},
	[10756] = {
		"Rouge",
		"RougeSelectReviveRequest",
		"RougeSelectReviveReply"
	},
	[-21377] = {
		"Rouge",
		"RougeRecruitHeroRequest",
		"RougeRecruitHeroReply"
	},
	[-32639] = {
		"Rouge",
		"RougeSelectLostCollectionRequest",
		"RougeSelectLostCollectionReply"
	},
	[22716] = {
		"Rouge",
		"RougeSelectCollectionLevelUpRequest",
		"RougeSelectCollectionLevelUpReply"
	},
	[19026] = {
		"Rouge",
		"RougePieceMoveRequest",
		"RougePieceMoveReply"
	},
	[18917] = {
		"Rouge",
		"RougePieceTalkSelectRequest",
		"RougePieceTalkSelectReply"
	},
	[18796] = {
		"Rouge",
		"RougeLeaveMiddleLayerRequest",
		"RougeLeaveMiddleLayerReply"
	},
	[-2848] = {
		"Rouge",
		"RougeRepairShopBuyRequest",
		"RougeRepairShopBuyReply"
	},
	[-26415] = {
		"Rouge",
		"RougeRepairShopRandomRequest",
		"RougeRepairShopRandomReply"
	},
	[27332] = {
		"Rouge",
		"RougeDisplaceRequest",
		"RougeDisplaceReply"
	},
	[12236] = {
		"Rouge",
		"RougeEndRequest",
		"RougeEndReply"
	},
	[-26067] = {
		"Rouge",
		"RougeAbortRequest",
		"RougeAbortReply"
	},
	[6807] = {
		"Rouge",
		"ActiveTalentRequest",
		"ActiveTalentReply"
	},
	[5407] = {
		"Rouge",
		"RougeUseMapSkillRequest",
		"RougeUseMapSkillReply"
	},
	[19136] = {
		"Rouge",
		"RougeUnlockSkillRequest",
		"RougeUnlockSkillReply"
	},
	[7450] = {
		"Rouge",
		"RougeRefreshMapRuleRequest",
		"RougeRefreshMapRuleReply"
	},
	[30052] = {
		"Rouge",
		"RougeRefreshMonsterRuleRequest",
		"RougeRefreshMonsterRuleReply"
	},
	[6650] = {
		"Rouge",
		"RougeEventUpdatePush"
	},
	[-25942] = {
		"Rouge",
		"RougeSelectDropPush"
	},
	[29148] = {
		"Rouge",
		"RougeLayerMapInfoPush"
	},
	[31302] = {
		"Rouge",
		"RougeLayerSimpleMapInfoPush"
	},
	[2721] = {
		"Rouge",
		"RougeUpdateCoinPush"
	},
	[549] = {
		"Rouge",
		"RougeUpdatePowerPush"
	},
	[2090] = {
		"Rouge",
		"RougeUpdateTalentPointPush"
	},
	[-17289] = {
		"Rouge",
		"RougeUpdateTeamExpAndLevelPush"
	},
	[20902] = {
		"Rouge",
		"RougeFightResultPush"
	},
	[29500] = {
		"Rouge",
		"RougeInMapItemUpdatePush"
	},
	[-30985] = {
		"Rouge",
		"RougeTeamHpUpdatePush"
	},
	[26581] = {
		"Rouge",
		"RougeInteractiveTeamHpUpdatePush"
	},
	[-18648] = {
		"Rouge",
		"RougeTeamInfoPush"
	},
	[10870] = {
		"Rouge",
		"RougeEntrustInfoPush"
	},
	[3606] = {
		"Rouge",
		"RougeTriggerEffectPush"
	},
	[4929] = {
		"Rouge",
		"RougeInfoPush"
	},
	[4939] = {
		"Rouge",
		"RougeComposeRequest",
		"RougeComposeReply"
	},
	[-7214] = {
		"Rouge",
		"RougeInlayRequest",
		"RougeInlayReply"
	},
	[18001] = {
		"Rouge",
		"RougeDemountRequest",
		"RougeDemountReply"
	},
	[19030] = {
		"Rouge",
		"RougeAddToBarRequest",
		"RougeAddToBarReply"
	},
	[20737] = {
		"Rouge",
		"RougeOneKeyAddToBarRequest",
		"RougeOneKeyAddToBarReply"
	},
	[12588] = {
		"Rouge",
		"RougeRemoveFromBarRequest",
		"RougeRemoveFromBarReply"
	},
	[6839] = {
		"Rouge",
		"RougeOneKeyRemoveFromBarRequest",
		"RougeOneKeyRemoveFromBarReply"
	},
	[21993] = {
		"Rouge",
		"RougeItemTrammelsRequest",
		"RougeItemTrammelsReply"
	},
	[22094] = {
		"Rouge",
		"RougeItemBagPush"
	},
	[26711] = {
		"Rouge",
		"RougeAddItemBagPush"
	},
	[-28452] = {
		"Rouge",
		"RougeRemoveItemBagPush"
	},
	[-24169] = {
		"Rouge",
		"RougeItemWarehousePush"
	},
	[22112] = {
		"Rouge",
		"RougeAddItemWarehousePush"
	},
	[3749] = {
		"Rouge",
		"RougeRemoveItemWarehousePush"
	},
	[-11470] = {
		"Rouge",
		"RougeItemLayoutEffectUpdatePush"
	},
	[-23961] = {
		"Rouge",
		"RougeItemUpdatePush"
	},
	[-19930] = {
		"Rouge",
		"RougeItemEffectChangeItemPush"
	},
	[26523] = {
		"RougeOutside",
		"GetRougeOutsideInfoRequest",
		"GetRougeOutsideInfoReply"
	},
	[-15623] = {
		"RougeOutside",
		"RougeActiveGeniusRequest",
		"RougeActiveGeniusReply"
	},
	[-19194] = {
		"RougeOutside",
		"RougeReceivePointBonusRequest",
		"RougeReceivePointBonusReply"
	},
	[-28578] = {
		"RougeOutside",
		"RougeUpdateGeniusPointPush"
	},
	[-13485] = {
		"RougeOutside",
		"RougeUpdatePointPush"
	},
	[-2746] = {
		"RougeOutside",
		"RougeMarkGeniusNewStageRequest",
		"RougeMarkGeniusNewStageReply"
	},
	[-24318] = {
		"RougeOutside",
		"RougeMarkBonusNewStageRequest",
		"RougeMarkBonusNewStageReply"
	},
	[15084] = {
		"RougeOutside",
		"RougeGetUnlockCollectionsRequest",
		"RougeGetUnlockCollectionsReply"
	},
	[-21878] = {
		"RougeOutside",
		"RougeGetNewReddotInfoRequest",
		"RougeGetNewReddotInfoReply"
	},
	[26217] = {
		"RougeOutside",
		"RougeMarkNewReddotRequest",
		"RougeMarkNewReddotReply"
	},
	[-885] = {
		"RougeOutside",
		"RougeReddotUpdatePush"
	},
	[15135] = {
		"RougeOutside",
		"RougeUnlockStoryRequest",
		"RougeUnlockStoryReply"
	},
	[-24907] = {
		"RougeOutside",
		"RougeLimiterSettingSaveRequest",
		"RougeLimiterSettingSaveReply"
	},
	[3058] = {
		"RougeOutside",
		"RougeDLCSettingSaveRequest",
		"RougeDLCSettingSaveReply"
	},
	[25271] = {
		"RougeOutside",
		"RougeLimiterUnlockBuffRequest",
		"RougeLimiterUnlockBuffReply"
	},
	[-23096] = {
		"RougeOutside",
		"RougeLimiterSpeedUpBuffCdRequest",
		"RougeLimiterSpeedUpBuffCdReply"
	},
	[23929] = {
		"SiegeBattle",
		"GetSiegeBattleInfoRequest",
		"GetSiegeBattleInfoReply"
	},
	[23153] = {
		"SiegeBattle",
		"StartSiegeBattleRequest",
		"StartSiegeBattleReply"
	},
	[1942] = {
		"SiegeBattle",
		"AbandonSiegeBattleRequest",
		"AbandonSiegeBattleReply"
	},
	[-13395] = {
		"SignIn",
		"GetSignInInfoRequest",
		"GetSignInInfoReply"
	},
	[-29407] = {
		"SignIn",
		"SignInRequest",
		"SignInReply"
	},
	[-20145] = {
		"SignIn",
		"SignInAddupRequest",
		"SignInAddupReply"
	},
	[-23661] = {
		"SignIn",
		"SignInHistoryRequest",
		"SignInHistoryReply"
	},
	[18942] = {
		"SignIn",
		"GetHeroBirthdayRequest",
		"GetHeroBirthdayReply"
	},
	[-2166] = {
		"SignIn",
		"SignInTotalRewardRequest",
		"SignInTotalRewardReply"
	},
	[28419] = {
		"SignIn",
		"SignInTotalRewardAllRequest",
		"SignInTotalRewardAllReply"
	},
	[-24282] = {
		"SignIn",
		"SupplementMonthCardRequest",
		"SupplementMonthCardReply"
	},
	[30499] = {
		"SodacheInside",
		"SodacheInsideEnterSceneRequest",
		"SodacheInsideEnterSceneReply"
	},
	[-16985] = {
		"SodacheInside",
		"SodacheInsideBuyRequest",
		"SodacheInsideBuyReply"
	},
	[32105] = {
		"SodacheInside",
		"SodacheInsideBatchBuyRequest",
		"SodacheInsideBatchBuyReply"
	},
	[32679] = {
		"SodacheInside",
		"SodacheInsideSellRequest",
		"SodacheInsideSellReply"
	},
	[-6459] = {
		"SodacheInside",
		"SodacheInsideGetSceneRequest",
		"SodacheInsideGetSceneReply"
	},
	[19478] = {
		"SodacheInside",
		"SodacheInsideSceneOperationRequest",
		"SodacheInsideSceneOperationReply"
	},
	[6136] = {
		"SodacheInside",
		"SodacheInsideAbandonSceneRequest",
		"SodacheInsideAbandonSceneReply"
	},
	[-26453] = {
		"SodacheInside",
		"SodacheInsideSubmitMaterialSettleRequest",
		"SodacheInsideSubmitMaterialSettleReply"
	},
	[-11017] = {
		"SodacheInside",
		"SodacheInsideSceneFinishSettlePush"
	},
	[20413] = {
		"SodacheInside",
		"SodacheInsideClosePanelRequest",
		"SodacheInsideClosePanelReply"
	},
	[-2982] = {
		"SodacheInside",
		"SodacheInsideHotfix1Request",
		"SodacheInsideHotfix1Reply"
	},
	[-2981] = {
		"SodacheInside",
		"SodacheInsideHotfix2Request",
		"SodacheInsideHotfix2Reply"
	},
	[-2980] = {
		"SodacheInside",
		"SodacheInsideHotfix3Request",
		"SodacheInsideHotfix3Reply"
	},
	[-14193] = {
		"SodacheInside",
		"SodacheInsideStatisticPush"
	},
	[-18705] = {
		"SodacheInside",
		"SodacheInsideStatisticGetRequest",
		"SodacheInsideStatisticGetReply"
	},
	[-31417] = {
		"SodacheOutside",
		"SodacheOutsideGetSceneRequest",
		"SodacheOutsideGetSceneReply"
	},
	[32690] = {
		"SodacheOutside",
		"SodacheBuildingUpgradeRequest",
		"SodacheBuildingUpgradeReply"
	},
	[-20173] = {
		"SodacheOutside",
		"SodacheRelicUpgradeRequest",
		"SodacheRelicUpgradeReply"
	},
	[20222] = {
		"SodacheOutside",
		"SodacheRelicOneKeyUpgradeRequest",
		"SodacheRelicOneKeyUpgradeReply"
	},
	[22985] = {
		"SodacheOutside",
		"SodacheBagUpdatePush"
	},
	[8504] = {
		"SodacheOutside",
		"SodacheStepPush"
	},
	[-17449] = {
		"SodacheOutside",
		"SodacheAttrPush"
	},
	[2579] = {
		"SodacheOutside",
		"SodacheTaskGainRewardRequest",
		"SodacheTaskGainRewardReply"
	},
	[-7742] = {
		"SodacheOutside",
		"SodacheTaskAbandonRequest",
		"SodacheTaskAbandonReply"
	},
	[4959] = {
		"SodacheOutside",
		"SodacheTaskAcceptRequest",
		"SodacheTaskAcceptReply"
	},
	[15491] = {
		"SodacheOutside",
		"SodacheTaskSubmitRequest",
		"SodacheTaskSubmitReply"
	},
	[-13668] = {
		"SodacheOutside",
		"SodacheOutsideHotfix1Request",
		"SodacheOutsideHotfix1Reply"
	},
	[-13667] = {
		"SodacheOutside",
		"SodacheOutsideHotfix2Request",
		"SodacheOutsideHotfix2Reply"
	},
	[-13666] = {
		"SodacheOutside",
		"SodacheOutsideHotfix3Request",
		"SodacheOutsideHotfix3Reply"
	},
	[-28177] = {
		"Stat",
		"ClientStatBaseInfoRequest",
		"ClientStatBaseInfoReply"
	},
	[-10251] = {
		"Stat",
		"StatInfoPush"
	},
	[-30158] = {
		"Stat",
		"UpdateClientStatBaseInfoRequest",
		"UpdateClientStatBaseInfoReply"
	},
	[-26134] = {
		"Store",
		"GetStoreInfosRequest",
		"GetStoreInfosReply"
	},
	[26890] = {
		"Store",
		"BuyGoodsRequest",
		"BuyGoodsReply"
	},
	[-9423] = {
		"Store",
		"ReadStoreNewRequest",
		"ReadStoreNewReply"
	},
	[-19309] = {
		"Story",
		"GetStoryRequest",
		"GetStoryReply"
	},
	[9590] = {
		"Story",
		"UpdateStoryRequest",
		"UpdateStoryReply"
	},
	[-8364] = {
		"Story",
		"GetStoryFinishRequest",
		"GetStoryFinishReply"
	},
	[16980] = {
		"Story",
		"StoryFinishPush"
	},
	[11695] = {
		"Summon",
		"SummonRequest",
		"SummonReply"
	},
	[-16421] = {
		"Summon",
		"GetSummonInfoRequest",
		"GetSummonInfoReply"
	},
	[-7898] = {
		"Summon",
		"SummonQueryTokenRequest",
		"SummonQueryTokenReply"
	},
	[24404] = {
		"Summon",
		"OpenLuckyBagRequest",
		"OpenLuckyBagReply"
	},
	[22095] = {
		"Summon",
		"ChooseMultiUpHeroRequest",
		"ChooseMultiUpHeroReply"
	},
	[4911] = {
		"Summon",
		"ChooseEnhancedPoolHeroRequest",
		"ChooseEnhancedPoolHeroReply"
	},
	[-3044] = {
		"Summon",
		"GetSummonProgressRewardsRequest",
		"GetSummonProgressRewardsReply"
	},
	[-21980] = {
		"Summon",
		"SelectSummonchoosableRewardRequest",
		"SelectSummonchoosableRewardReply"
	},
	[-5258] = {
		"Summon",
		"PopUpRecommendWindowRequest",
		"PopUpRecommendWindowReply"
	},
	[-7135] = {
		"Summon",
		"InfallibleSummonRequest",
		"InfallibleSummonReply"
	},
	[-14893] = {
		"SurvivalInterior",
		"EnterSurvivalRequest",
		"EnterSurvivalReply"
	},
	[15540] = {
		"SurvivalInterior",
		"SurvivalSceneOperationRequest",
		"SurvivalSceneOperationReply"
	},
	[21447] = {
		"SurvivalInterior",
		"SurvivalUpdateClientDataRequest",
		"SurvivalUpdateClientDataReply"
	},
	[-9172] = {
		"SurvivalInterior",
		"SurvivalSceneOperationLogRequest",
		"SurvivalSceneOperationLogReply"
	},
	[2321] = {
		"SurvivalInterior",
		"SurvivalUseItemRequest",
		"SurvivalUseItemReply"
	},
	[11667] = {
		"SurvivalInterior",
		"SurvivalSceneGiveUpRequest",
		"SurvivalSceneGiveUpReply"
	},
	[-13194] = {
		"SurvivalInterior",
		"SurvivalSceneOperationLogPush"
	},
	[-7141] = {
		"SurvivalInterior",
		"SurvivalTaskFollowRequest",
		"SurvivalTaskFollowReply"
	},
	[32442] = {
		"SurvivalInterior",
		"SurvivalSceneEndPush"
	},
	[-6780] = {
		"SurvivalInterior",
		"SurvivalDailyReportPush"
	},
	[-12765] = {
		"SurvivalInterior",
		"SurvivalAddMessageRequest",
		"SurvivalAddMessageReply"
	},
	[2475] = {
		"SurvivalInterior",
		"SurvivalMessageOperationRequest",
		"SurvivalMessageOperationReply"
	},
	[-6688] = {
		"SurvivalInterior",
		"SurvivalEditMessageRequest",
		"SurvivalEditMessageReply"
	},
	[-27430] = {
		"SurvivalInterior",
		"SurvivalMessagePush"
	},
	[-1037] = {
		"SurvivalInterior",
		"SurvivalUseRoleSkillRequest",
		"SurvivalUseRoleSkillReply"
	},
	[28582] = {
		"SurvivalInterior",
		"SurvivalSceneHotfix1Request",
		"SurvivalSceneHotfix1Reply"
	},
	[28583] = {
		"SurvivalInterior",
		"SurvivalSceneHotfix2Request",
		"SurvivalSceneHotfix2Reply"
	},
	[28584] = {
		"SurvivalInterior",
		"SurvivalSceneHotfix3Request",
		"SurvivalSceneHotfix3Reply"
	},
	[-5786] = {
		"SurvivalInterior",
		"SurvivalSceneHotfix1Push"
	},
	[-5785] = {
		"SurvivalInterior",
		"SurvivalSceneHotfix2Push"
	},
	[-5784] = {
		"SurvivalInterior",
		"SurvivalSceneHotfix3Push"
	},
	[-5489] = {
		"SurvivalOutSide",
		"SurvivalOutSideGetInfoRequest",
		"SurvivalOutSideGetInfoReply"
	},
	[2465] = {
		"SurvivalOutSide",
		"SurvivalMarkNewHandbookRequest",
		"SurvivalMarkNewHandbookReply"
	},
	[30471] = {
		"SurvivalOutSide",
		"SurvivalOutSideGainRewardRequest",
		"SurvivalOutSideGainRewardReply"
	},
	[4684] = {
		"SurvivalOutSide",
		"SurvivalHandbookPush"
	},
	[-11044] = {
		"SurvivalOutSide",
		"SurvivalSurvivalOutSideClientDataRequest",
		"SurvivalSurvivalOutSideClientDataReply"
	},
	[-18477] = {
		"SurvivalOutSide",
		"SurvivalOutSideTechUnlockRequest",
		"SurvivalOutSideTechUnlockReply"
	},
	[19978] = {
		"SurvivalOutSide",
		"SurvivalOutSideTechResetRequest",
		"SurvivalOutSideTechResetReply"
	},
	[-22146] = {
		"SurvivalOutSide",
		"SurvivalMarkRoleNotNewRequest",
		"SurvivalMarkRoleNotNewReply"
	},
	[-21876] = {
		"SurvivalOutSide",
		"SurvivalMarkModNotNewRequest",
		"SurvivalMarkModNotNewReply"
	},
	[5293] = {
		"SurvivalOutSide",
		"SurvivalOutsideShopBuyRequest",
		"SurvivalOutsideShopBuyReply"
	},
	[726] = {
		"SurvivalWeek",
		"SurvivalAttrContainerUpdatePush"
	},
	[-15458] = {
		"SurvivalWeek",
		"SurvivalDerivedContainerUpdatePush"
	},
	[-6272] = {
		"SurvivalWeek",
		"SurvivalRemoveBagItemRequest",
		"SurvivalRemoveBagItemReply"
	},
	[-29978] = {
		"SurvivalWeek",
		"SurvivalBagUpdatePush"
	},
	[-28092] = {
		"SurvivalWeek",
		"SurvivalItemTipsPush"
	},
	[14795] = {
		"SurvivalWeek",
		"SurvivalTaskUpdatePush"
	},
	[7501] = {
		"SurvivalWeek",
		"SurvivalReceiveTaskRewardRequest",
		"SurvivalReceiveTaskRewardReply"
	},
	[29901] = {
		"SurvivalWeek",
		"SurvivalStartWeekChooseDiffRequest",
		"SurvivalStartWeekChooseDiffReply"
	},
	[5063] = {
		"SurvivalWeek",
		"SurvivalChooseBootyRequest",
		"SurvivalChooseBootyReply"
	},
	[13041] = {
		"SurvivalWeek",
		"SurvivalGetWeekInfoRequest",
		"SurvivalGetWeekInfoReply"
	},
	[10008] = {
		"SurvivalWeek",
		"SurvivalAbandonWeekRequest",
		"SurvivalAbandonWeekReply"
	},
	[-5262] = {
		"SurvivalWeek",
		"SurvivalSettleWeekPush"
	},
	[-24627] = {
		"SurvivalWeek",
		"SurvivalWeekInfoPush"
	},
	[12677] = {
		"SurvivalWeek",
		"SurvivalBuildRequest",
		"SurvivalBuildReply"
	},
	[3352] = {
		"SurvivalWeek",
		"SurvivalRepairRequest",
		"SurvivalRepairReply"
	},
	[30653] = {
		"SurvivalWeek",
		"SurvivalUpgradeRequest",
		"SurvivalUpgradeReply"
	},
	[8917] = {
		"SurvivalWeek",
		"SurvivalNpcChangePositionRequest",
		"SurvivalNpcChangePositionReply"
	},
	[15762] = {
		"SurvivalWeek",
		"SurvivalNpcExchangePositionRequest",
		"SurvivalNpcExchangePositionReply"
	},
	[17124] = {
		"SurvivalWeek",
		"SurvivalBatchHeroChangePositionRequest",
		"SurvivalBatchHeroChangePositionReply"
	},
	[23074] = {
		"SurvivalWeek",
		"SurvivalHeroChangePositionRequest",
		"SurvivalHeroChangePositionReply"
	},
	[31775] = {
		"SurvivalWeek",
		"SurvivalHeroExchangePositionRequest",
		"SurvivalHeroExchangePositionReply"
	},
	[29926] = {
		"SurvivalWeek",
		"SurvivalBuildingUpdatePush"
	},
	[-22711] = {
		"SurvivalWeek",
		"SurvivalGetEquipInfoRequest",
		"SurvivalGetEquipInfoReply"
	},
	[12602] = {
		"SurvivalWeek",
		"SurvivalEquipSwitchPlanRequest",
		"SurvivalEquipSwitchPlanReply"
	},
	[-26420] = {
		"SurvivalWeek",
		"SurvivalEquipWearRequest",
		"SurvivalEquipWearReply"
	},
	[29753] = {
		"SurvivalWeek",
		"SurvivalEquipDemountRequest",
		"SurvivalEquipDemountReply"
	},
	[-28681] = {
		"SurvivalWeek",
		"SurvivalEquipOneKeyWearRequest",
		"SurvivalEquipOneKeyWearReply"
	},
	[-24700] = {
		"SurvivalWeek",
		"SurvivalEquipOneKeyDemountRequest",
		"SurvivalEquipOneKeyDemountReply"
	},
	[29090] = {
		"SurvivalWeek",
		"SurvivalEquipCompoundRequest",
		"SurvivalEquipCompoundReply"
	},
	[-23251] = {
		"SurvivalWeek",
		"SurvivalEquipSetNewFlagRequest",
		"SurvivalEquipSetNewFlagReply"
	},
	[-31474] = {
		"SurvivalWeek",
		"SurvivalJewelryEquipWearRequest",
		"SurvivalJewelryEquipWearReply"
	},
	[4411] = {
		"SurvivalWeek",
		"SurvivalJewelryEquipDemountRequest",
		"SurvivalJewelryEquipDemountReply"
	},
	[-17732] = {
		"SurvivalWeek",
		"SurvivalEquipUpdatePush"
	},
	[-25510] = {
		"SurvivalWeek",
		"SurvivalIntrudeExterminateRequest",
		"SurvivalIntrudeExterminateReply"
	},
	[-11279] = {
		"SurvivalWeek",
		"SurvivalIntrudeReExterminateRequest",
		"SurvivalIntrudeReExterminateReply"
	},
	[12621] = {
		"SurvivalWeek",
		"SurvivalIntrudeAbandonExterminateRequest",
		"SurvivalIntrudeAbandonExterminateReply"
	},
	[9079] = {
		"SurvivalWeek",
		"SurvivalIntrudeFightSettlePush"
	},
	[-3930] = {
		"SurvivalWeek",
		"SurvivalHeroUpdatePush"
	},
	[19158] = {
		"SurvivalWeek",
		"SurvivalPanelOperationRequest",
		"SurvivalPanelOperationReply"
	},
	[3675] = {
		"SurvivalWeek",
		"SurvivalClosePanelRequest",
		"SurvivalClosePanelReply"
	},
	[12702] = {
		"SurvivalWeek",
		"SurvivalRefreshRecruitTagRequest",
		"SurvivalRefreshRecruitTagReply"
	},
	[-7962] = {
		"SurvivalWeek",
		"SurvivalPublishRecruitTagRequest",
		"SurvivalPublishRecruitTagReply"
	},
	[5140] = {
		"SurvivalWeek",
		"SurvivalRecruitNpcRequest",
		"SurvivalRecruitNpcReply"
	},
	[23431] = {
		"SurvivalWeek",
		"SurvivalAbandonRecruitNpcRequest",
		"SurvivalAbandonRecruitNpcReply"
	},
	[6079] = {
		"SurvivalWeek",
		"SurvivalRecruitInfoPush"
	},
	[19423] = {
		"SurvivalWeek",
		"SurvivalShopSellRequest",
		"SurvivalShopSellReply"
	},
	[-7442] = {
		"SurvivalWeek",
		"SurvivalShopBuyRequest",
		"SurvivalShopBuyReply"
	},
	[-5201] = {
		"SurvivalWeek",
		"SurvivalShopUpdatePush"
	},
	[23641] = {
		"SurvivalWeek",
		"SurvivalNpcAcceptTaskRequest",
		"SurvivalNpcAcceptTaskReply"
	},
	[12799] = {
		"SurvivalWeek",
		"SurvivalNpcBoxPush"
	},
	[8997] = {
		"SurvivalWeek",
		"SurvivalReputationRewardRequest",
		"SurvivalReputationRewardReply"
	},
	[-14003] = {
		"SurvivalWeek",
		"SurvivalReputationExpRequest",
		"SurvivalReputationExpReply"
	},
	[23433] = {
		"SurvivalWeek",
		"SurvivalGetTalentInfoRequest",
		"SurvivalGetTalentInfoReply"
	},
	[-20507] = {
		"SurvivalWeek",
		"SurvivalUnlockInsideTechRequest",
		"SurvivalUnlockInsideTechReply"
	},
	[23579] = {
		"SurvivalWeek",
		"SurvivalLossReturnRewardRequest",
		"SurvivalLossReturnRewardReply"
	},
	[-7905] = {
		"SurvivalWeek",
		"SurvivalStepPush"
	},
	[29562] = {
		"SurvivalWeek",
		"SurvivalSurvivalWeekClientDataRequest",
		"SurvivalSurvivalWeekClientDataReply"
	},
	[-31548] = {
		"SurvivalWeek",
		"SurvivalWeekHotfix1Request",
		"SurvivalWeekHotfix1Reply"
	},
	[-31547] = {
		"SurvivalWeek",
		"SurvivalWeekHotfix2Request",
		"SurvivalWeekHotfix2Reply"
	},
	[-31546] = {
		"SurvivalWeek",
		"SurvivalWeekHotfix3Request",
		"SurvivalWeekHotfix3Reply"
	},
	[23940] = {
		"SurvivalWeek",
		"SurvivalWeekHotfix1Push"
	},
	[23941] = {
		"SurvivalWeek",
		"SurvivalWeekHotfix2Push"
	},
	[23942] = {
		"SurvivalWeek",
		"SurvivalWeekHotfix3Push"
	},
	[-3389] = {
		"Task",
		"GetTaskInfoRequest",
		"GetTaskInfoReply"
	},
	[-16104] = {
		"Task",
		"FinishTaskRequest",
		"FinishTaskReply"
	},
	[-614] = {
		"Task",
		"UpdateTaskPush"
	},
	[-32406] = {
		"Task",
		"DeleteTaskPush"
	},
	[9931] = {
		"Task",
		"GetTaskActivityBonusRequest",
		"GetTaskActivityBonusReply"
	},
	[-5551] = {
		"Task",
		"FinishAllTaskRequest",
		"FinishAllTaskReply"
	},
	[2868] = {
		"Task",
		"FinishReadTaskRequest",
		"FinishReadTaskReply"
	},
	[9952] = {
		"Teaching",
		"TeachingGetInfoRequest",
		"TeachingGetInfoReply"
	},
	[1787] = {
		"Teaching",
		"TeachingGetBonusRequest",
		"TeachingGetBonusReply"
	},
	[20515] = {
		"Teaching",
		"TeachingUpdateInfoPush"
	},
	[13540] = {
		"TowerCompose",
		"TowerComposeGetInfoRequest",
		"TowerComposeGetInfoReply"
	},
	[17271] = {
		"TowerCompose",
		"TowerComposeSetModsRequest",
		"TowerComposeSetModsReply"
	},
	[22941] = {
		"TowerCompose",
		"TowerComposeResearchProgressUpdatePush"
	},
	[20602] = {
		"TowerCompose",
		"TowerComposeUpdateRecordRequest",
		"TowerComposeUpdateRecordReply"
	},
	[24151] = {
		"TowerCompose",
		"TowerComposeLoadRecordRequest",
		"TowerComposeLoadRecordReply"
	},
	[-12526] = {
		"TowerCompose",
		"TowerComposeReChallengeRequest",
		"TowerComposeReChallengeReply"
	},
	[12440] = {
		"TowerCompose",
		"TowerComposeCancelReChallengeRequest",
		"TowerComposeCancelReChallengeReply"
	},
	[-28713] = {
		"TowerCompose",
		"TowerComposeUnlockModsPush"
	},
	[-8101] = {
		"TowerCompose",
		"TowerComposeFightSettlePush"
	},
	[-2260] = {
		"TowerDeep",
		"TowerDeepGetInfoRequest",
		"TowerDeepGetInfoReply"
	},
	[-1135] = {
		"TowerDeep",
		"TowerDeepSaveArchiveRequest",
		"TowerDeepSaveArchiveReply"
	},
	[-9039] = {
		"TowerDeep",
		"TowerDeepLoadArchiveRequest",
		"TowerDeepLoadArchiveReply"
	},
	[-23357] = {
		"TowerDeep",
		"TowerDeepResetRequest",
		"TowerDeepResetReply"
	},
	[27299] = {
		"TowerDeep",
		"TowerDeepFightSettlePush"
	},
	[-13537] = {
		"Tower",
		"GetTowerInfoRequest",
		"GetTowerInfoReply"
	},
	[-17459] = {
		"Tower",
		"TowerMopUpRequest",
		"TowerMopUpReply"
	},
	[-4800] = {
		"Tower",
		"TowerActiveTalentRequest",
		"TowerActiveTalentReply"
	},
	[10119] = {
		"Tower",
		"TowerResetTalentRequest",
		"TowerResetTalentReply"
	},
	[20167] = {
		"Tower",
		"TowerRenameTalentPlanRequest",
		"TowerRenameTalentPlanReply"
	},
	[7733] = {
		"Tower",
		"TowerChangeTalentPlanRequest",
		"TowerChangeTalentPlanReply"
	},
	[5874] = {
		"Tower",
		"TowerResetSubEpisodeRequest",
		"TowerResetSubEpisodeReply"
	},
	[-122] = {
		"Tower",
		"StartTowerBattleRequest",
		"StartTowerBattleReply"
	},
	[-764] = {
		"Tower",
		"TowerBattleFinishPush"
	},
	[-25273] = {
		"Tower",
		"TowerLayerUpdatePush"
	},
	[-15599] = {
		"Turnback",
		"GetTurnbackInfoRequest",
		"GetTurnbackInfoReply"
	},
	[-24211] = {
		"Turnback",
		"TurnbackSignInRequest",
		"TurnbackSignInReply"
	},
	[-29103] = {
		"Turnback",
		"TurnbackOnceBonusRequest",
		"TurnbackOnceBonusReply"
	},
	[-30386] = {
		"Turnback",
		"TurnbackFirstShowRequest",
		"TurnbackFirstShowReply"
	},
	[-31530] = {
		"Turnback",
		"TurnbackBonusPointRequest",
		"TurnbackBonusPointReply"
	},
	[-11727] = {
		"Turnback",
		"TurnbackAdditionPush"
	},
	[-30691] = {
		"Turnback",
		"BuyDoubleBonusRequest",
		"BuyDoubleBonusReply"
	},
	[-18158] = {
		"Turnback",
		"RefreshOnlineTaskRequest",
		"RefreshOnlineTaskReply"
	},
	[-30625] = {
		"Turnback",
		"GetTurnbackDailyBonusRequest",
		"GetTurnbackDailyBonusReply"
	},
	[-28897] = {
		"Turnback",
		"AcceptAllTurnbackBonusPointRequest",
		"AcceptAllTurnbackBonusPointReply"
	},
	[13785] = {
		"Turnback",
		"TurnbackReturnRewardRequest",
		"TurnbackReturnRewardReply"
	},
	[-2477] = {
		"Turnback",
		"AcceptAllTurnbackReturnRewardRequest",
		"AcceptAllTurnbackReturnRewardReply"
	},
	[-23079] = {
		"Udimo",
		"GetUdimoInfoRequest",
		"GetUdimoInfoReply"
	},
	[922] = {
		"Udimo",
		"UseUdimoRequest",
		"UseUdimoReply"
	},
	[18268] = {
		"Udimo",
		"UseBackgroundRequest",
		"UseBackgroundReply"
	},
	[-13820] = {
		"Udimo",
		"UseDecorationRequest",
		"UseDecorationReply"
	},
	[-13336] = {
		"Udimo",
		"WeathInfoPush"
	},
	[15277] = {
		"UnlockVoucher",
		"GetUnlockVoucherInfoRequest",
		"GetUnlockVoucherInfoReply"
	},
	[21220] = {
		"UnlockVoucher",
		"UnlockVoucherInfoUpdatePush"
	},
	[21642] = {
		"User",
		"LogoutRequest",
		"LogoutReply"
	},
	[-31567] = {
		"User",
		"DebugLogoutRequest",
		"DebugLogoutReply"
	},
	[-27221] = {
		"UserSetting",
		"GetSettingInfosRequest",
		"GetSettingInfosReply"
	},
	[-20517] = {
		"UserSetting",
		"UpdateSettingInfoRequest",
		"UpdateSettingInfoReply"
	},
	[-23481] = {
		"WarChess",
		"WarChessRoundStartPush"
	},
	[13229] = {
		"WarChess",
		"WarChessMyRoundStartRequest",
		"WarChessMyRoundStartReply"
	},
	[19485] = {
		"WarChess",
		"WarChessCharacterSkillRequest",
		"WarChessCharacterSkillReply"
	},
	[8444] = {
		"WarChess",
		"WarChessPiecePlaceRequest",
		"WarChessPiecePlaceReply"
	},
	[464] = {
		"WarChess",
		"WarChessRoundEndRequest",
		"WarChessRoundEndReply"
	},
	[-18334] = {
		"WarChess",
		"WarChessFightResultPush"
	},
	[-22058] = {
		"WarChess",
		"WarChessDiamondBoxPush"
	},
	[29319] = {
		"WarChess",
		"WarChessPieceSellRequest",
		"WarChessPieceSellReply"
	},
	[-31981] = {
		"Weekwalk",
		"GetWeekwalkInfoRequest",
		"GetWeekwalkInfoReply"
	},
	[22468] = {
		"Weekwalk",
		"BeforeStartWeekwalkBattleRequest",
		"BeforeStartWeekwalkBattleReply"
	},
	[31013] = {
		"Weekwalk",
		"WeekwalkGeneralRequest",
		"WeekwalkGeneralReply"
	},
	[-28842] = {
		"Weekwalk",
		"WeekwalkInfoUpdatePush"
	},
	[-21961] = {
		"Weekwalk",
		"WeekwalkDialogRequest",
		"WeekwalkDialogReply"
	},
	[10639] = {
		"Weekwalk",
		"WeekwalkHeroRecommendRequest",
		"WeekwalkHeroRecommendReply"
	},
	[27625] = {
		"Weekwalk",
		"WeekwalkDialogHistoryRequest",
		"WeekwalkDialogHistoryReply"
	},
	[12972] = {
		"Weekwalk",
		"ResetLayerRequest",
		"ResetLayerReply"
	},
	[8091] = {
		"Weekwalk",
		"MarkShowBuffRequest",
		"MarkShowBuffReply"
	},
	[21890] = {
		"Weekwalk",
		"MarkShowFinishedRequest",
		"MarkShowFinishedReply"
	},
	[-17006] = {
		"Weekwalk",
		"SelectNotCdHeroRequest",
		"SelectNotCdHeroReply"
	},
	[24540] = {
		"Weekwalk",
		"MarkPopDeepRuleRequest",
		"MarkPopDeepRuleReply"
	},
	[-18703] = {
		"Weekwalk",
		"MarkPopShallowSettleRequest",
		"MarkPopShallowSettleReply"
	},
	[6293] = {
		"Weekwalk",
		"MarkPopDeepSettleRequest",
		"MarkPopDeepSettleReply"
	},
	[-27320] = {
		"Weekwalk",
		"ChangeWeekwalkHeroGroupSelectRequest",
		"ChangeWeekwalkHeroGroupSelectReply"
	},
	[279] = {
		"WeekwalkVer2",
		"WeekwalkVer2GetInfoRequest",
		"WeekwalkVer2GetInfoReply"
	},
	[-7053] = {
		"WeekwalkVer2",
		"WeekwalkVer2HeroRecommendRequest",
		"WeekwalkVer2HeroRecommendReply"
	},
	[-7189] = {
		"WeekwalkVer2",
		"WeekwalkVer2ResetLayerRequest",
		"WeekwalkVer2ResetLayerReply"
	},
	[-29076] = {
		"WeekwalkVer2",
		"WeekwalkVer2ChangeHeroGroupSelectRequest",
		"WeekwalkVer2ChangeHeroGroupSelectReply"
	},
	[-13845] = {
		"WeekwalkVer2",
		"WeekwalkVer2ChooseSkillRequest",
		"WeekwalkVer2ChooseSkillReply"
	},
	[29864] = {
		"WeekwalkVer2",
		"WeekwalkVer2GetSettleInfoRequest",
		"WeekwalkVer2GetSettleInfoReply"
	},
	[-24210] = {
		"WeekwalkVer2",
		"WeekwalkVer2MarkPreSettleRequest",
		"WeekwalkVer2MarkPreSettleReply"
	},
	[29213] = {
		"WeekwalkVer2",
		"WeekwalkVer2MarkPopRuleRequest",
		"WeekwalkVer2MarkPopRuleReply"
	},
	[-17919] = {
		"WeekwalkVer2",
		"WeekwalkVer2MarkShowFinishedRequest",
		"WeekwalkVer2MarkShowFinishedReply"
	},
	[-22854] = {
		"WeekwalkVer2",
		"WeekwalkVer2InfoUpdatePush"
	},
	[19339] = {
		"WeekwalkVer2",
		"WeekwalkVer2SettleInfoUpdatePush"
	},
	[12174] = {
		"WeekwalkVer2",
		"WeekwalkVer2FightSettlePush"
	},
	[4958] = {
		"XF",
		"GuestTimeOutPush"
	},
	[31345] = {
		"XF",
		"MinorPlayTimeOutPush"
	},
	[26459] = {
		"XF",
		"MinorLimitLoginTimePush"
	}
}

setGlobal("module_cmd", module_cmd)

return module_cmd
