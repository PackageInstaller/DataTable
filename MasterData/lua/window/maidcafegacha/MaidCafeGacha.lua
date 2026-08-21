local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local m_activityManager = S:Get("ActivityManager")
local m_curNumber = -1
local m_curTimes = -1
local m_numberSpeed = 25
local m_gachaTimes = 0
local m_selectedGachaPhase = 1
local m_sortedGachaInfo
local m_unlockedGachaPhase = 0
local m_specialRewards, m_currentGachaInfo
local MAXGACHACOUNT = 100

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonTreasurePreview, OnClickPreview)
  WU.BindButtonEvent(REF.ButtonGacha, OnClickGacha)
  WU.BindButtonEvent(REF.ButtonAddOne, function()
    OnChangeGachaTimes(1)
  end)
  WU.BindButtonEvent(REF.ButtonAddTen, function()
    OnChangeGachaTimes(10)
  end)
  WU.BindButtonEvent(REF.ButtonMinusOne, function()
    OnChangeGachaTimes(-1)
  end)
  WU.BindButtonEvent(REF.ButtonMinusTen, function()
    OnChangeGachaTimes(-10)
  end)
  WU.TraverseChildren(REF.SpecialRewards, function(go, index)
    WU.SetActive(go, false)
  end)
  WU.TraverseChildren(REF.Grid, function(go, index)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.root, function()
      local targetGachaInfo = m_sortedGachaInfo[index + 1]
      local locked = true
      if targetGachaInfo then
        local ac = m_activityManager.GetActivitySync(targetGachaInfo.activityType, targetGachaInfo.activityId)
        locked = not ACU.IsOpenForDoing(ac)
      end
      if not locked then
        REF.Grid[index].root.UIToggle.value = true
        this:SetData("MaidCafe/SelectedGachaPhase", index + 1)
        m_selectedGachaPhase = index + 1
      else
        WU.ShowHintText(WU.GetString("MaidCafe_GachaLocked"))
        REF.Grid[m_selectedGachaPhase - 1].root.UIToggle.value = true
      end
    end)
    WU.SetActive(ref.TextureItem, false)
    WU.SetActive(ref.SpriteHead, false)
  end)
  WU.SetActive(REF.SpriteSoldOut, false)
  WU.SetActive(REF.SpecialRewards, false)
end

function InitWindow()
  m_gachaTimes = 0
  WU.SetActive(REF.SoldOut, false)
  WU.SetActive(REF.ButtonGacha, true)
  WU.SetActive(REF.Locked, false)
  this:BindRemote(DB:GameRequest("fci/maidcafe/gacha/"), OnGachaInfoChange)
  this:Bind("MaidCafe/SelectedGachaPhase", OnChangeGachaPhase)
  this:RegisterGameEvent("ActivityStatusChanged", function(category, id, status, type)
    if type == PB.enum.ActivityType.Common_Switch and status == PB.enum.ActivityStatus.Started then
      UpdateOpenTime()
    end
  end)
end

function UpdateWindow(delta)
  if m_curTimes == m_gachaTimes then
    return
  end
  if m_curNumber > m_gachaTimes then
    m_curNumber = m_gachaTimes
    m_curTimes = m_gachaTimes
    REF.LabelGachaTimes.UILabel.text = m_gachaTimes
  else
    m_curNumber = m_curNumber + delta * m_numberSpeed
    m_curTimes = math.floor(m_curNumber)
    REF.LabelGachaTimes.UILabel.text = m_curTimes
  end
end

function OnChangeGachaTimes(deltaTimes)
  if deltaTimes == 0 then
    m_gachaTimes = 0
  else
    local avaliableAmount = AvaliableGoodsAmount()
    if avaliableAmount < m_gachaTimes + deltaTimes then
      WU.ShowHintText(WU.GetString("MaidCafe_NotEnoughGoods", avaliableAmount))
      return
    else
      m_gachaTimes = m_gachaTimes + deltaTimes
    end
  end
  if m_gachaTimes < 0 then
    m_gachaTimes = 0
  elseif m_gachaTimes > MAXGACHACOUNT then
    WU.ShowHintText(WU.GetString("MaidCafe_GachaMaxOnce", MAXGACHACOUNT))
    m_gachaTimes = MAXGACHACOUNT
  end
  if deltaTimes ~= 0 then
    REF.CoinEffect.EffectGenerator:Play()
  end
  RefreshGachaCost()
