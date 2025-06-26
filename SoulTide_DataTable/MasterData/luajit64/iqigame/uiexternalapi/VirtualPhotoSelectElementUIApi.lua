-- chunkname: @IQIGame\\UIExternalApi\\VirtualPhotoSelectElementUIApi.lua

VirtualPhotoSelectElementUIApi = BaseLangApi:Extend()

function VirtualPhotoSelectElementUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ElementTypeName", self.GetElementTypeName)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function VirtualPhotoSelectElementUIApi:GetTitleText()
	return self:GetCfgText(3504211)
end

function VirtualPhotoSelectElementUIApi:GetElementTypeName(type)
	if type == 1 then
		return self:GetCfgText(3504212)
	elseif type == 2 then
		return self:GetCfgText(3504213)
	elseif type == 3 then
		return self:GetCfgText(3504215)
	elseif type == 4 then
		return self:GetCfgText(3504216)
	elseif type == 5 then
		return self:GetCfgText(3504401)
	elseif type == 6 then
		return self:GetCfgText(3504402)
	elseif type == 7 then
		return self:GetCfgText(3504403)
	elseif type == 8 then
		return self:GetCfgText(3504404)
	elseif type == 9 then
		return self:GetCfgText(3504405)
	elseif type == 10 then
		return self:GetCfgText(3504406)
	end

	return "resource"
end

function VirtualPhotoSelectElementUIApi:GetConfirmBtnText()
	return self:GetCfgText(3504214)
end

VirtualPhotoSelectElementUIApi:Init()
