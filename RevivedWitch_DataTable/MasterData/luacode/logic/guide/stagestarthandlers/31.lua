-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/31.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("bag.rolereset.changeselectroledialog")
  if dialog and dialog._upFrame and dialog._listByConditions then
    if #dialog._listByConditions > 0 then
      local logicCell = (dialog._upFrame):GetLogicCell(1)
      if logicCell and logicCell._cell then
        child = (logicCell._cell):GetRootWindow()
      end
      if child then
        (dialog._upFrame):SetSlide(false)
      end
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Guide):FinishGuide(65)
        return child
      end
    end
  end
end

return func

