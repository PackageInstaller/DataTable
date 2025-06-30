-- chunkname: @IQIGame\\UIExternalApi\\MazeApi.lua

MazeApi = BaseLangApi:Extend()

function MazeApi:Init()
	return
end

function MazeApi:GetTypeImgResourcePath(type)
	if type < 10 then
		type = "0" .. type
	end

	return UIGlobalApi.GetIconPath("/Common/Icon_Attr_0" .. type .. ".png")
end

function MazeApi:GetOrbmentBottomBgByType(type)
	return string.format(self:GetResUrl(3012), type)
end

function MazeApi:GetHeroElementImg(type)
	return string.format(self:GetResUrl(3004), type)
end

function MazeApi:GetTypeName(type)
	if type == MazeModule.ElementEnum.Wind then
		return self:GetCfgText(102)
	elseif type == MazeModule.ElementEnum.Fire then
		return self:GetCfgText(103)
	elseif type == MazeModule.ElementEnum.Thunder then
		return self:GetCfgText(104)
	elseif type == MazeModule.ElementEnum.Water then
		return self:GetCfgText(105)
	elseif type == MazeModule.ElementEnum.Soil then
		return self:GetCfgText(106)
	elseif type == MazeModule.ElementEnum.Yin then
		return self:GetCfgText(107)
	elseif type == MazeModule.ElementEnum.Yang then
		return self:GetCfgText(108)
	else
		return "None"
	end
end

function MazeApi:GetTypeNameAndDesc(type)
	return self:GetTypeName(type) .. MazeApi:GetElementPromptText()
end

function MazeApi:GetElementPromptText()
	return self:GetCfgText(240008)
end

function MazeApi:GetTypeTextColor(type)
	if type == MazeModule.ElementEnum.Wind then
		return ColorCfg.Maze.Wind
	elseif type == MazeModule.ElementEnum.Fire then
		return ColorCfg.Maze.Fire
	elseif type == MazeModule.ElementEnum.Thunder then
		return ColorCfg.Maze.Thunder
	elseif type == MazeModule.ElementEnum.Water then
		return ColorCfg.Maze.Water
	elseif type == MazeModule.ElementEnum.Soil then
		return ColorCfg.Maze.Soil
	elseif type == MazeModule.ElementEnum.Yin then
		return ColorCfg.Black
	elseif type == MazeModule.ElementEnum.Yang then
		return ColorCfg.White
	else
		return ColorCfg.Maze.DarkGrey
	end
end

function MazeApi:GetTimeFormat(state)
	if state == 1 then
		return self:GetCfgText(240004)
	elseif state == 2 then
		return self:GetCfgText(240005)
	elseif state == 3 then
		return self:GetCfgText(240006)
	end

	return self:GetCfgText(240007)
end

function MazeApi:GetSeatNormalBG(type)
	return string.format(self:GetResUrl(3008), type)
end

function MazeApi:GetSeatLockBG(type)
	return string.format(self:GetResUrl(3007), type)
end

function MazeApi:GetSeatEffectImg(type, effectId)
	return string.format(self:GetResUrl(3006), type, effectId)
end

function MazeApi:GetEffectBottomImage(type)
	if type == MazeModule.ElementEnum.Yin then
		return string.format(self:GetResUrl(3010), 1)
	else
		return string.format(self:GetResUrl(3010), 2)
	end
end

function MazeApi:GetSeatElementBG(type)
	return string.format(self:GetResUrl(3002), type)
end

function MazeApi:GetGemElementBG(type)
	if type == MazeModule.ElementEnum.Yin then
		return string.format(self:GetResUrl(3011), 1)
	else
		return string.format(self:GetResUrl(3011), 2)
	end
end

function MazeApi:GetSeatElementImage(type)
	return string.format(self:GetResUrl(3005), type)
end

function MazeApi:GetOrbmentImgByType(type)
	return string.format(self:GetResUrl(3009), type)
end

