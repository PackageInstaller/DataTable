local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local BattleEntity, Super = System.NewClass("BattleEntity")

function BattleEntity:ctor()
  self.listComp = {}
end

function BattleEntity:Dispose()
  for _, comp in ipairs(self.listComp) do
    comp:Dispose()
  end
  self.listComp = {}
  if self.battleEngine and self.battleEngine.RemoveObj and self.uid then
    self.battleEngine:RemoveObj(self.uid)
  end
end

function BattleEntity:Tick(deltaTime)
  for _, comp in ipairs(self.listComp) do
    comp:Tick(deltaTime)
  end
end

function BattleEntity:AddBattleComponent(T, ...)
  local comp = T(self, ...):cast(BattleComponent)
  table.insert(self.listComp, comp)
  return comp
end

function BattleEntity:RemoveBattleComponent(comp)
  for index, _comp in ipairs(self.listComp) do
    if _comp == comp then
      comp:Dispose()
      table.remove(self.listComp, index)
      break
    end
  end
end

function BattleEntity:GetBattleComponent(T)
  for _, comp in ipairs(self.listComp) do
    local isSameType = comp:isDerivedFrom(T:GetType())
    if isSameType then
      return comp
    end
  end
  return nil
end

function BattleEntity:GetAllComponents()
  return self.listComp
end

function BattleEntity:CallAllComponentMethod(method, ...)
  if self.listComp then
    for _, comp in pairs(self.listComp) do
      if nil ~= comp[method] then
        local ok, err = xpcall(comp[method], debug.traceback, comp, ...)
        if not ok and self.logger then
          self.logger:ErrorS("CallComponentMethod call failed {name} {comp} {err}", self.__name, comp.__name, err)
        end
      end
    end
  end
end

return BattleEntity
