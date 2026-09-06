local PathResolver = class("PathResolver")

function PathResolver:Ctor(controller, ref)
  self._controller = controller
  self._ref = ref
  self._cache = {}
end

function PathResolver:GetActor()
  if self._ref.actor and self._ref.actor.object then
    return self._ref.actor.object
  end
  return self:ResolvePath(nil, "Actor")
end

function PathResolver:GetSceneObject(id)
  local _, object = table.first(self._ref.sceneobjects, function(key, obj)
    return obj.object:GetInteractiveId() == id
  end)
  return object.object
end

function PathResolver:GetChest(id)
  local _, object = table.first(self._controller._chests, function(key, obj)
    return obj:GetID() == id
  end)
  return object
end

function PathResolver:GetPortal(id)
  return self._controller:GetPortal(id)
end

function PathResolver:GetStatefulSceneObject(id)
  local _, object = table.first(self._ref.statefulsceneobjects, function(key, obj)
    return obj:GetID() == id
  end)
  return object
end

function PathResolver:ResolvePath(root, path)
  root = root or self._ref:GetRootGameObject()
  return CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(root, path)
end

local function normalize_component(path)
  local UIInteraction = require("logic.scene.interaction.uiinteraction")
  if not path:find("%[") then
    return path, false
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if path == "[actor]" then
    return controller:GetPathResolver():GetActor(), true
  end
  for id in path:gmatch("%[sceneobject (%d+)%]") do
    local object = controller:GetPathResolver():GetSceneObject(tonumber(id))
    if object then
      return object:GetObj(), true
    end
    return nil
  end
  for instanceid, id in path:gmatch("%[trap (%d+) (%d+)%]") do
    local trap = TrapManager.GetTrap(tonumber(instanceid), tonumber(id))
    if trap then
      return trap:GetObject(), true
    else
      LogError("path", string.format("[trap %d %d] not found in scene %d", instanceid, id, controller:GetSceneID()))
    end
  end
  for instanceid, id in path:gmatch("%[switch (%d+) (%d+)%]") do
    local switch = SwitchManager.GetSwitch(tonumber(instanceid), tonumber(id))
    if switch then
      return switch:GetObject(), true
    else
      LogError("path", string.format("[switch %d %d] not found in scene %d", instanceid, id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[npc (%d+)%]") do
    local npc = NekoData.BehaviorManager.BM_NPC:GetNpcInstance(controller:GetSceneID(), tonumber(id))
    if npc then
      return npc:GetObj(), true
    else
      LogError("path", string.format("[npc %d] not found in scene %d", id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[chest (%d+)%]") do
    local chest = controller:GetPathResolver():GetChest(tonumber(id))
    if chest then
      return chest:GetObject(), PathResolver.ObjectType.Chest
    else
      LogError("path", string.format("[chest %d] not found in scene %d", id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[portal (%d+)%]") do
    local portal = controller:GetPathResolver():GetPortal(tonumber(id))
    if portal then
      return portal:GetObject(), PathResolver.ObjectType.Portal
    else
      LogError("path", string.format("[portal %d] not found in scene %d", id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[sso (%d+)%]") do
    return controller:GetPathResolver():GetSceneObject(tonumber(id)):GetObj(), true
  end
end

function PathResolver.Resolve(path)
  if not path or path == "" or path == "nil" then
    return
  end
  local root
  local realpath = ""
  if not path or not path:find("%[") then
    realpath = path
  else
    for _, w in ipairs(string.split(path, "/")) do
      local c, isobject = normalize_component(w)
      if isobject then
        root = c
        realpath = ""
      elseif not c then
        return
      else
        realpath = realpath .. c
      end
    end
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  return controller:GetPathResolver():ResolvePath(root, realpath)
end

PathResolver.ObjectType = {
  SceneObject = 1,
  Trap = 2,
  Switch = 3,
  NPC = 4,
  Chest = 5,
  Portal = 6,
  StatefulSceneObject = 7
}

function PathResolver.ResolveObject(path)
  local UIInteraction = require("logic.scene.interaction.uiinteraction")
  if not path:match("^%[.*%]$") then
    return
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if path == "[actor]" then
    return controller:GetPathResolver():GetActor()
  end
  for id in path:gmatch("%[sceneobject (%d+)%]") do
    return controller:GetPathResolver():GetSceneObject(tonumber(id)), PathResolver.ObjectType.SceneObject
  end
  for instance, id in path:gmatch("%[trap (%d+) (%d+)%]") do
    local trap = TrapManager.GetTrap(tonumber(instance), tonumber(id))
    if trap then
      return trap, PathResolver.ObjectType.Trap
    else
      LogError("path", "trap " .. id .. " not found in scene " .. controller:GetSceneID())
    end
  end
  for instance, id in path:gmatch("%[switch (%d+) (%d+)%]") do
    local switch = SwitchManager.GetSwitch(tonumber(instance), tonumber(id))
    if switch then
      return switch, PathResolver.ObjectType.Switch
    else
      LogError("path", "switch " .. id .. " not found in scene " .. controller:GetSceneID())
    end
  end
  for id in path:gmatch("%[npc (%d+)%]") do
    return NekoData.BehaviorManager.BM_NPC:GetNpcInstance(controller:GetSceneID(), tonumber(id)), PathResolver.ObjectType.NPC
  end
  for id in path:gmatch("%[chest (%d+)%]") do
    return controller:GetPathResolver():GetChest(tonumber(id)), PathResolver.ObjectType.Chest
  end
  for id in path:gmatch("%[portal (%d+)%]") do
    return controller:GetPathResolver():GetPortal(tonumber(id)), PathResolver.ObjectType.Portal
  end
  for id in path:gmatch("%[sso (%d+)%]") do
    return controller:GetPathResolver():GetStatefulSceneObject(tonumber(id)), PathResolver.ObjectType.StatefulSceneObject
  end
end

return PathResolver
