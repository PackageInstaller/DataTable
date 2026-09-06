local Packer = class("Packer")

function Packer:Ctor(mininterval, seed)
  self._random = pcg.create(seed)
  self._mininterval = mininterval
end

function Packer:Pack(rooms, width, height)
  local count = 0
  local i = 1
  while i <= #rooms do
    print(i)
    local area = rooms[i]:GetArea()
    local x = self._random(self._mininterval, width - area:GetWidth() - self._mininterval)
    local y = self._random(self._mininterval, height - area:GetHeight() - self._mininterval)
    area:SetPosition(x, y)
    local overlapped = false
    for j = 1, i - 1 do
      if Packer.Overlap(rooms[j]:GetArea(), area, self._mininterval) then
        overlapped = true
        break
      end
    end
    if 200 < count then
      i = 1
      count = 0
    elseif overlapped then
      count = count + 1
    else
      rooms[i]:SetArea(area)
      count = 0
      i = i + 1
    end
  end
end

function Packer.Overlap(lhs, rhs, gap)
  local lx, ly = lhs:GetPosition()
  local lxmax, lymax = lhs:GetMax()
  local rx, ry = rhs:GetPosition()
  local rxmax, rymax = rhs:GetMax()
  return math.max(lxmax, rxmax) - math.min(lx, rx) < lhs:GetWidth() + rhs:GetWidth() + gap and math.max(lymax, rymax) - math.min(ly, ry) < lhs:GetHeight() + rhs:GetHeight() + gap
end

return Packer
