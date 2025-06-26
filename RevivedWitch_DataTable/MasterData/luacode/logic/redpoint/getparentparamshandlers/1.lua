-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/getparentparamshandlers/1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(childParams)
  -- function num : 0_0
  if not childParams or not childParams[1] then
    return 
  end
  return {childParams[1]}
end

return func

