-- chunkname: @IQIGame\\Net\\net.lua

msgIdMethodName = "{\"100102\":\"net_centerChat.sendChat\",\"100103\":\"net_centerChat.switchRoom\",\"100104\":\"net_centerChat.sendChatResult\",\"100105\":\"net_centerChat.switchRoomResult\",\"100106\":\"net_centerChat.notifyChat\",\"100107\":\"net_centerChat.notifyChatRoom\",\"100108\":\"net_centerChat.reportPlayer\",\"100109\":\"net_centerChat.reportPlayerResult\",\"1002\":\"net_remoteLogic.requestMazeOrder\",\"100202\":\"net_centerRank.getRank\",\"100203\":\"net_centerRank.getRankResult\",\"100204\":\"net_centerRank.getRankUserData\",\"100205\":\"net_centerRank.getRankUserDataResult\",\"100206\":\"net_centerRank.getRankGoalie\",\"100207\":\"net_centerRank.getRankGoalieResult\",\"1003\":\"net_remoteLogic.requestBattleOrder\",\"100302\":\"net_centerFriend.removeFriends\",\"100303\":\"net_centerFriend.applyFriends\",\"100304\":\"net_centerFriend.dealWithApply\",\"100305\":\"net_centerFriend.addBlacklist\",\"100306\":\"net_centerFriend.removeBlacklist\",\"100307\":\"net_centerFriend.searchPlayer\",\"100308\":\"net_centerFriend.setRemark\",\"100309\":\"net_centerFriend.recommend\",\"100310\":\"net_centerFriend.removeFriendsResult\",\"100311\":\"net_centerFriend.applyFriendsResult\",\"100312\":\"net_centerFriend.dealWithApplyResult\",\"100313\":\"net_centerFriend.addBlacklistResult\",\"100314\":\"net_centerFriend.removeBlacklistResult\",\"100315\":\"net_centerFriend.searchPlayerResult\",\"100316\":\"net_centerFriend.setRemarkResult\",\"100317\":\"net_centerFriend.recommendResult\",\"100318\":\"net_centerFriend.notifyAddFriend\",\"100319\":\"net_centerFriend.notifyDeleteFriend\",\"100320\":\"net_centerFriend.notifyUpdateFriend\",\"1004\":\"net_remoteLogic.responseMazeCommand\",\"100402\":\"net_centerEventTurnTable.getTurntableLogInfo\",\"100403\":\"net_centerEventTurnTable.reciveRewardInfo\",\"100404\":\"net_centerEventTurnTable.getTurntableLogInfoResult\",\"100405\":\"net_centerEventTurnTable.reciveRewardInfoResult\",\"1005\":\"net_remoteLogic.requestMazeOrderResult\",\"100502\":\"net_centerEventGroupPurchase.getGroupPurchaseCommonData\",\"100503\":\"net_centerEventGroupPurchase.getGroupPurchaseCommonDataResult\",\"1006\":\"net_remoteLogic.responseBattleCommand\",\"100602\":\"net_centerEventVote.getVoteInfo\",\"100603\":\"net_centerEventVote.getVoteInfoResult\",\"1007\":\"net_remoteLogic.requestBattleOrderResult\",\"100702\":\"net_centerEventHelpNewbies.getFollowers\",\"100703\":\"net_centerEventHelpNewbies.getFollowersResult\",\"100802\":\"net_centerEventCupMatchVote.getVoteInfo\",\"100803\":\"net_centerEventCupMatchVote.getVoteInfoResult\",\"100902\":\"net_centerGuild.createGuild\",\"100903\":\"net_centerGuild.enterGuild\",\"100904\":\"net_centerGuild.exitGuild\",\"100905\":\"net_centerGuild.getRecommendGuildList\",\"100906\":\"net_centerGuild.applyGuild\",\"100907\":\"net_centerGuild.getMyApplyList\",\"100908\":\"net_centerGuild.cancelApplyGuild\",\"100909\":\"net_centerGuild.getAuditList\",\"100910\":\"net_centerGuild.refuseApply\",\"100911\":\"net_centerGuild.acceptApply\",\"100912\":\"net_centerGuild.getMemberList\",\"100913\":\"net_centerGuild.appointPosition\",\"100914\":\"net_centerGuild.removeMember\",\"100915\":\"net_centerGuild.impeachment\",\"100916\":\"net_centerGuild.cancelImpeachment\",\"100917\":\"net_centerGuild.quit\",\"100918\":\"net_centerGuild.editInfo\",\"100919\":\"net_centerGuild.changeName\",\"100920\":\"net_centerGuild.searchGuild\",\"100921\":\"net_centerGuild.getGuildTrainingIntegral\",\"100922\":\"net_centerGuild.createGuildResult\",\"100923\":\"net_centerGuild.enterGuildResult\",\"100924\":\"net_centerGuild.exitGuildResult\",\"100925\":\"net_centerGuild.getRecommendGuildListResult\",\"100926\":\"net_centerGuild.applyGuildResult\",\"100927\":\"net_centerGuild.getMyApplyListResult\",\"100928\":\"net_centerGuild.cancelApplyGuildResult\",\"100929\":\"net_centerGuild.getAuditListResult\",\"100930\":\"net_centerGuild.refuseApplyResult\",\"100931\":\"net_centerGuild.acceptApplyResult\",\"100932\":\"net_centerGuild.getMemberListResult\",\"100933\":\"net_centerGuild.appointPositionResult\",\"100934\":\"net_centerGuild.removeMemberResult\",\"100935\":\"net_centerGuild.impeachmentResult\",\"100936\":\"net_centerGuild.cancelImpeachmentResult\",\"100937\":\"net_centerGuild.quitResult\",\"100938\":\"net_centerGuild.editInfoResult\",\"100939\":\"net_centerGuild.changeNameResult\",\"100940\":\"net_centerGuild.searchGuildResult\",\"100941\":\"net_centerGuild.getGuildTrainingIntegralResult\",\"100942\":\"net_centerGuild.notifyJoinGuild\",\"100943\":\"net_centerGuild.notifyQuitGuild\",\"100944\":\"net_centerGuild.notifyUpdateGuildBase\",\"100945\":\"net_centerGuild.notifyUpdateGuild\",\"100946\":\"net_centerGuild.notifyUpdateGuildFund\",\"100947\":\"net_centerGuild.upBuildingLevel\",\"100948\":\"net_centerGuild.buyBuildingEffect\",\"100949\":\"net_centerGuild.upBuildingLevelResult\",\"100950\":\"net_centerGuild.buyBuildingEffectResult\",\"100951\":\"net_centerGuild.getQuestProgress\",\"100952\":\"net_centerGuild.getQuestProgressResult\",\"100953\":\"net_centerGuild.notifyNewAudit\",\"100954\":\"net_centerGuild.editNotice\",\"100955\":\"net_centerGuild.editNoticeResult\",\"102\":\"net_gameToCenter.registerSimplePlayer\",\"103\":\"net_gameToCenter.changePlayerName\",\"104\":\"net_gameToCenter.loadPlayer\",\"105\":\"net_gameToCenter.offline\",\"106\":\"net_gameToCenter.heartbeat\",\"107\":\"net_gameToCenter.uploadSimplePlayer\",\"108\":\"net_gameToCenter.uploadRankScore\",\"109\":\"net_gameToCenter.notifyCentralStart\",\"110\":\"net_gameToCenter.notifyCentralStop\",\"111\":\"net_gameToCenter.registerSimplePlayerResult\",\"112\":\"net_gameToCenter.changePlayerNameResult\",\"113\":\"net_gameToCenter.loadPlayerResult\",\"114\":\"net_gameToCenter.heartbeatResult\",\"115\":\"net_gameToCenter.notifyTopicChat\",\"116\":\"net_gameToCenter.notifyTopicChatRoom\",\"117\":\"net_gameToCenter.notifyExecCmd\",\"118\":\"net_gameToCenter.notifyDailyDupCommon\",\"119\":\"net_gameToCenter.notifyTargetConditionComplete\",\"120\":\"net_gameToCenter.notifyRankRewards\",\"1202\":\"net_shop.buy\",\"1203\":\"net_shop.refresh\",\"1204\":\"net_shop.buyResult\",\"1205\":\"net_shop.refreshResult\",\"1206\":\"net_shop.updateShop\",\"121\":\"net_gameToCenter.notifyGuildRankRewards\",\"122\":\"net_gameToCenter.notifyGmMail\",\"123\":\"net_gameToCenter.notifyOperationsEventList\",\"124\":\"net_gameToCenter.notifyGroupPurchaseRewards\",\"125\":\"net_gameToCenter.notifyLunaBattleLineGarrison\",\"126\":\"net_gameToCenter.notifyNewbiesData\",\"127\":\"net_gameToCenter.notifyNewbiesUpdate\",\"128\":\"net_gameToCenter.notifyStandardMail\",\"129\":\"net_gameToCenter.notifyTargetCheckStatusUpdate\",\"130\":\"net_gameToCenter.notifyCenterServerDiscreteData\",\"1302\":\"net_maze.enterMaze\",\"1303\":\"net_maze.mazeSettlement\",\"1304\":\"net_maze.saveMaze\",\"1305\":\"net_maze.restoreMaze\",\"1306\":\"net_maze.revive\",\"1307\":\"net_maze.uploadMazeQuestProgress\",\"1308\":\"net_maze.uploadMazeAlienEventUnlock\",\"1309\":\"net_maze.enterMazeResult\",\"131\":\"net_gameToCenter.notifyGuildTrainingMail\",\"1310\":\"net_maze.mazeSettlementResult\",\"1311\":\"net_maze.saveMazeResult\",\"1312\":\"net_maze.restoreMazeResult\",\"1313\":\"net_maze.reviveResult\",\"1314\":\"net_maze.uploadMazeQuestProgressResult\",\"1315\":\"net_maze.uploadMazeAlienEventUnlockResult\",\"1316\":\"net_maze.notifyFinishMaze\",\"1317\":\"net_maze.notifyUpdateMazeInfo\",\"1318\":\"net_maze.notifyUnlockRune\",\"1319\":\"net_maze.openHiddenMaze\",\"132\":\"net_gameToCenter.notifyQuitGuild\",\"1320\":\"net_maze.buyMazeCount\",\"1321\":\"net_maze.mopUp\",\"1322\":\"net_maze.openHiddenMazeResult\",\"1323\":\"net_maze.buyMazeCountResult\",\"1324\":\"net_maze.mopUpResult\",\"1325\":\"net_maze.notifyUpdateOpenExtraMazes\",\"1326\":\"net_maze.abandonMaze\",\"1327\":\"net_maze.abandonMazeResult\",\"1328\":\"net_maze.enterAbyssMaze\",\"1329\":\"net_maze.enterAbyssMazeResult\",\"133\":\"net_gameToCenter.notifyPlaceGameRankMail\",\"1330\":\"net_maze.notifyUpdateCurrMazes\",\"1331\":\"net_maze.enterHiddenMaze\",\"1332\":\"net_maze.enterHiddenMazeResult\",\"1333\":\"net_maze.uploadMazeMonsterUnlock\",\"1334\":\"net_maze.uploadMazeMonsterUnlockResult\",\"1335\":\"net_maze.enterIllusionMaze\",\"1336\":\"net_maze.enterIllusionMazeResult\",\"1337\":\"net_maze.notifyAbyssCid\",\"1338\":\"net_maze.enterTestMaze\",\"1339\":\"net_maze.enterTestMazeResult\",\"1340\":\"net_maze.illusionMopUp\",\"1341\":\"net_maze.illusionMopUpResult\",\"1342\":\"net_maze.notifyAbyssCids\",\"1343\":\"net_maze.quickChallenge\",\"1344\":\"net_maze.quickChallengeResult\",\"1345\":\"net_maze.notifyBossEnd\",\"1402\":\"net_dress.wear\",\"1403\":\"net_dress.viewDress\",\"1404\":\"net_dress.wearResult\",\"1405\":\"net_dress.viewDressResult\",\"1406\":\"net_dress.notifyUpdateDress\",\"1502\":\"net_dating.dating\",\"1503\":\"net_dating.datingResult\",\"1504\":\"net_dating.notifyDatingEnd\",\"1505\":\"net_dating.notifyDating\",\"1602\":\"net_dialog.selectDialog\",\"1603\":\"net_dialog.selectDialogResult\",\"1604\":\"net_dialog.notifyOpenDialog\",\"1702\":\"net_miniGame.chooseCard\",\"1703\":\"net_miniGame.chooseCardResult\",\"1704\":\"net_miniGame.notifyStartCardGame\",\"1705\":\"net_miniGame.turntableEnd\",\"1706\":\"net_miniGame.turntableEndResult\",\"1707\":\"net_miniGame.notifyStartTurntable\",\"1802\":\"net_home.enterHome\",\"1803\":\"net_home.exitHome\",\"1804\":\"net_home.harvestBuilding\",\"1805\":\"net_home.harvestLand\",\"1806\":\"net_home.plant\",\"1807\":\"net_home.unlockRoom\",\"1808\":\"net_home.changeSuit\",\"1809\":\"net_home.visitHome\",\"1810\":\"net_home.triggerPlot\",\"1811\":\"net_home.unlockSuit\",\"1812\":\"net_home.cook\",\"1813\":\"net_home.cancelCook\",\"1814\":\"net_home.rewardCook\",\"1815\":\"net_home.recordDailyAction\",\"1816\":\"net_home.changeRoomName\",\"1817\":\"net_home.enterRoom\",\"1818\":\"net_home.switchRoomShow\",\"1819\":\"net_home.receiveComfortLvAwards\",\"1820\":\"net_home.completeCook\",\"1821\":\"net_home.startWork\",\"1822\":\"net_home.rewardWork\",\"1823\":\"net_home.completePlant\",\"1824\":\"net_home.cancelPlant\",\"1825\":\"net_home.make\",\"1826\":\"net_home.cancelMake\",\"1827\":\"net_home.rewardMake\",\"1828\":\"net_home.completeMake\",\"1829\":\"net_home.help\",\"1830\":\"net_home.openVisitTreasureChest\",\"1831\":\"net_home.receiveComfortAwards\",\"1832\":\"net_home.saveRoomDecorate\",\"1833\":\"net_home.resetAffair\",\"1834\":\"net_home.enterHomeResult\",\"1835\":\"net_home.exitHomeResult\",\"1836\":\"net_home.harvestBuildingResult\",\"1837\":\"net_home.harvestLandResult\",\"1838\":\"net_home.plantResult\",\"1839\":\"net_home.unlockRoomResult\",\"1840\":\"net_home.changeSuitResult\",\"1841\":\"net_home.visitHomeResult\",\"1842\":\"net_home.triggerPlotResult\",\"1843\":\"net_home.unlockSuitResult\",\"1844\":\"net_home.cookResult\",\"1845\":\"net_home.cancelCookResult\",\"1846\":\"net_home.rewardCookResult\",\"1847\":\"net_home.recordDailyActionResult\",\"1848\":\"net_home.changeRoomNameResult\",\"1849\":\"net_home.enterRoomResult\",\"1850\":\"net_home.switchRoomShowResult\",\"1851\":\"net_home.receiveComfortLvAwardsResult\",\"1852\":\"net_home.completeCookResult\",\"1853\":\"net_home.startWorkResult\",\"1854\":\"net_home.rewardWorkResult\",\"1855\":\"net_home.completePlantResult\",\"1856\":\"net_home.cancelPlantResult\",\"1857\":\"net_home.makeResult\",\"1858\":\"net_home.cancelMakeResult\",\"1859\":\"net_home.rewardMakeResult\",\"1860\":\"net_home.completeMakeResult\",\"1861\":\"net_home.helpResult\",\"1862\":\"net_home.openVisitTreasureChestResult\",\"1863\":\"net_home.receiveComfortAwardsResult\",\"1864\":\"net_home.saveRoomDecorateResult\",\"1865\":\"net_home.resetAffairResult\",\"1866\":\"net_home.notifyUnlockCookBook\",\"1867\":\"net_home.notifyUnlockSuit\",\"1868\":\"net_home.notifyUpdateBasicHome\",\"1869\":\"net_home.notifyUpdateLand\",\"1870\":\"net_home.notifyUpdateBuilding\",\"1871\":\"net_home.notifyUpdateRoom\",\"1872\":\"net_home.notifyUnlockManufactureItem\",\"1873\":\"net_home.notifyActivationDecorates\",\"1874\":\"net_home.notifyHomeRole\",\"1875\":\"net_home.receiveLetter\",\"1876\":\"net_home.receiveLetterResult\",\"1877\":\"net_home.updateBuildingLv\",\"1878\":\"net_home.undoAffair\",\"1879\":\"net_home.updateBuildingLvResult\",\"1880\":\"net_home.undoAffairResult\",\"1881\":\"net_home.compound\",\"1882\":\"net_home.decompose\",\"1883\":\"net_home.compoundResult\",\"1884\":\"net_home.decomposeResult\",\"1885\":\"net_home.decomposeDecorate\",\"1886\":\"net_home.unlockLand\",\"1887\":\"net_home.decomposeDecorateResult\",\"1888\":\"net_home.unlockLandResult\",\"1902\":\"net_girl.getGirls\",\"1903\":\"net_girl.exitGirls\",\"1904\":\"net_girl.getGirlsResult\",\"1905\":\"net_girl.exitGirlsResult\",\"1906\":\"net_girl.giveGift\",\"1907\":\"net_girl.giveGiftResult\",\"1908\":\"net_girl.fondle\",\"1909\":\"net_girl.fondleResult\",\"1910\":\"net_girl.notifyFondleNumRecovery\",\"1911\":\"net_girl.connective\",\"1912\":\"net_girl.getSoulOath\",\"1913\":\"net_girl.connectiveResult\",\"1914\":\"net_girl.getSoulOathResult\",\"202\":\"net_gameToGame.openHomeBox\",\"203\":\"net_gameToGame.helpHome\",\"2202\":\"net_town.shopping\",\"2203\":\"net_town.execMainline\",\"2204\":\"net_town.enterArea\",\"2205\":\"net_town.shoppingResult\",\"2206\":\"net_town.execMainlineResult\",\"2207\":\"net_town.enterAreaResult\",\"2208\":\"net_town.notifyUnlockArea\",\"2209\":\"net_town.notifyEvent\",\"2210\":\"net_town.notifyShoppingFinish\",\"2211\":\"net_town.notifyMainlineFinish\",\"2212\":\"net_town.notifyShoppingEventRefresh\",\"2213\":\"net_town.notifyTownFunctionOpen\",\"2402\":\"net_lottery.lottery\",\"2403\":\"net_lottery.lotteryResult\",\"2404\":\"net_lottery.getLotteryHistory\",\"2405\":\"net_lottery.getLotteryHistoryResult\",\"2502\":\"net_mall.buy\",\"2503\":\"net_mall.buyResult\",\"2504\":\"net_mall.notifyMallRefresh\",\"2505\":\"net_mall.notifyMallStartSellTime\",\"2602\":\"net_library.openLibrary\",\"2603\":\"net_library.openLibraryResult\",\"2604\":\"net_library.viewNewsBook\",\"2605\":\"net_library.viewNewsBookResult\",\"2606\":\"net_library.getNewsBookRewards\",\"2607\":\"net_library.getNewsBookRewardsResult\",\"2702\":\"net_soulPrefab.wearEquipment\",\"2703\":\"net_soulPrefab.dumpEquipment\",\"2704\":\"net_soulPrefab.upgradeEquipment\",\"2705\":\"net_soulPrefab.upStarEquipment\",\"2706\":\"net_soulPrefab.decpEquipment\",\"2707\":\"net_soulPrefab.changeSoulPrefab\",\"2708\":\"net_soulPrefab.changeFormationPos\",\"2709\":\"net_soulPrefab.exchangeEquipment\",\"2710\":\"net_soulPrefab.wearEquipmentResult\",\"2711\":\"net_soulPrefab.dumpEquipmentResult\",\"2712\":\"net_soulPrefab.upgradeEquipmentResult\",\"2713\":\"net_soulPrefab.upStarEquipmentResult\",\"2714\":\"net_soulPrefab.decpEquipmentResult\",\"2715\":\"net_soulPrefab.changeSoulPrefabResult\",\"2716\":\"net_soulPrefab.changeFormationPosResult\",\"2717\":\"net_soulPrefab.exchangeEquipmentResult\",\"2718\":\"net_soulPrefab.notifySoulPrefab\",\"2719\":\"net_soulPrefab.wearEquipmentPrefab\",\"2720\":\"net_soulPrefab.saveEquipmentPrefab\",\"2721\":\"net_soulPrefab.wearEquipmentPrefabResult\",\"2722\":\"net_soulPrefab.saveEquipmentPrefabResult\",\"2723\":\"net_soulPrefab.notifyEquipmentPrefabChange\",\"2724\":\"net_soulPrefab.coverEquipments\",\"2725\":\"net_soulPrefab.coverEquipmentsResult\",\"2726\":\"net_soulPrefab.changEquipmentPrefabName\",\"2727\":\"net_soulPrefab.changEquipmentPrefabNameResult\",\"2728\":\"net_soulPrefab.setJewelrySpeed\",\"2729\":\"net_soulPrefab.setJewelrySpeedResult\",\"2802\":\"net_dailyDup.buyCount\",\"2803\":\"net_dailyDup.buyCountResult\",\"2804\":\"net_dailyDup.notifyDailyDup\",\"2902\":\"net_fight.fightOver\",\"2903\":\"net_fight.notifyStartFight\",\"3002\":\"net_challenge.challengeDup\",\"3003\":\"net_challenge.sweeping\",\"3004\":\"net_challenge.challengeDupResult\",\"3005\":\"net_challenge.sweepingResult\",\"3006\":\"net_challenge.notifyChallengeComplete\",\"3102\":\"net_tower.climbingTower\",\"3103\":\"net_tower.climbingTowerResult\",\"3104\":\"net_tower.notifyClimbingTowerComplete\",\"3202\":\"net_worldBoss.attack\",\"3203\":\"net_worldBoss.attackResult\",\"3204\":\"net_worldBoss.notifyAttackComplete\",\"3402\":\"net_soulNewStory.experienceNewStoryChapter\",\"3403\":\"net_soulNewStory.experienceNewStoryChapterResult\",\"3404\":\"net_soulNewStory.notifyCompleteNewStoryChapter\",\"3405\":\"net_soulNewStory.notifyUpdateSoulNewStory\",\"3602\":\"net_soulMemory.activeMemoryPiece\",\"3603\":\"net_soulMemory.experienceMemory\",\"3604\":\"net_soulMemory.getRewards\",\"3605\":\"net_soulMemory.viewMemory\",\"3606\":\"net_soulMemory.activeMemoryPieceResult\",\"3607\":\"net_soulMemory.experienceMemoryResult\",\"3608\":\"net_soulMemory.getRewardsResult\",\"3609\":\"net_soulMemory.viewMemoryResult\",\"3610\":\"net_soulMemory.notifyUpdateSoulMemoryChapter\",\"3611\":\"net_soulMemory.notifySoulMemoryDressProgress\",\"3702\":\"net_active.reciveFood\",\"3703\":\"net_active.reciveFoodResult\",\"3704\":\"net_active.sign\",\"3705\":\"net_active.signResult\",\"3706\":\"net_active.notifySign\",\"3707\":\"net_active.luckDraw\",\"3708\":\"net_active.getLuckDrawHistory\",\"3709\":\"net_active.luckDrawResult\",\"3710\":\"net_active.getLuckDrawHistoryResult\",\"3711\":\"net_active.getLvReachRewardList\",\"3712\":\"net_active.getLvReachReward\",\"3713\":\"net_active.getLvReachRewardListResult\",\"3714\":\"net_active.getLvReachRewardResult\",\"3715\":\"net_active.getRefundsGiftPacks\",\"3716\":\"net_active.getRefundsGiftPacksResult\",\"3717\":\"net_active.notifyRefundsGiftPacksUpdate\",\"3802\":\"net_user.validateUUID\",\"3803\":\"net_user.chooseRole\",\"3804\":\"net_user.createRole\",\"3805\":\"net_user.ping\",\"3806\":\"net_user.logout\",\"3807\":\"net_user.validateUUIDResult\",\"3808\":\"net_user.chooseRoleResult\",\"3809\":\"net_user.createRoleResult\",\"3810\":\"net_user.pang\",\"3811\":\"net_user.logoutResult\",\"3812\":\"net_user.notifyServerStatus\",\"3813\":\"net_user.notifyError\",\"3814\":\"net_user.handselSoul\",\"3815\":\"net_user.handselSoulResult\",\"3816\":\"net_user.reconnect\",\"3817\":\"net_user.reconnectResult\",\"3902\":\"net_player.loadPlayer\",\"3903\":\"net_player.disbindRole\",\"3904\":\"net_player.changeData\",\"3905\":\"net_player.getPlayerInfo\",\"3906\":\"net_player.sendGiftCode\",\"3907\":\"net_player.changeShowSoul\",\"3908\":\"net_player.triggerGuide\",\"3909\":\"net_player.refreshReadPoint\",\"3910\":\"net_player.loadPlayerResult\",\"3911\":\"net_player.disbindRoleResult\",\"3912\":\"net_player.changeDataResult\",\"3913\":\"net_player.getPlayerInfoResult\",\"3914\":\"net_player.sendGiftCodeResult\",\"3915\":\"net_player.changeShowSoulResult\",\"3916\":\"net_player.triggerGuideResult\",\"3917\":\"net_player.refreshReadPointResult\",\"3918\":\"net_player.updateBaseInfo\",\"3919\":\"net_player.updateAttributes\",\"3920\":\"net_player.notifyFunctionTypeOpen\",\"3921\":\"net_player.notifyUnlockEvent\",\"3922\":\"net_player.notifyEnergyRecovery\",\"3923\":\"net_player.updatePlayerGlobalBuff\",\"3924\":\"net_player.notifyNumAttr\",\"3925\":\"net_player.notifyUnLockHeadIcon\",\"3926\":\"net_player.notifyUnLockLoginBackground\",\"3927\":\"net_player.notifyWeather\",\"3928\":\"net_player.notifyReadPoint\",\"3929\":\"net_player.notifyUpdatePlayerParams\",\"3930\":\"net_player.notifyEffectNotice\",\"3931\":\"net_player.notifyTodayOpenVisitTreasureChest\",\"3932\":\"net_player.notifyTodayHelpHomeCount\",\"3933\":\"net_player.notifyTodayHelpBuildingCount\",\"3934\":\"net_player.notifyUnlockTownEvent\",\"3935\":\"net_player.notifyDailyReset\",\"3936\":\"net_player.notifyRecharge\",\"3937\":\"net_player.notifyPayInfo\",\"3938\":\"net_player.notifyMonthCard\",\"3939\":\"net_player.notifyUnLockAvatarFrame\",\"3940\":\"net_player.saveSettingData\",\"3941\":\"net_player.saveSettingDataResult\",\"3942\":\"net_player.notifyItemDebts\",\"3943\":\"net_player.notifyChatEmojiUnlock\",\"3944\":\"net_player.notifyUnLockTitle\",\"3945\":\"net_player.saveShowCollectItems\",\"3946\":\"net_player.saveShowCollectItemsResult\",\"3947\":\"net_player.buyAdvanceLevelChase\",\"3948\":\"net_player.buyAdvanceLevelChaseResult\",\"3949\":\"net_player.notifyExecution\",\"3950\":\"net_player.notifySoulWhisperUnlock\",\"3951\":\"net_player.notifyHeadIconTimelimit\",\"3952\":\"net_player.notifyAvatarFrameTimelimit\",\"3953\":\"net_player.notifyTitleTimelimit\",\"3954\":\"net_player.useEquipSkin\",\"3955\":\"net_player.useEquipSkinResult\",\"3956\":\"net_player.notifyEquipSkinUpdate\",\"3957\":\"net_player.notifyRandomMallUpdate\",\"3958\":\"net_player.notifyUnLockGirlBackground\",\"3959\":\"net_player.notifyUnLockChatBackground\",\"3960\":\"net_player.savePlayerSetting\",\"3961\":\"net_player.savePlayerSettingResult\",\"3962\":\"net_player.dressUpRotateSwitch\",\"3963\":\"net_player.dressUpRotateList\",\"3964\":\"net_player.dressUpRotateSwitchResult\",\"3965\":\"net_player.dressUpRotateListResult\",\"4002\":\"net_item.sellItem\",\"4003\":\"net_item.useItem\",\"4004\":\"net_item.destroyItem\",\"4005\":\"net_item.sellItemResult\",\"4006\":\"net_item.useItemResult\",\"4007\":\"net_item.destroyItemResult\",\"4008\":\"net_item.exchange\",\"4009\":\"net_item.exchangeBatch\",\"4010\":\"net_item.exchangeResult\",\"4011\":\"net_item.exchangeBatchResult\",\"4012\":\"net_item.lockEquipment\",\"4013\":\"net_item.lockEquipmentResult\",\"4014\":\"net_item.optionalGift\",\"4015\":\"net_item.optionalGiftResult\",\"4102\":\"net_warehouse.notifyItemChange\",\"4202\":\"net_worldnotice.broadcastShopBuy\",\"4302\":\"net_quest.commitQuest\",\"4303\":\"net_quest.giveUpQuest\",\"4304\":\"net_quest.commitQuestResult\",\"4305\":\"net_quest.giveUpQuestResult\",\"4306\":\"net_quest.notifyUpdateQuest\",\"4307\":\"net_quest.notifyFinishQuestList\",\"4308\":\"net_quest.notifyFailQuestList\",\"4309\":\"net_quest.notifyAutoCommit\",\"4310\":\"net_quest.unlockChapterTasks\",\"4311\":\"net_quest.unlockChapterTasksResult\",\"4402\":\"net_formation.changeFormationName\",\"4403\":\"net_formation.exchangeSoulPrefab\",\"4404\":\"net_formation.changeFormationNameResult\",\"4405\":\"net_formation.exchangeSoulPrefabResult\",\"4406\":\"net_formation.notifyFomationUpdate\",\"4407\":\"net_formation.copyFormation\",\"4408\":\"net_formation.copyFormationResult\",\"4502\":\"net_mail.getMails\",\"4503\":\"net_mail.readMail\",\"4504\":\"net_mail.pickUp\",\"4505\":\"net_mail.delMail\",\"4506\":\"net_mail.getMailsResult\",\"4507\":\"net_mail.readMailResult\",\"4508\":\"net_mail.pickUpResult\",\"4509\":\"net_mail.delMailResult\",\"4510\":\"net_mail.notifyNewMail\",\"4602\":\"net_soul.unlock\",\"4603\":\"net_soul.useSoulExpItem\",\"4604\":\"net_soul.evolution\",\"4605\":\"net_soul.activeTalent\",\"4606\":\"net_soul.activeTalentGroup\",\"4607\":\"net_soul.unlockSkillGroup\",\"4608\":\"net_soul.activationSkillStrengthen\",\"4609\":\"net_soul.unlockResult\",\"4610\":\"net_soul.useSoulExpItemResult\",\"4611\":\"net_soul.evolutionResult\",\"4612\":\"net_soul.activeTalentResult\",\"4613\":\"net_soul.activeTalentGroupResult\",\"4614\":\"net_soul.unlockSkillGroupResult\",\"4615\":\"net_soul.activationSkillStrengthenResult\",\"4616\":\"net_soul.notifySoulMood\",\"4617\":\"net_soul.updateSoul\",\"4618\":\"net_soul.notifyRepetitionUnlockSoul\",\"4619\":\"net_soul.activeSpecialSpirit\",\"4620\":\"net_soul.activeSpecialSpiritResult\",\"4702\":\"net_rpgMaze.notifyTicketsUpdate\",\"4703\":\"net_rpgMaze.challengeBoss\",\"4704\":\"net_rpgMaze.challengeExBoss\",\"4705\":\"net_rpgMaze.challengeBossResult\",\"4706\":\"net_rpgMaze.challengeExBossResult\",\"4707\":\"net_rpgMaze.notifyChallengeBossComplete\",\"4708\":\"net_rpgMaze.notifyChallengeExBossComplete\",\"4709\":\"net_rpgMaze.enterRPGMaze\",\"4710\":\"net_rpgMaze.enterRPGMazeResult\",\"4802\":\"net_battlePasses.getRewards\",\"4803\":\"net_battlePasses.getLastSeasonRewards\",\"4804\":\"net_battlePasses.getRewardsResult\",\"4805\":\"net_battlePasses.getLastSeasonRewardsResult\",\"4902\":\"net_operationsEvent.notifyAllEventStatus\",\"4903\":\"net_operationsEvent.notifyOperationsEventData\",\"5002\":\"net_operationsGroupPurchase.groupPurchaseBuy\",\"5003\":\"net_operationsGroupPurchase.groupPurchaseBuyResult\",\"5102\":\"net_operationsImagePuzzle.imagePuzzleUnlock\",\"5103\":\"net_operationsImagePuzzle.imagePuzzleGetUnlockReward\",\"5104\":\"net_operationsImagePuzzle.imagePuzzleGetReward\",\"5105\":\"net_operationsImagePuzzle.imagePuzzleUnlockResult\",\"5106\":\"net_operationsImagePuzzle.imagePuzzleGetUnlockRewardResult\",\"5107\":\"net_operationsImagePuzzle.imagePuzzleGetRewardResult\",\"5202\":\"net_operationsMagicMuseum.attack\",\"5203\":\"net_operationsMagicMuseum.attackResult\",\"5204\":\"net_operationsMagicMuseum.notifyMuseumAttackRet\",\"5302\":\"net_operationsNewCharacter.newCharacterUnlock\",\"5303\":\"net_operationsNewCharacter.bingoLog\",\"5304\":\"net_operationsNewCharacter.newCharacterStory\",\"5305\":\"net_operationsNewCharacter.newCharacterUnlockResult\",\"5306\":\"net_operationsNewCharacter.bingoLogResult\",\"5307\":\"net_operationsNewCharacter.newCharacterStoryResult\",\"5308\":\"net_operationsNewCharacter.notifyNewCharacterStoryFinished\",\"5402\":\"net_operationsGachaPool.draw\",\"5403\":\"net_operationsGachaPool.drawResult\",\"5404\":\"net_operationsGachaPool.refresh\",\"5405\":\"net_operationsGachaPool.refreshResult\",\"5502\":\"net_operationsDoubleFight.fight\",\"5503\":\"net_operationsDoubleFight.getRewards\",\"5504\":\"net_operationsDoubleFight.fightResult\",\"5505\":\"net_operationsDoubleFight.getRewardsResult\",\"5506\":\"net_operationsDoubleFight.notifyFightComplete\",\"5507\":\"net_operationsDoubleFight.notifyUpdateDoubleFightStepPOD\",\"5602\":\"net_lunaBattleLine.garrison\",\"5603\":\"net_lunaBattleLine.getAssists\",\"5604\":\"net_lunaBattleLine.refreshAssist\",\"5605\":\"net_lunaBattleLine.getStrengthenSoulPrefab\",\"5606\":\"net_lunaBattleLine.garrisonResult\",\"5607\":\"net_lunaBattleLine.getAssistsResult\",\"5608\":\"net_lunaBattleLine.refreshAssistResult\",\"5609\":\"net_lunaBattleLine.getStrengthenSoulPrefabResult\",\"5610\":\"net_lunaBattleLine.enterFortMaze\",\"5611\":\"net_lunaBattleLine.enterSealMaze\",\"5612\":\"net_lunaBattleLine.enterStrengthenMaze\",\"5613\":\"net_lunaBattleLine.enterFortMazeResult\",\"5614\":\"net_lunaBattleLine.enterSealMazeResult\",\"5615\":\"net_lunaBattleLine.enterStrengthenMazeResult\",\"5616\":\"net_lunaBattleLine.broadcastGarrison\",\"5702\":\"net_operationsSpaceTreasure.explore\",\"5703\":\"net_operationsSpaceTreasure.exploreResult\",\"5802\":\"net_operationsFurnitureGache.draw\",\"5803\":\"net_operationsFurnitureGache.drawResult\",\"5902\":\"net_dreamMap.enterMap\",\"5903\":\"net_dreamMap.resetMap\",\"5904\":\"net_dreamMap.openCell\",\"5905\":\"net_dreamMap.enterMapResult\",\"5906\":\"net_dreamMap.resetMapResult\",\"5907\":\"net_dreamMap.openCellResult\",\"5908\":\"net_dreamMap.selectDialog\",\"5909\":\"net_dreamMap.selectDialogResult\",\"5910\":\"net_dreamMap.notifyOpenDialog\",\"5911\":\"net_dreamMap.markCell\",\"5912\":\"net_dreamMap.markCellResult\",\"6002\":\"net_operationsPanda.action\",\"6003\":\"net_operationsPanda.getGift\",\"6004\":\"net_operationsPanda.enterBambooForest\",\"6005\":\"net_operationsPanda.explore\",\"6006\":\"net_operationsPanda.doEvent\",\"6007\":\"net_operationsPanda.actionResult\",\"6008\":\"net_operationsPanda.getGiftResult\",\"6009\":\"net_operationsPanda.enterBambooForestResult\",\"6010\":\"net_operationsPanda.exploreResult\",\"6011\":\"net_operationsPanda.doEventResult\",\"6012\":\"net_operationsPanda.notifyCompleteEvent\",\"6013\":\"net_operationsPanda.notifyFightComplete\",\"6014\":\"net_operationsPanda.selectDialog\",\"6015\":\"net_operationsPanda.selectDialogResult\",\"6016\":\"net_operationsPanda.notifyOpenDialog\",\"6102\":\"net_operationsTreasureHunt.exchangeTreasureGift\",\"6103\":\"net_operationsTreasureHunt.exchangeTreasureGiftResult\",\"6202\":\"net_operationsVote.vote\",\"6203\":\"net_operationsVote.voteResult\",\"6302\":\"net_operationsHelpNewbies.submitInviteCode\",\"6303\":\"net_operationsHelpNewbies.confirmTask\",\"6304\":\"net_operationsHelpNewbies.submitInviteCodeResult\",\"6305\":\"net_operationsHelpNewbies.confirmTaskResult\",\"6402\":\"net_taleChallenge.triggerChallengeStory\",\"6403\":\"net_taleChallenge.triggerChallengeFight\",\"6404\":\"net_taleChallenge.triggerChallengeBoss\",\"6405\":\"net_taleChallenge.triggerChallengeStoryResult\",\"6406\":\"net_taleChallenge.triggerChallengeFightResult\",\"6407\":\"net_taleChallenge.triggerChallengeBossResult\",\"6408\":\"net_taleChallenge.notifyTaleChallengeStoryFinished\",\"6409\":\"net_taleChallenge.notifyChallengeFightRet\",\"6410\":\"net_taleChallenge.notifyChallengeBossRet\",\"6411\":\"net_taleChallenge.selectDialog\",\"6412\":\"net_taleChallenge.selectDialogResult\",\"6413\":\"net_taleChallenge.notifyOpenDialog\",\"6414\":\"net_taleChallenge.draw\",\"6415\":\"net_taleChallenge.drawResult\",\"6502\":\"net_dualTeamExplore.challengeBoss\",\"6503\":\"net_dualTeamExplore.challengeExBoss\",\"6504\":\"net_dualTeamExplore.challengeBossResult\",\"6505\":\"net_dualTeamExplore.challengeExBossResult\",\"6506\":\"net_dualTeamExplore.notifyChallengeBossComplete\",\"6507\":\"net_dualTeamExplore.notifyChallengeExBossComplete\",\"6508\":\"net_dualTeamExplore.notifyTicketsUpdate\",\"6509\":\"net_dualTeamExplore.enterLevel\",\"6510\":\"net_dualTeamExplore.move\",\"6511\":\"net_dualTeamExplore.enterLevelResult\",\"6512\":\"net_dualTeamExplore.moveResult\",\"6513\":\"net_dualTeamExplore.notifyExecution\",\"6514\":\"net_dualTeamExplore.notifyShowGetItems\",\"6515\":\"net_dualTeamExplore.notifyNodeUpdate\",\"6516\":\"net_dualTeamExplore.notifyTeamStatus\",\"6517\":\"net_dualTeamExplore.notifyLevelStatus\",\"6518\":\"net_dualTeamExplore.notifyTeamMemberAttr\",\"6519\":\"net_dualTeamExplore.notifyLevelSettlement\",\"6520\":\"net_dualTeamExplore.selectDialog\",\"6521\":\"net_dualTeamExplore.selectDialogResult\",\"6522\":\"net_dualTeamExplore.notifyOpenDialog\",\"6523\":\"net_dualTeamExplore.fight\",\"6524\":\"net_dualTeamExplore.fightResult\",\"6525\":\"net_dualTeamExplore.notifyFightComplete\",\"6526\":\"net_dualTeamExplore.enterDualTeamMaze\",\"6527\":\"net_dualTeamExplore.enterDualTeamMazeResult\",\"6528\":\"net_dualTeamExplore.plotLevel\",\"6529\":\"net_dualTeamExplore.plotLevelResult\",\"6530\":\"net_dualTeamExplore.giveup\",\"6531\":\"net_dualTeamExplore.giveupResult\",\"6532\":\"net_dualTeamExplore.numberInput\",\"6533\":\"net_dualTeamExplore.numberInputResult\",\"6534\":\"net_dualTeamExplore.revive\",\"6535\":\"net_dualTeamExplore.reviveResult\",\"6536\":\"net_dualTeamExplore.useItem\",\"6537\":\"net_dualTeamExplore.useItemResult\",\"6538\":\"net_dualTeamExplore.notifyFight\",\"6602\":\"net_magicTower.enterMap\",\"6603\":\"net_magicTower.giveup\",\"6604\":\"net_magicTower.move\",\"6605\":\"net_magicTower.enterMapResult\",\"6606\":\"net_magicTower.giveupResult\",\"6607\":\"net_magicTower.moveResult\",\"6608\":\"net_magicTower.notifyExecution\",\"6609\":\"net_magicTower.notifySettlement\",\"6610\":\"net_magicTower.selectDialog\",\"6611\":\"net_magicTower.selectDialogResult\",\"6612\":\"net_magicTower.notifyOpenDialog\",\"6702\":\"net_fishing.fishing\",\"6703\":\"net_fishing.fishingConfirm\",\"6704\":\"net_fishing.illegalFishing\",\"6705\":\"net_fishing.fishingResult\",\"6706\":\"net_fishing.fishingConfirmResult\",\"6707\":\"net_fishing.illegalFishingResult\",\"6708\":\"net_fishing.notifyFishSpecimen\",\"6709\":\"net_fishing.exchangeFish\",\"6710\":\"net_fishing.exchangeFishResult\",\"6711\":\"net_fishing.exchangeFishByType\",\"6712\":\"net_fishing.exchangeFishByTypeResult\",\"6713\":\"net_fishing.automaticFishing\",\"6714\":\"net_fishing.drawRewards\",\"6715\":\"net_fishing.automaticFishingResult\",\"6716\":\"net_fishing.drawRewardsResult\",\"6717\":\"net_fishing.notifyFishOpen\",\"6802\":\"net_miniGalGame.startNewGame\",\"6803\":\"net_miniGalGame.loadGame\",\"6804\":\"net_miniGalGame.saveGame\",\"6805\":\"net_miniGalGame.selectDialog\",\"6806\":\"net_miniGalGame.shopBuy\",\"6807\":\"net_miniGalGame.itemUse\",\"6808\":\"net_miniGalGame.submitMiniGameOver\",\"6809\":\"net_miniGalGame.triggerEvent\",\"6810\":\"net_miniGalGame.towerFight\",\"6811\":\"net_miniGalGame.callFromGirl\",\"6812\":\"net_miniGalGame.startNewGameResult\",\"6813\":\"net_miniGalGame.loadGameResult\",\"6814\":\"net_miniGalGame.saveGameResult\",\"6815\":\"net_miniGalGame.selectDialogResult\",\"6816\":\"net_miniGalGame.shopBuyResult\",\"6817\":\"net_miniGalGame.itemUseResult\",\"6818\":\"net_miniGalGame.submitMiniGameOverResult\",\"6819\":\"net_miniGalGame.triggerEventResult\",\"6820\":\"net_miniGalGame.towerFightResult\",\"6821\":\"net_miniGalGame.callFromGirlResult\",\"6822\":\"net_miniGalGame.notifyOpenDialog\",\"6823\":\"net_miniGalGame.notifyGalItemsStatus\",\"6824\":\"net_miniGalGame.notifyGalTaskFinish\",\"6825\":\"net_miniGalGame.notifyGalShop\",\"6826\":\"net_miniGalGame.notifyGalGirlsData\",\"6827\":\"net_miniGalGame.notifyGalBaseData\",\"6828\":\"net_miniGalGame.notifyGalMiniGameStart\",\"6829\":\"net_miniGalGame.notifyFight\",\"6830\":\"net_miniGalGame.notifyUpdateSaveData\",\"6831\":\"net_miniGalGame.notifyScheduleList\",\"6832\":\"net_miniGalGame.notifyCallFromGirl\",\"6833\":\"net_miniGalGame.notifyEventTriggeredCount\",\"6834\":\"net_miniGalGame.notifyAchievementData\",\"6835\":\"net_miniGalGame.notifyLocalAchievementData\",\"6836\":\"net_miniGalGame.notifyItemUsedCount\",\"6837\":\"net_miniGalGame.notifyComplete\",\"6838\":\"net_miniGalGame.sendMessage\",\"6839\":\"net_miniGalGame.sendMessageResult\",\"6840\":\"net_miniGalGame.notifyMessageFromGirl\",\"6841\":\"net_miniGalGame.notifyMessageGroupCount\",\"6902\":\"net_evilErosion.wearEquipment\",\"6903\":\"net_evilErosion.dumpEquipment\",\"6904\":\"net_evilErosion.exchangeEquipment\",\"6905\":\"net_evilErosion.upStarEquipment\",\"6906\":\"net_evilErosion.decpEquipment\",\"6907\":\"net_evilErosion.changeFormationPos\",\"6908\":\"net_evilErosion.changePosition\",\"6909\":\"net_evilErosion.changeCustomSkills\",\"6910\":\"net_evilErosion.fight\",\"6911\":\"net_evilErosion.getDailySupply\",\"6912\":\"net_evilErosion.wearEquipmentResult\",\"6913\":\"net_evilErosion.dumpEquipmentResult\",\"6914\":\"net_evilErosion.exchangeEquipmentResult\",\"6915\":\"net_evilErosion.upStarEquipmentResult\",\"6916\":\"net_evilErosion.decpEquipmentResult\",\"6917\":\"net_evilErosion.changeFormationPosResult\",\"6918\":\"net_evilErosion.changePositionResult\",\"6919\":\"net_evilErosion.changeCustomSkillsResult\",\"6920\":\"net_evilErosion.fightResult\",\"6921\":\"net_evilErosion.getDailySupplyResult\",\"6922\":\"net_evilErosion.notifyFightComplete\",\"6923\":\"net_evilErosion.notifyUpdateSoulPrefab\",\"7002\":\"net_operationsTurntable.draw\",\"7003\":\"net_operationsTurntable.drawResult\",\"7102\":\"net_abyssPlus.enterLevel\",\"7103\":\"net_abyssPlus.challengeExBoss\",\"7104\":\"net_abyssPlus.enterLevelResult\",\"7105\":\"net_abyssPlus.challengeExBossResult\",\"7106\":\"net_abyssPlus.notifyChallengeExBossComplete\",\"7107\":\"net_abyssPlus.useRune\",\"7108\":\"net_abyssPlus.useRuneResult\",\"7202\":\"net_operationsLimitTurntable.draw\",\"7203\":\"net_operationsLimitTurntable.getHistory\",\"7204\":\"net_operationsLimitTurntable.drawResult\",\"7205\":\"net_operationsLimitTurntable.getHistoryResult\",\"7302\":\"net_operationsCupMatchVote.vote\",\"7303\":\"net_operationsCupMatchVote.voteResult\",\"7402\":\"net_guild.sign\",\"7403\":\"net_guild.getGuildQuestRewards\",\"7404\":\"net_guild.refreshRedPoint\",\"7405\":\"net_guild.signResult\",\"7406\":\"net_guild.getGuildQuestRewardsResult\",\"7407\":\"net_guild.refreshRedPointResult\",\"7502\":\"net_guildChallenge.attack\",\"7503\":\"net_guildChallenge.getRewards\",\"7504\":\"net_guildChallenge.mopup\",\"7505\":\"net_guildChallenge.getScore\",\"7506\":\"net_guildChallenge.attackResult\",\"7507\":\"net_guildChallenge.getRewardsResult\",\"7508\":\"net_guildChallenge.mopupResult\",\"7509\":\"net_guildChallenge.getScoreResult\",\"7510\":\"net_guildChallenge.notifyAttackComplete\",\"7602\":\"net_mining.enterMap\",\"7603\":\"net_mining.excavate\",\"7604\":\"net_mining.autoExcavate\",\"7605\":\"net_mining.interact\",\"7606\":\"net_mining.selectDialog\",\"7607\":\"net_mining.enterMapResult\",\"7608\":\"net_mining.excavateResult\",\"7609\":\"net_mining.autoExcavateResult\",\"7610\":\"net_mining.interactResult\",\"7611\":\"net_mining.notifyGridComplete\",\"7612\":\"net_mining.selectDialogResult\",\"7613\":\"net_mining.notifyEnterLayer\",\"7614\":\"net_mining.notifyOpenDialog\",\"7615\":\"net_mining.notifyFightComplete\",\"7616\":\"net_mining.notifyGetRewards\",\"7702\":\"net_jewelry.wear\",\"7703\":\"net_jewelry.unwear\",\"7704\":\"net_jewelry.upStar\",\"7705\":\"net_jewelry.upStarInBag\",\"7706\":\"net_jewelry.setSpeed\",\"7707\":\"net_jewelry.recycle\",\"7708\":\"net_jewelry.newWear\",\"7709\":\"net_jewelry.newUnWear\",\"7710\":\"net_jewelry.setJewelrySpeed\",\"7711\":\"net_jewelry.newUpStar\",\"7712\":\"net_jewelry.newRecycle\",\"7713\":\"net_jewelry.wearResult\",\"7714\":\"net_jewelry.unwearResult\",\"7715\":\"net_jewelry.upStarResult\",\"7716\":\"net_jewelry.upStarInBagResult\",\"7717\":\"net_jewelry.setSpeedResult\",\"7718\":\"net_jewelry.recycleResult\",\"7719\":\"net_jewelry.newWearResult\",\"7720\":\"net_jewelry.newUnWearResult\",\"7721\":\"net_jewelry.setJewelrySpeedResult\",\"7722\":\"net_jewelry.newUpStarResult\",\"7723\":\"net_jewelry.newRecycleResult\",\"7802\":\"net_singleWeakTower.fight\",\"7803\":\"net_singleWeakTower.fightResult\",\"7804\":\"net_singleWeakTower.notifyFightComplete\",\"7902\":\"net_commandChallengeLayer.startDrill\",\"7903\":\"net_commandChallengeLayer.startDrillResult\",\"7904\":\"net_commandChallengeLayer.notifyFightComplete\",\"8002\":\"net_flightChallenge.flightChallengeStart\",\"8003\":\"net_flightChallenge.flightChallengeLevelUp\",\"8004\":\"net_flightChallenge.flightChallengeEnd\",\"8005\":\"net_flightChallenge.flightChallengeBoss\",\"8006\":\"net_flightChallenge.flightChallengeStartResult\",\"8007\":\"net_flightChallenge.flightChallengeLevelUpResult\",\"8008\":\"net_flightChallenge.flightChallengeEndResult\",\"8009\":\"net_flightChallenge.flightChallengeBossResult\",\"8010\":\"net_flightChallenge.notifyFlightChallengeBossEnd\",\"9002\":\"net_guildTraining.attack\",\"9003\":\"net_guildTraining.attackResult\",\"9004\":\"net_guildTraining.notifyAttackEnd\",\"9005\":\"net_guildTraining.notifyQuitGuild\",\"9102\":\"net_restaurant.getRestaurantInfo\",\"9103\":\"net_restaurant.transactDocuments\",\"9104\":\"net_restaurant.practice\",\"9105\":\"net_restaurant.levelUp\",\"9106\":\"net_restaurant.work\",\"9107\":\"net_restaurant.receiveIncome\",\"9108\":\"net_restaurant.readBurst\",\"9109\":\"net_restaurant.openDialog\",\"9110\":\"net_restaurant.selectDialog\",\"9111\":\"net_restaurant.getProblem\",\"9112\":\"net_restaurant.answer\",\"9113\":\"net_restaurant.linkGameInfo\",\"9114\":\"net_restaurant.linkGame\",\"9115\":\"net_restaurant.puzzleInfo\",\"9116\":\"net_restaurant.puzzle\",\"9117\":\"net_restaurant.memoryFlopInfo\",\"9118\":\"net_restaurant.memoryFlop\",\"9119\":\"net_restaurant.combatTraining\",\"9120\":\"net_restaurant.bossTraining\",\"9121\":\"net_restaurant.getRestaurantInfoResult\",\"9122\":\"net_restaurant.transactDocumentsResult\",\"9123\":\"net_restaurant.practiceResult\",\"9124\":\"net_restaurant.levelUpResult\",\"9125\":\"net_restaurant.workResult\",\"9126\":\"net_restaurant.receiveIncomeResult\",\"9127\":\"net_restaurant.readBurstResult\",\"9128\":\"net_restaurant.openDialogResult\",\"9129\":\"net_restaurant.selectDialogResult\",\"9130\":\"net_restaurant.getProblemResult\",\"9131\":\"net_restaurant.answerResult\",\"9132\":\"net_restaurant.linkGameInfoResult\",\"9133\":\"net_restaurant.linkGameResult\",\"9134\":\"net_restaurant.puzzleInfoResult\",\"9135\":\"net_restaurant.puzzleResult\",\"9136\":\"net_restaurant.memoryFlopInfoResult\",\"9137\":\"net_restaurant.memoryFlopResult\",\"9138\":\"net_restaurant.combatTrainingResult\",\"9139\":\"net_restaurant.bossTrainingResult\",\"9140\":\"net_restaurant.notifyReceiveIncome\",\"9141\":\"net_restaurant.notifyBossTraining\",\"9142\":\"net_restaurant.notifyCombatTrainingBossEnd\",\"9143\":\"net_restaurant.notifyTaskFinish\",\"9144\":\"net_restaurant.notifyEventIsFinish\",\"9145\":\"net_restaurant.notifyEmergency\",\"9146\":\"net_restaurant.notifyEarnings\",\"9202\":\"net_placeGame.recruit\",\"9203\":\"net_placeGame.levelUp\",\"9204\":\"net_placeGame.dismissal\",\"9205\":\"net_placeGame.changeFormationName\",\"9206\":\"net_placeGame.goIntoBattle\",\"9207\":\"net_placeGame.modifySoul\",\"9208\":\"net_placeGame.changePosition\",\"9209\":\"net_placeGame.modifyWeapon\",\"9210\":\"net_placeGame.climbingTower\",\"9211\":\"net_placeGame.openTheBox\",\"9212\":\"net_placeGame.buyATreasureChest\",\"9213\":\"net_placeGame.allSoulUnload\",\"9214\":\"net_placeGame.allEquipUnload\",\"9215\":\"net_placeGame.soulEquipUnload\",\"9216\":\"net_placeGame.openDialog\",\"9217\":\"net_placeGame.selectDialog\",\"9218\":\"net_placeGame.equipmentLock\",\"9219\":\"net_placeGame.equipmentResolve\",\"9220\":\"net_placeGame.recruitResult\",\"9221\":\"net_placeGame.levelUpResult\",\"9222\":\"net_placeGame.dismissalResult\",\"9223\":\"net_placeGame.changeFormationNameResult\",\"9224\":\"net_placeGame.goIntoBattleResult\",\"9225\":\"net_placeGame.modifySoulResult\",\"9226\":\"net_placeGame.changePositionResult\",\"9227\":\"net_placeGame.modifyWeaponResult\",\"9228\":\"net_placeGame.climbingTowerResult\",\"9229\":\"net_placeGame.openTheBoxResult\",\"9230\":\"net_placeGame.buyATreasureChestResult\",\"9231\":\"net_placeGame.allSoulUnloadResult\",\"9232\":\"net_placeGame.allEquipUnloadResult\",\"9233\":\"net_placeGame.soulEquipUnloadResult\",\"9234\":\"net_placeGame.openDialogResult\",\"9235\":\"net_placeGame.selectDialogResult\",\"9236\":\"net_placeGame.equipmentLockResult\",\"9237\":\"net_placeGame.equipmentResolveResult\",\"9238\":\"net_placeGame.notifyBoss\",\"9239\":\"net_placeGame.notifyFormation\",\"9240\":\"net_placeGame.notifyEventIsFinish\",\"9241\":\"net_placeGame.notifyBoxAdd\",\"9242\":\"net_placeGame.notifyChallengeLevel\",\"9302\":\"net_amusementPark.getAmusementParkInfo\",\"9303\":\"net_amusementPark.getAmusementParkInfoTemporarily\",\"9304\":\"net_amusementPark.build\",\"9305\":\"net_amusementPark.changeLayout\",\"9306\":\"net_amusementPark.confirmChanges\",\"9307\":\"net_amusementPark.parkLevelUp\",\"9308\":\"net_amusementPark.randomActionFigure\",\"9309\":\"net_amusementPark.recruit\",\"9310\":\"net_amusementPark.roleLevelUp\",\"9311\":\"net_amusementPark.roleDeploy\",\"9312\":\"net_amusementPark.roleUnDeploy\",\"9313\":\"net_amusementPark.openDialog\",\"9314\":\"net_amusementPark.selectDialog\",\"9315\":\"net_amusementPark.receiveIncome\",\"9316\":\"net_amusementPark.combatTraining\",\"9317\":\"net_amusementPark.bossTraining\",\"9318\":\"net_amusementPark.readBurst\",\"9319\":\"net_amusementPark.dollMachineInfo\",\"9320\":\"net_amusementPark.dollMachine\",\"9321\":\"net_amusementPark.pixelBirdInfo\",\"9322\":\"net_amusementPark.pixelBird\",\"9323\":\"net_amusementPark.stackingInfo\",\"9324\":\"net_amusementPark.stacking\",\"9325\":\"net_amusementPark.oneStrokeInfo\",\"9326\":\"net_amusementPark.oneStroke\",\"9327\":\"net_amusementPark.answerInfo\",\"9328\":\"net_amusementPark.answer\",\"9329\":\"net_amusementPark.getLittleGameInfo\",\"9330\":\"net_amusementPark.getAmusementParkInfoResult\",\"9331\":\"net_amusementPark.getAmusementParkInfoTemporarilyResult\",\"9332\":\"net_amusementPark.buildResult\",\"9333\":\"net_amusementPark.changeLayoutResult\",\"9334\":\"net_amusementPark.confirmChangesResult\",\"9335\":\"net_amusementPark.parkLevelUpResult\",\"9336\":\"net_amusementPark.randomActionFigureResult\",\"9337\":\"net_amusementPark.recruitResult\",\"9338\":\"net_amusementPark.roleLevelUpResult\",\"9339\":\"net_amusementPark.roleDeployResult\",\"9340\":\"net_amusementPark.roleUnDeployResult\",\"9341\":\"net_amusementPark.openDialogResult\",\"9342\":\"net_amusementPark.selectDialogResult\",\"9343\":\"net_amusementPark.receiveIncomeResult\",\"9344\":\"net_amusementPark.combatTrainingResult\",\"9345\":\"net_amusementPark.bossTrainingResult\",\"9346\":\"net_amusementPark.readBurstResult\",\"9347\":\"net_amusementPark.dollMachineInfoResult\",\"9348\":\"net_amusementPark.dollMachineResult\",\"9349\":\"net_amusementPark.pixelBirdInfoResult\",\"9350\":\"net_amusementPark.pixelBirdResult\",\"9351\":\"net_amusementPark.stackingInfoResult\",\"9352\":\"net_amusementPark.stackingResult\",\"9353\":\"net_amusementPark.oneStrokeInfoResult\",\"9354\":\"net_amusementPark.oneStrokeResult\",\"9355\":\"net_amusementPark.answerInfoResult\",\"9356\":\"net_amusementPark.answerResult\",\"9357\":\"net_amusementPark.getLittleGameInfoResult\",\"9358\":\"net_amusementPark.notifyAmusementParkInfo\",\"9359\":\"net_amusementPark.notifyAmusementParkInfoPOD\",\"9360\":\"net_amusementPark.notifyEventIsFinish\",\"9361\":\"net_amusementPark.notifyReceiveIncome\",\"9362\":\"net_amusementPark.notifyEmergency\",\"9363\":\"net_amusementPark.notifyBossTraining\",\"9364\":\"net_amusementPark.notifyCombatTrainingBossEnd\",\"9365\":\"net_amusementPark.notifyItemGMAdd\",\"9402\":\"net_survival.startChallenge\",\"9403\":\"net_survival.endChallenge\",\"9404\":\"net_survival.level\",\"9405\":\"net_survival.startChallengeUnlimited\",\"9406\":\"net_survival.endChallengeUnlimited\",\"9407\":\"net_survival.startChallengeResult\",\"9408\":\"net_survival.endChallengeResult\",\"9409\":\"net_survival.levelResult\",\"9410\":\"net_survival.startChallengeUnlimitedResult\",\"9411\":\"net_survival.endChallengeUnlimitedResult\",\"9412\":\"net_survival.selectDialog\",\"9413\":\"net_survival.selectDialogResult\",\"9414\":\"net_survival.notifyOpenDialog\",\"9415\":\"net_survival.notifyUpdateSurvivalPassStatus\",\"9416\":\"net_survival.notifyDialogRewards\",\"9502\":\"net_horizontalRPG.elementExecution\",\"9503\":\"net_horizontalRPG.elementExecutionElse\",\"9504\":\"net_horizontalRPG.combatTraining\",\"9505\":\"net_horizontalRPG.bossTraining\",\"9506\":\"net_horizontalRPG.selectDialog\",\"9507\":\"net_horizontalRPG.modifyWeather\",\"9508\":\"net_horizontalRPG.quickChallenge\",\"9509\":\"net_horizontalRPG.elementExecutionResult\",\"9510\":\"net_horizontalRPG.elementExecutionElseResult\",\"9511\":\"net_horizontalRPG.combatTrainingResult\",\"9512\":\"net_horizontalRPG.bossTrainingResult\",\"9513\":\"net_horizontalRPG.selectDialogResult\",\"9514\":\"net_horizontalRPG.modifyWeatherResult\",\"9515\":\"net_horizontalRPG.quickChallengeResult\",\"9516\":\"net_horizontalRPG.notifyCombatTrainingBossEnd\",\"9517\":\"net_horizontalRPG.notifyBossTraining\",\"9518\":\"net_horizontalRPG.notifyBossUnlock\",\"9519\":\"net_horizontalRPG.notifyTicketsUpdate\",\"9520\":\"net_horizontalRPG.notifyElementExecution\",\"9521\":\"net_horizontalRPG.notifyCMD\",\"9522\":\"net_horizontalRPG.challenge\",\"9523\":\"net_horizontalRPG.challengeResult\",\"9524\":\"net_horizontalRPG.notifyFinnishLevels\",\"9525\":\"net_horizontalRPG.notifyUnlockedDifficulty\",\"9526\":\"net_horizontalRPG.notifyChallengeFightEnd\",\"9527\":\"net_horizontalRPG.notifyChallengeStoryFinished\",\"9528\":\"net_horizontalRPG.notifyHRPGFinished\",\"9529\":\"net_horizontalRPG.selectLevelDialog\",\"9530\":\"net_horizontalRPG.selectLevelDialogResult\",\"9602\":\"net_fishingActivity.fishing\",\"9603\":\"net_fishingActivity.fishingConfirm\",\"9604\":\"net_fishingActivity.getAutoFishingRewards\",\"9605\":\"net_fishingActivity.upRole\",\"9606\":\"net_fishingActivity.upSkill\",\"9607\":\"net_fishingActivity.upAction\",\"9608\":\"net_fishingActivity.getStoryRewards\",\"9609\":\"net_fishingActivity.fishingResult\",\"9610\":\"net_fishingActivity.fishingConfirmResult\",\"9611\":\"net_fishingActivity.getAutoFishingRewardsResult\",\"9612\":\"net_fishingActivity.upRoleResult\",\"9613\":\"net_fishingActivity.upSkillResult\",\"9614\":\"net_fishingActivity.upActionResult\",\"9615\":\"net_fishingActivity.getStoryRewardsResult\"}"
msgIdMethodTypes = "{\"100102\":[\"CChatPOD\"],\"100103\":[\"int\"],\"100104\":[\"int\"],\"100105\":[\"int\",\"ChatRoomPOD\"],\"100106\":[\"SChatPOD\"],\"100107\":[\"ChatRoomPOD\"],\"100108\":[\"string\",\"int\",\"string\",\"string\",\"string\"],\"100109\":[\"int\"],\"1002\":[\"long\",\"string\"],\"100202\":[\"int\",\"int\",\"bool\"],\"100203\":[\"int\",\"int\",\"bool\",\"list<RankingPOD>\",\"list<RankingPOD>\",\"int\",\"long\",\"string\",\"int\"],\"100204\":[\"int\",\"bool\",\"int\"],\"100205\":[\"int\",\"string\"],\"100206\":[\"int\",\"int\",\"int\"],\"100207\":[\"int\",\"RankingPOD\",\"int\",\"int\"],\"1003\":[\"string\",\"string\"],\"100302\":[\"list<long>\"],\"100303\":[\"list<string>\"],\"100304\":[\"list<long>\",\"bool\"],\"100305\":[\"string\"],\"100306\":[\"list<long>\"],\"100307\":[\"string\"],\"100308\":[\"long\",\"string\"],\"100309\":[],\"100310\":[\"int\"],\"100311\":[\"int\"],\"100312\":[\"int\"],\"100313\":[\"int\"],\"100314\":[\"int\"],\"100315\":[\"int\",\"FriendPOD\"],\"100316\":[\"int\",\"FriendPOD\"],\"100317\":[\"int\",\"list<FriendPOD>\"],\"100318\":[\"list<FriendPOD>\"],\"100319\":[\"list<long>\"],\"100320\":[\"list<FriendPOD>\"],\"1004\":[\"string\"],\"100402\":[\"int\"],\"100403\":[\"int\",\"string\",\"string\",\"string\",\"string\"],\"100404\":[\"int\",\"list<ActiveTurntableRecordPOD>\"],\"100405\":[\"int\"],\"1005\":[\"int\"],\"100502\":[\"int\"],\"100503\":[\"int\",\"GroupPurchaseCommonDataPOD\"],\"1006\":[\"string\"],\"100602\":[\"int\"],\"100603\":[\"int\",\"CenterVoteDataPOD\"],\"1007\":[\"int\"],\"100702\":[\"int\"],\"100703\":[\"int\",\"list<HelpNewbiesFollowerDataPOD>\"],\"100802\":[\"int\"],\"100803\":[\"int\",\"CenterCupMatchVoteDataPOD\"],\"100902\":[\"string\"],\"100903\":[],\"100904\":[],\"100905\":[],\"100906\":[\"int\"],\"100907\":[],\"100908\":[\"int\"],\"100909\":[],\"100910\":[\"list<string>\"],\"100911\":[\"string\"],\"100912\":[],\"100913\":[\"string\",\"int\"],\"100914\":[\"string\"],\"100915\":[],\"100916\":[],\"100917\":[],\"100918\":[\"int\",\"int\",\"int\",\"int\"],\"100919\":[\"string\"],\"100920\":[\"string\"],\"100921\":[],\"100922\":[\"int\"],\"100923\":[\"int\",\"GuildPOD\"],\"100924\":[\"int\"],\"100925\":[\"int\",\"list<GuildBasePOD>\"],\"100926\":[\"int\"],\"100927\":[\"int\",\"list<GuildBasePOD>\"],\"100928\":[\"int\",\"int\"],\"100929\":[\"int\",\"list<GuildAuditPOD>\"],\"100930\":[\"int\",\"list<string>\"],\"100931\":[\"int\",\"string\"],\"100932\":[\"int\",\"list<GuildMemberPOD>\"],\"100933\":[\"int\"],\"100934\":[\"int\"],\"100935\":[\"int\"],\"100936\":[\"int\"],\"100937\":[\"int\"],\"100938\":[\"int\"],\"100939\":[\"int\"],\"100940\":[\"int\",\"list<GuildBasePOD>\"],\"100941\":[\"int\",\"list<CenterGuildTrainingPlayerRankPOD>\"],\"100942\":[\"int\",\"string\"],\"100943\":[],\"100944\":[\"GuildBasePOD\"],\"100945\":[\"GuildPOD\"],\"100946\":[\"int\",\"int\"],\"100947\":[\"int\"],\"100948\":[\"int\"],\"100949\":[\"int\",\"GuildBuildingPOD\"],\"100950\":[\"int\",\"GuildBuildingPOD\"],\"100951\":[],\"100952\":[\"int\",\"map<int|int>\"],\"100953\":[\"int\"],\"100954\":[\"string\"],\"100955\":[\"int\",\"string\"],\"102\":[\"long\",\"SimplePlayerPOD\",\"PlayerPlatformDataPOD\"],\"103\":[\"string\",\"string\"],\"104\":[\"string\",\"PlayerPlatformDataPOD\"],\"105\":[\"string\"],\"106\":[\"string\"],\"107\":[\"SimplePlayerPOD\"],\"108\":[\"int\",\"string\",\"long\",\"string\",\"string\"],\"109\":[],\"110\":[],\"111\":[\"int\",\"long\",\"SimplePlayerPOD\"],\"112\":[\"int\",\"bool\",\"string\",\"SimplePlayerPOD\"],\"113\":[\"int\",\"string\",\"CenterLoadPlayerPOD\"],\"114\":[\"int\",\"bool\"],\"115\":[\"SChatPOD\",\"list<string>\",\"bool\"],\"116\":[\"ChatRoomPOD\",\"list<string>\"],\"117\":[\"string\",\"string\"],\"118\":[\"list<DailyDupCommonPOD>\"],\"119\":[\"string\",\"int\",\"list<int>\",\"int\"],\"120\":[\"int\",\"list<string>\",\"list<RankSubsectionItemPOD>\"],\"1202\":[\"int\",\"int\"],\"1203\":[\"int\",\"int\"],\"1204\":[\"int\",\"int\",\"int\"],\"1205\":[\"int\",\"int\",\"int\"],\"1206\":[\"ShopPOD\"],\"121\":[\"int\",\"list<RankSubsectionItemPOD>\",\"list<RankSubsectionItemPOD>\"],\"122\":[\"GmMailPOD\"],\"123\":[\"list<OperationEventPOD>\"],\"124\":[\"int\",\"map<string|GroupPurchaseRewardPOD>\"],\"125\":[\"int\",\"string\",\"int\"],\"126\":[\"int\",\"string\",\"int\",\"string\"],\"127\":[\"int\",\"string\",\"map<int|int>\"],\"128\":[\"int\",\"string\",\"string\",\"long\",\"int\"],\"129\":[\"string\",\"int\",\"int\"],\"130\":[\"CenterServerDiscreteDataPOD\"],\"1302\":[\"int\",\"long\"],\"1303\":[\"MazeSettlementPOD\"],\"1304\":[\"string\",\"bool\",\"int\"],\"1305\":[\"int\"],\"1306\":[],\"1307\":[\"int\",\"int\"],\"1308\":[\"int\",\"int\"],\"1309\":[\"int\",\"MazePOD\"],\"131\":[\"list<GuildTrainingBossScorePOD>\"],\"1310\":[\"int\",\"MazeSettlementResultPOD\"],\"1311\":[\"int\",\"bool\"],\"1312\":[\"int\",\"MazePOD\"],\"1313\":[\"int\"],\"1314\":[\"int\"],\"1315\":[\"int\",\"int\",\"int\"],\"1316\":[\"int\"],\"1317\":[\"MazeInfoPOD\"],\"1318\":[\"int\"],\"1319\":[\"int\"],\"132\":[\"string\"],\"1320\":[\"int\"],\"1321\":[\"int\",\"int\",\"long\"],\"1322\":[\"int\"],\"1323\":[\"int\"],\"1324\":[\"int\",\"list<MazeMopUpPOD>\"],\"1325\":[\"list<int>\"],\"1326\":[\"int\"],\"1327\":[\"int\",\"int\"],\"1328\":[\"int\",\"long\"],\"1329\":[\"int\",\"MazePOD\"],\"133\":[\"list<PLaceGameRankInfoPOD>\"],\"1330\":[\"list<int>\"],\"1331\":[\"int\",\"long\"],\"1332\":[\"int\",\"MazePOD\"],\"1333\":[\"int\"],\"1334\":[\"int\"],\"1335\":[\"int\",\"int\"],\"1336\":[\"int\",\"MazePOD\"],\"1337\":[\"int\"],\"1338\":[\"int\",\"long\"],\"1339\":[\"int\",\"MazePOD\"],\"1340\":[\"int\",\"int\"],\"1341\":[\"int\",\"list<MazeMopUpPOD>\"],\"1342\":[\"list<int>\"],\"1343\":[\"int\",\"long\"],\"1344\":[\"int\"],\"1345\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"list<int>\"],\"1402\":[\"int\"],\"1403\":[\"int\"],\"1404\":[\"int\"],\"1405\":[\"int\"],\"1406\":[\"int\",\"DressPOD\"],\"1502\":[\"int\",\"int\"],\"1503\":[\"int\",\"int\",\"int\"],\"1504\":[\"int\",\"int\",\"list<ItemShowPOD>\",\"list<int>\"],\"1505\":[\"int\",\"map<int|int>\"],\"1602\":[\"int\",\"list<int>\"],\"1603\":[\"int\",\"int\"],\"1604\":[\"int\"],\"1702\":[\"int\"],\"1703\":[\"int\",\"int\"],\"1704\":[\"int\"],\"1705\":[\"int\"],\"1706\":[\"int\",\"int\"],\"1707\":[\"int\"],\"1802\":[],\"1803\":[],\"1804\":[\"int\"],\"1805\":[\"int\",\"int\"],\"1806\":[\"int\",\"int\",\"int\"],\"1807\":[\"int\"],\"1808\":[\"int\",\"int\"],\"1809\":[\"string\",\"string\"],\"1810\":[\"int\"],\"1811\":[\"int\"],\"1812\":[\"int\",\"int\",\"int\",\"int\"],\"1813\":[\"int\",\"int\"],\"1814\":[\"int\",\"int\"],\"1815\":[\"int\"],\"1816\":[\"int\",\"string\"],\"1817\":[\"int\",\"int\"],\"1818\":[\"int\"],\"1819\":[\"int\"],\"1820\":[\"int\",\"int\",\"int\"],\"1821\":[\"int\",\"int\",\"list<int>\"],\"1822\":[\"int\",\"int\"],\"1823\":[\"int\",\"int\",\"int\"],\"1824\":[\"int\",\"int\"],\"1825\":[\"int\",\"int\",\"int\"],\"1826\":[\"int\",\"int\"],\"1827\":[\"int\",\"int\"],\"1828\":[\"int\",\"int\",\"int\"],\"1829\":[\"long\",\"list<int>\"],\"1830\":[\"int\"],\"1831\":[\"int\"],\"1832\":[\"int\",\"list<DecoratePOD>\"],\"1833\":[\"int\",\"int\",\"bool\"],\"1834\":[\"int\",\"HomePOD\"],\"1835\":[\"int\"],\"1836\":[\"int\",\"BuildingPOD\",\"list<ItemShowPOD>\"],\"1837\":[\"int\",\"int\",\"list<LandPOD>\",\"list<ItemShowPOD>\"],\"1838\":[\"int\",\"int\",\"LandPOD\"],\"1839\":[\"int\",\"int\"],\"1840\":[\"int\",\"RoomPOD\"],\"1841\":[\"int\",\"string\",\"HomePOD\"],\"1842\":[\"int\",\"int\"],\"1843\":[\"int\",\"int\"],\"1844\":[\"int\",\"BuildingPOD\"],\"1845\":[\"int\",\"BuildingPOD\"],\"1846\":[\"int\",\"BuildingPOD\",\"list<ItemShowPOD>\"],\"1847\":[\"int\"],\"1848\":[\"int\",\"RoomPOD\"],\"1849\":[\"int\"],\"1850\":[\"int\",\"RoomPOD\"],\"1851\":[\"int\",\"list<ItemShowPOD>\"],\"1852\":[\"int\",\"BuildingPOD\"],\"1853\":[\"int\",\"BuildingPOD\",\"int\"],\"1854\":[\"int\",\"BuildingPOD\",\"list<WorkRewardResultPOD>\"],\"1855\":[\"int\",\"int\",\"LandPOD\"],\"1856\":[\"int\",\"int\",\"LandPOD\"],\"1857\":[\"int\",\"BuildingPOD\"],\"1858\":[\"int\",\"BuildingPOD\"],\"1859\":[\"int\",\"BuildingPOD\",\"list<ItemShowPOD>\"],\"1860\":[\"int\",\"BuildingPOD\"],\"1861\":[\"int\",\"long\",\"list<ItemShowPOD>\"],\"1862\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"1863\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"1864\":[\"int\",\"int\"],\"1865\":[\"int\"],\"1866\":[\"int\"],\"1867\":[\"list<int>\"],\"1868\":[\"BasicHomeInfoPOD\"],\"1869\":[\"int\",\"list<LandPOD>\"],\"1870\":[\"BuildingPOD\"],\"1871\":[\"RoomPOD\"],\"1872\":[\"int\"],\"1873\":[\"list<int>\"],\"1874\":[\"list<HomeRolePOD>\"],\"1875\":[\"int\",\"int\"],\"1876\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"1877\":[\"int\"],\"1878\":[\"int\",\"int\"],\"1879\":[\"int\"],\"1880\":[\"int\"],\"1881\":[\"int\",\"int\",\"int\"],\"1882\":[\"int\",\"int\",\"int\"],\"1883\":[\"int\",\"list<ItemShowPOD>\"],\"1884\":[\"int\",\"list<ItemShowPOD>\"],\"1885\":[\"int\",\"int\"],\"1886\":[\"int\",\"int\"],\"1887\":[\"int\",\"int\",\"int\"],\"1888\":[\"int\",\"LandPOD\"],\"1902\":[],\"1903\":[],\"1904\":[\"int\",\"list<GirlPOD>\"],\"1905\":[\"int\"],\"1906\":[\"int\",\"int\"],\"1907\":[\"int\",\"int\",\"int\",\"bool\",\"int\"],\"1908\":[\"int\"],\"1909\":[\"int\",\"int\",\"int\",\"int\",\"bool\",\"int\"],\"1910\":[\"int\",\"int\"],\"1911\":[\"int\"],\"1912\":[\"int\"],\"1913\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"1914\":[\"int\",\"int\",\"SoulOathPOD\"],\"202\":[\"string\",\"string\",\"int\"],\"203\":[\"string\",\"string\",\"list<int>\"],\"2202\":[\"int\"],\"2203\":[\"int\",\"int\"],\"2204\":[\"int\"],\"2205\":[\"int\"],\"2206\":[\"int\",\"int\",\"int\"],\"2207\":[\"int\",\"int\"],\"2208\":[\"list<AreaPOD>\"],\"2209\":[\"list<int>\"],\"2210\":[\"int\",\"list<ItemShowPOD>\"],\"2211\":[\"list<ItemShowPOD>\"],\"2212\":[\"list<int>\"],\"2213\":[\"TownPOD\"],\"2402\":[\"int\",\"int\",\"list<int>\"],\"2403\":[\"int\",\"LotteryShowPOD\",\"int\",\"map<int|int>\",\"list<ItemShowPOD>\",\"list<ItemShowPOD>\"],\"2404\":[],\"2405\":[\"int\",\"list<LotteryHistoryPOD>\"],\"2502\":[\"int\",\"int\"],\"2503\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"2504\":[\"map<int|int>\"],\"2505\":[\"map<int|int>\"],\"2602\":[],\"2603\":[\"int\",\"LibraryPOD\"],\"2604\":[\"int\"],\"2605\":[\"int\"],\"2606\":[\"int\"],\"2607\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"2702\":[\"long\",\"long\",\"int\"],\"2703\":[\"list<long>\",\"long\"],\"2704\":[\"long\",\"map<int|int>\"],\"2705\":[\"long\",\"list<long>\"],\"2706\":[\"list<long>\",\"bool\"],\"2707\":[\"long\",\"int\",\"int\",\"list<int>\",\"int\"],\"2708\":[\"long\",\"int\"],\"2709\":[\"long\",\"int\",\"int\"],\"2710\":[\"int\"],\"2711\":[\"int\"],\"2712\":[\"int\"],\"2713\":[\"int\"],\"2714\":[\"int\",\"list<ItemShowPOD>\"],\"2715\":[\"int\"],\"2716\":[\"int\"],\"2717\":[\"int\"],\"2718\":[\"list<SoulPrefabPOD>\"],\"2719\":[\"long\",\"long\"],\"2720\":[\"map<int|long>\",\"long\"],\"2721\":[\"int\"],\"2722\":[\"int\"],\"2723\":[\"EquipmentPrefabPOD\"],\"2724\":[\"long\",\"map<int|long>\"],\"2725\":[\"int\"],\"2726\":[\"long\",\"string\"],\"2727\":[\"int\"],\"2728\":[\"long\",\"int\",\"int\"],\"2729\":[\"int\"],\"2802\":[\"int\"],\"2803\":[\"int\"],\"2804\":[\"DailyDupPOD\"],\"2902\":[\"int\",\"int\",\"map<int|long>\",\"FightTroopPOD\",\"FightTroopPOD\",\"string\",\"string\",\"int\",\"map<int|long>\",\"map<int|long>\"],\"2903\":[\"bool\",\"FightPOD\",\"string\"],\"3002\":[\"int\",\"long\"],\"3003\":[\"int\",\"int\"],\"3004\":[\"int\"],\"3005\":[\"int\",\"list<ItemShowPOD>\",\"int\"],\"3006\":[\"bool\",\"int\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"int\"],\"3102\":[\"int\",\"long\"],\"3103\":[\"int\"],\"3104\":[\"bool\",\"int\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"int\",\"int\"],\"3202\":[\"int\",\"long\",\"bool\",\"int\"],\"3203\":[\"int\",\"int\",\"int\"],\"3204\":[\"bool\",\"int\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"WorldBossPOD\"],\"3402\":[\"int\",\"int\"],\"3403\":[\"int\",\"int\",\"int\"],\"3404\":[\"SoulNewStoryPOD\",\"list<ItemShowPOD>\",\"int\",\"int\",\"int\",\"int\"],\"3405\":[\"SoulNewStoryPOD\"],\"3602\":[\"int\",\"int\"],\"3603\":[\"int\"],\"3604\":[\"int\"],\"3605\":[\"int\"],\"3606\":[\"int\",\"int\",\"int\",\"SoulMemoryChapterPOD\"],\"3607\":[\"int\",\"int\"],\"3608\":[\"int\",\"int\",\"list<ItemShowPOD>\",\"SoulMemoryChapterPOD\",\"SoulMemoryChapterPOD\"],\"3609\":[\"int\"],\"3610\":[\"SoulMemoryChapterPOD\"],\"3611\":[\"int\",\"map<int|int>\"],\"3702\":[\"int\",\"bool\"],\"3703\":[\"int\",\"int\"],\"3704\":[],\"3705\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"3706\":[\"int\"],\"3707\":[\"int\"],\"3708\":[],\"3709\":[\"int\",\"list<ItemShowPOD>\"],\"3710\":[\"int\",\"list<LuckDrawHistoryPOD>\"],\"3711\":[],\"3712\":[\"int\"],\"3713\":[\"int\",\"list<int>\"],\"3714\":[\"int\",\"list<ItemShowPOD>\"],\"3715\":[\"list<int>\"],\"3716\":[\"int\",\"list<ItemShowPOD>\"],\"3717\":[\"map<int|int>\",\"map<int|int>\"],\"3802\":[\"string\",\"string\",\"string\"],\"3803\":[\"string\"],\"3804\":[\"int\",\"string\"],\"3805\":[],\"3806\":[],\"3807\":[\"int\",\"list<RoleInfoPOD>\",\"int\",\"string\",\"string\",\"bool\"],\"3808\":[\"int\",\"int\",\"string\"],\"3809\":[\"int\",\"RoleInfoPOD\"],\"3810\":[\"int\"],\"3811\":[\"int\"],\"3812\":[\"int\",\"int\"],\"3813\":[\"int\",\"string\"],\"3814\":[],\"3815\":[\"int\",\"int\"],\"3816\":[\"string\",\"int\",\"string\"],\"3817\":[\"int\",\"int\",\"string\"],\"3902\":[],\"3903\":[\"string\"],\"3904\":[\"int\",\"string\"],\"3905\":[\"string\",\"string\"],\"3906\":[\"string\"],\"3907\":[\"int\"],\"3908\":[\"int\",\"int\",\"int\"],\"3909\":[\"int\"],\"3910\":[\"int\",\"PlayerPOD\"],\"3911\":[\"int\"],\"3912\":[\"int\",\"int\",\"PlayerBaseInfoPOD\"],\"3913\":[\"int\",\"PlayerInfoPOD\"],\"3914\":[\"int\",\"list<ItemShowPOD>\"],\"3915\":[\"int\"],\"3916\":[\"int\",\"int\",\"int\",\"int\"],\"3917\":[\"int\"],\"3918\":[\"PlayerBaseInfoPOD\"],\"3919\":[\"list<int>\"],\"3920\":[\"int\"],\"3921\":[\"int\"],\"3922\":[\"int\",\"int\"],\"3923\":[\"list<GlobalBuffPOD>\"],\"3924\":[\"map<int|int>\"],\"3925\":[\"int\",\"bool\"],\"3926\":[\"int\"],\"3927\":[\"int\"],\"3928\":[\"map<int|bool>\"],\"3929\":[\"int\",\"int\"],\"3930\":[\"int\",\"list<int>\",\"int\"],\"3931\":[\"int\"],\"3932\":[\"int\"],\"3933\":[\"map<long|int>\"],\"3934\":[\"int\"],\"3935\":[\"DailyResetPOD\"],\"3936\":[\"int\",\"list<ItemShowPOD>\",\"string\",\"string\",\"string\",\"int\",\"int\",\"double\",\"string\",\"long\",\"string\"],\"3937\":[\"map<int|int>\",\"map<int|bool>\"],\"3938\":[\"map<int|int>\"],\"3939\":[\"int\",\"bool\"],\"3940\":[\"string\",\"string\"],\"3941\":[\"int\"],\"3942\":[\"map<int|int>\"],\"3943\":[\"int\"],\"3944\":[\"int\",\"bool\"],\"3945\":[\"map<int|int>\"],\"3946\":[\"int\",\"map<int|int>\"],\"3947\":[],\"3948\":[\"int\"],\"3949\":[\"int\"],\"3950\":[\"int\"],\"3951\":[\"map<int|int>\"],\"3952\":[\"map<int|int>\"],\"3953\":[\"map<int|int>\"],\"3954\":[\"int\",\"int\"],\"3955\":[\"int\",\"int\",\"int\"],\"3956\":[\"int\",\"int\"],\"3957\":[\"map<int|int>\"],\"3958\":[\"int\"],\"3959\":[\"int\"],\"3960\":[\"int\",\"int\"],\"3961\":[\"int\",\"int\",\"int\"],\"3962\":[\"int\"],\"3963\":[\"list<int>\"],\"3964\":[\"int\",\"int\"],\"3965\":[\"int\",\"list<int>\"],\"4002\":[\"long\",\"int\"],\"4003\":[\"long\",\"int\"],\"4004\":[\"long\"],\"4005\":[\"int\"],\"4006\":[\"int\",\"list<ItemShowPOD>\",\"list<ItemUseRecordPOD>\"],\"4007\":[\"int\"],\"4008\":[\"int\",\"int\"],\"4009\":[\"map<int|int>\"],\"4010\":[\"int\",\"bool\",\"list<ItemShowPOD>\",\"map<int|int>\",\"float\"],\"4011\":[\"int\",\"map<int|int>\",\"list<ItemShowPOD>\",\"map<int|int>\"],\"4012\":[\"long\"],\"4013\":[\"int\",\"long\",\"bool\"],\"4014\":[\"long\",\"list<int>\",\"int\"],\"4015\":[\"int\",\"list<ItemShowPOD>\"],\"4102\":[\"list<ItemPOD>\"],\"4202\":[\"int\",\"string\",\"int\"],\"4302\":[\"list<int>\"],\"4303\":[\"int\"],\"4304\":[\"int\",\"list<int>\",\"list<ItemShowPOD>\"],\"4305\":[\"int\",\"int\"],\"4306\":[\"QuestPOD\",\"bool\"],\"4307\":[\"int\",\"bool\"],\"4308\":[\"int\",\"bool\"],\"4309\":[\"int\",\"list<ItemShowPOD>\"],\"4310\":[\"list<int>\"],\"4311\":[\"int\",\"list<int>\"],\"4402\":[\"long\",\"string\"],\"4403\":[\"long\",\"int\",\"int\",\"int\",\"list<int>\",\"int\"],\"4404\":[\"int\",\"string\"],\"4405\":[\"int\"],\"4406\":[\"FormationPOD\"],\"4407\":[\"long\",\"long\"],\"4408\":[\"int\",\"long\",\"long\"],\"4502\":[\"int\"],\"4503\":[\"long\"],\"4504\":[\"list<long>\"],\"4505\":[\"list<long>\"],\"4506\":[\"int\",\"int\",\"list<MailPOD>\"],\"4507\":[\"int\",\"long\"],\"4508\":[\"int\",\"list<MailPOD>\",\"list<ItemShowPOD>\"],\"4509\":[\"int\",\"list<long>\"],\"4510\":[\"int\"],\"4602\":[\"int\"],\"4603\":[\"int\",\"map<int|int>\"],\"4604\":[\"int\"],\"4605\":[\"int\",\"int\"],\"4606\":[\"int\",\"int\"],\"4607\":[\"int\",\"int\"],\"4608\":[\"int\",\"int\",\"int\"],\"4609\":[\"int\"],\"4610\":[\"int\"],\"4611\":[\"int\",\"SoulPOD\"],\"4612\":[\"int\",\"SoulPOD\"],\"4613\":[\"int\",\"SoulPOD\"],\"4614\":[\"int\"],\"4615\":[\"int\"],\"4616\":[\"int\",\"int\",\"int\",\"int\"],\"4617\":[\"SoulPOD\"],\"4618\":[\"int\"],\"4619\":[\"int\",\"int\"],\"4620\":[\"int\",\"int\",\"int\"],\"4702\":[\"int\"],\"4703\":[\"long\",\"int\",\"bool\"],\"4704\":[\"long\"],\"4705\":[\"int\"],\"4706\":[\"int\"],\"4707\":[\"bool\",\"int\",\"list<ItemShowPOD>\",\"bool\"],\"4708\":[\"bool\",\"list<ItemShowPOD>\",\"map<int|long>\"],\"4709\":[\"int\"],\"4710\":[\"int\",\"MazePOD\"],\"4802\":[\"list<int>\"],\"4803\":[],\"4804\":[\"int\"],\"4805\":[\"int\"],\"4902\":[\"list<OperationEventPOD>\"],\"4903\":[\"OperationEventDataPOD\"],\"5002\":[\"int\",\"int\",\"int\"],\"5003\":[\"int\",\"list<ItemShowPOD>\",\"OperationEventDataPOD\"],\"5102\":[\"int\"],\"5103\":[\"int\",\"int\"],\"5104\":[\"int\",\"int\"],\"5105\":[\"int\",\"OperationEventDataPOD\"],\"5106\":[\"int\",\"list<ItemShowPOD>\",\"OperationEventDataPOD\"],\"5107\":[\"int\",\"list<ItemShowPOD>\",\"OperationEventDataPOD\"],\"5202\":[\"int\",\"int\",\"long\"],\"5203\":[\"int\"],\"5204\":[\"int\",\"int\",\"bool\",\"list<ItemShowPOD>\"],\"5302\":[\"int\",\"int\"],\"5303\":[\"int\",\"int\"],\"5304\":[\"int\",\"int\"],\"5305\":[\"int\",\"list<int>\",\"list<int>\",\"list<ItemShowPOD>\"],\"5306\":[\"int\",\"list<NewCharacterRewardsLogPOD>\"],\"5307\":[\"int\"],\"5308\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"5402\":[\"int\"],\"5403\":[\"int\",\"int\",\"list<ItemShowPOD>\",\"OperationEventDataPOD\"],\"5404\":[\"int\"],\"5405\":[\"int\",\"OperationEventDataPOD\"],\"5502\":[\"int\",\"int\",\"int\",\"long\"],\"5503\":[\"int\",\"int\",\"list<int>\"],\"5504\":[\"int\"],\"5505\":[\"int\",\"list<ItemShowPOD>\",\"int\",\"int\",\"list<int>\"],\"5506\":[\"int\",\"bool\",\"map<int|long>\",\"int\",\"int\",\"int\",\"int\"],\"5507\":[\"int\",\"DoubleFightStepPOD\"],\"5602\":[\"int\",\"long\"],\"5603\":[\"int\"],\"5604\":[\"int\"],\"5605\":[\"int\"],\"5606\":[\"int\",\"int\",\"long\",\"FormationSoulPrefabPOD\"],\"5607\":[\"int\",\"int\",\"list<LunaBattleLineAssistUnitPOD>\"],\"5608\":[\"int\",\"int\",\"list<LunaBattleLineAssistUnitPOD>\"],\"5609\":[\"int\",\"int\",\"list<FormationSoulPrefabPOD>\"],\"5610\":[\"int\",\"long\"],\"5611\":[\"int\",\"long\",\"string\"],\"5612\":[\"int\",\"list<EnterMazeSoulPrefabPOD>\"],\"5613\":[\"int\",\"int\",\"MazePOD\"],\"5614\":[\"int\",\"int\",\"MazePOD\"],\"5615\":[\"int\",\"int\",\"MazePOD\"],\"5616\":[\"int\",\"string\",\"int\"],\"5702\":[\"int\",\"int\",\"int\"],\"5703\":[\"int\",\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"5802\":[\"int\",\"int\"],\"5803\":[\"int\",\"list<ItemShowPOD>\"],\"5902\":[\"int\"],\"5903\":[],\"5904\":[\"int\",\"int\"],\"5905\":[\"int\",\"DreamMapDataPOD\"],\"5906\":[\"int\",\"DreamMapDataPOD\"],\"5907\":[\"int\",\"list<DreamMapExectionItemPOD>\",\"int\",\"int\",\"int\",\"int\"],\"5908\":[\"int\",\"list<int>\"],\"5909\":[\"int\",\"int\"],\"5910\":[\"int\"],\"5911\":[\"int\",\"int\",\"int\"],\"5912\":[\"int\",\"int\",\"int\",\"int\"],\"6002\":[\"int\"],\"6003\":[\"int\"],\"6004\":[],\"6005\":[],\"6006\":[\"int\",\"list<string>\"],\"6007\":[\"int\",\"int\",\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"6008\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"6009\":[\"int\",\"list<int>\",\"int\"],\"6010\":[\"int\",\"list<int>\"],\"6011\":[\"int\",\"int\",\"list<string>\"],\"6012\":[\"int\",\"list<ItemShowPOD>\"],\"6013\":[\"int\",\"bool\",\"list<ItemShowPOD>\"],\"6014\":[\"int\",\"list<int>\"],\"6015\":[\"int\",\"int\"],\"6016\":[\"int\"],\"6102\":[\"int\",\"int\"],\"6103\":[\"int\",\"list<ItemShowPOD>\"],\"6202\":[\"int\",\"int\"],\"6203\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"6302\":[\"int\",\"string\"],\"6303\":[\"int\",\"int\"],\"6304\":[\"int\"],\"6305\":[\"int\",\"list<ItemShowPOD>\"],\"6402\":[\"int\"],\"6403\":[\"int\",\"long\"],\"6404\":[\"long\"],\"6405\":[\"int\"],\"6406\":[\"int\"],\"6407\":[\"int\"],\"6408\":[\"int\",\"list<ItemShowPOD>\"],\"6409\":[\"int\",\"bool\",\"list<ItemShowPOD>\"],\"6410\":[\"bool\",\"list<ItemShowPOD>\"],\"6411\":[\"int\",\"list<int>\"],\"6412\":[\"int\",\"int\"],\"6413\":[\"int\"],\"6414\":[\"int\",\"int\"],\"6415\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\",\"map<int|int>\"],\"6502\":[\"long\",\"int\",\"bool\"],\"6503\":[\"long\",\"int\"],\"6504\":[\"int\"],\"6505\":[\"int\"],\"6506\":[\"bool\",\"int\",\"list<ItemShowPOD>\",\"bool\"],\"6507\":[\"bool\",\"list<ItemShowPOD>\",\"map<int|long>\"],\"6508\":[\"int\"],\"6509\":[\"int\",\"long\",\"long\",\"bool\"],\"6510\":[\"int\",\"int\"],\"6511\":[\"int\",\"DualTeamExploreLevelPOD\"],\"6512\":[\"int\",\"int\",\"int\",\"bool\"],\"6513\":[\"int\",\"int\"],\"6514\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"6515\":[\"DualTeamExploreNodePOD\"],\"6516\":[\"int\",\"bool\"],\"6517\":[\"bool\"],\"6518\":[\"int\",\"list<double>\",\"int\"],\"6519\":[\"bool\"],\"6520\":[\"int\",\"list<int>\"],\"6521\":[\"int\",\"int\"],\"6522\":[\"int\"],\"6523\":[\"int\"],\"6524\":[\"int\"],\"6525\":[\"bool\",\"int\",\"DualTeamExploreTeamPOD\",\"DualTeamExploreTeamPOD\"],\"6526\":[\"int\"],\"6527\":[\"int\",\"MazePOD\"],\"6528\":[\"int\",\"bool\"],\"6529\":[\"int\"],\"6530\":[],\"6531\":[\"int\"],\"6532\":[\"int\"],\"6533\":[\"int\",\"int\"],\"6534\":[],\"6535\":[\"int\",\"int\",\"DualTeamExploreTeamPOD\"],\"6536\":[\"int\"],\"6537\":[\"int\"],\"6538\":[\"int\"],\"6602\":[\"int\"],\"6603\":[],\"6604\":[\"int\"],\"6605\":[\"int\",\"MagicTowerMapDataPOD\"],\"6606\":[\"int\"],\"6607\":[\"int\",\"int\"],\"6608\":[\"MagicTowerMapExecutionItemPOD\"],\"6609\":[\"bool\"],\"6610\":[\"int\",\"list<int>\"],\"6611\":[\"int\",\"int\"],\"6612\":[\"int\"],\"6702\":[\"long\",\"int\"],\"6703\":[\"bool\"],\"6704\":[\"int\",\"int\"],\"6705\":[\"int\",\"int\",\"int\",\"int\"],\"6706\":[\"int\",\"ItemShowPOD\"],\"6707\":[\"int\",\"list<ItemShowPOD>\"],\"6708\":[\"list<int>\"],\"6709\":[\"int\",\"int\"],\"6710\":[\"int\",\"list<ItemShowPOD>\"],\"6711\":[\"int\"],\"6712\":[\"int\",\"list<ItemShowPOD>\"],\"6713\":[\"long\",\"int\"],\"6714\":[],\"6715\":[\"int\",\"long\"],\"6716\":[\"int\",\"list<ItemShowPOD>\"],\"6717\":[\"FishingDataPOD\"],\"6802\":[],\"6803\":[\"int\"],\"6804\":[\"int\"],\"6805\":[\"int\",\"list<int>\"],\"6806\":[\"int\",\"int\"],\"6807\":[\"int\",\"int\"],\"6808\":[\"int\",\"int\",\"int\"],\"6809\":[\"int\"],\"6810\":[\"int\"],\"6811\":[\"int\",\"int\"],\"6812\":[\"int\",\"MiniGalGameSavaDataDetailPOD\"],\"6813\":[\"int\",\"MiniGalGameSavaDataDetailPOD\"],\"6814\":[\"int\"],\"6815\":[\"int\",\"int\"],\"6816\":[\"int\"],\"6817\":[\"int\"],\"6818\":[\"int\",\"list<MiniGalGameItemPOD>\"],\"6819\":[\"int\"],\"6820\":[\"int\",\"int\",\"int\",\"list<MiniGalGameItemPOD>\"],\"6821\":[\"int\"],\"6822\":[\"int\",\"int\",\"int\"],\"6823\":[\"map<int|int>\"],\"6824\":[\"int\",\"list<MiniGalGameItemPOD>\"],\"6825\":[\"map<int|int>\"],\"6826\":[\"list<MiniGalGameGirlDataPOD>\"],\"6827\":[\"MiniGalGameBasePOD\"],\"6828\":[\"int\",\"int\"],\"6829\":[\"int\",\"bool\",\"list<MiniGalGameItemPOD>\"],\"6830\":[\"list<MiniGalGameSavaDataPOD>\"],\"6831\":[\"list<MiniGalGameSchedulePOD>\"],\"6832\":[\"int\"],\"6833\":[\"map<int|MiniGalGameCountPOD>\"],\"6834\":[\"map<int|int>\"],\"6835\":[\"map<int|int>\"],\"6836\":[\"map<int|MiniGalGameCountPOD>\"],\"6837\":[\"int\",\"int\"],\"6838\":[\"int\",\"int\"],\"6839\":[\"int\",\"int\",\"int\"],\"6840\":[\"int\",\"MiniGalGameMessageGroupPOD\"],\"6841\":[\"map<int|MiniGalGameCountPOD>\"],\"6902\":[\"long\",\"long\",\"int\"],\"6903\":[\"long\",\"long\"],\"6904\":[\"long\",\"int\",\"int\"],\"6905\":[\"long\"],\"6906\":[\"list<long>\"],\"6907\":[\"long\",\"int\"],\"6908\":[\"long\",\"int\"],\"6909\":[\"long\",\"list<int>\"],\"6910\":[\"int\"],\"6911\":[],\"6912\":[\"int\"],\"6913\":[\"int\"],\"6914\":[\"int\"],\"6915\":[\"int\"],\"6916\":[\"int\",\"list<ItemShowPOD>\"],\"6917\":[\"int\"],\"6918\":[\"int\"],\"6919\":[\"int\"],\"6920\":[\"int\"],\"6921\":[\"int\",\"list<ItemShowPOD>\"],\"6922\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"int\",\"int\"],\"6923\":[\"list<EvilErosionSoulPrefabPOD>\"],\"7002\":[\"int\"],\"7003\":[\"int\",\"int\",\"string\"],\"7102\":[\"int\",\"long\"],\"7103\":[\"long\"],\"7104\":[\"int\",\"MazePOD\"],\"7105\":[\"int\"],\"7106\":[\"bool\",\"list<ItemShowPOD>\",\"map<int|long>\"],\"7107\":[\"list<int>\"],\"7108\":[\"int\"],\"7202\":[\"int\",\"int\"],\"7203\":[\"int\"],\"7204\":[\"int\",\"list<int>\",\"list<ItemShowPOD>\",\"OperationEventDataPOD\"],\"7205\":[\"int\",\"list<LimitTurnTableHistoryPOD>\"],\"7302\":[\"int\",\"int\"],\"7303\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"7402\":[],\"7403\":[\"list<int>\"],\"7404\":[],\"7405\":[\"int\",\"list<ItemShowPOD>\"],\"7406\":[\"int\",\"list<int>\",\"list<ItemShowPOD>\"],\"7407\":[\"int\",\"bool\"],\"7502\":[\"long\",\"int\"],\"7503\":[\"list<int>\"],\"7504\":[\"int\",\"int\"],\"7505\":[],\"7506\":[\"int\",\"int\"],\"7507\":[\"int\",\"list<int>\",\"list<ItemShowPOD>\"],\"7508\":[\"int\",\"int\",\"list<ItemShowPOD>\",\"int\"],\"7509\":[\"int\",\"int\"],\"7510\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\"],\"7602\":[],\"7603\":[\"int\"],\"7604\":[\"int\",\"int\"],\"7605\":[\"int\",\"long\"],\"7606\":[\"int\",\"list<int>\"],\"7607\":[\"int\",\"MiningLayerPOD\"],\"7608\":[\"int\",\"int\"],\"7609\":[\"int\",\"list<int>\"],\"7610\":[\"int\",\"int\"],\"7611\":[\"int\"],\"7612\":[\"int\",\"int\"],\"7613\":[\"MiningLayerPOD\"],\"7614\":[\"int\"],\"7615\":[\"bool\",\"map<int|long>\",\"list<ItemShowPOD>\"],\"7616\":[\"list<ItemShowPOD>\"],\"7702\":[\"int\",\"int\",\"int\"],\"7703\":[\"int\"],\"7704\":[\"int\"],\"7705\":[\"int\"],\"7706\":[\"int\",\"int\"],\"7707\":[\"int\",\"int\"],\"7708\":[\"long\",\"long\",\"int\"],\"7709\":[\"long\"],\"7710\":[\"long\",\"long\",\"int\"],\"7711\":[\"long\"],\"7712\":[\"long\"],\"7713\":[\"int\",\"int\",\"int\",\"int\"],\"7714\":[\"int\",\"int\"],\"7715\":[\"int\",\"int\",\"int\"],\"7716\":[\"int\",\"int\"],\"7717\":[\"int\",\"int\",\"int\"],\"7718\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"7719\":[\"int\"],\"7720\":[\"int\"],\"7721\":[\"int\"],\"7722\":[\"int\"],\"7723\":[\"int\",\"list<ItemShowPOD>\"],\"7802\":[\"int\",\"long\"],\"7803\":[\"int\"],\"7804\":[\"bool\",\"int\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"int\"],\"7902\":[\"int\"],\"7903\":[\"int\"],\"7904\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\"],\"8002\":[],\"8003\":[\"int\"],\"8004\":[\"int\",\"int\"],\"8005\":[\"long\"],\"8006\":[\"int\"],\"8007\":[\"int\",\"FlightChallengeMechaPOD\"],\"8008\":[\"int\",\"int\",\"list<ItemShowPOD>\",\"int\"],\"8009\":[\"int\"],\"8010\":[\"bool\",\"int\",\"map<int|long>\"],\"9002\":[\"long\",\"int\"],\"9003\":[\"int\"],\"9004\":[\"bool\",\"map<int|long>\",\"list<ItemShowPOD>\",\"int\",\"list<int>\"],\"9005\":[],\"9102\":[],\"9103\":[],\"9104\":[\"int\"],\"9105\":[],\"9106\":[\"int\",\"int\",\"int\",\"int\"],\"9107\":[],\"9108\":[],\"9109\":[\"int\"],\"9110\":[\"int\",\"list<int>\"],\"9111\":[\"bool\"],\"9112\":[\"bool\",\"int\"],\"9113\":[],\"9114\":[\"int\",\"int\"],\"9115\":[],\"9116\":[\"int\"],\"9117\":[],\"9118\":[\"int\",\"int\",\"int\"],\"9119\":[\"int\",\"long\"],\"9120\":[\"long\"],\"9121\":[\"int\",\"RestaurantOperationAttributePOD\"],\"9122\":[\"int\",\"PositionInformationPOD\"],\"9123\":[\"int\",\"PositionInformationPOD\",\"map<int|int>\",\"RestaurantOperationAttributePOD\"],\"9124\":[\"int\",\"RestaurantOperationAttributePOD\"],\"9125\":[\"int\",\"list<PostPOD>\",\"PositionInformationPOD\",\"int\",\"int\"],\"9126\":[\"int\",\"list<ItemShowPOD>\",\"int\"],\"9127\":[\"int\"],\"9128\":[\"int\",\"int\"],\"9129\":[\"int\",\"int\"],\"9130\":[\"int\",\"RestaurantOperationQuestionPOD\"],\"9131\":[\"int\",\"RestaurantOperationQuestionPOD\",\"list<ItemShowPOD>\"],\"9132\":[\"int\",\"list<RestaurantOperationLinkGamePOD>\"],\"9133\":[\"int\",\"list<RestaurantOperationLinkGamePOD>\"],\"9134\":[\"int\",\"int\"],\"9135\":[\"int\",\"int\"],\"9136\":[\"int\",\"list<RestaurantOperationDrawPOD>\"],\"9137\":[\"int\",\"list<RestaurantOperationDrawPOD>\"],\"9138\":[\"int\"],\"9139\":[\"int\"],\"9140\":[\"int\"],\"9141\":[\"bool\",\"int\",\"map<int|long>\"],\"9142\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"map<int|int>\"],\"9143\":[\"int\"],\"9144\":[\"int\"],\"9145\":[\"list<RestaurantOperationEventPOD>\"],\"9146\":[\"map<int|float>\"],\"9202\":[\"int\"],\"9203\":[\"int\",\"int\"],\"9204\":[\"int\"],\"9205\":[\"long\",\"string\"],\"9206\":[\"long\",\"int\",\"int\"],\"9207\":[\"long\",\"int\"],\"9208\":[\"long\",\"int\"],\"9209\":[\"long\",\"long\",\"bool\"],\"9210\":[\"long\"],\"9211\":[],\"9212\":[\"int\",\"int\"],\"9213\":[\"long\"],\"9214\":[\"long\"],\"9215\":[\"long\"],\"9216\":[\"int\"],\"9217\":[\"int\",\"list<int>\"],\"9218\":[\"long\",\"bool\"],\"9219\":[\"list<long>\"],\"9220\":[\"int\",\"PlaceGameSoulPOD\",\"list<PlaceGameSoulPOD>\"],\"9221\":[\"int\",\"PlaceGameSoulPOD\"],\"9222\":[\"int\",\"int\",\"list<PlaceGameSoulPOD>\"],\"9223\":[\"int\",\"long\",\"string\"],\"9224\":[\"int\",\"PlaceGameFormationPOD\"],\"9225\":[\"int\",\"PlaceGameSoulPrefabPOD\"],\"9226\":[\"int\",\"int\"],\"9227\":[\"int\",\"list<PlaceGameSoulPrefabPOD>\"],\"9228\":[\"int\"],\"9229\":[\"int\",\"list<ItemPOD>\"],\"9230\":[\"int\",\"list<ItemPOD>\"],\"9231\":[\"int\",\"list<PlaceGameSoulPrefabPOD>\"],\"9232\":[\"int\",\"list<PlaceGameSoulPrefabPOD>\"],\"9233\":[\"int\",\"PlaceGameSoulPrefabPOD\"],\"9234\":[\"int\",\"int\"],\"9235\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"9236\":[\"int\"],\"9237\":[\"int\",\"list<ItemShowPOD>\"],\"9238\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\"],\"9239\":[\"PlaceGameSoulPrefabPOD\"],\"9240\":[\"int\"],\"9241\":[\"int\"],\"9242\":[\"int\"],\"9302\":[],\"9303\":[],\"9304\":[\"int\",\"int\"],\"9305\":[\"list<AmusementParkVoCachePOD>\"],\"9306\":[\"list<AmusementParkVoCachePOD>\"],\"9307\":[\"int\"],\"9308\":[],\"9309\":[\"int\"],\"9310\":[\"int\"],\"9311\":[\"int\",\"int\"],\"9312\":[\"int\",\"int\"],\"9313\":[\"int\"],\"9314\":[\"int\",\"list<int>\"],\"9315\":[],\"9316\":[\"int\",\"long\"],\"9317\":[\"long\"],\"9318\":[],\"9319\":[],\"9320\":[\"int\",\"int\"],\"9321\":[],\"9322\":[\"int\",\"int\"],\"9323\":[],\"9324\":[\"int\",\"int\"],\"9325\":[],\"9326\":[\"int\"],\"9327\":[],\"9328\":[\"int\"],\"9329\":[],\"9330\":[\"int\",\"AmusementParkInfoPOD\"],\"9331\":[\"int\",\"list<AmusementParkLandPOD>\"],\"9332\":[\"int\",\"int\"],\"9333\":[\"int\",\"AmusementParkAttPOD\"],\"9334\":[\"int\",\"AmusementParkAttPOD\",\"list<AmusementParkLandPOD>\"],\"9335\":[\"int\",\"int\"],\"9336\":[\"int\",\"list<AmusementParkVoRolePOD>\"],\"9337\":[\"int\",\"list<AmusementParkVoRolePOD>\",\"list<AmusementParkVoRolePOD>\"],\"9338\":[\"int\",\"AmusementParkVoRolePOD\"],\"9339\":[\"int\",\"AmusementParkVoRolePOD\"],\"9340\":[\"int\",\"AmusementParkVoRolePOD\"],\"9341\":[\"int\",\"int\"],\"9342\":[\"int\",\"int\"],\"9343\":[\"int\",\"list<ItemShowPOD>\",\"int\"],\"9344\":[\"int\"],\"9345\":[\"int\"],\"9346\":[\"int\"],\"9347\":[\"int\",\"int\",\"int\"],\"9348\":[\"int\",\"int\",\"int\"],\"9349\":[\"int\",\"int\",\"int\"],\"9350\":[\"int\",\"int\",\"int\"],\"9351\":[\"int\",\"int\",\"int\"],\"9352\":[\"int\",\"int\",\"int\"],\"9353\":[\"int\",\"int\"],\"9354\":[\"int\",\"int\"],\"9355\":[\"int\",\"int\"],\"9356\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"9357\":[\"int\",\"map<int|AmusementParkGameShowInfoPOD>\"],\"9358\":[\"list<AmusementParkLandPOD>\",\"list<int>\"],\"9359\":[\"AmusementParkAttPOD\"],\"9360\":[\"int\"],\"9361\":[\"int\"],\"9362\":[\"list<AmusementParkEventPOD>\"],\"9363\":[\"bool\",\"int\",\"map<int|long>\"],\"9364\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"map<int|int>\"],\"9365\":[\"list<ItemShowPOD>\"],\"9402\":[\"int\"],\"9403\":[\"int\",\"int\",\"int\",\"int\"],\"9404\":[],\"9405\":[],\"9406\":[\"int\",\"int\"],\"9407\":[\"int\",\"int\"],\"9408\":[\"int\",\"list<ItemShowPOD>\",\"int\",\"int\",\"int\",\"int\"],\"9409\":[\"int\",\"int\"],\"9410\":[\"int\"],\"9411\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"9412\":[\"int\",\"list<int>\"],\"9413\":[\"int\",\"int\"],\"9414\":[\"int\"],\"9415\":[\"SurvivalPassStatusPOD\"],\"9416\":[\"list<ItemShowPOD>\"],\"9502\":[\"int\",\"int\",\"int\",\"int\"],\"9503\":[\"list<int>\"],\"9504\":[\"int\",\"long\",\"bool\"],\"9505\":[\"long\"],\"9506\":[\"int\",\"list<int>\"],\"9507\":[\"int\"],\"9508\":[\"int\",\"int\"],\"9509\":[\"int\"],\"9510\":[\"int\"],\"9511\":[\"int\"],\"9512\":[\"int\"],\"9513\":[\"int\",\"int\"],\"9514\":[\"int\",\"int\"],\"9515\":[\"int\",\"list<ItemShowPOD>\"],\"9516\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\",\"bool\",\"int\",\"int\"],\"9517\":[\"bool\",\"int\",\"map<int|long>\"],\"9518\":[\"list<int>\"],\"9519\":[\"int\"],\"9520\":[\"list<HorizontalRPGResPOD>\"],\"9521\":[\"HorizontalRPGPOD\"],\"9522\":[\"int\",\"long\"],\"9523\":[\"int\",\"int\",\"MazePOD\",\"HorizontalRPGMapPOD\",\"int\"],\"9524\":[\"int\"],\"9525\":[\"int\"],\"9526\":[\"bool\",\"int\",\"map<int|long>\",\"list<ItemShowPOD>\"],\"9527\":[\"int\",\"list<ItemShowPOD>\"],\"9528\":[\"int\",\"list<ItemShowPOD>\"],\"9529\":[\"int\",\"list<int>\"],\"9530\":[\"int\",\"int\"],\"9602\":[],\"9603\":[\"bool\"],\"9604\":[],\"9605\":[],\"9606\":[\"int\"],\"9607\":[\"int\"],\"9608\":[\"int\"],\"9609\":[\"int\",\"FishingActivityItemPOD\"],\"9610\":[\"int\"],\"9611\":[\"int\",\"list<FishingActivityItemPOD>\",\"int\"],\"9612\":[\"int\",\"int\"],\"9613\":[\"int\",\"int\",\"int\"],\"9614\":[\"int\",\"int\",\"int\"],\"9615\":[\"int\",\"list<ItemShowPOD>\"]}"
namePodSerialId = "{\"AbyssPlusPOD\":{\"levelScore\":1,\"runes\":2,\"usedRunes\":3},\"ActiveTurntableRecordPOD\":{\"goods\":3,\"pid\":1,\"pname\":2,\"rare\":4,\"time\":5},\"AffairEventPOD\":{\"cid\":1,\"soulCid\":3,\"time\":2},\"AffairPOD\":{\"cid\":2,\"events\":6,\"finishTime\":4,\"id\":1,\"soulCids\":5,\"status\":3},\"AlienRewardStatusPOD\":{\"cid\":1,\"status\":2},\"AmusementParkAttPOD\":{\"attr\":3,\"level\":1,\"number\":2},\"AmusementParkEventPOD\":{\"achievement\":4,\"date\":1,\"eventCfgId\":2,\"status\":3,\"value\":5},\"AmusementParkGamePOD\":{\"answer\":8,\"dLevel\":1,\"dollMachine\":2,\"oneStrokeId\":7,\"pLevel\":3,\"pixelBird\":4,\"sLevel\":5,\"stacking\":6},\"AmusementParkGameShowInfoPOD\":{\"level\":1,\"score\":2},\"AmusementParkInfoPOD\":{\"amusementParkAttPOD\":1,\"amusementParkVoRoles\":4,\"amusementParkVoRolesHave\":5,\"boss\":6,\"dialogId\":8,\"plot\":7,\"postList\":2,\"unitList\":3},\"AmusementParkLandPOD\":{\"doll\":5,\"level\":2,\"post\":3,\"property\":4,\"roleAdd\":6,\"unitID\":1},\"AmusementParkPOD\":{\"event\":3,\"exBossIsLock\":2,\"numberOfReturns\":1},\"AmusementParkVoCachePOD\":{\"post\":1,\"unit\":2},\"AmusementParkVoInfoPOD\":{\"addItem\":11,\"amusementParkLandPODList\":3,\"amusementParkVoRoles\":4,\"amusementParkVoRolesHave\":5,\"completedTask\":15,\"controlCid\":1,\"dialogIDSequence\":12,\"events\":14,\"finishedPlot\":13,\"lastAttackExBossHurt\":16,\"lastRefreshTime\":7,\"lastRefreshTimeOfEvent\":8,\"lastRefreshTimeOfPerformance\":9,\"monster\":17,\"postList\":2,\"rankNumber\":19,\"roleLevelUpNumber\":18,\"unclaimedAwardNumber\":6,\"unclaimedAwardNumberForPerformance\":10},\"AmusementParkVoRolePOD\":{\"attr\":3,\"id\":1,\"level\":2,\"status\":4},\"AreaPOD\":{\"cid\":1,\"isLock\":2,\"isNew\":3},\"BasicHomeInfoPOD\":{\"alreadyReward\":5,\"currentComfort\":3,\"id\":1,\"maxComfort\":4,\"pname\":2},\"BattlePassesPOD\":{\"advanced\":1,\"bpExp\":2,\"bpLv\":3,\"lastSeasonLv\":4,\"rewardsGetList\":5},\"BuildingPOD\":{\"cid\":2,\"helpLogs\":3,\"id\":1,\"kitchenPOD\":6,\"lands\":5,\"lv\":9,\"manufacture\":8,\"officePOD\":7,\"productionData\":4},\"CChatPOD\":{\"channel\":1,\"content\":4,\"target\":3,\"type\":2},\"CenterCupMatchVoteDataPOD\":{\"finalTime\":5,\"finishTime\":6,\"group\":3,\"knockoutTime\":4,\"lastVoteTime\":7,\"stage\":1,\"votes\":2},\"CenterEvilErosionPOD\":{\"levelRatingTime\":1},\"CenterGuildChallengePOD\":{\"bossType\":1,\"buffOrder\":2},\"CenterGuildTrainingPOD\":{\"id\":1},\"CenterGuildTrainingPlayerRankPOD\":{\"createTime\":4,\"name\":2,\"pid\":1,\"score\":3},\"CenterLoadPlayerPOD\":{\"chatRoom\":1,\"eoDataPOD\":4,\"friends\":2,\"guildChatCaches\":7,\"guildId\":5,\"guildName\":6,\"simplePlayerPOD\":3},\"CenterLunaBattleLineDataPOD\":{\"participation\":2,\"zoneSealPercentage\":1},\"CenterServerDiscreteDataPOD\":{\"mallRandomGroup\":1},\"CenterVoteDataPOD\":{\"votes\":1},\"CenterWorldBossPOD\":{\"bossType\":1,\"buffOrder\":2},\"ChallengePOD\":{\"difficult\":1},\"ChatRoomPOD\":{\"msg\":3,\"onlineCount\":2,\"roomNumber\":1},\"CulinaryPOD\":{\"cid\":2,\"costs\":6,\"finishTime\":4,\"id\":1,\"idx\":5,\"num\":7,\"receiveNum\":8,\"singleCookTime\":9,\"startTime\":10,\"status\":3},\"CupMatchVoteDataPOD\":{\"myVotes\":1,\"tickets\":2},\"DailyDupCommonPOD\":{\"centerEvilErosionPOD\":7,\"centerGuildChallengePOD\":8,\"centerGuildTrainingPOD\":9,\"centerLunaBattleLineDataPOD\":6,\"centerWorldBoss\":5,\"cid\":1,\"openCount\":3,\"openDate\":4,\"status\":2},\"DailyDupPOD\":{\"abyssPlusPOD\":16,\"amusementParkPOD\":24,\"battlePassesPOD\":8,\"buyCount\":2,\"challengeDataPOD\":11,\"challengePOD\":4,\"common\":1,\"dreamMapPOD\":10,\"dualTeamExplorePOD\":12,\"enterCount\":3,\"evilErosionPOD\":15,\"fishingActivityPOD\":27,\"flightChallengePOD\":20,\"guildChallengePOD\":17,\"guildTrainingPOD\":21,\"horizontalRPGPOD\":26,\"lunaBattleLineDataPOD\":9,\"magicTowerPOD\":13,\"miniGalGameDataPOD\":14,\"miningPOD\":18,\"placeGamePOD\":23,\"restaurantOperationPOD\":22,\"rpgMazePOD\":7,\"singleWeakTower\":19,\"survivalPOD\":25,\"towerPOD\":5,\"worldBossPOD\":6},\"DailyResetPOD\":{\"dailySupplyList\":4,\"dailyWorkCount\":5,\"exchangeRecords\":3,\"guildQuestGetRecord\":7,\"isGuildSign\":6,\"lotteryCnts\":2,\"remainderGiveGiftNum\":1},\"DecoratePOD\":{\"cid\":1,\"x\":2,\"y\":3},\"DollPOD\":{\"dress2DCid\":9,\"dress3DCid\":10,\"equipments\":7,\"exp\":4,\"formationPos\":19,\"hp\":20,\"initSkills\":5,\"jewelry\":24,\"lv\":3,\"mazeRecord\":8,\"mood\":15,\"newJewelryDollPOD\":25,\"pAblityIds\":17,\"position\":18,\"power\":14,\"skillGroupId\":22,\"skillStrengthens\":6,\"soulCid\":1,\"soulMarryCid\":12,\"soulMemoryPieces\":13,\"soulQualityCid\":2,\"specialSpirit\":23,\"talentCids\":11,\"talentGroupCids\":16,\"unlockSkillGroups\":21},\"DoubleFightDataPOD\":{\"doubleFightSteps\":1},\"DoubleFightRecordPOD\":{\"formationInfoPOD\":2,\"hurtPercentage\":5,\"hurtScore\":4,\"index\":1,\"isWin\":3,\"round\":7,\"roundScore\":6},\"DoubleFightStepPOD\":{\"getAwardsIndex\":4,\"maxScore\":2,\"records\":5,\"score\":3,\"step\":1},\"DreamMapCellPOD\":{\"dataId\":3,\"elementId\":6,\"isOpen\":4,\"markType\":7,\"showType\":5,\"x\":1,\"y\":2},\"DreamMapDataPOD\":{\"cells\":2,\"combo\":6,\"currDialog\":7,\"mapId\":1,\"movePoint\":5,\"resetCount\":8,\"roleX\":3,\"roleY\":4},\"DreamMapExectionItemPOD\":{\"exectionId\":1,\"getItems\":2,\"getMovePoint\":3,\"getSpAwardId\":4},\"DreamMapPOD\":{\"spRewardsCount\":2,\"unlockMaps\":1},\"DressPOD\":{\"dressCid\":1,\"expireTime\":2,\"isNew\":3},\"DualTeamExploreLevelPOD\":{\"currDialog\":7,\"currFightMonsterTeamId\":8,\"currMazeCid\":9,\"currNumberInputId\":10,\"currTeam\":6,\"currTransportNodeId\":11,\"easyMode\":12,\"levelCid\":1,\"nodes\":2,\"separate\":5,\"team1\":3,\"team2\":4},\"DualTeamExploreNodePOD\":{\"capacity\":4,\"cid\":2,\"id\":1,\"nextNodes\":3,\"occupierTeamId\":5},\"DualTeamExplorePOD\":{\"controlCid\":1,\"currLevelCid\":8,\"exBossFormationInfo1\":10,\"exBossFormationInfo2\":12,\"exBossOpen\":6,\"exBossScore1\":11,\"exBossScore2\":13,\"finishEasyLevels\":15,\"finishLevels\":9,\"freeChallengeBossCount\":3,\"killedBoss\":5,\"lastAttackExBossTime1\":7,\"lastAttackExBossTime2\":14,\"tickets\":2,\"unlockBoss\":4},\"DualTeamExploreTeamPOD\":{\"currNodeId\":3,\"dead\":2,\"formationInfo\":1,\"stop\":4},\"DynamicTaskPOD\":{\"checkType\":17,\"commitStatus\":9,\"content\":3,\"desc\":20,\"endTime\":13,\"finNum\":7,\"icon\":19,\"id\":1,\"isNew\":15,\"isPop\":16,\"mTitle\":4,\"prize_cid\":10,\"prize_num\":11,\"sortNum\":14,\"startTime\":12,\"tgtNum\":6,\"tgtParams\":18,\"tgt_str\":8,\"title\":2,\"type\":5},\"EnterMazeSoulPrefabPOD\":{\"postion\":2,\"soulPrefabId\":1},\"EquipmentPOD\":{\"cid\":1,\"exp\":3,\"lock\":4,\"lv\":2,\"star\":5},\"EquipmentPrefabPOD\":{\"equipmentMap\":4,\"id\":1,\"idx\":3,\"name\":2,\"soulCid\":5},\"EvilErosionPOD\":{\"currLevel\":1,\"getDailySupplys\":4,\"rating\":3,\"soulPrefabs\":2},\"EvilErosionSoulPrefabPOD\":{\"allSkillStrengths\":12,\"allSkills\":11,\"attr\":8,\"customSkills\":10,\"dress2DCid\":5,\"dress3DCid\":6,\"equipments\":9,\"formationPos\":14,\"id\":1,\"lv\":3,\"position\":13,\"power\":7,\"qualityId\":4,\"soulCid\":2},\"FightPOD\":{\"Attacker\":5,\"BattleParams\":9,\"BattleType\":2,\"Defender\":6,\"ID\":1,\"MapID\":3,\"MaxRound\":10,\"MonsterTeamID\":8,\"Players\":7,\"RandomSeed\":4},\"FightTroopPOD\":{\"ArrFightUnitPOD\":2,\"Buffs\":1},\"FightUnitPOD\":{\"Attributes\":4,\"BattlePos\":6,\"InitBuff\":12,\"IsHelper\":10,\"Level\":3,\"MonsterCfgId\":2,\"Pid\":1,\"Power\":11,\"SPStatus\":9,\"SkillStrengthens\":8,\"Skills\":7,\"TroopType\":5},\"FishingActivityItemPOD\":{\"fishId\":1,\"num\":3,\"weight\":2},\"FishingActivityPOD\":{\"actionLevel\":7,\"autoFishingRewardsTime\":4,\"book\":1,\"getStoryList\":5,\"maxWeight\":3,\"roleLevel\":8,\"skillLevel\":6,\"totalWeight\":2},\"FishingDataPOD\":{\"baitId\":3,\"countdown\":5,\"fishId\":1,\"rodId\":2,\"specimenData\":4,\"state\":6},\"FlightChallengeMechaPOD\":{\"firingSpeed\":3,\"growthAttribute\":2,\"id\":1},\"FlightChallengePOD\":{\"flightChallengeMechas\":2,\"record\":1},\"FormationEquipPOD\":{\"cid\":1,\"lv\":2,\"star\":3},\"FormationInfoPOD\":{\"index\":2,\"name\":1,\"soulPrefabs\":3,\"userData\":4},\"FormationJewelryPOD\":{\"cid\":1,\"speed\":2,\"star\":3},\"FormationPOD\":{\"formation\":3,\"id\":1,\"index\":4,\"name\":2},\"FormationSoulPrefabPOD\":{\"activeTalentCids\":17,\"activeTalentGroupCids\":18,\"allSkillStrengths\":14,\"allSkills\":13,\"attr\":8,\"customSkills\":10,\"dress2DCid\":4,\"dress3DCid\":5,\"equipments\":9,\"exp\":16,\"favorLv\":6,\"id\":23,\"jewelryPOD\":26,\"lv\":2,\"mood\":21,\"optionalSkill\":25,\"pAblityIds\":22,\"position\":12,\"power\":7,\"qualityId\":3,\"skillGroupId\":11,\"soulCid\":1,\"soulMarryCid\":19,\"soulMemoryPieces\":20,\"specialSpirit\":24,\"unlockSkillGroups\":15},\"FriendPOD\":{\"avatarFrame\":14,\"createTime\":11,\"guid\":2,\"headIcon\":5,\"id\":1,\"lastLoginTime\":12,\"online\":8,\"pId\":3,\"pLv\":7,\"pName\":4,\"remark\":9,\"serverId\":13,\"title\":15,\"type\":10,\"vip\":6},\"FurnitureGachaDataPOD\":{\"gachaCount\":1,\"gachaIdList\":2},\"GachaPoolDataPOD\":{\"getAwards\":1,\"isRefresh\":2},\"GirlPOD\":{\"activation\":3,\"datingRecord\":2,\"soulCid\":1},\"GlobalBuffPOD\":{\"cid\":1,\"endTime\":2},\"GmMailPOD\":{\"channelIds\":13,\"content\":3,\"createTime\":5,\"endTime\":6,\"id\":1,\"isAllPlayer\":8,\"isAllTime\":9,\"itemList\":7,\"levelLimit\":11,\"payPoint\":12,\"sender\":4,\"target\":10,\"title\":2},\"GroupPurchaseCommonDataPOD\":{\"totalCount\":1},\"GroupPurchaseDataPOD\":{\"buyCount\":1},\"GroupPurchaseRewardPOD\":{\"payPoint\":1,\"rewardData\":2},\"GuildAuditPOD\":{\"lastLoginTime\":3,\"online\":2,\"player\":1},\"GuildBasePOD\":{\"auditType\":7,\"avatarFrame\":5,\"headIcon\":4,\"id\":1,\"leaderName\":8,\"level\":3,\"memberMaxNum\":10,\"memberNum\":9,\"name\":2,\"policy\":6},\"GuildBuildingPOD\":{\"buyEffectExpTime\":3,\"cid\":1,\"lv\":2},\"GuildChallengePOD\":{\"currBossLevel\":1,\"getRewards\":2},\"GuildMemberPOD\":{\"activeNum\":6,\"joinTime\":5,\"lastLoginTime\":3,\"online\":2,\"player\":1,\"position\":4},\"GuildPOD\":{\"banNotice\":10,\"base\":1,\"buildings\":4,\"fund\":3,\"fundDailyGetRecord\":6,\"impeachmentTime\":2,\"members\":8,\"newAuditCount\":7,\"notice\":9,\"questProgress\":5},\"GuildTrainingBossScorePOD\":{\"pids\":2,\"score\":1},\"GuildTrainingPOD\":{\"getAward\":2,\"guildIntegral\":3,\"maxIntegral\":1},\"HelpLogPOD\":{\"createTime\":6,\"entryCid\":4,\"entryVal\":5,\"name\":2,\"pid\":1,\"target\":3},\"HelpNewbiesDataPOD\":{\"rookie\":3,\"senior\":2,\"type\":1},\"HelpNewbiesFollowerDataPOD\":{\"lastMazeId\":2,\"pod\":1},\"HelpNewbiesRookieDataPOD\":{\"name\":2,\"reachedLevel\":4,\"useCode\":3,\"usedInviteCode\":1},\"HelpNewbiesSeniorDataPOD\":{\"eventTask\":2,\"finishedTask\":3,\"inviteCode\":1},\"HomePOD\":{\"activationDecorates\":7,\"baseInfo\":1,\"buildings\":2,\"roles\":6,\"rooms\":3,\"todayActions\":11,\"triggerDialogs\":5,\"unlockAIActions\":10,\"unlockCookBook\":9,\"unlockManufactureItem\":4,\"unlockSuit\":8,\"visitTreasureChest\":12},\"HomeRolePOD\":{\"belongRoom\":5,\"dress2DCid\":2,\"dress3DCid\":3,\"favorLv\":4,\"letters\":6,\"newStoryId\":8,\"roleCid\":1,\"transactionCid\":7},\"HorizontalRPGElementPOD\":{\"effect\":2,\"id\":1},\"HorizontalRPGInfoPOD\":{\"boss\":6,\"currLevel\":21,\"dialogIDSequence\":5,\"dolls\":14,\"exBoss\":7,\"formationId\":9,\"freeChallengeBossCount\":15,\"horizontalRPGMapPODs\":13,\"invincibleTime\":10,\"killBoss\":17,\"lastAttackExBossHurt\":8,\"levelDialogIDSequence\":19,\"map\":4,\"maxOrderMap\":22,\"onlyOne\":18,\"passedRecord\":23,\"star\":1,\"starUpperLimit\":2,\"task\":11,\"taskTips\":12,\"tickets\":16,\"unlockedDifficulty\":20,\"weather\":3},\"HorizontalRPGMapPOD\":{\"born\":3,\"currLevelCid\":5,\"element\":4,\"id\":1,\"region\":2},\"HorizontalRPGPOD\":{\"boss\":8,\"dialog\":4,\"dolls\":10,\"exBoss\":7,\"finnishLevels\":14,\"freeChallengeBossCount\":11,\"horizontalRPGMapPODs\":9,\"killBoss\":13,\"levelDialog\":16,\"star\":1,\"starUpperLimit\":2,\"task\":5,\"taskTips\":6,\"tickets\":12,\"unlockedDifficulty\":15,\"weather\":3},\"HorizontalRPGResPOD\":{\"elementId\":2,\"id\":1,\"info\":4,\"type\":3},\"ImagePuzzleEventPOD\":{\"gotRewards\":4,\"rewards\":3,\"unlockedPlace\":2,\"unlockedRewardsIdx\":1},\"ItemEquipmentPOD\":{\"exp\":2,\"lock\":4,\"lv\":1,\"soulPrefabIds\":3,\"star\":5,\"upCostGold\":6},\"ItemPOD\":{\"cid\":2,\"createTime\":5,\"equipmentData\":6,\"id\":1,\"newJewelryEquipmentVoPOD\":8,\"num\":3,\"placeGameEquipPOD\":7,\"usedNum\":4},\"ItemShowPOD\":{\"cid\":1,\"num\":2,\"tag\":3},\"ItemUseRecordPOD\":{\"itemCid\":1,\"useTime\":2},\"KitchenPOD\":{\"culinarys\":2,\"maxQueueCount\":1},\"LandPOD\":{\"cid\":1,\"currentSeedCid\":2,\"finishTime\":3,\"status\":4},\"LibraryAreaPOD\":{\"entrys\":1,\"rewards\":2},\"LibraryMonsterPOD\":{\"count\":1,\"rewards\":2},\"LibraryNpcPOD\":{\"entrys\":1,\"rewards\":2},\"LibraryPOD\":{\"alienEvent\":6,\"alienRewards\":8,\"area\":1,\"equipStar\":9,\"getNewsBook\":12,\"monster\":3,\"newsBook\":4,\"npc\":2,\"rumorPlate\":5,\"souls\":10,\"townStory\":7,\"townStoryCG\":11},\"LibrarySoulPOD\":{\"datings\":4,\"newStroys\":3,\"soulCid\":1,\"unlockPlate\":2},\"LimitTurnTableDataPOD\":{\"getAwards\":1,\"insureTimes\":2},\"LimitTurnTableHistoryPOD\":{\"rewardId\":2,\"time\":1},\"LoadOperationEventDataPOD\":{\"newbiesMapDataPOD\":1},\"LotteryHistoryPOD\":{\"itemCid\":2,\"itemNum\":3,\"lotteryCid\":1,\"time\":4},\"LotteryShowPOD\":{\"drawCount\":3,\"leftHiddenInsureTime\":4,\"leftInsureTime\":2,\"showCid\":1},\"LuckDrawHistoryPOD\":{\"itemCid\":1,\"itemNum\":2,\"time\":3},\"LunaBattleLineAssistUnitPOD\":{\"player\":1,\"soulPrefab\":2},\"LunaBattleLineDataPOD\":{\"participation\":2,\"zones\":1},\"LunaBattleLineZonePOD\":{\"garrison\":2,\"zoneId\":1},\"MagicMuseumDataPOD\":{\"bossFightCount\":1,\"bossRewardsCount\":2,\"curRound\":3},\"MagicTowerMapCellPOD\":{\"dataId\":5,\"floor\":2,\"id\":1,\"x\":3,\"y\":4},\"MagicTowerMapDataPOD\":{\"cells\":2,\"currDialog\":4,\"mapId\":1,\"role\":3},\"MagicTowerMapExecutionItemPOD\":{\"executionType\":1,\"getItems\":3,\"params\":2,\"role\":4},\"MagicTowerPOD\":{\"currMapId\":1},\"MagicTowerRolePOD\":{\"atk\":4,\"cellId\":1,\"def\":3,\"equipments\":5,\"hp\":2,\"key1\":6,\"key2\":7,\"key3\":8},\"MailPOD\":{\"cid\":2,\"content\":4,\"createTime\":8,\"expireTime\":9,\"id\":1,\"isHasItem\":7,\"isRead\":6,\"itemList\":10,\"sender\":5,\"title\":3},\"MakePOD\":{\"cid\":2,\"costs\":5,\"finishTime\":4,\"id\":1,\"status\":3},\"ManufacturePOD\":{\"makes\":2,\"maxQueueCount\":1},\"MazeInfoPOD\":{\"buyCount\":6,\"cid\":1,\"enterCount\":5,\"score\":3,\"star\":2,\"starConditions\":4,\"winCount\":7},\"MazeMopUpPOD\":{\"addSoulExps\":2,\"money\":4,\"playerExp\":3,\"rewards\":1},\"MazePOD\":{\"carryItems\":4,\"id\":1,\"isLocal\":7,\"mazeCid\":2,\"mazePlayer\":5,\"randomSeed\":3,\"saveData\":6,\"saveVersion\":8},\"MazePlayerBaseInfoPOD\":{\"avatarFrame\":10,\"exp\":7,\"headIcon\":3,\"leaderCid\":2,\"pLv\":6,\"pName\":1,\"pid\":8,\"serverId\":9,\"vip\":4,\"vipexp\":5},\"MazePlayerPOD\":{\"alienEvents\":9,\"baseInfo\":2,\"completePathNodes\":8,\"dolls\":3,\"finishMazes\":13,\"finishQuests\":15,\"first\":1,\"fishSpecimens\":16,\"itemDropGetCnts\":11,\"mainQuests\":6,\"openPathNodes\":7,\"playerParams\":5,\"records\":17,\"unlockMonsters\":12,\"unlockRunes\":10,\"unlockSouls\":14,\"unlockedEvents\":4},\"MazeSettlementPOD\":{\"completeNodeCount\":16,\"completePathNodes\":5,\"deadCount\":11,\"dolls\":19,\"duration\":13,\"fightWinCount\":15,\"getItems\":9,\"killBossCount\":14,\"killMonsterRecord\":7,\"mazeData\":2,\"mazeItemDropGetCnts\":18,\"openPathNodes\":4,\"otherData\":17,\"playerParams\":6,\"records\":21,\"reviveCount\":12,\"rewards\":10,\"saveVersion\":20,\"score\":3,\"starConditions\":8,\"success\":1},\"MazeSettlementResultPOD\":{\"addSoulExps\":6,\"firstRewards\":4,\"money\":8,\"playerExp\":7,\"rewards\":5,\"rewardsBoxes\":9,\"score\":2,\"starConditions\":3,\"success\":1},\"MazeSettlementRewardBoxPOD\":{\"cid\":1,\"items\":3,\"num\":2},\"MiniGalGameBasePOD\":{\"areaList\":3,\"baseProps\":4,\"day\":1,\"dayOfPhase\":2},\"MiniGalGameCountPOD\":{\"countId\":1,\"recordCountOfDay\":2,\"recordCountOfMonth\":4,\"recordCountOfTotal\":6,\"recordCountOfWeek\":3,\"recordCountOfYear\":5},\"MiniGalGameDataPOD\":{\"achievementData\":2,\"saveList\":1},\"MiniGalGameGirlDataPOD\":{\"callCount\":4,\"favorAbility\":2,\"girlId\":1,\"messageGroups\":7,\"noShow\":5,\"phoneLock\":3,\"rejectCount\":6},\"MiniGalGameItemPOD\":{\"itemId\":1,\"itemNum\":2},\"MiniGalGameMessageGroupPOD\":{\"day\":2,\"dayOfPhase\":3,\"id\":1,\"messageIds\":4},\"MiniGalGameSavaDataDetailPOD\":{\"basePOD\":1,\"dialogId\":8,\"girls\":2,\"itemUsedCount\":11,\"items\":5,\"localAchievementData\":12,\"messageGroupCount\":13,\"playthrough\":9,\"scheduleList\":6,\"shopRecord\":4,\"taskList\":3,\"towerRecord\":7,\"triggeredCount\":10},\"MiniGalGameSavaDataPOD\":{\"day\":2,\"dayOfPhase\":3,\"gameOver\":5,\"saveTime\":4,\"slot\":1},\"MiniGalGameSchedulePOD\":{\"areaId\":5,\"day\":2,\"dayOfPhase\":3,\"functionId\":6,\"girlId\":4,\"id\":1,\"status\":7},\"MiningGridPOD\":{\"dataCid\":5,\"id\":1,\"skinId\":6,\"state\":4,\"x\":2,\"y\":3},\"MiningLayerPOD\":{\"floor\":1,\"grids\":2},\"MiningPOD\":{\"dialogId\":3,\"floorMax\":2,\"floorNow\":1},\"NewCharacterDataPOD\":{\"bingoNums\":2,\"bingoRewards\":3,\"finishStories\":4,\"remainCount\":6,\"round\":1,\"totalTicket\":5},\"NewCharacterRewardsLogPOD\":{\"id\":3,\"idx\":1,\"rewards\":4,\"time\":5,\"type\":2},\"NewJewelryDollPOD\":{\"cid\":1,\"speed\":3,\"star\":2},\"NewJewelryEquipmentVoPOD\":{\"soul\":2,\"star\":1},\"OfficePOD\":{\"affairs\":1,\"freeRefreshTimes\":2},\"OperationEventDataPOD\":{\"advPOD\":16,\"cupMatchVoteDataPOD\":19,\"dataCfgId\":2,\"doubleFightDataPOD\":8,\"eventCfgId\":1,\"furnitureGachaDataPOD\":10,\"gachaPoolData\":7,\"gpData\":3,\"helpNewbiesDataPOD\":15,\"ipData\":4,\"limitTurnTableDataPOD\":18,\"mmData\":5,\"ncData\":6,\"paidQuestDataPOD\":12,\"pandaDataPOD\":11,\"spaceTreasureDataPOD\":9,\"treasureHuntDataPOD\":14,\"turntableDataPOD\":17,\"voteDataPOD\":13},\"OperationEventPOD\":{\"closeTime\":6,\"dataCfgId\":2,\"endTime\":5,\"eventCfgId\":1,\"eventUid\":8,\"extJsonData\":7,\"startTime\":4,\"status\":3},\"PLaceGameRankInfoPOD\":{\"pid\":2,\"score\":1},\"PaidQuestDataPOD\":{\"paid\":1},\"PandaDataPOD\":{\"exploreCount\":4,\"favorNum\":1,\"getGifts\":3,\"maxFavorNum\":2},\"PlaceGameEquipPOD\":{\"level\":1,\"lock\":5,\"pAbilityIDEffect1\":3,\"pAbilityIDEffect2\":4,\"property\":2},\"PlaceGameFormationPOD\":{\"formation\":3,\"id\":1,\"index\":4,\"name\":2},\"PlaceGameInfoPOD\":{\"controlCid\":1,\"dialogIDSequence\":12,\"equipmentTreasureBox\":4,\"finishedPlot\":13,\"firingSoul\":10,\"numberOfPlies\":2,\"placeGameFormationPODS\":11,\"soulPrefabs\":9,\"time\":5,\"timeDate\":6,\"timeEquip\":7,\"timeEquipDate\":8,\"treasureBox\":3},\"PlaceGamePOD\":{\"award\":1,\"customs\":2,\"dialogId\":8,\"firingSoulPODs\":6,\"placeGameFormationPODs\":4,\"placeGameSoulPODs\":3,\"placeGameSoulPrefabPODs\":5,\"plot\":7},\"PlaceGamePropertyPOD\":{\"id\":1,\"value\":2},\"PlaceGameSoulPOD\":{\"cid\":2,\"experience\":3,\"level\":1},\"PlaceGameSoulPrefabInfoPOD\":{\"experience\":6,\"id\":1,\"level\":5,\"location\":3,\"soulCid\":2,\"stance\":4},\"PlaceGameSoulPrefabPOD\":{\"attr\":5,\"equipments\":6,\"formationPos\":8,\"id\":1,\"lv\":3,\"position\":7,\"power\":4,\"soulCid\":2},\"PlayerBaseInfoPOD\":{\"areaId\":19,\"avatarFrame\":22,\"channelNo\":24,\"chatBackground\":26,\"createTime\":17,\"exp\":13,\"guid\":2,\"guildId\":25,\"headIcon\":5,\"intro\":4,\"leaderCid\":9,\"openId\":3,\"pLv\":12,\"pName\":6,\"payPoint\":18,\"pid\":1,\"power\":14,\"sceneID\":16,\"sdkName\":8,\"serverId\":7,\"showSoulCid\":15,\"sumPay\":21,\"title\":23,\"uid\":20,\"vip\":10,\"vipexp\":11},\"PlayerInfoPOD\":{\"allCollectItems\":3,\"baseInfo\":1,\"finishMaze\":5,\"guildId\":6,\"guildName\":7,\"showCollectItems\":2,\"soulCount\":4},\"PlayerPOD\":{\"abyssCid\":57,\"abyssCids\":89,\"advanceLevelChaseFlag\":67,\"antiAddictionAccTime\":32,\"avatarFrameTimelimit\":70,\"backflowTime\":72,\"baseInfo\":1,\"chatRoom\":23,\"commandChallengeLayerIDs\":88,\"currDialog\":11,\"currMazes\":15,\"currentGuide\":34,\"currentWeatherCid\":26,\"dailyDups\":51,\"dailySupplyList\":46,\"disableGuide\":59,\"dressUpRotateList\":91,\"dressUpRotateSwitch\":90,\"dresses\":9,\"equipSkins\":74,\"equipmentPrefabs\":47,\"exchangeRecords\":27,\"failQuestList\":12,\"finishGuide\":35,\"finishMazes\":7,\"finishQuestList\":14,\"fishingData\":73,\"fondleNum\":18,\"formations\":36,\"friends\":24,\"functionTypes\":2,\"globalBuffs\":20,\"guildChatCaches\":83,\"guildId\":78,\"guildName\":79,\"guildQuestGetRecord\":82,\"headIconTimelimit\":69,\"isGuildSign\":80,\"itemDebts\":63,\"itemUseRecords\":4,\"lotteryCnts\":39,\"lotteryRecords\":29,\"lotteryShows\":28,\"mallBuyCountHistory\":56,\"mallBuyCountRecords\":31,\"mallStartSellTime\":77,\"mazeInfoPOD\":37,\"monthCard\":55,\"newMailCount\":16,\"nextRecoveryEnergyTime\":17,\"nextRecoveryFondleTime\":19,\"numAttrs\":21,\"opEventsDatas\":62,\"opEventsStatus\":61,\"openExtraMazes\":41,\"payCount\":53,\"payExBonus\":54,\"playerParams\":33,\"playerSetting\":86,\"quests\":13,\"quickChallenge\":92,\"randomMalls\":81,\"refundsGiftPackRewards\":76,\"refundsGiftPacks\":75,\"remainderGiveGiftNum\":10,\"settingData\":60,\"shops\":6,\"showCollectItems\":66,\"signInfo\":30,\"soulMemoryChapters\":48,\"soulNewStorys\":49,\"soulPrefabs\":38,\"souls\":5,\"titleTimelimit\":71,\"todayHelpBuildingCount\":44,\"todayHelpHomeCount\":43,\"todayHomeWorkCount\":52,\"todayOpenVisitTreasureChest\":42,\"townInfo\":50,\"unlockAvatarFrames\":58,\"unlockChapterTasks\":87,\"unlockChatBackgrounds\":85,\"unlockChatEmojis\":64,\"unlockGirlBackgrounds\":84,\"unlockHeadIcons\":22,\"unlockLoginBackgrounds\":25,\"unlockRunes\":40,\"unlockSoulWhispers\":68,\"unlockTitle\":65,\"unlockTownEvents\":45,\"unlockedEvents\":8,\"warehouse\":3},\"PlayerPlatformDataPOD\":{\"attMap\":2,\"channelNo\":3,\"sdkName\":1},\"PlayerSimplePOD\":{\"avatarFrame\":9,\"chatBackground\":13,\"guid\":8,\"guildId\":11,\"headIcon\":4,\"leaderCid\":3,\"pLv\":6,\"pName\":2,\"pid\":1,\"serverId\":7,\"showGirlDressId\":12,\"title\":10,\"vip\":5},\"PositionInformationPOD\":{\"att\":4,\"count\":5,\"id\":1,\"location\":3,\"postType\":2},\"PostPOD\":{\"number\":3,\"positionInformation\":2,\"restaurantMarkUp\":5,\"type\":1,\"value\":4},\"ProductionPOD\":{\"itemAwards\":2,\"nextProduceTime\":4,\"oneProduceTime\":5,\"output\":1,\"storageLimit\":3},\"QuestPOD\":{\"cid\":1,\"createTime\":4,\"finNum\":2,\"tgtNum\":3},\"RPGMazePOD\":{\"controlCid\":1,\"dolls\":2,\"exBossOpen\":7,\"freeChallengeBossCount\":4,\"killedBoss\":6,\"lastAttackExBossTime\":8,\"tickets\":3,\"unlockBoss\":5},\"RankSubsectionItemPOD\":{\"guildId\":4,\"percentRank\":2,\"pids\":3,\"score\":1},\"RankingPOD\":{\"avatarFrame\":11,\"customData\":9,\"guid\":5,\"headIcon\":6,\"name\":2,\"pLv\":8,\"pid\":1,\"serverId\":12,\"title\":13,\"updateTime\":4,\"userData\":10,\"value\":3,\"vip\":7},\"RestaurantOperationAttributePOD\":{\"allAtt\":7,\"dialogId\":2,\"income\":5,\"level\":1,\"plot\":6,\"positionInformation\":4,\"postInfo\":3},\"RestaurantOperationDrawPOD\":{\"cumulativeSteps\":2,\"id\":1,\"time\":3},\"RestaurantOperationEventPOD\":{\"achievement\":4,\"date\":3,\"id\":1,\"status\":2,\"value\":5},\"RestaurantOperationLinkGamePOD\":{\"id\":1,\"time\":2},\"RestaurantOperationPOD\":{\"combatTraining\":2,\"event\":4,\"exBossLock\":3,\"numberOfReturns\":1},\"RestaurantOperationQuestionPOD\":{\"date\":3,\"id\":2,\"number\":5,\"rightNumber\":1,\"state\":4},\"RoleInfoPOD\":{\"createTime\":6,\"guid\":5,\"leaderCid\":3,\"lv\":4,\"pid\":1,\"pname\":2},\"RoomPOD\":{\"cid\":2,\"comfort\":3,\"dbid\":1,\"decorates\":4,\"foreignShow\":7,\"name\":6,\"receiveComfortAwards\":8,\"suitCid\":5},\"SChatPOD\":{\"channel\":2,\"content\":5,\"sender\":1,\"target\":4,\"time\":6,\"type\":3},\"ShopPOD\":{\"buyGoodsList\":7,\"cid\":1,\"freeRefreshCnt\":4,\"goodsList\":2,\"itemRefreshCnt\":5,\"nextRefreshTime\":3,\"payRefreshCnt\":6},\"SimplePlayerPOD\":{\"avatarFrame\":19,\"banSpeakEndTime\":17,\"chatBackground\":22,\"chatRoomId\":16,\"createTime\":11,\"guid\":15,\"headIcon\":14,\"isOnline\":7,\"isRobot\":8,\"lastLoginTime\":9,\"lastLogoutTime\":10,\"leaderCid\":5,\"lv\":3,\"pid\":2,\"pname\":4,\"registerIp\":18,\"serverId\":12,\"showGirlDressId\":21,\"teamPower\":6,\"title\":20,\"totalCharge\":23,\"uid\":1,\"vip\":13},\"SingleWeakTowerPOD\":{\"towerFloor\":1},\"SoulMemoryChapterPOD\":{\"cid\":1,\"isExperience\":4,\"isGetReward\":3,\"isNew\":5,\"unlockPieceCids\":2},\"SoulNewStoryPOD\":{\"cid\":1,\"isAllComplete\":3,\"unlockChapters\":2},\"SoulOathPOD\":{\"activation\":1,\"countData\":3,\"dateData\":2},\"SoulPOD\":{\"activationSkillStrengthen\":13,\"cid\":1,\"dailyDislike\":11,\"dress2DCid\":6,\"dress3DCid\":7,\"exp\":3,\"favor\":8,\"favorLv\":9,\"favorMaxLv\":10,\"jewelry\":22,\"lv\":2,\"mood\":15,\"moodTimeInterval\":16,\"oathActivation\":21,\"qualityId\":4,\"soulAttr\":18,\"soulMemoryPieces\":17,\"specialSpirit\":20,\"talentCids\":5,\"talentGroupCids\":14,\"unlockSkillGroups\":12,\"workStatus\":19},\"SoulPrefabPOD\":{\"attr\":5,\"customSkills\":7,\"equipments\":6,\"id\":1,\"jewelrySpeeds\":11,\"name\":2,\"newJewelrySpeeds\":12,\"optionalSkill\":10,\"position\":9,\"power\":4,\"skillGroupId\":8,\"soulCid\":3},\"SpaceTreasureDataPOD\":{\"getTickets\":2,\"totalEnergy\":1},\"SummerAdventureDataPOD\":{\"exchangedCount\":1},\"SurvivalInfoPOD\":{\"boss\":3,\"controlCid\":1,\"currPass\":6,\"dialogIDSequence\":5,\"level\":2,\"survivalPassStatusPODMap\":4},\"SurvivalPOD\":{\"dialogId\":3,\"level\":1,\"pass\":2},\"SurvivalPassStatusPOD\":{\"award\":2,\"id\":1},\"TaleChallengeDataPOD\":{\"dialogId\":3,\"passedNode\":1,\"taleChallengeRewardPoolData\":5,\"unlockedBoss\":2,\"unlockedDifficulty\":4},\"TaleChallengeRewardPoolPOD\":{\"drawCount\":2,\"id\":1},\"TowerPOD\":{\"nowLayer\":1},\"TownPOD\":{\"areas\":3,\"currentEventId\":1,\"executableEvents\":2,\"shoppingEventIds\":4},\"TreasureHuntDataPOD\":{\"exchangeGiftRecords\":1},\"TurntableDataPOD\":{\"dailyFreeDrawCount\":1},\"VoteDataPOD\":{\"myVotes\":1},\"WorkRewardResultPOD\":{\"affairId\":1,\"itemAward\":2,\"superSuc\":3},\"WorkersWhoPOD\":{\"attr\":2,\"cid\":1},\"WorldBossPOD\":{\"bossCid\":1,\"buffOrder\":3,\"typeLevel\":2}}"
namePodTypes = "{\"AbyssPlusPOD\":{\"levelScore\":\"map<int|int>\",\"runes\":\"list<int>\",\"usedRunes\":\"list<int>\"},\"ActiveTurntableRecordPOD\":{\"goods\":\"map<int|int>\",\"pid\":\"string\",\"pname\":\"string\",\"rare\":\"int\",\"time\":\"long\"},\"AffairEventPOD\":{\"cid\":\"int\",\"soulCid\":\"int\",\"time\":\"int\"},\"AffairPOD\":{\"cid\":\"int\",\"events\":\"list<AffairEventPOD>\",\"finishTime\":\"int\",\"id\":\"int\",\"soulCids\":\"list<int>\",\"status\":\"int\"},\"AlienRewardStatusPOD\":{\"cid\":\"int\",\"status\":\"map<int|bool>\"},\"AmusementParkAttPOD\":{\"attr\":\"map<int|int>\",\"level\":\"int\",\"number\":\"int\"},\"AmusementParkEventPOD\":{\"achievement\":\"bool\",\"date\":\"long\",\"eventCfgId\":\"int\",\"status\":\"bool\",\"value\":\"int\"},\"AmusementParkGamePOD\":{\"answer\":\"list<int>\",\"dLevel\":\"int\",\"dollMachine\":\"int\",\"oneStrokeId\":\"int\",\"pLevel\":\"int\",\"pixelBird\":\"int\",\"sLevel\":\"int\",\"stacking\":\"int\"},\"AmusementParkGameShowInfoPOD\":{\"level\":\"int\",\"score\":\"long\"},\"AmusementParkInfoPOD\":{\"amusementParkAttPOD\":\"AmusementParkAttPOD\",\"amusementParkVoRoles\":\"list<AmusementParkVoRolePOD>\",\"amusementParkVoRolesHave\":\"list<AmusementParkVoRolePOD>\",\"boss\":\"map<int|int>\",\"dialogId\":\"int\",\"plot\":\"list<int>\",\"postList\":\"list<int>\",\"unitList\":\"list<AmusementParkLandPOD>\"},\"AmusementParkLandPOD\":{\"doll\":\"list<int>\",\"level\":\"int\",\"post\":\"int\",\"property\":\"map<int|int>\",\"roleAdd\":\"map<int|int>\",\"unitID\":\"int\"},\"AmusementParkPOD\":{\"event\":\"list<AmusementParkEventPOD>\",\"exBossIsLock\":\"bool\",\"numberOfReturns\":\"int\"},\"AmusementParkVoCachePOD\":{\"post\":\"int\",\"unit\":\"int\"},\"AmusementParkVoInfoPOD\":{\"addItem\":\"map<int|int>\",\"amusementParkLandPODList\":\"list<AmusementParkLandPOD>\",\"amusementParkVoRoles\":\"list<AmusementParkVoRolePOD>\",\"amusementParkVoRolesHave\":\"list<AmusementParkVoRolePOD>\",\"completedTask\":\"list<int>\",\"controlCid\":\"int\",\"dialogIDSequence\":\"list<int>\",\"events\":\"list<AmusementParkEventPOD>\",\"finishedPlot\":\"list<int>\",\"lastAttackExBossHurt\":\"long\",\"lastRefreshTime\":\"long\",\"lastRefreshTimeOfEvent\":\"long\",\"lastRefreshTimeOfPerformance\":\"long\",\"monster\":\"map<int|int>\",\"postList\":\"list<int>\",\"rankNumber\":\"long\",\"roleLevelUpNumber\":\"int\",\"unclaimedAwardNumber\":\"int\",\"unclaimedAwardNumberForPerformance\":\"int\"},\"AmusementParkVoRolePOD\":{\"attr\":\"map<int|int>\",\"id\":\"int\",\"level\":\"int\",\"status\":\"bool\"},\"AreaPOD\":{\"cid\":\"int\",\"isLock\":\"bool\",\"isNew\":\"bool\"},\"BasicHomeInfoPOD\":{\"alreadyReward\":\"list\",\"currentComfort\":\"int\",\"id\":\"long\",\"maxComfort\":\"int\",\"pname\":\"string\"},\"BattlePassesPOD\":{\"advanced\":\"bool\",\"bpExp\":\"int\",\"bpLv\":\"int\",\"lastSeasonLv\":\"int\",\"rewardsGetList\":\"list<int>\"},\"BuildingPOD\":{\"cid\":\"int\",\"helpLogs\":\"list<HelpLogPOD>\",\"id\":\"long\",\"kitchenPOD\":\"KitchenPOD\",\"lands\":\"list<LandPOD>\",\"lv\":\"int\",\"manufacture\":\"ManufacturePOD\",\"officePOD\":\"OfficePOD\",\"productionData\":\"ProductionPOD\"},\"CChatPOD\":{\"channel\":\"int\",\"content\":\"string\",\"target\":\"string\",\"type\":\"int\"},\"CenterCupMatchVoteDataPOD\":{\"finalTime\":\"int\",\"finishTime\":\"int\",\"group\":\"map<int|int>\",\"knockoutTime\":\"int\",\"lastVoteTime\":\"map<int|int>\",\"stage\":\"int\",\"votes\":\"map<int|int>\"},\"CenterEvilErosionPOD\":{\"levelRatingTime\":\"map<int|int>\"},\"CenterGuildChallengePOD\":{\"bossType\":\"int\",\"buffOrder\":\"int\"},\"CenterGuildTrainingPOD\":{\"id\":\"int\"},\"CenterGuildTrainingPlayerRankPOD\":{\"createTime\":\"long\",\"name\":\"string\",\"pid\":\"string\",\"score\":\"int\"},\"CenterLoadPlayerPOD\":{\"chatRoom\":\"ChatRoomPOD\",\"eoDataPOD\":\"LoadOperationEventDataPOD\",\"friends\":\"list<FriendPOD>\",\"guildChatCaches\":\"list<SChatPOD>\",\"guildId\":\"int\",\"guildName\":\"string\",\"simplePlayerPOD\":\"SimplePlayerPOD\"},\"CenterLunaBattleLineDataPOD\":{\"participation\":\"long\",\"zoneSealPercentage\":\"map<int|int>\"},\"CenterServerDiscreteDataPOD\":{\"mallRandomGroup\":\"map<int|int>\"},\"CenterVoteDataPOD\":{\"votes\":\"map<int|int>\"},\"CenterWorldBossPOD\":{\"bossType\":\"int\",\"buffOrder\":\"int\"},\"ChallengePOD\":{\"difficult\":\"list<int>\"},\"ChatRoomPOD\":{\"msg\":\"list<SChatPOD>\",\"onlineCount\":\"int\",\"roomNumber\":\"int\"},\"CulinaryPOD\":{\"cid\":\"int\",\"costs\":\"list<int>\",\"finishTime\":\"int\",\"id\":\"int\",\"idx\":\"int\",\"num\":\"int\",\"receiveNum\":\"int\",\"singleCookTime\":\"int\",\"startTime\":\"int\",\"status\":\"int\"},\"CupMatchVoteDataPOD\":{\"myVotes\":\"map<int|int>\",\"tickets\":\"int\"},\"DailyDupCommonPOD\":{\"centerEvilErosionPOD\":\"CenterEvilErosionPOD\",\"centerGuildChallengePOD\":\"CenterGuildChallengePOD\",\"centerGuildTrainingPOD\":\"CenterGuildTrainingPOD\",\"centerLunaBattleLineDataPOD\":\"CenterLunaBattleLineDataPOD\",\"centerWorldBoss\":\"CenterWorldBossPOD\",\"cid\":\"int\",\"openCount\":\"int\",\"openDate\":\"int\",\"status\":\"int\"},\"DailyDupPOD\":{\"abyssPlusPOD\":\"AbyssPlusPOD\",\"amusementParkPOD\":\"AmusementParkPOD\",\"battlePassesPOD\":\"BattlePassesPOD\",\"buyCount\":\"int\",\"challengeDataPOD\":\"TaleChallengeDataPOD\",\"challengePOD\":\"ChallengePOD\",\"common\":\"DailyDupCommonPOD\",\"dreamMapPOD\":\"DreamMapPOD\",\"dualTeamExplorePOD\":\"DualTeamExplorePOD\",\"enterCount\":\"int\",\"evilErosionPOD\":\"EvilErosionPOD\",\"fishingActivityPOD\":\"FishingActivityPOD\",\"flightChallengePOD\":\"FlightChallengePOD\",\"guildChallengePOD\":\"GuildChallengePOD\",\"guildTrainingPOD\":\"GuildTrainingPOD\",\"horizontalRPGPOD\":\"HorizontalRPGPOD\",\"lunaBattleLineDataPOD\":\"LunaBattleLineDataPOD\",\"magicTowerPOD\":\"MagicTowerPOD\",\"miniGalGameDataPOD\":\"MiniGalGameDataPOD\",\"miningPOD\":\"MiningPOD\",\"placeGamePOD\":\"PlaceGamePOD\",\"restaurantOperationPOD\":\"RestaurantOperationPOD\",\"rpgMazePOD\":\"RPGMazePOD\",\"singleWeakTower\":\"SingleWeakTowerPOD\",\"survivalPOD\":\"SurvivalPOD\",\"towerPOD\":\"TowerPOD\",\"worldBossPOD\":\"WorldBossPOD\"},\"DailyResetPOD\":{\"dailySupplyList\":\"list<int>\",\"dailyWorkCount\":\"int\",\"exchangeRecords\":\"map<int|int>\",\"guildQuestGetRecord\":\"list<int>\",\"isGuildSign\":\"bool\",\"lotteryCnts\":\"map<int|int>\",\"remainderGiveGiftNum\":\"int\"},\"DecoratePOD\":{\"cid\":\"int\",\"x\":\"int\",\"y\":\"int\"},\"DollPOD\":{\"dress2DCid\":\"int\",\"dress3DCid\":\"int\",\"equipments\":\"map<int|EquipmentPOD>\",\"exp\":\"int\",\"formationPos\":\"int\",\"hp\":\"int\",\"initSkills\":\"list<int>\",\"jewelry\":\"map<int|int>\",\"lv\":\"int\",\"mazeRecord\":\"map<int|int>\",\"mood\":\"int\",\"newJewelryDollPOD\":\"NewJewelryDollPOD\",\"pAblityIds\":\"list<int>\",\"position\":\"int\",\"power\":\"int\",\"skillGroupId\":\"int\",\"skillStrengthens\":\"list<int>\",\"soulCid\":\"int\",\"soulMarryCid\":\"int\",\"soulMemoryPieces\":\"list<int>\",\"soulQualityCid\":\"int\",\"specialSpirit\":\"list<int>\",\"talentCids\":\"list<int>\",\"talentGroupCids\":\"list<int>\",\"unlockSkillGroups\":\"list<int>\"},\"DoubleFightDataPOD\":{\"doubleFightSteps\":\"list<DoubleFightStepPOD>\"},\"DoubleFightRecordPOD\":{\"formationInfoPOD\":\"FormationInfoPOD\",\"hurtPercentage\":\"int\",\"hurtScore\":\"int\",\"index\":\"int\",\"isWin\":\"bool\",\"round\":\"int\",\"roundScore\":\"int\"},\"DoubleFightStepPOD\":{\"getAwardsIndex\":\"list<int>\",\"maxScore\":\"int\",\"records\":\"list<DoubleFightRecordPOD>\",\"score\":\"int\",\"step\":\"int\"},\"DreamMapCellPOD\":{\"dataId\":\"int\",\"elementId\":\"int\",\"isOpen\":\"bool\",\"markType\":\"int\",\"showType\":\"bool\",\"x\":\"int\",\"y\":\"int\"},\"DreamMapDataPOD\":{\"cells\":\"list<DreamMapCellPOD>\",\"combo\":\"int\",\"currDialog\":\"int\",\"mapId\":\"int\",\"movePoint\":\"int\",\"resetCount\":\"int\",\"roleX\":\"int\",\"roleY\":\"int\"},\"DreamMapExectionItemPOD\":{\"exectionId\":\"int\",\"getItems\":\"list<ItemShowPOD>\",\"getMovePoint\":\"int\",\"getSpAwardId\":\"int\"},\"DreamMapPOD\":{\"spRewardsCount\":\"map<int|int>\",\"unlockMaps\":\"list<int>\"},\"DressPOD\":{\"dressCid\":\"int\",\"expireTime\":\"int\",\"isNew\":\"bool\"},\"DualTeamExploreLevelPOD\":{\"currDialog\":\"int\",\"currFightMonsterTeamId\":\"int\",\"currMazeCid\":\"int\",\"currNumberInputId\":\"int\",\"currTeam\":\"int\",\"currTransportNodeId\":\"int\",\"easyMode\":\"bool\",\"levelCid\":\"int\",\"nodes\":\"list<DualTeamExploreNodePOD>\",\"separate\":\"bool\",\"team1\":\"DualTeamExploreTeamPOD\",\"team2\":\"DualTeamExploreTeamPOD\"},\"DualTeamExploreNodePOD\":{\"capacity\":\"int\",\"cid\":\"int\",\"id\":\"int\",\"nextNodes\":\"list<int>\",\"occupierTeamId\":\"int\"},\"DualTeamExplorePOD\":{\"controlCid\":\"int\",\"currLevelCid\":\"int\",\"exBossFormationInfo1\":\"FormationInfoPOD\",\"exBossFormationInfo2\":\"FormationInfoPOD\",\"exBossOpen\":\"bool\",\"exBossScore1\":\"int\",\"exBossScore2\":\"int\",\"finishEasyLevels\":\"list<int>\",\"finishLevels\":\"list<int>\",\"freeChallengeBossCount\":\"int\",\"killedBoss\":\"list<int>\",\"lastAttackExBossTime1\":\"int\",\"lastAttackExBossTime2\":\"int\",\"tickets\":\"int\",\"unlockBoss\":\"list<int>\"},\"DualTeamExploreTeamPOD\":{\"currNodeId\":\"int\",\"dead\":\"bool\",\"formationInfo\":\"FormationInfoPOD\",\"stop\":\"bool\"},\"DynamicTaskPOD\":{\"checkType\":\"int\",\"commitStatus\":\"list<int>\",\"content\":\"string\",\"desc\":\"string\",\"endTime\":\"int\",\"finNum\":\"list<int>\",\"icon\":\"string\",\"id\":\"string\",\"isNew\":\"int\",\"isPop\":\"int\",\"mTitle\":\"string\",\"prize_cid\":\"list<int>\",\"prize_num\":\"list<int>\",\"sortNum\":\"int\",\"startTime\":\"int\",\"tgtNum\":\"list<int>\",\"tgtParams\":\"list<int>\",\"tgt_str\":\"list<string>\",\"title\":\"string\",\"type\":\"int\"},\"EnterMazeSoulPrefabPOD\":{\"postion\":\"int\",\"soulPrefabId\":\"long\"},\"EquipmentPOD\":{\"cid\":\"int\",\"exp\":\"int\",\"lock\":\"bool\",\"lv\":\"int\",\"star\":\"int\"},\"EquipmentPrefabPOD\":{\"equipmentMap\":\"map<int|long>\",\"id\":\"long\",\"idx\":\"int\",\"name\":\"string\",\"soulCid\":\"int\"},\"EvilErosionPOD\":{\"currLevel\":\"int\",\"getDailySupplys\":\"list<int>\",\"rating\":\"map<int|int>\",\"soulPrefabs\":\"list<EvilErosionSoulPrefabPOD>\"},\"EvilErosionSoulPrefabPOD\":{\"allSkillStrengths\":\"list<int>\",\"allSkills\":\"list<int>\",\"attr\":\"list<double>\",\"customSkills\":\"list<int>\",\"dress2DCid\":\"int\",\"dress3DCid\":\"int\",\"equipments\":\"map<int|long>\",\"formationPos\":\"int\",\"id\":\"long\",\"lv\":\"int\",\"position\":\"int\",\"power\":\"int\",\"qualityId\":\"int\",\"soulCid\":\"int\"},\"FightPOD\":{\"Attacker\":\"FightTroopPOD\",\"BattleParams\":\"map<int|int>\",\"BattleType\":\"int\",\"Defender\":\"FightTroopPOD\",\"ID\":\"string\",\"MapID\":\"int\",\"MaxRound\":\"int\",\"MonsterTeamID\":\"int\",\"Players\":\"list<string>\",\"RandomSeed\":\"long\"},\"FightTroopPOD\":{\"ArrFightUnitPOD\":\"list<FightUnitPOD>\",\"Buffs\":\"list<int>\"},\"FightUnitPOD\":{\"Attributes\":\"list<double>\",\"BattlePos\":\"int\",\"InitBuff\":\"list<int>\",\"IsHelper\":\"bool\",\"Level\":\"int\",\"MonsterCfgId\":\"int\",\"Pid\":\"string\",\"Power\":\"int\",\"SPStatus\":\"list<bool>\",\"SkillStrengthens\":\"list<int>\",\"Skills\":\"list<int>\",\"TroopType\":\"int\"},\"FishingActivityItemPOD\":{\"fishId\":\"int\",\"num\":\"int\",\"weight\":\"int\"},\"FishingActivityPOD\":{\"actionLevel\":\"map<int|int>\",\"autoFishingRewardsTime\":\"int\",\"book\":\"map<int|FishingActivityItemPOD>\",\"getStoryList\":\"list<int>\",\"maxWeight\":\"map<int|int>\",\"roleLevel\":\"int\",\"skillLevel\":\"map<int|int>\",\"totalWeight\":\"int\"},\"FishingDataPOD\":{\"baitId\":\"int\",\"countdown\":\"long\",\"fishId\":\"int\",\"rodId\":\"int\",\"specimenData\":\"map<int|int>\",\"state\":\"bool\"},\"FlightChallengeMechaPOD\":{\"firingSpeed\":\"float\",\"growthAttribute\":\"map<int|float>\",\"id\":\"int\"},\"FlightChallengePOD\":{\"flightChallengeMechas\":\"list<FlightChallengeMechaPOD>\",\"record\":\"int\"},\"FormationEquipPOD\":{\"cid\":\"int\",\"lv\":\"int\",\"star\":\"int\"},\"FormationInfoPOD\":{\"index\":\"int\",\"name\":\"string\",\"soulPrefabs\":\"map<int|FormationSoulPrefabPOD>\",\"userData\":\"string\"},\"FormationJewelryPOD\":{\"cid\":\"int\",\"speed\":\"int\",\"star\":\"int\"},\"FormationPOD\":{\"formation\":\"map<long|int>\",\"id\":\"long\",\"index\":\"int\",\"name\":\"string\"},\"FormationSoulPrefabPOD\":{\"activeTalentCids\":\"list<int>\",\"activeTalentGroupCids\":\"list<int>\",\"allSkillStrengths\":\"list<int>\",\"allSkills\":\"list<int>\",\"attr\":\"list<double>\",\"customSkills\":\"list<int>\",\"dress2DCid\":\"int\",\"dress3DCid\":\"int\",\"equipments\":\"map<int|FormationEquipPOD>\",\"exp\":\"int\",\"favorLv\":\"int\",\"id\":\"long\",\"jewelryPOD\":\"FormationJewelryPOD\",\"lv\":\"int\",\"mood\":\"int\",\"optionalSkill\":\"int\",\"pAblityIds\":\"list<int>\",\"position\":\"int\",\"power\":\"int\",\"qualityId\":\"int\",\"skillGroupId\":\"int\",\"soulCid\":\"int\",\"soulMarryCid\":\"int\",\"soulMemoryPieces\":\"list<int>\",\"specialSpirit\":\"list<int>\",\"unlockSkillGroups\":\"list<int>\"},\"FriendPOD\":{\"avatarFrame\":\"int\",\"createTime\":\"int\",\"guid\":\"int\",\"headIcon\":\"int\",\"id\":\"long\",\"lastLoginTime\":\"int\",\"online\":\"bool\",\"pId\":\"string\",\"pLv\":\"int\",\"pName\":\"string\",\"remark\":\"string\",\"serverId\":\"string\",\"title\":\"int\",\"type\":\"int\",\"vip\":\"int\"},\"FurnitureGachaDataPOD\":{\"gachaCount\":\"int\",\"gachaIdList\":\"list<int>\"},\"GachaPoolDataPOD\":{\"getAwards\":\"list<int>\",\"isRefresh\":\"bool\"},\"GirlPOD\":{\"activation\":\"bool\",\"datingRecord\":\"map<int|int>\",\"soulCid\":\"int\"},\"GlobalBuffPOD\":{\"cid\":\"int\",\"endTime\":\"int\"},\"GmMailPOD\":{\"channelIds\":\"string\",\"content\":\"string\",\"createTime\":\"long\",\"endTime\":\"long\",\"id\":\"int\",\"isAllPlayer\":\"bool\",\"isAllTime\":\"bool\",\"itemList\":\"list<int>\",\"levelLimit\":\"int\",\"payPoint\":\"int\",\"sender\":\"string\",\"target\":\"list<string>\",\"title\":\"string\"},\"GroupPurchaseCommonDataPOD\":{\"totalCount\":\"map<int|int>\"},\"GroupPurchaseDataPOD\":{\"buyCount\":\"map<int|int>\"},\"GroupPurchaseRewardPOD\":{\"payPoint\":\"int\",\"rewardData\":\"list<int>\"},\"GuildAuditPOD\":{\"lastLoginTime\":\"int\",\"online\":\"bool\",\"player\":\"PlayerSimplePOD\"},\"GuildBasePOD\":{\"auditType\":\"int\",\"avatarFrame\":\"int\",\"headIcon\":\"int\",\"id\":\"int\",\"leaderName\":\"string\",\"level\":\"int\",\"memberMaxNum\":\"int\",\"memberNum\":\"int\",\"name\":\"string\",\"policy\":\"int\"},\"GuildBuildingPOD\":{\"buyEffectExpTime\":\"int\",\"cid\":\"int\",\"lv\":\"int\"},\"GuildChallengePOD\":{\"currBossLevel\":\"int\",\"getRewards\":\"list<int>\"},\"GuildMemberPOD\":{\"activeNum\":\"int\",\"joinTime\":\"int\",\"lastLoginTime\":\"int\",\"online\":\"bool\",\"player\":\"PlayerSimplePOD\",\"position\":\"int\"},\"GuildPOD\":{\"banNotice\":\"bool\",\"base\":\"GuildBasePOD\",\"buildings\":\"list<GuildBuildingPOD>\",\"fund\":\"int\",\"fundDailyGetRecord\":\"int\",\"impeachmentTime\":\"int\",\"members\":\"list<GuildMemberPOD>\",\"newAuditCount\":\"int\",\"notice\":\"string\",\"questProgress\":\"map<int|int>\"},\"GuildTrainingBossScorePOD\":{\"pids\":\"list<string>\",\"score\":\"int\"},\"GuildTrainingPOD\":{\"getAward\":\"list<int>\",\"guildIntegral\":\"int\",\"maxIntegral\":\"int\"},\"HelpLogPOD\":{\"createTime\":\"int\",\"entryCid\":\"int\",\"entryVal\":\"int\",\"name\":\"string\",\"pid\":\"string\",\"target\":\"list<int>\"},\"HelpNewbiesDataPOD\":{\"rookie\":\"HelpNewbiesRookieDataPOD\",\"senior\":\"HelpNewbiesSeniorDataPOD\",\"type\":\"int\"},\"HelpNewbiesFollowerDataPOD\":{\"lastMazeId\":\"int\",\"pod\":\"PlayerSimplePOD\"},\"HelpNewbiesRookieDataPOD\":{\"name\":\"string\",\"reachedLevel\":\"bool\",\"useCode\":\"bool\",\"usedInviteCode\":\"int\"},\"HelpNewbiesSeniorDataPOD\":{\"eventTask\":\"map<int|int>\",\"finishedTask\":\"list<int>\",\"inviteCode\":\"int\"},\"HomePOD\":{\"activationDecorates\":\"list<int>\",\"baseInfo\":\"BasicHomeInfoPOD\",\"buildings\":\"list<BuildingPOD>\",\"roles\":\"list<HomeRolePOD>\",\"rooms\":\"list<RoomPOD>\",\"todayActions\":\"list<int>\",\"triggerDialogs\":\"list<int>\",\"unlockAIActions\":\"list<int>\",\"unlockCookBook\":\"list<int>\",\"unlockManufactureItem\":\"list<int>\",\"unlockSuit\":\"list<int>\",\"visitTreasureChest\":\"map<int|int>\"},\"HomeRolePOD\":{\"belongRoom\":\"int\",\"dress2DCid\":\"int\",\"dress3DCid\":\"int\",\"favorLv\":\"int\",\"letters\":\"list<int>\",\"newStoryId\":\"int\",\"roleCid\":\"int\",\"transactionCid\":\"int\"},\"HorizontalRPGElementPOD\":{\"effect\":\"int\",\"id\":\"int\"},\"HorizontalRPGInfoPOD\":{\"boss\":\"list<int>\",\"currLevel\":\"int\",\"dialogIDSequence\":\"list<int>\",\"dolls\":\"list<DollPOD>\",\"exBoss\":\"bool\",\"formationId\":\"long\",\"freeChallengeBossCount\":\"int\",\"horizontalRPGMapPODs\":\"map<int|HorizontalRPGMapPOD>\",\"invincibleTime\":\"long\",\"killBoss\":\"list<int>\",\"lastAttackExBossHurt\":\"long\",\"levelDialogIDSequence\":\"list<int>\",\"map\":\"int\",\"maxOrderMap\":\"map<int|int>\",\"onlyOne\":\"list<int>\",\"passedRecord\":\"map<int|int>\",\"star\":\"int\",\"starUpperLimit\":\"int\",\"task\":\"list<int>\",\"taskTips\":\"list<int>\",\"tickets\":\"int\",\"unlockedDifficulty\":\"list<int>\",\"weather\":\"int\"},\"HorizontalRPGMapPOD\":{\"born\":\"int\",\"currLevelCid\":\"int\",\"element\":\"list<HorizontalRPGElementPOD>\",\"id\":\"int\",\"region\":\"int\"},\"HorizontalRPGPOD\":{\"boss\":\"list<int>\",\"dialog\":\"int\",\"dolls\":\"list<DollPOD>\",\"exBoss\":\"bool\",\"finnishLevels\":\"list<int>\",\"freeChallengeBossCount\":\"int\",\"horizontalRPGMapPODs\":\"HorizontalRPGMapPOD\",\"killBoss\":\"list<int>\",\"levelDialog\":\"int\",\"star\":\"int\",\"starUpperLimit\":\"int\",\"task\":\"list<int>\",\"taskTips\":\"list<int>\",\"tickets\":\"int\",\"unlockedDifficulty\":\"list<int>\",\"weather\":\"int\"},\"HorizontalRPGResPOD\":{\"elementId\":\"int\",\"id\":\"int\",\"info\":\"string\",\"type\":\"int\"},\"ImagePuzzleEventPOD\":{\"gotRewards\":\"list<int>\",\"rewards\":\"list<int>\",\"unlockedPlace\":\"list<int>\",\"unlockedRewardsIdx\":\"int\"},\"ItemEquipmentPOD\":{\"exp\":\"int\",\"lock\":\"bool\",\"lv\":\"int\",\"soulPrefabIds\":\"map<long|int>\",\"star\":\"int\",\"upCostGold\":\"int\"},\"ItemPOD\":{\"cid\":\"int\",\"createTime\":\"int\",\"equipmentData\":\"ItemEquipmentPOD\",\"id\":\"long\",\"newJewelryEquipmentVoPOD\":\"NewJewelryEquipmentVoPOD\",\"num\":\"int\",\"placeGameEquipPOD\":\"PlaceGameEquipPOD\",\"usedNum\":\"int\"},\"ItemShowPOD\":{\"cid\":\"int\",\"num\":\"int\",\"tag\":\"int\"},\"ItemUseRecordPOD\":{\"itemCid\":\"int\",\"useTime\":\"int\"},\"KitchenPOD\":{\"culinarys\":\"list<CulinaryPOD>\",\"maxQueueCount\":\"int\"},\"LandPOD\":{\"cid\":\"int\",\"currentSeedCid\":\"int\",\"finishTime\":\"int\",\"status\":\"int\"},\"LibraryAreaPOD\":{\"entrys\":\"list<int>\",\"rewards\":\"map<int|bool>\"},\"LibraryMonsterPOD\":{\"count\":\"int\",\"rewards\":\"map<int|bool>\"},\"LibraryNpcPOD\":{\"entrys\":\"list<int>\",\"rewards\":\"map<int|bool>\"},\"LibraryPOD\":{\"alienEvent\":\"map<int|bool>\",\"alienRewards\":\"map<int|AlienRewardStatusPOD>\",\"area\":\"map<int|LibraryAreaPOD>\",\"equipStar\":\"map<int|int>\",\"getNewsBook\":\"list<int>\",\"monster\":\"map<int|LibraryMonsterPOD>\",\"newsBook\":\"map<int|bool>\",\"npc\":\"map<int|LibraryNpcPOD>\",\"rumorPlate\":\"map<int|bool>\",\"souls\":\"list<LibrarySoulPOD>\",\"townStory\":\"map<int|bool>\",\"townStoryCG\":\"map<int|bool>\"},\"LibrarySoulPOD\":{\"datings\":\"list<int>\",\"newStroys\":\"list<int>\",\"soulCid\":\"int\",\"unlockPlate\":\"map<int|bool>\"},\"LimitTurnTableDataPOD\":{\"getAwards\":\"map<int|int>\",\"insureTimes\":\"int\"},\"LimitTurnTableHistoryPOD\":{\"rewardId\":\"int\",\"time\":\"int\"},\"LoadOperationEventDataPOD\":{\"newbiesMapDataPOD\":\"map<int|HelpNewbiesDataPOD>\"},\"LotteryHistoryPOD\":{\"itemCid\":\"int\",\"itemNum\":\"int\",\"lotteryCid\":\"int\",\"time\":\"int\"},\"LotteryShowPOD\":{\"drawCount\":\"int\",\"leftHiddenInsureTime\":\"int\",\"leftInsureTime\":\"int\",\"showCid\":\"int\"},\"LuckDrawHistoryPOD\":{\"itemCid\":\"int\",\"itemNum\":\"int\",\"time\":\"int\"},\"LunaBattleLineAssistUnitPOD\":{\"player\":\"PlayerSimplePOD\",\"soulPrefab\":\"FormationSoulPrefabPOD\"},\"LunaBattleLineDataPOD\":{\"participation\":\"int\",\"zones\":\"map<int|LunaBattleLineZonePOD>\"},\"LunaBattleLineZonePOD\":{\"garrison\":\"FormationSoulPrefabPOD\",\"zoneId\":\"int\"},\"MagicMuseumDataPOD\":{\"bossFightCount\":\"map<int|int>\",\"bossRewardsCount\":\"map<int|int>\",\"curRound\":\"int\"},\"MagicTowerMapCellPOD\":{\"dataId\":\"int\",\"floor\":\"int\",\"id\":\"int\",\"x\":\"int\",\"y\":\"int\"},\"MagicTowerMapDataPOD\":{\"cells\":\"list<MagicTowerMapCellPOD>\",\"currDialog\":\"int\",\"mapId\":\"int\",\"role\":\"MagicTowerRolePOD\"},\"MagicTowerMapExecutionItemPOD\":{\"executionType\":\"int\",\"getItems\":\"list<ItemShowPOD>\",\"params\":\"list<string>\",\"role\":\"MagicTowerRolePOD\"},\"MagicTowerPOD\":{\"currMapId\":\"int\"},\"MagicTowerRolePOD\":{\"atk\":\"int\",\"cellId\":\"int\",\"def\":\"int\",\"equipments\":\"list<int>\",\"hp\":\"int\",\"key1\":\"int\",\"key2\":\"int\",\"key3\":\"int\"},\"MailPOD\":{\"cid\":\"int\",\"content\":\"string\",\"createTime\":\"int\",\"expireTime\":\"int\",\"id\":\"long\",\"isHasItem\":\"bool\",\"isRead\":\"bool\",\"itemList\":\"list<ItemShowPOD>\",\"sender\":\"string\",\"title\":\"string\"},\"MakePOD\":{\"cid\":\"int\",\"costs\":\"list<int>\",\"finishTime\":\"int\",\"id\":\"int\",\"status\":\"int\"},\"ManufacturePOD\":{\"makes\":\"list<MakePOD>\",\"maxQueueCount\":\"int\"},\"MazeInfoPOD\":{\"buyCount\":\"int\",\"cid\":\"int\",\"enterCount\":\"int\",\"score\":\"int\",\"star\":\"int\",\"starConditions\":\"list<bool>\",\"winCount\":\"int\"},\"MazeMopUpPOD\":{\"addSoulExps\":\"map<int|int>\",\"money\":\"int\",\"playerExp\":\"int\",\"rewards\":\"list<ItemShowPOD>\"},\"MazePOD\":{\"carryItems\":\"list<ItemPOD>\",\"id\":\"long\",\"isLocal\":\"bool\",\"mazeCid\":\"int\",\"mazePlayer\":\"MazePlayerPOD\",\"randomSeed\":\"int\",\"saveData\":\"string\",\"saveVersion\":\"int\"},\"MazePlayerBaseInfoPOD\":{\"avatarFrame\":\"int\",\"exp\":\"int\",\"headIcon\":\"int\",\"leaderCid\":\"int\",\"pLv\":\"int\",\"pName\":\"string\",\"pid\":\"string\",\"serverId\":\"string\",\"vip\":\"int\",\"vipexp\":\"int\"},\"MazePlayerPOD\":{\"alienEvents\":\"list<int>\",\"baseInfo\":\"MazePlayerBaseInfoPOD\",\"completePathNodes\":\"list<int>\",\"dolls\":\"list<DollPOD>\",\"finishMazes\":\"list<int>\",\"finishQuests\":\"list<int>\",\"first\":\"bool\",\"fishSpecimens\":\"list<int>\",\"itemDropGetCnts\":\"map<int|int>\",\"mainQuests\":\"map<int|int>\",\"openPathNodes\":\"list<int>\",\"playerParams\":\"map<int|int>\",\"records\":\"string\",\"unlockMonsters\":\"list<int>\",\"unlockRunes\":\"list<int>\",\"unlockSouls\":\"list<int>\",\"unlockedEvents\":\"list<int>\"},\"MazeSettlementPOD\":{\"completeNodeCount\":\"int\",\"completePathNodes\":\"list<int>\",\"deadCount\":\"int\",\"dolls\":\"list<DollPOD>\",\"duration\":\"int\",\"fightWinCount\":\"int\",\"getItems\":\"list<ItemPOD>\",\"killBossCount\":\"int\",\"killMonsterRecord\":\"map<int|int>\",\"mazeData\":\"string\",\"mazeItemDropGetCnts\":\"map<int|int>\",\"openPathNodes\":\"list<int>\",\"otherData\":\"map<string|string>\",\"playerParams\":\"map<int|int>\",\"records\":\"string\",\"reviveCount\":\"int\",\"rewards\":\"list<int>\",\"saveVersion\":\"int\",\"score\":\"int\",\"starConditions\":\"list<bool>\",\"success\":\"bool\"},\"MazeSettlementResultPOD\":{\"addSoulExps\":\"map<int|int>\",\"firstRewards\":\"list<ItemShowPOD>\",\"money\":\"int\",\"playerExp\":\"int\",\"rewards\":\"list<ItemShowPOD>\",\"rewardsBoxes\":\"list<MazeSettlementRewardBoxPOD>\",\"score\":\"int\",\"starConditions\":\"list<bool>\",\"success\":\"bool\"},\"MazeSettlementRewardBoxPOD\":{\"cid\":\"int\",\"items\":\"list<ItemShowPOD>\",\"num\":\"int\"},\"MiniGalGameBasePOD\":{\"areaList\":\"list<int>\",\"baseProps\":\"map<int|int>\",\"day\":\"int\",\"dayOfPhase\":\"int\"},\"MiniGalGameCountPOD\":{\"countId\":\"int\",\"recordCountOfDay\":\"int\",\"recordCountOfMonth\":\"int\",\"recordCountOfTotal\":\"int\",\"recordCountOfWeek\":\"int\",\"recordCountOfYear\":\"int\"},\"MiniGalGameDataPOD\":{\"achievementData\":\"map<int|int>\",\"saveList\":\"list<MiniGalGameSavaDataPOD>\"},\"MiniGalGameGirlDataPOD\":{\"callCount\":\"int\",\"favorAbility\":\"int\",\"girlId\":\"int\",\"messageGroups\":\"list<MiniGalGameMessageGroupPOD>\",\"noShow\":\"int\",\"phoneLock\":\"int\",\"rejectCount\":\"int\"},\"MiniGalGameItemPOD\":{\"itemId\":\"int\",\"itemNum\":\"int\"},\"MiniGalGameMessageGroupPOD\":{\"day\":\"int\",\"dayOfPhase\":\"int\",\"id\":\"int\",\"messageIds\":\"list<int>\"},\"MiniGalGameSavaDataDetailPOD\":{\"basePOD\":\"MiniGalGameBasePOD\",\"dialogId\":\"int\",\"girls\":\"list<MiniGalGameGirlDataPOD>\",\"itemUsedCount\":\"map<int|MiniGalGameCountPOD>\",\"items\":\"map<int|int>\",\"localAchievementData\":\"map<int|int>\",\"messageGroupCount\":\"map<int|MiniGalGameCountPOD>\",\"playthrough\":\"int\",\"scheduleList\":\"list<MiniGalGameSchedulePOD>\",\"shopRecord\":\"map<int|int>\",\"taskList\":\"list<int>\",\"towerRecord\":\"list<int>\",\"triggeredCount\":\"map<int|MiniGalGameCountPOD>\"},\"MiniGalGameSavaDataPOD\":{\"day\":\"int\",\"dayOfPhase\":\"int\",\"gameOver\":\"bool\",\"saveTime\":\"int\",\"slot\":\"int\"},\"MiniGalGameSchedulePOD\":{\"areaId\":\"int\",\"day\":\"int\",\"dayOfPhase\":\"int\",\"functionId\":\"int\",\"girlId\":\"int\",\"id\":\"int\",\"status\":\"int\"},\"MiningGridPOD\":{\"dataCid\":\"int\",\"id\":\"int\",\"skinId\":\"int\",\"state\":\"int\",\"x\":\"int\",\"y\":\"int\"},\"MiningLayerPOD\":{\"floor\":\"int\",\"grids\":\"map<int|MiningGridPOD>\"},\"MiningPOD\":{\"dialogId\":\"int\",\"floorMax\":\"int\",\"floorNow\":\"int\"},\"NewCharacterDataPOD\":{\"bingoNums\":\"list<int>\",\"bingoRewards\":\"list<int>\",\"finishStories\":\"list<int>\",\"remainCount\":\"int\",\"round\":\"int\",\"totalTicket\":\"int\"},\"NewCharacterRewardsLogPOD\":{\"id\":\"int\",\"idx\":\"int\",\"rewards\":\"list<ItemShowPOD>\",\"time\":\"int\",\"type\":\"int\"},\"NewJewelryDollPOD\":{\"cid\":\"int\",\"speed\":\"int\",\"star\":\"int\"},\"NewJewelryEquipmentVoPOD\":{\"soul\":\"list<long>\",\"star\":\"int\"},\"OfficePOD\":{\"affairs\":\"list<AffairPOD>\",\"freeRefreshTimes\":\"int\"},\"OperationEventDataPOD\":{\"advPOD\":\"SummerAdventureDataPOD\",\"cupMatchVoteDataPOD\":\"CupMatchVoteDataPOD\",\"dataCfgId\":\"int\",\"doubleFightDataPOD\":\"DoubleFightDataPOD\",\"eventCfgId\":\"int\",\"furnitureGachaDataPOD\":\"FurnitureGachaDataPOD\",\"gachaPoolData\":\"GachaPoolDataPOD\",\"gpData\":\"GroupPurchaseDataPOD\",\"helpNewbiesDataPOD\":\"HelpNewbiesDataPOD\",\"ipData\":\"ImagePuzzleEventPOD\",\"limitTurnTableDataPOD\":\"LimitTurnTableDataPOD\",\"mmData\":\"MagicMuseumDataPOD\",\"ncData\":\"NewCharacterDataPOD\",\"paidQuestDataPOD\":\"PaidQuestDataPOD\",\"pandaDataPOD\":\"PandaDataPOD\",\"spaceTreasureDataPOD\":\"SpaceTreasureDataPOD\",\"treasureHuntDataPOD\":\"TreasureHuntDataPOD\",\"turntableDataPOD\":\"TurntableDataPOD\",\"voteDataPOD\":\"VoteDataPOD\"},\"OperationEventPOD\":{\"closeTime\":\"int\",\"dataCfgId\":\"int\",\"endTime\":\"int\",\"eventCfgId\":\"int\",\"eventUid\":\"string\",\"extJsonData\":\"string\",\"startTime\":\"int\",\"status\":\"int\"},\"PLaceGameRankInfoPOD\":{\"pid\":\"string\",\"score\":\"int\"},\"PaidQuestDataPOD\":{\"paid\":\"bool\"},\"PandaDataPOD\":{\"exploreCount\":\"int\",\"favorNum\":\"int\",\"getGifts\":\"list<int>\",\"maxFavorNum\":\"int\"},\"PlaceGameEquipPOD\":{\"level\":\"int\",\"lock\":\"bool\",\"pAbilityIDEffect1\":\"list<int>\",\"pAbilityIDEffect2\":\"list<int>\",\"property\":\"list<PlaceGamePropertyPOD>\"},\"PlaceGameFormationPOD\":{\"formation\":\"map<long|int>\",\"id\":\"long\",\"index\":\"int\",\"name\":\"string\"},\"PlaceGameInfoPOD\":{\"controlCid\":\"int\",\"dialogIDSequence\":\"list<int>\",\"equipmentTreasureBox\":\"map<int|int>\",\"finishedPlot\":\"list<int>\",\"firingSoul\":\"map<int|PlaceGameSoulPOD>\",\"numberOfPlies\":\"int\",\"placeGameFormationPODS\":\"map<long|PlaceGameFormationPOD>\",\"soulPrefabs\":\"map<int|PlaceGameSoulPOD>\",\"time\":\"int\",\"timeDate\":\"long\",\"timeEquip\":\"int\",\"timeEquipDate\":\"long\",\"treasureBox\":\"map<int|int>\"},\"PlaceGamePOD\":{\"award\":\"int\",\"customs\":\"int\",\"dialogId\":\"int\",\"firingSoulPODs\":\"list<PlaceGameSoulPOD>\",\"placeGameFormationPODs\":\"list<PlaceGameFormationPOD>\",\"placeGameSoulPODs\":\"list<PlaceGameSoulPOD>\",\"placeGameSoulPrefabPODs\":\"list<PlaceGameSoulPrefabPOD>\",\"plot\":\"list<int>\"},\"PlaceGamePropertyPOD\":{\"id\":\"int\",\"value\":\"double\"},\"PlaceGameSoulPOD\":{\"cid\":\"int\",\"experience\":\"int\",\"level\":\"int\"},\"PlaceGameSoulPrefabInfoPOD\":{\"experience\":\"int\",\"id\":\"long\",\"level\":\"int\",\"location\":\"int\",\"soulCid\":\"int\",\"stance\":\"int\"},\"PlaceGameSoulPrefabPOD\":{\"attr\":\"list<double>\",\"equipments\":\"map<int|long>\",\"formationPos\":\"int\",\"id\":\"long\",\"lv\":\"int\",\"position\":\"int\",\"power\":\"int\",\"soulCid\":\"int\"},\"PlayerBaseInfoPOD\":{\"areaId\":\"string\",\"avatarFrame\":\"int\",\"channelNo\":\"string\",\"chatBackground\":\"int\",\"createTime\":\"int\",\"exp\":\"int\",\"guid\":\"int\",\"guildId\":\"int\",\"headIcon\":\"int\",\"intro\":\"string\",\"leaderCid\":\"int\",\"openId\":\"string\",\"pLv\":\"int\",\"pName\":\"string\",\"payPoint\":\"int\",\"pid\":\"string\",\"power\":\"int\",\"sceneID\":\"int\",\"sdkName\":\"string\",\"serverId\":\"string\",\"showSoulCid\":\"int\",\"sumPay\":\"int\",\"title\":\"int\",\"uid\":\"string\",\"vip\":\"int\",\"vipexp\":\"int\"},\"PlayerInfoPOD\":{\"allCollectItems\":\"list<int>\",\"baseInfo\":\"PlayerBaseInfoPOD\",\"finishMaze\":\"list<int>\",\"guildId\":\"int\",\"guildName\":\"string\",\"showCollectItems\":\"map<int|int>\",\"soulCount\":\"int\"},\"PlayerPOD\":{\"abyssCid\":\"int\",\"abyssCids\":\"list<int>\",\"advanceLevelChaseFlag\":\"bool\",\"antiAddictionAccTime\":\"int\",\"avatarFrameTimelimit\":\"map<int|int>\",\"backflowTime\":\"int\",\"baseInfo\":\"PlayerBaseInfoPOD\",\"chatRoom\":\"ChatRoomPOD\",\"commandChallengeLayerIDs\":\"list<int>\",\"currDialog\":\"int\",\"currMazes\":\"list<int>\",\"currentGuide\":\"map<int|int>\",\"currentWeatherCid\":\"int\",\"dailyDups\":\"list<DailyDupPOD>\",\"dailySupplyList\":\"list<int>\",\"disableGuide\":\"bool\",\"dressUpRotateList\":\"list<int>\",\"dressUpRotateSwitch\":\"int\",\"dresses\":\"list<DressPOD>\",\"equipSkins\":\"map<int|int>\",\"equipmentPrefabs\":\"list<EquipmentPrefabPOD>\",\"exchangeRecords\":\"map<int|int>\",\"failQuestList\":\"list<int>\",\"finishGuide\":\"map<int|int>\",\"finishMazes\":\"list<int>\",\"finishQuestList\":\"list<int>\",\"fishingData\":\"FishingDataPOD\",\"fondleNum\":\"int\",\"formations\":\"list<FormationPOD>\",\"friends\":\"list<FriendPOD>\",\"functionTypes\":\"list<int>\",\"globalBuffs\":\"list<GlobalBuffPOD>\",\"guildChatCaches\":\"list<SChatPOD>\",\"guildId\":\"int\",\"guildName\":\"string\",\"guildQuestGetRecord\":\"list<int>\",\"headIconTimelimit\":\"map<int|int>\",\"isGuildSign\":\"bool\",\"itemDebts\":\"map<int|int>\",\"itemUseRecords\":\"list<ItemUseRecordPOD>\",\"lotteryCnts\":\"map<int|int>\",\"lotteryRecords\":\"map<int|int>\",\"lotteryShows\":\"list<LotteryShowPOD>\",\"mallBuyCountHistory\":\"map<int|int>\",\"mallBuyCountRecords\":\"map<int|int>\",\"mallStartSellTime\":\"map<int|int>\",\"mazeInfoPOD\":\"map<int|MazeInfoPOD>\",\"monthCard\":\"map<int|int>\",\"newMailCount\":\"int\",\"nextRecoveryEnergyTime\":\"int\",\"nextRecoveryFondleTime\":\"int\",\"numAttrs\":\"map<int|int>\",\"opEventsDatas\":\"list<OperationEventDataPOD>\",\"opEventsStatus\":\"list<OperationEventPOD>\",\"openExtraMazes\":\"list<int>\",\"payCount\":\"map<int|int>\",\"payExBonus\":\"map<int|bool>\",\"playerParams\":\"map<int|int>\",\"playerSetting\":\"map<int|int>\",\"quests\":\"list<QuestPOD>\",\"quickChallenge\":\"list<int>\",\"randomMalls\":\"map<int|int>\",\"refundsGiftPackRewards\":\"map<int|int>\",\"refundsGiftPacks\":\"map<int|int>\",\"remainderGiveGiftNum\":\"int\",\"settingData\":\"map<string|string>\",\"shops\":\"list<ShopPOD>\",\"showCollectItems\":\"map<int|int>\",\"signInfo\":\"int\",\"soulMemoryChapters\":\"list<SoulMemoryChapterPOD>\",\"soulNewStorys\":\"list<SoulNewStoryPOD>\",\"soulPrefabs\":\"list<SoulPrefabPOD>\",\"souls\":\"list<SoulPOD>\",\"titleTimelimit\":\"map<int|int>\",\"todayHelpBuildingCount\":\"map<long|int>\",\"todayHelpHomeCount\":\"int\",\"todayHomeWorkCount\":\"int\",\"todayOpenVisitTreasureChest\":\"int\",\"townInfo\":\"TownPOD\",\"unlockAvatarFrames\":\"list<int>\",\"unlockChapterTasks\":\"list<int>\",\"unlockChatBackgrounds\":\"list<int>\",\"unlockChatEmojis\":\"list<int>\",\"unlockGirlBackgrounds\":\"list<int>\",\"unlockHeadIcons\":\"list<int>\",\"unlockLoginBackgrounds\":\"list<int>\",\"unlockRunes\":\"list<int>\",\"unlockSoulWhispers\":\"list<int>\",\"unlockTitle\":\"list<int>\",\"unlockTownEvents\":\"list<int>\",\"unlockedEvents\":\"list<int>\",\"warehouse\":\"list<ItemPOD>\"},\"PlayerPlatformDataPOD\":{\"attMap\":\"map<string|string>\",\"channelNo\":\"string\",\"sdkName\":\"string\"},\"PlayerSimplePOD\":{\"avatarFrame\":\"int\",\"chatBackground\":\"int\",\"guid\":\"int\",\"guildId\":\"int\",\"headIcon\":\"int\",\"leaderCid\":\"int\",\"pLv\":\"int\",\"pName\":\"string\",\"pid\":\"string\",\"serverId\":\"string\",\"showGirlDressId\":\"int\",\"title\":\"int\",\"vip\":\"int\"},\"PositionInformationPOD\":{\"att\":\"map<int|int>\",\"count\":\"int\",\"id\":\"int\",\"location\":\"int\",\"postType\":\"int\"},\"PostPOD\":{\"number\":\"int\",\"positionInformation\":\"map<int|PositionInformationPOD>\",\"restaurantMarkUp\":\"int\",\"type\":\"int\",\"value\":\"int\"},\"ProductionPOD\":{\"itemAwards\":\"map<int|int>\",\"nextProduceTime\":\"int\",\"oneProduceTime\":\"int\",\"output\":\"map<int|int>\",\"storageLimit\":\"int\"},\"QuestPOD\":{\"cid\":\"int\",\"createTime\":\"int\",\"finNum\":\"int\",\"tgtNum\":\"int\"},\"RPGMazePOD\":{\"controlCid\":\"int\",\"dolls\":\"list<DollPOD>\",\"exBossOpen\":\"bool\",\"freeChallengeBossCount\":\"int\",\"killedBoss\":\"list<int>\",\"lastAttackExBossTime\":\"int\",\"tickets\":\"int\",\"unlockBoss\":\"list<int>\"},\"RankSubsectionItemPOD\":{\"guildId\":\"string\",\"percentRank\":\"int\",\"pids\":\"list<string>\",\"score\":\"long\"},\"RankingPOD\":{\"avatarFrame\":\"int\",\"customData\":\"string\",\"guid\":\"int\",\"headIcon\":\"int\",\"name\":\"string\",\"pLv\":\"int\",\"pid\":\"string\",\"serverId\":\"string\",\"title\":\"int\",\"updateTime\":\"int\",\"userData\":\"string\",\"value\":\"long\",\"vip\":\"int\"},\"RestaurantOperationAttributePOD\":{\"allAtt\":\"int\",\"dialogId\":\"int\",\"income\":\"map<int|float>\",\"level\":\"int\",\"plot\":\"list<int>\",\"positionInformation\":\"list<PositionInformationPOD>\",\"postInfo\":\"list<PostPOD>\"},\"RestaurantOperationDrawPOD\":{\"cumulativeSteps\":\"int\",\"id\":\"int\",\"time\":\"int\"},\"RestaurantOperationEventPOD\":{\"achievement\":\"bool\",\"date\":\"long\",\"id\":\"int\",\"status\":\"bool\",\"value\":\"int\"},\"RestaurantOperationLinkGamePOD\":{\"id\":\"int\",\"time\":\"int\"},\"RestaurantOperationPOD\":{\"combatTraining\":\"map<int|int>\",\"event\":\"list<RestaurantOperationEventPOD>\",\"exBossLock\":\"bool\",\"numberOfReturns\":\"int\"},\"RestaurantOperationQuestionPOD\":{\"date\":\"long\",\"id\":\"int\",\"number\":\"int\",\"rightNumber\":\"int\",\"state\":\"int\"},\"RoleInfoPOD\":{\"createTime\":\"int\",\"guid\":\"int\",\"leaderCid\":\"int\",\"lv\":\"int\",\"pid\":\"string\",\"pname\":\"string\"},\"RoomPOD\":{\"cid\":\"int\",\"comfort\":\"int\",\"dbid\":\"long\",\"decorates\":\"list<DecoratePOD>\",\"foreignShow\":\"bool\",\"name\":\"string\",\"receiveComfortAwards\":\"bool\",\"suitCid\":\"int\"},\"SChatPOD\":{\"channel\":\"int\",\"content\":\"string\",\"sender\":\"PlayerSimplePOD\",\"target\":\"string\",\"time\":\"int\",\"type\":\"int\"},\"ShopPOD\":{\"buyGoodsList\":\"list<int>\",\"cid\":\"int\",\"freeRefreshCnt\":\"int\",\"goodsList\":\"list<int>\",\"itemRefreshCnt\":\"int\",\"nextRefreshTime\":\"int\",\"payRefreshCnt\":\"int\"},\"SimplePlayerPOD\":{\"avatarFrame\":\"int\",\"banSpeakEndTime\":\"long\",\"chatBackground\":\"int\",\"chatRoomId\":\"int\",\"createTime\":\"long\",\"guid\":\"int\",\"headIcon\":\"int\",\"isOnline\":\"bool\",\"isRobot\":\"bool\",\"lastLoginTime\":\"long\",\"lastLogoutTime\":\"long\",\"leaderCid\":\"int\",\"lv\":\"int\",\"pid\":\"string\",\"pname\":\"string\",\"registerIp\":\"string\",\"serverId\":\"string\",\"showGirlDressId\":\"int\",\"teamPower\":\"int\",\"title\":\"int\",\"totalCharge\":\"double\",\"uid\":\"string\",\"vip\":\"int\"},\"SingleWeakTowerPOD\":{\"towerFloor\":\"map<int|int>\"},\"SoulMemoryChapterPOD\":{\"cid\":\"int\",\"isExperience\":\"bool\",\"isGetReward\":\"bool\",\"isNew\":\"bool\",\"unlockPieceCids\":\"list<int>\"},\"SoulNewStoryPOD\":{\"cid\":\"int\",\"isAllComplete\":\"bool\",\"unlockChapters\":\"map<int|bool>\"},\"SoulOathPOD\":{\"activation\":\"bool\",\"countData\":\"map<int|int>\",\"dateData\":\"map<int|long>\"},\"SoulPOD\":{\"activationSkillStrengthen\":\"list<int>\",\"cid\":\"int\",\"dailyDislike\":\"bool\",\"dress2DCid\":\"int\",\"dress3DCid\":\"int\",\"exp\":\"int\",\"favor\":\"int\",\"favorLv\":\"int\",\"favorMaxLv\":\"int\",\"jewelry\":\"map<int|int>\",\"lv\":\"int\",\"mood\":\"int\",\"moodTimeInterval\":\"int\",\"oathActivation\":\"bool\",\"qualityId\":\"int\",\"soulAttr\":\"list<double>\",\"soulMemoryPieces\":\"list<int>\",\"specialSpirit\":\"list<int>\",\"talentCids\":\"list<int>\",\"talentGroupCids\":\"list<int>\",\"unlockSkillGroups\":\"list<int>\",\"workStatus\":\"int\"},\"SoulPrefabPOD\":{\"attr\":\"list<double>\",\"customSkills\":\"list<int>\",\"equipments\":\"map<int|long>\",\"id\":\"long\",\"jewelrySpeeds\":\"map<int|int>\",\"name\":\"string\",\"newJewelrySpeeds\":\"map<long|int>\",\"optionalSkill\":\"int\",\"position\":\"int\",\"power\":\"int\",\"skillGroupId\":\"int\",\"soulCid\":\"int\"},\"SpaceTreasureDataPOD\":{\"getTickets\":\"map<int|int>\",\"totalEnergy\":\"int\"},\"SummerAdventureDataPOD\":{\"exchangedCount\":\"int\"},\"SurvivalInfoPOD\":{\"boss\":\"int\",\"controlCid\":\"int\",\"currPass\":\"int\",\"dialogIDSequence\":\"list<int>\",\"level\":\"int\",\"survivalPassStatusPODMap\":\"map<int|SurvivalPassStatusPOD>\"},\"SurvivalPOD\":{\"dialogId\":\"int\",\"level\":\"int\",\"pass\":\"list<SurvivalPassStatusPOD>\"},\"SurvivalPassStatusPOD\":{\"award\":\"list<int>\",\"id\":\"int\"},\"TaleChallengeDataPOD\":{\"dialogId\":\"int\",\"passedNode\":\"list<int>\",\"taleChallengeRewardPoolData\":\"list<TaleChallengeRewardPoolPOD>\",\"unlockedBoss\":\"bool\",\"unlockedDifficulty\":\"list<int>\"},\"TaleChallengeRewardPoolPOD\":{\"drawCount\":\"map<int|int>\",\"id\":\"int\"},\"TowerPOD\":{\"nowLayer\":\"int\"},\"TownPOD\":{\"areas\":\"list<AreaPOD>\",\"currentEventId\":\"int\",\"executableEvents\":\"list<int>\",\"shoppingEventIds\":\"list<int>\"},\"TreasureHuntDataPOD\":{\"exchangeGiftRecords\":\"map<int|int>\"},\"TurntableDataPOD\":{\"dailyFreeDrawCount\":\"int\"},\"VoteDataPOD\":{\"myVotes\":\"map<int|int>\"},\"WorkRewardResultPOD\":{\"affairId\":\"int\",\"itemAward\":\"list<ItemShowPOD>\",\"superSuc\":\"bool\"},\"WorkersWhoPOD\":{\"attr\":\"list<double>\",\"cid\":\"int\"},\"WorldBossPOD\":{\"bossCid\":\"int\",\"buffOrder\":\"int\",\"typeLevel\":\"map<int|int>\"}}"

LuaCodeInterface.InitSnet(msgIdMethodName, msgIdMethodTypes, namePodSerialId, namePodTypes)

net_structs_inner = {}
net_structs = {}
net_gameToCenter = {}

function net_gameToCenter.registerSimplePlayer(sessionId, simplePlayerPOD, platformData)
	local success = LuaCodeInterface.Send(102, sessionId, simplePlayerPOD, platformData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.changePlayerName(pid, name)
	local success = LuaCodeInterface.Send(103, pid, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.loadPlayer(pid, platformData)
	local success = LuaCodeInterface.Send(104, pid, platformData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.offline(pid)
	local success = LuaCodeInterface.Send(105, pid)
end

function net_gameToCenter.heartbeat(serverId)
	local success = LuaCodeInterface.Send(106, serverId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.uploadSimplePlayer(simplePlayerPOD)
	local success = LuaCodeInterface.Send(107, simplePlayerPOD)
end

function net_gameToCenter.uploadRankScore(rankId, pid, score, customData, userData)
	local success = LuaCodeInterface.Send(108, rankId, pid, score, customData, userData)
end

function net_gameToCenter.notifyCentralStart()
	warning("please override this function -> net_gameToCenter.notifyCentralStart!")
end

function net_gameToCenter.notifyCentralStart_delegate()
	net_gameToCenter.notifyCentralStart()
end

function net_gameToCenter.notifyCentralStop()
	warning("please override this function -> net_gameToCenter.notifyCentralStop!")
end

function net_gameToCenter.notifyCentralStop_delegate()
	net_gameToCenter.notifyCentralStop()
end

function net_gameToCenter.registerSimplePlayerResult(code, sessionId, simplePlayerPOD)
	warning("please override this function -> net_gameToCenter.registerSimplePlayerResult!")
end

function net_gameToCenter.registerSimplePlayerResult_delegate(code, sessionId, simplePlayerPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.registerSimplePlayerResult(code, sessionId, simplePlayerPOD)
end

function net_gameToCenter.changePlayerNameResult(code, apiChange, pid, simplePlayerPOD)
	warning("please override this function -> net_gameToCenter.changePlayerNameResult!")
end

function net_gameToCenter.changePlayerNameResult_delegate(code, apiChange, pid, simplePlayerPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.changePlayerNameResult(code, apiChange, pid, simplePlayerPOD)
end

function net_gameToCenter.loadPlayerResult(code, pid, centerLoadPlayerPOD)
	warning("please override this function -> net_gameToCenter.loadPlayerResult!")
end

function net_gameToCenter.loadPlayerResult_delegate(code, pid, centerLoadPlayerPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.loadPlayerResult(code, pid, centerLoadPlayerPOD)
end

function net_gameToCenter.heartbeatResult(code, needReconnect)
	warning("please override this function -> net_gameToCenter.heartbeatResult!")
end

function net_gameToCenter.heartbeatResult_delegate(code, needReconnect)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.heartbeatResult(code, needReconnect)
end

function net_gameToCenter.notifyTopicChat(chat, pids, all)
	warning("please override this function -> net_gameToCenter.notifyTopicChat!")
end

function net_gameToCenter.notifyTopicChat_delegate(chat, pids, all)
	net_gameToCenter.notifyTopicChat(chat, pids, all)
end

function net_gameToCenter.notifyTopicChatRoom(chatRoom, pids)
	warning("please override this function -> net_gameToCenter.notifyTopicChatRoom!")
end

function net_gameToCenter.notifyTopicChatRoom_delegate(chatRoom, pids)
	net_gameToCenter.notifyTopicChatRoom(chatRoom, pids)
end

function net_gameToCenter.notifyExecCmd(pid, cmd)
	warning("please override this function -> net_gameToCenter.notifyExecCmd!")
end

function net_gameToCenter.notifyExecCmd_delegate(pid, cmd)
	net_gameToCenter.notifyExecCmd(pid, cmd)
end

function net_gameToCenter.notifyDailyDupCommon(dups)
	warning("please override this function -> net_gameToCenter.notifyDailyDupCommon!")
end

function net_gameToCenter.notifyDailyDupCommon_delegate(dups)
	net_gameToCenter.notifyDailyDupCommon(dups)
end

function net_gameToCenter.notifyTargetConditionComplete(pid, type, targetParams, addNum)
	warning("please override this function -> net_gameToCenter.notifyTargetConditionComplete!")
end

function net_gameToCenter.notifyTargetConditionComplete_delegate(pid, type, targetParams, addNum)
	net_gameToCenter.notifyTargetConditionComplete(pid, type, targetParams, addNum)
end

function net_gameToCenter.notifyRankRewards(rankId, fixRankPids, rankSubsectionItems)
	warning("please override this function -> net_gameToCenter.notifyRankRewards!")
end

function net_gameToCenter.notifyRankRewards_delegate(rankId, fixRankPids, rankSubsectionItems)
	net_gameToCenter.notifyRankRewards(rankId, fixRankPids, rankSubsectionItems)
end

function net_gameToCenter.notifyGuildRankRewards(rankId, fixRankPids, rankSubsectionItems)
	warning("please override this function -> net_gameToCenter.notifyGuildRankRewards!")
end

function net_gameToCenter.notifyGuildRankRewards_delegate(rankId, fixRankPids, rankSubsectionItems)
	net_gameToCenter.notifyGuildRankRewards(rankId, fixRankPids, rankSubsectionItems)
end

function net_gameToCenter.notifyGmMail(gmMail)
	warning("please override this function -> net_gameToCenter.notifyGmMail!")
end

function net_gameToCenter.notifyGmMail_delegate(gmMail)
	net_gameToCenter.notifyGmMail(gmMail)
end

function net_gameToCenter.notifyOperationsEventList(eventList)
	warning("please override this function -> net_gameToCenter.notifyOperationsEventList!")
end

function net_gameToCenter.notifyOperationsEventList_delegate(eventList)
	net_gameToCenter.notifyOperationsEventList(eventList)
end

function net_gameToCenter.notifyGroupPurchaseRewards(mailId, rewardsData)
	warning("please override this function -> net_gameToCenter.notifyGroupPurchaseRewards!")
end

function net_gameToCenter.notifyGroupPurchaseRewards_delegate(mailId, rewardsData)
	net_gameToCenter.notifyGroupPurchaseRewards(mailId, rewardsData)
end

function net_gameToCenter.notifyLunaBattleLineGarrison(zoneId, pname, soulCid)
	warning("please override this function -> net_gameToCenter.notifyLunaBattleLineGarrison!")
end

function net_gameToCenter.notifyLunaBattleLineGarrison_delegate(zoneId, pname, soulCid)
	net_gameToCenter.notifyLunaBattleLineGarrison(zoneId, pname, soulCid)
end

function net_gameToCenter.notifyNewbiesData(eventId, pid, inviteCode, inviteName)
	warning("please override this function -> net_gameToCenter.notifyNewbiesData!")
end

function net_gameToCenter.notifyNewbiesData_delegate(eventId, pid, inviteCode, inviteName)
	net_gameToCenter.notifyNewbiesData(eventId, pid, inviteCode, inviteName)
end

function net_gameToCenter.notifyNewbiesUpdate(eventId, pid, map)
	warning("please override this function -> net_gameToCenter.notifyNewbiesUpdate!")
end

function net_gameToCenter.notifyNewbiesUpdate_delegate(eventId, pid, map)
	net_gameToCenter.notifyNewbiesUpdate(eventId, pid, map)
end

function net_gameToCenter.notifyStandardMail(mailId, pid, content, expireTime, logType)
	warning("please override this function -> net_gameToCenter.notifyStandardMail!")
end

function net_gameToCenter.notifyStandardMail_delegate(mailId, pid, content, expireTime, logType)
	net_gameToCenter.notifyStandardMail(mailId, pid, content, expireTime, logType)
end

function net_gameToCenter.notifyTargetCheckStatusUpdate(pid, type, value)
	warning("please override this function -> net_gameToCenter.notifyTargetCheckStatusUpdate!")
end

function net_gameToCenter.notifyTargetCheckStatusUpdate_delegate(pid, type, value)
	net_gameToCenter.notifyTargetCheckStatusUpdate(pid, type, value)
end

function net_gameToCenter.notifyCenterServerDiscreteData(data)
	warning("please override this function -> net_gameToCenter.notifyCenterServerDiscreteData!")
end

function net_gameToCenter.notifyCenterServerDiscreteData_delegate(data)
	net_gameToCenter.notifyCenterServerDiscreteData(data)
end

function net_gameToCenter.notifyGuildTrainingMail(GuildTrainingBossScores)
	warning("please override this function -> net_gameToCenter.notifyGuildTrainingMail!")
end

function net_gameToCenter.notifyGuildTrainingMail_delegate(GuildTrainingBossScores)
	net_gameToCenter.notifyGuildTrainingMail(GuildTrainingBossScores)
end

function net_gameToCenter.notifyQuitGuild(pid)
	warning("please override this function -> net_gameToCenter.notifyQuitGuild!")
end

function net_gameToCenter.notifyQuitGuild_delegate(pid)
	net_gameToCenter.notifyQuitGuild(pid)
end

function net_gameToCenter.notifyPlaceGameRankMail(pLaceGameRankInfos)
	warning("please override this function -> net_gameToCenter.notifyPlaceGameRankMail!")
end

function net_gameToCenter.notifyPlaceGameRankMail_delegate(pLaceGameRankInfos)
	net_gameToCenter.notifyPlaceGameRankMail(pLaceGameRankInfos)
end

net_gameToGame = {}

function net_gameToGame.openHomeBox(name, pid, boxCid)
	local success = LuaCodeInterface.Send(202, name, pid, boxCid)
end

function net_gameToGame.helpHome(name, pid, target)
	local success = LuaCodeInterface.Send(203, name, pid, target)
end

net_remoteLogic = {}

function net_remoteLogic.requestMazeOrder(mazeID, orderJson)
	local success = LuaCodeInterface.Send(1002, mazeID, orderJson)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_remoteLogic.requestBattleOrder(fightID, orderJson)
	local success = LuaCodeInterface.Send(1003, fightID, orderJson)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_remoteLogic.responseMazeCommand(commandJson)
	warning("please override this function -> net_remoteLogic.responseMazeCommand!")
end

function net_remoteLogic.responseMazeCommand_delegate(commandJson)
	net_remoteLogic.responseMazeCommand(commandJson)
end

function net_remoteLogic.requestMazeOrderResult(code)
	warning("please override this function -> net_remoteLogic.requestMazeOrderResult!")
end

function net_remoteLogic.requestMazeOrderResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_remoteLogic.requestMazeOrderResult(code)
end

function net_remoteLogic.responseBattleCommand(commandJson)
	warning("please override this function -> net_remoteLogic.responseBattleCommand!")
end

function net_remoteLogic.responseBattleCommand_delegate(commandJson)
	net_remoteLogic.responseBattleCommand(commandJson)
end

function net_remoteLogic.requestBattleOrderResult(code)
	warning("please override this function -> net_remoteLogic.requestBattleOrderResult!")
end

function net_remoteLogic.requestBattleOrderResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_remoteLogic.requestBattleOrderResult(code)
end

net_shop = {}

function net_shop.buy(shopCid, index)
	local success = LuaCodeInterface.Send(1202, shopCid, index)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_shop.refresh(shopCid, type)
	local success = LuaCodeInterface.Send(1203, shopCid, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_shop.buyResult(code, shopCid, index)
	warning("please override this function -> net_shop.buyResult!")
end

function net_shop.buyResult_delegate(code, shopCid, index)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_shop.buyResult(code, shopCid, index)
end

function net_shop.refreshResult(code, shopCid, type)
	warning("please override this function -> net_shop.refreshResult!")
end

function net_shop.refreshResult_delegate(code, shopCid, type)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_shop.refreshResult(code, shopCid, type)
end

function net_shop.updateShop(shop)
	warning("please override this function -> net_shop.updateShop!")
end

function net_shop.updateShop_delegate(shop)
	net_shop.updateShop(shop)
end

net_maze = {}

function net_maze.enterMaze(mazeCid, formationID)
	local success = LuaCodeInterface.Send(1302, mazeCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.mazeSettlement(settlementPOD)
	local success = LuaCodeInterface.Send(1303, settlementPOD)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.saveMaze(saveData, isQuit, saveVersion)
	local success = LuaCodeInterface.Send(1304, saveData, isQuit, saveVersion)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.restoreMaze(mazeCid)
	local success = LuaCodeInterface.Send(1305, mazeCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.revive()
	local success = LuaCodeInterface.Send(1306)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.uploadMazeQuestProgress(cid, finNum)
	local success = LuaCodeInterface.Send(1307, cid, finNum)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.uploadMazeAlienEventUnlock(cid, elementCid)
	local success = LuaCodeInterface.Send(1308, cid, elementCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.enterMazeResult(code, maze)
	warning("please override this function -> net_maze.enterMazeResult!")
end

function net_maze.enterMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.enterMazeResult(code, maze)
end

function net_maze.mazeSettlementResult(code, mazeSettlementResult)
	warning("please override this function -> net_maze.mazeSettlementResult!")
end

function net_maze.mazeSettlementResult_delegate(code, mazeSettlementResult)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.mazeSettlementResult(code, mazeSettlementResult)
end

function net_maze.saveMazeResult(code, isQuit)
	warning("please override this function -> net_maze.saveMazeResult!")
end

function net_maze.saveMazeResult_delegate(code, isQuit)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.saveMazeResult(code, isQuit)
end

function net_maze.restoreMazeResult(code, maze)
	warning("please override this function -> net_maze.restoreMazeResult!")
end

function net_maze.restoreMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.restoreMazeResult(code, maze)
end

function net_maze.reviveResult(code)
	warning("please override this function -> net_maze.reviveResult!")
end

function net_maze.reviveResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.reviveResult(code)
end

function net_maze.uploadMazeQuestProgressResult(code)
	warning("please override this function -> net_maze.uploadMazeQuestProgressResult!")
end

function net_maze.uploadMazeQuestProgressResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.uploadMazeQuestProgressResult(code)
end

function net_maze.uploadMazeAlienEventUnlockResult(code, cid, elementCid)
	warning("please override this function -> net_maze.uploadMazeAlienEventUnlockResult!")
end

function net_maze.uploadMazeAlienEventUnlockResult_delegate(code, cid, elementCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.uploadMazeAlienEventUnlockResult(code, cid, elementCid)
end

function net_maze.notifyFinishMaze(mazeCid)
	warning("please override this function -> net_maze.notifyFinishMaze!")
end

function net_maze.notifyFinishMaze_delegate(mazeCid)
	net_maze.notifyFinishMaze(mazeCid)
end

function net_maze.notifyUpdateMazeInfo(pod)
	warning("please override this function -> net_maze.notifyUpdateMazeInfo!")
end

function net_maze.notifyUpdateMazeInfo_delegate(pod)
	net_maze.notifyUpdateMazeInfo(pod)
end

function net_maze.notifyUnlockRune(cid)
	warning("please override this function -> net_maze.notifyUnlockRune!")
end

function net_maze.notifyUnlockRune_delegate(cid)
	net_maze.notifyUnlockRune(cid)
end

function net_maze.openHiddenMaze(mazeCid)
	local success = LuaCodeInterface.Send(1319, mazeCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.buyMazeCount(mazeCid)
	local success = LuaCodeInterface.Send(1320, mazeCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.mopUp(mazeCid, count, formationID)
	local success = LuaCodeInterface.Send(1321, mazeCid, count, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.openHiddenMazeResult(code)
	warning("please override this function -> net_maze.openHiddenMazeResult!")
end

function net_maze.openHiddenMazeResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.openHiddenMazeResult(code)
end

function net_maze.buyMazeCountResult(code)
	warning("please override this function -> net_maze.buyMazeCountResult!")
end

function net_maze.buyMazeCountResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.buyMazeCountResult(code)
end

function net_maze.mopUpResult(code, mopUpInfo)
	warning("please override this function -> net_maze.mopUpResult!")
end

function net_maze.mopUpResult_delegate(code, mopUpInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.mopUpResult(code, mopUpInfo)
end

function net_maze.notifyUpdateOpenExtraMazes(mazeCids)
	warning("please override this function -> net_maze.notifyUpdateOpenExtraMazes!")
end

function net_maze.notifyUpdateOpenExtraMazes_delegate(mazeCids)
	net_maze.notifyUpdateOpenExtraMazes(mazeCids)
end

function net_maze.abandonMaze(mazeCid)
	local success = LuaCodeInterface.Send(1326, mazeCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.abandonMazeResult(code, mazeCid)
	warning("please override this function -> net_maze.abandonMazeResult!")
end

function net_maze.abandonMazeResult_delegate(code, mazeCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.abandonMazeResult(code, mazeCid)
end

function net_maze.enterAbyssMaze(mazeCid, formationID)
	local success = LuaCodeInterface.Send(1328, mazeCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.enterAbyssMazeResult(code, maze)
	warning("please override this function -> net_maze.enterAbyssMazeResult!")
end

function net_maze.enterAbyssMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.enterAbyssMazeResult(code, maze)
end

function net_maze.notifyUpdateCurrMazes(currMazes)
	warning("please override this function -> net_maze.notifyUpdateCurrMazes!")
end

function net_maze.notifyUpdateCurrMazes_delegate(currMazes)
	net_maze.notifyUpdateCurrMazes(currMazes)
end

function net_maze.enterHiddenMaze(mazeCid, formationID)
	local success = LuaCodeInterface.Send(1331, mazeCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.enterHiddenMazeResult(code, maze)
	warning("please override this function -> net_maze.enterHiddenMazeResult!")
end

function net_maze.enterHiddenMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.enterHiddenMazeResult(code, maze)
end

function net_maze.uploadMazeMonsterUnlock(cid)
	local success = LuaCodeInterface.Send(1333, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.uploadMazeMonsterUnlockResult(code)
	warning("please override this function -> net_maze.uploadMazeMonsterUnlockResult!")
end

function net_maze.uploadMazeMonsterUnlockResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.uploadMazeMonsterUnlockResult(code)
end

function net_maze.enterIllusionMaze(mazeCid, soulCid)
	local success = LuaCodeInterface.Send(1335, mazeCid, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.enterIllusionMazeResult(code, maze)
	warning("please override this function -> net_maze.enterIllusionMazeResult!")
end

function net_maze.enterIllusionMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.enterIllusionMazeResult(code, maze)
end

function net_maze.notifyAbyssCid(abyssCid)
	warning("please override this function -> net_maze.notifyAbyssCid!")
end

function net_maze.notifyAbyssCid_delegate(abyssCid)
	net_maze.notifyAbyssCid(abyssCid)
end

function net_maze.enterTestMaze(mazeCid, formationID)
	local success = LuaCodeInterface.Send(1338, mazeCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.enterTestMazeResult(code, maze)
	warning("please override this function -> net_maze.enterTestMazeResult!")
end

function net_maze.enterTestMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.enterTestMazeResult(code, maze)
end

function net_maze.illusionMopUp(mazeCid, count)
	local success = LuaCodeInterface.Send(1340, mazeCid, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.illusionMopUpResult(code, mopUpInfo)
	warning("please override this function -> net_maze.illusionMopUpResult!")
end

function net_maze.illusionMopUpResult_delegate(code, mopUpInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.illusionMopUpResult(code, mopUpInfo)
end

function net_maze.notifyAbyssCids(abyssCids)
	warning("please override this function -> net_maze.notifyAbyssCids!")
end

function net_maze.notifyAbyssCids_delegate(abyssCids)
	net_maze.notifyAbyssCids(abyssCids)
end

function net_maze.quickChallenge(mazeCid, formationID)
	local success = LuaCodeInterface.Send(1343, mazeCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_maze.quickChallengeResult(code)
	warning("please override this function -> net_maze.quickChallengeResult!")
end

function net_maze.quickChallengeResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_maze.quickChallengeResult(code)
end

function net_maze.notifyBossEnd(win, cid, dmgRecords, items, quickChallenge)
	warning("please override this function -> net_maze.notifyBossEnd!")
end

function net_maze.notifyBossEnd_delegate(win, cid, dmgRecords, items, quickChallenge)
	net_maze.notifyBossEnd(win, cid, dmgRecords, items, quickChallenge)
end

net_dress = {}

function net_dress.wear(dressCid)
	local success = LuaCodeInterface.Send(1402, dressCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dress.viewDress(dressCid)
	local success = LuaCodeInterface.Send(1403, dressCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dress.wearResult(code)
	warning("please override this function -> net_dress.wearResult!")
end

function net_dress.wearResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dress.wearResult(code)
end

function net_dress.viewDressResult(code)
	warning("please override this function -> net_dress.viewDressResult!")
end

function net_dress.viewDressResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dress.viewDressResult(code)
end

function net_dress.notifyUpdateDress(type, dress)
	warning("please override this function -> net_dress.notifyUpdateDress!")
end

function net_dress.notifyUpdateDress_delegate(type, dress)
	net_dress.notifyUpdateDress(type, dress)
end

net_dating = {}

function net_dating.dating(soulCid, chooseCid)
	local success = LuaCodeInterface.Send(1502, soulCid, chooseCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dating.datingResult(code, soulCid, chooseCid)
	warning("please override this function -> net_dating.datingResult!")
end

function net_dating.datingResult_delegate(code, soulCid, chooseCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dating.datingResult(code, soulCid, chooseCid)
end

function net_dating.notifyDatingEnd(soulCid, eventCid, getItems, favorData)
	warning("please override this function -> net_dating.notifyDatingEnd!")
end

function net_dating.notifyDatingEnd_delegate(soulCid, eventCid, getItems, favorData)
	net_dating.notifyDatingEnd(soulCid, eventCid, getItems, favorData)
end

function net_dating.notifyDating(soulCid, datingRecord)
	warning("please override this function -> net_dating.notifyDating!")
end

function net_dating.notifyDating_delegate(soulCid, datingRecord)
	net_dating.notifyDating(soulCid, datingRecord)
end

net_dialog = {}

function net_dialog.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(1602, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dialog.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_dialog.selectDialogResult!")
end

function net_dialog.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dialog.selectDialogResult(code, nextDialogCid)
end

function net_dialog.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_dialog.notifyOpenDialog!")
end

function net_dialog.notifyOpenDialog_delegate(dialogCid)
	net_dialog.notifyOpenDialog(dialogCid)
end

net_miniGame = {}

function net_miniGame.chooseCard(cardCfgIndex)
	local success = LuaCodeInterface.Send(1702, cardCfgIndex)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGame.chooseCardResult(code, cardCfgIndex)
	warning("please override this function -> net_miniGame.chooseCardResult!")
end

function net_miniGame.chooseCardResult_delegate(code, cardCfgIndex)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGame.chooseCardResult(code, cardCfgIndex)
end

function net_miniGame.notifyStartCardGame(cardCid)
	warning("please override this function -> net_miniGame.notifyStartCardGame!")
end

function net_miniGame.notifyStartCardGame_delegate(cardCid)
	net_miniGame.notifyStartCardGame(cardCid)
end

function net_miniGame.turntableEnd(cardCfgIndex)
	local success = LuaCodeInterface.Send(1705, cardCfgIndex)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGame.turntableEndResult(code, cardCfgIndex)
	warning("please override this function -> net_miniGame.turntableEndResult!")
end

function net_miniGame.turntableEndResult_delegate(code, cardCfgIndex)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGame.turntableEndResult(code, cardCfgIndex)
end

function net_miniGame.notifyStartTurntable(cid)
	warning("please override this function -> net_miniGame.notifyStartTurntable!")
end

function net_miniGame.notifyStartTurntable_delegate(cid)
	net_miniGame.notifyStartTurntable(cid)
end

net_home = {}

function net_home.enterHome()
	local success = LuaCodeInterface.Send(1802)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.exitHome()
	local success = LuaCodeInterface.Send(1803)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.harvestBuilding(buildingCid)
	local success = LuaCodeInterface.Send(1804, buildingCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.harvestLand(buildingCid, landCid)
	local success = LuaCodeInterface.Send(1805, buildingCid, landCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.plant(buildingCid, landCid, seedCid)
	local success = LuaCodeInterface.Send(1806, buildingCid, landCid, seedCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.unlockRoom(cid)
	local success = LuaCodeInterface.Send(1807, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.changeSuit(roomCid, suitCid)
	local success = LuaCodeInterface.Send(1808, roomCid, suitCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.visitHome(targetServerId, targetPid)
	local success = LuaCodeInterface.Send(1809, targetServerId, targetPid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.triggerPlot(cid)
	local success = LuaCodeInterface.Send(1810, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.unlockSuit(suitCid)
	local success = LuaCodeInterface.Send(1811, suitCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.cook(buildingCid, queueId, cookCombinationCid, num)
	local success = LuaCodeInterface.Send(1812, buildingCid, queueId, cookCombinationCid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.cancelCook(buildingCid, queueId)
	local success = LuaCodeInterface.Send(1813, buildingCid, queueId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.rewardCook(buildingCid, queueId)
	local success = LuaCodeInterface.Send(1814, buildingCid, queueId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.recordDailyAction(actionId)
	local success = LuaCodeInterface.Send(1815, actionId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.changeRoomName(cid, name)
	local success = LuaCodeInterface.Send(1816, cid, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.enterRoom(roomCid, homeLandRoleCid)
	local success = LuaCodeInterface.Send(1817, roomCid, homeLandRoleCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.switchRoomShow(cid)
	local success = LuaCodeInterface.Send(1818, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.receiveComfortLvAwards(cid)
	local success = LuaCodeInterface.Send(1819, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.completeCook(buildingCid, queueId, time)
	local success = LuaCodeInterface.Send(1820, buildingCid, queueId, time)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.startWork(buildingCid, affairId, soulCids)
	local success = LuaCodeInterface.Send(1821, buildingCid, affairId, soulCids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.rewardWork(buildingCid, affairId)
	local success = LuaCodeInterface.Send(1822, buildingCid, affairId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.completePlant(buildingCid, landCid, time)
	local success = LuaCodeInterface.Send(1823, buildingCid, landCid, time)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.cancelPlant(buildingCid, landCid)
	local success = LuaCodeInterface.Send(1824, buildingCid, landCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.make(buildingCid, queueId, manufactureItemCid)
	local success = LuaCodeInterface.Send(1825, buildingCid, queueId, manufactureItemCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.cancelMake(buildingCid, queueId)
	local success = LuaCodeInterface.Send(1826, buildingCid, queueId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.rewardMake(buildingCid, queueId)
	local success = LuaCodeInterface.Send(1827, buildingCid, queueId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.completeMake(buildingCid, queueId, time)
	local success = LuaCodeInterface.Send(1828, buildingCid, queueId, time)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.help(id, target)
	local success = LuaCodeInterface.Send(1829, id, target)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.openVisitTreasureChest(boxId)
	local success = LuaCodeInterface.Send(1830, boxId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.receiveComfortAwards(roomId)
	local success = LuaCodeInterface.Send(1831, roomId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.saveRoomDecorate(roomId, decorate)
	local success = LuaCodeInterface.Send(1832, roomId, decorate)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.resetAffair(affairId, buildingId, isFree)
	local success = LuaCodeInterface.Send(1833, affairId, buildingId, isFree)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.enterHomeResult(code, home)
	warning("please override this function -> net_home.enterHomeResult!")
end

function net_home.enterHomeResult_delegate(code, home)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.enterHomeResult(code, home)
end

function net_home.exitHomeResult(code)
	warning("please override this function -> net_home.exitHomeResult!")
end

function net_home.exitHomeResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.exitHomeResult(code)
end

function net_home.harvestBuildingResult(code, building, itemAwards)
	warning("please override this function -> net_home.harvestBuildingResult!")
end

function net_home.harvestBuildingResult_delegate(code, building, itemAwards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.harvestBuildingResult(code, building, itemAwards)
end

function net_home.harvestLandResult(code, buildingCid, land, itemAwards)
	warning("please override this function -> net_home.harvestLandResult!")
end

function net_home.harvestLandResult_delegate(code, buildingCid, land, itemAwards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.harvestLandResult(code, buildingCid, land, itemAwards)
end

function net_home.plantResult(code, buildingCid, land)
	warning("please override this function -> net_home.plantResult!")
end

function net_home.plantResult_delegate(code, buildingCid, land)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.plantResult(code, buildingCid, land)
end

function net_home.unlockRoomResult(code, cid)
	warning("please override this function -> net_home.unlockRoomResult!")
end

function net_home.unlockRoomResult_delegate(code, cid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.unlockRoomResult(code, cid)
end

function net_home.changeSuitResult(code, room)
	warning("please override this function -> net_home.changeSuitResult!")
end

function net_home.changeSuitResult_delegate(code, room)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.changeSuitResult(code, room)
end

function net_home.visitHomeResult(code, targetPid, home)
	warning("please override this function -> net_home.visitHomeResult!")
end

function net_home.visitHomeResult_delegate(code, targetPid, home)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.visitHomeResult(code, targetPid, home)
end

function net_home.triggerPlotResult(code, cid)
	warning("please override this function -> net_home.triggerPlotResult!")
end

function net_home.triggerPlotResult_delegate(code, cid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.triggerPlotResult(code, cid)
end

function net_home.unlockSuitResult(code, suitCid)
	warning("please override this function -> net_home.unlockSuitResult!")
end

function net_home.unlockSuitResult_delegate(code, suitCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.unlockSuitResult(code, suitCid)
end

function net_home.cookResult(code, building)
	warning("please override this function -> net_home.cookResult!")
end

function net_home.cookResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.cookResult(code, building)
end

function net_home.cancelCookResult(code, building)
	warning("please override this function -> net_home.cancelCookResult!")
end

function net_home.cancelCookResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.cancelCookResult(code, building)
end

function net_home.rewardCookResult(code, building, itemAward)
	warning("please override this function -> net_home.rewardCookResult!")
end

function net_home.rewardCookResult_delegate(code, building, itemAward)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.rewardCookResult(code, building, itemAward)
end

function net_home.recordDailyActionResult(code)
	warning("please override this function -> net_home.recordDailyActionResult!")
end

function net_home.recordDailyActionResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.recordDailyActionResult(code)
end

function net_home.changeRoomNameResult(code, room)
	warning("please override this function -> net_home.changeRoomNameResult!")
end

function net_home.changeRoomNameResult_delegate(code, room)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.changeRoomNameResult(code, room)
end

function net_home.enterRoomResult(code)
	warning("please override this function -> net_home.enterRoomResult!")
end

function net_home.enterRoomResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.enterRoomResult(code)
end

function net_home.switchRoomShowResult(code, room)
	warning("please override this function -> net_home.switchRoomShowResult!")
end

function net_home.switchRoomShowResult_delegate(code, room)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.switchRoomShowResult(code, room)
end

function net_home.receiveComfortLvAwardsResult(code, itemAwards)
	warning("please override this function -> net_home.receiveComfortLvAwardsResult!")
end

function net_home.receiveComfortLvAwardsResult_delegate(code, itemAwards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.receiveComfortLvAwardsResult(code, itemAwards)
end

function net_home.completeCookResult(code, building)
	warning("please override this function -> net_home.completeCookResult!")
end

function net_home.completeCookResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.completeCookResult(code, building)
end

function net_home.startWorkResult(code, building, count)
	warning("please override this function -> net_home.startWorkResult!")
end

function net_home.startWorkResult_delegate(code, building, count)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.startWorkResult(code, building, count)
end

function net_home.rewardWorkResult(code, building, rewardPODs)
	warning("please override this function -> net_home.rewardWorkResult!")
end

function net_home.rewardWorkResult_delegate(code, building, rewardPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.rewardWorkResult(code, building, rewardPODs)
end

function net_home.completePlantResult(code, buildingCid, land)
	warning("please override this function -> net_home.completePlantResult!")
end

function net_home.completePlantResult_delegate(code, buildingCid, land)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.completePlantResult(code, buildingCid, land)
end

function net_home.cancelPlantResult(code, buildingCid, land)
	warning("please override this function -> net_home.cancelPlantResult!")
end

function net_home.cancelPlantResult_delegate(code, buildingCid, land)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.cancelPlantResult(code, buildingCid, land)
end

function net_home.makeResult(code, building)
	warning("please override this function -> net_home.makeResult!")
end

function net_home.makeResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.makeResult(code, building)
end

function net_home.cancelMakeResult(code, building)
	warning("please override this function -> net_home.cancelMakeResult!")
end

function net_home.cancelMakeResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.cancelMakeResult(code, building)
end

function net_home.rewardMakeResult(code, building, itemAward)
	warning("please override this function -> net_home.rewardMakeResult!")
end

function net_home.rewardMakeResult_delegate(code, building, itemAward)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.rewardMakeResult(code, building, itemAward)
end

function net_home.completeMakeResult(code, building)
	warning("please override this function -> net_home.completeMakeResult!")
end

function net_home.completeMakeResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.completeMakeResult(code, building)
end

function net_home.helpResult(code, id, itemShows)
	warning("please override this function -> net_home.helpResult!")
end

function net_home.helpResult_delegate(code, id, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.helpResult(code, id, itemShows)
end

function net_home.openVisitTreasureChestResult(code, boxId, itemShows)
	warning("please override this function -> net_home.openVisitTreasureChestResult!")
end

function net_home.openVisitTreasureChestResult_delegate(code, boxId, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.openVisitTreasureChestResult(code, boxId, itemShows)
end

function net_home.receiveComfortAwardsResult(code, roomId, itemShows)
	warning("please override this function -> net_home.receiveComfortAwardsResult!")
end

function net_home.receiveComfortAwardsResult_delegate(code, roomId, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.receiveComfortAwardsResult(code, roomId, itemShows)
end

function net_home.saveRoomDecorateResult(code, roomId)
	warning("please override this function -> net_home.saveRoomDecorateResult!")
end

function net_home.saveRoomDecorateResult_delegate(code, roomId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.saveRoomDecorateResult(code, roomId)
end

function net_home.resetAffairResult(code)
	warning("please override this function -> net_home.resetAffairResult!")
end

function net_home.resetAffairResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.resetAffairResult(code)
end

function net_home.notifyUnlockCookBook(cookBookId)
	warning("please override this function -> net_home.notifyUnlockCookBook!")
end

function net_home.notifyUnlockCookBook_delegate(cookBookId)
	net_home.notifyUnlockCookBook(cookBookId)
end

function net_home.notifyUnlockSuit(ids)
	warning("please override this function -> net_home.notifyUnlockSuit!")
end

function net_home.notifyUnlockSuit_delegate(ids)
	net_home.notifyUnlockSuit(ids)
end

function net_home.notifyUpdateBasicHome(basicHome)
	warning("please override this function -> net_home.notifyUpdateBasicHome!")
end

function net_home.notifyUpdateBasicHome_delegate(basicHome)
	net_home.notifyUpdateBasicHome(basicHome)
end

function net_home.notifyUpdateLand(buildingCid, land)
	warning("please override this function -> net_home.notifyUpdateLand!")
end

function net_home.notifyUpdateLand_delegate(buildingCid, land)
	net_home.notifyUpdateLand(buildingCid, land)
end

function net_home.notifyUpdateBuilding(building)
	warning("please override this function -> net_home.notifyUpdateBuilding!")
end

function net_home.notifyUpdateBuilding_delegate(building)
	net_home.notifyUpdateBuilding(building)
end

function net_home.notifyUpdateRoom(room)
	warning("please override this function -> net_home.notifyUpdateRoom!")
end

function net_home.notifyUpdateRoom_delegate(room)
	net_home.notifyUpdateRoom(room)
end

function net_home.notifyUnlockManufactureItem(manufactureItemCid)
	warning("please override this function -> net_home.notifyUnlockManufactureItem!")
end

function net_home.notifyUnlockManufactureItem_delegate(manufactureItemCid)
	net_home.notifyUnlockManufactureItem(manufactureItemCid)
end

function net_home.notifyActivationDecorates(activationDecorates)
	warning("please override this function -> net_home.notifyActivationDecorates!")
end

function net_home.notifyActivationDecorates_delegate(activationDecorates)
	net_home.notifyActivationDecorates(activationDecorates)
end

function net_home.notifyHomeRole(roles)
	warning("please override this function -> net_home.notifyHomeRole!")
end

function net_home.notifyHomeRole_delegate(roles)
	net_home.notifyHomeRole(roles)
end

function net_home.receiveLetter(roleCid, letterCid)
	local success = LuaCodeInterface.Send(1875, roleCid, letterCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.receiveLetterResult(code, roleCid, letterCid, getItems)
	warning("please override this function -> net_home.receiveLetterResult!")
end

function net_home.receiveLetterResult_delegate(code, roleCid, letterCid, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.receiveLetterResult(code, roleCid, letterCid, getItems)
end

function net_home.updateBuildingLv(buildingCid)
	local success = LuaCodeInterface.Send(1877, buildingCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.undoAffair(affairId, buildingCid)
	local success = LuaCodeInterface.Send(1878, affairId, buildingCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.updateBuildingLvResult(code)
	warning("please override this function -> net_home.updateBuildingLvResult!")
end

function net_home.updateBuildingLvResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.updateBuildingLvResult(code)
end

function net_home.undoAffairResult(code)
	warning("please override this function -> net_home.undoAffairResult!")
end

function net_home.undoAffairResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.undoAffairResult(code)
end

function net_home.compound(cid, buildingCid, num)
	local success = LuaCodeInterface.Send(1881, cid, buildingCid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.decompose(cid, buildingCid, num)
	local success = LuaCodeInterface.Send(1882, cid, buildingCid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.compoundResult(code, getItems)
	warning("please override this function -> net_home.compoundResult!")
end

function net_home.compoundResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.compoundResult(code, getItems)
end

function net_home.decomposeResult(code, getItems)
	warning("please override this function -> net_home.decomposeResult!")
end

function net_home.decomposeResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.decomposeResult(code, getItems)
end

function net_home.decomposeDecorate(decorateCid, num)
	local success = LuaCodeInterface.Send(1885, decorateCid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.unlockLand(buildingCid, landCid)
	local success = LuaCodeInterface.Send(1886, buildingCid, landCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.decomposeDecorateResult(code, decorateCid, num)
	warning("please override this function -> net_home.decomposeDecorateResult!")
end

function net_home.decomposeDecorateResult_delegate(code, decorateCid, num)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.decomposeDecorateResult(code, decorateCid, num)
end

function net_home.unlockLandResult(code, landPOD)
	warning("please override this function -> net_home.unlockLandResult!")
end

function net_home.unlockLandResult_delegate(code, landPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.unlockLandResult(code, landPOD)
end

net_girl = {}

function net_girl.getGirls()
	local success = LuaCodeInterface.Send(1902)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_girl.exitGirls()
	local success = LuaCodeInterface.Send(1903)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_girl.getGirlsResult(code, girls)
	warning("please override this function -> net_girl.getGirlsResult!")
end

function net_girl.getGirlsResult_delegate(code, girls)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_girl.getGirlsResult(code, girls)
end

function net_girl.exitGirlsResult(code)
	warning("please override this function -> net_girl.exitGirlsResult!")
end

function net_girl.exitGirlsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_girl.exitGirlsResult(code)
end

function net_girl.giveGift(soulCid, giftCid)
	local success = LuaCodeInterface.Send(1906, soulCid, giftCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_girl.giveGiftResult(code, soulCid, giftCid, spAddition, addFavor)
	warning("please override this function -> net_girl.giveGiftResult!")
end

function net_girl.giveGiftResult_delegate(code, soulCid, giftCid, spAddition, addFavor)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_girl.giveGiftResult(code, soulCid, giftCid, spAddition, addFavor)
end

function net_girl.fondle(soulCid)
	local success = LuaCodeInterface.Send(1908, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_girl.fondleResult(code, soulCid, actionCid, addFavor, dislike, fondleNum)
	warning("please override this function -> net_girl.fondleResult!")
end

function net_girl.fondleResult_delegate(code, soulCid, actionCid, addFavor, dislike, fondleNum)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_girl.fondleResult(code, soulCid, actionCid, addFavor, dislike, fondleNum)
end

function net_girl.notifyFondleNumRecovery(fondleNum, nextRecoveryFondleNumTime)
	warning("please override this function -> net_girl.notifyFondleNumRecovery!")
end

function net_girl.notifyFondleNumRecovery_delegate(fondleNum, nextRecoveryFondleNumTime)
	net_girl.notifyFondleNumRecovery(fondleNum, nextRecoveryFondleNumTime)
end

function net_girl.connective(soulMarryId)
	local success = LuaCodeInterface.Send(1911, soulMarryId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_girl.getSoulOath(soulCid)
	local success = LuaCodeInterface.Send(1912, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_girl.connectiveResult(code, soulMarryId, soulCid, shows)
	warning("please override this function -> net_girl.connectiveResult!")
end

function net_girl.connectiveResult_delegate(code, soulMarryId, soulCid, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_girl.connectiveResult(code, soulMarryId, soulCid, shows)
end

function net_girl.getSoulOathResult(code, soulCid, pod)
	warning("please override this function -> net_girl.getSoulOathResult!")
end

function net_girl.getSoulOathResult_delegate(code, soulCid, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_girl.getSoulOathResult(code, soulCid, pod)
end

net_town = {}

function net_town.shopping(eventCid)
	local success = LuaCodeInterface.Send(2202, eventCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_town.execMainline(areaCid, eventCid)
	local success = LuaCodeInterface.Send(2203, areaCid, eventCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_town.enterArea(areaCid)
	local success = LuaCodeInterface.Send(2204, areaCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_town.shoppingResult(code)
	warning("please override this function -> net_town.shoppingResult!")
end

function net_town.shoppingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_town.shoppingResult(code)
end

function net_town.execMainlineResult(code, areaCid, eventCid)
	warning("please override this function -> net_town.execMainlineResult!")
end

function net_town.execMainlineResult_delegate(code, areaCid, eventCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_town.execMainlineResult(code, areaCid, eventCid)
end

function net_town.enterAreaResult(code, areaCid)
	warning("please override this function -> net_town.enterAreaResult!")
end

function net_town.enterAreaResult_delegate(code, areaCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_town.enterAreaResult(code, areaCid)
end

function net_town.notifyUnlockArea(area)
	warning("please override this function -> net_town.notifyUnlockArea!")
end

function net_town.notifyUnlockArea_delegate(area)
	net_town.notifyUnlockArea(area)
end

function net_town.notifyEvent(ids)
	warning("please override this function -> net_town.notifyEvent!")
end

function net_town.notifyEvent_delegate(ids)
	net_town.notifyEvent(ids)
end

function net_town.notifyShoppingFinish(areaCid, itemAwards)
	warning("please override this function -> net_town.notifyShoppingFinish!")
end

function net_town.notifyShoppingFinish_delegate(areaCid, itemAwards)
	net_town.notifyShoppingFinish(areaCid, itemAwards)
end

function net_town.notifyMainlineFinish(itemAwards)
	warning("please override this function -> net_town.notifyMainlineFinish!")
end

function net_town.notifyMainlineFinish_delegate(itemAwards)
	net_town.notifyMainlineFinish(itemAwards)
end

function net_town.notifyShoppingEventRefresh(ids)
	warning("please override this function -> net_town.notifyShoppingEventRefresh!")
end

function net_town.notifyShoppingEventRefresh_delegate(ids)
	net_town.notifyShoppingEventRefresh(ids)
end

function net_town.notifyTownFunctionOpen(townPOD)
	warning("please override this function -> net_town.notifyTownFunctionOpen!")
end

function net_town.notifyTownFunctionOpen_delegate(townPOD)
	net_town.notifyTownFunctionOpen(townPOD)
end

net_lottery = {}

function net_lottery.lottery(showId, lotteryCid, upCids)
	local success = LuaCodeInterface.Send(2402, showId, lotteryCid, upCids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lottery.lotteryResult(code, lotteryShowPOD, lotteryCid, lotteryRecords, baseShowItems, showItems)
	warning("please override this function -> net_lottery.lotteryResult!")
end

function net_lottery.lotteryResult_delegate(code, lotteryShowPOD, lotteryCid, lotteryRecords, baseShowItems, showItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lottery.lotteryResult(code, lotteryShowPOD, lotteryCid, lotteryRecords, baseShowItems, showItems)
end

function net_lottery.getLotteryHistory()
	local success = LuaCodeInterface.Send(2404)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lottery.getLotteryHistoryResult(code, lottertHistorys)
	warning("please override this function -> net_lottery.getLotteryHistoryResult!")
end

function net_lottery.getLotteryHistoryResult_delegate(code, lottertHistorys)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lottery.getLotteryHistoryResult(code, lottertHistorys)
end

net_mall = {}

function net_mall.buy(mallCid, num)
	local success = LuaCodeInterface.Send(2502, mallCid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mall.buyResult(code, mallCid, num, getItems)
	warning("please override this function -> net_mall.buyResult!")
end

function net_mall.buyResult_delegate(code, mallCid, num, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mall.buyResult(code, mallCid, num, getItems)
end

function net_mall.notifyMallRefresh(mallBuyCountRecords)
	warning("please override this function -> net_mall.notifyMallRefresh!")
end

function net_mall.notifyMallRefresh_delegate(mallBuyCountRecords)
	net_mall.notifyMallRefresh(mallBuyCountRecords)
end

function net_mall.notifyMallStartSellTime(mallStartSellTime)
	warning("please override this function -> net_mall.notifyMallStartSellTime!")
end

function net_mall.notifyMallStartSellTime_delegate(mallStartSellTime)
	net_mall.notifyMallStartSellTime(mallStartSellTime)
end

net_library = {}

function net_library.openLibrary()
	local success = LuaCodeInterface.Send(2602)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_library.openLibraryResult(code, library)
	warning("please override this function -> net_library.openLibraryResult!")
end

function net_library.openLibraryResult_delegate(code, library)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_library.openLibraryResult(code, library)
end

function net_library.viewNewsBook(id)
	local success = LuaCodeInterface.Send(2604, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_library.viewNewsBookResult(code)
	warning("please override this function -> net_library.viewNewsBookResult!")
end

function net_library.viewNewsBookResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_library.viewNewsBookResult(code)
end

function net_library.getNewsBookRewards(id)
	local success = LuaCodeInterface.Send(2606, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_library.getNewsBookRewardsResult(code, id, itemShows)
	warning("please override this function -> net_library.getNewsBookRewardsResult!")
end

function net_library.getNewsBookRewardsResult_delegate(code, id, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_library.getNewsBookRewardsResult(code, id, itemShows)
end

net_soulPrefab = {}

function net_soulPrefab.wearEquipment(soulPrelabId, equipmentId, pos)
	local success = LuaCodeInterface.Send(2702, soulPrelabId, equipmentId, pos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.dumpEquipment(soulPrelabId, equipmentId)
	local success = LuaCodeInterface.Send(2703, soulPrelabId, equipmentId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.upgradeEquipment(equipmentId, materialIds)
	local success = LuaCodeInterface.Send(2704, equipmentId, materialIds)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.upStarEquipment(equipmentId, materialIds)
	local success = LuaCodeInterface.Send(2705, equipmentId, materialIds)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.decpEquipment(materialIds, senior)
	local success = LuaCodeInterface.Send(2706, materialIds, senior)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.changeSoulPrefab(soulPrefabId, soulId, skillGroupId, customSkills, optionalSkill)
	local success = LuaCodeInterface.Send(2707, soulPrefabId, soulId, skillGroupId, customSkills, optionalSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.changeFormationPos(prefabId, pos)
	local success = LuaCodeInterface.Send(2708, prefabId, pos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.exchangeEquipment(prefabId, idx1, idx2)
	local success = LuaCodeInterface.Send(2709, prefabId, idx1, idx2)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.wearEquipmentResult(code)
	warning("please override this function -> net_soulPrefab.wearEquipmentResult!")
end

function net_soulPrefab.wearEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.wearEquipmentResult(code)
end

function net_soulPrefab.dumpEquipmentResult(code)
	warning("please override this function -> net_soulPrefab.dumpEquipmentResult!")
end

function net_soulPrefab.dumpEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.dumpEquipmentResult(code)
end

function net_soulPrefab.upgradeEquipmentResult(code)
	warning("please override this function -> net_soulPrefab.upgradeEquipmentResult!")
end

function net_soulPrefab.upgradeEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.upgradeEquipmentResult(code)
end

function net_soulPrefab.upStarEquipmentResult(code)
	warning("please override this function -> net_soulPrefab.upStarEquipmentResult!")
end

function net_soulPrefab.upStarEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.upStarEquipmentResult(code)
end

function net_soulPrefab.decpEquipmentResult(code, getItems)
	warning("please override this function -> net_soulPrefab.decpEquipmentResult!")
end

function net_soulPrefab.decpEquipmentResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.decpEquipmentResult(code, getItems)
end

function net_soulPrefab.changeSoulPrefabResult(code)
	warning("please override this function -> net_soulPrefab.changeSoulPrefabResult!")
end

function net_soulPrefab.changeSoulPrefabResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.changeSoulPrefabResult(code)
end

function net_soulPrefab.changeFormationPosResult(code)
	warning("please override this function -> net_soulPrefab.changeFormationPosResult!")
end

function net_soulPrefab.changeFormationPosResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.changeFormationPosResult(code)
end

function net_soulPrefab.exchangeEquipmentResult(code)
	warning("please override this function -> net_soulPrefab.exchangeEquipmentResult!")
end

function net_soulPrefab.exchangeEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.exchangeEquipmentResult(code)
end

function net_soulPrefab.notifySoulPrefab(pods)
	warning("please override this function -> net_soulPrefab.notifySoulPrefab!")
end

function net_soulPrefab.notifySoulPrefab_delegate(pods)
	net_soulPrefab.notifySoulPrefab(pods)
end

function net_soulPrefab.wearEquipmentPrefab(soulPrelabId, equipmentPrefabId)
	local success = LuaCodeInterface.Send(2719, soulPrelabId, equipmentPrefabId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.saveEquipmentPrefab(equipmentPrefabMap, equipmentPrefabId)
	local success = LuaCodeInterface.Send(2720, equipmentPrefabMap, equipmentPrefabId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.wearEquipmentPrefabResult(code)
	warning("please override this function -> net_soulPrefab.wearEquipmentPrefabResult!")
end

function net_soulPrefab.wearEquipmentPrefabResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.wearEquipmentPrefabResult(code)
end

function net_soulPrefab.saveEquipmentPrefabResult(code)
	warning("please override this function -> net_soulPrefab.saveEquipmentPrefabResult!")
end

function net_soulPrefab.saveEquipmentPrefabResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.saveEquipmentPrefabResult(code)
end

function net_soulPrefab.notifyEquipmentPrefabChange(pod)
	warning("please override this function -> net_soulPrefab.notifyEquipmentPrefabChange!")
end

function net_soulPrefab.notifyEquipmentPrefabChange_delegate(pod)
	net_soulPrefab.notifyEquipmentPrefabChange(pod)
end

function net_soulPrefab.coverEquipments(soulPrefabId, equipmentMap)
	local success = LuaCodeInterface.Send(2724, soulPrefabId, equipmentMap)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.coverEquipmentsResult(code)
	warning("please override this function -> net_soulPrefab.coverEquipmentsResult!")
end

function net_soulPrefab.coverEquipmentsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.coverEquipmentsResult(code)
end

function net_soulPrefab.changEquipmentPrefabName(prefabId, name)
	local success = LuaCodeInterface.Send(2726, prefabId, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.changEquipmentPrefabNameResult(code)
	warning("please override this function -> net_soulPrefab.changEquipmentPrefabNameResult!")
end

function net_soulPrefab.changEquipmentPrefabNameResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.changEquipmentPrefabNameResult(code)
end

function net_soulPrefab.setJewelrySpeed(prefabId, jewelryCid, speed)
	local success = LuaCodeInterface.Send(2728, prefabId, jewelryCid, speed)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulPrefab.setJewelrySpeedResult(code)
	warning("please override this function -> net_soulPrefab.setJewelrySpeedResult!")
end

function net_soulPrefab.setJewelrySpeedResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulPrefab.setJewelrySpeedResult(code)
end

net_dailyDup = {}

function net_dailyDup.buyCount(dupCid)
	local success = LuaCodeInterface.Send(2802, dupCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dailyDup.buyCountResult(code)
	warning("please override this function -> net_dailyDup.buyCountResult!")
end

function net_dailyDup.buyCountResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dailyDup.buyCountResult(code)
end

function net_dailyDup.notifyDailyDup(dup)
	warning("please override this function -> net_dailyDup.notifyDailyDup!")
end

function net_dailyDup.notifyDailyDup_delegate(dup)
	net_dailyDup.notifyDailyDup(dup)
end

net_fight = {}

function net_fight.fightOver(type, fightResult, dmgRecords, attacker, defender, fightData, userData, round, healRecords, hurtRecords)
	local success = LuaCodeInterface.Send(2902, type, fightResult, dmgRecords, attacker, defender, fightData, userData, round, healRecords, hurtRecords)
end

function net_fight.notifyStartFight(isLocalFight, fightPOD, userData)
	warning("please override this function -> net_fight.notifyStartFight!")
end

function net_fight.notifyStartFight_delegate(isLocalFight, fightPOD, userData)
	net_fight.notifyStartFight(isLocalFight, fightPOD, userData)
end

net_challenge = {}

function net_challenge.challengeDup(levelCid, formationID)
	local success = LuaCodeInterface.Send(3002, levelCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_challenge.sweeping(levelCid, count)
	local success = LuaCodeInterface.Send(3003, levelCid, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_challenge.challengeDupResult(code)
	warning("please override this function -> net_challenge.challengeDupResult!")
end

function net_challenge.challengeDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_challenge.challengeDupResult(code)
end

function net_challenge.sweepingResult(code, getItems, oldMaxHurt)
	warning("please override this function -> net_challenge.sweepingResult!")
end

function net_challenge.sweepingResult_delegate(code, getItems, oldMaxHurt)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_challenge.sweepingResult(code, getItems, oldMaxHurt)
end

function net_challenge.notifyChallengeComplete(win, dupCid, levelCid, dmgRecords, getItems, oldMaxHurt)
	warning("please override this function -> net_challenge.notifyChallengeComplete!")
end

function net_challenge.notifyChallengeComplete_delegate(win, dupCid, levelCid, dmgRecords, getItems, oldMaxHurt)
	net_challenge.notifyChallengeComplete(win, dupCid, levelCid, dmgRecords, getItems, oldMaxHurt)
end

net_tower = {}

function net_tower.climbingTower(towerCid, formationID)
	local success = LuaCodeInterface.Send(3102, towerCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_tower.climbingTowerResult(code)
	warning("please override this function -> net_tower.climbingTowerResult!")
end

function net_tower.climbingTowerResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_tower.climbingTowerResult(code)
end

function net_tower.notifyClimbingTowerComplete(win, dupCid, layerCid, dmgRecords, getItems, maxLayer, nowLayer)
	warning("please override this function -> net_tower.notifyClimbingTowerComplete!")
end

function net_tower.notifyClimbingTowerComplete_delegate(win, dupCid, layerCid, dmgRecords, getItems, maxLayer, nowLayer)
	net_tower.notifyClimbingTowerComplete(win, dupCid, layerCid, dmgRecords, getItems, maxLayer, nowLayer)
end

net_worldBoss = {}

function net_worldBoss.attack(dupCid, formationID, clearCD, boosCid)
	local success = LuaCodeInterface.Send(3202, dupCid, formationID, clearCD, boosCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_worldBoss.attackResult(code, dupCid, boosCid)
	warning("please override this function -> net_worldBoss.attackResult!")
end

function net_worldBoss.attackResult_delegate(code, dupCid, boosCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_worldBoss.attackResult(code, dupCid, boosCid)
end

function net_worldBoss.notifyAttackComplete(win, dupCid, layerCid, dmgRecords, getItems, worldBossPOD)
	warning("please override this function -> net_worldBoss.notifyAttackComplete!")
end

function net_worldBoss.notifyAttackComplete_delegate(win, dupCid, layerCid, dmgRecords, getItems, worldBossPOD)
	net_worldBoss.notifyAttackComplete(win, dupCid, layerCid, dmgRecords, getItems, worldBossPOD)
end

net_soulNewStory = {}

function net_soulNewStory.experienceNewStoryChapter(storyCid, chapterIndex)
	local success = LuaCodeInterface.Send(3402, storyCid, chapterIndex)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulNewStory.experienceNewStoryChapterResult(code, storyCid, chapterIndex)
	warning("please override this function -> net_soulNewStory.experienceNewStoryChapterResult!")
end

function net_soulNewStory.experienceNewStoryChapterResult_delegate(code, storyCid, chapterIndex)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulNewStory.experienceNewStoryChapterResult(code, storyCid, chapterIndex)
end

function net_soulNewStory.notifyCompleteNewStoryChapter(soulNewStory, showRewards, beginFavorLv, beginFavor, endFavorLv, endFavor)
	warning("please override this function -> net_soulNewStory.notifyCompleteNewStoryChapter!")
end

function net_soulNewStory.notifyCompleteNewStoryChapter_delegate(soulNewStory, showRewards, beginFavorLv, beginFavor, endFavorLv, endFavor)
	net_soulNewStory.notifyCompleteNewStoryChapter(soulNewStory, showRewards, beginFavorLv, beginFavor, endFavorLv, endFavor)
end

function net_soulNewStory.notifyUpdateSoulNewStory(soulNewStory)
	warning("please override this function -> net_soulNewStory.notifyUpdateSoulNewStory!")
end

function net_soulNewStory.notifyUpdateSoulNewStory_delegate(soulNewStory)
	net_soulNewStory.notifyUpdateSoulNewStory(soulNewStory)
end

net_soulMemory = {}

function net_soulMemory.activeMemoryPiece(chapterCid, pieceCid)
	local success = LuaCodeInterface.Send(3602, chapterCid, pieceCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulMemory.experienceMemory(chapterCid)
	local success = LuaCodeInterface.Send(3603, chapterCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulMemory.getRewards(chapterCid)
	local success = LuaCodeInterface.Send(3604, chapterCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulMemory.viewMemory(chapterCid)
	local success = LuaCodeInterface.Send(3605, chapterCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soulMemory.activeMemoryPieceResult(code, chapterCid, pieceCid, soulMemoryChapter)
	warning("please override this function -> net_soulMemory.activeMemoryPieceResult!")
end

function net_soulMemory.activeMemoryPieceResult_delegate(code, chapterCid, pieceCid, soulMemoryChapter)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulMemory.activeMemoryPieceResult(code, chapterCid, pieceCid, soulMemoryChapter)
end

function net_soulMemory.experienceMemoryResult(code, chapterCid)
	warning("please override this function -> net_soulMemory.experienceMemoryResult!")
end

function net_soulMemory.experienceMemoryResult_delegate(code, chapterCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulMemory.experienceMemoryResult(code, chapterCid)
end

function net_soulMemory.getRewardsResult(code, chapterCid, showRewards, soulMemoryChapter, newSoulMemoryChapter)
	warning("please override this function -> net_soulMemory.getRewardsResult!")
end

function net_soulMemory.getRewardsResult_delegate(code, chapterCid, showRewards, soulMemoryChapter, newSoulMemoryChapter)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulMemory.getRewardsResult(code, chapterCid, showRewards, soulMemoryChapter, newSoulMemoryChapter)
end

function net_soulMemory.viewMemoryResult(code)
	warning("please override this function -> net_soulMemory.viewMemoryResult!")
end

function net_soulMemory.viewMemoryResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soulMemory.viewMemoryResult(code)
end

function net_soulMemory.notifyUpdateSoulMemoryChapter(soulMemoryChapter)
	warning("please override this function -> net_soulMemory.notifyUpdateSoulMemoryChapter!")
end

function net_soulMemory.notifyUpdateSoulMemoryChapter_delegate(soulMemoryChapter)
	net_soulMemory.notifyUpdateSoulMemoryChapter(soulMemoryChapter)
end

function net_soulMemory.notifySoulMemoryDressProgress(soulCid, memoryDressProgress)
	warning("please override this function -> net_soulMemory.notifySoulMemoryDressProgress!")
end

function net_soulMemory.notifySoulMemoryDressProgress_delegate(soulCid, memoryDressProgress)
	net_soulMemory.notifySoulMemoryDressProgress(soulCid, memoryDressProgress)
end

net_active = {}

function net_active.reciveFood(cid, isFree)
	local success = LuaCodeInterface.Send(3702, cid, isFree)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.reciveFoodResult(code, cid)
	warning("please override this function -> net_active.reciveFoodResult!")
end

function net_active.reciveFoodResult_delegate(code, cid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.reciveFoodResult(code, cid)
end

function net_active.sign()
	local success = LuaCodeInterface.Send(3704)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.signResult(code, signInfo, shows)
	warning("please override this function -> net_active.signResult!")
end

function net_active.signResult_delegate(code, signInfo, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.signResult(code, signInfo, shows)
end

function net_active.notifySign(signInfo)
	warning("please override this function -> net_active.notifySign!")
end

function net_active.notifySign_delegate(signInfo)
	net_active.notifySign(signInfo)
end

function net_active.luckDraw(type)
	local success = LuaCodeInterface.Send(3707, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.getLuckDrawHistory()
	local success = LuaCodeInterface.Send(3708)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.luckDrawResult(code, showItems)
	warning("please override this function -> net_active.luckDrawResult!")
end

function net_active.luckDrawResult_delegate(code, showItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.luckDrawResult(code, showItems)
end

function net_active.getLuckDrawHistoryResult(code, luckDrawHistorys)
	warning("please override this function -> net_active.getLuckDrawHistoryResult!")
end

function net_active.getLuckDrawHistoryResult_delegate(code, luckDrawHistorys)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.getLuckDrawHistoryResult(code, luckDrawHistorys)
end

function net_active.getLvReachRewardList()
	local success = LuaCodeInterface.Send(3711)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.getLvReachReward(id)
	local success = LuaCodeInterface.Send(3712, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.getLvReachRewardListResult(code, idsList)
	warning("please override this function -> net_active.getLvReachRewardListResult!")
end

function net_active.getLvReachRewardListResult_delegate(code, idsList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.getLvReachRewardListResult(code, idsList)
end

function net_active.getLvReachRewardResult(code, itemList)
	warning("please override this function -> net_active.getLvReachRewardResult!")
end

function net_active.getLvReachRewardResult_delegate(code, itemList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.getLvReachRewardResult(code, itemList)
end

function net_active.getRefundsGiftPacks(id)
	local success = LuaCodeInterface.Send(3715, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_active.getRefundsGiftPacksResult(code, showItems)
	warning("please override this function -> net_active.getRefundsGiftPacksResult!")
end

function net_active.getRefundsGiftPacksResult_delegate(code, showItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_active.getRefundsGiftPacksResult(code, showItems)
end

function net_active.notifyRefundsGiftPacksUpdate(refundsGiftPacks, refundsGiftPackRewards)
	warning("please override this function -> net_active.notifyRefundsGiftPacksUpdate!")
end

function net_active.notifyRefundsGiftPacksUpdate_delegate(refundsGiftPacks, refundsGiftPackRewards)
	net_active.notifyRefundsGiftPacksUpdate(refundsGiftPacks, refundsGiftPackRewards)
end

net_user = {}

function net_user.validateUUID(uuid, serverId, accountServerId)
	local success = LuaCodeInterface.Send(3802, uuid, serverId, accountServerId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.chooseRole(pid)
	local success = LuaCodeInterface.Send(3803, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.createRole(leaderCid, name)
	local success = LuaCodeInterface.Send(3804, leaderCid, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.ping()
	local success = LuaCodeInterface.Send(3805)
end

function net_user.logout()
	local success = LuaCodeInterface.Send(3806)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.validateUUIDResult(code, roles, recommandJobId, uid, reconnectToken, testMode)
	warning("please override this function -> net_user.validateUUIDResult!")
end

function net_user.validateUUIDResult_delegate(code, roles, recommandJobId, uid, reconnectToken, testMode)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.validateUUIDResult(code, roles, recommandJobId, uid, reconnectToken, testMode)
end

function net_user.chooseRoleResult(code, handselSoulCount, msg)
	warning("please override this function -> net_user.chooseRoleResult!")
end

function net_user.chooseRoleResult_delegate(code, handselSoulCount, msg)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.chooseRoleResult(code, handselSoulCount, msg)
end

function net_user.createRoleResult(code, role)
	warning("please override this function -> net_user.createRoleResult!")
end

function net_user.createRoleResult_delegate(code, role)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.createRoleResult(code, role)
end

function net_user.pang(serverTime)
	warning("please override this function -> net_user.pang!")
end

function net_user.pang_delegate(serverTime)
	net_user.pang(serverTime)
end

function net_user.logoutResult(code)
	warning("please override this function -> net_user.logoutResult!")
end

function net_user.logoutResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.logoutResult(code)
end

function net_user.notifyServerStatus(time, rawOffset)
	warning("please override this function -> net_user.notifyServerStatus!")
end

function net_user.notifyServerStatus_delegate(time, rawOffset)
	net_user.notifyServerStatus(time, rawOffset)
end

function net_user.notifyError(code, msg)
	warning("please override this function -> net_user.notifyError!")
end

function net_user.notifyError_delegate(code, msg)
	net_user.notifyError(code, msg)
end

function net_user.handselSoul()
	local success = LuaCodeInterface.Send(3814)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.handselSoulResult(code, handselSoulCount)
	warning("please override this function -> net_user.handselSoulResult!")
end

function net_user.handselSoulResult_delegate(code, handselSoulCount)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.handselSoulResult(code, handselSoulCount)
end

function net_user.reconnect(token, readMsgLength, uid)
	local success = LuaCodeInterface.Send(3816, token, readMsgLength, uid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.reconnectResult(code, lastMsgOrder, reconnectToken)
	warning("please override this function -> net_user.reconnectResult!")
end

function net_user.reconnectResult_delegate(code, lastMsgOrder, reconnectToken)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.reconnectResult(code, lastMsgOrder, reconnectToken)
end

net_player = {}

function net_player.loadPlayer()
	local success = LuaCodeInterface.Send(3902)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.disbindRole(pid)
	local success = LuaCodeInterface.Send(3903, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.changeData(type, content)
	local success = LuaCodeInterface.Send(3904, type, content)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.getPlayerInfo(targetServerId, targetPid)
	local success = LuaCodeInterface.Send(3905, targetServerId, targetPid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.sendGiftCode(code)
	local success = LuaCodeInterface.Send(3906, code)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.changeShowSoul(soulCid)
	local success = LuaCodeInterface.Send(3907, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.triggerGuide(id, step, type)
	local success = LuaCodeInterface.Send(3908, id, step, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.refreshReadPoint(type)
	local success = LuaCodeInterface.Send(3909, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.loadPlayerResult(code, player)
	warning("please override this function -> net_player.loadPlayerResult!")
end

function net_player.loadPlayerResult_delegate(code, player)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.loadPlayerResult(code, player)
end

function net_player.disbindRoleResult(code)
	warning("please override this function -> net_player.disbindRoleResult!")
end

function net_player.disbindRoleResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.disbindRoleResult(code)
end

function net_player.changeDataResult(code, type, baseInfo)
	warning("please override this function -> net_player.changeDataResult!")
end

function net_player.changeDataResult_delegate(code, type, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.changeDataResult(code, type, baseInfo)
end

function net_player.getPlayerInfoResult(code, playerInfo)
	warning("please override this function -> net_player.getPlayerInfoResult!")
end

function net_player.getPlayerInfoResult_delegate(code, playerInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.getPlayerInfoResult(code, playerInfo)
end

function net_player.sendGiftCodeResult(code, items)
	warning("please override this function -> net_player.sendGiftCodeResult!")
end

function net_player.sendGiftCodeResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.sendGiftCodeResult(code, items)
end

function net_player.changeShowSoulResult(code)
	warning("please override this function -> net_player.changeShowSoulResult!")
end

function net_player.changeShowSoulResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.changeShowSoulResult(code)
end

function net_player.triggerGuideResult(code, id, step, type)
	warning("please override this function -> net_player.triggerGuideResult!")
end

function net_player.triggerGuideResult_delegate(code, id, step, type)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.triggerGuideResult(code, id, step, type)
end

function net_player.refreshReadPointResult(code)
	warning("please override this function -> net_player.refreshReadPointResult!")
end

function net_player.refreshReadPointResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.refreshReadPointResult(code)
end

function net_player.updateBaseInfo(baseInfo)
	warning("please override this function -> net_player.updateBaseInfo!")
end

function net_player.updateBaseInfo_delegate(baseInfo)
	net_player.updateBaseInfo(baseInfo)
end

function net_player.updateAttributes(attributes)
	warning("please override this function -> net_player.updateAttributes!")
end

function net_player.updateAttributes_delegate(attributes)
	net_player.updateAttributes(attributes)
end

function net_player.notifyFunctionTypeOpen(functionTypeId)
	warning("please override this function -> net_player.notifyFunctionTypeOpen!")
end

function net_player.notifyFunctionTypeOpen_delegate(functionTypeId)
	net_player.notifyFunctionTypeOpen(functionTypeId)
end

function net_player.notifyUnlockEvent(eventCid)
	warning("please override this function -> net_player.notifyUnlockEvent!")
end

function net_player.notifyUnlockEvent_delegate(eventCid)
	net_player.notifyUnlockEvent(eventCid)
end

function net_player.notifyEnergyRecovery(energy, nextRecoveryEnergyTime)
	warning("please override this function -> net_player.notifyEnergyRecovery!")
end

function net_player.notifyEnergyRecovery_delegate(energy, nextRecoveryEnergyTime)
	net_player.notifyEnergyRecovery(energy, nextRecoveryEnergyTime)
end

function net_player.updatePlayerGlobalBuff(globalBuffs)
	warning("please override this function -> net_player.updatePlayerGlobalBuff!")
end

function net_player.updatePlayerGlobalBuff_delegate(globalBuffs)
	net_player.updatePlayerGlobalBuff(globalBuffs)
end

function net_player.notifyNumAttr(numAttr)
	warning("please override this function -> net_player.notifyNumAttr!")
end

function net_player.notifyNumAttr_delegate(numAttr)
	net_player.notifyNumAttr(numAttr)
end

function net_player.notifyUnLockHeadIcon(headIconId, remove)
	warning("please override this function -> net_player.notifyUnLockHeadIcon!")
end

function net_player.notifyUnLockHeadIcon_delegate(headIconId, remove)
	net_player.notifyUnLockHeadIcon(headIconId, remove)
end

function net_player.notifyUnLockLoginBackground(background)
	warning("please override this function -> net_player.notifyUnLockLoginBackground!")
end

function net_player.notifyUnLockLoginBackground_delegate(background)
	net_player.notifyUnLockLoginBackground(background)
end

function net_player.notifyWeather(weatherCid)
	warning("please override this function -> net_player.notifyWeather!")
end

function net_player.notifyWeather_delegate(weatherCid)
	net_player.notifyWeather(weatherCid)
end

function net_player.notifyReadPoint(readPoint)
	warning("please override this function -> net_player.notifyReadPoint!")
end

function net_player.notifyReadPoint_delegate(readPoint)
	net_player.notifyReadPoint(readPoint)
end

function net_player.notifyUpdatePlayerParams(paramID, value)
	warning("please override this function -> net_player.notifyUpdatePlayerParams!")
end

function net_player.notifyUpdatePlayerParams_delegate(paramID, value)
	net_player.notifyUpdatePlayerParams(paramID, value)
end

function net_player.notifyEffectNotice(effectType, effectParams, num)
	warning("please override this function -> net_player.notifyEffectNotice!")
end

function net_player.notifyEffectNotice_delegate(effectType, effectParams, num)
	net_player.notifyEffectNotice(effectType, effectParams, num)
end

function net_player.notifyTodayOpenVisitTreasureChest(todayOpenVisitTreasureChest)
	warning("please override this function -> net_player.notifyTodayOpenVisitTreasureChest!")
end

function net_player.notifyTodayOpenVisitTreasureChest_delegate(todayOpenVisitTreasureChest)
	net_player.notifyTodayOpenVisitTreasureChest(todayOpenVisitTreasureChest)
end

function net_player.notifyTodayHelpHomeCount(todayHelpHomeCount)
	warning("please override this function -> net_player.notifyTodayHelpHomeCount!")
end

function net_player.notifyTodayHelpHomeCount_delegate(todayHelpHomeCount)
	net_player.notifyTodayHelpHomeCount(todayHelpHomeCount)
end

function net_player.notifyTodayHelpBuildingCount(todayHelpBuildingCount)
	warning("please override this function -> net_player.notifyTodayHelpBuildingCount!")
end

function net_player.notifyTodayHelpBuildingCount_delegate(todayHelpBuildingCount)
	net_player.notifyTodayHelpBuildingCount(todayHelpBuildingCount)
end

function net_player.notifyUnlockTownEvent(eventCid)
	warning("please override this function -> net_player.notifyUnlockTownEvent!")
end

function net_player.notifyUnlockTownEvent_delegate(eventCid)
	net_player.notifyUnlockTownEvent(eventCid)
end

function net_player.notifyDailyReset(dailyReset)
	warning("please override this function -> net_player.notifyDailyReset!")
end

function net_player.notifyDailyReset_delegate(dailyReset)
	net_player.notifyDailyReset(dailyReset)
end

function net_player.notifyRecharge(getPayPoint, exBonus, open_id, order_id, game_order_id, product_id, product_type, amount, unit, pay_time, role_name)
	warning("please override this function -> net_player.notifyRecharge!")
end

function net_player.notifyRecharge_delegate(getPayPoint, exBonus, open_id, order_id, game_order_id, product_id, product_type, amount, unit, pay_time, role_name)
	net_player.notifyRecharge(getPayPoint, exBonus, open_id, order_id, game_order_id, product_id, product_type, amount, unit, pay_time, role_name)
end

function net_player.notifyPayInfo(payCount, payExBonus)
	warning("please override this function -> net_player.notifyPayInfo!")
end

function net_player.notifyPayInfo_delegate(payCount, payExBonus)
	net_player.notifyPayInfo(payCount, payExBonus)
end

function net_player.notifyMonthCard(monthCard)
	warning("please override this function -> net_player.notifyMonthCard!")
end

function net_player.notifyMonthCard_delegate(monthCard)
	net_player.notifyMonthCard(monthCard)
end

function net_player.notifyUnLockAvatarFrame(avatarFrame, remove)
	warning("please override this function -> net_player.notifyUnLockAvatarFrame!")
end

function net_player.notifyUnLockAvatarFrame_delegate(avatarFrame, remove)
	net_player.notifyUnLockAvatarFrame(avatarFrame, remove)
end

function net_player.saveSettingData(key, value)
	local success = LuaCodeInterface.Send(3940, key, value)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.saveSettingDataResult(code)
	warning("please override this function -> net_player.saveSettingDataResult!")
end

function net_player.saveSettingDataResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.saveSettingDataResult(code)
end

function net_player.notifyItemDebts(itemDebts)
	warning("please override this function -> net_player.notifyItemDebts!")
end

function net_player.notifyItemDebts_delegate(itemDebts)
	net_player.notifyItemDebts(itemDebts)
end

function net_player.notifyChatEmojiUnlock(cid)
	warning("please override this function -> net_player.notifyChatEmojiUnlock!")
end

function net_player.notifyChatEmojiUnlock_delegate(cid)
	net_player.notifyChatEmojiUnlock(cid)
end

function net_player.notifyUnLockTitle(title, remove)
	warning("please override this function -> net_player.notifyUnLockTitle!")
end

function net_player.notifyUnLockTitle_delegate(title, remove)
	net_player.notifyUnLockTitle(title, remove)
end

function net_player.saveShowCollectItems(items)
	local success = LuaCodeInterface.Send(3945, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.saveShowCollectItemsResult(code, items)
	warning("please override this function -> net_player.saveShowCollectItemsResult!")
end

function net_player.saveShowCollectItemsResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.saveShowCollectItemsResult(code, items)
end

function net_player.buyAdvanceLevelChase()
	local success = LuaCodeInterface.Send(3947)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.buyAdvanceLevelChaseResult(code)
	warning("please override this function -> net_player.buyAdvanceLevelChaseResult!")
end

function net_player.buyAdvanceLevelChaseResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.buyAdvanceLevelChaseResult(code)
end

function net_player.notifyExecution(id)
	warning("please override this function -> net_player.notifyExecution!")
end

function net_player.notifyExecution_delegate(id)
	net_player.notifyExecution(id)
end

function net_player.notifySoulWhisperUnlock(whisperId)
	warning("please override this function -> net_player.notifySoulWhisperUnlock!")
end

function net_player.notifySoulWhisperUnlock_delegate(whisperId)
	net_player.notifySoulWhisperUnlock(whisperId)
end

function net_player.notifyHeadIconTimelimit(headIconTimelimit)
	warning("please override this function -> net_player.notifyHeadIconTimelimit!")
end

function net_player.notifyHeadIconTimelimit_delegate(headIconTimelimit)
	net_player.notifyHeadIconTimelimit(headIconTimelimit)
end

function net_player.notifyAvatarFrameTimelimit(avatarFrameTimelimit)
	warning("please override this function -> net_player.notifyAvatarFrameTimelimit!")
end

function net_player.notifyAvatarFrameTimelimit_delegate(avatarFrameTimelimit)
	net_player.notifyAvatarFrameTimelimit(avatarFrameTimelimit)
end

function net_player.notifyTitleTimelimit(titleTimelimit)
	warning("please override this function -> net_player.notifyTitleTimelimit!")
end

function net_player.notifyTitleTimelimit_delegate(titleTimelimit)
	net_player.notifyTitleTimelimit(titleTimelimit)
end

function net_player.useEquipSkin(id, status)
	local success = LuaCodeInterface.Send(3954, id, status)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.useEquipSkinResult(code, id, status)
	warning("please override this function -> net_player.useEquipSkinResult!")
end

function net_player.useEquipSkinResult_delegate(code, id, status)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.useEquipSkinResult(code, id, status)
end

function net_player.notifyEquipSkinUpdate(cid, status)
	warning("please override this function -> net_player.notifyEquipSkinUpdate!")
end

function net_player.notifyEquipSkinUpdate_delegate(cid, status)
	net_player.notifyEquipSkinUpdate(cid, status)
end

function net_player.notifyRandomMallUpdate(randomMalls)
	warning("please override this function -> net_player.notifyRandomMallUpdate!")
end

function net_player.notifyRandomMallUpdate_delegate(randomMalls)
	net_player.notifyRandomMallUpdate(randomMalls)
end

function net_player.notifyUnLockGirlBackground(background)
	warning("please override this function -> net_player.notifyUnLockGirlBackground!")
end

function net_player.notifyUnLockGirlBackground_delegate(background)
	net_player.notifyUnLockGirlBackground(background)
end

function net_player.notifyUnLockChatBackground(background)
	warning("please override this function -> net_player.notifyUnLockChatBackground!")
end

function net_player.notifyUnLockChatBackground_delegate(background)
	net_player.notifyUnLockChatBackground(background)
end

function net_player.savePlayerSetting(key, value)
	local success = LuaCodeInterface.Send(3960, key, value)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.savePlayerSettingResult(code, key, value)
	warning("please override this function -> net_player.savePlayerSettingResult!")
end

function net_player.savePlayerSettingResult_delegate(code, key, value)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.savePlayerSettingResult(code, key, value)
end

function net_player.dressUpRotateSwitch(value)
	local success = LuaCodeInterface.Send(3962, value)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.dressUpRotateList(ids)
	local success = LuaCodeInterface.Send(3963, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.dressUpRotateSwitchResult(code, value)
	warning("please override this function -> net_player.dressUpRotateSwitchResult!")
end

function net_player.dressUpRotateSwitchResult_delegate(code, value)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.dressUpRotateSwitchResult(code, value)
end

function net_player.dressUpRotateListResult(code, ids)
	warning("please override this function -> net_player.dressUpRotateListResult!")
end

function net_player.dressUpRotateListResult_delegate(code, ids)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.dressUpRotateListResult(code, ids)
end

net_item = {}

function net_item.sellItem(itemId, num)
	local success = LuaCodeInterface.Send(4002, itemId, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.useItem(itemId, num)
	local success = LuaCodeInterface.Send(4003, itemId, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.destroyItem(itemId)
	local success = LuaCodeInterface.Send(4004, itemId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.sellItemResult(code)
	warning("please override this function -> net_item.sellItemResult!")
end

function net_item.sellItemResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.sellItemResult(code)
end

function net_item.useItemResult(code, addItems, itemUseRecords)
	warning("please override this function -> net_item.useItemResult!")
end

function net_item.useItemResult_delegate(code, addItems, itemUseRecords)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.useItemResult(code, addItems, itemUseRecords)
end

function net_item.destroyItemResult(code)
	warning("please override this function -> net_item.destroyItemResult!")
end

function net_item.destroyItemResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.destroyItemResult(code)
end

function net_item.exchange(cid, count)
	local success = LuaCodeInterface.Send(4008, cid, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.exchangeBatch(idCounts)
	local success = LuaCodeInterface.Send(4009, idCounts)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.exchangeResult(code, success, showItems, exchangeRecords, critMultiple)
	warning("please override this function -> net_item.exchangeResult!")
end

function net_item.exchangeResult_delegate(code, success, showItems, exchangeRecords, critMultiple)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.exchangeResult(code, success, showItems, exchangeRecords, critMultiple)
end

function net_item.exchangeBatchResult(code, successInfo, showItems, exchangeRecords)
	warning("please override this function -> net_item.exchangeBatchResult!")
end

function net_item.exchangeBatchResult_delegate(code, successInfo, showItems, exchangeRecords)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.exchangeBatchResult(code, successInfo, showItems, exchangeRecords)
end

function net_item.lockEquipment(equipmentId)
	local success = LuaCodeInterface.Send(4012, equipmentId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.lockEquipmentResult(code, equipmentId, lock)
	warning("please override this function -> net_item.lockEquipmentResult!")
end

function net_item.lockEquipmentResult_delegate(code, equipmentId, lock)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.lockEquipmentResult(code, equipmentId, lock)
end

function net_item.optionalGift(itemId, chooses, num)
	local success = LuaCodeInterface.Send(4014, itemId, chooses, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.optionalGiftResult(code, getItems)
	warning("please override this function -> net_item.optionalGiftResult!")
end

function net_item.optionalGiftResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.optionalGiftResult(code, getItems)
end

net_warehouse = {}

function net_warehouse.notifyItemChange(datas)
	warning("please override this function -> net_warehouse.notifyItemChange!")
end

function net_warehouse.notifyItemChange_delegate(datas)
	net_warehouse.notifyItemChange(datas)
end

net_worldnotice = {}

function net_worldnotice.broadcastShopBuy(noticeId, pName, goodsCid)
	warning("please override this function -> net_worldnotice.broadcastShopBuy!")
end

function net_worldnotice.broadcastShopBuy_delegate(noticeId, pName, goodsCid)
	net_worldnotice.broadcastShopBuy(noticeId, pName, goodsCid)
end

net_quest = {}

function net_quest.commitQuest(cids)
	local success = LuaCodeInterface.Send(4302, cids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_quest.giveUpQuest(cid)
	local success = LuaCodeInterface.Send(4303, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_quest.commitQuestResult(code, cids, awards)
	warning("please override this function -> net_quest.commitQuestResult!")
end

function net_quest.commitQuestResult_delegate(code, cids, awards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_quest.commitQuestResult(code, cids, awards)
end

function net_quest.giveUpQuestResult(code, cid)
	warning("please override this function -> net_quest.giveUpQuestResult!")
end

function net_quest.giveUpQuestResult_delegate(code, cid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_quest.giveUpQuestResult(code, cid)
end

function net_quest.notifyUpdateQuest(updateQuest, remove)
	warning("please override this function -> net_quest.notifyUpdateQuest!")
end

function net_quest.notifyUpdateQuest_delegate(updateQuest, remove)
	net_quest.notifyUpdateQuest(updateQuest, remove)
end

function net_quest.notifyFinishQuestList(cid, remove)
	warning("please override this function -> net_quest.notifyFinishQuestList!")
end

function net_quest.notifyFinishQuestList_delegate(cid, remove)
	net_quest.notifyFinishQuestList(cid, remove)
end

function net_quest.notifyFailQuestList(cid, remove)
	warning("please override this function -> net_quest.notifyFailQuestList!")
end

function net_quest.notifyFailQuestList_delegate(cid, remove)
	net_quest.notifyFailQuestList(cid, remove)
end

function net_quest.notifyAutoCommit(cid, awards)
	warning("please override this function -> net_quest.notifyAutoCommit!")
end

function net_quest.notifyAutoCommit_delegate(cid, awards)
	net_quest.notifyAutoCommit(cid, awards)
end

function net_quest.unlockChapterTasks(mids)
	local success = LuaCodeInterface.Send(4310, mids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_quest.unlockChapterTasksResult(code, mids)
	warning("please override this function -> net_quest.unlockChapterTasksResult!")
end

function net_quest.unlockChapterTasksResult_delegate(code, mids)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_quest.unlockChapterTasksResult(code, mids)
end

net_formation = {}

function net_formation.changeFormationName(id, name)
	local success = LuaCodeInterface.Send(4402, id, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.exchangeSoulPrefab(formationId, exchangeIdx1, exchangeIdx2, skillGroupId1, customSkills1, optionalSkill1)
	local success = LuaCodeInterface.Send(4403, formationId, exchangeIdx1, exchangeIdx2, skillGroupId1, customSkills1, optionalSkill1)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.changeFormationNameResult(code, name)
	warning("please override this function -> net_formation.changeFormationNameResult!")
end

function net_formation.changeFormationNameResult_delegate(code, name)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.changeFormationNameResult(code, name)
end

function net_formation.exchangeSoulPrefabResult(code)
	warning("please override this function -> net_formation.exchangeSoulPrefabResult!")
end

function net_formation.exchangeSoulPrefabResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.exchangeSoulPrefabResult(code)
end

function net_formation.notifyFomationUpdate(formation)
	warning("please override this function -> net_formation.notifyFomationUpdate!")
end

function net_formation.notifyFomationUpdate_delegate(formation)
	net_formation.notifyFomationUpdate(formation)
end

function net_formation.copyFormation(fromId, copyToId)
	local success = LuaCodeInterface.Send(4407, fromId, copyToId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.copyFormationResult(code, fromId, copyToId)
	warning("please override this function -> net_formation.copyFormationResult!")
end

function net_formation.copyFormationResult_delegate(code, fromId, copyToId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.copyFormationResult(code, fromId, copyToId)
end

net_mail = {}

function net_mail.getMails(mailType)
	local success = LuaCodeInterface.Send(4502, mailType)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.readMail(mailId)
	local success = LuaCodeInterface.Send(4503, mailId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.pickUp(mailIdList)
	local success = LuaCodeInterface.Send(4504, mailIdList)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.delMail(mailIdList)
	local success = LuaCodeInterface.Send(4505, mailIdList)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.getMailsResult(code, mailType, mails)
	warning("please override this function -> net_mail.getMailsResult!")
end

function net_mail.getMailsResult_delegate(code, mailType, mails)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.getMailsResult(code, mailType, mails)
end

function net_mail.readMailResult(code, mailId)
	warning("please override this function -> net_mail.readMailResult!")
end

function net_mail.readMailResult_delegate(code, mailId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.readMailResult(code, mailId)
end

function net_mail.pickUpResult(code, mails, getItems)
	warning("please override this function -> net_mail.pickUpResult!")
end

function net_mail.pickUpResult_delegate(code, mails, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.pickUpResult(code, mails, getItems)
end

function net_mail.delMailResult(code, mails)
	warning("please override this function -> net_mail.delMailResult!")
end

function net_mail.delMailResult_delegate(code, mails)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.delMailResult(code, mails)
end

function net_mail.notifyNewMail(newMailCount)
	warning("please override this function -> net_mail.notifyNewMail!")
end

function net_mail.notifyNewMail_delegate(newMailCount)
	net_mail.notifyNewMail(newMailCount)
end

net_soul = {}

function net_soul.unlock(soulCid)
	local success = LuaCodeInterface.Send(4602, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.useSoulExpItem(soulCid, items)
	local success = LuaCodeInterface.Send(4603, soulCid, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.evolution(soulCid)
	local success = LuaCodeInterface.Send(4604, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.activeTalent(soulCid, talentCid)
	local success = LuaCodeInterface.Send(4605, soulCid, talentCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.activeTalentGroup(soulCid, groupCid)
	local success = LuaCodeInterface.Send(4606, soulCid, groupCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.unlockSkillGroup(soulId, skillGroupId)
	local success = LuaCodeInterface.Send(4607, soulId, skillGroupId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.activationSkillStrengthen(soulCid, skillCId, skillStrengthenCid)
	local success = LuaCodeInterface.Send(4608, soulCid, skillCId, skillStrengthenCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.unlockResult(code)
	warning("please override this function -> net_soul.unlockResult!")
end

function net_soul.unlockResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.unlockResult(code)
end

function net_soul.useSoulExpItemResult(code)
	warning("please override this function -> net_soul.useSoulExpItemResult!")
end

function net_soul.useSoulExpItemResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.useSoulExpItemResult(code)
end

function net_soul.evolutionResult(code, soul)
	warning("please override this function -> net_soul.evolutionResult!")
end

function net_soul.evolutionResult_delegate(code, soul)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.evolutionResult(code, soul)
end

function net_soul.activeTalentResult(code, soul)
	warning("please override this function -> net_soul.activeTalentResult!")
end

function net_soul.activeTalentResult_delegate(code, soul)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.activeTalentResult(code, soul)
end

function net_soul.activeTalentGroupResult(code, soul)
	warning("please override this function -> net_soul.activeTalentGroupResult!")
end

function net_soul.activeTalentGroupResult_delegate(code, soul)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.activeTalentGroupResult(code, soul)
end

function net_soul.unlockSkillGroupResult(code)
	warning("please override this function -> net_soul.unlockSkillGroupResult!")
end

function net_soul.unlockSkillGroupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.unlockSkillGroupResult(code)
end

function net_soul.activationSkillStrengthenResult(code)
	warning("please override this function -> net_soul.activationSkillStrengthenResult!")
end

function net_soul.activationSkillStrengthenResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.activationSkillStrengthenResult(code)
end

function net_soul.notifySoulMood(soulCid, oldMood, nowMood, type)
	warning("please override this function -> net_soul.notifySoulMood!")
end

function net_soul.notifySoulMood_delegate(soulCid, oldMood, nowMood, type)
	net_soul.notifySoulMood(soulCid, oldMood, nowMood, type)
end

function net_soul.updateSoul(soul)
	warning("please override this function -> net_soul.updateSoul!")
end

function net_soul.updateSoul_delegate(soul)
	net_soul.updateSoul(soul)
end

function net_soul.notifyRepetitionUnlockSoul(soulCid)
	warning("please override this function -> net_soul.notifyRepetitionUnlockSoul!")
end

function net_soul.notifyRepetitionUnlockSoul_delegate(soulCid)
	net_soul.notifyRepetitionUnlockSoul(soulCid)
end

function net_soul.activeSpecialSpirit(soulCid, id)
	local success = LuaCodeInterface.Send(4619, soulCid, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_soul.activeSpecialSpiritResult(code, soulCid, id)
	warning("please override this function -> net_soul.activeSpecialSpiritResult!")
end

function net_soul.activeSpecialSpiritResult_delegate(code, soulCid, id)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_soul.activeSpecialSpiritResult(code, soulCid, id)
end

net_rpgMaze = {}

function net_rpgMaze.notifyTicketsUpdate(value)
	warning("please override this function -> net_rpgMaze.notifyTicketsUpdate!")
end

function net_rpgMaze.notifyTicketsUpdate_delegate(value)
	net_rpgMaze.notifyTicketsUpdate(value)
end

function net_rpgMaze.challengeBoss(formationId, bossCid, isFree)
	local success = LuaCodeInterface.Send(4703, formationId, bossCid, isFree)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_rpgMaze.challengeExBoss(formationId)
	local success = LuaCodeInterface.Send(4704, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_rpgMaze.challengeBossResult(code)
	warning("please override this function -> net_rpgMaze.challengeBossResult!")
end

function net_rpgMaze.challengeBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_rpgMaze.challengeBossResult(code)
end

function net_rpgMaze.challengeExBossResult(code)
	warning("please override this function -> net_rpgMaze.challengeExBossResult!")
end

function net_rpgMaze.challengeExBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_rpgMaze.challengeExBossResult(code)
end

function net_rpgMaze.notifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
	warning("please override this function -> net_rpgMaze.notifyChallengeBossComplete!")
end

function net_rpgMaze.notifyChallengeBossComplete_delegate(win, bossCid, getItems, openExBoss)
	net_rpgMaze.notifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
end

function net_rpgMaze.notifyChallengeExBossComplete(win, getItems, dmgRecords)
	warning("please override this function -> net_rpgMaze.notifyChallengeExBossComplete!")
end

function net_rpgMaze.notifyChallengeExBossComplete_delegate(win, getItems, dmgRecords)
	net_rpgMaze.notifyChallengeExBossComplete(win, getItems, dmgRecords)
end

function net_rpgMaze.enterRPGMaze(mazeCid)
	local success = LuaCodeInterface.Send(4709, mazeCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_rpgMaze.enterRPGMazeResult(code, maze)
	warning("please override this function -> net_rpgMaze.enterRPGMazeResult!")
end

function net_rpgMaze.enterRPGMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_rpgMaze.enterRPGMazeResult(code, maze)
end

net_battlePasses = {}

function net_battlePasses.getRewards(rewardsIdList)
	local success = LuaCodeInterface.Send(4802, rewardsIdList)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_battlePasses.getLastSeasonRewards()
	local success = LuaCodeInterface.Send(4803)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_battlePasses.getRewardsResult(code)
	warning("please override this function -> net_battlePasses.getRewardsResult!")
end

function net_battlePasses.getRewardsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_battlePasses.getRewardsResult(code)
end

function net_battlePasses.getLastSeasonRewardsResult(code)
	warning("please override this function -> net_battlePasses.getLastSeasonRewardsResult!")
end

function net_battlePasses.getLastSeasonRewardsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_battlePasses.getLastSeasonRewardsResult(code)
end

net_operationsEvent = {}

function net_operationsEvent.notifyAllEventStatus(list)
	warning("please override this function -> net_operationsEvent.notifyAllEventStatus!")
end

function net_operationsEvent.notifyAllEventStatus_delegate(list)
	net_operationsEvent.notifyAllEventStatus(list)
end

function net_operationsEvent.notifyOperationsEventData(pod)
	warning("please override this function -> net_operationsEvent.notifyOperationsEventData!")
end

function net_operationsEvent.notifyOperationsEventData_delegate(pod)
	net_operationsEvent.notifyOperationsEventData(pod)
end

net_operationsGroupPurchase = {}

function net_operationsGroupPurchase.groupPurchaseBuy(eventId, idx, num)
	local success = LuaCodeInterface.Send(5002, eventId, idx, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsGroupPurchase.groupPurchaseBuyResult(code, list, pod)
	warning("please override this function -> net_operationsGroupPurchase.groupPurchaseBuyResult!")
end

function net_operationsGroupPurchase.groupPurchaseBuyResult_delegate(code, list, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsGroupPurchase.groupPurchaseBuyResult(code, list, pod)
end

net_operationsImagePuzzle = {}

function net_operationsImagePuzzle.imagePuzzleUnlock(eventId)
	local success = LuaCodeInterface.Send(5102, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsImagePuzzle.imagePuzzleGetUnlockReward(eventId, idx)
	local success = LuaCodeInterface.Send(5103, eventId, idx)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsImagePuzzle.imagePuzzleGetReward(eventId, rewadId)
	local success = LuaCodeInterface.Send(5104, eventId, rewadId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsImagePuzzle.imagePuzzleUnlockResult(code, pod)
	warning("please override this function -> net_operationsImagePuzzle.imagePuzzleUnlockResult!")
end

function net_operationsImagePuzzle.imagePuzzleUnlockResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsImagePuzzle.imagePuzzleUnlockResult(code, pod)
end

function net_operationsImagePuzzle.imagePuzzleGetUnlockRewardResult(code, list, pod)
	warning("please override this function -> net_operationsImagePuzzle.imagePuzzleGetUnlockRewardResult!")
end

function net_operationsImagePuzzle.imagePuzzleGetUnlockRewardResult_delegate(code, list, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsImagePuzzle.imagePuzzleGetUnlockRewardResult(code, list, pod)
end

function net_operationsImagePuzzle.imagePuzzleGetRewardResult(code, list, pod)
	warning("please override this function -> net_operationsImagePuzzle.imagePuzzleGetRewardResult!")
end

function net_operationsImagePuzzle.imagePuzzleGetRewardResult_delegate(code, list, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsImagePuzzle.imagePuzzleGetRewardResult(code, list, pod)
end

net_operationsMagicMuseum = {}

function net_operationsMagicMuseum.attack(eventId, museumId, formationId)
	local success = LuaCodeInterface.Send(5202, eventId, museumId, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsMagicMuseum.attackResult(code)
	warning("please override this function -> net_operationsMagicMuseum.attackResult!")
end

function net_operationsMagicMuseum.attackResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsMagicMuseum.attackResult(code)
end

function net_operationsMagicMuseum.notifyMuseumAttackRet(eventId, museumId, win, showList)
	warning("please override this function -> net_operationsMagicMuseum.notifyMuseumAttackRet!")
end

function net_operationsMagicMuseum.notifyMuseumAttackRet_delegate(eventId, museumId, win, showList)
	net_operationsMagicMuseum.notifyMuseumAttackRet(eventId, museumId, win, showList)
end

net_operationsNewCharacter = {}

function net_operationsNewCharacter.newCharacterUnlock(eventId, type)
	local success = LuaCodeInterface.Send(5302, eventId, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsNewCharacter.bingoLog(eventId, start)
	local success = LuaCodeInterface.Send(5303, eventId, start)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsNewCharacter.newCharacterStory(eventId, storyId)
	local success = LuaCodeInterface.Send(5304, eventId, storyId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsNewCharacter.newCharacterUnlockResult(code, cardList, bingoIdList, showList)
	warning("please override this function -> net_operationsNewCharacter.newCharacterUnlockResult!")
end

function net_operationsNewCharacter.newCharacterUnlockResult_delegate(code, cardList, bingoIdList, showList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsNewCharacter.newCharacterUnlockResult(code, cardList, bingoIdList, showList)
end

function net_operationsNewCharacter.bingoLogResult(code, podList)
	warning("please override this function -> net_operationsNewCharacter.bingoLogResult!")
end

function net_operationsNewCharacter.bingoLogResult_delegate(code, podList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsNewCharacter.bingoLogResult(code, podList)
end

function net_operationsNewCharacter.newCharacterStoryResult(code)
	warning("please override this function -> net_operationsNewCharacter.newCharacterStoryResult!")
end

function net_operationsNewCharacter.newCharacterStoryResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsNewCharacter.newCharacterStoryResult(code)
end

function net_operationsNewCharacter.notifyNewCharacterStoryFinished(eventId, storyId, list)
	warning("please override this function -> net_operationsNewCharacter.notifyNewCharacterStoryFinished!")
end

function net_operationsNewCharacter.notifyNewCharacterStoryFinished_delegate(eventId, storyId, list)
	net_operationsNewCharacter.notifyNewCharacterStoryFinished(eventId, storyId, list)
end

net_operationsGachaPool = {}

function net_operationsGachaPool.draw(eventId)
	local success = LuaCodeInterface.Send(5402, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsGachaPool.drawResult(code, awardsId, list, pod)
	warning("please override this function -> net_operationsGachaPool.drawResult!")
end

function net_operationsGachaPool.drawResult_delegate(code, awardsId, list, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsGachaPool.drawResult(code, awardsId, list, pod)
end

function net_operationsGachaPool.refresh(eventId)
	local success = LuaCodeInterface.Send(5404, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsGachaPool.refreshResult(code, pod)
	warning("please override this function -> net_operationsGachaPool.refreshResult!")
end

function net_operationsGachaPool.refreshResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsGachaPool.refreshResult(code, pod)
end

net_operationsDoubleFight = {}

function net_operationsDoubleFight.fight(eventId, step, index, formationId)
	local success = LuaCodeInterface.Send(5502, eventId, step, index, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsDoubleFight.getRewards(eventId, step, indexs)
	local success = LuaCodeInterface.Send(5503, eventId, step, indexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsDoubleFight.fightResult(code)
	warning("please override this function -> net_operationsDoubleFight.fightResult!")
end

function net_operationsDoubleFight.fightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsDoubleFight.fightResult(code)
end

function net_operationsDoubleFight.getRewardsResult(code, items, eventId, step, indexs)
	warning("please override this function -> net_operationsDoubleFight.getRewardsResult!")
end

function net_operationsDoubleFight.getRewardsResult_delegate(code, items, eventId, step, indexs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsDoubleFight.getRewardsResult(code, items, eventId, step, indexs)
end

function net_operationsDoubleFight.notifyFightComplete(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round)
	warning("please override this function -> net_operationsDoubleFight.notifyFightComplete!")
end

function net_operationsDoubleFight.notifyFightComplete_delegate(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round)
	net_operationsDoubleFight.notifyFightComplete(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round)
end

function net_operationsDoubleFight.notifyUpdateDoubleFightStepPOD(eventId, doubleFightStepPOD)
	warning("please override this function -> net_operationsDoubleFight.notifyUpdateDoubleFightStepPOD!")
end

function net_operationsDoubleFight.notifyUpdateDoubleFightStepPOD_delegate(eventId, doubleFightStepPOD)
	net_operationsDoubleFight.notifyUpdateDoubleFightStepPOD(eventId, doubleFightStepPOD)
end

net_lunaBattleLine = {}

function net_lunaBattleLine.garrison(zoneId, soulPrefabId)
	local success = LuaCodeInterface.Send(5602, zoneId, soulPrefabId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.getAssists(zoneId)
	local success = LuaCodeInterface.Send(5603, zoneId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.refreshAssist(zoneId)
	local success = LuaCodeInterface.Send(5604, zoneId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.getStrengthenSoulPrefab(zoneId)
	local success = LuaCodeInterface.Send(5605, zoneId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.garrisonResult(code, zoneId, soulPrefabId, garrison)
	warning("please override this function -> net_lunaBattleLine.garrisonResult!")
end

function net_lunaBattleLine.garrisonResult_delegate(code, zoneId, soulPrefabId, garrison)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.garrisonResult(code, zoneId, soulPrefabId, garrison)
end

function net_lunaBattleLine.getAssistsResult(code, zoneId, assistUnits)
	warning("please override this function -> net_lunaBattleLine.getAssistsResult!")
end

function net_lunaBattleLine.getAssistsResult_delegate(code, zoneId, assistUnits)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.getAssistsResult(code, zoneId, assistUnits)
end

function net_lunaBattleLine.refreshAssistResult(code, zoneId, assistUnits)
	warning("please override this function -> net_lunaBattleLine.refreshAssistResult!")
end

function net_lunaBattleLine.refreshAssistResult_delegate(code, zoneId, assistUnits)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.refreshAssistResult(code, zoneId, assistUnits)
end

function net_lunaBattleLine.getStrengthenSoulPrefabResult(code, zoneId, soulPrefabs)
	warning("please override this function -> net_lunaBattleLine.getStrengthenSoulPrefabResult!")
end

function net_lunaBattleLine.getStrengthenSoulPrefabResult_delegate(code, zoneId, soulPrefabs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.getStrengthenSoulPrefabResult(code, zoneId, soulPrefabs)
end

function net_lunaBattleLine.enterFortMaze(zoneId, formationID)
	local success = LuaCodeInterface.Send(5610, zoneId, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.enterSealMaze(zoneId, formationID, assistPid)
	local success = LuaCodeInterface.Send(5611, zoneId, formationID, assistPid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.enterStrengthenMaze(zoneId, soulPrefabs)
	local success = LuaCodeInterface.Send(5612, zoneId, soulPrefabs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_lunaBattleLine.enterFortMazeResult(code, zoneId, maze)
	warning("please override this function -> net_lunaBattleLine.enterFortMazeResult!")
end

function net_lunaBattleLine.enterFortMazeResult_delegate(code, zoneId, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.enterFortMazeResult(code, zoneId, maze)
end

function net_lunaBattleLine.enterSealMazeResult(code, zoneId, maze)
	warning("please override this function -> net_lunaBattleLine.enterSealMazeResult!")
end

function net_lunaBattleLine.enterSealMazeResult_delegate(code, zoneId, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.enterSealMazeResult(code, zoneId, maze)
end

function net_lunaBattleLine.enterStrengthenMazeResult(code, zoneId, maze)
	warning("please override this function -> net_lunaBattleLine.enterStrengthenMazeResult!")
end

function net_lunaBattleLine.enterStrengthenMazeResult_delegate(code, zoneId, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_lunaBattleLine.enterStrengthenMazeResult(code, zoneId, maze)
end

function net_lunaBattleLine.broadcastGarrison(zoneId, pname, soulCid)
	warning("please override this function -> net_lunaBattleLine.broadcastGarrison!")
end

function net_lunaBattleLine.broadcastGarrison_delegate(zoneId, pname, soulCid)
	net_lunaBattleLine.broadcastGarrison(zoneId, pname, soulCid)
end

net_operationsSpaceTreasure = {}

function net_operationsSpaceTreasure.explore(eventId, cid, num)
	local success = LuaCodeInterface.Send(5702, eventId, cid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsSpaceTreasure.exploreResult(code, eventId, cid, num, list)
	warning("please override this function -> net_operationsSpaceTreasure.exploreResult!")
end

function net_operationsSpaceTreasure.exploreResult_delegate(code, eventId, cid, num, list)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsSpaceTreasure.exploreResult(code, eventId, cid, num, list)
end

net_operationsFurnitureGache = {}

function net_operationsFurnitureGache.draw(eventId, type)
	local success = LuaCodeInterface.Send(5802, eventId, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsFurnitureGache.drawResult(code, showList)
	warning("please override this function -> net_operationsFurnitureGache.drawResult!")
end

function net_operationsFurnitureGache.drawResult_delegate(code, showList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsFurnitureGache.drawResult(code, showList)
end

net_dreamMap = {}

function net_dreamMap.enterMap(mapId)
	local success = LuaCodeInterface.Send(5902, mapId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dreamMap.resetMap()
	local success = LuaCodeInterface.Send(5903)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dreamMap.openCell(x, y)
	local success = LuaCodeInterface.Send(5904, x, y)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dreamMap.enterMapResult(code, mapData)
	warning("please override this function -> net_dreamMap.enterMapResult!")
end

function net_dreamMap.enterMapResult_delegate(code, mapData)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dreamMap.enterMapResult(code, mapData)
end

function net_dreamMap.resetMapResult(code, mapData)
	warning("please override this function -> net_dreamMap.resetMapResult!")
end

function net_dreamMap.resetMapResult_delegate(code, mapData)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dreamMap.resetMapResult(code, mapData)
end

function net_dreamMap.openCellResult(code, exectionItems, combo, movePoint, showCellX, showCellY)
	warning("please override this function -> net_dreamMap.openCellResult!")
end

function net_dreamMap.openCellResult_delegate(code, exectionItems, combo, movePoint, showCellX, showCellY)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dreamMap.openCellResult(code, exectionItems, combo, movePoint, showCellX, showCellY)
end

function net_dreamMap.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(5908, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dreamMap.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_dreamMap.selectDialogResult!")
end

function net_dreamMap.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dreamMap.selectDialogResult(code, nextDialogCid)
end

function net_dreamMap.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_dreamMap.notifyOpenDialog!")
end

function net_dreamMap.notifyOpenDialog_delegate(dialogCid)
	net_dreamMap.notifyOpenDialog(dialogCid)
end

function net_dreamMap.markCell(x, y, markType)
	local success = LuaCodeInterface.Send(5911, x, y, markType)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dreamMap.markCellResult(code, x, y, markType)
	warning("please override this function -> net_dreamMap.markCellResult!")
end

function net_dreamMap.markCellResult_delegate(code, x, y, markType)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dreamMap.markCellResult(code, x, y, markType)
end

net_operationsPanda = {}

function net_operationsPanda.action(actionType)
	local success = LuaCodeInterface.Send(6002, actionType)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsPanda.getGift(giftId)
	local success = LuaCodeInterface.Send(6003, giftId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsPanda.enterBambooForest()
	local success = LuaCodeInterface.Send(6004)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsPanda.explore()
	local success = LuaCodeInterface.Send(6005)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsPanda.doEvent(eventId, params)
	local success = LuaCodeInterface.Send(6006, eventId, params)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsPanda.actionResult(code, actionType, addFavor, favorNum, maxFavorNum, getItems)
	warning("please override this function -> net_operationsPanda.actionResult!")
end

function net_operationsPanda.actionResult_delegate(code, actionType, addFavor, favorNum, maxFavorNum, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsPanda.actionResult(code, actionType, addFavor, favorNum, maxFavorNum, getItems)
end

function net_operationsPanda.getGiftResult(code, giftId, itemShows)
	warning("please override this function -> net_operationsPanda.getGiftResult!")
end

function net_operationsPanda.getGiftResult_delegate(code, giftId, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsPanda.getGiftResult(code, giftId, itemShows)
end

function net_operationsPanda.enterBambooForestResult(code, events, currDialog)
	warning("please override this function -> net_operationsPanda.enterBambooForestResult!")
end

function net_operationsPanda.enterBambooForestResult_delegate(code, events, currDialog)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsPanda.enterBambooForestResult(code, events, currDialog)
end

function net_operationsPanda.exploreResult(code, events)
	warning("please override this function -> net_operationsPanda.exploreResult!")
end

function net_operationsPanda.exploreResult_delegate(code, events)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsPanda.exploreResult(code, events)
end

function net_operationsPanda.doEventResult(code, eventId, params)
	warning("please override this function -> net_operationsPanda.doEventResult!")
end

function net_operationsPanda.doEventResult_delegate(code, eventId, params)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsPanda.doEventResult(code, eventId, params)
end

function net_operationsPanda.notifyCompleteEvent(eventId, itemShows)
	warning("please override this function -> net_operationsPanda.notifyCompleteEvent!")
end

function net_operationsPanda.notifyCompleteEvent_delegate(eventId, itemShows)
	net_operationsPanda.notifyCompleteEvent(eventId, itemShows)
end

function net_operationsPanda.notifyFightComplete(eventId, win, itemShows)
	warning("please override this function -> net_operationsPanda.notifyFightComplete!")
end

function net_operationsPanda.notifyFightComplete_delegate(eventId, win, itemShows)
	net_operationsPanda.notifyFightComplete(eventId, win, itemShows)
end

function net_operationsPanda.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(6014, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsPanda.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_operationsPanda.selectDialogResult!")
end

function net_operationsPanda.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsPanda.selectDialogResult(code, nextDialogCid)
end

function net_operationsPanda.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_operationsPanda.notifyOpenDialog!")
end

function net_operationsPanda.notifyOpenDialog_delegate(dialogCid)
	net_operationsPanda.notifyOpenDialog(dialogCid)
end

net_operationsTreasureHunt = {}

function net_operationsTreasureHunt.exchangeTreasureGift(eventId, giftId)
	local success = LuaCodeInterface.Send(6102, eventId, giftId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsTreasureHunt.exchangeTreasureGiftResult(code, list)
	warning("please override this function -> net_operationsTreasureHunt.exchangeTreasureGiftResult!")
end

function net_operationsTreasureHunt.exchangeTreasureGiftResult_delegate(code, list)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsTreasureHunt.exchangeTreasureGiftResult(code, list)
end

net_operationsVote = {}

function net_operationsVote.vote(eventId, voteId)
	local success = LuaCodeInterface.Send(6202, eventId, voteId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsVote.voteResult(code, eventId, voteId, getItems)
	warning("please override this function -> net_operationsVote.voteResult!")
end

function net_operationsVote.voteResult_delegate(code, eventId, voteId, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsVote.voteResult(code, eventId, voteId, getItems)
end

net_operationsHelpNewbies = {}

function net_operationsHelpNewbies.submitInviteCode(eventId, inviteCode)
	local success = LuaCodeInterface.Send(6302, eventId, inviteCode)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsHelpNewbies.confirmTask(eventId, eventTaskId)
	local success = LuaCodeInterface.Send(6303, eventId, eventTaskId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsHelpNewbies.submitInviteCodeResult(code)
	warning("please override this function -> net_operationsHelpNewbies.submitInviteCodeResult!")
end

function net_operationsHelpNewbies.submitInviteCodeResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsHelpNewbies.submitInviteCodeResult(code)
end

function net_operationsHelpNewbies.confirmTaskResult(code, items)
	warning("please override this function -> net_operationsHelpNewbies.confirmTaskResult!")
end

function net_operationsHelpNewbies.confirmTaskResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsHelpNewbies.confirmTaskResult(code, items)
end

net_taleChallenge = {}

function net_taleChallenge.triggerChallengeStory(nodeId)
	local success = LuaCodeInterface.Send(6402, nodeId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_taleChallenge.triggerChallengeFight(nodeId, formationId)
	local success = LuaCodeInterface.Send(6403, nodeId, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_taleChallenge.triggerChallengeBoss(formationId)
	local success = LuaCodeInterface.Send(6404, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_taleChallenge.triggerChallengeStoryResult(code)
	warning("please override this function -> net_taleChallenge.triggerChallengeStoryResult!")
end

function net_taleChallenge.triggerChallengeStoryResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_taleChallenge.triggerChallengeStoryResult(code)
end

function net_taleChallenge.triggerChallengeFightResult(code)
	warning("please override this function -> net_taleChallenge.triggerChallengeFightResult!")
end

function net_taleChallenge.triggerChallengeFightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_taleChallenge.triggerChallengeFightResult(code)
end

function net_taleChallenge.triggerChallengeBossResult(code)
	warning("please override this function -> net_taleChallenge.triggerChallengeBossResult!")
end

function net_taleChallenge.triggerChallengeBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_taleChallenge.triggerChallengeBossResult(code)
end

function net_taleChallenge.notifyTaleChallengeStoryFinished(nodeId, list)
	warning("please override this function -> net_taleChallenge.notifyTaleChallengeStoryFinished!")
end

function net_taleChallenge.notifyTaleChallengeStoryFinished_delegate(nodeId, list)
	net_taleChallenge.notifyTaleChallengeStoryFinished(nodeId, list)
end

function net_taleChallenge.notifyChallengeFightRet(nodeId, win, showList)
	warning("please override this function -> net_taleChallenge.notifyChallengeFightRet!")
end

function net_taleChallenge.notifyChallengeFightRet_delegate(nodeId, win, showList)
	net_taleChallenge.notifyChallengeFightRet(nodeId, win, showList)
end

function net_taleChallenge.notifyChallengeBossRet(win, showList)
	warning("please override this function -> net_taleChallenge.notifyChallengeBossRet!")
end

function net_taleChallenge.notifyChallengeBossRet_delegate(win, showList)
	net_taleChallenge.notifyChallengeBossRet(win, showList)
end

function net_taleChallenge.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(6411, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_taleChallenge.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_taleChallenge.selectDialogResult!")
end

function net_taleChallenge.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_taleChallenge.selectDialogResult(code, nextDialogCid)
end

function net_taleChallenge.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_taleChallenge.notifyOpenDialog!")
end

function net_taleChallenge.notifyOpenDialog_delegate(dialogCid)
	net_taleChallenge.notifyOpenDialog(dialogCid)
end

function net_taleChallenge.draw(id, count)
	local success = LuaCodeInterface.Send(6414, id, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_taleChallenge.drawResult(code, id, count, rewards, drawInfo)
	warning("please override this function -> net_taleChallenge.drawResult!")
end

function net_taleChallenge.drawResult_delegate(code, id, count, rewards, drawInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_taleChallenge.drawResult(code, id, count, rewards, drawInfo)
end

net_dualTeamExplore = {}

function net_dualTeamExplore.challengeBoss(formationId, bossCid, isFree)
	local success = LuaCodeInterface.Send(6502, formationId, bossCid, isFree)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.challengeExBoss(formationId, exBossIndex)
	local success = LuaCodeInterface.Send(6503, formationId, exBossIndex)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.challengeBossResult(code)
	warning("please override this function -> net_dualTeamExplore.challengeBossResult!")
end

function net_dualTeamExplore.challengeBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.challengeBossResult(code)
end

function net_dualTeamExplore.challengeExBossResult(code)
	warning("please override this function -> net_dualTeamExplore.challengeExBossResult!")
end

function net_dualTeamExplore.challengeExBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.challengeExBossResult(code)
end

function net_dualTeamExplore.notifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
	warning("please override this function -> net_dualTeamExplore.notifyChallengeBossComplete!")
end

function net_dualTeamExplore.notifyChallengeBossComplete_delegate(win, bossCid, getItems, openExBoss)
	net_dualTeamExplore.notifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
end

function net_dualTeamExplore.notifyChallengeExBossComplete(win, getItems, dmgRecords)
	warning("please override this function -> net_dualTeamExplore.notifyChallengeExBossComplete!")
end

function net_dualTeamExplore.notifyChallengeExBossComplete_delegate(win, getItems, dmgRecords)
	net_dualTeamExplore.notifyChallengeExBossComplete(win, getItems, dmgRecords)
end

function net_dualTeamExplore.notifyTicketsUpdate(value)
	warning("please override this function -> net_dualTeamExplore.notifyTicketsUpdate!")
end

function net_dualTeamExplore.notifyTicketsUpdate_delegate(value)
	net_dualTeamExplore.notifyTicketsUpdate(value)
end

function net_dualTeamExplore.enterLevel(levelCid, formationId1, formationId2, easyMode)
	local success = LuaCodeInterface.Send(6509, levelCid, formationId1, formationId2, easyMode)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.move(teamId, nodeId)
	local success = LuaCodeInterface.Send(6510, teamId, nodeId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.enterLevelResult(code, levelPOD)
	warning("please override this function -> net_dualTeamExplore.enterLevelResult!")
end

function net_dualTeamExplore.enterLevelResult_delegate(code, levelPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.enterLevelResult(code, levelPOD)
end

function net_dualTeamExplore.moveResult(code, teamId, nodeId, isStop)
	warning("please override this function -> net_dualTeamExplore.moveResult!")
end

function net_dualTeamExplore.moveResult_delegate(code, teamId, nodeId, isStop)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.moveResult(code, teamId, nodeId, isStop)
end

function net_dualTeamExplore.notifyExecution(serviceId, executionId)
	warning("please override this function -> net_dualTeamExplore.notifyExecution!")
end

function net_dualTeamExplore.notifyExecution_delegate(serviceId, executionId)
	net_dualTeamExplore.notifyExecution(serviceId, executionId)
end

function net_dualTeamExplore.notifyShowGetItems(serviceId, executionId, itemShows)
	warning("please override this function -> net_dualTeamExplore.notifyShowGetItems!")
end

function net_dualTeamExplore.notifyShowGetItems_delegate(serviceId, executionId, itemShows)
	net_dualTeamExplore.notifyShowGetItems(serviceId, executionId, itemShows)
end

function net_dualTeamExplore.notifyNodeUpdate(node)
	warning("please override this function -> net_dualTeamExplore.notifyNodeUpdate!")
end

function net_dualTeamExplore.notifyNodeUpdate_delegate(node)
	net_dualTeamExplore.notifyNodeUpdate(node)
end

function net_dualTeamExplore.notifyTeamStatus(teamId, stop)
	warning("please override this function -> net_dualTeamExplore.notifyTeamStatus!")
end

function net_dualTeamExplore.notifyTeamStatus_delegate(teamId, stop)
	net_dualTeamExplore.notifyTeamStatus(teamId, stop)
end

function net_dualTeamExplore.notifyLevelStatus(separate)
	warning("please override this function -> net_dualTeamExplore.notifyLevelStatus!")
end

function net_dualTeamExplore.notifyLevelStatus_delegate(separate)
	net_dualTeamExplore.notifyLevelStatus(separate)
end

function net_dualTeamExplore.notifyTeamMemberAttr(soulCid, attr, power)
	warning("please override this function -> net_dualTeamExplore.notifyTeamMemberAttr!")
end

function net_dualTeamExplore.notifyTeamMemberAttr_delegate(soulCid, attr, power)
	net_dualTeamExplore.notifyTeamMemberAttr(soulCid, attr, power)
end

function net_dualTeamExplore.notifyLevelSettlement(success)
	warning("please override this function -> net_dualTeamExplore.notifyLevelSettlement!")
end

function net_dualTeamExplore.notifyLevelSettlement_delegate(success)
	net_dualTeamExplore.notifyLevelSettlement(success)
end

function net_dualTeamExplore.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(6520, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_dualTeamExplore.selectDialogResult!")
end

function net_dualTeamExplore.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.selectDialogResult(code, nextDialogCid)
end

function net_dualTeamExplore.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_dualTeamExplore.notifyOpenDialog!")
end

function net_dualTeamExplore.notifyOpenDialog_delegate(dialogCid)
	net_dualTeamExplore.notifyOpenDialog(dialogCid)
end

function net_dualTeamExplore.fight(teamId)
	local success = LuaCodeInterface.Send(6523, teamId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.fightResult(code)
	warning("please override this function -> net_dualTeamExplore.fightResult!")
end

function net_dualTeamExplore.fightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.fightResult(code)
end

function net_dualTeamExplore.notifyFightComplete(win, teamId, team1, team2)
	warning("please override this function -> net_dualTeamExplore.notifyFightComplete!")
end

function net_dualTeamExplore.notifyFightComplete_delegate(win, teamId, team1, team2)
	net_dualTeamExplore.notifyFightComplete(win, teamId, team1, team2)
end

function net_dualTeamExplore.enterDualTeamMaze(teamId)
	local success = LuaCodeInterface.Send(6526, teamId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.enterDualTeamMazeResult(code, maze)
	warning("please override this function -> net_dualTeamExplore.enterDualTeamMazeResult!")
end

function net_dualTeamExplore.enterDualTeamMazeResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.enterDualTeamMazeResult(code, maze)
end

function net_dualTeamExplore.plotLevel(levelCid, easyMode)
	local success = LuaCodeInterface.Send(6528, levelCid, easyMode)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.plotLevelResult(code)
	warning("please override this function -> net_dualTeamExplore.plotLevelResult!")
end

function net_dualTeamExplore.plotLevelResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.plotLevelResult(code)
end

function net_dualTeamExplore.giveup()
	local success = LuaCodeInterface.Send(6530)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.giveupResult(code)
	warning("please override this function -> net_dualTeamExplore.giveupResult!")
end

function net_dualTeamExplore.giveupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.giveupResult(code)
end

function net_dualTeamExplore.numberInput(type)
	local success = LuaCodeInterface.Send(6532, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.numberInputResult(code, type)
	warning("please override this function -> net_dualTeamExplore.numberInputResult!")
end

function net_dualTeamExplore.numberInputResult_delegate(code, type)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.numberInputResult(code, type)
end

function net_dualTeamExplore.revive()
	local success = LuaCodeInterface.Send(6534)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.reviveResult(code, teamId, team)
	warning("please override this function -> net_dualTeamExplore.reviveResult!")
end

function net_dualTeamExplore.reviveResult_delegate(code, teamId, team)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.reviveResult(code, teamId, team)
end

function net_dualTeamExplore.useItem(itemCid)
	local success = LuaCodeInterface.Send(6536, itemCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dualTeamExplore.useItemResult(code)
	warning("please override this function -> net_dualTeamExplore.useItemResult!")
end

function net_dualTeamExplore.useItemResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dualTeamExplore.useItemResult(code)
end

function net_dualTeamExplore.notifyFight(id)
	warning("please override this function -> net_dualTeamExplore.notifyFight!")
end

function net_dualTeamExplore.notifyFight_delegate(id)
	net_dualTeamExplore.notifyFight(id)
end

net_magicTower = {}

function net_magicTower.enterMap(mapId)
	local success = LuaCodeInterface.Send(6602, mapId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_magicTower.giveup()
	local success = LuaCodeInterface.Send(6603)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_magicTower.move(cellId)
	local success = LuaCodeInterface.Send(6604, cellId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_magicTower.enterMapResult(code, mapData)
	warning("please override this function -> net_magicTower.enterMapResult!")
end

function net_magicTower.enterMapResult_delegate(code, mapData)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_magicTower.enterMapResult(code, mapData)
end

function net_magicTower.giveupResult(code)
	warning("please override this function -> net_magicTower.giveupResult!")
end

function net_magicTower.giveupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_magicTower.giveupResult(code)
end

function net_magicTower.moveResult(code, cellId)
	warning("please override this function -> net_magicTower.moveResult!")
end

function net_magicTower.moveResult_delegate(code, cellId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_magicTower.moveResult(code, cellId)
end

function net_magicTower.notifyExecution(exectionItem)
	warning("please override this function -> net_magicTower.notifyExecution!")
end

function net_magicTower.notifyExecution_delegate(exectionItem)
	net_magicTower.notifyExecution(exectionItem)
end

function net_magicTower.notifySettlement(success)
	warning("please override this function -> net_magicTower.notifySettlement!")
end

function net_magicTower.notifySettlement_delegate(success)
	net_magicTower.notifySettlement(success)
end

function net_magicTower.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(6610, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_magicTower.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_magicTower.selectDialogResult!")
end

function net_magicTower.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_magicTower.selectDialogResult(code, nextDialogCid)
end

function net_magicTower.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_magicTower.notifyOpenDialog!")
end

function net_magicTower.notifyOpenDialog_delegate(dialogCid)
	net_magicTower.notifyOpenDialog(dialogCid)
end

net_fishing = {}

function net_fishing.fishing(rodId, baitItemId)
	local success = LuaCodeInterface.Send(6702, rodId, baitItemId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.fishingConfirm(suc)
	local success = LuaCodeInterface.Send(6703, suc)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.illegalFishing(toolId, num)
	local success = LuaCodeInterface.Send(6704, toolId, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.fishingResult(code, fishId, baitId, rodId)
	warning("please override this function -> net_fishing.fishingResult!")
end

function net_fishing.fishingResult_delegate(code, fishId, baitId, rodId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.fishingResult(code, fishId, baitId, rodId)
end

function net_fishing.fishingConfirmResult(code, pod)
	warning("please override this function -> net_fishing.fishingConfirmResult!")
end

function net_fishing.fishingConfirmResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.fishingConfirmResult(code, pod)
end

function net_fishing.illegalFishingResult(code, podList)
	warning("please override this function -> net_fishing.illegalFishingResult!")
end

function net_fishing.illegalFishingResult_delegate(code, podList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.illegalFishingResult(code, podList)
end

function net_fishing.notifyFishSpecimen(newSpecimenList)
	warning("please override this function -> net_fishing.notifyFishSpecimen!")
end

function net_fishing.notifyFishSpecimen_delegate(newSpecimenList)
	net_fishing.notifyFishSpecimen(newSpecimenList)
end

function net_fishing.exchangeFish(cid, num)
	local success = LuaCodeInterface.Send(6709, cid, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.exchangeFishResult(code, podList)
	warning("please override this function -> net_fishing.exchangeFishResult!")
end

function net_fishing.exchangeFishResult_delegate(code, podList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.exchangeFishResult(code, podList)
end

function net_fishing.exchangeFishByType(type)
	local success = LuaCodeInterface.Send(6711, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.exchangeFishByTypeResult(code, podList)
	warning("please override this function -> net_fishing.exchangeFishByTypeResult!")
end

function net_fishing.exchangeFishByTypeResult_delegate(code, podList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.exchangeFishByTypeResult(code, podList)
end

function net_fishing.automaticFishing(rodI, baitItemId)
	local success = LuaCodeInterface.Send(6713, rodI, baitItemId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.drawRewards()
	local success = LuaCodeInterface.Send(6714)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishing.automaticFishingResult(code, time)
	warning("please override this function -> net_fishing.automaticFishingResult!")
end

function net_fishing.automaticFishingResult_delegate(code, time)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.automaticFishingResult(code, time)
end

function net_fishing.drawRewardsResult(code, podList)
	warning("please override this function -> net_fishing.drawRewardsResult!")
end

function net_fishing.drawRewardsResult_delegate(code, podList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishing.drawRewardsResult(code, podList)
end

function net_fishing.notifyFishOpen(fishingData)
	warning("please override this function -> net_fishing.notifyFishOpen!")
end

function net_fishing.notifyFishOpen_delegate(fishingData)
	net_fishing.notifyFishOpen(fishingData)
end

net_miniGalGame = {}

function net_miniGalGame.startNewGame()
	local success = LuaCodeInterface.Send(6802)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.loadGame(slotIdx)
	local success = LuaCodeInterface.Send(6803, slotIdx)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.saveGame(slotIdx)
	local success = LuaCodeInterface.Send(6804, slotIdx)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(6805, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.shopBuy(shopCfgId, num)
	local success = LuaCodeInterface.Send(6806, shopCfgId, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.itemUse(itemId, num)
	local success = LuaCodeInterface.Send(6807, itemId, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.submitMiniGameOver(type, gameId, status)
	local success = LuaCodeInterface.Send(6808, type, gameId, status)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.triggerEvent(eventId)
	local success = LuaCodeInterface.Send(6809, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.towerFight(towerMonsterId)
	local success = LuaCodeInterface.Send(6810, towerMonsterId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.callFromGirl(girl, status)
	local success = LuaCodeInterface.Send(6811, girl, status)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.startNewGameResult(code, pod)
	warning("please override this function -> net_miniGalGame.startNewGameResult!")
end

function net_miniGalGame.startNewGameResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.startNewGameResult(code, pod)
end

function net_miniGalGame.loadGameResult(code, pod)
	warning("please override this function -> net_miniGalGame.loadGameResult!")
end

function net_miniGalGame.loadGameResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.loadGameResult(code, pod)
end

function net_miniGalGame.saveGameResult(code)
	warning("please override this function -> net_miniGalGame.saveGameResult!")
end

function net_miniGalGame.saveGameResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.saveGameResult(code)
end

function net_miniGalGame.selectDialogResult(code, nextDialogId)
	warning("please override this function -> net_miniGalGame.selectDialogResult!")
end

function net_miniGalGame.selectDialogResult_delegate(code, nextDialogId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.selectDialogResult(code, nextDialogId)
end

function net_miniGalGame.shopBuyResult(code)
	warning("please override this function -> net_miniGalGame.shopBuyResult!")
end

function net_miniGalGame.shopBuyResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.shopBuyResult(code)
end

function net_miniGalGame.itemUseResult(code)
	warning("please override this function -> net_miniGalGame.itemUseResult!")
end

function net_miniGalGame.itemUseResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.itemUseResult(code)
end

function net_miniGalGame.submitMiniGameOverResult(code, rewards)
	warning("please override this function -> net_miniGalGame.submitMiniGameOverResult!")
end

function net_miniGalGame.submitMiniGameOverResult_delegate(code, rewards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.submitMiniGameOverResult(code, rewards)
end

function net_miniGalGame.triggerEventResult(code)
	warning("please override this function -> net_miniGalGame.triggerEventResult!")
end

function net_miniGalGame.triggerEventResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.triggerEventResult(code)
end

function net_miniGalGame.towerFightResult(code, towerMonsterId, fightStatus, rewards)
	warning("please override this function -> net_miniGalGame.towerFightResult!")
end

function net_miniGalGame.towerFightResult_delegate(code, towerMonsterId, fightStatus, rewards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.towerFightResult(code, towerMonsterId, fightStatus, rewards)
end

function net_miniGalGame.callFromGirlResult(code)
	warning("please override this function -> net_miniGalGame.callFromGirlResult!")
end

function net_miniGalGame.callFromGirlResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.callFromGirlResult(code)
end

function net_miniGalGame.notifyOpenDialog(dialogId, dynamicType, dynamicValue)
	warning("please override this function -> net_miniGalGame.notifyOpenDialog!")
end

function net_miniGalGame.notifyOpenDialog_delegate(dialogId, dynamicType, dynamicValue)
	net_miniGalGame.notifyOpenDialog(dialogId, dynamicType, dynamicValue)
end

function net_miniGalGame.notifyGalItemsStatus(items)
	warning("please override this function -> net_miniGalGame.notifyGalItemsStatus!")
end

function net_miniGalGame.notifyGalItemsStatus_delegate(items)
	net_miniGalGame.notifyGalItemsStatus(items)
end

function net_miniGalGame.notifyGalTaskFinish(taskId, rewards)
	warning("please override this function -> net_miniGalGame.notifyGalTaskFinish!")
end

function net_miniGalGame.notifyGalTaskFinish_delegate(taskId, rewards)
	net_miniGalGame.notifyGalTaskFinish(taskId, rewards)
end

function net_miniGalGame.notifyGalShop(shopRecord)
	warning("please override this function -> net_miniGalGame.notifyGalShop!")
end

function net_miniGalGame.notifyGalShop_delegate(shopRecord)
	net_miniGalGame.notifyGalShop(shopRecord)
end

function net_miniGalGame.notifyGalGirlsData(girls)
	warning("please override this function -> net_miniGalGame.notifyGalGirlsData!")
end

function net_miniGalGame.notifyGalGirlsData_delegate(girls)
	net_miniGalGame.notifyGalGirlsData(girls)
end

function net_miniGalGame.notifyGalBaseData(base)
	warning("please override this function -> net_miniGalGame.notifyGalBaseData!")
end

function net_miniGalGame.notifyGalBaseData_delegate(base)
	net_miniGalGame.notifyGalBaseData(base)
end

function net_miniGalGame.notifyGalMiniGameStart(type, gameId)
	warning("please override this function -> net_miniGalGame.notifyGalMiniGameStart!")
end

function net_miniGalGame.notifyGalMiniGameStart_delegate(type, gameId)
	net_miniGalGame.notifyGalMiniGameStart(type, gameId)
end

function net_miniGalGame.notifyFight(fightId, win, rewards)
	warning("please override this function -> net_miniGalGame.notifyFight!")
end

function net_miniGalGame.notifyFight_delegate(fightId, win, rewards)
	net_miniGalGame.notifyFight(fightId, win, rewards)
end

function net_miniGalGame.notifyUpdateSaveData(podList)
	warning("please override this function -> net_miniGalGame.notifyUpdateSaveData!")
end

function net_miniGalGame.notifyUpdateSaveData_delegate(podList)
	net_miniGalGame.notifyUpdateSaveData(podList)
end

function net_miniGalGame.notifyScheduleList(scheduleList)
	warning("please override this function -> net_miniGalGame.notifyScheduleList!")
end

function net_miniGalGame.notifyScheduleList_delegate(scheduleList)
	net_miniGalGame.notifyScheduleList(scheduleList)
end

function net_miniGalGame.notifyCallFromGirl(girl)
	warning("please override this function -> net_miniGalGame.notifyCallFromGirl!")
end

function net_miniGalGame.notifyCallFromGirl_delegate(girl)
	net_miniGalGame.notifyCallFromGirl(girl)
end

function net_miniGalGame.notifyEventTriggeredCount(eventCount)
	warning("please override this function -> net_miniGalGame.notifyEventTriggeredCount!")
end

function net_miniGalGame.notifyEventTriggeredCount_delegate(eventCount)
	net_miniGalGame.notifyEventTriggeredCount(eventCount)
end

function net_miniGalGame.notifyAchievementData(achievementData)
	warning("please override this function -> net_miniGalGame.notifyAchievementData!")
end

function net_miniGalGame.notifyAchievementData_delegate(achievementData)
	net_miniGalGame.notifyAchievementData(achievementData)
end

function net_miniGalGame.notifyLocalAchievementData(achievementData)
	warning("please override this function -> net_miniGalGame.notifyLocalAchievementData!")
end

function net_miniGalGame.notifyLocalAchievementData_delegate(achievementData)
	net_miniGalGame.notifyLocalAchievementData(achievementData)
end

function net_miniGalGame.notifyItemUsedCount(itemUsedCount)
	warning("please override this function -> net_miniGalGame.notifyItemUsedCount!")
end

function net_miniGalGame.notifyItemUsedCount_delegate(itemUsedCount)
	net_miniGalGame.notifyItemUsedCount(itemUsedCount)
end

function net_miniGalGame.notifyComplete(saveIdx, functionId)
	warning("please override this function -> net_miniGalGame.notifyComplete!")
end

function net_miniGalGame.notifyComplete_delegate(saveIdx, functionId)
	net_miniGalGame.notifyComplete(saveIdx, functionId)
end

function net_miniGalGame.sendMessage(messageId, girlId)
	local success = LuaCodeInterface.Send(6838, messageId, girlId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_miniGalGame.sendMessageResult(code, messageId, girlId)
	warning("please override this function -> net_miniGalGame.sendMessageResult!")
end

function net_miniGalGame.sendMessageResult_delegate(code, messageId, girlId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.sendMessageResult(code, messageId, girlId)
end

function net_miniGalGame.notifyMessageFromGirl(girlId, pod)
	warning("please override this function -> net_miniGalGame.notifyMessageFromGirl!")
end

function net_miniGalGame.notifyMessageFromGirl_delegate(girlId, pod)
	net_miniGalGame.notifyMessageFromGirl(girlId, pod)
end

function net_miniGalGame.notifyMessageGroupCount(MessageGroupCount)
	warning("please override this function -> net_miniGalGame.notifyMessageGroupCount!")
end

function net_miniGalGame.notifyMessageGroupCount_delegate(MessageGroupCount)
	net_miniGalGame.notifyMessageGroupCount(MessageGroupCount)
end

net_evilErosion = {}

function net_evilErosion.wearEquipment(soulPrelabId, equipmentId, pos)
	local success = LuaCodeInterface.Send(6902, soulPrelabId, equipmentId, pos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.dumpEquipment(soulPrelabId, equipmentId)
	local success = LuaCodeInterface.Send(6903, soulPrelabId, equipmentId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.exchangeEquipment(prefabId, idx1, idx2)
	local success = LuaCodeInterface.Send(6904, prefabId, idx1, idx2)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.upStarEquipment(equipmentId)
	local success = LuaCodeInterface.Send(6905, equipmentId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.decpEquipment(materialIds)
	local success = LuaCodeInterface.Send(6906, materialIds)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.changeFormationPos(prefabId, formationPos)
	local success = LuaCodeInterface.Send(6907, prefabId, formationPos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.changePosition(prefabId, pos)
	local success = LuaCodeInterface.Send(6908, prefabId, pos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.changeCustomSkills(prefabId, customSkills)
	local success = LuaCodeInterface.Send(6909, prefabId, customSkills)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.fight(levelCid)
	local success = LuaCodeInterface.Send(6910, levelCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.getDailySupply()
	local success = LuaCodeInterface.Send(6911)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_evilErosion.wearEquipmentResult(code)
	warning("please override this function -> net_evilErosion.wearEquipmentResult!")
end

function net_evilErosion.wearEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.wearEquipmentResult(code)
end

function net_evilErosion.dumpEquipmentResult(code)
	warning("please override this function -> net_evilErosion.dumpEquipmentResult!")
end

function net_evilErosion.dumpEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.dumpEquipmentResult(code)
end

function net_evilErosion.exchangeEquipmentResult(code)
	warning("please override this function -> net_evilErosion.exchangeEquipmentResult!")
end

function net_evilErosion.exchangeEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.exchangeEquipmentResult(code)
end

function net_evilErosion.upStarEquipmentResult(code)
	warning("please override this function -> net_evilErosion.upStarEquipmentResult!")
end

function net_evilErosion.upStarEquipmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.upStarEquipmentResult(code)
end

function net_evilErosion.decpEquipmentResult(code, getItems)
	warning("please override this function -> net_evilErosion.decpEquipmentResult!")
end

function net_evilErosion.decpEquipmentResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.decpEquipmentResult(code, getItems)
end

function net_evilErosion.changeFormationPosResult(code)
	warning("please override this function -> net_evilErosion.changeFormationPosResult!")
end

function net_evilErosion.changeFormationPosResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.changeFormationPosResult(code)
end

function net_evilErosion.changePositionResult(code)
	warning("please override this function -> net_evilErosion.changePositionResult!")
end

function net_evilErosion.changePositionResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.changePositionResult(code)
end

function net_evilErosion.changeCustomSkillsResult(code)
	warning("please override this function -> net_evilErosion.changeCustomSkillsResult!")
end

function net_evilErosion.changeCustomSkillsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.changeCustomSkillsResult(code)
end

function net_evilErosion.fightResult(code)
	warning("please override this function -> net_evilErosion.fightResult!")
end

function net_evilErosion.fightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.fightResult(code)
end

function net_evilErosion.getDailySupplyResult(code, getItems)
	warning("please override this function -> net_evilErosion.getDailySupplyResult!")
end

function net_evilErosion.getDailySupplyResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_evilErosion.getDailySupplyResult(code, getItems)
end

function net_evilErosion.notifyFightComplete(win, levelCid, dmgRecords, getItems, rating, ratinTime)
	warning("please override this function -> net_evilErosion.notifyFightComplete!")
end

function net_evilErosion.notifyFightComplete_delegate(win, levelCid, dmgRecords, getItems, rating, ratinTime)
	net_evilErosion.notifyFightComplete(win, levelCid, dmgRecords, getItems, rating, ratinTime)
end

function net_evilErosion.notifyUpdateSoulPrefab(pods)
	warning("please override this function -> net_evilErosion.notifyUpdateSoulPrefab!")
end

function net_evilErosion.notifyUpdateSoulPrefab_delegate(pods)
	net_evilErosion.notifyUpdateSoulPrefab(pods)
end

net_operationsTurntable = {}

function net_operationsTurntable.draw(eventId)
	local success = LuaCodeInterface.Send(7002, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsTurntable.drawResult(code, turntableId, uuid)
	warning("please override this function -> net_operationsTurntable.drawResult!")
end

function net_operationsTurntable.drawResult_delegate(code, turntableId, uuid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsTurntable.drawResult(code, turntableId, uuid)
end

net_abyssPlus = {}

function net_abyssPlus.enterLevel(levelCid, formationId)
	local success = LuaCodeInterface.Send(7102, levelCid, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_abyssPlus.challengeExBoss(formationId)
	local success = LuaCodeInterface.Send(7103, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_abyssPlus.enterLevelResult(code, maze)
	warning("please override this function -> net_abyssPlus.enterLevelResult!")
end

function net_abyssPlus.enterLevelResult_delegate(code, maze)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_abyssPlus.enterLevelResult(code, maze)
end

function net_abyssPlus.challengeExBossResult(code)
	warning("please override this function -> net_abyssPlus.challengeExBossResult!")
end

function net_abyssPlus.challengeExBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_abyssPlus.challengeExBossResult(code)
end

function net_abyssPlus.notifyChallengeExBossComplete(win, getItems, dmgRecords)
	warning("please override this function -> net_abyssPlus.notifyChallengeExBossComplete!")
end

function net_abyssPlus.notifyChallengeExBossComplete_delegate(win, getItems, dmgRecords)
	net_abyssPlus.notifyChallengeExBossComplete(win, getItems, dmgRecords)
end

function net_abyssPlus.useRune(runes)
	local success = LuaCodeInterface.Send(7107, runes)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_abyssPlus.useRuneResult(code)
	warning("please override this function -> net_abyssPlus.useRuneResult!")
end

function net_abyssPlus.useRuneResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_abyssPlus.useRuneResult(code)
end

net_operationsLimitTurntable = {}

function net_operationsLimitTurntable.draw(eventId, type)
	local success = LuaCodeInterface.Send(7202, eventId, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsLimitTurntable.getHistory(eventId)
	local success = LuaCodeInterface.Send(7203, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsLimitTurntable.drawResult(code, awardsId, list, pod)
	warning("please override this function -> net_operationsLimitTurntable.drawResult!")
end

function net_operationsLimitTurntable.drawResult_delegate(code, awardsId, list, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsLimitTurntable.drawResult(code, awardsId, list, pod)
end

function net_operationsLimitTurntable.getHistoryResult(code, historys)
	warning("please override this function -> net_operationsLimitTurntable.getHistoryResult!")
end

function net_operationsLimitTurntable.getHistoryResult_delegate(code, historys)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsLimitTurntable.getHistoryResult(code, historys)
end

net_operationsCupMatchVote = {}

function net_operationsCupMatchVote.vote(eventId, voteId)
	local success = LuaCodeInterface.Send(7302, eventId, voteId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_operationsCupMatchVote.voteResult(code, eventId, voteId, getItems)
	warning("please override this function -> net_operationsCupMatchVote.voteResult!")
end

function net_operationsCupMatchVote.voteResult_delegate(code, eventId, voteId, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_operationsCupMatchVote.voteResult(code, eventId, voteId, getItems)
end

net_guild = {}

function net_guild.sign()
	local success = LuaCodeInterface.Send(7402)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guild.getGuildQuestRewards(ids)
	local success = LuaCodeInterface.Send(7403, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guild.refreshRedPoint()
	local success = LuaCodeInterface.Send(7404)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guild.signResult(code, itemShows)
	warning("please override this function -> net_guild.signResult!")
end

function net_guild.signResult_delegate(code, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guild.signResult(code, itemShows)
end

function net_guild.getGuildQuestRewardsResult(code, ids, items)
	warning("please override this function -> net_guild.getGuildQuestRewardsResult!")
end

function net_guild.getGuildQuestRewardsResult_delegate(code, ids, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guild.getGuildQuestRewardsResult(code, ids, items)
end

function net_guild.refreshRedPointResult(code, status)
	warning("please override this function -> net_guild.refreshRedPointResult!")
end

function net_guild.refreshRedPointResult_delegate(code, status)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guild.refreshRedPointResult(code, status)
end

net_guildChallenge = {}

function net_guildChallenge.attack(formationID, layerCid)
	local success = LuaCodeInterface.Send(7502, formationID, layerCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guildChallenge.getRewards(id)
	local success = LuaCodeInterface.Send(7503, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guildChallenge.mopup(layerCid, count)
	local success = LuaCodeInterface.Send(7504, layerCid, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guildChallenge.getScore()
	local success = LuaCodeInterface.Send(7505)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guildChallenge.attackResult(code, layerCid)
	warning("please override this function -> net_guildChallenge.attackResult!")
end

function net_guildChallenge.attackResult_delegate(code, layerCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guildChallenge.attackResult(code, layerCid)
end

function net_guildChallenge.getRewardsResult(code, id, getItems)
	warning("please override this function -> net_guildChallenge.getRewardsResult!")
end

function net_guildChallenge.getRewardsResult_delegate(code, id, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guildChallenge.getRewardsResult(code, id, getItems)
end

function net_guildChallenge.mopupResult(code, layerCid, getItems, count)
	warning("please override this function -> net_guildChallenge.mopupResult!")
end

function net_guildChallenge.mopupResult_delegate(code, layerCid, getItems, count)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guildChallenge.mopupResult(code, layerCid, getItems, count)
end

function net_guildChallenge.getScoreResult(code, score)
	warning("please override this function -> net_guildChallenge.getScoreResult!")
end

function net_guildChallenge.getScoreResult_delegate(code, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guildChallenge.getScoreResult(code, score)
end

function net_guildChallenge.notifyAttackComplete(win, layerCid, dmgRecords, getItems)
	warning("please override this function -> net_guildChallenge.notifyAttackComplete!")
end

function net_guildChallenge.notifyAttackComplete_delegate(win, layerCid, dmgRecords, getItems)
	net_guildChallenge.notifyAttackComplete(win, layerCid, dmgRecords, getItems)
end

net_mining = {}

function net_mining.enterMap()
	local success = LuaCodeInterface.Send(7602)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mining.excavate(gridId)
	local success = LuaCodeInterface.Send(7603, gridId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mining.autoExcavate(number, type)
	local success = LuaCodeInterface.Send(7604, number, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mining.interact(gridId, formationId)
	local success = LuaCodeInterface.Send(7605, gridId, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mining.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(7606, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mining.enterMapResult(code, layer)
	warning("please override this function -> net_mining.enterMapResult!")
end

function net_mining.enterMapResult_delegate(code, layer)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mining.enterMapResult(code, layer)
end

function net_mining.excavateResult(code, gridId)
	warning("please override this function -> net_mining.excavateResult!")
end

function net_mining.excavateResult_delegate(code, gridId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mining.excavateResult(code, gridId)
end

function net_mining.autoExcavateResult(code, gridIds)
	warning("please override this function -> net_mining.autoExcavateResult!")
end

function net_mining.autoExcavateResult_delegate(code, gridIds)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mining.autoExcavateResult(code, gridIds)
end

function net_mining.interactResult(code, gridId)
	warning("please override this function -> net_mining.interactResult!")
end

function net_mining.interactResult_delegate(code, gridId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mining.interactResult(code, gridId)
end

function net_mining.notifyGridComplete(gridId)
	warning("please override this function -> net_mining.notifyGridComplete!")
end

function net_mining.notifyGridComplete_delegate(gridId)
	net_mining.notifyGridComplete(gridId)
end

function net_mining.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_mining.selectDialogResult!")
end

function net_mining.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mining.selectDialogResult(code, nextDialogCid)
end

function net_mining.notifyEnterLayer(layer)
	warning("please override this function -> net_mining.notifyEnterLayer!")
end

function net_mining.notifyEnterLayer_delegate(layer)
	net_mining.notifyEnterLayer(layer)
end

function net_mining.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_mining.notifyOpenDialog!")
end

function net_mining.notifyOpenDialog_delegate(dialogCid)
	net_mining.notifyOpenDialog(dialogCid)
end

function net_mining.notifyFightComplete(win, dmgRecords, getItems)
	warning("please override this function -> net_mining.notifyFightComplete!")
end

function net_mining.notifyFightComplete_delegate(win, dmgRecords, getItems)
	net_mining.notifyFightComplete(win, dmgRecords, getItems)
end

function net_mining.notifyGetRewards(getItems)
	warning("please override this function -> net_mining.notifyGetRewards!")
end

function net_mining.notifyGetRewards_delegate(getItems)
	net_mining.notifyGetRewards(getItems)
end

net_jewelry = {}

function net_jewelry.wear(soulCid, cid, speed)
	local success = LuaCodeInterface.Send(7702, soulCid, cid, speed)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.unwear(soulCid)
	local success = LuaCodeInterface.Send(7703, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.upStar(soulCid)
	local success = LuaCodeInterface.Send(7704, soulCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.upStarInBag(cid)
	local success = LuaCodeInterface.Send(7705, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.setSpeed(soulCid, speed)
	local success = LuaCodeInterface.Send(7706, soulCid, speed)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.recycle(cid, count)
	local success = LuaCodeInterface.Send(7707, cid, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.newWear(soulPrelabId, id, speed)
	local success = LuaCodeInterface.Send(7708, soulPrelabId, id, speed)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.newUnWear(soulPrelabId)
	local success = LuaCodeInterface.Send(7709, soulPrelabId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.setJewelrySpeed(prefabId, id, speed)
	local success = LuaCodeInterface.Send(7710, prefabId, id, speed)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.newUpStar(id)
	local success = LuaCodeInterface.Send(7711, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.newRecycle(id)
	local success = LuaCodeInterface.Send(7712, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_jewelry.wearResult(code, soulCid, cid, speed)
	warning("please override this function -> net_jewelry.wearResult!")
end

function net_jewelry.wearResult_delegate(code, soulCid, cid, speed)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.wearResult(code, soulCid, cid, speed)
end

function net_jewelry.unwearResult(code, soulCid)
	warning("please override this function -> net_jewelry.unwearResult!")
end

function net_jewelry.unwearResult_delegate(code, soulCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.unwearResult(code, soulCid)
end

function net_jewelry.upStarResult(code, soulCid, newId)
	warning("please override this function -> net_jewelry.upStarResult!")
end

function net_jewelry.upStarResult_delegate(code, soulCid, newId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.upStarResult(code, soulCid, newId)
end

function net_jewelry.upStarInBagResult(code, cid)
	warning("please override this function -> net_jewelry.upStarInBagResult!")
end

function net_jewelry.upStarInBagResult_delegate(code, cid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.upStarInBagResult(code, cid)
end

function net_jewelry.setSpeedResult(code, soulCid, speed)
	warning("please override this function -> net_jewelry.setSpeedResult!")
end

function net_jewelry.setSpeedResult_delegate(code, soulCid, speed)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.setSpeedResult(code, soulCid, speed)
end

function net_jewelry.recycleResult(code, cid, getItems)
	warning("please override this function -> net_jewelry.recycleResult!")
end

function net_jewelry.recycleResult_delegate(code, cid, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.recycleResult(code, cid, getItems)
end

function net_jewelry.newWearResult(code)
	warning("please override this function -> net_jewelry.newWearResult!")
end

function net_jewelry.newWearResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.newWearResult(code)
end

function net_jewelry.newUnWearResult(code)
	warning("please override this function -> net_jewelry.newUnWearResult!")
end

function net_jewelry.newUnWearResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.newUnWearResult(code)
end

function net_jewelry.setJewelrySpeedResult(code)
	warning("please override this function -> net_jewelry.setJewelrySpeedResult!")
end

function net_jewelry.setJewelrySpeedResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.setJewelrySpeedResult(code)
end

function net_jewelry.newUpStarResult(code)
	warning("please override this function -> net_jewelry.newUpStarResult!")
end

function net_jewelry.newUpStarResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.newUpStarResult(code)
end

function net_jewelry.newRecycleResult(code, getItems)
	warning("please override this function -> net_jewelry.newRecycleResult!")
end

function net_jewelry.newRecycleResult_delegate(code, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_jewelry.newRecycleResult(code, getItems)
end

net_singleWeakTower = {}

function net_singleWeakTower.fight(towerCid, formationID)
	local success = LuaCodeInterface.Send(7802, towerCid, formationID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_singleWeakTower.fightResult(code)
	warning("please override this function -> net_singleWeakTower.fightResult!")
end

function net_singleWeakTower.fightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_singleWeakTower.fightResult(code)
end

function net_singleWeakTower.notifyFightComplete(win, dupCid, layerCid, dmgRecords, getItems, nowLayer)
	warning("please override this function -> net_singleWeakTower.notifyFightComplete!")
end

function net_singleWeakTower.notifyFightComplete_delegate(win, dupCid, layerCid, dmgRecords, getItems, nowLayer)
	net_singleWeakTower.notifyFightComplete(win, dupCid, layerCid, dmgRecords, getItems, nowLayer)
end

net_commandChallengeLayer = {}

function net_commandChallengeLayer.startDrill(levelID)
	local success = LuaCodeInterface.Send(7902, levelID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_commandChallengeLayer.startDrillResult(code)
	warning("please override this function -> net_commandChallengeLayer.startDrillResult!")
end

function net_commandChallengeLayer.startDrillResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_commandChallengeLayer.startDrillResult(code)
end

function net_commandChallengeLayer.notifyFightComplete(win, levelID, dmgRecords, getItems)
	warning("please override this function -> net_commandChallengeLayer.notifyFightComplete!")
end

function net_commandChallengeLayer.notifyFightComplete_delegate(win, levelID, dmgRecords, getItems)
	net_commandChallengeLayer.notifyFightComplete(win, levelID, dmgRecords, getItems)
end

net_flightChallenge = {}

function net_flightChallenge.flightChallengeStart()
	local success = LuaCodeInterface.Send(8002)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_flightChallenge.flightChallengeLevelUp(id)
	local success = LuaCodeInterface.Send(8003, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_flightChallenge.flightChallengeEnd(distance, integral)
	local success = LuaCodeInterface.Send(8004, distance, integral)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_flightChallenge.flightChallengeBoss(formationId)
	local success = LuaCodeInterface.Send(8005, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_flightChallenge.flightChallengeStartResult(code)
	warning("please override this function -> net_flightChallenge.flightChallengeStartResult!")
end

function net_flightChallenge.flightChallengeStartResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_flightChallenge.flightChallengeStartResult(code)
end

function net_flightChallenge.flightChallengeLevelUpResult(code, flightChallengeMechaPOD)
	warning("please override this function -> net_flightChallenge.flightChallengeLevelUpResult!")
end

function net_flightChallenge.flightChallengeLevelUpResult_delegate(code, flightChallengeMechaPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_flightChallenge.flightChallengeLevelUpResult(code, flightChallengeMechaPOD)
end

function net_flightChallenge.flightChallengeEndResult(code, distance, items, integral)
	warning("please override this function -> net_flightChallenge.flightChallengeEndResult!")
end

function net_flightChallenge.flightChallengeEndResult_delegate(code, distance, items, integral)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_flightChallenge.flightChallengeEndResult(code, distance, items, integral)
end

function net_flightChallenge.flightChallengeBossResult(code)
	warning("please override this function -> net_flightChallenge.flightChallengeBossResult!")
end

function net_flightChallenge.flightChallengeBossResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_flightChallenge.flightChallengeBossResult(code)
end

function net_flightChallenge.notifyFlightChallengeBossEnd(win, cid, dmgRecords)
	warning("please override this function -> net_flightChallenge.notifyFlightChallengeBossEnd!")
end

function net_flightChallenge.notifyFlightChallengeBossEnd_delegate(win, cid, dmgRecords)
	net_flightChallenge.notifyFlightChallengeBossEnd(win, cid, dmgRecords)
end

net_guildTraining = {}

function net_guildTraining.attack(formationId, id)
	local success = LuaCodeInterface.Send(9002, formationId, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_guildTraining.attackResult(code)
	warning("please override this function -> net_guildTraining.attackResult!")
end

function net_guildTraining.attackResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_guildTraining.attackResult(code)
end

function net_guildTraining.notifyAttackEnd(win, dmgRecords, items, maxScore, getAward)
	warning("please override this function -> net_guildTraining.notifyAttackEnd!")
end

function net_guildTraining.notifyAttackEnd_delegate(win, dmgRecords, items, maxScore, getAward)
	net_guildTraining.notifyAttackEnd(win, dmgRecords, items, maxScore, getAward)
end

function net_guildTraining.notifyQuitGuild()
	warning("please override this function -> net_guildTraining.notifyQuitGuild!")
end

function net_guildTraining.notifyQuitGuild_delegate()
	net_guildTraining.notifyQuitGuild()
end

net_restaurant = {}

function net_restaurant.getRestaurantInfo()
	local success = LuaCodeInterface.Send(9102)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.transactDocuments()
	local success = LuaCodeInterface.Send(9103)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.practice(id)
	local success = LuaCodeInterface.Send(9104, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.levelUp()
	local success = LuaCodeInterface.Send(9105)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.work(id, post, location, state)
	local success = LuaCodeInterface.Send(9106, id, post, location, state)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.receiveIncome()
	local success = LuaCodeInterface.Send(9107)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.readBurst()
	local success = LuaCodeInterface.Send(9108)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.openDialog(eventId)
	local success = LuaCodeInterface.Send(9109, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(9110, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.getProblem(getNew)
	local success = LuaCodeInterface.Send(9111, getNew)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.answer(status, id)
	local success = LuaCodeInterface.Send(9112, status, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.linkGameInfo()
	local success = LuaCodeInterface.Send(9113)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.linkGame(id, time)
	local success = LuaCodeInterface.Send(9114, id, time)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.puzzleInfo()
	local success = LuaCodeInterface.Send(9115)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.puzzle(score)
	local success = LuaCodeInterface.Send(9116, score)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.memoryFlopInfo()
	local success = LuaCodeInterface.Send(9117)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.memoryFlop(id, step, time)
	local success = LuaCodeInterface.Send(9118, id, step, time)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.combatTraining(bossId, formationId)
	local success = LuaCodeInterface.Send(9119, bossId, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.bossTraining(formationId)
	local success = LuaCodeInterface.Send(9120, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_restaurant.getRestaurantInfoResult(code, restaurantOperationAttributePOD)
	warning("please override this function -> net_restaurant.getRestaurantInfoResult!")
end

function net_restaurant.getRestaurantInfoResult_delegate(code, restaurantOperationAttributePOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.getRestaurantInfoResult(code, restaurantOperationAttributePOD)
end

function net_restaurant.transactDocumentsResult(code, positionInformationPOD)
	warning("please override this function -> net_restaurant.transactDocumentsResult!")
end

function net_restaurant.transactDocumentsResult_delegate(code, positionInformationPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.transactDocumentsResult(code, positionInformationPOD)
end

function net_restaurant.practiceResult(code, positionInformationPOD, beforeAtt, restaurantOperationAttribute)
	warning("please override this function -> net_restaurant.practiceResult!")
end

function net_restaurant.practiceResult_delegate(code, positionInformationPOD, beforeAtt, restaurantOperationAttribute)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.practiceResult(code, positionInformationPOD, beforeAtt, restaurantOperationAttribute)
end

function net_restaurant.levelUpResult(code, restaurantOperationAttribute)
	warning("please override this function -> net_restaurant.levelUpResult!")
end

function net_restaurant.levelUpResult_delegate(code, restaurantOperationAttribute)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.levelUpResult(code, restaurantOperationAttribute)
end

function net_restaurant.workResult(code, posts, positionInformation, post, location)
	warning("please override this function -> net_restaurant.workResult!")
end

function net_restaurant.workResult_delegate(code, posts, positionInformation, post, location)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.workResult(code, posts, positionInformation, post, location)
end

function net_restaurant.receiveIncomeResult(code, items, time)
	warning("please override this function -> net_restaurant.receiveIncomeResult!")
end

function net_restaurant.receiveIncomeResult_delegate(code, items, time)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.receiveIncomeResult(code, items, time)
end

function net_restaurant.readBurstResult(code)
	warning("please override this function -> net_restaurant.readBurstResult!")
end

function net_restaurant.readBurstResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.readBurstResult(code)
end

function net_restaurant.openDialogResult(code, dialogCid)
	warning("please override this function -> net_restaurant.openDialogResult!")
end

function net_restaurant.openDialogResult_delegate(code, dialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.openDialogResult(code, dialogCid)
end

function net_restaurant.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_restaurant.selectDialogResult!")
end

function net_restaurant.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.selectDialogResult(code, nextDialogCid)
end

function net_restaurant.getProblemResult(code, restaurantOperationQuestion)
	warning("please override this function -> net_restaurant.getProblemResult!")
end

function net_restaurant.getProblemResult_delegate(code, restaurantOperationQuestion)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.getProblemResult(code, restaurantOperationQuestion)
end

function net_restaurant.answerResult(code, restaurantOperationQuestion, items)
	warning("please override this function -> net_restaurant.answerResult!")
end

function net_restaurant.answerResult_delegate(code, restaurantOperationQuestion, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.answerResult(code, restaurantOperationQuestion, items)
end

function net_restaurant.linkGameInfoResult(code, RestaurantOperationLinkGame)
	warning("please override this function -> net_restaurant.linkGameInfoResult!")
end

function net_restaurant.linkGameInfoResult_delegate(code, RestaurantOperationLinkGame)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.linkGameInfoResult(code, RestaurantOperationLinkGame)
end

function net_restaurant.linkGameResult(code, RestaurantOperationLinkGame)
	warning("please override this function -> net_restaurant.linkGameResult!")
end

function net_restaurant.linkGameResult_delegate(code, RestaurantOperationLinkGame)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.linkGameResult(code, RestaurantOperationLinkGame)
end

function net_restaurant.puzzleInfoResult(code, score)
	warning("please override this function -> net_restaurant.puzzleInfoResult!")
end

function net_restaurant.puzzleInfoResult_delegate(code, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.puzzleInfoResult(code, score)
end

function net_restaurant.puzzleResult(code, score)
	warning("please override this function -> net_restaurant.puzzleResult!")
end

function net_restaurant.puzzleResult_delegate(code, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.puzzleResult(code, score)
end

function net_restaurant.memoryFlopInfoResult(code, RestaurantOperationDraw)
	warning("please override this function -> net_restaurant.memoryFlopInfoResult!")
end

function net_restaurant.memoryFlopInfoResult_delegate(code, RestaurantOperationDraw)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.memoryFlopInfoResult(code, RestaurantOperationDraw)
end

function net_restaurant.memoryFlopResult(code, RestaurantOperationDraw)
	warning("please override this function -> net_restaurant.memoryFlopResult!")
end

function net_restaurant.memoryFlopResult_delegate(code, RestaurantOperationDraw)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.memoryFlopResult(code, RestaurantOperationDraw)
end

function net_restaurant.combatTrainingResult(code)
	warning("please override this function -> net_restaurant.combatTrainingResult!")
end

function net_restaurant.combatTrainingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.combatTrainingResult(code)
end

function net_restaurant.bossTrainingResult(code)
	warning("please override this function -> net_restaurant.bossTrainingResult!")
end

function net_restaurant.bossTrainingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_restaurant.bossTrainingResult(code)
end

function net_restaurant.notifyReceiveIncome(number)
	warning("please override this function -> net_restaurant.notifyReceiveIncome!")
end

function net_restaurant.notifyReceiveIncome_delegate(number)
	net_restaurant.notifyReceiveIncome(number)
end

function net_restaurant.notifyBossTraining(win, cid, dmgRecords)
	warning("please override this function -> net_restaurant.notifyBossTraining!")
end

function net_restaurant.notifyBossTraining_delegate(win, cid, dmgRecords)
	net_restaurant.notifyBossTraining(win, cid, dmgRecords)
end

function net_restaurant.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
	warning("please override this function -> net_restaurant.notifyCombatTrainingBossEnd!")
end

function net_restaurant.notifyCombatTrainingBossEnd_delegate(win, cid, dmgRecords, items, monster)
	net_restaurant.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
end

function net_restaurant.notifyTaskFinish(id)
	warning("please override this function -> net_restaurant.notifyTaskFinish!")
end

function net_restaurant.notifyTaskFinish_delegate(id)
	net_restaurant.notifyTaskFinish(id)
end

function net_restaurant.notifyEventIsFinish(eventId)
	warning("please override this function -> net_restaurant.notifyEventIsFinish!")
end

function net_restaurant.notifyEventIsFinish_delegate(eventId)
	net_restaurant.notifyEventIsFinish(eventId)
end

function net_restaurant.notifyEmergency(list)
	warning("please override this function -> net_restaurant.notifyEmergency!")
end

function net_restaurant.notifyEmergency_delegate(list)
	net_restaurant.notifyEmergency(list)
end

function net_restaurant.notifyEarnings(income)
	warning("please override this function -> net_restaurant.notifyEarnings!")
end

function net_restaurant.notifyEarnings_delegate(income)
	net_restaurant.notifyEarnings(income)
end

net_placeGame = {}

function net_placeGame.recruit(id)
	local success = LuaCodeInterface.Send(9202, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.levelUp(id, type)
	local success = LuaCodeInterface.Send(9203, id, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.dismissal(id)
	local success = LuaCodeInterface.Send(9204, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.changeFormationName(id, name)
	local success = LuaCodeInterface.Send(9205, id, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.goIntoBattle(id, beforeIndex, afterIndex)
	local success = LuaCodeInterface.Send(9206, id, beforeIndex, afterIndex)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.modifySoul(id, sid)
	local success = LuaCodeInterface.Send(9207, id, sid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.changePosition(id, position)
	local success = LuaCodeInterface.Send(9208, id, position)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.modifyWeapon(id, eId, state)
	local success = LuaCodeInterface.Send(9209, id, eId, state)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.climbingTower(formationId)
	local success = LuaCodeInterface.Send(9210, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.openTheBox()
	local success = LuaCodeInterface.Send(9211)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.buyATreasureChest(number, index)
	local success = LuaCodeInterface.Send(9212, number, index)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.allSoulUnload(id)
	local success = LuaCodeInterface.Send(9213, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.allEquipUnload(id)
	local success = LuaCodeInterface.Send(9214, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.soulEquipUnload(id)
	local success = LuaCodeInterface.Send(9215, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.openDialog(eventId)
	local success = LuaCodeInterface.Send(9216, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(9217, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.equipmentLock(eId, state)
	local success = LuaCodeInterface.Send(9218, eId, state)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.equipmentResolve(eIds)
	local success = LuaCodeInterface.Send(9219, eIds)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_placeGame.recruitResult(code, placeGameSoulPOD, firingSoulPODs)
	warning("please override this function -> net_placeGame.recruitResult!")
end

function net_placeGame.recruitResult_delegate(code, placeGameSoulPOD, firingSoulPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.recruitResult(code, placeGameSoulPOD, firingSoulPODs)
end

function net_placeGame.levelUpResult(code, placeGameSoulPOD)
	warning("please override this function -> net_placeGame.levelUpResult!")
end

function net_placeGame.levelUpResult_delegate(code, placeGameSoulPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.levelUpResult(code, placeGameSoulPOD)
end

function net_placeGame.dismissalResult(code, id, firingSoulPODs)
	warning("please override this function -> net_placeGame.dismissalResult!")
end

function net_placeGame.dismissalResult_delegate(code, id, firingSoulPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.dismissalResult(code, id, firingSoulPODs)
end

function net_placeGame.changeFormationNameResult(code, id, name)
	warning("please override this function -> net_placeGame.changeFormationNameResult!")
end

function net_placeGame.changeFormationNameResult_delegate(code, id, name)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.changeFormationNameResult(code, id, name)
end

function net_placeGame.goIntoBattleResult(code, placeGameFormationPOD)
	warning("please override this function -> net_placeGame.goIntoBattleResult!")
end

function net_placeGame.goIntoBattleResult_delegate(code, placeGameFormationPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.goIntoBattleResult(code, placeGameFormationPOD)
end

function net_placeGame.modifySoulResult(code, placeGameSoulPrefabPOD)
	warning("please override this function -> net_placeGame.modifySoulResult!")
end

function net_placeGame.modifySoulResult_delegate(code, placeGameSoulPrefabPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.modifySoulResult(code, placeGameSoulPrefabPOD)
end

function net_placeGame.changePositionResult(code, position)
	warning("please override this function -> net_placeGame.changePositionResult!")
end

function net_placeGame.changePositionResult_delegate(code, position)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.changePositionResult(code, position)
end

function net_placeGame.modifyWeaponResult(code, placeGameFormationPODs)
	warning("please override this function -> net_placeGame.modifyWeaponResult!")
end

function net_placeGame.modifyWeaponResult_delegate(code, placeGameFormationPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.modifyWeaponResult(code, placeGameFormationPODs)
end

function net_placeGame.climbingTowerResult(code)
	warning("please override this function -> net_placeGame.climbingTowerResult!")
end

function net_placeGame.climbingTowerResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.climbingTowerResult(code)
end

function net_placeGame.openTheBoxResult(code, items)
	warning("please override this function -> net_placeGame.openTheBoxResult!")
end

function net_placeGame.openTheBoxResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.openTheBoxResult(code, items)
end

function net_placeGame.buyATreasureChestResult(code, items)
	warning("please override this function -> net_placeGame.buyATreasureChestResult!")
end

function net_placeGame.buyATreasureChestResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.buyATreasureChestResult(code, items)
end

function net_placeGame.allSoulUnloadResult(code, placeGameFormationPODs)
	warning("please override this function -> net_placeGame.allSoulUnloadResult!")
end

function net_placeGame.allSoulUnloadResult_delegate(code, placeGameFormationPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.allSoulUnloadResult(code, placeGameFormationPODs)
end

function net_placeGame.allEquipUnloadResult(code, placeGameFormationPODs)
	warning("please override this function -> net_placeGame.allEquipUnloadResult!")
end

function net_placeGame.allEquipUnloadResult_delegate(code, placeGameFormationPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.allEquipUnloadResult(code, placeGameFormationPODs)
end

function net_placeGame.soulEquipUnloadResult(code, placeGameSoulPrefabPOD)
	warning("please override this function -> net_placeGame.soulEquipUnloadResult!")
end

function net_placeGame.soulEquipUnloadResult_delegate(code, placeGameSoulPrefabPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.soulEquipUnloadResult(code, placeGameSoulPrefabPOD)
end

function net_placeGame.openDialogResult(code, dialogCid)
	warning("please override this function -> net_placeGame.openDialogResult!")
end

function net_placeGame.openDialogResult_delegate(code, dialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.openDialogResult(code, dialogCid)
end

function net_placeGame.selectDialogResult(code, nextDialogCid, items)
	warning("please override this function -> net_placeGame.selectDialogResult!")
end

function net_placeGame.selectDialogResult_delegate(code, nextDialogCid, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.selectDialogResult(code, nextDialogCid, items)
end

function net_placeGame.equipmentLockResult(code)
	warning("please override this function -> net_placeGame.equipmentLockResult!")
end

function net_placeGame.equipmentLockResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.equipmentLockResult(code)
end

function net_placeGame.equipmentResolveResult(code, items)
	warning("please override this function -> net_placeGame.equipmentResolveResult!")
end

function net_placeGame.equipmentResolveResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.equipmentResolveResult(code, items)
end

function net_placeGame.notifyBoss(win, cid, dmgRecords, items)
	warning("please override this function -> net_placeGame.notifyBoss!")
end

function net_placeGame.notifyBoss_delegate(win, cid, dmgRecords, items)
	net_placeGame.notifyBoss(win, cid, dmgRecords, items)
end

function net_placeGame.notifyFormation(placeGameSoulPrefabPOD)
	warning("please override this function -> net_placeGame.notifyFormation!")
end

function net_placeGame.notifyFormation_delegate(placeGameSoulPrefabPOD)
	net_placeGame.notifyFormation(placeGameSoulPrefabPOD)
end

function net_placeGame.notifyEventIsFinish(eventId)
	warning("please override this function -> net_placeGame.notifyEventIsFinish!")
end

function net_placeGame.notifyEventIsFinish_delegate(eventId)
	net_placeGame.notifyEventIsFinish(eventId)
end

function net_placeGame.notifyBoxAdd(number)
	warning("please override this function -> net_placeGame.notifyBoxAdd!")
end

function net_placeGame.notifyBoxAdd_delegate(number)
	net_placeGame.notifyBoxAdd(number)
end

function net_placeGame.notifyChallengeLevel(level)
	warning("please override this function -> net_placeGame.notifyChallengeLevel!")
end

function net_placeGame.notifyChallengeLevel_delegate(level)
	net_placeGame.notifyChallengeLevel(level)
end

net_amusementPark = {}

function net_amusementPark.getAmusementParkInfo()
	local success = LuaCodeInterface.Send(9302)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.getAmusementParkInfoTemporarily()
	local success = LuaCodeInterface.Send(9303)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.build(post, buildingId)
	local success = LuaCodeInterface.Send(9304, post, buildingId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.changeLayout(cache)
	local success = LuaCodeInterface.Send(9305, cache)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.confirmChanges(cache)
	local success = LuaCodeInterface.Send(9306, cache)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.parkLevelUp(post)
	local success = LuaCodeInterface.Send(9307, post)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.randomActionFigure()
	local success = LuaCodeInterface.Send(9308)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.recruit(id)
	local success = LuaCodeInterface.Send(9309, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.roleLevelUp(id)
	local success = LuaCodeInterface.Send(9310, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.roleDeploy(bId, rId)
	local success = LuaCodeInterface.Send(9311, bId, rId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.roleUnDeploy(bId, rId)
	local success = LuaCodeInterface.Send(9312, bId, rId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.openDialog(eventId)
	local success = LuaCodeInterface.Send(9313, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(9314, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.receiveIncome()
	local success = LuaCodeInterface.Send(9315)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.combatTraining(bossId, formationId)
	local success = LuaCodeInterface.Send(9316, bossId, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.bossTraining(formationId)
	local success = LuaCodeInterface.Send(9317, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.readBurst()
	local success = LuaCodeInterface.Send(9318)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.dollMachineInfo()
	local success = LuaCodeInterface.Send(9319)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.dollMachine(level, score)
	local success = LuaCodeInterface.Send(9320, level, score)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.pixelBirdInfo()
	local success = LuaCodeInterface.Send(9321)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.pixelBird(level, score)
	local success = LuaCodeInterface.Send(9322, level, score)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.stackingInfo()
	local success = LuaCodeInterface.Send(9323)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.stacking(level, score)
	local success = LuaCodeInterface.Send(9324, level, score)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.oneStrokeInfo()
	local success = LuaCodeInterface.Send(9325)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.oneStroke(id)
	local success = LuaCodeInterface.Send(9326, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.answerInfo()
	local success = LuaCodeInterface.Send(9327)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.answer(id)
	local success = LuaCodeInterface.Send(9328, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.getLittleGameInfo()
	local success = LuaCodeInterface.Send(9329)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_amusementPark.getAmusementParkInfoResult(code, amusementParkInfoPOD)
	warning("please override this function -> net_amusementPark.getAmusementParkInfoResult!")
end

function net_amusementPark.getAmusementParkInfoResult_delegate(code, amusementParkInfoPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.getAmusementParkInfoResult(code, amusementParkInfoPOD)
end

function net_amusementPark.getAmusementParkInfoTemporarilyResult(code, unitList)
	warning("please override this function -> net_amusementPark.getAmusementParkInfoTemporarilyResult!")
end

function net_amusementPark.getAmusementParkInfoTemporarilyResult_delegate(code, unitList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.getAmusementParkInfoTemporarilyResult(code, unitList)
end

function net_amusementPark.buildResult(code, id)
	warning("please override this function -> net_amusementPark.buildResult!")
end

function net_amusementPark.buildResult_delegate(code, id)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.buildResult(code, id)
end

function net_amusementPark.changeLayoutResult(code, amusementParkAttPOD)
	warning("please override this function -> net_amusementPark.changeLayoutResult!")
end

function net_amusementPark.changeLayoutResult_delegate(code, amusementParkAttPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.changeLayoutResult(code, amusementParkAttPOD)
end

function net_amusementPark.confirmChangesResult(code, amusementParkAttPOD, unitList)
	warning("please override this function -> net_amusementPark.confirmChangesResult!")
end

function net_amusementPark.confirmChangesResult_delegate(code, amusementParkAttPOD, unitList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.confirmChangesResult(code, amusementParkAttPOD, unitList)
end

function net_amusementPark.parkLevelUpResult(code, id)
	warning("please override this function -> net_amusementPark.parkLevelUpResult!")
end

function net_amusementPark.parkLevelUpResult_delegate(code, id)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.parkLevelUpResult(code, id)
end

function net_amusementPark.randomActionFigureResult(code, amusementParkVoRolePODs)
	warning("please override this function -> net_amusementPark.randomActionFigureResult!")
end

function net_amusementPark.randomActionFigureResult_delegate(code, amusementParkVoRolePODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.randomActionFigureResult(code, amusementParkVoRolePODs)
end

function net_amusementPark.recruitResult(code, amusementParkVoRoles, amusementParkVoRolesHave)
	warning("please override this function -> net_amusementPark.recruitResult!")
end

function net_amusementPark.recruitResult_delegate(code, amusementParkVoRoles, amusementParkVoRolesHave)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.recruitResult(code, amusementParkVoRoles, amusementParkVoRolesHave)
end

function net_amusementPark.roleLevelUpResult(code, amusementParkVoRolePOD)
	warning("please override this function -> net_amusementPark.roleLevelUpResult!")
end

function net_amusementPark.roleLevelUpResult_delegate(code, amusementParkVoRolePOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.roleLevelUpResult(code, amusementParkVoRolePOD)
end

function net_amusementPark.roleDeployResult(code, amusementParkVoRolePOD)
	warning("please override this function -> net_amusementPark.roleDeployResult!")
end

function net_amusementPark.roleDeployResult_delegate(code, amusementParkVoRolePOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.roleDeployResult(code, amusementParkVoRolePOD)
end

function net_amusementPark.roleUnDeployResult(code, amusementParkVoRolePOD)
	warning("please override this function -> net_amusementPark.roleUnDeployResult!")
end

function net_amusementPark.roleUnDeployResult_delegate(code, amusementParkVoRolePOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.roleUnDeployResult(code, amusementParkVoRolePOD)
end

function net_amusementPark.openDialogResult(code, dialogCid)
	warning("please override this function -> net_amusementPark.openDialogResult!")
end

function net_amusementPark.openDialogResult_delegate(code, dialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.openDialogResult(code, dialogCid)
end

function net_amusementPark.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_amusementPark.selectDialogResult!")
end

function net_amusementPark.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.selectDialogResult(code, nextDialogCid)
end

function net_amusementPark.receiveIncomeResult(code, items, time)
	warning("please override this function -> net_amusementPark.receiveIncomeResult!")
end

function net_amusementPark.receiveIncomeResult_delegate(code, items, time)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.receiveIncomeResult(code, items, time)
end

function net_amusementPark.combatTrainingResult(code)
	warning("please override this function -> net_amusementPark.combatTrainingResult!")
end

function net_amusementPark.combatTrainingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.combatTrainingResult(code)
end

function net_amusementPark.bossTrainingResult(code)
	warning("please override this function -> net_amusementPark.bossTrainingResult!")
end

function net_amusementPark.bossTrainingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.bossTrainingResult(code)
end

function net_amusementPark.readBurstResult(code)
	warning("please override this function -> net_amusementPark.readBurstResult!")
end

function net_amusementPark.readBurstResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.readBurstResult(code)
end

function net_amusementPark.dollMachineInfoResult(code, level, score)
	warning("please override this function -> net_amusementPark.dollMachineInfoResult!")
end

function net_amusementPark.dollMachineInfoResult_delegate(code, level, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.dollMachineInfoResult(code, level, score)
end

function net_amusementPark.dollMachineResult(code, level, score)
	warning("please override this function -> net_amusementPark.dollMachineResult!")
end

function net_amusementPark.dollMachineResult_delegate(code, level, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.dollMachineResult(code, level, score)
end

function net_amusementPark.pixelBirdInfoResult(code, level, score)
	warning("please override this function -> net_amusementPark.pixelBirdInfoResult!")
end

function net_amusementPark.pixelBirdInfoResult_delegate(code, level, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.pixelBirdInfoResult(code, level, score)
end

function net_amusementPark.pixelBirdResult(code, level, score)
	warning("please override this function -> net_amusementPark.pixelBirdResult!")
end

function net_amusementPark.pixelBirdResult_delegate(code, level, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.pixelBirdResult(code, level, score)
end

function net_amusementPark.stackingInfoResult(code, level, score)
	warning("please override this function -> net_amusementPark.stackingInfoResult!")
end

function net_amusementPark.stackingInfoResult_delegate(code, level, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.stackingInfoResult(code, level, score)
end

function net_amusementPark.stackingResult(code, level, score)
	warning("please override this function -> net_amusementPark.stackingResult!")
end

function net_amusementPark.stackingResult_delegate(code, level, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.stackingResult(code, level, score)
end

function net_amusementPark.oneStrokeInfoResult(code, score)
	warning("please override this function -> net_amusementPark.oneStrokeInfoResult!")
end

function net_amusementPark.oneStrokeInfoResult_delegate(code, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.oneStrokeInfoResult(code, score)
end

function net_amusementPark.oneStrokeResult(code, score)
	warning("please override this function -> net_amusementPark.oneStrokeResult!")
end

function net_amusementPark.oneStrokeResult_delegate(code, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.oneStrokeResult(code, score)
end

function net_amusementPark.answerInfoResult(code, score)
	warning("please override this function -> net_amusementPark.answerInfoResult!")
end

function net_amusementPark.answerInfoResult_delegate(code, score)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.answerInfoResult(code, score)
end

function net_amusementPark.answerResult(code, score, items)
	warning("please override this function -> net_amusementPark.answerResult!")
end

function net_amusementPark.answerResult_delegate(code, score, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.answerResult(code, score, items)
end

function net_amusementPark.getLittleGameInfoResult(code, info)
	warning("please override this function -> net_amusementPark.getLittleGameInfoResult!")
end

function net_amusementPark.getLittleGameInfoResult_delegate(code, info)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.getLittleGameInfoResult(code, info)
end

function net_amusementPark.notifyAmusementParkInfo(amusementParkLandPODs, post)
	warning("please override this function -> net_amusementPark.notifyAmusementParkInfo!")
end

function net_amusementPark.notifyAmusementParkInfo_delegate(amusementParkLandPODs, post)
	net_amusementPark.notifyAmusementParkInfo(amusementParkLandPODs, post)
end

function net_amusementPark.notifyAmusementParkInfoPOD(amusementParkAttPOD)
	warning("please override this function -> net_amusementPark.notifyAmusementParkInfoPOD!")
end

function net_amusementPark.notifyAmusementParkInfoPOD_delegate(amusementParkAttPOD)
	net_amusementPark.notifyAmusementParkInfoPOD(amusementParkAttPOD)
end

function net_amusementPark.notifyEventIsFinish(eventId)
	warning("please override this function -> net_amusementPark.notifyEventIsFinish!")
end

function net_amusementPark.notifyEventIsFinish_delegate(eventId)
	net_amusementPark.notifyEventIsFinish(eventId)
end

function net_amusementPark.notifyReceiveIncome(num)
	warning("please override this function -> net_amusementPark.notifyReceiveIncome!")
end

function net_amusementPark.notifyReceiveIncome_delegate(num)
	net_amusementPark.notifyReceiveIncome(num)
end

function net_amusementPark.notifyEmergency(list)
	warning("please override this function -> net_amusementPark.notifyEmergency!")
end

function net_amusementPark.notifyEmergency_delegate(list)
	net_amusementPark.notifyEmergency(list)
end

function net_amusementPark.notifyBossTraining(win, cid, dmgRecords)
	warning("please override this function -> net_amusementPark.notifyBossTraining!")
end

function net_amusementPark.notifyBossTraining_delegate(win, cid, dmgRecords)
	net_amusementPark.notifyBossTraining(win, cid, dmgRecords)
end

function net_amusementPark.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
	warning("please override this function -> net_amusementPark.notifyCombatTrainingBossEnd!")
end

function net_amusementPark.notifyCombatTrainingBossEnd_delegate(win, cid, dmgRecords, items, monster)
	net_amusementPark.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
end

function net_amusementPark.notifyItemGMAdd(items)
	warning("please override this function -> net_amusementPark.notifyItemGMAdd!")
end

function net_amusementPark.notifyItemGMAdd_delegate(items)
	net_amusementPark.notifyItemGMAdd(items)
end

net_survival = {}

function net_survival.startChallenge(pass)
	local success = LuaCodeInterface.Send(9402, pass)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_survival.endChallenge(id, pass, monster, boss)
	local success = LuaCodeInterface.Send(9403, id, pass, monster, boss)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_survival.level()
	local success = LuaCodeInterface.Send(9404)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_survival.startChallengeUnlimited()
	local success = LuaCodeInterface.Send(9405)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_survival.endChallengeUnlimited(id, boss)
	local success = LuaCodeInterface.Send(9406, id, boss)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_survival.startChallengeResult(code, pass)
	warning("please override this function -> net_survival.startChallengeResult!")
end

function net_survival.startChallengeResult_delegate(code, pass)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_survival.startChallengeResult(code, pass)
end

function net_survival.endChallengeResult(code, getItems, monster, boss, id, pass)
	warning("please override this function -> net_survival.endChallengeResult!")
end

function net_survival.endChallengeResult_delegate(code, getItems, monster, boss, id, pass)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_survival.endChallengeResult(code, getItems, monster, boss, id, pass)
end

function net_survival.levelResult(code, level)
	warning("please override this function -> net_survival.levelResult!")
end

function net_survival.levelResult_delegate(code, level)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_survival.levelResult(code, level)
end

function net_survival.startChallengeUnlimitedResult(code)
	warning("please override this function -> net_survival.startChallengeUnlimitedResult!")
end

function net_survival.startChallengeUnlimitedResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_survival.startChallengeUnlimitedResult(code)
end

function net_survival.endChallengeUnlimitedResult(code, id, boss, getItems)
	warning("please override this function -> net_survival.endChallengeUnlimitedResult!")
end

function net_survival.endChallengeUnlimitedResult_delegate(code, id, boss, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_survival.endChallengeUnlimitedResult(code, id, boss, getItems)
end

function net_survival.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(9412, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_survival.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_survival.selectDialogResult!")
end

function net_survival.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_survival.selectDialogResult(code, nextDialogCid)
end

function net_survival.notifyOpenDialog(dialogCid)
	warning("please override this function -> net_survival.notifyOpenDialog!")
end

function net_survival.notifyOpenDialog_delegate(dialogCid)
	net_survival.notifyOpenDialog(dialogCid)
end

function net_survival.notifyUpdateSurvivalPassStatus(survivalPassStatusPOD)
	warning("please override this function -> net_survival.notifyUpdateSurvivalPassStatus!")
end

function net_survival.notifyUpdateSurvivalPassStatus_delegate(survivalPassStatusPOD)
	net_survival.notifyUpdateSurvivalPassStatus(survivalPassStatusPOD)
end

function net_survival.notifyDialogRewards(getItems)
	warning("please override this function -> net_survival.notifyDialogRewards!")
end

function net_survival.notifyDialogRewards_delegate(getItems)
	net_survival.notifyDialogRewards(getItems)
end

net_horizontalRPG = {}

function net_horizontalRPG.elementExecution(map, region, element, type)
	local success = LuaCodeInterface.Send(9502, map, region, element, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.elementExecutionElse(service)
	local success = LuaCodeInterface.Send(9503, service)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.combatTraining(bossId, formationId, isFree)
	local success = LuaCodeInterface.Send(9504, bossId, formationId, isFree)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.bossTraining(formationId)
	local success = LuaCodeInterface.Send(9505, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.selectDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(9506, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.modifyWeather(id)
	local success = LuaCodeInterface.Send(9507, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.quickChallenge(bossId, number)
	local success = LuaCodeInterface.Send(9508, bossId, number)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.elementExecutionResult(code)
	warning("please override this function -> net_horizontalRPG.elementExecutionResult!")
end

function net_horizontalRPG.elementExecutionResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.elementExecutionResult(code)
end

function net_horizontalRPG.elementExecutionElseResult(code)
	warning("please override this function -> net_horizontalRPG.elementExecutionElseResult!")
end

function net_horizontalRPG.elementExecutionElseResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.elementExecutionElseResult(code)
end

function net_horizontalRPG.combatTrainingResult(code)
	warning("please override this function -> net_horizontalRPG.combatTrainingResult!")
end

function net_horizontalRPG.combatTrainingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.combatTrainingResult(code)
end

function net_horizontalRPG.bossTrainingResult(code)
	warning("please override this function -> net_horizontalRPG.bossTrainingResult!")
end

function net_horizontalRPG.bossTrainingResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.bossTrainingResult(code)
end

function net_horizontalRPG.selectDialogResult(code, nextDialogCid)
	warning("please override this function -> net_horizontalRPG.selectDialogResult!")
end

function net_horizontalRPG.selectDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.selectDialogResult(code, nextDialogCid)
end

function net_horizontalRPG.modifyWeatherResult(code, state)
	warning("please override this function -> net_horizontalRPG.modifyWeatherResult!")
end

function net_horizontalRPG.modifyWeatherResult_delegate(code, state)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.modifyWeatherResult(code, state)
end

function net_horizontalRPG.quickChallengeResult(code, items)
	warning("please override this function -> net_horizontalRPG.quickChallengeResult!")
end

function net_horizontalRPG.quickChallengeResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.quickChallengeResult(code, items)
end

function net_horizontalRPG.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, openExBoss, freeBossNumber, ticks)
	warning("please override this function -> net_horizontalRPG.notifyCombatTrainingBossEnd!")
end

function net_horizontalRPG.notifyCombatTrainingBossEnd_delegate(win, cid, dmgRecords, items, openExBoss, freeBossNumber, ticks)
	net_horizontalRPG.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, openExBoss, freeBossNumber, ticks)
end

function net_horizontalRPG.notifyBossTraining(win, cid, dmgRecords)
	warning("please override this function -> net_horizontalRPG.notifyBossTraining!")
end

function net_horizontalRPG.notifyBossTraining_delegate(win, cid, dmgRecords)
	net_horizontalRPG.notifyBossTraining(win, cid, dmgRecords)
end

function net_horizontalRPG.notifyBossUnlock(boss)
	warning("please override this function -> net_horizontalRPG.notifyBossUnlock!")
end

function net_horizontalRPG.notifyBossUnlock_delegate(boss)
	net_horizontalRPG.notifyBossUnlock(boss)
end

function net_horizontalRPG.notifyTicketsUpdate(value)
	warning("please override this function -> net_horizontalRPG.notifyTicketsUpdate!")
end

function net_horizontalRPG.notifyTicketsUpdate_delegate(value)
	net_horizontalRPG.notifyTicketsUpdate(value)
end

function net_horizontalRPG.notifyElementExecution(HorizontalRPGResPods)
	warning("please override this function -> net_horizontalRPG.notifyElementExecution!")
end

function net_horizontalRPG.notifyElementExecution_delegate(HorizontalRPGResPods)
	net_horizontalRPG.notifyElementExecution(HorizontalRPGResPods)
end

function net_horizontalRPG.notifyCMD(horizontalRPGPOD)
	warning("please override this function -> net_horizontalRPG.notifyCMD!")
end

function net_horizontalRPG.notifyCMD_delegate(horizontalRPGPOD)
	net_horizontalRPG.notifyCMD(horizontalRPGPOD)
end

function net_horizontalRPG.challenge(levelCid, formationId)
	local success = LuaCodeInterface.Send(9522, levelCid, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.challengeResult(code, levelCid, mazePOD, horizontalRPGMapPOD, levelDialogCid)
	warning("please override this function -> net_horizontalRPG.challengeResult!")
end

function net_horizontalRPG.challengeResult_delegate(code, levelCid, mazePOD, horizontalRPGMapPOD, levelDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.challengeResult(code, levelCid, mazePOD, horizontalRPGMapPOD, levelDialogCid)
end

function net_horizontalRPG.notifyFinnishLevels(cid)
	warning("please override this function -> net_horizontalRPG.notifyFinnishLevels!")
end

function net_horizontalRPG.notifyFinnishLevels_delegate(cid)
	net_horizontalRPG.notifyFinnishLevels(cid)
end

function net_horizontalRPG.notifyUnlockedDifficulty(diffculty)
	warning("please override this function -> net_horizontalRPG.notifyUnlockedDifficulty!")
end

function net_horizontalRPG.notifyUnlockedDifficulty_delegate(diffculty)
	net_horizontalRPG.notifyUnlockedDifficulty(diffculty)
end

function net_horizontalRPG.notifyChallengeFightEnd(win, levelCid, dmgRecords, items)
	warning("please override this function -> net_horizontalRPG.notifyChallengeFightEnd!")
end

function net_horizontalRPG.notifyChallengeFightEnd_delegate(win, levelCid, dmgRecords, items)
	net_horizontalRPG.notifyChallengeFightEnd(win, levelCid, dmgRecords, items)
end

function net_horizontalRPG.notifyChallengeStoryFinished(levelCid, items)
	warning("please override this function -> net_horizontalRPG.notifyChallengeStoryFinished!")
end

function net_horizontalRPG.notifyChallengeStoryFinished_delegate(levelCid, items)
	net_horizontalRPG.notifyChallengeStoryFinished(levelCid, items)
end

function net_horizontalRPG.notifyHRPGFinished(levelCid, items)
	warning("please override this function -> net_horizontalRPG.notifyHRPGFinished!")
end

function net_horizontalRPG.notifyHRPGFinished_delegate(levelCid, items)
	net_horizontalRPG.notifyHRPGFinished(levelCid, items)
end

function net_horizontalRPG.selectLevelDialog(selectIndex, skipSelectIndexs)
	local success = LuaCodeInterface.Send(9529, selectIndex, skipSelectIndexs)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_horizontalRPG.selectLevelDialogResult(code, nextDialogCid)
	warning("please override this function -> net_horizontalRPG.selectLevelDialogResult!")
end

function net_horizontalRPG.selectLevelDialogResult_delegate(code, nextDialogCid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_horizontalRPG.selectLevelDialogResult(code, nextDialogCid)
end

net_fishingActivity = {}

function net_fishingActivity.fishing()
	local success = LuaCodeInterface.Send(9602)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.fishingConfirm(suc)
	local success = LuaCodeInterface.Send(9603, suc)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.getAutoFishingRewards()
	local success = LuaCodeInterface.Send(9604)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.upRole()
	local success = LuaCodeInterface.Send(9605)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.upSkill(id)
	local success = LuaCodeInterface.Send(9606, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.upAction(id)
	local success = LuaCodeInterface.Send(9607, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.getStoryRewards(id)
	local success = LuaCodeInterface.Send(9608, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fishingActivity.fishingResult(code, fish)
	warning("please override this function -> net_fishingActivity.fishingResult!")
end

function net_fishingActivity.fishingResult_delegate(code, fish)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.fishingResult(code, fish)
end

function net_fishingActivity.fishingConfirmResult(code)
	warning("please override this function -> net_fishingActivity.fishingConfirmResult!")
end

function net_fishingActivity.fishingConfirmResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.fishingConfirmResult(code)
end

function net_fishingActivity.getAutoFishingRewardsResult(code, fishes, autoFishingRewardsTim)
	warning("please override this function -> net_fishingActivity.getAutoFishingRewardsResult!")
end

function net_fishingActivity.getAutoFishingRewardsResult_delegate(code, fishes, autoFishingRewardsTim)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.getAutoFishingRewardsResult(code, fishes, autoFishingRewardsTim)
end

function net_fishingActivity.upRoleResult(code, level)
	warning("please override this function -> net_fishingActivity.upRoleResult!")
end

function net_fishingActivity.upRoleResult_delegate(code, level)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.upRoleResult(code, level)
end

function net_fishingActivity.upSkillResult(code, id, level)
	warning("please override this function -> net_fishingActivity.upSkillResult!")
end

function net_fishingActivity.upSkillResult_delegate(code, id, level)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.upSkillResult(code, id, level)
end

function net_fishingActivity.upActionResult(code, id, level)
	warning("please override this function -> net_fishingActivity.upActionResult!")
end

function net_fishingActivity.upActionResult_delegate(code, id, level)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.upActionResult(code, id, level)
end

function net_fishingActivity.getStoryRewardsResult(code, itemShows)
	warning("please override this function -> net_fishingActivity.getStoryRewardsResult!")
end

function net_fishingActivity.getStoryRewardsResult_delegate(code, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fishingActivity.getStoryRewardsResult(code, itemShows)
end

net_centerChat = {}

function net_centerChat.sendChat(chat)
	local success = LuaCodeInterface.Send(100102, chat)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerChat.switchRoom(roomId)
	local success = LuaCodeInterface.Send(100103, roomId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerChat.sendChatResult(code)
	warning("please override this function -> net_centerChat.sendChatResult!")
end

function net_centerChat.sendChatResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerChat.sendChatResult(code)
end

function net_centerChat.switchRoomResult(code, chatRoom)
	warning("please override this function -> net_centerChat.switchRoomResult!")
end

function net_centerChat.switchRoomResult_delegate(code, chatRoom)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerChat.switchRoomResult(code, chatRoom)
end

function net_centerChat.notifyChat(chat)
	warning("please override this function -> net_centerChat.notifyChat!")
end

function net_centerChat.notifyChat_delegate(chat)
	net_centerChat.notifyChat(chat)
end

function net_centerChat.notifyChatRoom(chatRoom)
	warning("please override this function -> net_centerChat.notifyChatRoom!")
end

function net_centerChat.notifyChatRoom_delegate(chatRoom)
	net_centerChat.notifyChatRoom(chatRoom)
end

function net_centerChat.reportPlayer(pid, type, text, reason, remark)
	local success = LuaCodeInterface.Send(100108, pid, type, text, reason, remark)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerChat.reportPlayerResult(code)
	warning("please override this function -> net_centerChat.reportPlayerResult!")
end

function net_centerChat.reportPlayerResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerChat.reportPlayerResult(code)
end

net_centerRank = {}

function net_centerRank.getRank(rankId, count, needUserData)
	local success = LuaCodeInterface.Send(100202, rankId, count, needUserData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerRank.getRankResult(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	warning("please override this function -> net_centerRank.getRankResult!")
end

function net_centerRank.getRankResult_delegate(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerRank.getRankResult(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
end

function net_centerRank.getRankUserData(rankId, lastRanking, rank)
	local success = LuaCodeInterface.Send(100204, rankId, lastRanking, rank)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerRank.getRankUserDataResult(code, userData)
	warning("please override this function -> net_centerRank.getRankUserDataResult!")
end

function net_centerRank.getRankUserDataResult_delegate(code, userData)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerRank.getRankUserDataResult(code, userData)
end

function net_centerRank.getRankGoalie(rankId, rankType, ranking)
	local success = LuaCodeInterface.Send(100206, rankId, rankType, ranking)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerRank.getRankGoalieResult(code, rankingPOD, ranking, rankType)
	warning("please override this function -> net_centerRank.getRankGoalieResult!")
end

function net_centerRank.getRankGoalieResult_delegate(code, rankingPOD, ranking, rankType)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerRank.getRankGoalieResult(code, rankingPOD, ranking, rankType)
end

net_centerFriend = {}

function net_centerFriend.removeFriends(ids)
	local success = LuaCodeInterface.Send(100302, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.applyFriends(ids)
	local success = LuaCodeInterface.Send(100303, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.dealWithApply(ids, allow)
	local success = LuaCodeInterface.Send(100304, ids, allow)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.addBlacklist(pid)
	local success = LuaCodeInterface.Send(100305, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.removeBlacklist(ids)
	local success = LuaCodeInterface.Send(100306, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.searchPlayer(guid)
	local success = LuaCodeInterface.Send(100307, guid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.setRemark(friendId, remark)
	local success = LuaCodeInterface.Send(100308, friendId, remark)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.recommend()
	local success = LuaCodeInterface.Send(100309)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.removeFriendsResult(code)
	warning("please override this function -> net_centerFriend.removeFriendsResult!")
end

function net_centerFriend.removeFriendsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.removeFriendsResult(code)
end

function net_centerFriend.applyFriendsResult(code)
	warning("please override this function -> net_centerFriend.applyFriendsResult!")
end

function net_centerFriend.applyFriendsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.applyFriendsResult(code)
end

function net_centerFriend.dealWithApplyResult(code)
	warning("please override this function -> net_centerFriend.dealWithApplyResult!")
end

function net_centerFriend.dealWithApplyResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.dealWithApplyResult(code)
end

function net_centerFriend.addBlacklistResult(code)
	warning("please override this function -> net_centerFriend.addBlacklistResult!")
end

function net_centerFriend.addBlacklistResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.addBlacklistResult(code)
end

function net_centerFriend.removeBlacklistResult(code)
	warning("please override this function -> net_centerFriend.removeBlacklistResult!")
end

function net_centerFriend.removeBlacklistResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.removeBlacklistResult(code)
end

function net_centerFriend.searchPlayerResult(code, friend)
	warning("please override this function -> net_centerFriend.searchPlayerResult!")
end

function net_centerFriend.searchPlayerResult_delegate(code, friend)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.searchPlayerResult(code, friend)
end

function net_centerFriend.setRemarkResult(code, friend)
	warning("please override this function -> net_centerFriend.setRemarkResult!")
end

function net_centerFriend.setRemarkResult_delegate(code, friend)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.setRemarkResult(code, friend)
end

function net_centerFriend.recommendResult(code, friends)
	warning("please override this function -> net_centerFriend.recommendResult!")
end

function net_centerFriend.recommendResult_delegate(code, friends)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.recommendResult(code, friends)
end

function net_centerFriend.notifyAddFriend(friends)
	warning("please override this function -> net_centerFriend.notifyAddFriend!")
end

function net_centerFriend.notifyAddFriend_delegate(friends)
	net_centerFriend.notifyAddFriend(friends)
end

function net_centerFriend.notifyDeleteFriend(ids)
	warning("please override this function -> net_centerFriend.notifyDeleteFriend!")
end

function net_centerFriend.notifyDeleteFriend_delegate(ids)
	net_centerFriend.notifyDeleteFriend(ids)
end

function net_centerFriend.notifyUpdateFriend(friends)
	warning("please override this function -> net_centerFriend.notifyUpdateFriend!")
end

function net_centerFriend.notifyUpdateFriend_delegate(friends)
	net_centerFriend.notifyUpdateFriend(friends)
end

net_centerEventTurnTable = {}

function net_centerEventTurnTable.getTurntableLogInfo(eventId)
	local success = LuaCodeInterface.Send(100402, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerEventTurnTable.reciveRewardInfo(eventId, uuid, name, phone, address)
	local success = LuaCodeInterface.Send(100403, eventId, uuid, name, phone, address)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerEventTurnTable.getTurntableLogInfoResult(code, recordList)
	warning("please override this function -> net_centerEventTurnTable.getTurntableLogInfoResult!")
end

function net_centerEventTurnTable.getTurntableLogInfoResult_delegate(code, recordList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerEventTurnTable.getTurntableLogInfoResult(code, recordList)
end

function net_centerEventTurnTable.reciveRewardInfoResult(code)
	warning("please override this function -> net_centerEventTurnTable.reciveRewardInfoResult!")
end

function net_centerEventTurnTable.reciveRewardInfoResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerEventTurnTable.reciveRewardInfoResult(code)
end

net_centerEventGroupPurchase = {}

function net_centerEventGroupPurchase.getGroupPurchaseCommonData(cfgId)
	local success = LuaCodeInterface.Send(100502, cfgId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerEventGroupPurchase.getGroupPurchaseCommonDataResult(code, pod)
	warning("please override this function -> net_centerEventGroupPurchase.getGroupPurchaseCommonDataResult!")
end

function net_centerEventGroupPurchase.getGroupPurchaseCommonDataResult_delegate(code, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerEventGroupPurchase.getGroupPurchaseCommonDataResult(code, pod)
end

net_centerEventVote = {}

function net_centerEventVote.getVoteInfo(eventId)
	local success = LuaCodeInterface.Send(100602, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerEventVote.getVoteInfoResult(code, centerVoteDataPOD)
	warning("please override this function -> net_centerEventVote.getVoteInfoResult!")
end

function net_centerEventVote.getVoteInfoResult_delegate(code, centerVoteDataPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerEventVote.getVoteInfoResult(code, centerVoteDataPOD)
end

net_centerEventHelpNewbies = {}

function net_centerEventHelpNewbies.getFollowers(eventId)
	local success = LuaCodeInterface.Send(100702, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerEventHelpNewbies.getFollowersResult(code, retList)
	warning("please override this function -> net_centerEventHelpNewbies.getFollowersResult!")
end

function net_centerEventHelpNewbies.getFollowersResult_delegate(code, retList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerEventHelpNewbies.getFollowersResult(code, retList)
end

net_centerEventCupMatchVote = {}

function net_centerEventCupMatchVote.getVoteInfo(eventId)
	local success = LuaCodeInterface.Send(100802, eventId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerEventCupMatchVote.getVoteInfoResult(code, centerCupMatchVoteDataPOD)
	warning("please override this function -> net_centerEventCupMatchVote.getVoteInfoResult!")
end

function net_centerEventCupMatchVote.getVoteInfoResult_delegate(code, centerCupMatchVoteDataPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerEventCupMatchVote.getVoteInfoResult(code, centerCupMatchVoteDataPOD)
end

net_centerGuild = {}

function net_centerGuild.createGuild(name)
	local success = LuaCodeInterface.Send(100902, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.enterGuild()
	local success = LuaCodeInterface.Send(100903)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.exitGuild()
	local success = LuaCodeInterface.Send(100904)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.getRecommendGuildList()
	local success = LuaCodeInterface.Send(100905)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.applyGuild(id)
	local success = LuaCodeInterface.Send(100906, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.getMyApplyList()
	local success = LuaCodeInterface.Send(100907)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.cancelApplyGuild(id)
	local success = LuaCodeInterface.Send(100908, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.getAuditList()
	local success = LuaCodeInterface.Send(100909)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.refuseApply(pids)
	local success = LuaCodeInterface.Send(100910, pids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.acceptApply(pid)
	local success = LuaCodeInterface.Send(100911, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.getMemberList()
	local success = LuaCodeInterface.Send(100912)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.appointPosition(pid, postion)
	local success = LuaCodeInterface.Send(100913, pid, postion)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.removeMember(pid)
	local success = LuaCodeInterface.Send(100914, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.impeachment()
	local success = LuaCodeInterface.Send(100915)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.cancelImpeachment()
	local success = LuaCodeInterface.Send(100916)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.quit()
	local success = LuaCodeInterface.Send(100917)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.editInfo(headIcon, avatarFrame, policy, auditType)
	local success = LuaCodeInterface.Send(100918, headIcon, avatarFrame, policy, auditType)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.changeName(name)
	local success = LuaCodeInterface.Send(100919, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.searchGuild(txt)
	local success = LuaCodeInterface.Send(100920, txt)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.getGuildTrainingIntegral()
	local success = LuaCodeInterface.Send(100921)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.createGuildResult(code)
	warning("please override this function -> net_centerGuild.createGuildResult!")
end

function net_centerGuild.createGuildResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.createGuildResult(code)
end

function net_centerGuild.enterGuildResult(code, guildPOD)
	warning("please override this function -> net_centerGuild.enterGuildResult!")
end

function net_centerGuild.enterGuildResult_delegate(code, guildPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.enterGuildResult(code, guildPOD)
end

function net_centerGuild.exitGuildResult(code)
	warning("please override this function -> net_centerGuild.exitGuildResult!")
end

function net_centerGuild.exitGuildResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.exitGuildResult(code)
end

function net_centerGuild.getRecommendGuildListResult(code, guildBaseList)
	warning("please override this function -> net_centerGuild.getRecommendGuildListResult!")
end

function net_centerGuild.getRecommendGuildListResult_delegate(code, guildBaseList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.getRecommendGuildListResult(code, guildBaseList)
end

function net_centerGuild.applyGuildResult(code)
	warning("please override this function -> net_centerGuild.applyGuildResult!")
end

function net_centerGuild.applyGuildResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.applyGuildResult(code)
end

function net_centerGuild.getMyApplyListResult(code, guildBaseList)
	warning("please override this function -> net_centerGuild.getMyApplyListResult!")
end

function net_centerGuild.getMyApplyListResult_delegate(code, guildBaseList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.getMyApplyListResult(code, guildBaseList)
end

function net_centerGuild.cancelApplyGuildResult(code, guildId)
	warning("please override this function -> net_centerGuild.cancelApplyGuildResult!")
end

function net_centerGuild.cancelApplyGuildResult_delegate(code, guildId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.cancelApplyGuildResult(code, guildId)
end

function net_centerGuild.getAuditListResult(code, auditList)
	warning("please override this function -> net_centerGuild.getAuditListResult!")
end

function net_centerGuild.getAuditListResult_delegate(code, auditList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.getAuditListResult(code, auditList)
end

function net_centerGuild.refuseApplyResult(code, pids)
	warning("please override this function -> net_centerGuild.refuseApplyResult!")
end

function net_centerGuild.refuseApplyResult_delegate(code, pids)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.refuseApplyResult(code, pids)
end

function net_centerGuild.acceptApplyResult(code, pid)
	warning("please override this function -> net_centerGuild.acceptApplyResult!")
end

function net_centerGuild.acceptApplyResult_delegate(code, pid)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.acceptApplyResult(code, pid)
end

function net_centerGuild.getMemberListResult(code, members)
	warning("please override this function -> net_centerGuild.getMemberListResult!")
end

function net_centerGuild.getMemberListResult_delegate(code, members)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.getMemberListResult(code, members)
end

function net_centerGuild.appointPositionResult(code)
	warning("please override this function -> net_centerGuild.appointPositionResult!")
end

function net_centerGuild.appointPositionResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.appointPositionResult(code)
end

function net_centerGuild.removeMemberResult(code)
	warning("please override this function -> net_centerGuild.removeMemberResult!")
end

function net_centerGuild.removeMemberResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.removeMemberResult(code)
end

function net_centerGuild.impeachmentResult(code)
	warning("please override this function -> net_centerGuild.impeachmentResult!")
end

function net_centerGuild.impeachmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.impeachmentResult(code)
end

function net_centerGuild.cancelImpeachmentResult(code)
	warning("please override this function -> net_centerGuild.cancelImpeachmentResult!")
end

function net_centerGuild.cancelImpeachmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.cancelImpeachmentResult(code)
end

function net_centerGuild.quitResult(code)
	warning("please override this function -> net_centerGuild.quitResult!")
end

function net_centerGuild.quitResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.quitResult(code)
end

function net_centerGuild.editInfoResult(code)
	warning("please override this function -> net_centerGuild.editInfoResult!")
end

function net_centerGuild.editInfoResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.editInfoResult(code)
end

function net_centerGuild.changeNameResult(code)
	warning("please override this function -> net_centerGuild.changeNameResult!")
end

function net_centerGuild.changeNameResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.changeNameResult(code)
end

function net_centerGuild.searchGuildResult(code, guildBaseList)
	warning("please override this function -> net_centerGuild.searchGuildResult!")
end

function net_centerGuild.searchGuildResult_delegate(code, guildBaseList)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.searchGuildResult(code, guildBaseList)
end

function net_centerGuild.getGuildTrainingIntegralResult(code, centerGuildTrainingPlayerRanks)
	warning("please override this function -> net_centerGuild.getGuildTrainingIntegralResult!")
end

function net_centerGuild.getGuildTrainingIntegralResult_delegate(code, centerGuildTrainingPlayerRanks)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.getGuildTrainingIntegralResult(code, centerGuildTrainingPlayerRanks)
end

function net_centerGuild.notifyJoinGuild(guildId, guildName)
	warning("please override this function -> net_centerGuild.notifyJoinGuild!")
end

function net_centerGuild.notifyJoinGuild_delegate(guildId, guildName)
	net_centerGuild.notifyJoinGuild(guildId, guildName)
end

function net_centerGuild.notifyQuitGuild()
	warning("please override this function -> net_centerGuild.notifyQuitGuild!")
end

function net_centerGuild.notifyQuitGuild_delegate()
	net_centerGuild.notifyQuitGuild()
end

function net_centerGuild.notifyUpdateGuildBase(basePOD)
	warning("please override this function -> net_centerGuild.notifyUpdateGuildBase!")
end

function net_centerGuild.notifyUpdateGuildBase_delegate(basePOD)
	net_centerGuild.notifyUpdateGuildBase(basePOD)
end

function net_centerGuild.notifyUpdateGuild(pod)
	warning("please override this function -> net_centerGuild.notifyUpdateGuild!")
end

function net_centerGuild.notifyUpdateGuild_delegate(pod)
	net_centerGuild.notifyUpdateGuild(pod)
end

function net_centerGuild.notifyUpdateGuildFund(fund, fundDailyGetRecord)
	warning("please override this function -> net_centerGuild.notifyUpdateGuildFund!")
end

function net_centerGuild.notifyUpdateGuildFund_delegate(fund, fundDailyGetRecord)
	net_centerGuild.notifyUpdateGuildFund(fund, fundDailyGetRecord)
end

function net_centerGuild.upBuildingLevel(buildingId)
	local success = LuaCodeInterface.Send(100947, buildingId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.buyBuildingEffect(buildingId)
	local success = LuaCodeInterface.Send(100948, buildingId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.upBuildingLevelResult(code, building)
	warning("please override this function -> net_centerGuild.upBuildingLevelResult!")
end

function net_centerGuild.upBuildingLevelResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.upBuildingLevelResult(code, building)
end

function net_centerGuild.buyBuildingEffectResult(code, building)
	warning("please override this function -> net_centerGuild.buyBuildingEffectResult!")
end

function net_centerGuild.buyBuildingEffectResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.buyBuildingEffectResult(code, building)
end

function net_centerGuild.getQuestProgress()
	local success = LuaCodeInterface.Send(100951)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.getQuestProgressResult(code, progress)
	warning("please override this function -> net_centerGuild.getQuestProgressResult!")
end

function net_centerGuild.getQuestProgressResult_delegate(code, progress)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.getQuestProgressResult(code, progress)
end

function net_centerGuild.notifyNewAudit(newAuditCount)
	warning("please override this function -> net_centerGuild.notifyNewAudit!")
end

function net_centerGuild.notifyNewAudit_delegate(newAuditCount)
	net_centerGuild.notifyNewAudit(newAuditCount)
end

function net_centerGuild.editNotice(notice)
	local success = LuaCodeInterface.Send(100954, notice)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerGuild.editNoticeResult(code, notice)
	warning("please override this function -> net_centerGuild.editNoticeResult!")
end

function net_centerGuild.editNoticeResult_delegate(code, notice)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerGuild.editNoticeResult(code, notice)
end
