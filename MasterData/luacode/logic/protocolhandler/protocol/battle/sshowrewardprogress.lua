local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("mainline.offlinepvp.offlinepvprewarddialog")
  
  if dialog then
    dialog:Init(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
