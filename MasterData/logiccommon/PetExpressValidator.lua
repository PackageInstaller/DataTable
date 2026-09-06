-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/express/PetExpressValidator.lua

module("logiccommon.common.express.PetExpressValidator", package.seeall)

local PetExpressValidator = {}

PetExpressValidator.AtomKey = {
	Race = "Race",
	NotNull = "NotNull",
	InitRare = "InitRare",
	Job = "Job",
	Signs = "Signs",
	CarriedPet = "CarriedPet",
	Gender = "Gender",
	Level = "Level",
	AwakenLevel = "AwakenLevel",
	StrengthenRaceType = "StrengthenRaceType",
	OnlyStart = "OnlyStart",
	NullPet = "NullPet",
	Id = "Id",
	RaceType = "RaceType",
	AttackType = "AttackType"
}

local _isBlank, _parse, _printError, _clearCache, _handlers

function PetExpressValidator.buildContextByPetMo(petMo)
	if petMo == nil then
		return nil
	end

	local raceId = petMo.raceId

	if petMo.getDefineId then
		raceId = petMo:getDefineId()
	end

	if not petMo.level then
		local level = petMo.curLv

		if petMo.getPetLv then
			level = petMo:getPetLv()
		end

		if not petMo.awakeLevel then
			return {
				petId = checknumber(petMo.petId),
				raceId = checknumber(raceId),
				skinId = checknumber(petMo.curFaceId),
				level = checknumber(level),
				awakenLevel = checknumber((petMo.getAwakenLv or nil) and petMo:getAwakenLv()),
				carriedMasterId = checknumber(petMo.carriedMasterId)
			}
		end
	end
end

function PetExpressValidator.buildContextByPetId(petId)
	local petMo = BagPetsFacade.instance:getPetInfo(petId)

	return PetExpressValidator.buildContextByPetMo(petMo)
end

function PetExpressValidator.match(expressStr, petContext)
	if _isBlank(expressStr) then
		return true
	end

	local ast, err = _parse(expressStr)

	if ast == nil then
		_printError(string.format("%s；表达式：%s", tostring(err), tostring(expressStr)))

		return false
	end

	local ok, result = pcall(ExpressParser.eval, ast, petContext)

	if not ok then
		_printError(string.format("运行表达式时发生错误：%s；表达式：%s", tostring(result), tostring(expressStr)))

		return false
	end

	return result == true
end

function PetExpressValidator.validateExpression(expressStr)
	if _isBlank(expressStr) then
		return true
	end

	local _, err = _parse(expressStr)

	if err ~= nil then
		return false, err
	end

	return true
end

function PetExpressValidator.clearCache()
	_clearCache()
end

function PetExpressValidator.isSupportedAtomKey(key)
	return _handlers[key] ~= nil
end

local MAX_CACHE_COUNT = 1000
local _cache = {}
local _cacheCount = 0

local function _trim(str)
	str = str or ""

	return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

function _isBlank(str)
	return str == nil or _trim(str) == ""
end

local function _formatAtomError(key, msg)
	return string.format("条件 '%s' 配置错误：%s", tostring(key), msg)
end

function _printError(msg)
	printError("PetExpressValidator 配置错误：" .. tostring(msg))
end

local function _splitValues(value)
	local result = {}

	for _, v in ipairs(string.split(value or "", ",") or {}) do
		v = _trim(v)

		if v ~= "" then
			table.insert(result, v)
		end
	end

	return result
end

local function _parseValues(key, param)
	if _isBlank(param) then
		return nil, _formatAtomError(key, "参数不能为空")
	end

	local values = _splitValues(param)

	if #values <= 0 then
		return nil, _formatAtomError(key, "参数不能为空")
	end

	return values
end

local function _ensureNoParam(key, param)
	if param ~= nil then
		return nil, _formatAtomError(key, "这个条件不支持参数，请去掉 '$' 后面的内容")
	end

	return true
end

