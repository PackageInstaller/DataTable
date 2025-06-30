-- chunkname: @IQIGame\\UIExternalApi\\NoviceTaskUIApi.lua

NoviceTaskUIApi = BaseLangApi:Extend()

function NoviceTaskUIApi:GetDayTipText()
	return "Day"
end

function NoviceTaskUIApi:GetDayCountText(day)
	return "0" .. day
end

function NoviceTaskUIApi:GetTimeFormat(seconds)
	if seconds > 86400 then
		return DateTimeFormat(seconds, "dd天hh小时", false)
	else
		return DateTimeFormat(seconds, "hh:mm:ss", false)
	end
end

function NoviceTaskUIApi:GetExpItemCid()
	return 105
end
