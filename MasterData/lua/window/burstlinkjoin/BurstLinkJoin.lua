local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local m_burstLinkInfo, m_ticketInfo, m_activityInfo
local m_itemSlotList = {}
local m_moneyCost

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonJoin, OnButtonJoinClick)
  WU.BindButtonEvent(REF.ButtonPrizePreview, OnPrizePreview)
end

function InitWindow()
  WU.ToggleRendering(REF.NodeTicket, false)
  WU.ToggleRendering(REF.ButtonJoin, false)
  WU.ToggleRendering(REF.LabelStatusDesc, false)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
end

function UninitWindow()
end

function Goto(activityInfo)
  SetTournamentInfo(activityInfo)
end

function OnActivityStatusChanged(category, activityId, status)
  if category == PB.enum.ActivityCategory.Tournament and m_activityInfo.activityId == activityId then
    Refresh()
  end
end

function SetTournamentInfo(activityInfo)
  m_activityInfo = activityInfo
  this:BindRemote(DB:GameRequest("fci/BurstLinkPvpInfo/"):SyncInput(false), OnBurstLinkInfoGet)
end

function ReqMoneyCost()
  this:GameRequest("fci/resbuyprice/" .. PB.enum.RefreshPriceType.BurstLink):Get(function(response)
    if response then
      m_moneyCost = response
      if response.cost then
        SetCostInfo(response.cost)
      end
      Refresh()
    end
  end)
end

function OnBurstLinkInfoGet(burstLinkInfo)
  if burstLinkInfo then
    m_burstLinkInfo = burstLinkInfo
    Refresh()
    this:GameRequest("fci/resbuyprice/" .. m_activityInfo.type .. "/" .. m_activityInfo.activityId):Get(function(response)
      if response then
        m_ticketInfo = response
        local stock = DB:GetData("fci/item/" .. m_ticketInfo.cost.id).count
        local hasCost = m_ticketInfo.cost ~= nil and m_ticketInfo.cost.count > 0
        WU.ToggleRendering(REF.NodeTicket, hasCost)
        if hasCost then
          SetBurstLinkTicket(m_ticketInfo.cost, stock)
        end
        Refresh()
      end
    end)
  end
end

function IsEnoughTickets()
  if m_ticketInfo and m_ticketInfo.cost then
    local stock = DB:GetData("fci/item/" .. m_ticketInfo.cost.id).count
    return stock >= m_ticketInfo.cost.count
  end
  return false
end

function Refresh()
  if m_activityInfo and m_burstLinkInfo then
    local startTime = WU.RenderTime2(m_activityInfo.timestampStart, true)
    local finishTime = WU.RenderTime2(m_activityInfo.timestampEnd, true)
    REF.LabelDurationTime.UIHtmlLabel.text = WU.GetActivityWeekRender(m_activityInfo, true)
    SetPrizePreview(m_burstLinkInfo.reward)
    local status = ACU.GetStatus(m_activityInfo)
    if status == PB.enum.ActivityStatus.Started then
      ShowJoinButton()
    elseif status == PB.enum.ActivityStatus.PreHeat then
      HideJoinButton(WU.GetString("Tournament_StatusNotStarted"))
    elseif status == PB.enum.ActivityStatus.Finished then
      HideJoinButton(WU.GetString("Tournament_StatusFinished"))
    end
  end
end

function ShowJoinButton()
  if m_ticketInfo then
    WU.ToggleRendering(REF.ButtonJoin, true)
  end
  WU.ToggleRendering(REF.LabelStatusDesc, false)
end

function HideJoinButton(desc)
  WU.ToggleRendering(REF.ButtonJoin, false)
  WU.ToggleRendering(REF.LabelStatusDesc, true)
  REF.LabelStatusDesc.UIHtmlLabel.text = desc
end

