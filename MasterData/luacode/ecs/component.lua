local Component = dataclass("Component")

function Component:Ctor(entity)
  self._entity = entity
end

return Component
