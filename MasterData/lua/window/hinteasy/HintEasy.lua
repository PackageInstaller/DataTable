local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local IU = require("Common/ItemUtil")
local m_callback

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    REF.EffectOpen.gameObject:SetActive(false)
    REF.ContentGrid.gameObject:SetActive(false)
    REF.Black.BoxCollider2D.enabled = false
    REF.EffectClose.EffectGenerator:Play(function()
      if m_callback then
        m_callback()
        m_callback = nil
      end
      WU.RecycleWindow(this)
    end)
  end)
end

function SetContent(resChange, effectOpen, effectClose, callback)
  m_callback = callback
  REF.Black.BoxCollider2D.enabled = false
  REF.EffectOpen.gameObject:SetActive(true)
  REF.ContentGrid.gameObject:SetActive(true)
  SetItem(SplitReschange(resChange))
  REF.EffectOpen.EffectGenerator.m_EffectName = effectOpen
  REF.EffectOpen.EffectGenerator:Reset()
  REF.EffectClose.EffectGenerator.m_EffectName = effectClose
  REF.EffectClose.EffectGenerator:Reset()
  REF.EffectOpen.EffectGenerator:Play(function()
    REF.Black.BoxCollider2D.enabled = true
  end)
end

function SplitReschange(resChange)
  local rewards = IU.FlatInboxItems(resChange)
  local items = {}
  for _, reward in pairs(rewards) do
    if reward.baseRes and reward.baseRes.countDelta > 0 and reward.baseRes.param == PB.enum.ResourceParamType.None then
      local type = reward.baseRes.type
      if reward.baseRes.type == PB.enum.ResourceType.ResItem then
        table.insert(items, {
          type = reward.baseRes.type,
          id = reward.baseRes.id,
          count = reward.baseRes.count,
          countDelta = reward.baseRes.countDelta,
          ownerBoxId = reward.ownerBoxId
        })
      end
    end
  end
  return items
end

function SetItem(items)
  WU.TraverseChildren(REF.ContentGrid, function(go, parIdx)
    local gasket = _ENV["$"](go).root
    local data = items[parIdx + 1]
    gasket.gameObject:SetActive(data ~= nil)
    if data then
      gasket["$SetData"](data.type, data.id, data.countDelta)
    end
  end)
  REF.ContentGrid.UIGrid:Reposition()
end
