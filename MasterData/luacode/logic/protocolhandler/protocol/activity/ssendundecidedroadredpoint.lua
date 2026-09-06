local function p1(protocol)
  if not DialogManager.GetDialog("mainline.undecidedroad.undecidedroadmaindialog") then
    NekoData.DataManager.DM_Game:OnSUndecidedRoadRedPoint()
    
    LuaNotificationCenter.PostNotification(Common.n_RefreshUndecidedRoadRedDot, nil, nil)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
