-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeMainUIApi.lua

EndlessMazeMainUIApi = BaseLangApi:Extend()
EndlessMazeMainUIApi.ShowTypeAttrMap = {
	{
		7,
		11,
		12,
		15,
		17,
		19,
		20,
		21,
		22,
		23,
		24,
		77,
		26
	},
	{
		49,
		50,
		51,
		53,
		54,
		32
	},
	{
		41,
		42,
		37,
		38,
		39
	},
	{
		47,
		48,
		43,
		44,
		45,
		59,
		60,
		55,
		56,
		57,
		33
	}
}

function EndlessMazeMainUIApi:Init()
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("ScoreLabelText", self.GetScoreLabelText)
	self:RegisterApi("ScoreText", self.GetScoreText)
	self:RegisterApi("ScoreInfoTipBoxNumText", self.GetScoreInfoTipBoxNumText)
	self:RegisterApi("ScoreInfoBoxImagePaths", self.GetScoreInfoBoxImagePaths)
	self:RegisterApi("EngravingBtnText", self.GetEngravingBtnText)
	self:RegisterApi("MazeTopRightRuneNoticeTypeText", self.GetMazeTopRightRuneNoticeTypeText)
	self:RegisterApi("StartTitleText", self.GetStartTitleText)
	self:RegisterApi("StartTipText", self.GetStartTipText)
	self:RegisterApi("NextRewardTipDescText", self.GetNextRewardTipDescText)
	self:RegisterApi("ScoreBarBoxEffect", self.GetScoreBarBoxEffect)
	self:RegisterApi("ScoreBoxEffect", self.GetScoreBoxEffect)
	self:RegisterApi("StartRuneEffectCid", self.GetStartRuneEffectCid)
	self:RegisterApi("FlyRuneEffectCid", self.GetFlyRuneEffectCid)
	self:RegisterApi("DangerLabel", self.GetDangerLabel)
	self:RegisterApi("DangerText", self.GetDangerText)
	self:RegisterApi("DangerOutlineColor", self.GetDangerOutlineColor)
	self:RegisterApi("DangerLabelBg", self.GetDangerLabelBg)
end

function EndlessMazeMainUIApi:GetMazeNameText(chapterOrder, order, name)
	return name
end

function EndlessMazeMainUIApi:GetScoreLabelText()
	return self:GetCfgText(2100007)
end

function EndlessMazeMainUIApi:GetScoreText(score, maxScore)
	return score .. "/" .. maxScore
end

function EndlessMazeMainUIApi:GetScoreInfoTipBoxNumText(num)
	return "X" .. num
end

function EndlessMazeMainUIApi:GetScoreInfoBoxImagePaths()
	return {
		self:GetResUrl(1100004),
		self:GetResUrl(1100005),
		self:GetResUrl(1100006),
		self:GetResUrl(1100007),
		self:GetResUrl(1100008)
	}
end

function EndlessMazeMainUIApi:GetEngravingBtnText()
	return self:GetCfgText(2200010)
end

function EndlessMazeMainUIApi:GetMazeTopRightRuneNoticeTypeText(type)
	if type == 2 then
		return self:GetCfgText(2200011)
	elseif type == 3 then
		return self:GetCfgText(2200012)
	elseif type == 4 then
		return self:GetCfgText(2200013)
	elseif type == 5 then
		return self:GetCfgText(2200014)
	end
end

function EndlessMazeMainUIApi:GetStartTitleText()
	return self:GetCfgText(2200015)
end

function EndlessMazeMainUIApi:GetStartTipText(conditionsDesc)
	return ""
end

function EndlessMazeMainUIApi:GetNextRewardTipDescText(score, rewardScore)
	return self:GetCfgText(2200016) .. rewardScore - score .. self:GetCfgText(2200017)
end

function EndlessMazeMainUIApi:GetScoreBarBoxEffect(type)
	if type == 1 then
		return 9001628
	elseif type == 2 then
		return 9001629
	elseif type == 3 then
		return 9001630
	elseif type == 4 then
		return 9001631
	elseif type == 5 then
		return 9001632
	end
end

function EndlessMazeMainUIApi:GetScoreBoxEffect(type)
	if type == 1 then
		return 9001633
	elseif type == 2 then
		return 9001634
	elseif type == 3 then
		return 9001635
	elseif type == 4 then
		return 9001636
	elseif type == 5 then
		return 9001637
	end
end

function EndlessMazeMainUIApi:GetStartRuneEffectCid(quality)
	if quality == 1 then
		return 9001641
	elseif quality == 2 then
		return 9001642
	elseif quality == 3 then
		return 9001643
	end
end

function EndlessMazeMainUIApi:GetFlyRuneEffectCid(quality)
	if quality == 1 then
		return 9001644
	elseif quality == 2 then
		return 9001645
	elseif quality == 3 then
		return 9001646
	end
end

function EndlessMazeMainUIApi:GetDangerLabel(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return self.TextColor[201] .. self:GetCfgText(2200018) .. self.TextColor[0]
	elseif monsterGrade < 8 then
		return self.TextColor[206] .. self:GetCfgText(2200018) .. self.TextColor[0]
	else
		return self.TextColor[41] .. self:GetCfgText(2200018) .. self.TextColor[0]
	end
end

function EndlessMazeMainUIApi:GetDangerText(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return self.TextColor[201] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + endlessPowerCid * 0.1)) .. self.TextColor[0]
	elseif monsterGrade < 8 then
		return self.TextColor[206] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + endlessPowerCid * 0.1)) .. self.TextColor[0]
	else
		return self.TextColor[41] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + endlessPowerCid * 0.1)) .. self.TextColor[0]
	end
end

function EndlessMazeMainUIApi:GetDangerOutlineColor(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return "#238c4d"
	elseif monsterGrade < 8 then
		return "#9a5823"
	else
		return "#b10000"
	end
end

function EndlessMazeMainUIApi:GetDangerLabelBg(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return self:GetResUrl(1100001)
	elseif monsterGrade < 8 then
		return self:GetResUrl(1100002)
	else
		return self:GetResUrl(1100003)
	end
end

EndlessMazeMainUIApi:Init()
