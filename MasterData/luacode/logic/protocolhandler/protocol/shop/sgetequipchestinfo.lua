local function p1(protocol)
  DialogManager.CreateSingletonDialog("shop.equipboxbuydialog"):InitData(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