function MazeApi:GetOrbmentNameByType(type)
	if type == 1 then
		return self:GetCfgText(240001)
	elseif type == 2 then
		return self:GetCfgText(240002)
	elseif type == 3 then
		return self:GetCfgText(240003)
	else
		return "NONE"
	end
end

function MazeApi:GetSeatEffectId(effectType, type)
	if effectType == 1 then
		if type == 1 then
			return 10013
		elseif type == 2 then
			return 10014
		elseif type == 3 then
			return 10015
		end
	elseif effectType == 2 then
		if type == 1 then
			return 10010
		elseif type == 2 then
			return 10011
		elseif type == 3 then
			return 10012
		end
	end
end

function MazeApi:MontageMazeTreasureChestText(text, costList)
	if costList == nil then
		return text
	end

	if #costList < 2 then
		return text
	end

	return text .. "-" .. costList[2]
end

function MazeApi:GetSenroUIPointText(value)
	return "可用森罗点:" .. value
end

function MazeApi:GetMazeStageDiffCNText(index)
	if index == 1 then
		return "普通"
	elseif index == 2 then
		return "困难"
	elseif index == 3 then
		return "噩梦"
	end
end

function MazeApi:GetBuffQualityTitle(quality)
	if quality == 3 then
		return "通常"
	elseif quality == 4 then
		return "稀有"
	elseif quality == 5 then
		return "传说"
	else
		return "未配置类型"
	end
end

function MazeApi:GetSelectBuffBackground(quality)
	return string.format("Assets/05_Images/UI/Maze/MazeBattleUI/MazeBattleBuff/ChooseBuff_Img_%s.png", quality)
end

function MazeApi:GetSelectBuffFrame(quality)
	return string.format("Assets/05_Images/UI/Maze/MazeBattleUI/MazeBattleBuff/MazeBattleBuff_Frame_%s.png", quality)
end

function MazeApi:GetBuffTitleFrame(quality)
	return string.format("Assets/05_Images/UI/Maze/MazeBattleUI/MazeBattleBuff/MazeBattleBuff_Tittle_Frame_%s.png", quality)
end

function MazeApi:GetMazeMapTagText(tag)
	if tag == Constant.MazeEventType.Battle then
		return "战斗"
	elseif tag == Constant.MazeEventType.TreasureChest then
		return "宝箱"
	elseif tag == Constant.MazeEventType.SelectBuff then
		return "营地"
	elseif tag == Constant.MazeEventType.Businessman then
		return "商人"
	elseif tag == Constant.MazeEventType.Video or tag == Constant.MazeEventType.DialogueInteractive or tag == Constant.MazeEventType.MazeInteractive then
		return "迷宫交互"
	elseif tag == Constant.MazeEventType.Portal then
		return "传送门"
	end

	return "未知类型"
end

function MazeApi:GetMazeMapTagImg(type, isFinish)
	local imgUrl = ""

	if type == Constant.MazeEventType.Battle then
		if isFinish then
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_01_F.png"
		else
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_01.png"
		end
	elseif type == Constant.MazeEventType.TreasureChest then
		if isFinish then
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_02_F.png"
		else
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_02.png"
		end
	elseif type == Constant.MazeEventType.SelectBuff then
		if isFinish then
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_01_F.png"
		else
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_01.png"
		end
	elseif type == Constant.MazeEventType.Businessman then
		imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_04.png"
	elseif type == Constant.MazeEventType.Video or type == Constant.MazeEventType.DialogueInteractive or type == Constant.MazeEventType.MazeInteractive then
		if isFinish then
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_06_F.png"
		else
			imgUrl = "Assets/05_Images/Labyrinth/EventType/Typeicon_06.png"
		end
	elseif type == Constant.MazeEventType.Portal then
		imgUrl = isFinish and "Assets/05_Images/Labyrinth/EventType/Typeicon_06_F.png" or "Assets/05_Images/Labyrinth/EventType/Typeicon_06.png"
	end

	return imgUrl
