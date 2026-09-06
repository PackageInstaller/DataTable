-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfuleggs/model/ColorfulEggsConst.lua

module("logic.extensions.colorfuleggs.model.ColorfulEggsConst", package.seeall)

local ColorfulEggsConst = {}

ColorfulEggsConst.States = {
	Finished = 4,
	Running = 3,
	Triggered = 2,
	UnTriggered = 1
}

function ColorfulEggsConst.shouldTriggered(eggCo)
	if not eggCo then
		return false
	end

	if eggCo.t_level > 0 and MofangModel.instance:getCurLv() < eggCo.t_level then
		return false
	end

	if eggCo.t_power > 0 and RoleModel.instance:getMaxPower() < eggCo.t_power then
		return false
	end

	if eggCo.t_task > 0 and not TaskModel.instance:isTaskFinished(eggCo.t_task) then
		return false
	end

	if eggCo.t_preEgg > 0 then
		local preCo = ColorfulEggConfig.instance:getColorfulEggCo(eggCo.t_preEgg)

		if not ColorfulEggsConst.shouldTriggered(preCo) then
			return false
		end
	end

	if eggCo.t_timeStart and eggCo.t_timeEnd and not GameUtil.checkIsInTimePeriod(eggCo.t_timeStart, eggCo.t_timeEnd) then
		return false
	end

	if eggCo.t_hours_start and #eggCo.t_hours_start > 0 and eggCo.t_hours_end and #eggCo.t_hours_end > 0 and not GameUtil.checkIsInTimePeriod(eggCo.t_hours_start, eggCo.t_hours_end, true) then
		return false
	end

	return true
end

function ColorfulEggsConst.isEggFinished(eggCo)
	if not eggCo then
		return true
	end

	if eggCo.taskId > 0 then
		return TaskModel.instance:isTaskAccpetable(eggCo.taskId)
	end

	local afterIds = ColorfulEggConfig.instance:getAfterColorfulEggs(eggCo.id)

	if afterIds then
		for i = 1, #afterIds do
			local afterCo = ColorfulEggConfig.instance:getColorfulEggCo(afterIds[i])

			if not ColorfulEggsConst.isEggFinished(afterCo) then
				return false
			end
		end

		return true
	end

	return false
end

return ColorfulEggsConst
