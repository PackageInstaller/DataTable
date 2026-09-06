local Enum_Camp = dataclass("Enum_Camp")
Enum_Camp.LeftFighter = 1
Enum_Camp.RightFighter = 2

function Enum_Camp:Ctor()
end

function Enum_Camp:Marshal(data)
end

function Enum_Camp:Unmarshal(data)
end

function Enum_Camp:CheckVariable()
  return true
end

return Enum_Camp
