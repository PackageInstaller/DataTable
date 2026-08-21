local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_chips, m_items

function SetupWindow()
  LU.Bind(REF.ChipContent, {
    updateRow = OnChipItemShow
  })
  WU.BindButtonEvent(REF.NodeContinue, function()
    WU.RecycleWindow("ActorDecomposeResult")
  end)
end

function SetView(resChange)
  m_chips = {}
  m_items = {}
  for _, change in pairs(resChange) do
    if change.baseRes and change.baseRes.countDelta > 0 then
      local itemInfo = PB.get("ItemInfo", change.baseRes.id)
      if itemInfo and itemInfo.type == PB.enum.ItemType.ActorChip then
        table.insert(m_chips, change.baseRes)
      else
        table.insert(m_items, change.baseRes)
      end
    end
  end
  LU.Set(REF.ChipContent, #m_chips)
  ShowExtraContent()
end

function OnChipItemShow(rowRef, wrapIndex, realIndex)
  if m_chips and realIndex ~= nil and realIndex < #m_chips then
    local res = m_chips[realIndex + 1]
    rowRef["$$SetData"](res.type, res.id, res.countDelta)
  end
end

function ShowExtraContent()
  for i = 0, #REF.ExtraContent - 1 do
    local ref = REF.ExtraContent[i]
    local item = m_items[i + 1]
    ref.root.gameObject:SetActive(i < #m_items)
    if i < #m_items then
      ref["$$SetData"](item.type, item.id, item.countDelta)
    end
  end
  REF.LabelExtraGot.gameObject:SetActive(0 < #m_items)
  REF.ExtraContent.UIGrid:Reposition()
end