local function _getCompareFunc(compareStr)
	if compareStr == ">" or compareStr == GameEnum.GREATER_THAN then
		return function(x, y)
			return y < x
		end
	elseif compareStr == "<" or compareStr == GameEnum.LESS_THAN then
		return function(x, y)
			return x < y
		end
	elseif compareStr == ">=" or compareStr == GameEnum.GREATER_THAN_OR_EQUAL_TO then
		return function(x, y)
			return y <= x
		end
	elseif compareStr == "<=" or compareStr == GameEnum.LESS_THAN_OR_EQUAL_TO then
		return function(x, y)
			return x <= y
		end
	elseif compareStr == "!=" or compareStr == "~=" or compareStr == GameEnum.NOT_EQUAL_TO then
		return function(x, y)
			return x ~= y
		end
	end

	if compareStr == "=" or compareStr == "==" or compareStr == GameEnum.EQUAL_TO then
		return function(x, y)
			return x == y
		end
	end

	return nil
end

local function _parseNumberCompare(key, compareParam)
	if _isBlank(compareParam) then
		return nil, _formatAtomError(key, "比较参数不能为空，格式应为 '比较符,目标值'，例如 Level$>=,10")
	end

	local params = string.split(compareParam or "", ",") or {}
	local compareStr = _trim(params[1])
	local targetStr = _trim(params[2])
	local compareFunc = _getCompareFunc(compareStr)
	local targetValue = tonumber(targetStr)

	if params[3] ~= nil then
		return nil, _formatAtomError(key, "比较参数过多，格式应为 '比较符,目标值'")
	end

	if compareFunc == nil then
		return nil, _formatAtomError(key, string.format("不支持比较符 '%s'，可用 >、<、>=、<=、=、==、!=、~=", tostring(compareStr)))
	end

	if targetValue == nil then
		return nil, _formatAtomError(key, "比较目标值不是数字，格式应为 '比较符,数字'")
	end

	return function(currentValue)
		return compareFunc(checknumber(currentValue), targetValue)
	end
end

local function _matchNumberOrStringValues(values, currentValue)
	for _, target in ipairs(values or {}) do
		local targetNumber = tonumber(target)
		local currentNumber = tonumber(currentValue)

		if targetNumber ~= nil and currentNumber ~= nil and targetNumber == currentNumber or target == tostring(currentValue) then
			return true
		end
	end

	return false
end

local function _getSkinId(petContext)
	if petContext == nil then
		return 0
	end

	local skinId = checknumber(petContext.skinId)

	if skinId <= 0 then
		skinId = checknumber(petContext.raceId)
	end

	return skinId
end

local function _matchRaceType(values, petContext)
	local skinId = _getSkinId(petContext)

	if skinId <= 0 then
		return false
	end

	local attrs = PetSkinConfig.instance:getAllElementAttrs(skinId)

	if attrs == nil then
		return false
	end

	for _, attr in ipairs(attrs) do
		local attrType = GameEnum.Races[attr]

		for _, target in ipairs(values) do
			if target == attr or checknumber(target) == attrType then
				return true
			end
		end
	end

	return false
end

local function _matchStrengthenRaceType(values, petContext)
	if _matchRaceType(values, petContext) then
		return true
	end

	local skinId = _getSkinId(petContext)

	if skinId <= 0 then
		return false
	end

	return PetSkinConfig.instance:checkHasEleAttr(skinId, GameEnum.RaceType.Yuan) == true
end

local function _matchJob(values, petContext)
	local skinId = _getSkinId(petContext)

	if skinId <= 0 then
		return false
	end

	for _, target in ipairs(values or {}) do
		if PetSkinConfig.instance:checkHasJob(skinId, target) or PetSkinConfig.instance:checkHasJob(skinId, checknumber(target)) then
			return true
		end
	end

	return false
end

local function _matchGender(values, petContext)
	local skinId = _getSkinId(petContext)

	if skinId <= 0 then
		return false
	end

	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	return cfg ~= nil and _matchNumberOrStringValues(values, cfg.genderId)
end

local function _matchAttackType(values, petContext)
	local skinId = _getSkinId(petContext)

	if skinId <= 0 then
		return false
	end

	local jobList = PetSkinConfig.instance:getJobKeyList(skinId) or {}

	for _, jobKey in ipairs(jobList) do
		local jobIdx = GameEnum.JobZh[jobKey]

		if jobIdx then
			::label_29_0::

			local jobCo = CharacterConfig.instance:getJobCo(jobIdx)

			if jobCo ~= nil and _matchNumberOrStringValues(values, jobCo.attackType) then
				return true
			end
		end
	end

	return false
end

