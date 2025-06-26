-- chunkname: @IQIGame\\UIExternalApi\\PandaSceneMainUIApi.lua

PandaSceneMainUIApi = BaseLangApi:Extend()

function PandaSceneMainUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("BtnExploreLabel", self.GetBtnExploreLabel)
	self:RegisterApi("TextSpendName", self.GetTextSpendName)
	self:RegisterApi("TextSpendNum", self.GetTextSpendNum)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("ExplorationOrder", self.GetExplorationOrder)
end

function PandaSceneMainUIApi:GetExplorationOrder(haveNum, maxNum)
	return tostring(haveNum) .. "/" .. tostring(maxNum)
end

function PandaSceneMainUIApi:GetTextDes()
	return self:GetCfgText(3800550)
end

function PandaSceneMainUIApi:GetTextSpendNum(num)
	return string.format("x %s", num)
end

function PandaSceneMainUIApi:GetTextSpendName(str)
	return self:GetCfgText(3800551)
end

function PandaSceneMainUIApi:GetBtnExploreLabel()
	return self:GetCfgText(3800552)
end

function PandaSceneMainUIApi:GetTitleText()
	return self:GetCfgText(1233503)
end

PandaSceneMainUIApi:Init()
