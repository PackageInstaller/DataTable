-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/sdk/unit_iterators.lua

if not SkillDevKit then
	local exports = {}
	local abs, min, max = math.abs, math.min, math.max
	local FilterMeta = {}

	local function MakeFilter(func)
		return setmetatable({
			__func = func
		}, FilterMeta)
	end

	_G.MakeFilter = MakeFilter

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

	local function makeBuffMatchFunction(env, tagOrFilter)
		if tagOrFilter == nil then
			return nil
		end

		local atype = type(tagOrFilter)

		if atype == "string" then
			return function(buff)
				return buff:isMatched(tagOrFilter)
			end
		elseif atype == "table" or atype == "function" then
			return function(buff)
				return tagOrFilter(env, buff)
			end
		end
	end

	function SkillDevKit.ONESELF(env, who)
		return MakeFilter(function(_, unit)
			return unit == who
		end)
	end

	function SkillDevKit.TEAMMATES_OF(env, who)
		local side = who:getSide()

		return MakeFilter(function(_, unit)
			return unit:getSide() == side
		end)
	end

	function SkillDevKit.ROW_OF(env, who)
		local rpos = who:getPosition()

		return MakeFilter(function(_, unit)
			local pos = unit:getPosition()

			return pos.x == rpos.x and pos.zone == rpos.zone
		end)
	end

	function SkillDevKit.COL_OF(env, who)
		local rpos = who:getPosition()

		return MakeFilter(function(_, unit)
			local pos = unit:getPosition()

			return pos.y == rpos.y and pos.zone == rpos.zone
		end)
	end

	function SkillDevKit.CROSS_OF(env, who)
		local rpos = who:getPosition()
		local x, y, zone = rpos.x, rpos.y, rpos.zone

		return MakeFilter(function(_, unit)
			local pos = unit:getPosition()

			return pos.zone == zone and (pos.x == x or pos.y == y)
		end)
	end

	function SkillDevKit.NEIGHBORS_OF(env, who)
		local rpos = who:getPosition()
		local x, y, zone = rpos.x, rpos.y, rpos.zone

		return MakeFilter(function(_, unit)
			local pos = unit:getPosition()

			return pos.zone == zone and abs(pos.x - x) + abs(pos.y - y) == 1
		end)
	end

	function SkillDevKit.FRONT_OF(env, who, excluded)
		local rpos = who:getPosition()
		local rzone, rx = rpos.zone, rpos.x

		if excluded then
			if not (rx - 1) then
				local boundary = rx

				return MakeFilter(function(_, unit)
					local pos = unit:getPosition()

					return pos.x <= boundary and pos.zone == rzone
				end)
			end
		end
	end

	function SkillDevKit.BACK_OF(env, who, excluded)
		local rpos = who:getPosition()
		local rzone, rx = rpos.zone, rpos.x

		if excluded then
			if not (rx + 1) then
				local boundary = rx

				return MakeFilter(function(_, unit)
					local pos = unit:getPosition()

					return pos.x >= boundary and pos.zone == rzone
				end)
			end
		end
	end

	function SkillDevKit.ABOVE(env, who, excluded)
		local rpos = who:getPosition()
		local rzone, ry = rpos.zone, rpos.y

		if excluded then
			if not (ry - 1) then
				local boundary = ry

				return MakeFilter(function(_, unit)
					local pos = unit:getPosition()

					return pos.y <= boundary and pos.zone == rzone
				end)
			end
		end
	end

	function SkillDevKit.BELOW(env, who, excluded)
		local rpos = who:getPosition()
		local rzone, ry = rpos.zone, rpos.y

		if excluded then
			if not (ry + 1) then
				local boundary = ry

				return MakeFilter(function(_, unit)
					local pos = unit:getPosition()

					return pos.y >= boundary and pos.zone == rzone
				end)
			end
		end
	end

	function SkillDevKit.HAS_SUMMONER(env, who)
		if who then
			return MakeFilter(function(_, unit)
				return unit:getSummoner() == who
			end)
		else
			return MakeFilter(function(_, unit)
				return unit:getSummoner() ~= nil
			end)
		end
	end

	SkillDevKit.OBLIQUE_CROSS = MakeFilter(function(_, unit)
		local pos = unit:getPosition()

		return abs(pos.x - 2) == 1 and abs(pos.y - 2) == 1 or pos.x == 2 and pos.y == 2
	end)
	SkillDevKit.MID_CROSS = MakeFilter(function(_, unit)
		local pos = unit:getPosition()

		return pos.x == 2 or pos.y == 2
	end)
	SkillDevKit.TOP_COL = MakeFilter(function(_, unit)
		local pos = unit:getPosition()

		return pos.y == 1
	end)
	SkillDevKit.MID_COL = MakeFilter(function(_, unit)
		local pos = unit:getPosition()

		return pos.y == 2
	end)
	SkillDevKit.BOTTOM_COL = MakeFilter(function(_, unit)
		local pos = unit:getPosition()

		return pos.y == 3
	end)
	SkillDevKit.FRONT_ROW = MakeFilter(function(_, unit)
		local pos = unit:getPosition()
		local x = pos.x

		return x == 1 or x == -1
	end)
	SkillDevKit.MID_ROW = MakeFilter(function(_, unit)
		local pos = unit:getPosition()
		local x = pos.x

		return x == 2 or x == -2
	end)
	SkillDevKit.BACK_ROW = MakeFilter(function(_, unit)
		local pos = unit:getPosition()
		local x = pos.x

		return x == 3 or x == -3
	end)

	function SkillDevKit.MARKED(env, flag)
		return MakeFilter(function(_, unit)
			return unit:hasFlag(flag)
		end)
	end

	function SkillDevKit.HASSTATUS(env, statu)
		return MakeFilter(function(_, unit)
			return unit:hasStatus(statu)
		end)
	end

	function SkillDevKit.HASBUFFTAG(env, filter)
		local buffSystem = env.global["$BuffSystem"]
		local matchFunc = makeBuffMatchFunction(env, filter)

		return MakeFilter(function(_, unit)
			local buffs = buffSystem:selectBuffsOnTarget(unit, matchFunc)

			return #buffs > 0
		end)
	end

	SkillDevKit.PETS = MakeFilter(function(_, unit)
		local flag = unit:getComponent("Flag")

		if not flag:hasStatus(kBEOffline) then
			return unit:getFlagCheckers()["$HERO"](unit)
		end
	end)
	SkillDevKit.MASTER = MakeFilter(function(_, unit)
		return unit:getFlagCheckers()["$MASTER"](unit)
	end)
	SkillDevKit.SUMMONS = MakeFilter(function(_, unit)
		return unit:getFlagCheckers()["$SUMMONED"](unit)
	end)

	local function filterArrayElements(env, array, filter, total)
		local result, count = {}, 0

		if total == nil then
			total = #array
		end

		for i = 1, total do
			local element = array[i]

			if element and filter(env, element) then
				count = count + 1
				result[count] = element
			end
		end

		return result, count
	end

	_G.filterArrayElements = filterArrayElements

	function SkillDevKit.AllUnits(env, filter)
		local actorSide = env["$actor"]:getSide()
		local units_ = env.global["$BattleField"]:crossCollectUnits({}, actorSide)
		local units = {}

		for k, v in pairs(units_) do
			local flag = v:getComponent("Flag")

			if not flag:hasStatus(kBEOffline) then
				units[#units + 1] = v
			end
		end

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end

	function SkillDevKit.FriendUnits(env, filter)
		local targetSide = env["$actor"]:getSide()
		local units_ = env.global["$BattleField"]:collectUnits({}, targetSide)
		local units = {}

		for k, v in pairs(units_) do
			local flag = v:getComponent("Flag")

			if not flag:hasStatus(kBEOffline) then
				units[#units + 1] = v
			end
		end

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end

	function SkillDevKit.FriendEntities(env, filter)
		local targetSide = env["$actor"]:getSide()
		local units_ = env.global["$BattleField"]:collectAllUnits({}, targetSide)
		local units = {}

		for k, v in pairs(units_) do
			local flag = v:getComponent("Flag")

			if not flag:hasStatus(kBEOffline) then
				units[#units + 1] = v
			end
		end

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end

	function SkillDevKit.EnemyUnits(env, filter)
		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local units_ = env.global["$BattleField"]:collectUnits({}, targetSide)
		local units = {}

		for k, v in pairs(units_) do
			local flag = v:getComponent("Flag")

			if not flag:hasStatus(kBEOffline) then
				units[#units + 1] = v
			end
		end

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end

	function SkillDevKit.EnemyMaster(env)
		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local units = env.global["$BattleField"]:collectUnits({}, targetSide)

		for _, unit in ipairs(units) do
			if unit:getFlagCheckers()["$MASTER"](unit) then
				return unit
			end
		end

		return nil
	end

	function SkillDevKit.FriendMaster(env)
		local targetSide = env["$actor"]:getSide()
		local units = env.global["$BattleField"]:collectUnits({}, targetSide)

		for _, unit in ipairs(units) do
			if unit:getFlagCheckers()["$MASTER"](unit) then
				return unit
			end
		end

		return nil
	end

	function SkillDevKit.FriendField(env)
		local targetSide = env["$actor"]:getSide()
		local units = env.global["$BattleField"]:collectFieldUnits({}, targetSide)

		for _, unit in ipairs(units) do
			if unit:getFlagCheckers()["$FIELD"](unit) then
				return unit
			end
		end

		return nil
	end

	function SkillDevKit.EnemyField(env)
		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local units = env.global["$BattleField"]:collectFieldUnits({}, targetSide)

		for _, unit in ipairs(units) do
			if unit:getFlagCheckers()["$FIELD"](unit) then
				return unit
			end
		end

		return nil
	end

	function SkillDevKit.Killer(env)
		local foeId = env["$actor"]:getFoe()

		if not foeId then
			return
		end

		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local units = env.global["$BattleField"]:collectUnits({}, targetSide)

		for _, unit in ipairs(units) do
			if unit:getId() == foeId then
				return unit
			end
		end

		return nil
	end

	function SkillDevKit.Slice(env, array, start, ended)
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

	function SkillDevKit.SortBy(env, array, compare, keyGetter)
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

				keys[elem] = keyGetter(env, elem)
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

	function SkillDevKit.BestN(env, n, propName, array)
		local newArray = {}

		for _, unit in ipairs(array) do
			newArray[#newArray + 1] = exports._getUnitProperty(unit, propName, {
				unit = unit
			})
		end

		table.sort(newArray, function(a, b)
			return a[propName] > b[propName]
		end)

		local result = {}

		for i = 1, n do
			result[i] = newArray[i] and newArray[i].unit
		end

		return result
	end

	function SkillDevKit.WorstN(env, n, propName, array)
		local newArray = {}

		for _, unit in ipairs(array) do
			newArray[#newArray + 1] = exports._getUnitProperty(unit, propName, {
				unit = unit
			})
		end

		table.sort(newArray, function(a, b)
			return a[propName] < b[propName]
		end)

		local result = {}

		for i = 1, n do
			result[i] = newArray[i] and newArray[i].unit
		end

		return result
	end

	function SkillDevKit.RandomN(env, n, array)
		local targets, cnt = {}, 0

		for i, target in ipairs(array) do
			cnt = cnt + 1
			targets[cnt] = target
		end
	end

	function SkillDevKit.FriendDiedUnits(env, filter)
		local targetSide = env["$actor"]:getSide()
		local units = env.global["$FormationSystem"]:getCemetery():getUnitsBySide(targetSide)

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end

	function SkillDevKit.EnemyDiedUnits(env, filter)
		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local units = env.global["$FormationSystem"]:getCemetery():getUnitsBySide(targetSide)

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end

	function SkillDevKit.AllDiedUnits(env, filter)
		local targetSide = env["$actor"]:getSide()
		local units_f = env.global["$FormationSystem"]:getCemetery():getUnitsBySide(targetSide)
		local targetSide = opposeBattleSide(env["$actor"]:getSide())
		local units_e = env.global["$FormationSystem"]:getCemetery():getUnitsBySide(targetSide)
		local units = {}

		for k, v in pairs(units_f) do
			units[#units + 1] = v
		end

		for k, v in pairs(units_e) do
			units[#units + 1] = v
		end

		if filter == nil then
			return units
		end

		return filterArrayElements(env, units, filter)
	end
end
