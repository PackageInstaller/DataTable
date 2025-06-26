-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sopendungeonlist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("sopendungeonlist", "recevie")
  local userinfo = {}
  for world,worldValue in pairs(protocol.world) do
    local worldTemp = {worldId = world, curZone = worldValue.curZone, 
floorDetail = {}
, clearZones = worldValue.clearZones, totalZones = worldValue.totalZones, isReceived = worldValue.isReceived}
    for floor,floorValue in pairs(worldValue.zone) do
      local temp = {}
      temp.floor = floor
      temp.checkPointOpenBoxex = (floorValue.checkPoint).openedBoxes
      temp.checkPointTotalBoxes = (floorValue.checkPoint).totalBoxes
      temp.openedBoxes = floorValue.openedBoxes
      temp.totalBoxes = floorValue.totalBoxes
      temp.isReceived = floorValue.isReceived
      temp.autoExplore = floorValue.autoExplore
      temp.spirit = (floorValue.checkPoint).spirit
      if (floorValue.checkPoint).isPass == 0 then
        temp.firstGet = false
      else
        temp.firstGet = true
      end
      temp.smallPoint = {}
      for _,v in ipairs(floorValue.smallPoint) do
        local tempSmallInfo = {}
        tempSmallInfo = {bigParentId = temp.floor, sceneId = v.sceneId, isPass = v.isPass, openedBoxes = v.openedBoxes, totalBoxes = v.totalBoxes}
        ;
        (table.insert)(temp.smallPoint, tempSmallInfo)
      end
      ;
      (table.insert)(worldTemp.floorDetail, temp)
    end
    ;
    (table.insert)(userinfo, worldTemp)
  end
  ;
  ((NekoData.DataManager).DM_Game):OnSOpenDungeonList(userinfo)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ReceiveDungeonList, nil, userinfo)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

