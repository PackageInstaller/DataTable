-- this file is auto generate by proto2lua.exe, please DO NOT modify it manually!

local protoMessages = {
    [PROTOCOL.Unkonw] = "protocol.Unkonw",
    [PROTOCOL.FirstCommunicateReq] = "protocol.FirstCommunicateReq",
    [PROTOCOL.FirstCommunicateResp] = "protocol.FirstCommunicateResp",
    [PROTOCOL.LoginReq] = "protocol.LoginReq",
    [PROTOCOL.LoginResp] = "protocol.LoginResp",
    [PROTOCOL.ClientReadyReq] = "protocol.ClientReadyReq",
    [PROTOCOL.ClientReadyResp] = "protocol.ClientReadyResp",
    [PROTOCOL.OtherLoginPush] = "protocol.OtherLoginPush",
    [PROTOCOL.PingReq] = "protocol.PingReq",
    [PROTOCOL.PingResp] = "protocol.PingResp",
    [PROTOCOL.DailyUpdatePush] = "protocol.DailyUpdatePush",
    [PROTOCOL.PlayingLimitInfoReq] = "protocol.PlayingLimitInfoReq",
    [PROTOCOL.PlayingLimitInfoResp] = "protocol.PlayingLimitInfoResp",
    [PROTOCOL.PlayingLimitInfoUpdatePush] = "protocol.PlayingLimitInfoUpdatePush",
    [PROTOCOL.PlayingTimeLimitedPush] = "protocol.PlayingTimeLimitedPush",
    [PROTOCOL.ItemBagReq] = "protocol.ItemBagReq",
    [PROTOCOL.ItemBagResp] = "protocol.ItemBagResp",
    [PROTOCOL.UseItemReq] = "protocol.UseItemReq",
    [PROTOCOL.UseItemResp] = "protocol.UseItemResp",
    [PROTOCOL.ItemUpdatePush] = "protocol.ItemUpdatePush",
    [PROTOCOL.MailboxInfoReq] = "protocol.MailboxInfoReq", -- 请求所有邮件信息
    [PROTOCOL.MailboxInfoResp] = "protocol.MailboxInfoResp",
    [PROTOCOL.MailboxRewardsReq] = "protocol.MailboxRewardsReq", -- 领取邮件奖励
    [PROTOCOL.MailboxRewardsResp] = "protocol.MailboxRewardsResp",
    [PROTOCOL.MailboxAllRewardsReq] = "protocol.MailboxAllRewardsReq", -- 领取全部邮件奖励
    [PROTOCOL.MailboxAllRewardsResp] = "protocol.MailboxAllRewardsResp",
    [PROTOCOL.MailboxReadReq] = "protocol.MailboxReadReq", -- 阅读邮件
    [PROTOCOL.MailboxReadResp] = "protocol.MailboxReadResp",
    [PROTOCOL.MailboxDeleteReq] = "protocol.MailboxDeleteReq", -- 删除邮件
    [PROTOCOL.MailboxDeleteResp] = "protocol.MailboxDeleteResp",
    [PROTOCOL.MailboxDeleteAllReq] = "protocol.MailboxDeleteAllReq", -- 删除所有可删除邮件
    [PROTOCOL.MailboxDeleteAllResp] = "protocol.MailboxDeleteAllResp",
    [PROTOCOL.MailboxUpdatePush] = "protocol.MailboxUpdatePush",
    [PROTOCOL.FormationModifyReq] = "protocol.FormationModifyReq",
    [PROTOCOL.FormationModifyResp] = "protocol.FormationModifyResp",
    [PROTOCOL.FormationsListInfoReq] = "protocol.FormationsListInfoReq",
    [PROTOCOL.FormationsListInfoResp] = "protocol.FormationsListInfoResp",
    [PROTOCOL.FormationUpdatePush] = "protocol.FormationUpdatePush",
    [PROTOCOL.TaskPackReq] = "protocol.TaskPackReq",
    [PROTOCOL.TaskPackResp] = "protocol.TaskPackResp",
    [PROTOCOL.TaskUpdatePush] = "protocol.TaskUpdatePush",
    [PROTOCOL.TaskSubmitReq] = "protocol.TaskSubmitReq",
    [PROTOCOL.TaskSubmitResp] = "protocol.TaskSubmitResp",
    [PROTOCOL.TaskReceiveStageRewardReq] = "protocol.TaskReceiveStageRewardReq",
    [PROTOCOL.TaskReceiveStageRewardResp] = "protocol.TaskReceiveStageRewardResp",
    [PROTOCOL.TaskSubmitAllReq] = "protocol.TaskSubmitAllReq",
    [PROTOCOL.TaskSubmitAllResp] = "protocol.TaskSubmitAllResp",
    [PROTOCOL.NewbieBingoReq] = "protocol.NewbieBingoReq",
    [PROTOCOL.NewbieBingoResp] = "protocol.NewbieBingoResp",
    [PROTOCOL.NewbieBingoUpdatePush] = "protocol.NewbieBingoUpdatePush",
    [PROTOCOL.NewbieBingoReceiveRewardReq] = "protocol.NewbieBingoReceiveRewardReq",
    [PROTOCOL.NewbieBingoReceiveRewardResp] = "protocol.NewbieBingoReceiveRewardResp",
    [PROTOCOL.TaskSubmitByGroupReq] = "protocol.TaskSubmitByGroupReq",
    [PROTOCOL.TaskSubmitByGroupResp] = "protocol.TaskSubmitByGroupResp",
    [PROTOCOL.CharacterPackInfoReq] = "protocol.CharacterPackInfoReq",
    [PROTOCOL.CharacterPackInfoResp] = "protocol.CharacterPackInfoResp",
    [PROTOCOL.CharacterPackSetSkinReq] = "protocol.CharacterPackSetSkinReq",
    [PROTOCOL.CharacterPackSetSkinResp] = "protocol.CharacterPackSetSkinResp",
    [PROTOCOL.CharacterPackLevelUpReq] = "protocol.CharacterPackLevelUpReq",
    [PROTOCOL.CharacterPackLevelUpResp] = "protocol.CharacterPackLevelUpResp",
    [PROTOCOL.CharacterPackBeadReq] = "protocol.CharacterPackBeadReq",
    [PROTOCOL.CharacterPackBeadResp] = "protocol.CharacterPackBeadResp",
    [PROTOCOL.CharacterPackEvolutionReq] = "protocol.CharacterPackEvolutionReq",
    [PROTOCOL.CharacterPackEvolutionResp] = "protocol.CharacterPackEvolutionResp",
    [PROTOCOL.CharacterPackIntimacyReq] = "protocol.CharacterPackIntimacyReq",
    [PROTOCOL.CharacterPackIntimacyResp] = "protocol.CharacterPackIntimacyResp",
    [PROTOCOL.CharacterPackConstellationReq] = "protocol.CharacterPackConstellationReq",
    [PROTOCOL.CharacterPackConstellationResp] = "protocol.CharacterPackConstellationResp",
    [PROTOCOL.CharacterPackEquipReq] = "protocol.CharacterPackEquipReq",
    [PROTOCOL.CharacterPackEquipResp] = "protocol.CharacterPackEquipResp",
    [PROTOCOL.CharacterPackUnequipReq] = "protocol.CharacterPackUnequipReq",
    [PROTOCOL.CharacterPackUnequipResp] = "protocol.CharacterPackUnequipResp",
    [PROTOCOL.CharacterPackFragExchangeReq] = "protocol.CharacterPackFragExchangeReq",
    [PROTOCOL.CharacterPackFragExchangeResp] = "protocol.CharacterPackFragExchangeResp",
    [PROTOCOL.CharacterPackMarryReq] = "protocol.CharacterPackMarryReq",
    [PROTOCOL.CharacterPackMarryResp] = "protocol.CharacterPackMarryResp",
    [PROTOCOL.CharacterPackSetMainWifeReq] = "protocol.CharacterPackSetMainWifeReq",
    [PROTOCOL.CharacterPackSetMainWifeResp] = "protocol.CharacterPackSetMainWifeResp",
    [PROTOCOL.CharacterPackUpdatePush] = "protocol.CharacterPackUpdatePush",
    [PROTOCOL.LevelPackReq] = "protocol.LevelPackReq", -- 请求关卡、章节数据
    [PROTOCOL.LevelPackResp] = "protocol.LevelPackResp",
    [PROTOCOL.BattleStartReq] = "protocol.BattleStartReq", -- 开始战斗
    [PROTOCOL.BattleStartResp] = "protocol.BattleStartResp",
    [PROTOCOL.BattleFinishReq] = "protocol.BattleFinishReq", -- 结束战斗
    [PROTOCOL.BattleFinishResp] = "protocol.BattleFinishResp",
    [PROTOCOL.PassNoBattleLevelReq] = "protocol.PassNoBattleLevelReq", -- 通关无战斗关卡
    [PROTOCOL.PassNoBattleLevelResp] = "protocol.PassNoBattleLevelResp",
    [PROTOCOL.ChapterReceiveStarRewardReq] = "protocol.ChapterReceiveStarRewardReq", -- 领取章节星星奖励
    [PROTOCOL.ChapterReceiveStarRewardResp] = "protocol.ChapterReceiveStarRewardResp",
    [PROTOCOL.LevelSweepReq] = "protocol.LevelSweepReq",
    [PROTOCOL.LevelSweepResp] = "protocol.LevelSweepResp",
    [PROTOCOL.BattlePlayerReviveReq] = "protocol.BattlePlayerReviveReq",
    [PROTOCOL.BattlePlayerReviveResp] = "protocol.BattlePlayerReviveResp",
    [PROTOCOL.LevelUpdatePush] = "protocol.LevelUpdatePush", -- 关卡、章节数据更新推送
    [PROTOCOL.AutoBattleResultPush] = "protocol.AutoBattleResultPush", -- 自动战斗结果推送
    [PROTOCOL.GuideReq] = "protocol.GuideReq",
    [PROTOCOL.GuideResp] = "protocol.GuideResp",
    [PROTOCOL.GuideSaveReq] = "protocol.GuideSaveReq",
    [PROTOCOL.GuideSaveResp] = "protocol.GuideSaveResp",
    [PROTOCOL.DailyRewardReq] = "protocol.DailyRewardReq",
    [PROTOCOL.DailyRewardResp] = "protocol.DailyRewardResp",
    [PROTOCOL.CommonCheckInReq] = "protocol.CommonCheckInReq",
    [PROTOCOL.CommonCheckInResp] = "protocol.CommonCheckInResp",
    [PROTOCOL.CommonCheckInReceiveReq] = "protocol.CommonCheckInReceiveReq",
    [PROTOCOL.CommonCheckInReceiveResp] = "protocol.CommonCheckInReceiveResp",
    [PROTOCOL.MonthlyCardReq] = "protocol.MonthlyCardReq",
    [PROTOCOL.MonthlyCardResp] = "protocol.MonthlyCardResp",
    [PROTOCOL.DailyRewardReceiveReq] = "protocol.DailyRewardReceiveReq",
    [PROTOCOL.DailyRewardReceiveResp] = "protocol.DailyRewardReceiveResp",
    [PROTOCOL.MonthlyCardReceiveReq] = "protocol.MonthlyCardReceiveReq",
    [PROTOCOL.MonthlyCardReceiveResp] = "protocol.MonthlyCardReceiveResp",
    [PROTOCOL.CommonCheckInUpdatePush] = "protocol.CommonCheckInUpdatePush",
    [PROTOCOL.DailyRewardUpdatePush] = "protocol.DailyRewardUpdatePush",
    [PROTOCOL.MonthlyCardUpdatePush] = "protocol.MonthlyCardUpdatePush",
    [PROTOCOL.RecruitReq] = "protocol.RecruitReq", -- 抽卡
    [PROTOCOL.RecruitResp] = "protocol.RecruitResp",
    [PROTOCOL.RecruitInfoReq] = "protocol.RecruitInfoReq", -- 获取卡池状态
    [PROTOCOL.RecruitInfoResp] = "protocol.RecruitInfoResp",
    [PROTOCOL.RecruitRookiePoolConfirmReq] = "protocol.RecruitRookiePoolConfirmReq", -- 确认新手池
    [PROTOCOL.RecruitRookiePoolConfirmResp] = "protocol.RecruitRookiePoolConfirmResp",
    [PROTOCOL.RecruitLogReq] = "protocol.RecruitLogReq", -- 抽卡记录
    [PROTOCOL.RecruitLogResp] = "protocol.RecruitLogResp",
    [PROTOCOL.RecruitUpdatePush] = "protocol.RecruitUpdatePush",
    [PROTOCOL.RoleInfoReq] = "protocol.RoleInfoReq",
    [PROTOCOL.RoleInfoResp] = "protocol.RoleInfoResp",
    [PROTOCOL.RoleInfoUpdatePush] = "protocol.RoleInfoUpdatePush",
    [PROTOCOL.ChangeNameReq] = "protocol.ChangeNameReq",
    [PROTOCOL.ChangeNameResp] = "protocol.ChangeNameResp",
    [PROTOCOL.ChangeSignatureReq] = "protocol.ChangeSignatureReq",
    [PROTOCOL.ChangeSignatureResp] = "protocol.ChangeSignatureResp",
    [PROTOCOL.MostUsedCharactersReq] = "protocol.MostUsedCharactersReq",
    [PROTOCOL.MostUsedCharactersResp] = "protocol.MostUsedCharactersResp",
    [PROTOCOL.SelectFirstCharacterReq] = "protocol.SelectFirstCharacterReq",
    [PROTOCOL.SelectFirstCharacterResp] = "protocol.SelectFirstCharacterResp",
    [PROTOCOL.HeadPortraitInfoUpdatePush] = "protocol.HeadPortraitInfoUpdatePush",
    [PROTOCOL.ChangeHeadPortraitReq] = "protocol.ChangeHeadPortraitReq",
    [PROTOCOL.ChangeHeadPortraitResp] = "protocol.ChangeHeadPortraitResp",
    [PROTOCOL.ChangeHeadPortraitBorderReq] = "protocol.ChangeHeadPortraitBorderReq",
    [PROTOCOL.ChangeHeadPortraitBorderResp] = "protocol.ChangeHeadPortraitBorderResp",
    [PROTOCOL.SetShowGirlReq] = "protocol.SetShowGirlReq",
    [PROTOCOL.SetShowGirlResp] = "protocol.SetShowGirlResp",
    [PROTOCOL.SetSocietyShowGirlReq] = "protocol.SetSocietyShowGirlReq",
    [PROTOCOL.SetSocietyShowGirlResp] = "protocol.SetSocietyShowGirlResp",
    [PROTOCOL.SetSupportUnitReq] = "protocol.SetSupportUnitReq",
    [PROTOCOL.SetSupportUnitResp] = "protocol.SetSupportUnitResp",
    [PROTOCOL.HouseRestReq] = "protocol.HouseRestReq",
    [PROTOCOL.HouseRestResp] = "protocol.HouseRestResp",
    [PROTOCOL.HouseSleepReq] = "protocol.HouseSleepReq",
    [PROTOCOL.HouseSleepResp] = "protocol.HouseSleepResp",
    [PROTOCOL.RedeemGiftCardCodeReq] = "protocol.RedeemGiftCardCodeReq",
    [PROTOCOL.RedeemGiftCardCodeResp] = "protocol.RedeemGiftCardCodeResp",
    [PROTOCOL.ShopInfoReq] = "protocol.ShopInfoReq",
    [PROTOCOL.ShopInfoResp] = "protocol.ShopInfoResp",
    [PROTOCOL.BuyGoodsReq] = "protocol.BuyGoodsReq",
    [PROTOCOL.BuyGoodsResp] = "protocol.BuyGoodsResp",
    [PROTOCOL.ShopUpdatePush] = "protocol.ShopUpdatePush",
    [PROTOCOL.PaymentInfoReq] = "protocol.PaymentInfoReq",
    [PROTOCOL.PaymentInfoResp] = "protocol.PaymentInfoResp",
    [PROTOCOL.PaymentInfoUpdatePush] = "protocol.PaymentInfoUpdatePush",
    [PROTOCOL.BuyPaymentGoodsReq] = "protocol.BuyPaymentGoodsReq",
    [PROTOCOL.BuyPaymentGoodsResp] = "protocol.BuyPaymentGoodsResp",
    [PROTOCOL.CreatePaymentOrderReq] = "protocol.CreatePaymentOrderReq",
    [PROTOCOL.CreatePaymentOrderResp] = "protocol.CreatePaymentOrderResp",
    [PROTOCOL.VerifyPaymentOrderReq] = "protocol.VerifyPaymentOrderReq",
    [PROTOCOL.VerifyPaymentOrderResp] = "protocol.VerifyPaymentOrderResp",
    [PROTOCOL.CancelPaymentOrderReq] = "protocol.CancelPaymentOrderReq",
    [PROTOCOL.CancelPaymentOrderResp] = "protocol.CancelPaymentOrderResp",
    [PROTOCOL.FriendDataReq] = "protocol.FriendDataReq",
    [PROTOCOL.FriendDataResp] = "protocol.FriendDataResp",
    [PROTOCOL.RequestFriendReq] = "protocol.RequestFriendReq",
    [PROTOCOL.RequestFriendResp] = "protocol.RequestFriendResp",
    [PROTOCOL.ApplyFriendRequestReq] = "protocol.ApplyFriendRequestReq",
    [PROTOCOL.ApplyFriendRequestResp] = "protocol.ApplyFriendRequestResp",
    [PROTOCOL.RemoveFriendRequestReq] = "protocol.RemoveFriendRequestReq",
    [PROTOCOL.RemoveFriendRequestResp] = "protocol.RemoveFriendRequestResp",
    [PROTOCOL.RemoveFriendReq] = "protocol.RemoveFriendReq",
    [PROTOCOL.RemoveFriendResp] = "protocol.RemoveFriendResp",
    [PROTOCOL.FriendDataUpdatePush] = "protocol.FriendDataUpdatePush",
    [PROTOCOL.SearchRoleReq] = "protocol.SearchRoleReq",
    [PROTOCOL.SearchRoleResp] = "protocol.SearchRoleResp",
    [PROTOCOL.FriendRecommendReq] = "protocol.FriendRecommendReq",
    [PROTOCOL.FriendRecommendResp] = "protocol.FriendRecommendResp",
    [PROTOCOL.SupportUnitRecommendReq] = "protocol.SupportUnitRecommendReq",
    [PROTOCOL.SupportUnitRecommendResp] = "protocol.SupportUnitRecommendResp",
    [PROTOCOL.SendGiftToFriendReq] = "protocol.SendGiftToFriendReq",
    [PROTOCOL.SendGiftToFriendResp] = "protocol.SendGiftToFriendResp",
    [PROTOCOL.ReceiveFriendGiftReq] = "protocol.ReceiveFriendGiftReq",
    [PROTOCOL.ReceiveFriendGiftResp] = "protocol.ReceiveFriendGiftResp",
    [PROTOCOL.SetFriendNoteReq] = "protocol.SetFriendNoteReq",
    [PROTOCOL.SetFriendNoteResp] = "protocol.SetFriendNoteResp",
    [PROTOCOL.GameEventReq] = "protocol.GameEventReq",
    [PROTOCOL.GameEventResp] = "protocol.GameEventResp",
    [PROTOCOL.RemovedGameEventModule] = "protocol.RemovedGameEventModule",
    [PROTOCOL.GameEventUpdatePush] = "protocol.GameEventUpdatePush",
    [PROTOCOL.TowerInfoReq] = "protocol.TowerInfoReq",
    [PROTOCOL.TowerInfoResp] = "protocol.TowerInfoResp",
    [PROTOCOL.TowerLevelUpReq] = "protocol.TowerLevelUpReq",
    [PROTOCOL.TowerLevelUpResp] = "protocol.TowerLevelUpResp",
    [PROTOCOL.TowerUnlockComponentReq] = "protocol.TowerUnlockComponentReq",
    [PROTOCOL.TowerUnlockComponentResp] = "protocol.TowerUnlockComponentResp",
    [PROTOCOL.TowerUpdatePush] = "protocol.TowerUpdatePush",
    [PROTOCOL.ModuleStatusReq] = "protocol.ModuleStatusReq",
    [PROTOCOL.ModuleStatusResp] = "protocol.ModuleStatusResp",
    [PROTOCOL.ModuleStatusUpdatePush] = "protocol.ModuleStatusUpdatePush",
    [PROTOCOL.FightSoulReq] = "protocol.FightSoulReq",
    [PROTOCOL.FightSoulResp] = "protocol.FightSoulResp",
    [PROTOCOL.FightSoulUpdatePush] = "protocol.FightSoulUpdatePush",
    [PROTOCOL.FightSoulExpStrengthenReq] = "protocol.FightSoulExpStrengthenReq",
    [PROTOCOL.FightSoulExpStrengthenResp] = "protocol.FightSoulExpStrengthenResp",
    [PROTOCOL.FightSoulMergeReq] = "protocol.FightSoulMergeReq",
    [PROTOCOL.FightSoulMergeResp] = "protocol.FightSoulMergeResp",
    [PROTOCOL.FightSoulDecomposeReq] = "protocol.FightSoulDecomposeReq",
    [PROTOCOL.FightSoulDecomposeResp] = "protocol.FightSoulDecomposeResp",
    [PROTOCOL.FightSoulSetLockingReq] = "protocol.FightSoulSetLockingReq",
    [PROTOCOL.FightSoulSetLockingResp] = "protocol.FightSoulSetLockingResp",
    [PROTOCOL.EquipmentPackReq] = "protocol.EquipmentPackReq", -- 请求装备背包信息
    [PROTOCOL.EquipmentPackResp] = "protocol.EquipmentPackResp",
    [PROTOCOL.EquipmentPackScrapReq] = "protocol.EquipmentPackScrapReq", -- 请求分解装备
    [PROTOCOL.EquipmentPackScrapResp] = "protocol.EquipmentPackScrapResp",
    [PROTOCOL.EquipmentPackLevelUpReq] = "protocol.EquipmentPackLevelUpReq", -- 请求装备升级
    [PROTOCOL.EquipmentPackLevelUpResp] = "protocol.EquipmentPackLevelUpResp",
    [PROTOCOL.EquipmentPackLockReq] = "protocol.EquipmentPackLockReq", -- 请求装备锁定
    [PROTOCOL.EquipmentPackLockResp] = "protocol.EquipmentPackLockResp",
    [PROTOCOL.EquipmentPackUpdatePush] = "protocol.EquipmentPackUpdatePush",
    [PROTOCOL.EncyclopediaReq] = "protocol.EncyclopediaReq",
    [PROTOCOL.EncyclopediaResp] = "protocol.EncyclopediaResp",
    [PROTOCOL.EncyclopediaUpdatePush] = "protocol.EncyclopediaUpdatePush",
    [PROTOCOL.EncyclopediaUnlockReq] = "protocol.EncyclopediaUnlockReq",
    [PROTOCOL.EncyclopediaUnlockResp] = "protocol.EncyclopediaUnlockResp",
    [PROTOCOL.ArenaInfoReq] = "protocol.ArenaInfoReq", -- 请求竞技场个人信息
    [PROTOCOL.ArenaInfoResp] = "protocol.ArenaInfoResp",
    [PROTOCOL.ArenaRefreshChallengerReq] = "protocol.ArenaRefreshChallengerReq", -- 请求刷新竞技场对手
    [PROTOCOL.ArenaRefreshChallengerResp] = "protocol.ArenaRefreshChallengerResp",
    [PROTOCOL.ArenaGetLeaderboardReq] = "protocol.ArenaGetLeaderboardReq", -- 获取竞技场排行榜
    [PROTOCOL.ArenaGetLeaderboardResp] = "protocol.ArenaGetLeaderboardResp",
    [PROTOCOL.ArenaAddChallengeTimesReq] = "protocol.ArenaAddChallengeTimesReq", -- 增加竞技场挑战次数
    [PROTOCOL.ArenaAddChallengeTimesResp] = "protocol.ArenaAddChallengeTimesResp",
    [PROTOCOL.ArenaHistoryReq] = "protocol.ArenaHistoryReq", -- 获取玩家竞技场历史信息
    [PROTOCOL.ArenaHistoryResp] = "protocol.ArenaHistoryResp",
    [PROTOCOL.ArenaAutoBattleReq] = "protocol.ArenaAutoBattleReq", -- 竞技场速战
    [PROTOCOL.ArenaAutoBattleResp] = "protocol.ArenaAutoBattleResp",
    [PROTOCOL.ArenaUpdatePush] = "protocol.ArenaUpdatePush",
    [PROTOCOL.PassReq] = "protocol.PassReq",
    [PROTOCOL.PassResp] = "protocol.PassResp",
    [PROTOCOL.PassUpdatePush] = "protocol.PassUpdatePush",
    [PROTOCOL.ReceivePassRewardsReq] = "protocol.ReceivePassRewardsReq",
    [PROTOCOL.ReceivePassRewardsResp] = "protocol.ReceivePassRewardsResp",
    [PROTOCOL.BossraidInfoReq] = "protocol.BossraidInfoReq",
    [PROTOCOL.BossraidInfoResp] = "protocol.BossraidInfoResp",
    [PROTOCOL.BossraidLeaderboardReq] = "protocol.BossraidLeaderboardReq",
    [PROTOCOL.BossraidLeaderboardResp] = "protocol.BossraidLeaderboardResp",
    [PROTOCOL.BossraidCancelReq] = "protocol.BossraidCancelReq",
    [PROTOCOL.BossraidCancelResp] = "protocol.BossraidCancelResp",
    [PROTOCOL.BossraidUpdatePush] = "protocol.BossraidUpdatePush",
}

return protoMessages
