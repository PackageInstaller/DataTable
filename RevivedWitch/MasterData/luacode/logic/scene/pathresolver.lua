-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/pathresolver.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PathResolver = class("PathResolver")
PathResolver.Ctor = function(self, controller, ref)
  -- function num : 0_0
  self._controller = controller
  self._ref = ref
  self._cache = {}
end

PathResolver.GetActor = function(self)
  -- function num : 0_1
  if (self._ref).actor and ((self._ref).actor).object then
    return ((self._ref).actor).object
  end
  return self:ResolvePath(nil, "Actor")
end

PathResolver.GetSceneObject = function(self, id)
  -- function num : 0_2 , upvalues : _ENV
  local _, object = (table.first)((self._ref).sceneobjects, function(key, obj)
    -- function num : 0_2_0 , upvalues : id
    do return (obj.object):GetInteractiveId() == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return object.object
end

PathResolver.GetChest = function(self, id)
  -- function num : 0_3 , upvalues : _ENV
  local _, object = (table.first)((self._controller)._chests, function(key, obj)
    -- function num : 0_3_0 , upvalues : id
    do return obj:GetID() == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return object
end

PathResolver.GetPortal = function(self, id)
  -- function num : 0_4
  return (self._controller):GetPortal(id)
end

PathResolver.GetStatefulSceneObject = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  local _, object = (table.first)((self._ref).statefulsceneobjects, function(key, obj)
    -- function num : 0_5_0 , upvalues : id
    do return obj:GetID() == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return object
end

PathResolver.ResolvePath = function(self, root, path)
  -- function num : 0_6 , upvalues : _ENV
  if not root then
    root = (self._ref):GetRootGameObject()
  end
  return ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(root, path)
end

local normalize_component = function(path)
  -- function num : 0_7 , upvalues : _ENV, PathResolver
  local UIInteraction = require("logic.scene.interaction.uiinteraction")
  if not path:find("%[") then
    return path, false
  end
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if path == "[actor]" then
    return (controller:GetPathResolver()):GetActor(), true
  end
  for id in path:gmatch("%[sceneobject (%d+)%]") do
    local object = (controller:GetPathResolver()):GetSceneObject(tonumber(id))
    if object then
      return object:GetObj(), true
    end
    do return nil end
  end
  for instanceid,id in path:gmatch("%[trap (%d+) (%d+)%]") do
    local trap = (TrapManager.GetTrap)(tonumber(instanceid), tonumber(id))
    if trap then
      return trap:GetObject(), true
    else
      LogError("path", (string.format)("[trap %d %d] not found in scene %d", instanceid, id, controller:GetSceneID()))
    end
  end
  for instanceid,id in path:gmatch("%[switch (%d+) (%d+)%]") do
    local switch = (SwitchManager.GetSwitch)(tonumber(instanceid), tonumber(id))
    if switch then
      return switch:GetObject(), true
    else
      LogError("path", (string.format)("[switch %d %d] not found in scene %d", instanceid, id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[npc (%d+)%]") do
    local npc = ((NekoData.BehaviorManager).BM_NPC):GetNpcInstance(controller:GetSceneID(), tonumber(id))
    if npc then
      return npc:GetObj(), true
    else
      LogError("path", (string.format)("[npc %d] not found in scene %d", id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[chest (%d+)%]") do
    local chest = (controller:GetPathResolver()):GetChest(tonumber(id))
    if chest then
      return chest:GetObject(), (PathResolver.ObjectType).Chest
    else
      LogError("path", (string.format)("[chest %d] not found in scene %d", id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[portal (%d+)%]") do
    local portal = (controller:GetPathResolver()):GetPortal(tonumber(id))
    if portal then
      return portal:GetObject(), (PathResolver.ObjectType).Portal
    else
      LogError("path", (string.format)("[portal %d] not found in scene %d", id, controller:GetSceneID()))
    end
  end
  for id in path:gmatch("%[sso (%d+)%]") do
    do return ((controller:GetPathResolver()):GetSceneObject(tonumber(id))):GetObj(), true end
  end
end

PathResolver.Resolve = function(path)
  -- function num : 0_8 , upvalues : _ENV, normalize_component
  if not path or path == "" or path == "nil" then
    return 
  end
  local root = nil
  local realpath = ""
  if not path or not path:find("%[") then
    realpath = path
  else
    for _,w in ipairs((string.split)(path, "/")) do
      local c, isobject = normalize_component(w)
      if isobject then
        root = c
        realpath = ""
      else
        if not c then
          return 
        else
          realpath = realpath .. c
        end
      end
    end
  end
  do
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    return (controller:GetPathResolver()):ResolvePath(root, realpath)
  end
end

PathResolver.ObjectType = {SceneObject = 1, Trap = 2, Switch = 3, NPC = 4, Chest = 5, Portal = 6, StatefulSceneObject = 7}
PathResolver.ResolveObject = function(path)
  -- function num : 0_9 , upvalues : _ENV, PathResolver
  local UIInteraction = require("logic.scene.interaction.uiinteraction")
  if not path:match("^%[.*%]$") then
    return 
  end
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if path == "[actor]" then
    return (controller:GetPathResolver()):GetActor()
  end
  for id in path:gmatch("%[sceneobject (%d+)%]") do
    do return (controller:GetPathResolver()):GetSceneObject(tonumber(id)), (PathResolver.ObjectType).SceneObject end
  end
  for instance,id in path:gmatch("%[trap (%d+) (%d+)%]") do
    local trap = (TrapManager.GetTrap)(tonumber(instance), tonumber(id))
    if trap then
      return trap, (PathResolver.ObjectType).Trap
    else
      LogError("path", "trap " .. id .. " not found in scene " .. controller:GetSceneID())
    end
  end
  for instance,id in path:gmatch("%[switch (%d+) (%d+)%]") do
    local switch = (SwitchManager.GetSwitch)(tonumber(instance), tonumber(id))
    if switch then
      return switch, (PathResolver.ObjectType).Switch
    else
      LogError("path", "switch " .. id .. " not found in scene " .. controller:GetSceneID())
    end
  end
  for id in path:gmatch("%[npc (%d+)%]") do
    do return ((NekoData.BehaviorManager).BM_NPC):GetNpcInstance(controller:GetSceneID(), tonumber(id)), (PathResolver.ObjectType).NPC end
  end
  for id in path:gmatch("%[chest (%d+)%]") do
    do return (controller:GetPathResolver()):GetChest(tonumber(id)), (PathResolver.ObjectType).Chest end
  end
  for id in path:gmatch("%[portal (%d+)%]") do
    do return (controller:GetPathResolver()):GetPortal(tonumber(id)), (PathResolver.ObjectType).Portal end
  end
  for id in path:gmatch("%[sso (%d+)%]") do
    do return (controller:GetPathResolver()):GetStatefulSceneObject(tonumber(id)), (PathResolver.ObjectType).StatefulSceneObject end
  end
end

return PathResolver

