local BM_Tower = class("BM_Tower")

function BM_Tower:Ctor()
  self._towerInfo = NekoData.Data.tower
end

function BM_Tower:GetCurrentPos()
  return self._towerInfo.pos
end

function BM_Tower:GetTileInfo()
  return self._towerInfo.mapInfo
end

function BM_Tower:GetTileType(index)
  return self._towerInfo.mapInfo[index].type
end

function BM_Tower:GetTileState(index)
  return self._towerInfo.mapInfo[index].state
end

function BM_Tower:GetExitIcon()
  local recorder = BeanManager.GetTableByName("dungeonselect.cislandtypeconfig"):GetRecorder(28)
  return recorder.imgassetBundleName, recorder.imgassetName
end

function BM_Tower:GetEnemy(index)
  return self._towerInfo.monsterInfo[index]
end

function BM_Tower:ShouldTileShow(index, ignore_neighbor)
  local info = self._towerInfo.mapInfo[index]
  local visible = info.state ~= 0 or info.cfg.isShow == 1 or info.type == 99 or index == self._towerInfo.pos
  if ignore_neighbor then
    return visible
  else
    local neighbor_visible = false
    for _, i in pairs(info.neighborID) do
      if i ~= 0 then
        local neighbor_info = self._towerInfo.mapInfo[i]
        if neighbor_info.state ~= 0 or neighbor_info.type == 99 or i == self._towerInfo.pos then
          neighbor_visible = true
          break
        end
      end
    end
    return visible or neighbor_visible
  end
end

function BM_Tower:ShouldTileIconShow(index)
  for _, i in pairs(self._towerInfo.mapInfo[index].neighborID) do
    if i ~= 0 then
      local info = self._towerInfo.mapInfo[i]
      if info.state == 1 or info.type == 99 then
        return true
      end
    end
  end
  local nearby = index == self._towerInfo.pos or self:IsConnected(self._towerInfo.pos, index)
  return not self:ShouldTileShow(index, true) and self:ShouldTileShow(index, false) and nearby
end

function BM_Tower:GetTowerStyle()
  return self._towerInfo.style
end

function BM_Tower:GetCurrentTowerID()
  return self._towerInfo.id
end

function BM_Tower:GetCurrentFloor()
  return self._towerInfo.floor.current
end

function BM_Tower:GetTotalFloors()
  return self._towerInfo.floor.total
end

function BM_Tower:GetDialogFloors()
  return self._towerInfo.dialogfloor
end

function BM_Tower:GetRequiredScenes()
  if not self._towerInfo.style then
    return {}
  end
  local recorder = BeanManager.GetTableByName("dungeonselect.ctowerdungeonbattleconfig"):GetRecorder(self._towerInfo.style)
  if SceneManager.IsInDay() then
    return {
      recorder.dayBattleSceneid
    }
  else
    return {
      recorder.nightbBattleSceneid
    }
  end
end

function BM_Tower:GetBackground()
  if not self._towerInfo.style then
    return
  end
  local recorder = BeanManager.GetTableByName("dungeonselect.ctowerdungeonbattleconfig"):GetRecorder(self._towerInfo.style)
  return recorder.assetBundleName, recorder.assetName
end

function BM_Tower:GetRoleHP(rolekey)
  return self._towerInfo.hp[rolekey] or 1
end

function BM_Tower:IsConnected(from, to)
  local lhs = self._towerInfo.mapInfo[from]
  local rhs = self._towerInfo.mapInfo[to]
  if lhs and rhs then
    for k, v in pairs(lhs.neighborID) do
      if v == to then
        return true, k
      end
    end
  end
  return false
end

function BM_Tower:CanMoveTo(from, to)
  local lhs = self._towerInfo.mapInfo[from]
  local rhs = self._towerInfo.mapInfo[to]
  if not lhs or not rhs then
    return false
  end
  if not self:IsConnected(from, to) then
    return false
  end
  if lhs.state == 0 then
    return lhs.type == 99 or rhs.state == 1 or rhs.type == 99
  elseif lhs.state == 1 then
    return true
  elseif lhs.state == 2 then
    return rhs.state == 1 or rhs.type == 99
  end
end

function BM_Tower:GetMovePath(from, to, tagTable)
  local tb
  if not tagTable then
    tb = {}
  else
    tb = tagTable
  end
  local lhs = self._towerInfo.mapInfo[from]
  if lhs then
    tb[from] = true
    for k, v in pairs(lhs.neighborID) do
      if not tb[v] then
        tb[v] = true
        if v == to then
          return {v}
        elseif v ~= 0 then
          local path = self:GetMovePath(v, to, tb)
          if path then
            table.insert(path, 1, v)
            return path
          end
        end
      end
    end
  end
  return false
end

function BM_Tower:HasUnfinishedTile()
  for _, v in pairs(self._towerInfo.mapInfo) do
    if v.state ~= 1 and v.type ~= 99 then
      return true
    end
  end
  return false
end

function BM_Tower:StartBattle(index, teamid)
  local req = LuaNetManager.CreateProtocol("protocol.battle.cbattlestart")
  req.battleType = req.TOWER
  req.id = self._towerInfo.mapInfo[index].serverID
  req.lineupID = teamid
  local sceneId = self:GetRequiredScenes()[1]
  if not sceneId then
    for _, v in pairs(self:GetRequiredScenes()) do
      sceneId = v
    end
  end
  req.battleSceneId = sceneId or 0
  req:Send()
end

function BM_Tower:Reset(index)
  local req = LuaNetManager.CreateProtocol("protocol.battle.ccancelchallenge")
  req:Send()
end

function BM_Tower:MoveTo(index)
  local req = LuaNetManager.CreateProtocol("protocol.battle.ctowermove")
  req.nextIsland = self._towerInfo.mapInfo[index].serverID
  req:Send()
end

function BM_Tower:OpenBox(index, choice)
  local req = LuaNetManager.CreateProtocol("protocol.battle.copentowerislandchest")
  req.islandID = self._towerInfo.mapInfo[index].serverID
  req.choice = choice or 0
  req:Send()
end

function BM_Tower:TriggerEvent(index, choice)
  local req = LuaNetManager.CreateProtocol("protocol.battle.ctouchislandevent")
  req.islandID = self._towerInfo.mapInfo[index].serverID
  req.event = choice or 0
  req:Send()
end

function BM_Tower:ActivateShrine(index)
  local req = LuaNetManager.CreateProtocol("protocol.battle.cislandtouchaltar")
  req.islandID = self._towerInfo.mapInfo[index].serverID
  req:Send()
end

function BM_Tower:FinishFloor()
  local req = LuaNetManager.CreateProtocol("protocol.battle.cfinishtowermap")
  req:Send()
end

return BM_Tower
