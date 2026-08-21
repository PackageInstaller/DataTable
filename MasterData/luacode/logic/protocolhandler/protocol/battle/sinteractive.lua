-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sinteractive.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PathResolver = require("logic.scene.pathresolver")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, PathResolver
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller and controller:IsNavMeshReady() then
    local path = (string.gsub)("[sso $d]", "%$d", (protocol.obj).id)
    local object = (PathResolver.ResolveObject)(path)
    if not object then
      LogError("sceneobject", "no sceneobject " .. path)
      ;
      ((NekoData.DataManager).DM_SEnterDungeon):OnSInteractive(protocol)
    else
      ;
      (object:ToState((protocol.obj).state - 1)):Run()
    end
  else
    do
      ;
      ((NekoData.DataManager).DM_SEnterDungeon):OnSInteractive(protocol)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

