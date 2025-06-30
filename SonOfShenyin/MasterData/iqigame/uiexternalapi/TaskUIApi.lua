-- chunkname: @IQIGame\\UIExternalApi\\TaskUIApi.lua

TaskUIApi = BaseLangApi:Extend()

function TaskUIApi:GetTipsMainTaskDes()
	return self:GetCfgText(4050001)
end

function TaskUIApi:GetTipsDayTaskDes()
	return self:GetCfgText(4050002)
end

function TaskUIApi:GetTipsWeekTaskDes()
	return self:GetCfgText(4050003)
end

function TaskUIApi:GetTipsPeriodTaskDes()
	return self:GetCfgText(4050004)
end

function TaskUIApi:GetTipsGetAward()
	return self:GetCfgText(4050005)
end

function TaskUIApi:GetTipsNoMainTaskDes()
	return self:GetCfgText(4050006)
end

function TaskUIApi:GetTipsFinishCurTask()
	return self:GetCfgText(1600034)
end

function TaskUIApi:GetTrunkProgress(schedule, needSchedule)
	return string.format("%s/%s", schedule, needSchedule)
end

function TaskUIApi:GetTrunkChapter(index)
	return string.format(self:GetResUrl(1100008), index)
end

function TaskUIApi:GetForWardPath(mpath)
	local path = ""

	if mpath then
		path = UIGlobalApi.ImagePath .. mpath
	else
		path = self:GetResUrl(1100001)
	end

	return path
end

function TaskUIApi:GetTimeText(hour, minute, second)
	return hour .. "：" .. minute .. "：" .. second
end

function TaskUIApi:GetNormalTaskDescText(str)
	return string.format(ColorCfg.TaskSystemUI.TaskNormal, str)
end

function TaskUIApi:GetHasDownTaskDescText(str)
	return string.format(ColorCfg.TaskSystemUI.TaskHasDown, str)
end

function TaskUIApi:GetDayTimeTipsText()
	return self:GetCfgText(4050007)
end

function TaskUIApi:GetWeeklyTimeTipsText()
	return self:GetCfgText(4050008)
end
