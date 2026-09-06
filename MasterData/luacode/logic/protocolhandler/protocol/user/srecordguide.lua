local function p1(protocol)
  NekoData.DataManager.DM_Game:OnRecordGuide(protocol)
  
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, nil, {
    guideFlag = protocol.guide
  })
end

local function p2(protocol, client)
end

return {p1, p2}
