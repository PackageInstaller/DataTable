-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/7.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  if luaWindow and #params > 0 then
    for i,v in ipairs(params) do
      local list = (string.split)(v, "@")
      local dialogName = list[1]
      local dialog = (DialogManager.GetDialog)(dialogName)
      if dialog then
        local child = nil
        if not list[2] then
          child = dialog:GetRootWindow()
        else
          child = dialog:GetChild(list[2])
        end
        if luaWindow ~= child then
          do
            do return not child end
            do return false end
            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  else
    return false
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

return func

