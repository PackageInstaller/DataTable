-- chunkname: @IQIGame\\UIExternalApi\\MazeWishUIApi.lua

MazeWishUIApi = BaseLangApi:Extend()

function MazeWishUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function MazeWishUIApi:GetTitleText()
	return self:GetCfgText(3209001)
end

function MazeWishUIApi:GetConfirmBtnText()
	return self:GetCfgText(3209002)
end

MazeWishUIApi:Init()
