-- chunkname: @IQIGame\\UIExternalApi\\DressUnlockUIApi.lua

DressUnlockUIApi = BaseLangApi:Extend()

function DressUnlockUIApi:Init()
	self:RegisterApi("goSoulName", self.GetSoulName)
	self:RegisterApi("goSoulTitle", self.GetSoulTitle)
	self:RegisterApi("goCvName", self.GetCvName)
	self:RegisterApi("goEnName", self.GetEnName)
	self:RegisterApi("cvContent", self.GetCVContent)
	self:RegisterApi("dressName", self.GetDressName)
end

function DressUnlockUIApi:GetDressName(name)
	return name
end

function DressUnlockUIApi:GetCVContent(content)
	return content
end

function DressUnlockUIApi:GetCvName(name)
	return "CV:" .. name
end

function DressUnlockUIApi:GetSoulName(name)
	return name
end

function DressUnlockUIApi:GetSoulTitle(title)
	return title
end

function DressUnlockUIApi:GetEnName(name)
	return name
end

DressUnlockUIApi:Init()
