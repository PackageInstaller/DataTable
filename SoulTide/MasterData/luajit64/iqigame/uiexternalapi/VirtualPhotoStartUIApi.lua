-- chunkname: @IQIGame\\UIExternalApi\\VirtualPhotoStartUIApi.lua

VirtualPhotoStartUIApi = BaseLangApi:Extend()

function VirtualPhotoStartUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function VirtualPhotoStartUIApi:GetTitleText()
	return self:GetCfgText(3504201)
end

VirtualPhotoStartUIApi:Init()
