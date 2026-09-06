local ComposedTrigger = class("ComposedTrigger")

function ComposedTrigger:Ctor(id, eventid)
  self._id = id
  self._eventid = eventid
  self._root = nil
  self._triggers = nil
end

function ComposedTrigger:AddTask(root)
  self._root = root
end

function ComposedTrigger:GetType()
  return "composed"
end

function ComposedTrigger:Destroy()
  self._root:Destroy()
end

function ComposedTrigger:Check()
  return self:OnCheck()
end

function ComposedTrigger:OnCheck()
  local type = self._root:GetType()
  if type == "composed" or type == "operator" then
    return self._root:Check()
  else
    return self._root:GetState()
  end
end

function ComposedTrigger:IsActive()
  return self:Check()
end

function ComposedTrigger:Activate()
  self._root:Activate()
end

function ComposedTrigger:Reset()
  self._root:Reset()
end

return ComposedTrigger
