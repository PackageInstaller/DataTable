-- chunkname: @IQIGame\\UIExternalApi\\GiftTipUIApi.lua

GiftTipUIApi = BaseLangApi:Extend()

function GiftTipUIApi:Init()
	self:RegisterApi("goViewTitle", self.GetViewTitle)
	self:RegisterApi("goBtnUse", self.GetBtnUseTxt)
	self:RegisterApi("goBtnSell", self.GetBtnSellTxt)
	self:RegisterApi("goName", self.GetNameText)
	self:RegisterApi("goNum", self.GetNumText)
	self:RegisterApi("goNameCell", self.GetNameCell)
	self:RegisterApi("goDescCell", self.GetDescCell)
end

function GiftTipUIApi:GetViewTitle()
	return self:GetCfgText(1014090)
end

function GiftTipUIApi:GetBtnUseTxt()
	return self:GetCfgText(26)
end

function GiftTipUIApi:GetBtnSellTxt()
	return self:GetCfgText(25)
end

function GiftTipUIApi:GetNameText(name, quality)
	return name
end

function GiftTipUIApi:GetNumText(num)
	return self:GetCfgText(1212004) .. num
end

function GiftTipUIApi:GetNameCell(name)
	return name
end

function GiftTipUIApi:GetDescCell(desc)
	return desc
end

GiftTipUIApi:Init()
