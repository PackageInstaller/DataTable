local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local EA = require("Common/EquipAttr")
local DBH = require("Manager/DataBindingHandler")
local m_targetEquip, m_candidateEquip

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonEquip, OnEquipClick)
  WU.BindButtonEvent(REF.ButtonUnequip, OnUnequipClick)
  REF.ToggleLevel.UIToggle.value = toboolean(this:GetData("ToggleEquipMaxLevelCompare"))
  CS.EventDelegate.Add(REF.ToggleLevel.UIToggle.onChange, OnToggleLevel)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    if m_targetEquip then
      this:SetData("ShareConfig", {
        shareName = "ActorEquipCompare",
        fromWindow = WU.TopWindow() and WU.TopWindow().name
      })
      this:SetData("Share/ActorEquipCompare", m_targetEquip)
      WU.AcquireWindowAsync("Share")
    end
  end)
end

function SetEquip(targetEquip, candidateEquip)
  m_targetEquip = targetEquip
  m_candidateEquip = candidateEquip
  REF.ButtonGrid.gameObject:SetActive(true)
  REF.ButtonUnequip.gameObject:SetActive(true)
  UpdateComparison()
end

function UpdateComparison()
  local actor = this:GetData("fci/actor/{Actor/SelectedUid}")
  local oldEquips = EU.GetEquips(actor)
  local newEquips = oldEquips
  if m_targetEquip then
    newEquips = oldEquips:where(function(k, v)
      return v.uid ~= m_targetEquip.uid
    end):values()
  end
  local newSuitAttr = false
  if m_candidateEquip then
    local preEquips = newEquips:duplicate()
    table.insert(newEquips, m_candidateEquip)
    local preSuitInfo = EA.GetSuitInfo(m_candidateEquip.id, preEquips)
    local newSuitInfo = EA.GetSuitInfo(m_candidateEquip.id, newEquips)
    if preSuitInfo and newSuitInfo then
      local _, preActiveAttr = preSuitInfo.attrList:find(function(k, v)
        return v.activated
      end)
      local _, newActiveAttr = newSuitInfo.attrList:find(function(k, v)
        return v.activated
      end)
      if not preActiveAttr and newActiveAttr or preActiveAttr and newActiveAttr and newActiveAttr.suitCount > preActiveAttr.suitCount then
        newSuitAttr = true
      end
    end
  end
  local oldEquipAttr = EA.GetEquipAttr(m_targetEquip, nil, oldEquips)
  local newEquipAttr = EA.GetEquipAttr(m_candidateEquip, nil, newEquips)
  if m_targetEquip and m_candidateEquip and this:GetData("ToggleEquipMaxLevelCompare") then
    local oldMaxLevel = EU.GetEquipMaxLevel(m_targetEquip)
    local newMaxLevel = EU.GetEquipMaxLevel(m_candidateEquip)
    local oldMapBaseAttrMap = EA.GetBaseAttrMapByEquipId(m_targetEquip.id, oldMaxLevel)
    local newMaxBaseAttrMap = EA.GetBaseAttrMapByEquipId(m_candidateEquip.id, newMaxLevel)
    for type, attr in pairs(oldMapBaseAttrMap) do
      oldEquipAttr.baseAttrMap[type].max = {
        value = attr.value,
        delta = 0
      }
    end
    for type, attr in pairs(newMaxBaseAttrMap) do
      newEquipAttr.baseAttrMap[type].max = {
        value = attr.value,
        delta = attr.value - oldMapBaseAttrMap[type].value
      }
    end
  end
  UpdateEquipInfo(_ENV["$"](REF.NodeTarget), m_targetEquip, oldEquipAttr)
  UpdateEquipInfo(_ENV["$"](REF.NodeCandidate), m_candidateEquip, newEquipAttr, newSuitAttr)
  REF.Grid.UIGrid:Reposition()
  WU.SetActive(REF.ToggleLevel, m_targetEquip and m_candidateEquip)
  REF.ButtonGrid.UIGrid:Reposition()
