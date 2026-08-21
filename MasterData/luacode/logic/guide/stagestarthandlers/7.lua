-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/7.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  for i,v in ipairs(guideFrame) do
    local list = (string.split)(v, "@")
    local dialogName = list[1]
    local dialog = ((DialogManager.GetDialog)(dialogName))
    local child = nil
    if dialog then
      if not list[2] then
        child = dialog:GetRootWindow()
      else
        child = dialog:GetChild(list[2])
      end
    end
    if child then
      return child
    end
  end
end

return func

