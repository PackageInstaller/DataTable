local ETaskConditionType = {}
ETaskConditionType.LevelUp = 1              --账号等级达到N
ETaskConditionType.PassMainMissionTimes = 2      --通关N次任意主线副本
ETaskConditionType.PassMainEliteMissionTimes = 3 --通关N次任意精英副本
ETaskConditionType.UpGradeAnyGirlTimes = 4  --升级任意少女N次
ETaskConditionType.BreakUpAnyGirlTimes = 5  --突破任意少女N次
ETaskConditionType.GetOnlineAwardTimes = 6  --领取挂机奖励N次
ETaskConditionType.BuyAnyItemTimes = 7      --商城购买任意道具N次
ETaskConditionType.EnterBedroomTimes = 8      --进入宿舍N次
ETaskConditionType.TouchAnyGirlTims = 9      --触摸任意少女N次
ETaskConditionType.PassSpecificMainMissionTimes = 10      --通关主线副本N-Y
ETaskConditionType.PassSpecificEliteMissionTimes = 11      --通关精英副本N-Y
ETaskConditionType.BridgeLevelUpTo = 12      --飞船舰桥等级达到N
ETaskConditionType.ManufacturingCabinLevelUpTo = 13      --飞船N个制造舱等级达到N
ETaskConditionType.MadeManufacturingCabinNumber = 14      --飞船N个训练室等级达到N
ETaskConditionType.GainManufacturingCabinAward = 15      --领取N次制造舱的奖励
ETaskConditionType.CommunicationRoomLevelUp = 18     --飞船通讯室等级达到N
ETaskConditionType.BedroomLevelUp = 19     --飞船N个宿舍等级达到N
ETaskConditionType.MadeBedroomNumber = 20     --飞船建造N各宿舍
ETaskConditionType.BedroomAtmosphereUpTo = 21     --飞船宿舍总氛围值达到N
ETaskConditionType.FinishCommonLotteryTimes = 22     --完成N次常规抽卡


return ETaskConditionType 

