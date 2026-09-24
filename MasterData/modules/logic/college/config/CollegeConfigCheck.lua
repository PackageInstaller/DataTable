-- chunkname: @modules/logic/college/config/CollegeConfigCheck.lua

module("modules.logic.college.config.CollegeConfigCheck", package.seeall)

local CollegeConfigCheck = class("CollegeConfigCheck")

function CollegeConfigCheck:process_college_building(configTable)
	for i, v in ipairs(configTable.configList) do
		local list = lua_college_building_level.configDict[v.id]

		if not list or not list[1] then
			logError("建筑等级配置不存在！" .. v.id)
		elseif #list > 3 then
			logError("建筑等级配置超过3级！" .. v.id)
		else
			for _, vv in ipairs(list) do
				if vv.level > 1 and string.nilorempty(vv.upgradeCost) then
					logError("建筑升级配置消耗为空！" .. v.id .. " " .. vv.level)
				end
			end
		end
	end
end

function CollegeConfigCheck:process_college_actor(configTable)
	for i, v in ipairs(configTable.configList) do
		local list = lua_college_actor_growth.configDict[v.id]

		if not list or not list[1] then
			logError("角色等级配置不存在！" .. v.id)
		else
			for _, vv in ipairs(list) do
				if vv.level > 1 and string.nilorempty(vv.cost) then
					logError("角色升级配置消耗为空！" .. v.id .. " " .. vv.level)
				end
			end
		end
	end
end

CollegeConfigCheck.instance = CollegeConfigCheck.New()

return CollegeConfigCheck
