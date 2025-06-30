-- chunkname: @IQIGame\\UIExternalApi\\ScrollMazeMainUIApi.lua

ScrollMazeMainUIApi = BaseLangApi:Extend()

function ScrollMazeMainUIApi:Init()
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("ScoreLabelText", self.GetScoreLabelText)
	self:RegisterApi("ScoreText", self.GetScoreText)
	self:RegisterApi("ScoreInfoBoxImagePaths", self.GetScoreInfoBoxImagePaths)
	self:RegisterApi("EngravingBtnText", self.GetEngravingBtnText)
	self:RegisterApi("MazeTopRightRuneNoticeTypeText", self.GetMazeTopRightRuneNoticeTypeText)
	self:RegisterApi("StartTitleText", self.GetStartTitleText)
	self:RegisterApi("StartTipText", self.GetStartTipText)
	self:RegisterApi("ScoreBoxEffect", self.GetScoreBoxEffect)
	self:RegisterApi("StartRuneEffectCid", self.GetStartRuneEffectCid)
	self:RegisterApi("FlyRuneEffectCid", self.GetFlyRuneEffectCid)
	self:RegisterApi("DangerLabel", self.GetDangerLabel)
	self:RegisterApi("DangerText", self.GetDangerText)
	self:RegisterApi("DangerOutlineColor", self.GetDangerOutlineColor)
	self:RegisterApi("DangerLabelBg", self.GetDangerLabelBg)
end

function ScrollMazeMainUIApi:GetMazeNameText(chapterOrder, order, name)
	return name
end

function ScrollMazeMainUIApi:GetScoreLabelText()
	return self:GetCfgText(2200301)
end

function ScrollMazeMainUIApi:GetScoreText(score)
	return score
end

function ScrollMazeMainUIApi:GetScoreInfoBoxImagePaths()
	return {
		self:GetResUrl(1100004),
		self:GetResUrl(1100005),
		self:GetResUrl(1100006),
		self:GetResUrl(1100007),
		self:GetResUrl(1100008)
	}
end

function ScrollMazeMainUIApi:GetEngravingBtnText()
	return self:GetCfgText(2200010)
end

function ScrollMazeMainUIApi:GetMazeTopRightRuneNoticeTypeText(type)
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

function ScrollMazeMainUIApi:GetStartTitleText()
	return self:GetCfgText(2200302)
end

function ScrollMazeMainUIApi:GetStartTipText(conditionsDesc)
	return ""
end

function ScrollMazeMainUIApi:GetScoreBoxEffect(type)
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

function ScrollMazeMainUIApi:GetStartRuneEffectCid(quality)
	if quality == 1 then
		return 9001641
	elseif quality == 2 then
		return 9001642
	elseif quality == 3 then
		return 9001643
	end
end

function ScrollMazeMainUIApi:GetFlyRuneEffectCid(quality)
	if quality == 1 then
		return 9001644
	elseif quality == 2 then
		return 9001645
	elseif quality == 3 then
		return 9001646
	end
end

function ScrollMazeMainUIApi:GetDangerLabel(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return self.TextColor[201] .. self:GetCfgText(2200018) .. self.TextColor[0]
	elseif monsterGrade < 8 then
		return self.TextColor[206] .. self:GetCfgText(2200018) .. self.TextColor[0]
	else
		return self.TextColor[41] .. self:GetCfgText(2200018) .. self.TextColor[0]
	end
end

function ScrollMazeMainUIApi:GetDangerText(monsterGrade, endlessPowerCid, chapterType)
	if chapterType == 8 then
		if monsterGrade < 4 then
			return self.TextColor[201] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 1000) * 0.1)) .. self.TextColor[0]
		elseif monsterGrade < 8 then
			return self.TextColor[206] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 1000) * 0.1)) .. self.TextColor[0]
		else
			return self.TextColor[41] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 1000) * 0.1)) .. self.TextColor[0]
		end
	elseif monsterGrade < 4 then
		return self.TextColor[201] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 2000) * 0.1)) .. self.TextColor[0]
	elseif monsterGrade < 8 then
		return self.TextColor[206] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 2000) * 0.1)) .. self.TextColor[0]
	else
		return self.TextColor[41] .. math.round((monsterGrade * 0.2 + 1) * 10 * (1 + (endlessPowerCid - 2000) * 0.1)) .. self.TextColor[0]
	end
end

function ScrollMazeMainUIApi:GetDangerOutlineColor(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return "#238c4d"
	elseif monsterGrade < 8 then
		return "#9a5823"
	else
		return "#b10000"
	end
end

function ScrollMazeMainUIApi:GetDangerLabelBg(monsterGrade, endlessPowerCid)
	if monsterGrade < 4 then
		return self:GetResUrl(1100001)
	elseif monsterGrade < 8 then
		return self:GetResUrl(1100002)
	else
		return self:GetResUrl(1100003)
	end
end

ScrollMazeMainUIApi:Init()
