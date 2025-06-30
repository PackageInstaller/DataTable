-- chunkname: @IQIGame\\UIExternalApi\\LibraryMazeUIApi.lua

LibraryMazeUIApi = BaseLangApi:Extend()

function LibraryMazeUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnEvent", self.GetTextBtnEvent)
	self:RegisterApi("TextEventDes", self.GetTextEventDes)
	self:RegisterApi("TextBtnMonster", self.GetTextBtnMonster)
	self:RegisterApi("TextMonsterDes", self.GetTextMonsterDes)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("LockTitle1", self.GetLockTitle1)
	self:RegisterApi("LockTitle2", self.GetLockTitle2)
	self:RegisterApi("LockDes", self.GetLockDes)
	self:RegisterApi("EventEntityScale", self.GetEventEntityScale)
	self:RegisterApi("MsgViewTextTitle", self.GetMsgViewTextTitle)
	self:RegisterApi("MonsterPanelTitle", self.GetMonsterPanelTitle)
	self:RegisterApi("TextDefault", self.GetTextDefault)
	self:RegisterApi("TextMonsterTitle1", self.GetTextMonsterTitle1)
	self:RegisterApi("TextMonsterTitle2", self.GetTextMonsterTitle2)
	self:RegisterApi("TextMonsterTitle3", self.GetTextMonsterTitle3)
	self:RegisterApi("MonsterTextStart", self.GetMonsterTextStart)
	self:RegisterApi("MonsterStartPath", self.GetMonsterStartPath)
	self:RegisterApi("MonsterImgScale", self.GetMonsterImgScale)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("MonsterResType", self.GetMonsterResType)
	self:RegisterApi("MonsterResTypeName", self.GetMonsterResTypeName)
	self:RegisterApi("MonsterRace", self.GetMonsterRace)
	self:RegisterApi("MonsterRaceName", self.GetMonsterRaceName)
	self:RegisterApi("RaceTip", self.GetRaceTip)
	self:RegisterApi("EffectText", self.GetEffectText)
end

function LibraryMazeUIApi:GetMsgViewTextTitle()
	return self:GetCfgText(1106206)
end

function LibraryMazeUIApi:GetEffectText(str)
	str = self:SkillValueColor(str, 29)

	return str
end

function LibraryMazeUIApi:GetRaceTip(type)
	if type == 1 then
		return self:GetCfgText(1106201)
	elseif type == 2 then
		return self:GetCfgText(1106202)
	elseif type == 3 then
		return self:GetCfgText(1106203)
	elseif type == 4 then
		return self:GetCfgText(1106204)
	elseif type == 5 then
		return self:GetCfgText(1106205)
	end

	return self:GetCfgText(1106205)
end

function LibraryMazeUIApi:GetMonsterRaceName(type)
	if type == 1 then
		return self:GetCfgText(1106110)
	elseif type == 2 then
		return self:GetCfgText(1106111)
	elseif type == 3 then
		return self:GetCfgText(1106112)
	elseif type == 4 then
		return self:GetCfgText(1106113)
	elseif type == 5 then
		return self:GetCfgText(1106114)
	end

	return self:GetCfgText(1106115)
end

function LibraryMazeUIApi:GetMonsterRace(type)
	if type == 1 then
		return self:GetCfgText(1400003)
	elseif type == 2 then
		return self:GetCfgText(1400001)
	elseif type == 3 then
		return self:GetCfgText(1400002)
	elseif type == 4 then
		return self:GetCfgText(1400004)
	elseif type == 5 then
		return self:GetCfgText(1400005)
	end

	return self:GetCfgText(1400003)
end

function LibraryMazeUIApi:GetMonsterResTypeName(type)
	if type == 1 then
		return self:GetCfgText(1106116)
	elseif type == 2 then
		return self:GetCfgText(1106117)
	elseif type == 3 then
		return self:GetCfgText(1106118)
	elseif type == 4 then
		return self:GetCfgText(1106119)
	elseif type == 5 then
		return self:GetCfgText(1106120)
	elseif type == 6 then
		return self:GetCfgText(1106121)
	end

	return self:GetCfgText(1106116)
end

function LibraryMazeUIApi:GetMonsterResType(type)
	if type == 1 then
		return self:GetCfgText(1400006)
	elseif type == 2 then
		return self:GetCfgText(1400007)
	elseif type == 3 then
		return self:GetCfgText(1400008)
	elseif type == 4 then
		return self:GetCfgText(1400009)
	elseif type == 5 then
		return self:GetCfgText(1400010)
	elseif type == 6 then
		return self:GetCfgText(1400011)
	end

	return self:GetCfgText(1400011)
end

function LibraryMazeUIApi:GetTextLock()
	return self:GetCfgText(1106122)
end

function LibraryMazeUIApi:GetMonsterImgScale()
	return Vector3.New(1.8, 1.8, 1.8)
end

function LibraryMazeUIApi:GetMonsterStartPath(top)
	if top then
		return self:GetCfgText(1400013)
	end

	return self:GetCfgText(1400014)
end

function LibraryMazeUIApi:GetMonsterTextStart(index)
	local str = ""

	if index == 1 then
		str = self:GetCfgText(1106123)
	elseif index == 2 then
		str = self:GetCfgText(1106124)
	elseif index == 3 then
		str = self:GetCfgText(1106125)
	elseif index == 4 then
		str = self:GetCfgText(1106126)
	end

	return str
end

function LibraryMazeUIApi:GetTextMonsterTitle3(isEng)
	if isEng then
		return "SKILL"
	end

	return self:GetCfgText(1106127)
end

function LibraryMazeUIApi:GetTextMonsterTitle2(isEng)
	if isEng then
		return "ATTRIBUTE"
	end

	return self:GetCfgText(1106128)
end

function LibraryMazeUIApi:GetTextMonsterTitle1(isEng)
	if isEng then
		return self:GetCfgText(1213082)
	end

	return self:GetCfgText(1106129)
end

function LibraryMazeUIApi:GetTextDefault()
	return "？？？"
end

function LibraryMazeUIApi:GetMonsterPanelTitle()
	return self:GetCfgText(1106042)
end

function LibraryMazeUIApi:GetEventEntityScale()
	return Vector3.New(150, 150, 150)
end

function LibraryMazeUIApi:GetLockDes()
	return self:GetCfgText(1106130)
end

function LibraryMazeUIApi:GetLockTitle2()
	return self:GetCfgText(1106019)
end

function LibraryMazeUIApi:GetLockTitle1()
	return "?????"
end

function LibraryMazeUIApi:GetTextReward(num1, num2)
	local per = math.floor(num1 / num2 * 100)

	if per == 0 and num1 > 0 then
		per = 1
	end

	return string.format(self:GetCfgText(1106107) .. "：%s", per .. "%")
end

function LibraryMazeUIApi:GetTextMonsterDes()
	return self:GetCfgText(1106132)
end

function LibraryMazeUIApi:GetTextBtnMonster()
	return self:GetCfgText(1106042)
end

function LibraryMazeUIApi:GetTextEventDes()
	return self:GetCfgText(1106133)
end

function LibraryMazeUIApi:GetTextBtnEvent()
	return self:GetCfgText(1106131)
end

function LibraryMazeUIApi:GetTextTitle()
	return self:GetCfgText(49)
end

LibraryMazeUIApi:Init()
