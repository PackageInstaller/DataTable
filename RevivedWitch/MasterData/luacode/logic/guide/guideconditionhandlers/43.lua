-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/guideconditionhandlers/43.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  local dialog = (DialogManager.GetTopmostDialog)()
  if dialog then
    for i,v in ipairs(params) do
      local dialogName = (DataCommon.Dialog)[tonumber(params[i])]
      if dialogName and dialogName == dialog._dialogName then
        if dialogName == "character.newcharacterinfodialog" then
          local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
          if dialog and dialog._tag == 1 then
            return true
          end
        else
          do
            do
              do return true end
              -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

return func

