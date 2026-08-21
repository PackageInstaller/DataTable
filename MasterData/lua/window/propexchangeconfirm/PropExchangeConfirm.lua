local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_messageCallback, m_closeMessage
local m_toggleSelect = false
local m_exchangeInfo
local m_num = 1
local m_max = 99999999

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnUIYes)
  REF.ButtonClose["$SetCallback"](OnUIClose)
  REF.Black["$SetCallback"](OnUIClose)
  LU.Bind(REF.PreviewContent, {
    updateRow = UpdateSlot
  })
end

function SetView(exchangeInfo, currentBuyCount)
  m_exchangeInfo = exchangeInfo
  if exchangeInfo then
    m_max = exchangeInfo.buyLimit - currentBuyCount
    LU.Set(REF.PreviewContent, #exchangeInfo.good)
    for i = 0, #REF.MyMoney - 1 do
      local cost = exchangeInfo.cost[i + 1]
      local ref = REF.MyMoney[i]
      WU.SetActive(ref.LabelMoney, cost ~= nil)
      if cost ~= nil then
        local myCount = GetCount(cost.type, cost.id)
        local c = myCount // cost.count
        if c < m_max then
          m_max = c
        end
        WU.SetActive(ref.root, true)
        ref.LabelMoney.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
        ref["@cost"] = cost
        WU.BindButtonEvent(ref.root, OnShowMoneyMessage)
      else
        WU.SetActive(ref.root, false)
      end
    end
    REF.MyMoney.UIGrid:Reposition()
    REF.WidgetNumberEdit["$SetNumberUpdateCallback"](OnItemNumEdit)
    REF.WidgetNumberEdit["$SetShowMax"](true)
    REF.WidgetNumberEdit["$SetRange"](1, m_max)
    REF.WidgetNumberEdit["$SetNumber"](1, true)
  end
end

function OnItemNumEdit(num)
  m_num = num
  for i = 0, #REF.MyMoney - 1 do
    local cost = m_exchangeInfo.cost[i + 1]
    if cost ~= nil then
      REF.MyMoney[i].LabelMoney.ResourcePrinter:SetResource(cost.type, cost.id, cost.count * num)
    end
  end
end

function UpdateSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_exchangeInfo == nil or index > #m_exchangeInfo.good then
    return
  end
  local good = m_exchangeInfo.good[index]
  slotRef["$$SetData"](good.type, good.id, good.count)
end

function OnShowMoneyMessage(go)
  local cost = _ENV["$"](go)["@cost"]
  WU.ShowResourceDetail(cost.type, cost.id)
end

function OnClick(message)
  WU.RecycleWindow(this)
  if m_messageCallback ~= nil then
    m_messageCallback(message, m_num)
    m_messageCallback = nil
  end
end

function SetCallback(callback)
  m_messageCallback = callback
end

function OnUIYes()
  OnClick("YES")
end

function OnUIClose()
  OnClick("Close")
end

function GetCount(type, id)
  if type == PB.enum.ResourceType.ResItem then
    local itemInfo = DB:GetData("fci/item/" .. id)
    if itemInfo then
      return itemInfo.count
    else
      return 0
    end
  else
    return DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[type] .. "_" .. id) or 0
  end
end
