-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sresourcepanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TypeInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeontype")
local DungeonInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeoninfo")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, DungeonInfoTable, TypeInfoTable
  LogInfo("sresourcepanel", "recevie")
  local userinfo = {}
  local l1 = (LuaNetManager.GetBeanDef)("protocol.battle.resourceword")
  local l2 = (LuaNetManager.GetBeanDef)("protocol.battle.resourcezone")
  local l3 = (LuaNetManager.GetBeanDef)("protocol.battle.resourcepass")
  for type,word in pairs(protocol.words) do
    local t1 = {}
    t1.id = type
    if word.status == l1.LOCK then
      t1.lock = true
    else
      if word.status == l1.UNSTART then
        t1.open = false
      else
        if word.status == l1.UNCLEAR then
          t1.open = true
          t1.clearAll = false
        else
          if word.status == l1.CLEAR then
            t1.open = true
            t1.clearAll = true
          end
        end
      end
    end
    t1.detailInfo = {}
    for zoneId,zone in pairs(word.zones) do
      local t2 = {}
      t2.id = zoneId
      if zone.status == l2.UNSTART then
        t2.open = false
      else
        if zone.status == l2.UNCLEAR then
          t2.open = true
          t2.clearAll = false
        else
          if zone.status == l2.CLEAR then
            t2.open = true
            t2.clearAll = true
          end
        end
      end
      t2.startTime = zone.starttime
      t2.endTime = zone.endTime
      t2.curStage = zone.curStage
      t2.stageList = {}
      for passId,stage in pairs(zone.passes) do
        local t3 = {}
        t3.id = passId
        if stage.status == l3.LOCK then
          t3.lock = true
        else
          if stage.status == l3.UNCLEAR then
            t3.lock = false
            t3.clear = false
          else
            if stage.status == l3.CLEAR then
              t3.lock = false
              t3.clear = true
            end
          end
        end
        t3.spirit = stage.spirit
        t3.recommendLevel = stage.level
        t3.exploreProgress = stage.process
        t3.firstItem = {}
        for _,item in ipairs(stage.firstItems) do
          (table.insert)(t3.firstItem, item)
        end
        if stage.first == 0 then
          t3.firstGet = false
        else
          t3.firstGet = true
        end
        t3.maybeItem = {}
        for _,item in ipairs(stage.randItems) do
          (table.insert)(t3.maybeItem, item)
        end
        t3.activityItems = {}
        for _,item in ipairs(stage.activityItems) do
          (table.insert)(t3.activityItems, item.id)
        end
        ;
        (table.insert)(t2.stageList, t3)
      end
      ;
      (table.sort)(t2.stageList, function(a, b)
    -- function num : 0_0_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (table.insert)(t1.detailInfo, t2)
    end
    ;
    (table.sort)(t1.detailInfo, function(a, b)
    -- function num : 0_0_1 , upvalues : DungeonInfoTable
    local r1 = DungeonInfoTable:GetRecorder(a.id)
    local r2 = DungeonInfoTable:GetRecorder(b.id)
    do return r1.sortID < r2.sortID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (table.insert)(userinfo, t1)
  end
  ;
  (table.sort)(userinfo, function(a, b)
    -- function num : 0_0_2 , upvalues : TypeInfoTable
    local r1 = TypeInfoTable:GetRecorder(a.id)
    local r2 = TypeInfoTable:GetRecorder(b.id)
    do return r1.sortID < r2.sortID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  ((NekoData.DataManager).DM_Game):OnSResourcePanel(userinfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ReceiveResourcePanel, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