end

function OnClickGacha()
  local cost = m_currentGachaInfo.gachaCost
  if cost == nil then
    return
  end
  if m_gachaTimes == 0 then
    OnChangeGachaTimes(1)
  end
  local stock = 0
  if cost.type == PB.enum.ResourceType.ResItem then
    stock = this:GetData("fci/item/" .. cost.id).count or 0
  else
    stock = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[cost.type] .. "_" .. cost.id) or 0
  end
  local costAll = m_gachaTimes * cost.count
  if stock < costAll then
    WU.ShowHintText(WU.GetString("MaidCafe_NotEnoughTickets"))
    return
  end
  local phaseTreasure = m_currentGachaInfo.gachaInfo
  local avaliableAmount = AvaliableGoodsAmount()
  if avaliableAmount < m_gachaTimes then
    WU.ShowHintText(WU.GetString("MaidCafe_NotEnoughGoods", avaliableAmount))
    return
  end
  this:GameRequest("fci/maidcafe/gacha/"):Post({gachaCount = m_gachaTimes, gachaPhase = m_selectedGachaPhase}, function(resp)
    local reschange = _ENV["!"]({})
    local allGachaPhaseInfo = this:GetData("fci/maidcafe/gacha/")
    local allGachaInfo = allGachaPhaseInfo.gachaPhaseInfo
    local unlockInfo = resp.gachaPhaseUnlock
    if unlockInfo ~= 0 then
      allGachaPhaseInfo.currentGachaPhase = unlockInfo
    end
    for _, info in pairs(resp.gachaGotInfo) do
      for _, change in pairs(info.gachaResChange) do
        table.insert(reschange, change)
        if change.baseRes and 0 < change.baseRes.countDelta or change.equip and 0 < change.equip.countDelta or change.weapon and 0 < change.weapon.countDelta then
          local gachaInfo = allGachaInfo[m_selectedGachaPhase].gachaInfo
          for _, v in pairs(gachaInfo) do
            if v.gachaId == info.gachaId then
              v.gachaCount = v.gachaCount + 1
            end
          end
        end
      end
    end
    this:SetData("fci/maidcafe/gacha/", allGachaPhaseInfo)
    DBH.ResChange(reschange)
    WU.ShowRewards(reschange)
    this:SetData("resChange", reschange)
    ResetGachaStatus()
  end)
end

function OnClickPreview()
  WU.AcquireWindowAsync("MaidCafeGachaPreview", function(win)
    _ENV["$"](win)["$$SetData"](m_currentGachaInfo.gachaInfo)
  end)
end

