-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sstartautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local info = {}
  for k,v in pairs(protocol) do
    info[k] = v
  end
  info.lineupId = 5001
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  if protocol.dungeonType == type.MAIN then
    local cdungeonselectmainline = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
    local recorder = cdungeonselectmainline:GetRecorder(info.zoneId)
    info.id = recorder.sceneid
  else
    do
      if protocol.dungeonType == type.RESOURCE then
        local cresourcedungeonstage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
        local recorder = cresourcedungeonstage:GetRecorder(info.zoneId)
        info.id = recorder.sceneID
      else
        do
          if protocol.dungeonType == type.ACTIVITY then
            local CEVENTLIST = (BeanManager.GetTableByName)("dungeonselect.ceventlist")
            local summeractivityEvents = (CEVENTLIST:GetRecorder((DataCommon.Activities).SwimSuit)).levenid
            local christmasactivityEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).Christmas)).levenid
            local loveractivityEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).Lover)).levenid
            local anniversaryEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).Anniversary)).levenid
            local starryirrorEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).StarMirage)).levenid
            local starryirrorcopyEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).StarMirageCopy)).levenid
            local summerEchoesEvent = (CEVENTLIST:GetRecorder((DataCommon.Activities).SummerEchoes)).levenid
            if (table.contain)(summeractivityEvents, info.zoneId) then
              local CHEXAGONBATTLECONFIG = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
              local CHEXAGONFUNCTION = (BeanManager.GetTableByName)("activity.chexagonfunction")
              local bettleID = (CHEXAGONFUNCTION:GetRecorder(info.zoneId)).battleID
              local recorder = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
              info.id = recorder.battlesceneid
            else
              do
                if (table.contain)(christmasactivityEvent, info.zoneId) then
                  local CHEXAGONBATTLECONFIG = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
                  local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
                  local bettleID = (CInterfaceFunction:GetRecorder(info.zoneId)).battleID
                  local recorder = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
                  info.id = recorder.battlesceneid
                else
                  do
                    if (table.contain)(loveractivityEvent, info.zoneId) then
                      local CHEXAGONBATTLECONFIG = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
                      local CValentineInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterfacefunction")
                      local bettleID = (CValentineInterfaceFunction:GetRecorder(info.zoneId)).battleID
                      local recorder = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
                      info.id = recorder.battlesceneid
                    else
                      do
                        if (table.contain)(starryirrorEvent, info.zoneId) or (table.contain)(starryirrorcopyEvent, info.zoneId) then
                          local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
                          local recorder = CStarrymirrorlevel:GetRecorder(info.zoneId)
                          info.id = recorder.battlesceneid
                        else
                          do
                            if (table.contain)(anniversaryEvent, info.zoneId) then
                              local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
                              local recorder = CAnniversarylevel:GetRecorder(info.zoneId)
                              info.id = recorder.battlesceneid
                            else
                              do
                                if (table.contain)(summerEchoesEvent, info.zoneId) then
                                  local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
                                  local CSRResourceDungeonStage = (BeanManager.GetTableByName)("activity.csrresourcedungeonstage")
                                  local levelId = (CSRFunction:GetRecorder(info.zoneId)).levelID
                                  local recorder = CSRResourceDungeonStage:GetRecorder(levelId)
                                  info.id = recorder.sceneID
                                end
                                do
                                  ;
                                  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
                                  ;
                                  ((NekoData.DataManager).DM_Dungeon):OnSStartAutoExplore(info)
                                  ;
                                  ((NekoData.DataManager).DM_SEnterDungeon):OnSStartAutoExplore(info)
                                  ;
                                  ((NekoData.DataManager).DM_Team):OnSEnterDungeon(info)
                                  ;
                                  ((NekoData.DataManager).DM_Dungeon):SetMode("auto")
                                  ;
                                  (LuaNotificationCenter.PostNotification)(Common.n_EnterDungeon, DM_Dungeon, nil)
                                  GlobalGameFSM:SetNumber("sceneLoadingId", 30005)
                                  if (protocol.curBattleInfo).battleid > 0 then
                                    ((NekoData.DataManager).DM_SBattleStart):OnSBattleStart(protocol.curBattleInfo)
                                    GlobalGameFSM:SetNumber("battleId", (protocol.curBattleInfo).battleid)
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

