-- chunkname: @IQIGame\\UIExternalApi\\MemorySceneMainUIApi.lua

MemorySceneMainUIApi = BaseLangApi:Extend()

function MemorySceneMainUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("tip", self.GetTip)
end

function MemorySceneMainUIApi:GetTip(tip)
	return tip
end

function MemorySceneMainUIApi:GetTitle(title)
	return title
end

MemorySceneMainUIApi:Init()
