local function func(conditionInfo)
  local params = conditionInfo.parm
  
  local dialog = DialogManager.GetTopmostDialog()
  if dialog then
    for i, v in ipairs(params) do
      local dialogName = DataCommon.Dialog[tonumber(params[i])]
      if dialogName and dialogName == dialog._dialogName then
        if dialogName == "character.newcharacterinfodialog" then
          local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
          if dialog and dialog._tag == 1 then
            return true
          end
        else
          return true
        end
      end
    end
  end
end

return func
