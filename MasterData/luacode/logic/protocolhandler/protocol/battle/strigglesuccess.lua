local function p1(protocol)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  
  if controller then
    local recorder = BeanManager.GetTableByName("event.ceventconfig")
    local eventSceneId = tonumber(recorder:GetRecorder(tonumber(protocol.eventId)).scene)
    local flag = eventSceneId == controller:GetSceneID()
    if controller:IsNavMeshReady() and flag then
      controller:OnSTriggleSuccess(protocol.eventId)
    else
      NekoData.DataManager.DM_SEnterDungeon:OnSTriggleSuccess(protocol)
    end
  else
    NekoData.DataManager.DM_SEnterDungeon:OnSTriggleSuccess(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
