local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_matchIndex, m_unlocked

function Start()
  WU.BindButtonEvent(REF.ButtonRename, OnRenameClick)
  WU.BindButtonEvent(REF.ButtonLoad, OnLoadClick)
  WU.BindButtonEvent(REF.ButtonSave, OnSaveClick)
  WU.BindButtonEvent(REF.ButtonOverride, OnOverrideClick)
  for i = 0, #REF.EquipGrid - 1 do
    REF.EquipGrid[i]["$$SetEquipPos"](i)
  end
end

function BindMatchIndex(matchIndex)
  if m_matchIndex then
    this:Unbind("Equip/Match/" .. m_matchIndex, OnMatchChanged)
  end
  m_matchIndex = matchIndex
  if m_matchIndex then
    this:Bind("Equip/Match/" .. m_matchIndex, OnMatchChanged)
  end
  local costumeInfo = PB.get("CostumeInfo", m_matchIndex)
  m_unlocked = costumeInfo.unlockLevel <= this:GetData("fci/baseinfo").level
  WU.SetActive(REF.NodeUnlocked, m_unlocked)
  WU.SetActive(REF.NodeLocked, not m_unlocked)
  REF.LabelUnlockTips.UILabel.text = WU.GetString("WindowActorEquip_UnlockMatchTips", costumeInfo.unlockLevel)
end

function OnMatchChanged(match)
  local matchName = WU.GetString("WindowActorEquip_MatchDefaultName") .. m_matchIndex
  if match and match.matchName ~= "" then
    matchName = match.matchName
  end
  REF.LabelName.UILabel.text = matchName
  for i = 0, #REF.EquipGrid - 1 do
    local iconSlotRef = REF.EquipGrid[i]
    local equipUid = 0
    if match then
      equipUid = match.matchEquipUids[i]
    end
    iconSlotRef["$$BindEquip"](equipUid)
  end
  local state = this:GetData("EquipMatch/State")
  WU.SetActive(REF.NodeSave, state == "save")
  WU.SetActive(REF.NodeLoad, state == "load")
  local isEmpty = IsEmpty(match)
  if state == "save" then
    WU.SetActive(REF.ButtonSave, isEmpty)
    WU.SetActive(REF.ButtonOverride, not isEmpty)
  elseif state == "load" then
    REF.ButtonLoad.UIButton.isEnabled = not isEmpty
  end
end

function IsEmpty(match)
  if match then
    for _, uid in pairs(match.matchEquipUids) do
      if uid ~= 0 then
        return false
      end
    end
  end
  return true
end

function OnRenameClick()
  if m_unlocked then
    local match = this:GetData("Equip/Match/" .. m_matchIndex)
    if match then
      WU.AcquireWindowAsync("EquipMatchRename", function(window)
        _ENV["$"](window)["$$SetMatchIndex"](m_matchIndex)
      end)
    else
      WU.ShowHintText(WU.GetString("WindowActorEquip_SaveMatchFirst"))
    end
  else
    WU.ShowHintText(WU.GetString("WindowActorEquip_UnlockMatchTips", PB.get("CostumeInfo", m_matchIndex).unlockLevel))
  end
end

function OnLoadClick()
  this:BroadcastGameEvent("EventLoadEquipMatch", m_matchIndex)
end

function OnSaveClick()
  this:BroadcastGameEvent("EventSaveEquipMatch", m_matchIndex)
end

function OnOverrideClick()
  WU.AcquireWindowAsync("EquipMatchOverride", function(window)
    _ENV["$"](window)["$$SetTargetMatchIndex"](m_matchIndex)
  end)
end
