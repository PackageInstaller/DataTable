local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local m_closing = false
local m_callback, m_items, m_items2, m_info, m_chapterId, m_progressId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, OnClose)
  WU.BindButtonEvent(REF.ButtonNo, OnShowReward)
  WU.BindButtonEvent(REF.ButtonYes, OnYes)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateWidget
  })
  LU.Bind(REF.WrapContent2, {
    updateRow = UpdateWidget2
  })
end

function OnClose()
  if m_closing then
    return
  end
  ShowEffectBG("UI_panle_bg_EquipB")
  m_closing = true
  WU.SetActive(REF.NodeContent, false)
  WU.SetActive(REF.NodeContent2, false)
  WU.SetActive(REF.NodeTitle, false)
  WU.SetActive(REF.NodeButton, false)
  this:DelayInvokeInScaledSeconds(REF.EffectBG.EffectGenerator.Duration, function()
    WU.RecycleWindow(this)
    m_closing = false
    if m_callback then
      m_callback()
    end
  end)
end

function ShowHintIconImpl(titleText)
  WU.SetActive(REF.NodeContent, true)
  WU.SetActive(REF.NodeContent2, true)
  LU.Set(REF.WrapContent, #m_items)
  LU.Set(REF.WrapContent2, #m_items2)
  REF.WrapContent.UIPlayTween:Play(true)
  REF.WrapContent2.UIPlayTween:Play(true)
  WU.SetActive(REF.NodeTitle, titleText ~= nil)
  if titleText then
    REF.LabelTitle.UILabel.text = titleText
  end
  WU.SetActive(REF.NodeButton, true)
  ShowEffectBG("UI_panle_bg_middleA02")
end

function ShowHintIcon(items1, items2, callback, effectTitleName, titleText)
  m_items = items1
  m_items2 = items2
  m_callback = callback
  REF.ScrollViewContent.UIScrollView.contentPivot = fif(#items1 <= 7, CS.UIWidget.Pivot.Center, CS.UIWidget.Pivot.Left)
  REF.ScrollViewContent2.UIScrollView.contentPivot = fif(#items2 <= 7, CS.UIWidget.Pivot.Center, CS.UIWidget.Pivot.Left)
  WU.SetActive(REF.NodeTitle, false)
  WU.SetActive(REF.NodeButton, false)
  WU.SetActive(REF.NodeContent, false)
  WU.SetActive(REF.NodeContent2, false)
  REF.EffectTitle.EffectGenerator.m_EffectName = effectTitleName
  REF.EffectTitle.EffectGenerator:Reset()
  REF.EffectTitle.EffectGenerator:Play(function()
    ShowHintIconImpl(titleText, effectTitleName)
  end)
end

function ShowEffectBG(effectName)
  REF.EffectBG.EffectGenerator.m_EffectName = effectName
  REF.EffectBG.EffectGenerator:Reset()
  REF.EffectBG.EffectGenerator:Play()
end

function UpdateWidget(slotRef, wrapIndex, realIndex)
  if m_items and realIndex and realIndex < #m_items then
    local item = m_items[realIndex + 1]
    if item.type == PB.enum.ResourceType.ResActor then
      slotRef["$$SetActorCustom"]({
        id = item.id,
        quality = item.quality
      })
    else
      slotRef["$$SetData"](item.type, item.id, item.count)
    end
    slotRef["$$SetOwnerBox"](item.ownerBoxId)
    slotRef["$$SetClickCallback"](nil)
  end
end

function UpdateWidget2(slotRef, wrapIndex, realIndex)
  if m_items2 and realIndex and realIndex < #m_items2 then
    local item = m_items2[realIndex + 1]
    if item.type == PB.enum.ResourceType.ResActor then
      slotRef["$$SetActorCustom"]({
        id = item.id,
        quality = item.quality
      })
    else
      slotRef["$$SetData"](item.type, item.id, item.count)
    end
    slotRef["$$SetOwnerBox"](item.ownerBoxId)
    slotRef["$$SetClickCallback"](nil)
  end
end

function SetProgress(chapterId, progressId)
  local info = PB.get("WarmupChapterProgressConfig", chapterId, progressId)
  local cost = PB.all("WarmupMiscConfig")[1].secretPlanCost
  m_chapterId = chapterId
  m_progressId = progressId
  if info then
    local itemList1 = info.progressReward
    local itemList2 = info.progressRewardSecretPlan
    ShowHintIcon(itemList1, itemList2, nil, "result_title_27", WU.GetString("ArmWarmup_PlanTip"))
    if cost then
      REF.LabelShowCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  else
    error("WarmupChapterProgressConfig.xlsx has not " .. chapterId .. "-" .. progressId)
  end
end

function OnYes()
  local cost = PB.all("WarmupMiscConfig")[1].secretPlanCost
  if cost then
    WU.TryToRefresh(cost.type, cost.count, function()
      WU.TryToPayResource(cost, function()
        this:GameRequest("fci/warmup/active-secret-plan/"):Post({}, function(result)
          if result and result.resChange then
            DBH.ResChange(result.resChange)
            WU.ShowRewards(result.resChange, OnClose)
            local info = this:GetData("fci/warmup")
            info.secretPlan = true
            this:SetData("fci/warmup", info)
          end
        end)
      end)
    end, "ArmWarmup_ConfirmToBuySecretPlan")
  else
    error("WarmupMiscConfig has no secretPlanCost")
  end
end

function OnShowReward()
  WU.AcquireWindowAsync("ArmWarmupReward", function(window)
    WU.RecycleWindow(this)
    _ENV["$"](window)["$$SetChapterId"](m_chapterId)
  end)
end
