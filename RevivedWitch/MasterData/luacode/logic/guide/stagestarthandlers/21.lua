-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/guide/stagestarthandlers/21.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local func = function(guideFrame)
  -- function num : 0_0 , upvalues : _ENV
  local child = nil
  local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
  if dialog and dialog._groupBtnFrame and #dialog._shopIDTypeList > 0 then
    local index = nil
    local groupBtnID = tonumber(guideFrame[1])
    for i,v in ipairs(dialog._shopIDTypeList) do
      if v == groupBtnID then
        index = i
        break
      end
    end
    do
      do
        if index then
          local logicCell = (dialog._groupBtnFrame):GetLogicCell(index)
          if logicCell and logicCell._cell then
            child = (logicCell._cell):GetChild("GroupBtn/Guide")
          end
        end
        return child
      end
    end
  end
end

return func

