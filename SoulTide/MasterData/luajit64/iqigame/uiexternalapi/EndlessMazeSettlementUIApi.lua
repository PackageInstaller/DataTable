-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeSettlementUIApi.lua

EndlessMazeSettlementUIApi = BaseLangApi:Extend()

function EndlessMazeSettlementUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ScoreLabel", self.GetScoreLabel)
	self:RegisterApi("DangerLabel", self.GetDangerLabel)
	self:RegisterApi("BoxEffects", self.GetBoxEffects)
	self:RegisterApi("BoxNumText", self.GetBoxNumText)
	self:RegisterApi("OpenAllBtnText", self.GetOpenAllBtnText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("DangerValue", self.GetDangerValue)
end

function EndlessMazeSettlementUIApi:GetTitleText()
	return self:GetCfgText(2300053), self:GetCfgText(2300054)
end

function EndlessMazeSettlementUIApi:GetScoreLabel()
	return self:GetCfgText(2200074)
end

function EndlessMazeSettlementUIApi:GetDangerLabel()
	return self:GetCfgText(2200018)
end

function EndlessMazeSettlementUIApi:GetBoxEffects()
	return {
		{
			9001601,
			9001611,
			9001621
		},
		{
			9001602,
			9001612,
			9001622
		},
		{
			9001603,
			9001613,
			9001623
		},
		{
			9001604,
			9001614,
			9001624
		},
		{
			9001605,
			9001615,
			9001625
		}
	}
end

function EndlessMazeSettlementUIApi:GetBoxNumText(num)
	return "X" .. num
end

function EndlessMazeSettlementUIApi:GetOpenAllBtnText()
	return self:GetCfgText(2200075)
end

function EndlessMazeSettlementUIApi:GetCloseBtnText()
	return self:GetCfgText(2200076)
end

function EndlessMazeSettlementUIApi:GetDangerValue(monsterGrade, endlessPowerCid)
	return math.round((monsterGrade * 0.2 + 1) * 10 * (1 + endlessPowerCid * 0.1))
end

EndlessMazeSettlementUIApi:Init()
