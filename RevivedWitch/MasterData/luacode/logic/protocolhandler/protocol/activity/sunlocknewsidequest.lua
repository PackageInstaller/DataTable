-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sunlocknewsidequest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if protocol.result == 0 then
    local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
    local recorder = CSideStoryChapter:GetRecorder(protocol.dungeonID)
    if recorder.unlockitem == 0 then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(recorder.unlockConfirm)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

