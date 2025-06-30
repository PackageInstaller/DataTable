-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/5.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)(guideFrame[1])
  if dialog and dialog._which == 1 and dialog._frame then
    local cell = (dialog._frame):GetLogicCell(dialog._which)
    if cell and cell._cell then
      local cellIndex, index = nil, nil
      for i,v in ipairs((cell._cell)._data) do
        for j,data in ipairs(v) do
          if not data.lock and (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel >= data.unlockLv then
            cellIndex = i
            index = data.selecttype
          end
        end
      end
      if cellIndex and index then
        local cell_cell = ((cell._cell)._frame):GetLogicCell(cellIndex)
        if cell_cell and cell_cell._cell then
          return {parent = (((cell_cell._cell)._unlockImg)[index])._uiObject, 
effectPos = {posX = 0, posY = 0}
}
        end
      end
    end
  end
end

return func

