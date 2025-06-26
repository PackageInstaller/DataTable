-- chunkname: @IQIGame\\UIExternalApi\\VideoPlayerUIApi.lua

VideoPlayerUIApi = BaseLangApi:Extend()

function VideoPlayerUIApi:Init()
	self:RegisterApi("NextTextDelay", self.GetNextTextDelay)
	self:RegisterApi("NextVideoDelay", self.GetNextVideoDelay)
	self:RegisterApi("MaxTextWidth", self.GetMaxTextWidth)
end

function VideoPlayerUIApi:GetNextTextDelay()
	return 3
end

function VideoPlayerUIApi:GetNextVideoDelay()
	return 2
end

function VideoPlayerUIApi:GetMaxTextWidth()
	return 1000
end

VideoPlayerUIApi:Init()
