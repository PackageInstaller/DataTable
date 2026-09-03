-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/CheckSkill.lua

local function updateTable(dst, src)
	if src == nil then
		return dst
	end

	if dst == nil then
		dst = {}
	end

	for k, v in pairs(src) do
		dst[k] = v
	end

	return dst
end

CheckSkillArgsBox = class("CheckSkillArgsBox", DebugViewTemplate, _M)

function CheckSkillArgsBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function CheckSkillArgsBox:onClick(data)
	local curSkillId = "Hero_Proud_TPGZhu1"
	local level = 1

	local function getLuaErrorDescription(errmsg)
		local _, pos1 = string.find(errmsg, ":")

		if pos1 then
			local _, pos2 = string.find(errmsg, ":", pos1 + 1)

			if pos2 then
				local _, pos3 = string.find(errmsg, " ", pos2 + 1)

				while pos3 == pos2 + 1 do
					pos2 = pos3
					_, pos3 = string.find(errmsg, " ", pos3 + 1)
				end

				return string.sub(errmsg, pos2 + 1)
			end
		end

		return errmsg
	end

	local function fixErrMsg(errmsg, trace_text)
		local errmsg_fix = getLuaErrorDescription(errmsg)
		local _, pos = string.find(trace_text, "in function 'trycall'")

		if pos then
			local _, pos1 = string.find(trace_text, ":", pos + 1)

			if pos1 then
				local tmpStr = string.sub(trace_text, pos + 3, pos1)
				local pos2, pos3 = string.find(trace_text, tmpStr, 1, true)
				local _, pos4 = string.find(trace_text, ":", pos3 + 1)

				return string.sub(trace_text, pos2, pos4) .. " " .. errmsg_fix, "stack traceback:\n\t" .. string.sub(trace_text, pos2)
			end
		end

		return errmsg
	end

	local function __TRACKBACK__(errmsg, ...)
		local trace_text = debug.traceback("", 0)

		errmsg = fixErrMsg(errmsg, trace_text)

		print("-----------------------TRACKBACK-----------------------")
		print(curSkillId .. "技能Args错误")
		print(errmsg .. "\n" .. trace_text, "LUA ERROR")
		print("-----------------------TRACKBACK-----------------------")
		app.showMessageBox(errmsg .. "\n" .. trace_text, curSkillId .. "技能Args错误")

		return trace_text
	end

	local function tryskill(func, ...)
		local args = {
			...
		}

		return xpcall(function()
			func(unpack(args))
		end, __TRACKBACK__)
	end

	local skills = require("skills.all")
	local globalScope = setmetatable({}, {
		__metatable = "private",
		__index = function(t, k)
			local val = skills.__all__[k]

			if val ~= nil then
				rawset(t, k, val)

				return val
			end

			return nil
		end
	})

	globalScope.global = globalScope

	local function defaultFunc(thisScope, args, actionOrFunction)
		return actionOrFunction
	end

	local replaceFuncs = {
		["[trigger_by]"] = true,
		["[schedule_at_moments]"] = true,
		["[schedule_in_cycles]"] = true
	}

	for name, member in pairs(_G.SkillScriptBuiltins) do
		globalScope[name] = replaceFuncs[name] and defaultFunc or member
	end

	local protoFactory = PrototypeFactory:getInstance()
	local skillIds = ConfigReader:getKeysOfTable("Skill")

	for i, skillId in ipairs(skillIds) do
		curSkillId = skillId

		if skillId then
			::label_3_0::

			local config = ConfigReader:getRecordById("Skill", skillId)

			if config == nil then
				local err = "技能Id:" .. tostring(skillId) .. "在技能表中不存在"

				print(err)
			else
				local skillProto = protoFactory:getSkillPrototype(skillId)
				local skillData = skillProto:getBattleSkillData(level)

				if skillData.proto == nil or skillData.proto == "" then
					local err = "技能Id:" .. tostring(skillId) .. "没有Actions"

					print(err)
					app.showMessageBox(err, curSkillId .. "技能Actions错误")
				else
					local prototype = globalScope[skillData.proto]

					if prototype == nil then
						local err = "技能Id:" .. tostring(skillId) .. "的Actions  " .. skillData.proto .. "不存在于技能脚本中"

						print(err)
						app.showMessageBox(err, curSkillId .. "技能Actions错误")
					else
						local externalVars = {}

						updateTable(externalVars, skillData.args)

						externalVars.skill = skillData
						externalVars.type = skillData.type
						externalVars.owner = globalScope.null
						externalVars.level = skillData.level

						tryskill(function()
							local thisScope = prototype:__new__(externalVars, globalScope)
						end)
					end
				end
			end
		end
	end
