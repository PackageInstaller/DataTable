local EGameKeyNode = {}

EGameKeyNode.Gift = 1 --送礼
EGameKeyNode.MissionVictory = 2 --关卡胜利
EGameKeyNode.GetAward = 3 --获得奖励 （弃用）
EGameKeyNode.AccountLevelUp = 4 --账号升级
EGameKeyNode.OtakuBrigeLevelUp = 5 --舰桥升级
EGameKeyNode.OtakuBuildFinishRoom = 6 --制造舱建造成功，回调中含 OtakuType.OtakuRoomType (检测时机表中id=6~9)
EGameKeyNode.OtakuProduceRoomUp = 8 --制造舱升级成功，回调中含 OtakuType.OtakuRoomType (检测时机表中id=6~9)
EGameKeyNode.ExpeditionEndByWechat = 10 --远征结束触发微信对话
EGameKeyNode.HerosBreach = 11 --战员突破
EGameKeyNode.LoginGameToMainScene = 12 --登录游戏到主场景
EGameKeyNode.AddFriends = 13 --添加好友
EGameKeyNode.CommanderSkillsUnLock = 14 --解锁指挥官技能
EGameKeyNode.CommanderSkillsUp = 15 --指挥官技能升级
EGameKeyNode.HerosLevelUp = 16 --战员升级
EGameKeyNode.HerosStarUp = 17 --战员觉醒
EGameKeyNode.GetHeros = 18 --获得战员
EGameKeyNode.HerosSkillUp = 19 --战员技能升级
EGameKeyNode.MainLevelFinish = 20 --主线关卡通关
EGameKeyNode.EliteLevelFinish = 21 --精英关卡通关 
EGameKeyNode.ResLevelFinish = 22 --资源关卡通关
EGameKeyNode.EncounterLevelFinish = 23 --遭遇关卡通关
EGameKeyNode.DailyTasksRewarded = 24 --日常任务奖励领取
EGameKeyNode.WeekTasksRewarded = 25 --周常任务奖励领取
EGameKeyNode.ChallengeTasksRewarded = 26 --挑战任务奖励领取
EGameKeyNode.CommanderTasksRewarded = 27 --长官指南任务奖励领取
EGameKeyNode.ElevenDrawTrigger = 28 --触发11抽
EGameKeyNode.OtakuBuildItemReceived = 29 --制造舱领取道具
EGameKeyNode.OtakuCanteenFoodReceived = 30 --餐厅菜品领取
EGameKeyNode.FoodMenuUnLock = 31 --菜单解锁
EGameKeyNode.OtakuCanteenHerosEating = 32 --战员进入餐厅用餐
EGameKeyNode.ExpeditionTasksRewarded = 33 --远征任务奖励领取
EGameKeyNode.HerosFavorAbilityUp = 34 --战员好感度提升
EGameKeyNode.HerosPersonalLevelUnLock = 35 --战员个人副本解说
EGameKeyNode.DromSpecialTrigger = 36 --宿舍特殊事件
EGameKeyNode.CommanderNoteUnLock = 37 --长官笔记解锁
EGameKeyNode.EncyclopaediaUnLock = 38 --百科全书解锁
EGameKeyNode.AtlasUnLock = 39 --土建结束
EGameKeyNode.AfterMainScene = 40 --第一次进入主界面后动态申请数据完成
return EGameKeyNode