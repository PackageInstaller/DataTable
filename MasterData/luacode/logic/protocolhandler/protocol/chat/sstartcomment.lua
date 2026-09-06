local function p1(protocol)
  LogInfoFormat("sstartcomment", "logType = %s", protocol.logType)
  
  NekoData.DataManager.DM_Chat:OnSStartComment(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
