local System = require("System.System")
local BattleComponent, Super = System.NewClass("BattleComponent")

function BattleComponent:ctor(entity)
  self.entity = entity
end

function BattleComponent:ctorData()
  local compName = self.__name
  local data = self.entity.data
  if not data[compName] then
    data[compName] = {}
  end
  return data[compName]
end

function BattleComponent:Dispose()
end

function BattleComponent:Tick(deltaTime)
end

return BattleComponent
