local function p1(protocol)
  local temp = ""
  
  for i, v in pairs(protocol.buffIds) do
    temp = temp .. i .. ":" .. v .. ";"
  end
  LogInfoFormat("sgetbuffinfo", "protocol.buffIds:%s", temp)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):OnSGetBuffInfo(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
