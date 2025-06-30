-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stageconditionhandlers/2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(conditionInfo, luaWindow)
  -- function num : 0_0 , upvalues : _ENV
  local params = conditionInfo.parm
  if luaWindow and #params > 0 then
    local dialog = (DialogManager.GetDialog)("character.basecharacterlistalldialog")
    if dialog then
      local index = nil
      for i,v in ipairs(dialog._listByConditions) do
        if v:GetId() == tonumber(params[1]) then
          index = i
          break
        end
      end
      do
        do
          do
            if index then
              local logicCell = (dialog._frame):GetLogicCell(index)
              if logicCell and logicCell._cell then
                local window = (logicCell._cell):GetChild("CharacterCell")
                local tag = luaWindow == (logicCell._cell):GetRootWindow()
                if tag then
                  (dialog._frame):SetSlide(true)
                  return true
                else
                  return false
                end
              else
                return false
              end
            else
              return false
            end
            do return false end
            do return false end
            -- DECOMPILER ERROR: 7 unprocessed JMP targets
          end
        end
      end
    end
  end
end

return func

