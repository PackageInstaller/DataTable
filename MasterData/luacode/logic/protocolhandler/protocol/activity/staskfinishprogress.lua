local function p1(protocol)
  local str
  
  for k, v in pairs(protocol.tasks) do
    if not str then
      str = "{"
    else
      str = str .. ", "
    end
    str = str .. "[" .. k .. "] = " .. "{status = " .. v.status .. ", num = " .. v.num .. "}"
  end
  str = str and str .. "}"
  LogInfoFormat("staskfinishprogress", "--- tasks = %s, firstDrama = %s ---", str, protocol.firstDrama)
  NekoData.DataManager.DM_Anniversary:OnSTaskFinishProgress(protocol)
  LuaNotificationCenter.PostNotification(Common.n_RefreshAnniversaryCumulativeTask, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
