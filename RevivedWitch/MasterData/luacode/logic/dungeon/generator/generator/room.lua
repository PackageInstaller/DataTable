-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/generator/room.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Room = class("Room")
Room.DoorCfg = class("DoorCfg")
-- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

;
(Room.DoorCfg).Ctor = function(self, center, dir, corners)
  -- function num : 0_0
  self.center = center
  self.dir = dir
  self.corners = corners
end

Room.Direction = {T = 1, R = 2, L = 3, B = 4}
Room.Ctor = function(self, area, id, type)
  -- function num : 0_1
  self._area = area
  self._id = id
  self._type = type
  self._doors = {}
end

Room.GetArea = function(self)
  -- function num : 0_2
  return self._area
end

Room.SetArea = function(self, area)
  -- function num : 0_3
  self._area = area
end

Room.GetID = function(self)
  -- function num : 0_4
  return self._id
end

Room.SetID = function(self, id)
  -- function num : 0_5
  self._id = id
end

Room.GetType = function(self)
  -- function num : 0_6
  return self._type
end

Room.HasDoor = function(self, dir)
  -- function num : 0_7 , upvalues : _ENV
  return (table.any)(self._doors, function(key, value)
    -- function num : 0_7_0 , upvalues : dir
    do return key.dir == dir end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

Room.AddDoor = function(self, cfg)
  -- function num : 0_8 , upvalues : _ENV
  if (table.any)(self._doors, function(key, value)
    -- function num : 0_8_0 , upvalues : cfg
    do return (key.dir == cfg.dir and (key.center):same(cfg.center)) end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
) then
    return false
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._doors)[cfg] = true
  return true
end

Room.OpenDoor = function(self, dir, center)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in pairs(self._doors) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

    if k.dir == dir and (k.center):same(center) then
      (self._doors)[k] = true
      return true
    end
  end
  return false
end

Room.GetOpenDoors = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local result = {}
  for k,v in pairs(self._doors) do
    if v then
      (table.insert)(result, k)
    end
  end
  return result
end

Room.GetAllDoors = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return (table.keys)(self._doors)
end

return Room

