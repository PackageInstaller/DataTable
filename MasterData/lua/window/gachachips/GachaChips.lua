local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local DU = require("Common/DungeonUtil")
local AU = require("Common/ActorUtil")
local m_gachaId = 5
local m_gachaDetail, m_actorChips
local m_selections = _ENV["!"]({})
local m_maxCountOnce = 0
local m_totalCount = 0
local m_chipIdToActorIdMap

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGacha, function()
    WU.RecordButtonClick(100115011)
    if not DU.IsWaitingForJob(OnGachaClick) then
      OnGachaClick()
    end
  end)
  WU.BindButtonEvent(REF.ButtonActorDecompose, function()
    WU.RecordButtonClick(100115009)
    WU.OpenActorDecompose()
  end)
  m_maxCountOnce = PB.get("GachaType", m_gachaId).maxCountOnce
  m_chipIdToActorIdMap = {}
  local actorDecomposeConfigs = PB.all("ActorDecompose")
  for i = 1, #actorDecomposeConfigs do
    local config = actorDecomposeConfigs[i]
    local _, res = table.find(config.decomposeRes, function(k, v)
      return v.isChips
    end)
    m_chipIdToActorIdMap[res.id] = m_chipIdToActorIdMap[res.id] or {}
    table.insert(m_chipIdToActorIdMap[res.id], config.id)
  end
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), OnGachaInfoChanged)
  this:Bind("fci/item/", OnItemChange)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_actorChips and m_actorChips[dataIndex]
    end,
    updateSlot = UpdateActorChipSlot,
    delta = 0.03
  })
  this:DelayInvokeInFrames(1, ResetSelection)
end

function UninitWindow()
  this:Unbind("fci/gachainfo/", OnGachaInfoChanged)
  this:Unbind("fci/item/", OnItemChange)
end

function OnGachaInfoChanged(gachaInfoList)
  if gachaInfoList then
    for _, v in pairs(gachaInfoList) do
      if v.id == m_gachaId then
        m_gachaDetail = v
        REF.LabelRemainTimes.UILabel.text = tostring(PB.get("GachaType", m_gachaId).maxCountPerDay - m_gachaDetail.gachaCountToday)
      end
    end
  end
end

function Focus(on)
  WU.RecordWindowFocus(100115, on)
end

