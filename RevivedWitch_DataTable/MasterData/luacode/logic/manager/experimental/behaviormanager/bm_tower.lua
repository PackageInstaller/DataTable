-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_tower.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Tower = class("BM_Tower")
BM_Tower.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._towerInfo = (NekoData.Data).tower
end

BM_Tower.GetCurrentPos = function(self)
  -- function num : 0_1
  return (self._towerInfo).pos
end

BM_Tower.GetTileInfo = function(self)
  -- function num : 0_2
  return (self._towerInfo).mapInfo
end

BM_Tower.GetTileType = function(self, index)
  -- function num : 0_3
  return (((self._towerInfo).mapInfo)[index]).type
end

BM_Tower.GetTileState = function(self, index)
  -- function num : 0_4
  return (((self._towerInfo).mapInfo)[index]).state
end

BM_Tower.GetExitIcon = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local recorder = ((BeanManager.GetTableByName)("dungeonselect.cislandtypeconfig")):GetRecorder(28)
  return recorder.imgassetBundleName, recorder.imgassetName
end

BM_Tower.GetEnemy = function(self, index)
  -- function num : 0_6
  return ((self._towerInfo).monsterInfo)[index]
end

BM_Tower.ShouldTileShow = function(self, index, ignore_neighbor)
  -- function num : 0_7 , upvalues : _ENV
  local info = ((self._towerInfo).mapInfo)[index]
  local visible = info.state ~= 0 or (info.cfg).isShow == 1 or info.type == 99 or index == (self._towerInfo).pos
  if ignore_neighbor then
    return visible
  else
    local neighbor_visible = false
    for _,i in pairs(info.neighborID) do
      if i ~= 0 then
        local neighbor_info = ((self._towerInfo).mapInfo)[i]
        if neighbor_info.state ~= 0 or neighbor_info.type == 99 or i == (self._towerInfo).pos then
          neighbor_visible = true
          break
        end
      end
    end
    return visible or neighbor_visible
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

BM_Tower.ShouldTileIconShow = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  for _,i in pairs((((self._towerInfo).mapInfo)[index]).neighborID) do
    if i ~= 0 then
      local info = ((self._towerInfo).mapInfo)[i]
      if info.state == 1 or info.type == 99 then
        return true
      end
    end
  end
  local nearby = index ~= (self._towerInfo).pos and self:IsConnected((self._towerInfo).pos, index)
  do return self:ShouldTileShow(index, true) or not self:ShouldTileShow(index, false) or nearby end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BM_Tower.GetTowerStyle = function(self)
  -- function num : 0_9
  return (self._towerInfo).style
end

BM_Tower.GetCurrentTowerID = function(self)
  -- function num : 0_10
  return (self._towerInfo).id
end

BM_Tower.GetCurrentFloor = function(self)
  -- function num : 0_11
  return ((self._towerInfo).floor).current
end

BM_Tower.GetTotalFloors = function(self)
  -- function num : 0_12
  return ((self._towerInfo).floor).total
end

BM_Tower.GetDialogFloors = function(self)
  -- function num : 0_13
  return (self._towerInfo).dialogfloor
end

BM_Tower.GetRequiredScenes = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not (self._towerInfo).style then
    return {}
  end
  local recorder = ((BeanManager.GetTableByName)("dungeonselect.ctowerdungeonbattleconfig")):GetRecorder((self._towerInfo).style)
  if (SceneManager.IsInDay)() then
    return {recorder.dayBattleSceneid}
  else
    return {recorder.nightbBattleSceneid}
  end
end

BM_Tower.GetBackground = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if not (self._towerInfo).style then
    return 
  end
  local recorder = ((BeanManager.GetTableByName)("dungeonselect.ctowerdungeonbattleconfig")):GetRecorder((self._towerInfo).style)
  return recorder.assetBundleName, recorder.assetName
end

BM_Tower.GetRoleHP = function(self, rolekey)
  -- function num : 0_16
  return ((self._towerInfo).hp)[rolekey] or 1
end

BM_Tower.IsConnected = function(self, from, to)
  -- function num : 0_17 , upvalues : _ENV
  local lhs = ((self._towerInfo).mapInfo)[from]
  local rhs = ((self._towerInfo).mapInfo)[to]
  if lhs and rhs then
    for k,v in pairs(lhs.neighborID) do
      if v == to then
        return true, k
      end
    end
  end
  do
    return false
  end
end

BM_Tower.CanMoveTo = function(self, from, to)
  -- function num : 0_18
  local lhs = ((self._towerInfo).mapInfo)[from]
  local rhs = ((self._towerInfo).mapInfo)[to]
  if not lhs or not rhs then
    return false
  end
  if not self:IsConnected(from, to) then
    return false
  end
  if lhs.type ~= 99 and rhs.state ~= 1 and rhs.type ~= 99 then
    do return lhs.state ~= 0 end
    if lhs.state == 1 then
      return true
    elseif rhs.state ~= 1 and rhs.type ~= 99 then
      do return lhs.state ~= 2 end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
end

BM_Tower.GetMovePath = function(self, from, to, tagTable)
  -- function num : 0_19 , upvalues : _ENV
  local tb = nil
  if not tagTable then
    tb = {}
  else
    tb = tagTable
  end
  local lhs = ((self._towerInfo).mapInfo)[from]
  if lhs then
    tb[from] = true
    for k,v in pairs(lhs.neighborID) do
      if not tb[v] then
        tb[v] = true
        if v == to then
          return {v}
        else
          if v ~= 0 then
            local path = self:GetMovePath(v, to, tb)
            if path then
              (table.insert)(path, 1, v)
              return path
            end
          end
        end
      end
    end
  end
  do
    return false
  end
end

BM_Tower.HasUnfinishedTile = function(self)
  -- function num : 0_20 , upvalues : _ENV
  for _,v in pairs((self._towerInfo).mapInfo) do
    if v.state ~= 1 and v.type ~= 99 then
      return true
    end
  end
  return false
end

BM_Tower.StartBattle = function(self, index, teamid)
  -- function num : 0_21 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
  req.battleType = req.TOWER
  req.id = (((self._towerInfo).mapInfo)[index]).serverID
  req.lineupID = teamid
  local sceneId = (self:GetRequiredScenes())[1]
  if not sceneId then
    for _,v in pairs(self:GetRequiredScenes()) do
      sceneId = v
    end
  end
  do
    req.battleSceneId = sceneId or 0
    req:Send()
  end
end

BM_Tower.Reset = function(self, index)
  -- function num : 0_22 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ccancelchallenge")
  req:Send()
end

BM_Tower.MoveTo = function(self, index)
  -- function num : 0_23 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ctowermove")
  req.nextIsland = (((self._towerInfo).mapInfo)[index]).serverID
  req:Send()
end

BM_Tower.OpenBox = function(self, index, choice)
  -- function num : 0_24 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.copentowerislandchest")
  req.islandID = (((self._towerInfo).mapInfo)[index]).serverID
  req.choice = choice or 0
  req:Send()
end

BM_Tower.TriggerEvent = function(self, index, choice)
  -- function num : 0_25 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ctouchislandevent")
  req.islandID = (((self._towerInfo).mapInfo)[index]).serverID
  req.event = choice or 0
  req:Send()
end

BM_Tower.ActivateShrine = function(self, index)
  -- function num : 0_26 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cislandtouchaltar")
  req.islandID = (((self._towerInfo).mapInfo)[index]).serverID
  req:Send()
end

BM_Tower.FinishFloor = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cfinishtowermap")
  req:Send()
end

return BM_Tower