end

CheckSkillTextBox = class("CheckSkillTextBox", DebugViewTemplate, _M)

function CheckSkillTextBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function CheckSkillTextBox:onClick(data)
	local curSkillId = "Skill_YLMNYi_Normal"
	local curDesc = "长描述"
	local level = 1

	local function getLuaErrorDescription(errmsg)
		local _, pos1 = string.find(errmsg, ":")

		if pos1 then
			local _, pos2 = string.find(errmsg, ":", pos1 + 1)

			if pos2 then
				local _, pos3 = string.find(errmsg, " ", pos2 + 1)

				while pos3 == pos2 + 1 do
					pos2 = pos3
					_, pos3 = string.find(errmsg, " ", pos3 + 1)
				end

				return string.sub(errmsg, pos2 + 1)
			end
		end

		return errmsg
	end

	local function fixErrMsg(errmsg, trace_text)
		local errmsg_fix = getLuaErrorDescription(errmsg)
		local _, pos = string.find(trace_text, "in function 'trycall'")

		if pos then
			local _, pos1 = string.find(trace_text, ":", pos + 1)

			if pos1 then
				local tmpStr = string.sub(trace_text, pos + 3, pos1)
				local pos2, pos3 = string.find(trace_text, tmpStr, 1, true)
				local _, pos4 = string.find(trace_text, ":", pos3 + 1)

				return string.sub(trace_text, pos2, pos4) .. " " .. errmsg_fix, "stack traceback:\n\t" .. string.sub(trace_text, pos2)
			end
		end

		return errmsg
	end

	local function __TRACKBACK__(errmsg, ...)
		local trace_text = debug.traceback("", 0)

		errmsg = fixErrMsg(errmsg, trace_text)

		print("-----------------------TRACKBACK-----------------------")
		print(curSkillId .. "文本错误")
		print(errmsg .. "\n" .. trace_text, "LUA ERROR")
		print("-----------------------TRACKBACK-----------------------")
		app.showMessageBox(errmsg .. "\n" .. trace_text, curSkillId .. curDesc .. "文本错误")

		return trace_text
	end

	local function tryskill(func, ...)
		local args = {
			...
		}

		return xpcall(function()
			func(unpack(args))
		end, __TRACKBACK__)
	end

	local skillIds = ConfigReader:getKeysOfTable("Skill")

	for i, skillId in ipairs(skillIds) do
		curSkillId = skillId

		if skillId then
			::label_13_0::

			local config = ConfigReader:getRecordById("Skill", skillId)

			if config == nil then
				local err = "技能Id:" .. tostring(skillId) .. "在技能表中不存在"

				print(err)
			else
				do
					local descKey = config.Desc_short

					if descKey == nil or descKey == "" then
						local err = "技能Id:" .. tostring(skillId) .. "的短描述不存在"

						print(err)
					else
						curDesc = "短描述"

						tryskill(function()
							local desc = ConfigReader:getEffectDesc("Skill", descKey, skillId, level)
						end)
					end
				end

				local descKey = config.Desc

				if descKey == nil or descKey == "" then
					local err = "技能Id:" .. tostring(skillId) .. "的长描述不存在"

					print(err)
				else
					curDesc = "长描述"

					tryskill(function()
						local desc = ConfigReader:getEffectDesc("Skill", descKey, skillId, level)
					end)
				end
			end
		end
	end
end

AddBattleSpeedBox = class("AddBattleSpeedBox", DebugViewTemplate, _M)

function AddBattleSpeedBox:initialize()
	self._viewConfig = {
		{
			default = "1",
			name = "Speed",
			title = "速度",
			type = "Input"
		}
	}
end

function AddBattleSpeedBox:onClick(data)
	local speed = tonumber(data.Speed)

	self:dispatch(Event:new("DEBUG_EVT_CHANGE_BATTLE_SPEED", speed))
end

OpenBattleSpeedButtonBox = class("OpenBattleSpeedButtonBox", DebugViewTemplate, _M)

function OpenBattleSpeedButtonBox:initialize()
	self._viewConfig = {
		{
			default = "{1.0,0.8,0.85,0.9,0.95,1.05,1.1,1.15,1.2,1.3,1.4,1.5}",
			name = "Speed",
			title = "速度",
			type = "Input"
		}
	}
end

function OpenBattleSpeedButtonBox:onClick(data)
	local speed = loadstring("return " .. data.Speed)()

	GameConfigs.battleControllerSpeed = type(speed) == "table" and speed or nil
end
