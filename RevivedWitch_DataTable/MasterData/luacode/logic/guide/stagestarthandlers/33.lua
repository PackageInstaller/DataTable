-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/33.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local params = guideFrame
  local child = nil
  if #params > 0 then
    local dialog = (DialogManager.GetDialog)("character.basecharacterlistalldialog")
    if dialog then
      local index = tonumber(params[1])
      do
        do
          if index then
            local logicCell = (dialog._frame):GetLogicCell(index)
            if logicCell and logicCell._cell then
              child = (logicCell._cell):GetRootWindow()
            end
          end
          if child then
            (dialog._frame):SetSlide(false)
          end
          return child
        end
      end
    end
  end
end

return func

