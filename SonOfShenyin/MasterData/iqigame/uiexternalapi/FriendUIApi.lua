-- chunkname: @IQIGame\\UIExternalApi\\FriendUIApi.lua

FriendUIApi = BaseLangApi:Extend()

function FriendUIApi:GetconfrimBtnText()
	return self:GetCfgText(1600037)
end

function FriendUIApi:GetcancelBtnText()
	return self:GetCfgText(1600038)
end

function FriendUIApi:GetInputPromptTex()
	return self:GetCfgText(1600039)
end

function FriendUIApi:GetOnlinText(isOnline)
	if isOnline then
		return self:GetCfgText(1600040)
	else
		return self:GetCfgText(1600059)
	end
end

function FriendUIApi:GetToggleTexts()
	return {
		self:GetCfgText(150001),
		self:GetCfgText(150002)
	}
end

function FriendUIApi:RemarkUnserviceableText()
	return self:GetCfgText(150003)
end
