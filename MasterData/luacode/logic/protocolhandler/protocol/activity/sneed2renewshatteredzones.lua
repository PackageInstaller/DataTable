local function p1(protocol)
  if DialogManager.GetDialog("mainline.fragment.fragmentmaindialog") then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetshatteredzonesinfo")
    
    csend:Send()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
