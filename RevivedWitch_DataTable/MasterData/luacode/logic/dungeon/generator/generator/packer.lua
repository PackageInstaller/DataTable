-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/generator/packer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Packer = class("Packer")
Packer.Ctor = function(self, mininterval, seed)
  -- function num : 0_0 , upvalues : _ENV
  self._random = (pcg.create)(seed)
  self._mininterval = mininterval
end

Packer.Pack = function(self, rooms, width, height)
  -- function num : 0_1 , upvalues : _ENV, Packer
  local count = 0
  local i = 1
  while 1 do
    while 1 do
      while 1 do
        if i <= #rooms then
          print(i)
          local area = (rooms[i]):GetArea()
          local x = (self._random)(self._mininterval, width - area:GetWidth() - self._mininterval)
          local y = (self._random)(self._mininterval, height - area:GetHeight() - self._mininterval)
          area:SetPosition(x, y)
          local overlapped = false
          for j = 1, i - 1 do
            if (Packer.Overlap)((rooms[j]):GetArea(), area, self._mininterval) then
              overlapped = true
              break
            end
          end
          do
            if count > 200 then
              i = 1
              count = 0
              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      if overlapped then
        count = count + 1
        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    ;
    (rooms[i]):SetArea(area)
    count = 0
    i = i + 1
  end
end

Packer.Overlap = function(lhs, rhs, gap)
  -- function num : 0_2 , upvalues : _ENV
  local lx, ly = lhs:GetPosition()
  local lxmax, lymax = lhs:GetMax()
  local rx, ry = rhs:GetPosition()
  local rxmax, rymax = rhs:GetMax()
  do return (math.max)(lxmax, rxmax) - (math.min)(lx, rx) < lhs:GetWidth() + rhs:GetWidth() + gap and (math.max)(lymax, rymax) - (math.min)(ly, ry) < lhs:GetHeight() + rhs:GetHeight() + gap end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return Packer

