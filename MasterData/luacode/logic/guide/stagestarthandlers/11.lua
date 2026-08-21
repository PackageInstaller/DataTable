-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/11.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("equipforge.equipforgedialog")
  if dialog and dialog._tab and dialog._tab == 1 then
    if #dialog._forgeIetmData > 0 then
      local index = 1
      local data = (dialog._forgeIetmData)[index]
      do
        do
          if data then
            local logicCell = (dialog._item_frame):GetLogicCell(index)
            if logicCell and logicCell._cell then
              child = (logicCell._cell):GetRootWindow()
            end
          end
          if child then
            (dialog._item_frame):SetSlide(false)
          end
          ;
          ((NekoData.BehaviorManager).BM_Guide):FinishGuide(53)
          return child
        end
      end
    end
  end
end

return func