end

function MazeApi:GetMazeSeasonText(season)
	return string.format("第%s赛季", season)
end

function MazeApi:GetMazeLvText(lv)
	return string.format("%s级", lv)
end

function MazeApi:GetJumpTips(consumeNum)
	return string.format(self:GetCfgText(240009), consumeNum)
end

function MazeApi:GetPlayerEntityID(sex)
	if sex == Constant.PlayerSex.Man then
		return 10810001
	else
		return 10810002
	end
end

function MazeApi:GetPlayVideoTips(stroyName)
	return self:GetCfgText(240011)
end

function MazeApi:GetWalkSoundId()
	return 22000026
end

function MazeApi:GetChangeRoomSoundId()
	return 22000142
end

function MazeApi:GetMonsterTypeTitle(monsterType)
	if monsterType == -1 then
		return self:GetCfgText(6090004)
	elseif monsterType == 1 then
		return self:GetCfgText(6090005)
	elseif monsterType == 2 then
		return self:GetCfgText(6090006)
	elseif monsterType == 3 then
		return self:GetCfgText(6090007)
	elseif monsterType == 4 then
		return self:GetCfgText(6090008)
	end
end

function MazeApi:GetkillMonsterSettlementTitle(monsterType)
	return string.format(self:GetCfgText(240012), self:GetMonsterTypeTitle(monsterType))
end

function MazeApi:GetGetItemSettlementTitle(itemName)
	return string.format(self:GetCfgText(240013), itemName)
end

function MazeApi:UpgradeConditionTitle()
	return string.format("条件：")
end

function MazeApi:GetCNLevelText(level)
	if level == 1 then
		return self:GetCfgText(240015)
	elseif level == 2 then
		return self:GetCfgText(240016)
	elseif level == 3 then
		return self:GetCfgText(240017)
	elseif level == 4 then
		return self:GetCfgText(240018)
	elseif level == 5 then
		return self:GetCfgText(240019)
	elseif level == 6 then
		return self:GetCfgText(240020)
	elseif level == 7 then
		return self:GetCfgText(240021)
	elseif level == 8 then
		return self:GetCfgText(240022)
	elseif level == 9 then
		return self:GetCfgText(240023)
	elseif level == 10 then
		return self:GetCfgText(240024)
	end
end

function MazeApi:GetENLevelText(level)
	if level == 1 then
		return self:GetCfgText(240026)
	elseif level == 2 then
		return self:GetCfgText(240027)
	elseif level == 3 then
		return self:GetCfgText(240028)
	elseif level == 4 then
		return self:GetCfgText(240029)
	elseif level == 5 then
		return self:GetCfgText(240030)
	elseif level == 6 then
		return self:GetCfgText(240031)
	elseif level == 7 then
		return self:GetCfgText(240032)
	elseif level == 8 then
		return self:GetCfgText(240033)
	elseif level == 9 then
		return self:GetCfgText(240034)
	elseif level == 10 then
		return self:GetCfgText(240035)
	end
end

function MazeApi:GetCNLevelTextAndSuffix(level)
	return self:GetCNLevelText(level) .. self:GetCfgText(240025)
end

function MazeApi:GetMoodStageImage(index)
	return string.format("Assets/05_Images/UI/Maze/MazeBattleUI/MazeBattleStage/MazeBattleStage_Icon_0%s.png", index)
end

function MazeApi:GetMoodEffect(index)
	if index == 5 then
		return 11001
	elseif index == 4 then
		return 11002
	elseif index == 3 then
		return 11003
	elseif index == 2 then
		return 11004
	elseif index == 1 then
		return 11005
	else
		return 11005
	end
end

function MazeApi:GetMoodChangeEffect(isUp)
	if isUp then
		return 11007
	else
		return 11006
	end
end

function MazeApi:GetActiveSenroTalentEffect()
	return 11009
end

function MazeApi:GetMazeUIBGMID()
	return 11000013
end

MazeApi:Init()
