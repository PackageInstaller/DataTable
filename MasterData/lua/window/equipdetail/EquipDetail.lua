local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local EA = require("Common/EquipAttr")
local GotoUtil = require("Common/GotoUtil")
local DBH = require("Manager/DataBindingHandler")
local m_equip, m_equipAttr
local m_displaySource = false
local m_sourcesData, m_callback
local m_repeatedContext = {}
local m_contextData

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonLock, OnClickLock)
  WU.BindButtonEvent(REF.ButtonEquipped, function()
    this:SetData("Actor/SelectedUid", m_equip.actorUid)
    WU.AcquireWindowAsync("ActorInfo", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabEquip")
      local equipInfo = PB.get("EquipInfo", m_equip.id)
      if equipInfo then
        this:BroadcastGameEvent("EventSelectEquipPos", equipInfo.pos)
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonEnhance, function()
    if EU.ValidateEquipLevelup(m_equip) then
      this:SetData("ActorEquipLevelup/EquipSpecified", true)
      this:SetData("Equip/SelectedUid", m_equip.uid)
      WU.AcquireWindowAsync("ActorEquipLevelup")
    end
  end)
  WU.BindButtonEvent(REF.ButtonGet, function()
    ShowSourceContent(not m_displaySource)
  end)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "EquipDetail",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    this:SetData("Share/EquipDetail", m_equip)
    WU.AcquireWindowAsync("Share")
  end)
end

function InitWindow()
  WU.ToggleRendering(REF.Content, false)
  _ENV["$"](REF.ButtonGet).Label.UIHtmlLabel.text = WU.GetString("WindowItem_Get")
  WU.ToggleRendering(REF.WidgetDetailSource, false)
  REF.NodeDetail.gameObject:SetActive(true)
  REF.ButtonShare.gameObject:SetActive(false)
  m_displaySource = false
  this:Bind("EquipDetail/DisplaySource", function(flag)
    if flag == nil then
      return
    end
    REF.ButtonGet.gameObject:SetActive(flag)
  end)
end

function UninitWindow()
  if m_callback then
    m_callback()
  end
end

function OnClickLock()
  if m_equip.matchIndex ~= 0 then
    WU.ShowMessageYesNo(WU.GetString("WindowActorEquip_RemoveFromMatch"), function(result)
      if result == "YES" then
        SetLock()
      end
    end)
  else
    SetLock()
  end
end

function SetLock()
  this:GameRequest("fci/equip/" .. m_equip.uid .. "/setlock/"):Post({
    isLock = not m_equip.isLock and m_equip.matchIndex == 0
  }, function(result)
    DBH.UpdateEquips(result.equip)
    for index, match in pairs(result.equipCustomMatch) do
      this:SetData("Equip/Match/" .. index, match)
    end
  end)
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_contextData)
  m_contextData = {}
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local d = m_repeatedContext[#m_repeatedContext]
    if d.uid then
      SetEquipUid(d.uid, {
        enhance = d.showEnhanceButton,
        equipped = d.showEquippedButton,
        share = d.showShareButton
      }, true)
      ShowSourceContent(d.showSource)
    elseif d.id then
      SetEquipId(d.id, d.level, true)
      ShowSourceContent(d.showSource)
    elseif d.equipRaw then
      SetEquipSystemRaw(d.equipRaw, true)
      ShowSourceContent(d.showSource)
    end
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
  REF["$UILuaWindow"]:PlayAnimation("Open")
  WU.ToggleRendering(REF.root, false)
end

function SetEquipUid(uid, showButtons, fromCache, callback)
  m_callback = callback
  if uid == nil then
    return
  end
  if fromCache ~= true then
    ShowSourceContent(false)
  end
  m_contextData = {
    uid = uid,
    showEnhanceButton = showButtons and showButtons.enhance ~= false,
    showEquippedButton = showButtons and showButtons.equipped ~= false,
    showShareButton = showButtons and showButtons.share ~= false,
    showSource = false
  }
  this:Bind("fci/equip/" .. uid, OnEquipChange)
  if WU.IsShareSwitchOn() and m_contextData.showShareButton then
    REF.ButtonShare.gameObject:SetActive(true)
  else
    REF.ButtonShare.gameObject:SetActive(false)
  end
end

function SetEquipSystemRaw(equipRaw)
  REF.ButtonEnhance.gameObject:SetActive(false)
  REF.ButtonEquipped.gameObject:SetActive(false)
  REF.ButtonShare.gameObject:SetActive(false)
  if fromCache ~= true then
    ShowSourceContent(false)
  end
  m_contextData = {equipRaw = equipRaw, showSource = false}
  REF.EquipState.gameObject:SetActive(false)
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResEquip, equipRaw.id)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  REF.LabelDetail.UIHtmlLabel.text = EA.GetEquipDetails(equipRaw.id)
  m_equipAttr = EA.GetEquipAttr(equipRaw)
  REF.WidgetEquipAttrTable["$SetEquipAttr"](m_equipAttr)
  REF.DetailScrollView.UIScrollView:ResetPosition()
  SetEquipSourceData(equipRaw.id)
  REF.DragDetail.UIWidget.height = 700
  REF.DetailScrollView.UIScrollView:ResetPosition()
  REF.ButtonShare.gameObject:SetActive(false)
  WU.ToggleRendering(REF.Content, true)
