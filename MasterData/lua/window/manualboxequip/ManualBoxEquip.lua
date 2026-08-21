local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local EA = require("Common/EquipAttr")
local DBH = require("Manager/DataBindingHandler")
local m_manualBox, m_dataList, m_selection, m_isPreview, m_callback, m_goodsInfo

function SetupWindow()
  LU.Bind(REF.WrapContentEquip, {
    updateRow = UpdateEquipSlot
  })
  WU.BindButtonEvent(REF.ButtonGet, OnGetClick)
  WU.BindButtonEvent(REF.ButtonBuy, OnBuyClick)
  WU.BindButtonEvent(REF.ButtonClose, OnCloseClick)
end

function InitWindow()
  this:Bind("EquipSlotSelected", OnEquipSlotSelected)
end

function UninitWindow()
  m_goodsInfo = nil
  this:SetData("EquipSlotSelected", nil)
end

function SetBoxId(boxId, isPreview, callback)
  if boxId then
    WU.ToggleRendering(REF.NodeContent, true)
    REF.LabelBoxName.UILabel.text = WU.GetString("ItemName_" .. boxId)
    REF.LabelBoxDesc.UIHtmlLabel.text = WU.GetItemDesc(boxId)
    m_isPreview = isPreview
    m_callback = callback
    m_manualBox = IU.GetManualBox(boxId)
    if m_manualBox.type == PB.enum.ManualBoxType.Equip then
      m_dataList = {}
      for k, v in ipairs(m_manualBox.inBoxArray) do
        table.insert(m_dataList, {
          index = k,
          inBox = v,
          isNew = IsNew(v)
        })
      end
      table.sort(m_dataList, function(a, b)
        return fif(a.isNew, 0, 1) < fif(b.isNew, 0, 1)
      end)
      LU.Set(REF.WrapContentEquip, #m_dataList)
      if 0 < #m_dataList then
        this:SetData("EquipSlotSelected", m_dataList[1])
      end
      WU.SetActive(REF.ButtonGet, not m_isPreview and not m_goodsInfo)
      WU.SetActive(REF.ButtonBuy, m_goodsInfo)
      if m_goodsInfo then
        local cost = m_goodsInfo.cost[1]
        REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
      end
    else
      error("ManualBoxEquip", "ManualBox with id " .. boxId .. " was not an equip box")
    end
    WU.ToggleRendering(REF.EffectOpen, false)
  end
end

function SetGoodsInfo(goodsInfo)
  m_goodsInfo = goodsInfo
  if m_goodsInfo then
    SetBoxId(m_goodsInfo.good.id)
  end
end

function OnEquipSlotSelected(selection)
  m_selection = selection
  UpdateData()
end

function UpdateData()
  if m_selection then
    local fakeEquip = {
      id = m_selection.inBox.id,
      randAttrIndex = 0,
      randAttrValueIndex = 0,
      level = 1
    }
    local equipAttr = EA.GetEquipAttr(fakeEquip)
    REF.WidgetEquipAttrTable["$SetEquipAttr"](equipAttr)
    REF.ScrollViewAttrs.UIScrollView:ResetPosition()
    REF.LabelEquipName.UILabel.text = WU.GetString("EquipName_" .. m_selection.inBox.id)
    local score = EA.GetEquipScore(m_selection.inBox.id, 1)
    local equipInfo = PB.get("EquipInfo", m_selection.inBox.id)
    if equipInfo then
      REF.LabelEquipScore.UIHtmlLabel.text = WU.GetString("Window_EquipBrief", math.floor(score), equipInfo.requireLevel)
    end
    REF.LabelEquipDesc.UIHtmlLabel.text = WU.GetString("EquipDesc_" .. m_selection.inBox.id)
  end
end

function UpdateEquipSlot(slotRef, wrapIndex, rowIndex)
  if m_dataList and rowIndex and rowIndex < #m_dataList then
    slotRef["$$SetData"](m_dataList[rowIndex + 1], rowIndex)
  end
end

function IsNew(inBox)
  local equips = this:GetData("fci/equip")
  local found = table.find(equips, function(k, v)
    return v.id == inBox.id
  end)
  return not found
end

function OnGetClick()
  this:GameRequest("fci/itemuse/"):Post({
    id = m_manualBox.id,
    count = 1,
    index = m_selection.index - 1
  }, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange, function()
      WU.RecycleWindow(this)
      DB:DelayInvokeInFrames(1, function()
        if m_callback then
          m_callback(true)
        end
      end)
    end)
  end)
end

function OnBuyClick()
  this:BroadcastGameEvent("TryToBuyGoods", m_goodsInfo, m_selection.index - 1, 1, function()
    WU.RecycleWindow(this)
    if m_callback then
      m_callback(true)
    end
  end)
end

function OnCloseClick()
  WU.RecycleWindow(this)
  DB:DelayInvokeInFrames(1, function()
    if m_callback then
      m_callback(false)
    end
  end)
end
