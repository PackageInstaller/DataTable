-- chunkname: @IQIGame\\UIExternalApi\\LibraryNewsUIApi.lua

LibraryNewsUIApi = BaseLangApi:Extend()

function LibraryNewsUIApi:Init()
	self:RegisterApi("NewsType1", self.GetNewsType1)
	self:RegisterApi("NewsType2", self.GetNewsType2)
	self:RegisterApi("NewsTypeDes1", self.GetNewsTypeDes1)
	self:RegisterApi("NewsTypeDes2", self.GetNewsTypeDes2)
	self:RegisterApi("TextNewsTitle", self.GetTextNewsTitle)
	self:RegisterApi("TextWeatherTitle", self.GetTextWeatherTitle)
	self:RegisterApi("NewsTypePath", self.GetNewsTypePath)
	self:RegisterApi("TextUnLockError", self.GetTextUnLockError)
	self:RegisterApi("TextReward", self.GetTextReward)
end

function LibraryNewsUIApi:GetTextReward(num1, num2)
	local per = math.floor(num1 / num2 * 100)

	if per == 0 and num1 > 0 then
		per = 1
	end

	return string.format(self:GetCfgText(1104205) .. "：%s", per .. "%")
end

function LibraryNewsUIApi:GetTextUnLockError()
	return self:GetCfgText(1015180)
end

function LibraryNewsUIApi:GetNewsTypePath(type)
	if type == 1 then
		return self:GetResUrl(1402001)
	end

	return self:GetResUrl(1402002)
end

function LibraryNewsUIApi:GetTextWeatherTitle()
	return self:GetCfgText(1104200)
end

function LibraryNewsUIApi:GetTextNewsTitle()
	return self:GetCfgText(1106047)
end

function LibraryNewsUIApi:GetNewsTypeDes2()
	return self:GetCfgText(1104201)
end

function LibraryNewsUIApi:GetNewsTypeDes1()
	return self:GetCfgText(1104202)
end

function LibraryNewsUIApi:GetNewsType2()
	return self:GetCfgText(1104203)
end

function LibraryNewsUIApi:GetNewsType1()
	return self:GetCfgText(1104204)
end

LibraryNewsUIApi:Init()
