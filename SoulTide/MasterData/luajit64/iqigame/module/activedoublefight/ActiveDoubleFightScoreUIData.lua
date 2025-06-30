-- chunkname: @IQIGame\\Module\\ActiveDoubleFight\\ActiveDoubleFightScoreUIData.lua

ActiveDoubleFightScoreUIData = {}

function ActiveDoubleFightScoreUIData.New(type, value, maxValue, scoreValue)
	local o = Clone(ActiveDoubleFightScoreUIData)

	o:Init(type, value, maxValue, scoreValue)

	return o
end

function ActiveDoubleFightScoreUIData:Init(type, value, maxValue, scoreValue)
	self.type = type
	self.value = value
	self.maxValue = maxValue
	self.scoreValue = scoreValue
end

return ActiveDoubleFightScoreUIData
