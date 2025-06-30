-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/5.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local tag = true
  for i,v in ipairs(params) do
    local list = (string.split)(v, "@")
    local dialogName = (DataCommon.Dialog)[tonumber(list[1])]
    if dialogName then
      local value = tonumber(list[2])
      if value == 0 then
        tag = not (DialogManager.GetDialog)(dialogName)
      else
        if (DialogManager.GetDialog)(dialogName) == nil then
          do
            do
              tag = value ~= 1
              if tag then
                return true
              end
              do return false end
              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  do return tag end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return func

