-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/28.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  if guideFrame and #guideFrame == 2 then
    local child = nil
    local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
    if dialog and dialog._which == 2 and dialog._frame and dialog._data then
      local cell = (dialog._frame):GetLogicCell(1)
      if cell and cell._cell and (cell._cell)._frame and #(cell._cell)._data > 0 then
        local typeId = (tonumber(guideFrame[1]))
        local index = nil
        for i,v in ipairs((cell._cell)._data) do
          if v.id == typeId then
            index = i
            break
          end
        end
        do
          do
            if index then
              local cell_cell = ((cell._cell)._frame):GetLogicCell(index)
              if cell_cell and cell_cell._cell then
                child = (cell_cell._cell):GetChild(guideFrame[2])
              end
            end
            do return child end
          end
        end
      end
    end
  end
end

return func