end

function UpdateEquipInfo(nodeRef, equip, equipAttr, newSuitAttr)
  nodeRef["$gameObject"]:SetActive(equip)
  local actor = this:GetData("fci/actor/{Actor/SelectedUid}")
  if equip and actor then
    local equipInfo = PB.get("EquipInfo", equip.id)
    nodeRef.WidgetIconEquip["$SetEquip"](equip)
    nodeRef.LabelName.UIHtmlLabel.text = WU.GetString("EquipName_" .. equip.id)
    nodeRef.LabelScore.UIHtmlLabel.text = WU.GetString("WindowActorEquipCompare_Score", math.floor(equip.score))
    local requireLevelText = ""
    if equipInfo then
      requireLevelText = WU.GetString("Window_Level", equipInfo.requireLevel)
      if equipInfo.requireLevel > actor.level then
        requireLevelText = HU.ApplyFontColor(requireLevelText, HU.ColorDefines.Error)
      end
    end
    nodeRef.LabelRequireLevel.UIHtmlLabel.text = WU.GetString("WindowActorEquipCompare_RequireLevel", requireLevelText)
    nodeRef.LabelDesc.UIHtmlLabel.text = WU.GetString("EquipDesc_" .. equip.id)
    nodeRef.WidgetEquipAttrCompactTable["$SetEquipAttr"](equipAttr, newSuitAttr)
    nodeRef.ScrollView.UIScrollView:ResetPosition()
  end
end

function OnEquipClick()
  WU.RecordButtonClick(8005)
  if m_candidateEquip then
    local actor = this:GetData("fci/actor/{Actor/SelectedUid}")
    if m_candidateEquip.actorUid ~= actor.uid then
      if m_candidateEquip.requireLevel <= actor.level then
        if m_candidateEquip.actorUid ~= 0 then
          local actorWithEquip = this:GetData("fci/actor/" .. m_candidateEquip.actorUid)
          local desc = HU.ActorReplaceDesc(actorWithEquip)
          WU.ShowMessageYesNo(WU.GetString("WindowActorEquipSubstitution_InUse", desc), function(result)
            if result == "YES" then
              RequestEquip(actor.uid, m_candidateEquip.uid)
            end
          end)
        else
          RequestEquip(actor.uid, m_candidateEquip.uid)
        end
      else
        WU.ShowHintText(WU.GetString("WindowActorEquipLevelLimit"))
      end
    end
  end
end

function RequestEquip(actorUid, targetUid)
  this:GameRequest("fci/equip/on/"):Post({actorUid = actorUid, equipUid = targetUid}, function(result)
    DBH.UpdateActors({
      [1] = result.newActor,
      [2] = result.oldActor
    })
    DBH.UpdateEquips({
      [1] = result.newEquip,
      [2] = result.oldEquip
    })
    WU.RecycleWindow(this)
  end)
end

function OnUnequipClick()
  WU.RecordButtonClick(8006)
  if m_targetEquip then
    local actorUid = this:GetData("Actor/SelectedUid")
    if m_targetEquip.actorUid == actorUid then
      local equipInfo = PB.get("EquipInfo", m_targetEquip.id)
      if equipInfo then
        RequestUnequip(actorUid, equipInfo.pos)
      end
    end
  end
end

function OnToggleLevel()
  this:SetData("ToggleEquipMaxLevelCompare", CS.UIToggle.current.value)
  UpdateComparison()
end

function RequestUnequip(actorUid, eqiupPos)
  this:GameRequest("fci/equip/off/"):Post({actorUid = actorUid, bodyPos = eqiupPos}, function(result)
    DBH.UpdateActors(result.newActor)
    DBH.UpdateEquips(result.newEquip)
    WU.RecycleWindow(this)
  end)
end

function Focus(on)
  WU.RecordWindowFocus(100105, on)
end
