local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local BattleEngineComponent, Super = System.NewClass("BattleEngineComponent", BattleComponent)

function BattleEngineComponent:ctor(entity)
  Super.ctor(self, entity)
  self.battleEngine = entity
  self.data = self:ctorData()
  self:Init()
end

function BattleEngineComponent:ctorData()
  if not self.entity.data[self.__name] then
    self.entity.data[self.__name] = {}
  end
  return self.entity.data[self.__name]
end

function BattleEngineComponent:Init()
  self:RegisterCallbacks()
end

function BattleEngineComponent:Dispose()
  self:UnregisterCallbacks()
end

function BattleEngineComponent:RegisterCallbacks()
end

function BattleEngineComponent:UnregisterCallbacks()
  self.battleEngine:UnregisterAllEventsByTarget(self)
end

return BattleEngineComponent