function OnGachaInfoChange(data)
  if data == nil then
    return
  end
  m_sortedGachaInfo = _ENV["!"]({})
  local gachaPhaseInfo = data.gachaPhaseInfo
  if gachaPhaseInfo == nil then
    return
  end
  for index = 1, #REF.Grid do
    WU.SetActive(REF.Grid[index - 1].root, index <= #gachaPhaseInfo)
    if index <= #gachaPhaseInfo then
      local info = gachaPhaseInfo[index]
      m_sortedGachaInfo[index] = info
    end
  end
  WU.SetActive(REF.Grid[2].root, false)
  WU.SetActive(REF.Grid[3].root, false)
  UpdateOpenTime()
  REF.Grid[m_selectedGachaPhase - 1].root.UIToggle.value = true
  REF.Grid.UIGrid:Reposition()
  WU.SetActive(REF.SpecialRewards, true)
  this:SetData("MaidCafe/SelectedGachaPhase", m_selectedGachaPhase)
end

function UpdateOpenTime()
  for index, gachaPhaseInfo in pairs(m_sortedGachaInfo) do
    local activityId = gachaPhaseInfo.activityId
    local activityType = gachaPhaseInfo.activityType
    local ac = m_activityManager.GetActivitySync(activityType, activityId)
    local isOpen = ACU.IsOpenForDoing(ac)
    local startTime = WU.RenderTime2(ac.timestampStart)
    WU.SetActive(REF.Grid[index - 1].SpriteHead, isOpen)
    WU.SetActive(REF.Grid[index - 1].SpriteLock, not isOpen)
    WU.SetActive(REF.Grid[index - 1].Arrow, isOpen)
    if isOpen then
      REF.Grid[index - 1].Label.UILabel.text = WU.GetString("MaidCafe_GachaOpen")
    else
      REF.Grid[index - 1].Label.UILabel.text = WU.GetString("MaidCafe_GachaOpenTime", startTime)
    end
  end
end

function OnChangeGachaPhase(index)
  if index == nil then
    return
  end
  m_currentGachaInfo = m_sortedGachaInfo[index]
  if m_currentGachaInfo == nil then
    return
  end
  local gachaCost = m_currentGachaInfo.gachaCost
  REF.LabelStock.ResourcePrinter:SetResource(gachaCost.type, gachaCost.id)
  m_specialRewards = _ENV["!"](m_currentGachaInfo.gachaInfo):where(function(k, info)
    return info.special
  end):toarray()
  table.sort(m_specialRewards, function(a, b)
    return a.gachaId < b.gachaId
  end)
  SetSpecialRewards()
  local _, avaliable = table.find(m_currentGachaInfo.gachaInfo, function(k, v)
    return v.gachaCountTotal > v.gachaCount
  end)
  local open = false
  local ac = m_activityManager.GetActivitySync(m_currentGachaInfo.activityType, m_currentGachaInfo.activityId)
  local locked = not ACU.IsOpenForDoing(ac)
  WU.SetActive(REF.SoldOut, not locked and not avaliable)
  WU.SetActive(REF.SpriteSoldOut, not locked and not avaliable)
  WU.SetActive(REF.ButtonGacha, not locked and avaliable)
  WU.SetActive(REF.Locked, locked)
  ResetGachaStatus()
end

function RefreshGachaCost()
  local stock = 0
  if m_currentGachaInfo == nil then
    return
  end
  local gachaCost = m_currentGachaInfo.gachaCost
  if gachaCost.type == PB.enum.ResourceType.ResItem then
    stock = this:GetData("fci/item/" .. gachaCost.id).count or 0
  else
    stock = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[gachaCost.type] .. "_" .. gachaCost.id) or 0
  end
  local estimateCost = m_gachaTimes * gachaCost.count
  REF.LabelTicketCost.ResourcePrinter:SetResource(gachaCost.type, gachaCost.id, estimateCost)
end

function SetSpecialRewards()
  for i = 1, #REF.SpecialRewards do
    WU.SetActive(REF.SpecialRewards[i - 1].root, m_specialRewards[i])
    if m_specialRewards[i] then
      local ref = REF.SpecialRewards[i - 1]
      local remainRewards = m_specialRewards[i].gachaCountTotal - m_specialRewards[i].gachaCount
      local _size = fif(m_specialRewards[i].reward.type == PB.enum.ResourceType.ResUniqueWeapon, "S", nil)
      local custom = {
        hideLevel = true,
        showEquip = false,
        phase = 1,
        showStar = false,
        isPreview = true
      }
      ref.common["$SetData"](m_specialRewards[i].reward.type, m_specialRewards[i].reward.id, m_specialRewards[i].reward.count, _size)
      if m_specialRewards[i].reward.type == PB.enum.ResourceType.ResUniqueWeapon then
        ref.common["$ShowCustom"](custom)
        ref.common["$SetClickCallback"](function()
          WU.ShowArmDetailById(m_specialRewards[i].reward.id, nil, custom)
        end)
      end
      ref.common["$SetBottomText"](WU.GetString("MaidCafe_GachaGot", m_specialRewards[i].gachaCount, m_specialRewards[i].gachaCountTotal))
      WU.SetActive(ref.GotAll, remainRewards == 0)
    end
  end
  REF.SpecialRewards.UIGrid:Reposition()
end

function AvaliableGoodsAmount()
  local phaseTreasure = m_currentGachaInfo.gachaInfo
  local avaliableAmount = 0
  for _, v in pairs(phaseTreasure) do
    local remainCount = v.gachaCountTotal - v.gachaCount
    if 0 < remainCount then
      avaliableAmount = avaliableAmount + remainCount
    end
  end
  return avaliableAmount
end

function ResetGachaStatus()
  m_gachaTimes = 0
  m_curNumber = m_gachaTimes
  m_curNumber = m_gachaTimes
  m_curTimes = m_gachaTimes
  REF.LabelGachaTimes.UILabel.text = m_gachaTimes
  RefreshGachaCost()
end
