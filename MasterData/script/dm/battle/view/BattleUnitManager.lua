-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleUnitManager.lua

local function mergeITable(dst, src)
	if src == nil then
		return dst
	end

	for k, v in ipairs(src) do
		local exist = false

		for k1, v1 in ipairs(dst) do
			if v == v1 then
				exist = true

				break
			end
		end

		if not exist then
			dst[#dst + 1] = v
		end
	end

	return dst
end

local function excludeITable(dst, exclude)
	if exclude == nil then
		return dst
	end

	local holeIndex

	for i, v in ipairs(dst) do
		local exist = false

		for _, v1 in ipairs(exclude) do
			if v == v1 then
				exist = true

				break
			end
		end

		if exist then
			dst[i] = nil

			if holeIndex == nil then
				holeIndex = i
			end
		elseif holeIndex ~= nil then
			dst[holeIndex] = v
			dst[i] = nil
			holeIndex = holeIndex + 1
		end
	end

	return dst
end

local function MakeMetaITable(t)
	return setmetatable(t, {
		__add = mergeITable,
		__sub = excludeITable,
		__eq = function(a, b)
			if type(a) == "table" then
				return a.id == b.id
			else
				return a == b
			end
		end
	})
end

local FilterMeta = {}

local function MakeFilter(func)
	return setmetatable({
		__func = func
	}, FilterMeta)
end

function FilterMeta.__mul(f1, f2)
	local func1, func2 = f1.__func, f2.__func

	return MakeFilter(function(...)
		return func1(...) and func2(...)
	end)
end

function FilterMeta.__add(f1, f2)
	local func1, func2 = f1.__func, f2.__func

	return MakeFilter(function(...)
		return func1(...) or func2(...)
	end)
end

function FilterMeta.__sub(f1, f2)
	local func1, func2 = f1.__func, f2.__func

	return MakeFilter(function(...)
		return func1(...) and not func2(...)
	end)
end

function FilterMeta.__unm(f)
	local func = f.__func

	return MakeFilter(function(...)
		return not func(...)
	end)
end

function FilterMeta.__call(t, ...)
	return t.__func(...)
end

local function filterArrayElements(array, filter, total)
	local result, count = {}, 0

	if total == nil then
		total = #array
	end

	for i = 1, total do
		local element = array[i]

		if element and filter(element) then
			count = count + 1
			result[count] = element
		end
	end

	return result, count
end

local __id2pos__ = {
	x = {
		1,
		1,
		1,
		2,
		2,
		2,
		3,
		3,
		3
	},
	y = {
		1,
		2,
		3,
		1,
		2,
		3,
		1,
		2,
		3
	}
}

local function BFCell_id2pos(id)
	if id > 0 then
		return 1, __id2pos__.x[id], __id2pos__.y[id]
	else
		id = -id

		return -1, __id2pos__.x[id], __id2pos__.y[id]
	end
end

local abs, floor = math.abs, math.floor

BattleUnitManager = class("BattleUnitManager", objectlua.Object, _M)

function BattleUnitManager:initialize()
	super.initialize(self)

	self._members = {}
	self._leftTeam = {}
	self._rightTeam = {}
	self._env = self:createEnvironment()
	self._ruleFuncs = {}
end

function BattleUnitManager:setBattleContext(battleContext)
	self._battleContext = battleContext
end

function BattleUnitManager:dispose()
	for k, unit in pairs(self._members) do
		if unit then
			unit:dispose()
		end
	end

	self._members = nil
	self._leftTeam = nil
	self._rightTeam = nil
end

local primaryTargetSearchOrders = {
	{
		1,
		4,
		7,
		2,
		5,
		8,
		3,
		6,
		9
	},
	{
		2,
		5,
		8,
		1,
		3,
		4,
		6,
		7,
		9
	},
	{
		3,
		6,
		9,
		2,
		5,
		8,
		1,
		4,
		7
	}
}

function BattleUnitManager:createEnvironment()
	local envmeta = {
		__index = function(env, k)
			if k == "TARGET" then
				local order = primaryTargetSearchOrders[env.y]
				local target, steal_target

				for i, v in ipairs(order) do
					local unit = env.getUnit(v * -1 * env.side)

					if unit then
						if unit:hasStatus(kBEStealth) then
							if steal_target == nil then
								steal_target = unit
							end
						else
							if unit:hasStatus(kBETaunt) then
								return unit
							end

							if target == nil then
								target = unit
							end
						end
					end
				end

				return target or steal_target
			elseif k == "SELF" then
				return env.pos
			else
				assert(false, tostring(k) .. " not exists in the Environment")
			end
		end
	}
	local env = setmetatable({}, envmeta)

	env.this = env
	env.__meta = envmeta
	env.Red = "Red"
	env.Green = "Green"

	local function getTeamArray(team)
		local array = {}

		for i = 1, 9 do
			if team[i] then
				array[#array + 1] = team[i]
			end
		end

		return array
	end

	function env.setPos(pos)
		env.pos = abs(pos)
		env.side, env.x, env.y = BFCell_id2pos(pos)
	end

	function env.getUnit(pos)
		if pos > 0 then
			return self._leftTeam[pos]
		else
			return self._rightTeam[-pos]
		end
	end

	function env.FriendUnits(filter)
		local array = env.side == 1 and getTeamArray(self._leftTeam) or getTeamArray(self._rightTeam)

		if filter == nil then
			return array
		end

		return filterArrayElements(array, filter)
	end

	function env.EnemyUnits(filter)
		local array = env.side == -1 and getTeamArray(self._leftTeam) or getTeamArray(self._rightTeam)

		if filter == nil then
			return array
		end

		return filterArrayElements(array, filter)
	end

	function env.EnemyAll(filter)
		local array = env.side == -1 and {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		} or {
			-1,
			-2,
			-3,
			-4,
			-5,
			-6,
			-7,
			-8,
			-9
		}

		if filter == nil then
			return array
		end

		return filterArrayElements(array, filter)
	end

	function env.FriendAll(filter)
		local array = env.side == 1 and {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		} or {
			-1,
			-2,
			-3,
			-4,
			-5,
			-6,
			-7,
			-8,
			-9
		}

		if filter == nil then
			return array
		end

		return filterArrayElements(array, filter)
	end

	env.OBLIQUE_CROSS = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return abs(x - 2) == 1 and abs(y - 2) == 1 or x == 2 and y == 2
	end)
	env.MID_CROSS = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return x == 2 or y == 2
	end)
	env.TOP_COL = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return y == 1
	end)
	env.MID_COL = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return y == 2
	end)
	env.BOTTOM_COL = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return y == 3
	end)
	env.FRONT_ROW = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return x == 1
	end)
	env.MID_ROW = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return x == 2
	end)
	env.BACK_ROW = MakeFilter(function(unit)
		local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return x == 3
	end)
	env.PETS = MakeFilter(function(unit)
		if type(unit) ~= "table" then
			return false
		end

		return unit:getRoleType() == RoleType.Hero
	end)
	env.MASTER = MakeFilter(function(unit)
		if type(unit) ~= "table" then
			return false
		end

		return unit:getRoleType() == RoleType.Master
	end)

	function env.MAKE_HP_FILTER(compare, value)
		local compFunc

		if compare == "<" then
			function compFunc(unit)
				if type(unit) ~= "table" then
					return false
				end

				return unit:getHp() < value
			end
		elseif compare == ">" then
			function compFunc(unit)
				if type(unit) ~= "table" then
					return false
				end

				return unit:getHp() > value
			end
		end

		return MakeFilter(compFunc)
	end

	function env.MAKE_HPRATIO_FILTER(compare, percent)
		local compFunc

		if compare == "<" then
			function compFunc(unit)
				if type(unit) ~= "table" then
					return false
				end

				return unit:getHp() / unit:getMaxHp() * 100 < percent
			end
		elseif compare == ">" then
			function compFunc(unit)
				if type(unit) ~= "table" then
					return false
				end

				return unit:getHp() / unit:getMaxHp() * 100 > percent
			end
		end

		return MakeFilter(compFunc)
	end

	function env.getHp(unit)
		if type(unit) ~= "table" then
			return 0
		end

		return unit:getHp()
	end

	function env.getMaxHp(unit)
		if type(unit) ~= "table" then
			return 1
		end

		return unit:getMaxHp()
	end

	function env.getHpRatio(unit)
		if type(unit) ~= "table" then
			return 0
		end

		return unit:getHp() * 100 / unit:getMaxHp()
	end

	function env.getRp(unit)
		if type(unit) ~= "table" then
			return 0
		end

		return unit:getRp()
	end

	function env.SortBy(array, compare, keyGetter)
		local compFunc

		if keyGetter == nil then
			compFunc = compare == "<" and function(a, b)
				return a < b
			end or compare == ">" and function(a, b)
				return b < a
			end or compare
		else
			local keys = {}

			for i = 1, #array do
				local elem = array[i]

				keys[elem] = keyGetter(elem)
			end

			compFunc = compare == "<" and function(a, b)
				return keys[a] < keys[b]
			end or compare == ">" and function(a, b)
				return keys[a] > keys[b]
			end or function(a, b)
				return compare(keys[a], keys[b])
			end
		end

		table.sort(array, compFunc)

		return array
	end

	function env.Slice(array, start, ended)
		local sliced = {}

		if start == nil then
			start = 1
		end

		local total = #array

		if ended == nil or total < ended then
			ended = #array
		elseif ended < 0 then
			ended = total + ended + 1
		end

		for i = start, ended do
			sliced[#sliced + 1] = array[i]
		end

		return sliced
	end

	function env.GenInfo(array, color, isRandom)
		local result = {}

		for i, v in ipairs(array) do
			result[i] = type(v) == "table" and {
				id = v:getCellId(),
				color = color,
				isRandom = isRandom
			} or {
				id = v,
				color = color,
				isRandom = isRandom
			}
		end

		return MakeMetaITable(result)
	end

	function env.MainTarget()
		return env.GenInfo({
			env.TARGET
		}, "Red")
	end

	self:createTargetEnvironment(env)

	return env
end

function BattleUnitManager:createTargetEnvironment(env)
	function env.ROW_OF(unit)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return MakeFilter(function(unit)
			local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

			return x == rx and zone == rzone
		end)
	end

	function env.COL_OF(unit)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return MakeFilter(function(unit)
			local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

			return y == ry and zone == rzone
		end)
	end

	function env.CROSS_OF(unit)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return MakeFilter(function(unit)
			local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

			return zone == rzone and (x == rx or y == ry)
		end)
	end

	function env.NEIGHBORS_OF(unit)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		return MakeFilter(function(unit)
			local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

			return zone == rzone and abs(x - rx) + abs(y - ry) == 1
		end)
	end

	function env.FRONT_OF(unit, excluded)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		if excluded then
			if not (rx - 1) then
				local boundary = rx

				return MakeFilter(function(unit)
					local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

					return x <= boundary and zone == rzone
				end)
			end
		end
	end

	function env.BACK_OF(unit, excluded)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		if excluded then
			if not (rx + 1) then
				local boundary = rx

				return MakeFilter(function(unit)
					local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

					return x >= boundary and zone == rzone
				end)
			end
		end
	end

	function env.ABOVE(unit, excluded)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		if excluded then
			if not (ry - 1) then
				local boundary = ry

				return MakeFilter(function(unit)
					local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

					return y <= boundary and zone == rzone
				end)
			end
		end
	end

	function env.BELOW(unit, excluded)
		if unit == nil then
			return MakeFilter(function(unit)
				return false
			end)
		end

		local rzone, rx, ry = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

		if excluded then
			if not (ry + 1) then
				local boundary = ry

				return MakeFilter(function(unit)
					local zone, x, y = BFCell_id2pos((type(unit) == "table" or nil) and unit:getCellId())

					return y >= boundary and zone == rzone
				end)
			end
		end
	end

	function env.HasBuff(tag)
		local battleField = self._battleContext:getObject("BattleField")
		local result = battleField:collectAllUnits({}, 1)
		local result1 = battleField:collectAllUnits({}, -1)

		for k, v in pairs(result1) do
			result[#result + 1] = v
		end

		local rets = {}

		for k, v in pairs(result) do
			local buffSystem = self._battleContext:getObject("BuffSystem")
			local _, cnt = buffSystem:selectBuffsOnTarget(v, MakeFilter(function(buff)
				return buff:isMatched(tag)
			end))

			if cnt > 0 then
				local id = v:getComponent("Position"):getCell():getId()

				rets[#rets + 1] = {
					color = "Green",
					id = id
				}
			end
		end

		return rets
	end

	function env.HasTrap(tag)
		local battleField = self._battleContext:getObject("BattleField")
		local cells = battleField:getCells()
		local trapSystem = self._battleContext:getObject("TrapSystem")
		local rets = {}

		for k, v in pairs(cells) do
			local _, cnt = trapSystem:selectBuffsOnTarget(v, MakeFilter(function(buff)
				return buff:isMatched(tag)
			end))

			if cnt > 0 then
				local id = v:getId()

				rets[#rets + 1] = {
					color = "Green",
					id = id
				}
			end
		end

		return rets
	end

	function env.AllCell()
		local battleField = self._battleContext:getObject("BattleField")
		local cells = battleField:getCells()
		local rets = {}

		for k, v in pairs(cells) do
			local id = v:getId()

			if math.abs(id) ~= 108 then
				rets[#rets + 1] = {
					color = "Green",
					id = id
				}
			end
		end

		return rets
	end
end

function BattleUnitManager:addUnit(unit, dataModel)
	local id = unit:getId()

	self._members[tostring(id)] = unit

	local cellId = dataModel:getCellId()

	if cellId > 0 then
		self._leftTeam[cellId] = dataModel
	else
		self._rightTeam[-cellId] = dataModel
	end
end

function BattleUnitManager:getUnitById(id)
	return self._members[tostring(id)]
end

function BattleUnitManager:exchange(oldCellId, newCellId)
	if oldCellId > 0 then
		if not self._leftTeam[oldCellId] then
			local dataModel = self._rightTeam[-oldCellId]

			if dataModel then
				if oldCellId > 0 then
					if newCellId > 0 then
						self._leftTeam[oldCellId] = self._leftTeam[newCellId]
						self._leftTeam[newCellId] = dataModel
					else
						self._leftTeam[oldCellId] = self._rightTeam[-newCellId]
						self._rightTeam[-newCellId] = dataModel
					end
				elseif newCellId > 0 then
					self._rightTeam[-oldCellId] = self._leftTeam[newCellId]
					self._leftTeam[newCellId] = dataModel
				else
					self._rightTeam[-oldCellId] = self._rightTeam[-newCellId]
					self._rightTeam[-newCellId] = dataModel
				end
			end
		end
	end
end

function BattleUnitManager:disableUnitById(id, cellId)
	if cellId > 0 then
		self._leftTeam[cellId] = nil
	else
		self._rightTeam[-cellId] = nil
	end
end

function BattleUnitManager:removeUnitById(id, cellId)
	if self._members[tostring(id)] then
		self._members[tostring(id)]:dispose()

		self._members[tostring(id)] = nil
	end

	for k, v in pairs(self._leftTeam) do
		if v._cellId ~= k and cellId == v._cellId then
			cellId = k

			break
		end
	end

	for k, v in pairs(self._rightTeam) do
		if 0 - v._cellId ~= k and cellId == v._cellId then
			cellId = 0 - k

			break
		end
	end

	if cellId > 0 then
		self._leftTeam[cellId] = nil
	else
		self._rightTeam[-cellId] = nil
	end
end

function BattleUnitManager:getMembers()
	return self._members
end

local function compileExpression(expression)
	if expression == nil then
		return nil
	end

	local expr = string.gsub(expression, "^[\t ]+", "")

	if expr == "" then
		return nil
	end

	local source = expr
	local fn, errmsg = loadstring(source)

	if fn == nil then
		battlelog("error", "Failed compiling expression: %s\n*ERROR*: %s", expression, errmsg)

		return nil, errmsg
	end

	return fn
end

function BattleUnitManager:_buildRules(targetPreview)
	local ruleFunc = self._ruleFuncs[targetPreview]

	if ruleFunc then
		return ruleFunc
	else
		local targetRule = ConfigReader:getDataByNameIdAndKey("TargetPreviewRule", targetPreview, "Function")
		local func = compileExpression(targetRule)

		if func ~= nil then
			ruleFunc = setfenv(func, self._env)
			self._ruleFuncs[targetPreview] = ruleFunc

			return ruleFunc
		end
	end
end

function BattleUnitManager:checkTargetPreview(targetPreview, pos)
	local ruleFunc = self:_buildRules(targetPreview)

	if ruleFunc then
		self._env.setPos(pos)

		return ruleFunc()
	end
end
