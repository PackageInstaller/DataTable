-- chunkname: @IQIGame\\UIExternalApi\\FunctionPreviewUIApi.lua

FunctionPreviewUIApi = BaseLangApi:Extend()

function FunctionPreviewUIApi:Init()
	self:RegisterApi("goTabName", self.GetTabName)
	self:RegisterApi("openInfoDesc", self.GetOpenInfoDesc)
	self:RegisterApi("goDetail", self.GetDetail)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goTitleEng", self.GetTitleEng)
end

function FunctionPreviewUIApi:GetTitle()
	return self:GetCfgText(1019027)
end

function FunctionPreviewUIApi:GetTitleEng()
	return "Preview"
end

function FunctionPreviewUIApi:GetDetail(desc)
	return desc
end

function FunctionPreviewUIApi:GetOpenInfoDesc(desc)
	return desc
end

function FunctionPreviewUIApi:GetTabName(name)
	return name
end

FunctionPreviewUIApi:Init()
