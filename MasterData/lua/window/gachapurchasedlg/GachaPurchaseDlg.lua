local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local U = require("Common/Util")
local EA = require("Common/EquipAttr")
local IU = require("Common/ItemUtil")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local m_iapHandler = S:Get("IAPHandler")
local m_onSucceed, m_onFailed, m_willFreeTime, m_gachaId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnButtonConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  local toggle = REF.CheckBox.UIToggle
  CS.EventDelegate.Add(toggle.onChange, function()
    local playerID = DB:GetData("playerId")
    WU.SetGameDataCache("GachaPurchaseTips" .. playerID, CS.UIToggle.current.value)
  end)
  REF.Black["$SetCallback"](OnCancelClick)
  this:Unbind("fci/gachainfo/", OnGachaInfoChanged)
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), OnGachaInfoChanged)
  this:RepeatInvokeInSeconds(1.0, function()
    UpdateFreeTime()
  end)
end

function UpdateFreeTime()
  if m_willFreeTime == nil then
    return
  end
  if m_willFreeTime - CS.GameTime.serverUtc <= 0 then
    m_willFreeTime = nil
    OnCancelClick()
  end
end

function OnGachaInfoChanged(res)
  if res == nil then
    return
  end
  for i = 1, #res do
    local info = res[i]
    if info.id == m_gachaId then
      m_willFreeTime = info.nextFreeGachaTime
      break
    end
  end
end

function SetData(gachaId, costArray, onSucceed, onFailed)
  m_onSucceed = onSucceed
  m_onFailed = onFailed
  m_gachaId = gachaId
  local icon = ""
  for i, v in ipairs(costArray) do
    local temp
    if icon ~= "" then
      icon = icon .. "  "
    end
    if v.type == PB.enum.ResourceType.ResItem then
      temp = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[v.type] .. "_" .. v.id .. "'/>"
    else
      temp = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[v.type] .. "_" .. "0'/>"
    end
    icon = icon .. temp .. v.count
  end
  local labelTips
  if gachaId == 10 then
    labelTips = WU.GetString("Purchase_NeedCostArm")
  else
    labelTips = WU.GetString("Purchase_NeedCost")
  end
  labelTips = labelTips .. icon
  REF.LabelBuy.UIHtmlLabel.text = labelTips
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
