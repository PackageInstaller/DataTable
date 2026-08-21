local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local m_gachaId = 6
local m_rate, m_rates

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClaw, function()
    if not DU.IsWaitingForJob(OnButtonClaw) then
      OnButtonClaw()
    end
  end)
  m_rates = PB.all("GachaFriendshipRate"):select(function(v)
    return v.rate
  end):toarray()
  m_rate = m_rates[1]
  WU.TraverseChildren(REF.ButtonsRate, function(g, i)
    _ENV["$"](g).LabelRate.UILabel.text = m_rates[i + 1]
    WU.BindButtonEvent(_ENV["$"](g).root, function()
      m_rate = m_rates[i + 1]
      RefreshGachaCost()
      REF.LabelRateDisplay.UILabel.text = m_rate
    end)
  end)
end

function OnButtonClaw()
  local gachaType = PB.get("GachaType", m_gachaId)
  WU.TryToPay(gachaType.cost.type, gachaType.cost.id, gachaType.cost.count * m_rate, function()
    local param = {
      id = m_gachaId,
      count = 1,
      rate = m_rate
    }
    RequestGacha(param)
  end)
end

function InitWindow()
  this:RegisterGameEvent("ResetGachaTimes", function()
    RefreshGachaCost()
  end)
  RefreshGachaCost()
  REF.WidgetBoardActor["$PlayByActorID"](1009)
  REF.LabelRateDisplay.UILabel.text = m_rate
end

function RefreshGachaCost()
  local gachaType = PB.get("GachaType", m_gachaId)
  local stockAmount = 0
  if gachaType.cost.type == PB.enum.ResourceType.ResItem then
    stockAmount = this:GetData("fci/item/" .. gachaType.cost.id).count
  else
    stockAmount = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[gachaType.cost.type] .. "_" .. gachaType.cost.id)
  end
  REF.LabelFriend.ResourcePrinter:SetAutoColor(false)
  REF.LabelFriend.ResourcePrinter:SetResource(gachaType.cost.type, gachaType.cost.id, stockAmount)
  REF.LabelCostFriend.ResourcePrinter:SetResource(gachaType.cost.type, gachaType.cost.id, gachaType.cost.count * m_rate)
end

function RequestGacha(param)
  this:SetData("fci/gachaResult/", nil)
  this:GameRequest("fci/gachatrade/"):Post(param, OnGachaResponse)
end

function OnGachaResponse(res)
  DBH.ResChange(res.info.resChange)
  this:SetData("fci/gachaResult/", res)
  local isClaw = res.isClawSuccess
  WU.AcquireWindowAsync("GachaClaw", function(window)
    _ENV["$"](window)["$$SetData"]({isClaw = isClaw})
  end)
end
