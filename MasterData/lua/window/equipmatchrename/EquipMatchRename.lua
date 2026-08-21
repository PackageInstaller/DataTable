local WU, DB, REF = require("Common/WindowUtil")(this)
local U = require("Common/Util")
local m_matchIndex = 0

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
end

function SetMatchIndex(matchIndex)
  m_matchIndex = matchIndex
  local match = this:GetData("Equip/Match/" .. m_matchIndex)
  if match then
    for i = 0, #REF.EquipGrid - 1 do
      local iconSlotRef = REF.EquipGrid[i]
      iconSlotRef["$$SetEquipPos"](i)
      iconSlotRef["$$BindEquip"](match.matchEquipUids[i])
    end
    REF.InputSingle.UIInput.defaultText = WU.GetString("Window_CharacterLimit", 7)
    REF.InputSingle.UIInput.value = match.matchName
  end
end

function OnConfirmClick()
  local match = this:GetData("Equip/Match/" .. m_matchIndex)
  local text = U.trim(REF.InputSingle.UIInput.value)
  if text ~= "" and match then
    if text ~= match.matchName then
      local param = {matchIndex = m_matchIndex, matchName = text}
      this:GameRequest("fci/equip/modify-match-name/"):Post(param, function(result)
        local match = this:GetData("Equip/Match/" .. m_matchIndex)
        match.matchName = result.matchName
        this:SetData("Equip/Match/" .. m_matchIndex, match)
        WU.RecycleWindow(this)
      end)
    else
      WU.RecycleWindow(this)
    end
  else
    WU.ShowHintText(WU.GetString("Window_EditBoxEmpty"))
  end
end

function OnCancelClick()
  WU.RecycleWindow(this)
end
