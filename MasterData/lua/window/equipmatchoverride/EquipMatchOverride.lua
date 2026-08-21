local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_matchIndex

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
end

function InitWindow()
  local currentActor = this:GetData("ActorInfo/CurrentActor")
  if currentActor then
    UpdateEquipGrid(_ENV["$"](REF.NodeNew).EquipGrid, currentActor.bodyEquips)
  end
end

function SetTargetMatchIndex(matchIndex)
  m_matchIndex = matchIndex
  local match = this:GetData("Equip/Match/" .. m_matchIndex)
  local tips = ""
  if match then
    UpdateEquipGrid(_ENV["$"](REF.NodeOld).EquipGrid, match.matchEquipUids)
    local matchName = WU.GetString("WindowActorEquip_MatchDefaultName") .. m_matchIndex
    if match.matchName ~= "" then
      matchName = match.matchName
    end
    tips = WU.GetString("WindowActorEquip_OverrideTips", matchName)
  end
  REF.LabelTips.UIHtmlLabel.text = tips
end

function UpdateEquipGrid(equipGrid, equipUids)
  for i = 0, #equipGrid - 1 do
    local iconSlotRef = equipGrid[i]
    iconSlotRef["$$SetEquipPos"](i)
    iconSlotRef["$$BindEquip"](equipUids[i] or equipUids[tostring(i)] or 0)
  end
end

function OnCancelClick()
  WU.RecycleWindow(this)
end

function OnConfirmClick()
  this:BroadcastGameEvent("EventSaveEquipMatch", m_matchIndex)
  WU.RecycleWindow(this)
end
