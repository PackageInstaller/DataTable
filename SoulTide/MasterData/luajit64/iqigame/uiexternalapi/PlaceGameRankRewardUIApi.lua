-- chunkname: @IQIGame\\UIExternalApi\\PlaceGameRankRewardUIApi.lua

PlaceGameRankRewardUIApi = BaseLangApi:Extend()

function PlaceGameRankRewardUIApi:Init()
	self:RegisterApi("TextRewardIndex", self.GetTextRewardIndex)
end

function PlaceGameRankRewardUIApi:GetTextRewardIndex(num1, num2, type)
	if type == 1 and num1 > 3 then
		return string.format("%s-%s", num1, num2)
	elseif type == 2 then
		if num1 == 1 then
			return string.format("1001-" .. "%s" .. "%%", num2)
		elseif num1 > 1 then
			return string.format("%s" .. "%%-" .. "%s" .. "%%", num1, num2)
		end
	end

	return ""
end

PlaceGameRankRewardUIApi:Init()
