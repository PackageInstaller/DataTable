-- chunkname: @IQIGame\\UIExternalApi\\SoulUnlockUIApi.lua

SoulUnlockUIApi = BaseLangApi:Extend()

function SoulUnlockUIApi:Init()
	self:RegisterApi("durationProgress", self.GetDurationProgress)
	self:RegisterApi("goSoulName", self.GetSoulName)
	self:RegisterApi("goSoulTitle", self.GetSoulTitle)
	self:RegisterApi("goSoulDesc", self.GetSoulDesc)
	self:RegisterApi("goCvName", self.GetCvName)
	self:RegisterApi("goEnName", self.GetEnName)
	self:RegisterApi("goTransToFragLabel", self.GetGoTransToFragLabel)
	self:RegisterApi("goFragNumText", self.GetGoFragNumText)
end

function SoulUnlockUIApi:GetDurationProgress(progress)
	local ret = 0

	if progress == 1 then
		ret = 1
	elseif progress == 2 then
		ret = 2
	end

	return ret
end

function SoulUnlockUIApi:GetSoulName(name)
	return name
end

function SoulUnlockUIApi:GetSoulTitle(title)
	return title
end

function SoulUnlockUIApi:GetSoulDesc(desc)
	return desc
end

function SoulUnlockUIApi:GetCvName(name)
	return self:GetCfgText(2900251) .. ":" .. name
end

function SoulUnlockUIApi:GetEnName(name)
	return name
end

function SoulUnlockUIApi:GetGoTransToFragLabel()
	return self:GetCfgText(2900250)
end

function SoulUnlockUIApi:GetGoFragNumText(num)
	return "x" .. num
end

SoulUnlockUIApi:Init()