end

function SetEquipId(id, level, fromCache)
  if id == nil then
    return
  end
  if fromCache ~= true then
    ShowSourceContent(false)
  end
  m_contextData = {id = id, showSource = true}
  REF.EquipState.gameObject:SetActive(false)
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResEquip, id)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  local fakeEquip = {
    id = id,
    randAttrIndex = 0,
    randAttrValueIndex = 0,
    level = level
  }
  REF.LabelDetail.UIHtmlLabel.text = EA.GetEquipDetails(id, level)
  m_equipAttr = EA.GetEquipAttr(fakeEquip)
  REF.WidgetEquipAttrTable["$SetEquipAttr"](m_equipAttr)
  REF.DetailScrollView.UIScrollView:ResetPosition()
  REF.ButtonEnhance.gameObject:SetActive(false)
  REF.DragDetail.UIWidget.height = 700
  REF.DetailScrollView.UIScrollView:ResetPosition()
  SetEquipSourceData(id)
  REF.ButtonShare.gameObject:SetActive(false)
  WU.ToggleRendering(REF.Content, true)
end

function OnEquipChange(equip)
  m_equip = equip
  if m_equip then
    if m_equip.actorUid and m_equip.actorUid > 0 then
      this:Bind("fci/actor/" .. m_equip.actorUid, OnEquipActorChange)
    else
      UpdateEquipDetail(nil)
    end
  end
end

function OnEquipActorChange(actor)
  if actor then
    UpdateEquipDetail(actor)
  end
end

function UpdateEquipDetail(actor)
  if m_equip then
    local reachMaxLevel = EU.IsEquipReachMaxLevel(m_equip)
    REF.EquipState.gameObject:SetActive(true)
    REF.WidgetIconSlot["$BindEquip"](m_equip)
    REF.LabelDetail.UIHtmlLabel.text = EA.GetEquipDetails(m_equip)
    local equips
    if actor then
      equips = EU.GetEquips(actor)
    end
    m_equipAttr = EA.GetEquipAttr(m_equip, nil, equips)
    REF.WidgetEquipAttrTable["$SetEquipAttr"](m_equipAttr)
    REF.DetailScrollView.UIScrollView:ResetPosition()
    REF.ButtonEnhance.gameObject:SetActive(m_contextData.showEnhanceButton and not reachMaxLevel)
    REF.DragDetail.UIWidget.height = fif(REF.ButtonEnhance.gameObject.activeSelf, 600, 700)
    REF.DetailScrollView.UIScrollView:ResetPosition()
    UpdateLockButton(m_equip.isLock or m_equip.matchIndex ~= 0)
    REF.ButtonEquipped.gameObject:SetActive(m_contextData.showEquippedButton and m_equip.actorUid ~= 0)
    if m_equip.actorUid ~= 0 and actor ~= nil and actor.id ~= 0 then
      local resActorConfig = PB.get("ActorConfig", actor.id)
      if resActorConfig ~= nil then
        local ref = _ENV["$"](REF.ButtonEquipped)
        ref.SpriteActorIcon.UISprite.spriteName = "actor_head_" .. resActorConfig.animRes
      end
    end
    SetEquipSourceData(m_equip.id)
    WU.ToggleRendering(REF.Content, true)
  end
end

function SetEquipSourceData(id)
  m_sourcesData = {}
  local equip = PB.get("EquipInfo", id)
  if equip then
    local sources = equip.sources
    for i = 1, #sources do
      table.insert(m_sourcesData, PB.get("Goto", sources[i]))
    end
    REF.WidgetDetailSource["$SetData"](m_sourcesData, "equip")
  end
end

function UpdateLockButton(isLock)
  if isLock then
    REF.ButtonLock.UIButton.normalSprite = "button_lock"
  else
    REF.ButtonLock.UIButton.normalSprite = "button_unlock"
  end
end

function OnItemSourceClick(go)
  local windowName = _ENV["$"](go)["@windowName"]
  local params = _ENV["$"](go)["@params"]
  if windowName ~= "None" then
    GotoUtil.Goto(windowName, params)
  end
end

function ShowSourceContent(isShow)
  m_displaySource = isShow
  if m_contextData then
    m_contextData.showSource = m_displaySource
  end
  WU.ToggleRendering(REF.WidgetDetailSource, m_displaySource)
  REF.NodeDetail.gameObject:SetActive(not m_displaySource)
  if m_displaySource then
    _ENV["$"](REF.ButtonGet).Label.UIHtmlLabel.text = WU.GetString("Window_Back")
    REF.WidgetDetailSource["$SetData"](m_sourcesData, "equip")
  else
    _ENV["$"](REF.ButtonGet).Label.UIHtmlLabel.text = WU.GetString("WindowItem_Get")
  end
end
