local Room = class("Room")
Room.DoorCfg = class("DoorCfg")

function Room.DoorCfg:Ctor(center, dir, corners)
  self.center = center
  self.dir = dir
  self.corners = corners
end

Room.Direction = {
  T = 1,
  R = 2,
  L = 3,
  B = 4
}

function Room:Ctor(area, id, type)
  self._area = area
  self._id = id
  self._type = type
  self._doors = {}
end

function Room:GetArea()
  return self._area
end

function Room:SetArea(area)
  self._area = area
end

function Room:GetID()
  return self._id
end

function Room:SetID(id)
  self._id = id
end

function Room:GetType()
  return self._type
end

function Room:HasDoor(dir)
  return table.any(self._doors, function(key, value)
    return key.dir == dir
  end)
end

function Room:AddDoor(cfg)
  if table.any(self._doors, function(key, value)
    return key.dir == cfg.dir and key.center:same(cfg.center)
  end) then
    return false
  end
  self._doors[cfg] = true
  return true
end

function Room:OpenDoor(dir, center)
  for k, v in pairs(self._doors) do
    if k.dir == dir and k.center:same(center) then
      self._doors[k] = true
      return true
    end
  end
  return false
end

function Room:GetOpenDoors()
  local result = {}
  for k, v in pairs(self._doors) do
    if v then
      table.insert(result, k)
    end
  end
  return result
end

function Room:GetAllDoors()
  return table.keys(self._doors)
end

return Room
