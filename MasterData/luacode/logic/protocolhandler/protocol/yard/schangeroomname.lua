local function p1(protocol)
  NekoData.DataManager.DM_Cabin:OnSChangeRoomName(protocol)
  
  DialogManager.DestroySingletonDialog("courtcabin.changecabinnamedialog")
  NekoData.BehaviorManager.BM_Message:SendMessageById(100160)
  local dialog = DialogManager.GetDialog("courtcabin.cabinmaindialog")
  if dialog then
    dialog:OnRefreshName()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