_handlers = {
	[PetExpressValidator.AtomKey.NullPet] = function(param, key)
		local ok, err = _ensureNoParam(key, param)

		if not ok then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext == nil
			end
		}
	end,
	[PetExpressValidator.AtomKey.NotNull] = function(param, key)
		local ok, err = _ensureNoParam(key, param)

		if not ok then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil
			end
		}
	end,
	[PetExpressValidator.AtomKey.Id] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchNumberOrStringValues(values, petContext.petId)
			end
		}
	end,
	[PetExpressValidator.AtomKey.Race] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchNumberOrStringValues(values, petContext.raceId)
			end
		}
	end,
	[PetExpressValidator.AtomKey.Level] = function(param, key)
		local compareFunc, err = _parseNumberCompare(key, param)

		if compareFunc == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and compareFunc(petContext.level)
			end
		}
	end,
	[PetExpressValidator.AtomKey.Job] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchJob(values, petContext)
			end
		}
	end,
	[PetExpressValidator.AtomKey.RaceType] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchRaceType(values, petContext)
			end
		}
	end,
	[PetExpressValidator.AtomKey.StrengthenRaceType] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchStrengthenRaceType(values, petContext)
			end
		}
	end,
	[PetExpressValidator.AtomKey.Signs] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				if petContext == nil then
					return false
				end

				for _, sign in ipairs(values) do
					if CharacterConfig.instance:checkHasSigns(petContext.raceId, sign) then
						return true
					end
				end

				return false
			end
		}
	end,
	[PetExpressValidator.AtomKey.Gender] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchGender(values, petContext)
			end
		}
	end,
	[PetExpressValidator.AtomKey.AttackType] = function(param, key)
		local values, err = _parseValues(key, param)

		if values == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and _matchAttackType(values, petContext)
			end
		}
	end,
	[PetExpressValidator.AtomKey.InitRare] = function(param, key)
		local compareFunc, err = _parseNumberCompare(key, param)

		if compareFunc == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				if petContext == nil then
					return false
				end

				local compareValue = CharacterConfig.instance:getInitRare(petContext.raceId)

				return compareFunc(compareValue)
			end
		}
	end,
	[PetExpressValidator.AtomKey.AwakenLevel] = function(param, key)
		local compareFunc, err = _parseNumberCompare(key, param)

		if compareFunc == nil then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and compareFunc(petContext.awakenLevel)
			end
		}
	end,
	[PetExpressValidator.AtomKey.OnlyStart] = function(param, key)
		local ok, err = _ensureNoParam(key, param)

		if not ok then
			return nil, err
		end

		return {
			cal = function()
				return true
			end
		}
	end,
	[PetExpressValidator.AtomKey.CarriedPet] = function(param, key)
		local ok, err = _ensureNoParam(key, param)

		if not ok then
			return nil, err
		end

		return {
			cal = function(petContext)
				return petContext ~= nil and checknumber(petContext.carriedMasterId) > 0
			end
		}
	end
}

local function _createAtom(atomStr)
	local splitIndex = string.find(atomStr, "$", 1, true)
	local key = splitIndex and _trim(string.sub(atomStr, 1, splitIndex - 1)) or _trim(atomStr)
	local param = splitIndex and _trim(string.sub(atomStr, splitIndex + 1)) or nil
	local handler = _handlers[key]

	if handler == nil then
		return nil, string.format("未知条件 '%s'，请确认条件名是否在 PetExpressValidator.AtomKey 中定义", key)
	end

	return handler(param, key)
end

function _clearCache()
	_cache = {}
	_cacheCount = 0
end

local function _setCache(expressStr, ast)
	if _cache[expressStr] == nil then
		if _cacheCount >= MAX_CACHE_COUNT then
			_clearCache()
		end

		_cacheCount = _cacheCount + 1
	end

	_cache[expressStr] = ast
end

function _parse(expressStr)
	local ast = _cache[expressStr]

	if ast ~= nil then
		return ast
	end

	local ok, err
	local var_63_0, var_63_1, var_63_2 = pcall(ExpressParser.parse, expressStr, _createAtom)

	err = var_63_2
	ast = var_63_1

	if not var_63_0 then
		return nil, ast
	end

	if ast == nil then
		return nil, var_63_2
	end

	_setCache(expressStr, ast)

	return ast
end

return PetExpressValidator
