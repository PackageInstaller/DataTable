local function p1(protocol)
  NekoData.DataManager.DM_Task:OnSMainLineReward(protocol)
  
  local str = ""
  for i, v in ipairs(protocol.mainLineRewardStates) do
    if str ~= "" then
      str = str .. ", {id=" .. v.mainLineId .. ", status=" .. v.mainLineState .. "}"
    else
      str = str .. "{id=" .. v.mainLineId .. ", status=" .. v.mainLineState .. "}"
    end
  end
  LogInfoFormat("smainlinereward", "%s", str)
end

local function p2(protocol, client)
end

return {p1, p2}
