local function func(conditionInfo)
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  
  return dialog and dialog._levelup_hasTriggerGuideTag1
end

return func
