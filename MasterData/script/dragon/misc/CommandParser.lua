-- chunkname: @/tmp/or_script/lua_compile/dragon/misc/CommandParser.lua

local CmdParserLogger = {}

function CmdParserLogger:new(...)
	local obj = setmetatable({}, {
		__index = self
	})

	obj:initialize(...)

	return obj
end

function CmdParserLogger:initialize()
	self.warnings = {}
	self.errors = {}
end

function CmdParserLogger:error(msg)
	self.errors[#self.errors + 1] = msg

	return self
end

function CmdParserLogger:warning(msg)
	self.warnings[#self.warnings + 1] = msg

	return self
end

function CmdParserLogger:isSuccess()
	return self:numOfErrors() == 0
end

function CmdParserLogger:numOfErrors()
	return #self.errors
end

function CmdParserLogger:numOfWarnings()
	return #self.warnings
end

function CmdParserLogger:toString()
	local ret = "========================================"

	ret = ret .. string.format("\n%d warnings, %d errors", self:numOfWarnings(), self:numOfErrors())

	if self:numOfWarnings() > 0 then
		ret = ret .. "\nWARNINGS: "

		for i, v in ipairs(self.warnings) do
			ret = ret .. string.format("\n  %d: %s", i, v)
		end
	end

	if self:numOfErrors() > 0 then
		ret = ret .. "\nERRORS: "

		for i, v in ipairs(self.errors) do
			ret = ret .. string.format("\n  %d: %s", i, v)
		end
	end

	ret = ret .. "\n"

	return ret
end

local Parser = {}
local p_id = "%a[%w_]*"
local p_num = "[+-]?%d*%.?%d+"
local p_str1 = "\"([^\"]*)\""
local p_str2 = "'([^']*)'"
local value_rules = {
	{
		p = p_num,
		action = function(t)
			return tonumber(t)
		end
	},
	{
		p = p_str1,
		action = function(t)
			local _, _, value = string.find(t, p_str1)

			return value
		end
	},
	{
		p = p_str2,
		action = function(t)
			local _, _, value = string.find(t, p_str2)

			return value
		end
	}
}

function Parser:_parseAndEatToken(src, pattern, action)
	local value

	src = string.gsub(src, "^%s*(" .. pattern .. ")", function(n)
		value = action == nil and n or action(n)

		return ""
	end)

	return value, src
end

function Parser:_parseAndEatTokenByRuleSet(src, ruleset)
	local value, left = nil, src

	for i, rule in ipairs(ruleset) do
		value, left = self:_parseAndEatToken(left, rule.p, rule.action)

		if value ~= nil then
			return value, left
		end
	end

	return nil, left
end

function Parser:_parseCommand(content, logger)
	local cmd

	cmd, content = self:_parseAndEatToken(content, p_id)

	if cmd == nil then
		logger:error("\"COMMAND\" expected.")

		return nil, content
	end

	local result = {
		cmd = cmd,
		params = {}
	}
	local matched, remain = self:_parseAndEatToken(content, ":")

	if matched then
		result.params, remain = self:_parseKVPairs(remain, logger)

		if logger:numOfErrors() > 0 then
			return nil, remain
		end

		if result.params == nil then
			result.params = {}
		end
	end

	return result, remain
end

function Parser:_parseKVPairs(content, logger)
	local dict = {}

	while content ~= nil do
		local comma

		repeat
			local var_16_0, var_16_1 = self:_parseAndEatToken(content, ",")

			content = var_16_1
		until var_16_0 == nil

		local key, value

		key, content = self:_parseAndEatToken(content, p_id)

		if key == nil then
			break
		end

		local assign
		local var_16_2, var_16_3 = self:_parseAndEatToken(content, "=")

		content = var_16_3

		if var_16_2 == nil then
			logger:error("\"=\" expected.")

			return nil, content
		end

		value, content = self:_parseValue(content, logger)

		if logger:numOfErrors() > 0 then
			return nil, content
		end

		if dict[key] ~= nil then
			logger:warning("key `" .. key .. "` aready exists. Overrided.")
		end

		dict[key] = value
	end

	return dict, content
end

function Parser:_parseValueArray(content, logger)
	local arr = {}

	while content ~= nil do
		local comma

		repeat
			local var_17_0, var_17_1 = self:_parseAndEatToken(content, ",")

			content = var_17_1
		until var_17_0 == nil

		local value

		value, content = self:_parseValue(content, logger)

		if logger:numOfErrors() > 0 then
			return nil, content
		end

		if value == nil then
			break
		end

		arr[#arr + 1] = value
	end

	return arr, content
end

function Parser:_parseValue(content, logger)
	local matched = false

	matched, content = self:_parseAndEatToken(content, "[{[]")

	if matched then
		local t, endWord

		if matched == "{" then
			t, content = self:_parseKVPairs(content, logger)
			endWord = "}"
		else
			t, content = self:_parseValueArray(content, logger)
			endWord = "]"
		end

		matched, content = self:_parseAndEatToken(content, endWord)

		if not matched then
			logger:error("\"" .. endWord .. "\" expected.")

			return nil, content
		end

		return t, content
	end

	return self:_parseAndEatTokenByRuleSet(content, value_rules)
end

function Parser:parse(str)
	local logger = CmdParserLogger:new()

	if str == nil then
		return nil, logger:error("No input.")
	end

	local commands = {}
	local content = str
	local matched, cmd

	repeat
		matched, content = self:_parseAndEatToken(content, "{")

		if matched == nil then
			break
		end

		cmd, content = self:_parseCommand(content, logger)

		if logger:numOfErrors() > 0 then
			return nil, logger
		end

		if cmd ~= nil then
			commands[#commands + 1] = cmd
		end

		local var_19_0, var_19_1 = self:_parseAndEatToken(content, "}")

		content = var_19_1
	until var_19_0 == nil

	return commands, logger
end

CommandParser = Parser

function CommandParser:new()
	return setmetatable({}, {
		__index = self
	})
end

function execCommandOnMovieclip(mc, source, processor, ...)
	local parser = CommandParser:new()
	local commands, err = parser:parse(source)
	local errmsg

	if err:numOfErrors() <= 0 then
		if err:numOfWarnings() > 0 then
			errmsg = string.format("Parse CMD error in `%s` (frame=%d):\n%s\nsource:\n%s", mc and mc:getLibName() or "unkown", mc and mc:getCurrentFrame() or -1, err:toString(), source)

			if DEBUG then
				assert(false, errmsg)
			end
		end

		if commands == nil or err:numOfErrors() > 0 then
			return false, errmsg
		end
	end

	for i = 1, #commands do
		x = commands[i]

		processor(mc, x.cmd, x.params, ...)
	end

	return true, errmsg
end
