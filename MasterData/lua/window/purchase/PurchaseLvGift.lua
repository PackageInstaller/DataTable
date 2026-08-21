local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_iaphandler = S:Get("IAPHandler")
local m_data, m_slotRef, m_mapMallRecord

function UpdateWidget(go, wrapIndex, realIndex)
  _ENV["$"](go)["$$SetData"](m_data[realIndex + 1], _ENV["$"](this))
end

function Awake()
  m_data = PB.all("Mall"):where(function(_, p)
    return p.isMonth == false and p.giftPage == 1 and p.noDisplay ~= true
  end):toarray()
  m_mapMallRecord = {}
  for i, v in ipairs(m_data) do
    m_mapMallRecord[v.id] = v
    v.buyCount = 0
  end
  this:RegisterGameEvent("UpdateSale", function(id, buyCount)
    local ref = m_slotRef[id]
    local nBuyCount = tonumber(buyCount)
    if ref then
      ref["$$SetBuyCount"](nBuyCount)
    end
    SetDataBuyCount(id, nBuyCount)
    InitData()
  end)
  this:RegisterGameEvent("PushTypePurchaseBuyRecord", function(params)
    local purchaseId = params[1]
    local mallInfo = GetMallInfoByProductID(purchaseId)
    if mallInfo then
      local ref = m_slotRef[mallInfo.id]
      local buyCount = tonumber(params[2])
      if ref then
        ref["$$SetBuyCount"](buyCount)
      end
      SetDataBuyCount(mallInfo.id, buyCount)
    end
  end)
end

function SetDataBuyCount(id, buyCount)
  local mallData = m_mapMallRecord[id]
  if mallData then
    mallData.buyCount = buyCount
  end
end

function UpdateBuyCount()
  this:GameRequest("fci/mall-info/"):Get(function(response)
    DB:SetData("fci/mall-info/", response)
    REF.Drag.gameObject:SetActive(true)
    for k, v in pairs(response.mallRecord.summary) do
      local key = tonumber(k)
      local buyCount = tonumber(v.buyCount)
      SetDataBuyCount(key, buyCount)
    end
    for k, v in pairs(response.purchaseRecord.buyRecord) do
      local mallInfo = GetMallInfoByProductID(k)
      if mallInfo then
        SetDataBuyCount(mallInfo.id, v.buyCount)
      end
    end
    InitData()
  end)
  REF.Drag.gameObject:SetActive(false)
end

function GetMallInfoByProductID(proID)
  if m_data == nil then
    return nil
  end
  for i, v in ipairs(m_data) do
    if v.productId == proID then
      return v
    end
  end
  return nil
end

function IsSaleFinish(data)
  if data.buyCount and data.buyCount >= data.maxBuyCount and data.maxBuyCount > 0 then
    return true
  end
  return false
end

function InitData()
  local slotIndex = 0
  m_slotRef = {}
  table.sort(m_data, function(a, b)
    if IsSaleFinish(a) == true and IsSaleFinish(b) == false then
      return false
    elseif IsSaleFinish(a) == false and IsSaleFinish(b) == true then
      return true
    else
      return a.id < b.id
    end
  end)
  local slotCount = #REF.ItemList
  for i, v in ipairs(m_data) do
    local _, temp = CloneSlot(REF.ItemList, i - 1, slotCount)
    slotCount = temp
  end
  for i, v in ipairs(m_data) do
    local slotRef = _ENV["$"](REF.ItemList.transform:GetChild(i - 1))
    if v.isNewGift == true then
      slotRef.root.transform:SetSiblingIndex(REF.PurchaseNewGiftItem.transform:GetSiblingIndex())
      REF.PurchaseNewGiftItem.transform:SetSiblingIndex(i - 1)
    end
  end
  for i, v in ipairs(m_data) do
    slotIndex, slotCount = SetAttrImpl(v, REF.ItemList, slotIndex, slotCount)
  end
  for i = slotIndex, slotCount - 1 do
    REF.ItemList[i]["$gameObject"]:SetActive(false)
  end
  REF.ScrollView.UIScrollView:ResetPosition()
  REF.ItemList.UIPlayTween:ResetDelay()
  REF.ItemList.UIPlayTween:Play(true)
  REF.ItemList.UITable:Reposition()
end

function Start()
end

function OnEnable()
  UpdateBuyCount()
end

function OnDisable()
end

function CloneSlot(listGasket, slotIndex, slotCount)
  local slotRef
  if slotIndex < slotCount then
    slotRef = listGasket[slotIndex]
  else
    local source = listGasket[1]["$gameObject"]
    local clone = CS.UnityEngine.GameObject.Instantiate(source, listGasket.transform)
    clone.name = source.name
    slotRef = _ENV["$"](clone)
    slotCount = slotCount + 1
  end
  return slotRef, slotCount
end

function SetAttrImpl(attr, listGasket, slotIndex, slotCount)
  local slotRef
  if slotIndex < slotCount then
    slotRef = _ENV["$"](listGasket.transform:GetChild(slotIndex))
  else
    local source = listGasket[1]["$gameObject"]
    local clone = CS.UnityEngine.GameObject.Instantiate(source, listGasket.transform)
    clone.name = source.name
    slotRef = _ENV["$"](clone)
    slotCount = slotCount + 1
  end
  slotRef["$gameObject"]:SetActive(true)
  slotRef["$$SetData"](attr)
  m_slotRef[attr.id] = slotRef
  slotIndex = slotIndex + 1
  return slotIndex, slotCount
end
