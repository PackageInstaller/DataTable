local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local SU = require("Common/SortUtil")
local IU = require("Common/ItemUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allQualityEquips = {}
local m_materialItems = {}
local m_consumableItems = {}
local m_gachaItems = {}
local m_equipList = {}
local m_armList = {}
local m_armClick = false
local m_selectedEquipUids = _ENV["!"]({})
local m_decomposePreview = _ENV["!"]({})
local m_decomposeExpItemPreview = _ENV["!"]({})
local m_decomposeExpItemMap = _ENV["!"]({})
local m_decomposeResItemPreview = _ENV["!"]({})
local m_decomposeResItemMap = _ENV["!"]({})
local m_decomposing = false
local m_activeScrollView, m_currentSortMate, m_activeData, m_clearNewFlag
local m_tabID = 10652

function SetupWindow()
  CS.EventDelegate.Add(REF.EquipBagTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    REF.BtnDecompose.gameObject:SetActive(CS.UIToggle.current.value)
    if CS.UIToggle.current.value then
      WU.RecordButtonClick(106002)
      m_tabID = 10652
      WU.SetRuleCallback("Bag", OnButtonRule)
      ChangeActiveScrollView("Equip")
      m_currentSortMate = REF.SortMateEquip.SortMate
      this:SetData("SortFinished", this:GetData("SortFinished"))
    end
  end)
  CS.EventDelegate.Add(REF.MaterialBagTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    if CS.UIToggle.current.value then
      WU.RecordButtonClick(106003)
      m_tabID = 10653
      SU.ClearNewFlag(PB.enum.ResourceType.ResEquip, m_clearNewFlag)
      WU.SetRuleCallback("Bag", nil)
      ChangeActiveScrollView("Item")
      m_currentSortMate = REF.SortMateMaterial.SortMate
      this:SetData("SortFinished", this:GetData("SortFinished"))
      CancelDecompose()
    end
  end)
  CS.EventDelegate.Add(REF.ConsumableBagTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    if CS.UIToggle.current.value then
      WU.RecordButtonClick(106004)
      m_tabID = 10654
      SU.ClearNewFlag(PB.enum.ResourceType.ResEquip, m_clearNewFlag)
      WU.SetRuleCallback("Bag", nil)
      ChangeActiveScrollView("Item")
      m_currentSortMate = REF.SortMateConsumable.SortMate
      this:SetData("SortFinished", this:GetData("SortFinished"))
      CancelDecompose()
    end
  end)
  CS.EventDelegate.Add(REF.GachaChipsBagTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    if CS.UIToggle.current.value then
      WU.RecordButtonClick(106005)
      m_tabID = 10655
      SU.ClearNewFlag(PB.enum.ResourceType.ResEquip, m_clearNewFlag)
      WU.SetRuleCallback("Bag", nil)
      ChangeActiveScrollView("Item")
      m_currentSortMate = REF.SortMateGachaChips.SortMate
      this:SetData("SortFinished", this:GetData("SortFinished"))
      CancelDecompose()
    end
  end)
  CS.EventDelegate.Add(REF.ArmBagTab.UIToggle.onChange, function()
    m_currentSortMate = nil
    if CS.UIToggle.current.value then
      m_armClick = true
      WU.SetRuleCallback("Bag", nil)
      ChangeActiveScrollView("Arm")
      m_currentSortMate = REF.SortMateArm.SortMate
      this:SetData("SortFinished", this:GetData("SortFinished"))
      CancelDecompose()
    end
  end)
  WU.BindButtonEvent(REF.BtnClosePreview, function()
    WU.RecordButtonClick(106007)
    CancelDecompose()
  end)
  WU.BindButtonEvent(REF.BtnDecompose, OnDecomposeClick)
  WU.BindButtonEvent(REF.BtnDoDecompose, OnDoDecomposeClick)
  WU.BindButtonEvent(REF.BtnBatchSelect, function()
    WU.RecordButtonClick(106008)
    WU.AcquireWindowAsync("BatchSelectEquip")
  end)
  LU.Bind(REF.PreviewWrapContent, {
    updateRow = OnPreviewShow
  })
  LU.Bind(_ENV["$"](REF.Equip).WrapContent, {
    dataSource = function(dataIndex)
      return m_activeData and m_activeData[dataIndex]
    end,
    updateSlot = OnEquipBagShow,
    delta = 0.01
  })
  LU.Bind(_ENV["$"](REF.Item).WrapContent, {
    dataSource = function(dataIndex)
      return m_activeData and m_activeData[dataIndex]
    end,
    updateSlot = OnItemBagShow,
    delta = 0.01
  })
  LU.Bind(_ENV["$"](REF.Arm).WrapContent, {
    dataSource = function(dataIndex)
      return m_activeData and m_activeData[dataIndex]
    end,
    updateSlot = OnArmShow,
    delta = 0.01
  })
end

function InitWindow()
  SortFocusBase.InitWindowEquip()
  SortFocusBase.InitWindowItem()
  m_armClick = false
  REF.EquipBagTab.UIToggle.value = true
  m_decomposePreview = _ENV["!"]({})
  m_decomposeExpItemPreview = _ENV["!"]({})
  m_decomposeResItemPreview = _ENV["!"]({})
  this:SetData("Actor/SelectedUid", nil)
  this:SetData("SelectedQuality", nil)
  this:Bind("SortFinished", OnSortFinished)
  this:Bind("SelectedQuality", OnSelectedQualityChange)
  this:RegisterGameEvent("ClearNewFlags", function()
    SU.ClearNewFlag(PB.enum.ResourceType.ResEquip, m_clearNewFlag)
  end)
  REF.DecomposePreview.transform.localPosition = CS.UnityEngine.Vector3(0, -622, 0)
end

function UninitWindow()
  if m_armClick then
    EU.SetArmUnNew()
  end
  CancelDecompose()
end

function ChangeActiveScrollView(suffix)
  local drag = REF.DragBG
  for i = 0, #drag - 1 do
    local scrollView = drag[i]
    local matched = scrollView["$gameObject"].name == suffix
    WU.SetActive(scrollView["$"], matched)
    if matched then
      m_activeScrollView = scrollView
    end
  end
end

function OnSortFinished(data)
  if data ~= nil and data.sortMate == m_currentSortMate then
    if REF.EquipBagTab.UIToggle.value then
      m_equipList = data.list
      GetEquipData()
      SetWrapContent(data.list, "Equip")
    elseif REF.ArmBagTab.UIToggle.value then
      m_armList = data.list
      SetWrapContent(data.list, "Arm")
    else
      GetItemData(data.list)
      local targetList
      if REF.ConsumableBagTab.UIToggle.value then
        targetList = m_consumableItems
      elseif REF.MaterialBagTab.UIToggle.value then
        targetList = m_materialItems
      elseif REF.GachaChipsBagTab.UIToggle.value then
        targetList = m_gachaItems
      end
      if targetList ~= nil then
        SetWrapContent(targetList, "Item")
      end
    end
  end
end

function OnWidgetIconClick(iconDetail)
  local widget = _ENV["$"](iconDetail)
  if m_decomposing then
    local equipUid = widget["@equipUid"]
    if equipUid then
      local equip = this:GetData("fci/equip/" .. equipUid)
      if equip.actorUid == 0 and not equip.isLock and equip.matchIndex == 0 then
        local selected = not m_selectedEquipUids[equipUid]
        widget["$$SetSelected"](selected)
        local quality = 0
        if widget["@info"] then
          quality = widget["@info"].quality
        end
        CalcDecomposePreview(quality, widget["@equipUid"], selected)
      end
    end
  elseif widget["@equipUid"] ~= nil then
    WU.ShowEquipDetailByUid(widget["@equipUid"], {
      enhance = true,
      equipped = true,
      share = true
    })
  elseif widget["@itemId"] ~= nil then
    WU.ShowItemDetail(widget["@itemId"], false)
  end
end

function OnDecomposeClick()
  WU.RecordButtonClick(106006)
  m_decomposing = true
  REF.BtnDecompose.BoxCollider2D.enabled = false
  REF.DecomposePreview["$Show"]()
  LU.Set(REF.PreviewWrapContent, 0)
  local wrapContent = m_activeScrollView.WrapContent
  for i = 0, #wrapContent - 1 do
    for j = 0, #wrapContent[i]["$"] - 1 do
      local iconDetail = wrapContent[i]["$"][j]
    end
  end
end

function OnDoDecomposeClick()
  WU.RecordButtonClick(106015)
  local uids = {
    equipUids = {}
  }
  local hasHighQualityEquip = false
  for uid, quality in pairs(m_selectedEquipUids) do
    table.insert(uids.equipUids, uid)
    if quality > PB.enum.EquipQuality.Purple then
      hasHighQualityEquip = true
    end
  end
  if #uids.equipUids ~= 0 then
    local tip = WU.GetString("Window_ConfirmDecomposeTip")
    if hasHighQualityEquip then
      tip = tip .. "<br/>" .. WU.GetString("Window_HasHightQualityEquipTip")
    end
    WU.ShowMessageYesNo(tip, function(action)
      if action == "YES" then
        this:GameRequest("fci/equip/decompose/"):Post(uids, function(result)
          DBH.ResChange(result.resChange)
          CancelDecompose()
          WU.ShowRewards(result.resChange)
          local sortMate = REF["$UILuaWindow"].SortMate
          this:BroadcastGameEvent("ApplySortAlternative", sortMate.tabIndex, sortMate.reverse)
        end)
      end
    end)
  end
end

function SetWrapContent(data, suffix)
  local wrapContent = _ENV["$"](REF[suffix]).WrapContent
  local row = math.ceil(#data / #wrapContent[0]["$"])
  m_activeData = data
  LU.Set(wrapContent, row)
  m_activeScrollView.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * wrapContent.UIWrapContent.itemSize)
  m_activeScrollView.BottomBarSpace.gameObject:SetActive(0 < row)
  REF.NodeEmpty.gameObject:SetActive(#data == 0)
  if suffix == "Equip" then
    NewFlagCount(data)
  end
end

function NewFlagCount(list)
  if table.empty(list) then
    return
  end
  m_clearNewFlag = {}
  for i = 1, #list do
    if list[i].isNew then
      table.insert(m_clearNewFlag, list[i])
    end
  end
end

function OnEquipBagShow(widget, data)
  if data ~= nil then
    widget["$$BindEquip"](data)
    local equipInfo = PB.get("EquipInfo", data.id)
    widget["@info"] = equipInfo
    widget["@equipUid"] = data.uid
    widget["@itemId"] = nil
    widget["$$ShowCustom"]({showNew = true})
    if data.actorUid ~= 0 then
      widget["$$SetTips"]("equipEquipped")
    end
    widget["$$SetSelected"](m_selectedEquipUids[data.uid] ~= nil)
    widget["$$SetClickCallback"](OnWidgetIconClick)
  else
    widget["$$ClearSlot"]()
  end
end

function OnArmShow(widget, data)
  if data ~= nil then
    widget["$$BindArm"](data, "S")
    widget["$$ShowCustom"]({showEquip = true})
    widget["$$SetClickCallback"](function()
      WU.AcquireWindowAsync("ArmDetail", function(window)
        _ENV["$"](window)["$$SetContent"](data)
      end)
    end)
  else
    widget["$$ClearSlot"]()
  end
end

function OnItemBagShow(widget, data)
  if data ~= nil then
    widget["$$BindItem"](data, true)
    widget["@itemId"] = data.id
    widget["@equipUid"] = nil
    widget["$$SetTips"](nil)
    widget["$$SetSelected"](false)
    widget["$$SetClickCallback"](OnWidgetIconClick)
  else
    widget["$$ClearSlot"]()
  end
end

function OnPreviewShow(rowRef, wrapIndex, realIndex)
  if m_decomposePreview and realIndex ~= nil and realIndex < #m_decomposePreview then
    local res = m_decomposePreview[realIndex + 1]
    rowRef["$$SetData"](res.type, res.id, res.count)
  else
    rowRef["$$ClearSlot"]()
  end
end

function OnSelectedQualityChange(selectedQuality)
  if selectedQuality == nil then
    return
  end
  CancelDecompose(true)
  for _, quality in pairs(selectedQuality) do
    if m_allQualityEquips[quality] ~= nil then
      for __, uid in pairs(m_allQualityEquips[quality]) do
        local equip = this:GetData("fci/equip/" .. uid)
        if equip.actorUid == 0 and not equip.isLock and equip.matchIndex == 0 and equip.level == 1 then
          local curStatus = m_selectedEquipUids[uid]
          if curStatus == nil then
            CalcDecomposePreview(quality, uid, true)
          end
        end
      end
    end
  end
  SetWrapContent(m_equipList, "Equip")
end

function CancelDecompose(onlyCancelSelected)
  if not m_decomposing then
    return
  end
  LU.Set(REF.PreviewWrapContent, 0)
  if not onlyCancelSelected then
    m_decomposing = false
    REF.BtnDecompose.BoxCollider2D.enabled = true
    REF.DecomposePreview["$Hide"]()
  end
  local wrapContent = m_activeScrollView.WrapContent
  for i = 0, #wrapContent - 1 do
    for j = 0, #wrapContent[i]["$"] - 1 do
      local iconDetail = wrapContent[i]["$"][j]
      iconDetail["$$SetSelected"](false)
    end
  end
  m_selectedEquipUids = _ENV["!"]({})
  m_decomposePreview = _ENV["!"]({})
  m_decomposeExpItemPreview = _ENV["!"]({})
  m_decomposeResItemPreview = _ENV["!"]({})
end

function GetItemData(sourceData)
  m_consumableItems = {}
  m_materialItems = {}
  m_gachaItems = {}
  for _, value in pairs(sourceData) do
    local item = PB.get("ItemInfo", value.id)
    if item.type == PB.enum.ItemType.Material and value.count > 0 then
      table.insert(m_materialItems, value)
    elseif item.type == PB.enum.ItemType.Consumable and value.count > 0 then
      table.insert(m_consumableItems, value)
    elseif item.type == PB.enum.ItemType.ActorChip and value.count > 0 then
      table.insert(m_gachaItems, value)
    elseif item.type == PB.enum.ItemType.ActivityDrop and value.count > 0 then
      table.insert(m_materialItems, value)
    end
  end
end

function GetEquipData()
  m_allQualityEquips = {}
  local all = this:GetData("fci/equip/")
  if all == nil then
    return
  end
  for k, v in pairs(all) do
    if v.id > 0 then
      local equipInfo = PB.get("EquipInfo", v.id)
      if equipInfo then
        if m_allQualityEquips[equipInfo.quality] == nil then
          m_allQualityEquips[equipInfo.quality] = {}
        end
        table.insert(m_allQualityEquips[equipInfo.quality], v.uid)
      end
    else
      error("Bag", "invalid equip id: " .. tostring(v.id))
    end
  end
end

function CalcDecomposePreview(quality, equipUid, selected)
  if selected then
    m_selectedEquipUids[equipUid] = quality
  else
    m_selectedEquipUids[equipUid] = nil
  end
  local expItems = m_decomposeExpItemMap[equipUid]
  if not expItems then
    expItems = GetDecomposeExpItems(equipUid)
    if not table.empty(expItems) then
      m_decomposeExpItemMap[equipUid] = expItems
    end
  end
  for _, res in pairs(expItems) do
    local i, p = _ENV["!"](m_decomposeExpItemPreview):find(function(k, v)
      return v.type == res.type and v.id == res.id
    end)
    if p then
      if selected then
        p.count = p.count + res.count
      else
        p.count = p.count - res.count
        if p.count <= 0 then
          table.remove(m_decomposeExpItemPreview, i)
        end
      end
    else
      table.insert(m_decomposeExpItemPreview, {
        type = res.type,
        id = res.id,
        count = res.count,
        exp = res.exp
      })
    end
  end
  table.sort(m_decomposeExpItemPreview, function(a, b)
    return a.exp > b.exp
  end)
  m_decomposePreview = _ENV["!"]({})
  m_decomposePreview:append(m_decomposeExpItemPreview)
  local resItems = m_decomposeResItemMap[equipUid]
  if not resItems then
    resItems = GetDecomposeResItems(equipUid)
    if not table.empty(resItems) then
      m_decomposeResItemMap[equipUid] = resItems
    end
  end
  for _, res in pairs(resItems) do
    local i, r = _ENV["!"](m_decomposeResItemPreview):find(function(k, v)
      return v.type == res.type and v.id == res.id
    end)
    if r then
      if selected then
        r.count = r.count + res.count
      else
        r.count = r.count - res.count
        if r.count <= 0 then
          table.remove(m_decomposeResItemPreview, i)
        end
      end
    else
      table.insert(m_decomposeResItemPreview, {
        type = res.type,
        id = res.id,
        count = res.count
      })
    end
  end
  m_decomposePreview:append(m_decomposeResItemPreview)
  LU.Set(REF.PreviewWrapContent, #m_decomposePreview)
end

function GetDecomposeExpItems(equipUid)
  local expSum = EU.DecomposedExp(this:GetData("fci/equip/" .. equipUid))
  local result = {}
  if expSum ~= 0 then
    local expItems = AU.DecomposeToExpItems(expSum, PB.enum.ItemFuncType.EquipExp)
    for _, v in pairs(expItems) do
      local res = {
        type = PB.enum.ResourceType.ResItem,
        id = v.id,
        count = v.cnt,
        exp = v.exp
      }
      table.insert(result, res)
    end
  end
  return result
end

function GetDecomposeResItems(equipUid)
  local result = _ENV["!"]({})
  local resItem = EU.DecomposedRes(this:GetData("fci/equip/" .. equipUid))
  if resItem then
    table.insert(result, resItem)
  end
  return result
end

function OnButtonRule()
  WU.AcquireWindowAsync("RuleCommon", function(ui)
    _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_EquipDecompose"))
  end)
end

function Focus(on)
  SortFocusBase.FocusEquip(on)
  SortFocusBase.FocusItem(on)
  if not on then
    SU.ClearNewFlag(PB.enum.ResourceType.ResEquip, m_clearNewFlag)
  end
  WU.RecordWindowFocus(100106, on)
  if on then
    this:Bind("SortName", OnRecordSortOptionClick)
  else
    this:Unbind("SortName", OnRecordSortOptionClick)
  end
end

function OnRecordSortOptionClick(sortName)
  if sortName then
    this:SetData("SortName", nil)
    WU.RecordButtonClick(m_tabID .. sortName)
  end
end
