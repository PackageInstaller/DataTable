-- chunkname: @IQIGame\\UIExternalApi\\SettingUIApi.lua

SettingUIApi = BaseLangApi:Extend()

function SettingUIApi:GetTextBtnExchange()
	return self:GetCfgText(1200002)
end

function SettingUIApi:GetTextTitle()
	return self:GetCfgText(1200004)
end

function SettingUIApi:GetTextTitle_1()
	return self:GetCfgText(1200005)
end

function SettingUIApi:GetTextTitle_2()
	return self:GetCfgText(1200006)
end

function SettingUIApi:GetTextTitle_3()
	return self:GetCfgText(1200007)
end

function SettingUIApi:GetTextTitle_4()
	return self:GetCfgText(1200008)
end

function SettingUIApi:GetTextTitle_5()
	return self:GetCfgText(1200009)
end

function SettingUIApi:GetTextTitle_6()
	return self:GetCfgText(1200010)
end

function SettingUIApi:GetTextTitle_7()
	return self:GetCfgText(1200011)
end

function SettingUIApi:GetTextTitle_8()
	return self:GetCfgText(1200012)
end

function SettingUIApi:GetTextTitle_9()
	return self:GetCfgText(1200013)
end

function SettingUIApi:GetTextTitle_10()
	return self:GetCfgText(1200014)
end

function SettingUIApi:GetTextTitle_11()
	return self:GetCfgText(1200015)
end

function SettingUIApi:GetTextTitle_12()
	return self:GetCfgText(1200016)
end

function SettingUIApi:GetTextTitle_13()
	return self:GetCfgText(1200017)
end

function SettingUIApi:GetTextTitle_14()
	return self:GetCfgText(1200018)
end

function SettingUIApi:GetTextTitle_15()
	return self:GetCfgText(1200019)
end

function SettingUIApi:GetTextTitle_16()
	return self:GetCfgText(1200020)
end

function SettingUIApi:GetTextTitle_17()
	return self:GetCfgText(1200021)
end

function SettingUIApi:GetTextTitle_18()
	return self:GetCfgText(1200022)
end

function SettingUIApi:GetTextTitle_19()
	return self:GetCfgText(1200023)
end

function SettingUIApi:GetErrorMsg()
	return self:GetCfgText(1200001)
end

function SettingUIApi:GetTextInput()
	return self:GetCfgText(1200003)
end

function SettingUIApi:GetTextDynamic(type)
	if type == 1 then
		return self:GetCfgText(1200023)
	elseif type == 2 then
		return self:GetCfgText(1200024)
	elseif type == 3 then
		return self:GetCfgText(1200025)
	elseif type == 4 then
		return self:GetCfgText(1200026)
	else
		return ""
	end
end

function SettingUIApi:GetTextDynamic1()
	return self:GetCfgText(1200024)
end

function SettingUIApi:GetTextDynamic3()
	return self:GetCfgText(1200025)
end

function SettingUIApi:GetTextDynamic2()
	return self:GetCfgText(1200026)
end

function SettingUIApi:GetTextDynamic3()
	return self:GetCfgText(1200023)
end

function SettingUIApi:GetClosePushText()
	return self:GetCfgText(1200028)
end

function SettingUIApi:GetVoiceTypeText()
	return {
		self:GetCfgText(1200030),
		self:GetCfgText(1200029)
	}
end
