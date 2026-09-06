local function p1(protocol)
  local ids = protocol.process
  
  local dialog = DialogManager.GetDialog("mainline.offlinepvp.offlinepvprewarddialog")
  if dialog then
    dialog:Refresh(ids)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
