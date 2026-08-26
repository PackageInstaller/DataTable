-- chunkname: @modules/logic/survival/model/map/SurvivalLogMo.lua

module("modules.logic.survival.model.map.SurvivalLogMo", package.seeall)

local SurvivalLogMo = pureTable("SurvivalLogMo")
local LogType = {
	TeamHealth = 4,
	HeroHealth = 5,
	Item = 1,
	RoleLevelUp = 7,
	TaskChange = 3
}

function SurvivalLogMo:ctor()
	self.isNpcRecr = false
end

function SurvivalLogMo:init(data, colorDict)
	self.logStr = ""

	local arr = string.splitToNumber(data, "#") or {}

	if arr[1] == LogType.Item then
		if not arr[3] then
			local count = 0

			if not arr[4] then
				local bagType = SurvivalEnum.ItemSource.Map
				local itemCo = lua_survival_item.configDict[arr[2]]

				if itemCo then
					local type = itemCo.type

					if type == SurvivalEnum.ItemType.NPC then
						if count > 0 then
							self.isNpcRecr = arr[2]
							self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_addnpc"), itemCo.name)
						else
							self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_removenpc"), itemCo.name)
						end
					elseif type == SurvivalEnum.ItemType.Currency then
						self.logStr = count > 0 and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_addcurrency"), itemCo.name, count) or bagType == SurvivalEnum.ItemSource.Map and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removecurrency"), itemCo.name, -count) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removecurrency_shelter"), itemCo.name, -count)
					else
						local itemName = itemCo.name

						colorDict = colorDict or SurvivalConst.ItemRareColor

						if colorDict[itemCo.rare] then
							itemName = string.format("<color=%s>%s</color>", colorDict[itemCo.rare], itemName)
						end

						self.logStr = count > 0 and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_additem"), itemName, count) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_removeitem"), itemName, -count)
					end
				end
			end
		end
	elseif arr[1] == LogType.TaskChange then
		if not arr[2] then
			local moduleId = 0

			if not arr[3] then
				local taskId = 0

				if not arr[4] then
					local status = 1
					local taskCo = SurvivalConfig.instance:getTaskCo(moduleId, taskId)

					if taskCo then
						self.logStr = status == 1 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_taskbegin"), taskCo.desc) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_taskfail"), taskCo.desc)
					end
				end
			end
		end
	elseif arr[1] == LogType.TeamHealth then
		if not arr[2] then
			local num = 0

			self.logStr = num >= 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_teamhealthadd"), num) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_teamhealthsub"), -num)
		end
	elseif arr[1] == LogType.HeroHealth then
		local heroCo = lua_character.configDict[tonumber(arr[2])]

		if heroCo then
			if not heroCo.name then
				local heroName = ""

				if not arr[3] then
					local num = 0

					self.logStr = num >= 0 and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_herohealthadd"), heroName, num) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_log_heaohealthsub"), heroName, -num)
				end
			end
		end
	elseif arr[1] == LogType.RoleLevelUp then
		local change = arr[2]

		self.logStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_log_rolelevelup"), change)
	end
end

function SurvivalLogMo:getLogStr()
	return self.logStr
end

return SurvivalLogMo
