
--注册oo模块
-- module("oo", package.seeall)

local function Copy(src, dst, copy)
	dst = dst or {}
	copy = copy or {}  -- 用于存放已经引用的table,防止table拷贝死循环
	assert(type(src) == "table" and type(dst) == "table" and type(copy) == "table")
	copy[src]=dst
	local k, v
	for k, v in pairs(src) do
		if type(v) == "table" then
			dst[k] = copy[v] or Copy(v, {}, copy)
		else
			dst[k] = v
		end
	end
	return dst
end

-- 实例化类()调用 
local function new(clz, ...)
	local obj = {}
	-- 设置 mt 存放父类的元表
	local mt = rawget(clz, "mt")
	if not mt then
		-- 新建元表元方法
		mt = {
			__index		= clz,				-- obj没有的key会来__index元表中寻找
			__tostring	= clz.__tostring,	-- 转字符串
			__add		= clz.__add,		-- 重载 +
			__sub		= clz.__sub,		-- 重载 -
			__mul		= clz.__mul,		-- 重载 *
			__div		= clz.__div,		-- 重载 /
			__mod		= clz.__mod,		-- 重载 %
			__pow		= clz.__pow,		-- 重载 ^
			__unm		= clz.__unm,		-- 重载 -(负号)
			__concat	= clz.__concat,		-- 重载 ..
			__len		= clz.__len,		-- 重载 #
			__eq		= clz.__eq,			-- 重载 =
			__lt		= clz.__lt,			-- 重载 <
			__le		= clz.__le,			-- 重载 <=
			__call		= clz.__call, 		-- 重载 ()
			__gc		= clz.__gc,			-- 垃圾收集器
		}
		rawset(clz, "mt", mt)
	end
	-- 设置obj实例的元表
	setmetatable(obj, mt)
	-- 调用实例的初始化
	obj:Init(...)
	return obj
end
--------------------------------------------------------------------------------------------
-- 基础类,所有类都继承ClassBase
local ClassBase = {}

-- 初始化调用
function ClassBase:Init(obj)
	if obj ~= self and type(obj) == "table" then
		Copy(obj, self)
	end
end

-- 判断是否继承自类
function ClassBase:IsInherit(clz)
	local c = GetClass(self)
	while c and c ~= ClassBase do
		if c == clz then return true end
		c = GetSuper(c)
	end
	return false
end

function ClassBase:print(key)
	if key then
		LogTable(self[key], "ClassBase:print|"..key, true)
	else
		LogTable(self, "ClassBase:print", true)
	end
end
--------------------------------------------------------------------------------------------
-- 构造类, 或继承super
function class(super)
	local clz = {}
	super = super or ClassBase

	-- 默认的构造方法
	if not super.Init then
		function super:Init()
		end
	end

	-- 设置父类
	rawset(clz, "__super", super)
	setmetatable(clz, {__index = super, __call = new})
	
	return clz
end

function DebugClass(super)
	local clz = {}
	super = super or ClassBase
	-- 设置父类
	rawset(clz, "__super", super)
	setmetatable(clz, {__index = super, __call = new})

	return table.CreateDebug(clz)
end

--------------------------------------------------------------------------------------------
-- 类型判断相关

-- 获取父类, 实例化对象没有父类, 只能用GetClass获取父类
function GetSuper(clz)
	return rawget(clz, "__super")
end

-- 获取类类型 或 父类类型
function GetClass(obj)
	return getmetatable(obj).__index
end

-- 判断obj是否继承自clz类, 或obj是类clz的实例化
function IsInstance(obj, clz)
	return ((obj.IsInherit and obj:IsInherit(clz)) == true)
end

oo = {}
oo.class = class
