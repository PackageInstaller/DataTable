-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/srefreshachievementinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  if protocol.sendType == 2 and ((NekoData.BehaviorManager).BM_Task):GetAchievement() then
    local list = (((NekoData.BehaviorManager).BM_Task):GetAchievement()).badges
    if list then
      for k,v in pairs((protocol.achievement).badges) do
        local ishas = false
        for id,_ in pairs(list) do
          if id == k then
            ishas = true
            break
          end
        end
        do
          do
            if not ishas then
              ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).RoleAchievementGetShow, data = k})
              break
            end
            -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    else
      for k,v in pairs((protocol.achievement).badges) do
        ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).RoleAchievementGetShow, data = k})
      end
    end
  end
  do
    ;
    ((NekoData.DataManager).DM_Task):OnSRefreshAchievementInfo(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshAchievementLevelAward, nil, nil)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

