local function p1(protocol)
  if protocol.result == 0 then
    local CSideStoryChapter = BeanManager.GetTableByName("dungeonselect.csidestorychapter")
    
    local recorder = CSideStoryChapter:GetRecorder(protocol.dungeonID)
    if recorder.unlockitem == 0 then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(recorder.unlockConfirm)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
