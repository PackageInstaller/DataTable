local Component = require("ecs.component")
local SummonDataComponent = dataclass("SummonDataComponent", Component)

function SummonDataComponent:Ctor(...)
  SummonDataComponent.super.Ctor(self, ...)
  self._yuziSummonData = {}
  self._summonBuffData = {}
  self._alternateFighter = {}
end

return SummonDataComponent
