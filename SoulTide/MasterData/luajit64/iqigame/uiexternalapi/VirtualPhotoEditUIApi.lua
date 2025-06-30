-- chunkname: @IQIGame\\UIExternalApi\\VirtualPhotoEditUIApi.lua

VirtualPhotoEditUIApi = BaseLangApi:Extend()

function VirtualPhotoEditUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("NameText_L3", self.GetNameText_L3)
	self:RegisterApi("TypeText_L3", self.GetTypeText_L3)
	self:RegisterApi("OrderText_L3", self.GetOrderText_L3)
	self:RegisterApi("DefaultElementScale", self.GetDefaultElementScale)
	self:RegisterApi("PreviewCloseBtnText", self.GetPreviewCloseBtnText)
	self:RegisterApi("SharePanel_ShareInfo", self.GetSharePanel_ShareInfo)
	self:RegisterApi("ElementLayer_TypeName", self.GetElementLayer_TypeName)
end

function VirtualPhotoEditUIApi:GetTitleText()
	return self:GetCfgText(3504201)
end

function VirtualPhotoEditUIApi:GetNameText_L3()
	return self:GetCfgText(3504221)
end

function VirtualPhotoEditUIApi:GetTypeText_L3()
	return self:GetCfgText(3504222)
end

function VirtualPhotoEditUIApi:GetOrderText_L3()
	return "1"
end

function VirtualPhotoEditUIApi:GetDefaultElementScale()
	return 50
end

function VirtualPhotoEditUIApi:GetPreviewCloseBtnText()
	return self:GetCfgText(3504223)
end

function VirtualPhotoEditUIApi:GetSharePanel_ShareInfo(index)
	if index == 1 then
		return self:GetCfgText(3504224), 20001
	elseif index == 2 then
		return self:GetCfgText(3504225), 20002
	elseif index == 3 then
		return self:GetCfgText(3504226), 20003
	elseif index == 4 then
		return self:GetCfgText(3504227), 20004
	end

	return "???", 20001
end

function VirtualPhotoEditUIApi:GetElementLayer_TypeName(type)
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

VirtualPhotoEditUIApi:Init()
