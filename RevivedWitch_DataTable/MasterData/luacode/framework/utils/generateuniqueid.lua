-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/generateuniqueid.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local _id = 0
generateUniqueId = function()
  -- function num : 0_0 , upvalues : _id
  _id = _id + 1
  return _id
end


