-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "BaseComponent")
require(__PACKAGE__ .. "HealthComponent")
require(__PACKAGE__ .. "AngerComponent")
require(__PACKAGE__ .. "NumericComponent")
require(__PACKAGE__ .. "SpecialNumericComponent")
require(__PACKAGE__ .. "PositionComponent")
require(__PACKAGE__ .. "FlagComponent")
require(__PACKAGE__ .. "GenreComponent")
require(__PACKAGE__ .. "SkillComponent")
require(__PACKAGE__ .. "FSMComponent")
require(__PACKAGE__ .. "BagComponent")
