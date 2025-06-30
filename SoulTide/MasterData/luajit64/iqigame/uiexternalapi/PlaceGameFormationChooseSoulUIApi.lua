-- chunkname: @IQIGame\\UIExternalApi\\PlaceGameFormationChooseSoulUIApi.lua

PlaceGameFormationChooseSoulUIApi = BaseLangApi:Extend()

function PlaceGameFormationChooseSoulUIApi:Init()
	self:RegisterApi("SoulPortraitPath", self.GetSoulPortraitPath)
	self:RegisterApi("SoulInfoLevelText", self.GetSoulInfoLevelText)
end

function PlaceGameFormationChooseSoulUIApi:GetSoulInfoLevelText(level)
	return string.format("LV.%s", level)
end

function PlaceGameFormationChooseSoulUIApi:GetSoulPortraitPath(soulCid, soulResCid)
	return UIGlobalApi.GetSoulPortraitPath(soulCid, soulResCid)
end

PlaceGameFormationChooseSoulUIApi:Init()
