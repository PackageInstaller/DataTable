-- chunkname: @IQIGame\\UIExternalApi\\AvPlayUIApi.lua

AvPlayUIApi = BaseLangApi:Extend()

function AvPlayUIApi:Init()
	self:RegisterApi("TextBtnJump", self.GetTextBtnJump)
end

function AvPlayUIApi:GetTextBtnJump()
	return self:GetCfgText(1317026)
end

AvPlayUIApi:Init()
