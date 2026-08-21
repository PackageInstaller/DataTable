local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_iaphandler = S:Get("IAPHandler")
local m_monthData

function UpdateWidget(refRow, wrapIndex, realIndex)
  refRow["$$SetData"](m_monthData, _ENV["$"](this))
end

function Awake()
  local data = PB.all("Mall")
  m_monthData = {}
  for i, v in ipairs(data) do
    if v.isMonth == true then
      m_monthData.data = v
      if v.productId and v.productId ~= "" then
        local product = m_iaphandler.GetProductsByID(v.productId)
        if product then
          m_monthData.rewardBuy = product.purchaseRes
          m_monthData.data.maxBuyCount = product.maxBuyCount
        else
          m_monthData.data = nil
        end
      else
        m_monthData.rewardBuy = v.reward
      end
      if m_monthData.data then
        break
      end
    end
  end
  local misc = PB.all("Misc"):first()
  m_monthData.rewardDaily = misc.monthCardRewardDaily
  LU.Bind(REF.ItemList, {
    updateRow = UpdateWidget
  })
  this:RegisterGameEvent("UpdateSale", function(id, buyCount)
    if m_monthData.data and m_monthData.data.id == id then
      m_monthData.buyCount = buyCount
    end
  end)
  this:RegisterGameEvent("PushTypePurchaseBuyRecord", function(params)
    local purchaseId = params[1]
    if m_monthData.data and purchaseId == m_monthData.data.productId then
      m_monthData.buyCount = tonumber(params[2])
    end
  end)
end

function UpdateBuyCount()
  this:GameRequest("fci/mall-info/"):Get(function(response)
    for k, v in pairs(response.mallRecord.summary) do
      local key = tonumber(k)
      if m_monthData.data and m_monthData.data.id == key then
        m_monthData.buyCount = v.buyCount
      end
    end
    for k, v in pairs(response.purchaseRecord.buyRecord) do
      if m_monthData.data and k == m_monthData.data.productId then
        m_monthData.buyCount = v.buyCount
      end
    end
  end)
end

function Start()
end

function OnEnable()
  UpdateBuyCount()
  local count = 0
  if m_monthData.data ~= nil then
    count = 1
  end
  LU.Set(REF.ItemList, count, false)
  REF.ScrollView.UIScrollView:ResetPosition()
end

function OnDisable()
end
