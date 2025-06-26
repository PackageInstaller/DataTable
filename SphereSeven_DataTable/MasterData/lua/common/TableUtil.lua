--[[
-- added by wsh @ 2017-12-11
-- table扩展工具类，对table不支持的功能执行扩展
-- 注意：
-- 1、所有参数带hashtable的函数，将把table当做哈希表对待
-- 2、所有参数带array的函数，将把table当做可空值数组对待
-- 3、所有参数带tb的函数，对表通用，不管是哈希表还是数组
--]]

-- 计算哈希表长度
local function count(hashtable)
	local count = 0
	for _,_ in pairs(hashtable) do
		count = count + 1
	end
	return count
end

-- 计算数据长度
local function length(list)
	if list.n ~= nil then
		return list.n
	end
	
	local count = 0
	for i,_ in pairs(list) do
		if count < i then
			count = i
		end		
	end
	return count
end

-- 设置数组长度
local function setlen(list, n)
	list.n = n
end

-- 获取哈希表所有键
local function keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

-- 获取哈希表所有值
local function values(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end

-- 合并哈希表：将src_hashtable表合并到dest_hashtable表，相同键值执行覆盖
local function merge(dest_hashtable, src_hashtable)
    for k, v in pairs(src_hashtable) do
        dest_hashtable[k] = v
    end
end

-- 合并数组：将src_array数组从begin位置开始插入到dest_array数组
-- 注意：begin <= 0被认为没有指定起始位置，则将两个数组执行拼接
local function insertto(dest_array, src_array, begin)
	assert(begin == nil or type(begin) == "number")
	if begin == nil or begin <= 0 then
		begin = #dest_array + 1
	end

	local src_len = #src_array
	for i = 0, src_len - 1 do
		dest_array[i + begin] = src_array[i + 1]
	end
end

-- 从数组中查找指定值，返回其索引，没找到返回false
local function indexof(list, value, begin)
    for i = begin or 1, #list do
        if list[i] == value then 
			return i 
		end
    end
	return false
end

local function contains(list, value)
	for i = 1, #list do
		if list[i] == value then
			return true
		end
	end
	return false
end

-- 从哈希表查找指定值，返回其键，没找到返回nil
-- 注意：
-- 1、containskey用hashtable[key] ~= nil快速判断
-- 2、containsvalue由本函数返回结果是否为nil判断
local function keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then 
			return k 
		end
    end
    return nil
end

-- 从数组中删除指定值，返回删除的值的个数(数组)
function table.removebyvalue(list, value, removeall)
    local remove_count = 0
	for i = #list, 1, -1 do
		if list[i] == value then
			table.remove(list, i)
			remove_count = remove_count + 1
            if not removeall then 
				break 
			end
		end
	end
	return remove_count
end


-- 遍历写：用函数返回值更新表格内容
local function map(tb, func)
    for k, v in pairs(tb) do
        tb[k] = func(k, v)
    end
end

-- 遍历读：不修改表格
local function walk(tb, func)
    for k,v in pairs(tb) do
        func(k, v)
    end
end

-- 按指定的排序方式遍历：不修改表格
local function walksort(tb, sort_func, walk_func)
	local keys = table.keys(tb)
	table.sort(keys, function(lkey, rkey)
		return sort_func(lkey, rkey)
	end)
	for i = 1, table.length(keys) do
		walk_func(keys[i], tb[keys[i]])
	end
end

-- 不连续的key排序
local function sortbykey(tb)
	local keys = table.keys(tb)
	--对key进行排序
	table.sort(keys, function(a, b)
		return a < b
	end)
	local tab = {}
	for i, key in ipairs(keys) do
		table.insert(tab, tb[key])
	end
	return tab
end

-- 过滤掉不符合条件的项：不对原表执行操作
local function filter(tb, func)
	local filter = {}
    for k, v in pairs(tb) do
        if not func(k, v) then 
			filter[k] = v
		end
    end
	return filter
end

-- 筛选出符合条件的项：不对原表执行操作
local function choose(tb, func)
	local choose = {}
    for k, v in table.pairsByKeys(tb) do
        if func(k, v) then 
			choose[k] = v
		end
    end
	return choose
end

local function chooseByIndex(tb,func)
	local choose = {}
	local index = 0
	for k, v in table.pairsByKeys(tb) do
		if func(k, v) then
			index = index + 1
			choose[index] = v
		end
	end
	return choose
end

-- 获取数据循环器：用于循环数组遍历，每次调用走一步，到数组末尾从新从头开始
local function circulator(list)
	local i = 1
	local iter = function()
		i = i >= #list and 1 or i + 1
		return list[i]
	end
	return iter
end

-- dump表
local function _table2str(lua_table, raw_table, table_map, n, fold, indent)
	indent = indent or 1
	for k, v in pairs(lua_table) do
		local _continue=false
		if type(k) == 'string' then
			if(string.startswith(k,"_")  or k == "__entity" or k == "Delete" or k == "is_disposed")then --or k == "Components"
				_continue=true
			end
			k = string.format('%q', k)
		else
			k = tostring(k)
		end
		if(not _continue)then
			n = n + 1; raw_table[n] = string.rep('    ', indent)
			n = n + 1; raw_table[n] = '['
			n = n + 1; raw_table[n] = k
			n = n + 1; raw_table[n] = ']'
			n = n + 1; raw_table[n] = ' = '
			if type(v) == 'table' then
				if fold and table_map[tostring(v)] then
					n = n + 1; raw_table[n] = tostring(v)
					n = n + 1; raw_table[n] = ',\n'
				else
					table_map[tostring(v)] = true
					n = n + 1; raw_table[n] = '{\n'
					n = _table2str(v, raw_table, table_map, n, fold, indent + 1)
					n = n + 1; raw_table[n] = string.rep('    ', indent)
					n = n + 1; raw_table[n] = '},\n'
				end
			else
				if type(v) == 'string' then
					v = string.format('%q', v)
				else
					v = tostring(v)
				end
				n = n + 1; raw_table[n] = v
				n = n + 1; raw_table[n] = ',\n'
			end
		end
	end
	return n
end

local function dump(lua_table, fold)
	if type(lua_table) == 'table' then
		local raw_table = {}
		local table_map = {}
		table_map[tostring(lua_table)] = true
		local n = 0
		n = n + 1; raw_table[n] = '{\n'
		n = _table2str(lua_table, raw_table, table_map, n, fold)
		n = n + 1; raw_table[n] = '}'
		return table.concat(raw_table, '')
	else
		return lua_table
	end
end

local function clone( obj )
	local InTable = {};
	local function Func(obj)
		if type(obj) ~= "table" then   --判断表中是否有表
			return obj;
		end
		local NewTable = {};  --定义一个新表
		InTable[obj] = NewTable;  --若表中有表，则先把表给InTable，再用NewTable去接收内嵌的表
		for k,v in pairs(obj) do  --把旧表的key和Value赋给新表
			NewTable[Func(k)] = Func(v);
		end
		return setmetatable(NewTable, getmetatable(obj))--赋值元表
	end
	return Func(obj) --若表中有表，则把内嵌的表也复制了
end

-- dump表
local function dump0(tb, dump_metatable, max_level)
	local lookup_table = {}
	local level = 0
	local rep = string.rep
	local dump_metatable = dump_metatable
	local max_level = max_level or 1

	local function _dump(tb, level)
		local str = "\n" .. rep("\t", level) .. "{\n"
		for k,v in pairs(tb) do
			local k_is_str = type(k) == "string" and 1 or 0
			local v_is_str = type(v) == "string" and 1 or 0
			str = str..rep("\t", level + 1).."["..rep("\"", k_is_str)..(tostring(k) or type(k))..rep("\"", k_is_str).."]".." = "
			if type(v) == "table" then
				if not lookup_table[v] and ((not max_level) or level < max_level) then
					lookup_table[v] = true
					str = str.._dump(v, level + 1, dump_metatable).."\n"
				else
					str = str..(tostring(v) or type(v))..",\n"
				end
			else
				str = str..rep("\"", v_is_str)..(tostring(v) or type(v))..rep("\"", v_is_str)..",\n"
			end
		end
		if dump_metatable then
			local mt = getmetatable(tb)
			if mt ~= nil and type(mt) == "table" then
				str = str..rep("\t", level + 1).."[\"__metatable\"]".." = "
				if not lookup_table[mt] and ((not max_level) or level < max_level) then
					lookup_table[mt] = true
					str = str.._dump(mt, level + 1, dump_metatable).."\n"
				else
					str = str..(tostring(v) or type(v))..",\n"
				end
			end
		end
		str = str..rep("\t", level) .. "},"
		return str
	end

	return _dump(tb, level)
end

local function pairsByKeys(t)
	local a = {}

	for n in pairs(t) do
		a[#a + 1] = n
	end
	
	table.sort(a)
	

	local i = 0

	return function()
		i = i + 1
		return a[i], t[a[i]]
	end
end

local function csenu(csList,func)
	local enu =csList:GetEnumerator()
	while enu:MoveNext() do
		func(enu.Current)
	end
end

local function csenuObject(transform,func,isComplete)
	if isComplete then
		func(transform)
	end
	if transform.childCount > 0 then
		for i = 0,transform.childCount -1 do
			local child = transform:GetChild(i);
			func(child);
			table.csenuObject(child,func);
		end
	end
end

---找到第一个匹配的元素
local function first(tb,func)
	if func == nil then
		for k,v in table.pairsByKeys(tb) do
			return v;
		end
	end

	for _, v in pairs(tb) do
		if func(v) then
			return v
		end
	end
	return nil
end


---如果有一个元素匹配就返回true
local function any(tb,func)
	for _, v in pairs(tb) do
		if func(v) then
			return true
		end
	end
	return false
end
---如果有一个元素不匹配就返回false
local function all(tb,func)
	for _, v in pairs(tb) do
		if not func(v) then
			return false
		end
	end
	return true
end

---从表中删除匹配的元素
local function removeall(list,func)
	for i = #list, 1, -1 do
		if func(list[i]) then
			table.remove(list, i)
		end
	end
end

local function removeget(list,func)
	for i = #list, 1, -1 do
		if func(list[i]) then
			return table.remove(list, i)
		end
	end
end

local function sum(list)
	local sumVal = 0
	for _, v in ipairs(list) do
		sumVal = sumVal + v
	end
	return sumVal
end

local function sortedfirst(list,sort_func)
	local vals = table.values(list)
	table.sort(vals, function(lv, rv)
		return sort_func(lv, rv)
	end)
	return vals[1]
end

local function randget(list)
	if #list == 0 then
		return nil
	end
	--math.randomseed(os.time())
	return list[math.random(1,#list)]
end

local function randtake(list,num)
	--math.randomseed(os.time())
	map(list,function (k,v)
		v.__guid = math.random()
		return v
	end)
	table.sort(list,function (a,b) return a.__guid>b.__guid end)
	map(list,function (k,v)
		v.__guid = nil
		return v
	end)
	local ret = {}
	for i = 1, num, 1 do
		table.insert(ret,list[i])
	end
	return ret
end

local function concatenate(t1,t2)
	local tab = {};
	for k,v in table.pairsByKeys(t1) do
		tab[k] = v;
	end

	for k,v in table.pairsByKeys(t2) do
		tab[k] = v;
	end
	
	return tab;
end


local function reverseTable(tab)
	local tmp = {}
	for i = 1, #tab do
		local key = #tab
		tmp[i] = table.remove(tab)
	end

	return tmp
end

table.clone = clone
table.count = count
table.length = length
table.setlen = setlen
table.keys = keys
table.values = values
table.merge = merge
table.insertto = insertto
table.indexof = indexof
table.contains = contains
table.keyof = keyof
table.map = map
table.walk = walk
table.walksort = walksort
table.sortbykey = sortbykey
table.filter = filter
table.choose = choose
table.circulator = circulator
table.dump = dump
table.dump0 = dump0
table.pairsByKeys = pairsByKeys

table.csenu = csenu
table.csenuObject = csenuObject
table.first = first
table.any = any
table.all = all
table.removeall = removeall
table.removeget = removeget
table.sum = sum
table.sortedfirst = sortedfirst
table.randget = randget
table.randtake = randtake
table.concatenate = concatenate
table.reverseTable = reverseTable
table.chooseByIndex = chooseByIndex