function OnButtonJoinClick(go)
  WU.RecordButtonClick(100127003)
  if m_ticketInfo ~= nil and m_ticketInfo.cost ~= nil and m_ticketInfo.cost.count > 0 then
    WU.TryToPay(m_ticketInfo.cost.type, m_ticketInfo.cost.id, m_ticketInfo.cost.count, RequestJoin)
  else
    RequestJoin()
  end
end

function RequestJoin()
  local activityType = this:GetData("fci/tournament/curActivityType")
  this:GameRequest("fci/BurstLinkPvpInfo"):Post({}, function(result)
    if result then
      DBH.ResChange(result.resChange)
      DB:HandleRemoteChanged("fci/tournament/summary")
      if activityType == PB.enum.ActivityType.BurstLinkPvp then
        WU.AcquireWindowAsync("BurstLinkActorSelect", nil, true)
      else
        WU.AcquireWindowAsync("TournamentPrepare", nil, true)
      end
    else
      WU.ShowHintText(WU.GetString("Tournament_EnterFailed"))
      WU.RecycleWindow(this)
    end
  end)
end

function SetPrizePreview(prizes)
  local bestPrize
  local bestWinCount = 0
  if prizes and 0 < #prizes then
    table.sort(prizes, function(prize1, prize2)
      return prize1.id < prize2.id
    end)
    bestWinCount = prizes[#prizes].id
    bestPrize = prizes[#prizes].reward
  end
  if bestPrize then
    CreatePrizeItemSlot(#bestPrize)
    SetPrizeItemSlot(bestPrize)
  end
end

function CreatePrizeItemSlot(itemSlotCount)
  local needCreatePrizeItemSlotNum = itemSlotCount - #m_itemSlotList
  for i = 1, needCreatePrizeItemSlotNum do
    if i <= 1 then
      table.insert(m_itemSlotList, REF.PrizeWidgetIconSlot)
    else
      local newItemSlot = CS.UnityEngine.GameObject.Instantiate(REF.PrizeWidgetIconSlot.gameObject, REF.PrizeWidgetIconSlot.transform.parent)
      table.insert(m_itemSlotList, newItemSlot)
    end
  end
end

function SetPrizeItemSlot(prizes)
  for i = 1, #m_itemSlotList do
    local itemREF = _ENV["$"](m_itemSlotList[i])
    local widgetItemSlotREF = _ENV["$"](itemREF.WidgetIconSlot)
    widgetItemSlotREF["$$SetData"](prizes[i].type, prizes[i].id, prizes[i].count)
    m_itemSlotList[i].transform.localPosition = {
      x = -150 * (i - 1),
      y = 0,
      z = 0
    }
    if i <= #prizes then
      m_itemSlotList[i].gameObject:SetActive(true)
    else
      m_itemSlotList[i].gameObject:SetActive(false)
    end
  end
end

function OnPrizePreview(go)
  WU.RecordButtonClick(100127001)
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("BurstLink")
  end)
end

function SetBurstLinkTicket(cost, stock)
  WU.ToggleRendering(REF.NodeTicket, true)
  if 0 < stock then
    REF.LabelTicketOwn.ResourcePrinter:SetFormat("{icon}&nbsp;{stock}")
    REF.LabelTicketOwn.ResourcePrinter:SetResource(cost.type, cost.id)
  else
    REF.LabelTicketOwn.ResourcePrinter:SetFormat("{icon}&nbsp;<font color=#fd5454>{stock}</font>")
    REF.LabelTicketOwn.ResourcePrinter:SetResource(cost.type, cost.id)
  end
  WU.ClearButtonEvent(REF.NodeTicket)
  WU.BindButtonEvent(REF.NodeTicket, function()
    OnShowTicketMessage(cost)
  end)
  SetCostInfo(cost)
end

function SetCostInfo(cost)
  _ENV["$"](REF.ButtonJoin).LabelCost.ResourcePrinter:SetAutoColor(true)
  _ENV["$"](REF.ButtonJoin).LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
end

function OnShowTicketMessage(cost)
  if cost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(cost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. cost.type))
  end
end

function Focus(on)
  WU.RecordWindowFocus(100127, on)
end
