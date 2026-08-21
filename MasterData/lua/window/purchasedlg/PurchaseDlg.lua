local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local U = require("Common/Util")
local EA = require("Common/EquipAttr")
local IU = require("Common/ItemUtil")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local m_iapHandler = S:Get("IAPHandler")
local m_onSucceed, m_onFailed

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  local toggle = REF.CheckBox.UIToggle
  CS.EventDelegate.Add(toggle.onChange, function()
    local playerID = DB:GetData("playerId")
    WU.SetGameDataCache("purchaseTips" .. playerID, CS.UIToggle.current.value)
  end)
  REF.Black["$SetCallback"](OnCancelClick)
end

function SetData(type, count, onSucceed, onFailed)
  m_onSucceed = onSucceed
  m_onFailed = onFailed
  REF.WidgetIconCost["$SetData"](count, type)
  REF.LabelBuy.gameObject:SetActive(true)
  REF.LabelBuy.UIHtmlLabel.text = WU.GetString("Purchase_Tips6")
end

function OnButtonConfirm()
  if m_onSucceed then
    m_onSucceed()
  end
  WU.RecycleWindow(this)
end

function OnCancelClick()
  if m_onFailed then
    m_onFailed()
  end
  WU.RecycleWindow(this)
end