function OnItemChange(itemList)
  if itemList then
    m_actorChips = {}
    for _, item in pairs(itemList) do
      if item.count > 0 then
        local itemInfo = PB.get("ItemInfo", item.id)
        if itemInfo.type == PB.enum.ItemType.ActorChip then
          local actorIds = m_chipIdToActorIdMap[itemInfo.id]
          if actorIds == nil then
            error("Debug", "ActorDecompose\232\161\168\228\184\141\229\173\152\229\156\168\231\155\184\229\186\148\230\149\176\230\141\174\239\188\140itemId\239\188\154" .. itemInfo.id)
          end
          local open = false
          if actorIds then
            for _, actorId in ipairs(actorIds) do
              local actorConfig = PB.get("ActorConfig", actorId)
              open = AU.IsActorOpen(actorId, actorConfig.openTime)
              if open then
                break
              end
            end
          end
          if open then
            table.insert(m_actorChips, item)
          end
        end
      end
    end
    local sort = PB.get("Sort", 12)
    SU.SortOnce(m_actorChips, sort, true)
    LU.Set(REF.WrapContent, math.ceil(#m_actorChips / 3))
    REF.NodeEmpty.gameObject:SetActive(#m_actorChips == 0)
  end
end

function UpdateActorChipSlot(slotRef, data)
  if data == nil then
    slotRef["$$ClearSlot"]()
  elseif data.id == nil then
    slotRef["$$SetEmpty"](1)
    slotRef["$$SetClickCallback"](WU.OpenActorDecompose)
  else
    slotRef["$$BindItem"](data)
    slotRef["@id"] = data.id
    local selection = m_selections[data.id]
    if selection == nil then
      slotRef["$$SetCount"](0)
    else
      slotRef["$$SetCount"](selection.count)
    end
    slotRef["$$SetClickCallback"](OnActorChipClick)
    slotRef["$$SetRemoveCallback"](OnActorChipRemove)
  end
end

function OnActorChipClick(slot)
  WU.RecordButtonClick(100115020)
  local result = false
  local slotRef = _ENV["$"](slot)
  local actorChip = this:GetData("fci/item/" .. slotRef["@id"])
  if actorChip then
    local selection = m_selections[actorChip.id]
    if not selection then
      selection = {
        type = PB.enum.ResourceType.ResItem,
        id = actorChip.id,
        count = 0
      }
      m_selections[actorChip.id] = selection
    end
    if m_totalCount < m_maxCountOnce then
      if actorChip.count > selection.count then
        m_totalCount = m_totalCount + 1
        UpdateConsume()
        selection.count = selection.count + 1
        result = true
      else
        WU.ShowHintText(WU.GetString("WindowGacha_ChipsNotEnough"))
      end
    else
      WU.ShowHintText(WU.GetString("WindowGacha_ChipsMaxCountOnce"))
    end
    if selection ~= nil then
      if selection.count > 0 then
        slotRef["$$SetCount"](selection.count)
      else
        selection.count = 0
        slotRef["$$SetCount"](0)
      end
    else
      slotRef["$$SetCount"](0)
    end
  end
  return result
end

function OnActorChipRemove(slot)
  WU.RecordButtonClick(100115021)
  m_totalCount = m_totalCount - 1
  if m_totalCount < 0 then
    m_totalCount = 0
  end
  UpdateConsume()
  local slotRef = _ENV["$"](slot)
  local actorChip = this:GetData("fci/item/" .. slotRef["@id"])
  local selection = m_selections[slotRef["@id"]]
  selection.count = selection.count - 1
  if 0 >= selection.count then
    selection.count = 0
    slotRef["$$SetCount"](0)
  else
    slotRef["$$SetCount"](selection.count)
  end
  return 0 < selection.count
end

function UpdateConsume()
  local safeCount = PB.get("GachaType", m_gachaId).safeCount
  REF.ButtonGacha.UIButton.isEnabled = safeCount <= m_totalCount
  REF.LabelChipCount.UILabel.text = tostring(m_totalCount)
  REF.NodeMinCountTips.gameObject:SetActive(safeCount > m_totalCount)
  REF.NodePrediction.gameObject:SetActive(safeCount <= m_totalCount)
  if safeCount > m_totalCount then
    REF.LabelMinCountTips.UIHtmlLabel.text = WU.GetString("Window_GachaMinChipsCount", safeCount)
  else
    local actorCount = math.floor(m_totalCount / safeCount)
    local remainders = m_totalCount % safeCount
    local predictions = WU.GetString("Window_GachaPrediction", actorCount)
    if 0 < remainders then
      local chance = PB.get("GachaActorChipChance", m_gachaId, remainders).chance / 100
      predictions = predictions .. WU.GetString("Window_GachaPredictionExtra", chance)
    end
    REF.LabelPrediction.UIHtmlLabel.text = predictions
  end
end

function OnGachaClick()
  local cost = _ENV["!"]({})
  for _, selection in pairs(m_selections) do
    if selection.count > 0 then
      table.insert(cost, selection)
    end
  end
  if 0 < #cost then
    this:SetData("GachaShareInfo/ChipsCount", m_totalCount)
    S:Get("Gacha").DoGacha(m_gachaDetail, {
      cost = cost,
      callback = ResetSelection,
      showContinue = false
    })
  end
end

function OnGachaReset()
  ResetSelection()
end

function ResetSelection()
  m_totalCount = 0
  m_selections = _ENV["!"]({})
  UpdateConsume()
  if m_actorChips then
    LU.Set(REF.WrapContent, math.ceil(#m_actorChips / 3), false)
  end
end
