local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_data, m_channel
local m_misc = PB.index("Misc", 1)
local m_min = m_misc.minAnyPurchase
local m_max = m_misc.maxAnyPurchase
local m_iapHandler = S:Get("IAPHandler")
local m_configDataManager = S:Get("ConfigDataManager")

function SetupWindow()
  WU.BindButtonEvent(REF.BtnYes, OnConfirm)
  WU.BindButtonEvent(REF.BtnCancel, OnCancel)
  WU.BindButtonEvent(REF.ShowChannels, ShowChannels)
  CS.EventDelegate.Add(REF.InputCount.UIInput.onChange, OnCountChange)
end

function OnCancel()
  WU.RecycleWindow(this)
end

function InitWindow()
  local accountCache = this:GetData("accountCache")
  local isGuest = accountCache.entryType == "guest"
  if isGuest then
    WU.ShowMessageOK(WU.GetString("Purchase_Guest_Warning"))
  end
  if WU.IsPreCommit() then
    _ENV["$"](REF.MonthCard).Label.UILabel.text = WU.GetString("Purchase_BuyGrowthPack")
  else
    _ENV["$"](REF.MonthCard).Label.UILabel.text = WU.GetString("Purchase_BuyMonthCard")
  end
end

function OnCountChange()
  if m_data ~= nil then
    local any_count = tonumber(REF.InputCount.UIInput.value) or 0
    if any_count >= m_min and any_count <= m_max then
      REF.LabelPrice.UIHtmlLabel.text = WU.GetString("Purchase_AnyPreview", any_count / m_data.ratio)
    else
      REF.LabelPrice.UIHtmlLabel.text = WU.GetString("Purchase_AnyInvalid", m_min, m_max)
    end
  else
    REF.LabelPrice.UIHtmlLabel.text = ""
  end
end

function OnConfirm()
  local any_count = tonumber(REF.InputCount.UIInput.value) or 0
  if m_data.ratio == 0 or any_count >= m_min and any_count <= m_max then
    WU.RecycleWindow(this)
    m_iapHandler.Purchase(m_data, m_channel, fif(m_data.ratio == 0, m_data.count, any_count))
  else
    WU.ShowHintText(WU.GetString("Purchase_AnyInvalidHint"))
  end
end

function SetData(data)
  m_data = data
  if m_data ~= nil then
    local detailRef
    detailRef = _ENV["$"](REF.Simple)
    REF.Complex.gameObject:SetActive(false)
    if data.isMonthCard then
      REF.Simple.gameObject:SetActive(false)
      REF.MonthCard.gameObject:SetActive(true)
    else
      REF.Simple.gameObject:SetActive(true)
      REF.MonthCard.gameObject:SetActive(false)
    end
    if m_data.ratio == 0 then
      REF.LabelPrice.UIHtmlLabel.text = m_iapHandler.GetLocalizedPrice(m_data.productId)
      detailRef.ConstCount.UIHtmlLabel.text = m_data.count
      detailRef.ConstCount.gameObject:SetActive(true)
      if detailRef.InputCount ~= nil then
        detailRef.InputCount.gameObject:SetActive(false)
      end
    else
      detailRef.InputCount.UIInput.value = m_min
      OnCountChange()
      detailRef.ConstCount.gameObject:SetActive(false)
      if detailRef.InputCount ~= nil then
        detailRef.InputCount.gameObject:SetActive(true)
      end
    end
    local activityInfo = m_iapHandler.GetActivityByPrice(m_data.count)
    if activityInfo then
      REF.Count2.gameObject:SetActive(true)
      local sendNum = m_iapHandler.GetSendNum(activityInfo)
      if m_iapHandler.IsDoubleSendByFirst(activityInfo) == true then
        REF.LabelPresent.UIHtmlLabel.text = WU.GetString("Purchase_FristPresent")
        REF.ConstCount2.UIHtmlLabel.text = tostring(m_data.count)
      elseif 0 < sendNum then
        REF.LabelPresent.UIHtmlLabel.text = WU.GetString("Purchase_PresentEx")
        REF.ConstCount2.UIHtmlLabel.text = tostring(sendNum)
      else
        REF.Count2.gameObject:SetActive(false)
      end
      REF.GridCost.UIGrid:Reposition()
    else
      REF.Count2.gameObject:SetActive(false)
      REF.GridCost.UIGrid:Reposition()
    end
    if m_channel == nil or m_channel == 0 then
      SetChannel(m_data.channels[1])
    else
      SetChannel(m_channel)
    end
  end
end

function SetChannel(channel)
  m_channel = channel
  REF.LabelChannel.UIHtmlLabel.text = WU.GetString("Purchase_Channel_" .. tostring(m_channel))
  local preferences = m_configDataManager.GetPreferences()
  preferences.lastPerchaseChannel = m_channel
  m_configDataManager.SetPreferences(preferences)
end

function ShowChannels()
  WU.AcquireWindowAsync("PurchaseChannel", function(window)
    _ENV["$"](window)["$$SetChannels"](m_data.channels, SetChannel)
  end)
end
