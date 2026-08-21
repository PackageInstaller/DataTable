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
    return p.isMonth == false and p.giftPage == 4
  end):toarray()
  table.sort(m_data, function(a, b)
    return a.id < b.id
  end)
  this:RegisterGameEvent("UpdateSale", function(id, buyCount)
    local nBuyCount = tonumber(buyCount)
    local _, data = table.find(m_data, function(_, v)
      return v.id == id
    end)
    if data ~= nil then
      data.buyCount = nBuyCount
    end
    InitData()
  end)
end

function InitData()
  this:GameRequest("fci/mall-info/"):Get(function(response)
    DB:SetData("fci/mall-info/", response)
    WU.IsOpenNewbieGiftPrompt(0)
    WU.IsOpenNewbieGiftPrompt(1)
    REF.Drag.gameObject:SetActive(true)
    for k, v in pairs(response.mallRecord.summary) do
      local key = tonumber(k)
      local buyCount = tonumber(v.buyCount)
      local _, data = table.find(m_data, function(_, v)
        return v.id == key
      end)
      if data ~= nil then
        data.buyCount = buyCount
      end
    end
  end)
  local slotIndex = 0
  m_slotRef = {}
  local refTable = _ENV["$"](REF.Table)
  _ENV["$"](refTable.Head).PurchaseNewbieItem["$SetData"](m_data[1], 0)
  WU.TraverseChildren(refTable.Body, function(go, i)
    local ref = _ENV["$"](go)
    local trueIndex = i * 2 + 1
    ref.Up["$SetData"](m_data[trueIndex + 1], 1)
    ref.Down["$SetData"](m_data[trueIndex + 2], 1)
  end)
end

function OnEnable()
  InitData()
end
