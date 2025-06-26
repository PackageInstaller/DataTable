-- chunkname: @IQIGame\\UIExternalApi\\UserInfoApi.lua

UserInfoApi = BaseLangApi:Extend()

function UserInfoApi:GetTittle()
	return self:GetCfgText(1010012)
end

function UserInfoApi:GetTips()
	return self:GetCfgText(1010013)
end

function UserInfoApi:GetAllTittle(id)
	if id == 1 then
		return self:GetCfgText(1010017)
	elseif id == 2 then
		return self:GetCfgText(1010007)
	elseif id == 3 then
		return self:GetCfgText(1010016)
	elseif id == 4 then
		return self:GetCfgText(1010009)
	end
end

function UserInfoApi:GetMonthDay(type)
	if type == 1 then
		return self:GetCfgText(1010014)
	else
		return self:GetCfgText(1010015)
	end
end

function UserInfoApi:GetCopyIDBtn()
	return self:GetCfgText(1010004)
end

function UserInfoApi:GetSignPlaceholder()
	return self:GetCfgText(1010005)
end

function UserInfoApi:GetImgPath(index, IsSelect)
	if IsSelect then
		return string.format(self:GetResUrl(1100010), index)
	else
		return string.format(self:GetResUrl(1100011), index)
	end
end

function UserInfoApi:GetBindSuccessText()
	return "绑定成功"
end

function UserInfoApi:GetReNamePanelTitle()
	return self:GetCfgText(1010019)
end

function UserInfoApi:GetReNamePanelInterval(interval)
	return self:GetCfgText(1010020, interval)
end

function UserInfoApi:GetReNamePanelNextTime(date)
	return self:GetCfgText(1010021, date)
end

function UserInfoApi:GetReNamePanelNameInvalid(type)
	if type == 2 then
		return self:GetCfgText(1010022)
	elseif type == 3 then
		return self:GetCfgText(1010023)
	elseif type == 1 then
		return self:GetCfgText(1010024)
	end
end

function UserInfoApi:GetReNamePanelInputPlaceholder()
	return self:GetCfgText(1010025)
end

function UserInfoApi:GetReNamePanelReNameSuccess()
	return self:GetCfgText(1010026)
end

function UserInfoApi:GetReNamePanelConfirmBtn()
	return self:GetCfgText(3060002)
end

function UserInfoApi:GetCumulativeLoginText(num)
	return tostring(num) .. self:GetCfgText(1010027)
end

function UserInfoApi:GetNameUnserviceableText()
	return self:GetCfgText(1010028)
end

function UserInfoApi:GetTimeFormat(state)
	if state == 1 then
		return self:GetCfgText(240004)
	elseif state == 2 then
		return self:GetCfgText(240005)
	elseif state == 3 then
		return self:GetCfgText(240006)
	end

	return self:GetCfgText(240007)
end
