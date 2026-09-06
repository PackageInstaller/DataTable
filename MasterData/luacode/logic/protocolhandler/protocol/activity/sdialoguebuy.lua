local function p1(protocol)
  local dialog = DialogManager.GetDialog("activity.lover.loverstoredialog")
  
  if dialog then
    dialog:PlayVoiceText(2)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
