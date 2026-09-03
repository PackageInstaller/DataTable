-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/enchants/all.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "CardAgent")
require(__PACKAGE__ .. "EnchantEffect")
require(__PACKAGE__ .. "EnchantObject")
require(__PACKAGE__ .. "EnchantGroup")
require(__PACKAGE__ .. "enchants.CardCostEnchant")
