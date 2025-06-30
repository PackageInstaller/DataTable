-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/npcobj.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcTable = (BeanManager.GetTableByName)("npc.cnpc")
local NPCManager = require("logic.scene.npcmanager")
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local NpcObj = class("NpcObj")
local cvarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local bubbleAssetBundle = (cvarconfig:GetRecorder(50)).Value
local bubbleAsset = (cvarconfig:GetRecorder(51)).Value
NpcObj.DirType = {North = 1, South = 3, East = 2, West = 4, Default = 4}
NpcObj.Ctor = function(self, npcId, sceneId, position, object)
  -- function num : 0_0 , upvalues : NpcTable, _ENV
  self._npcId = npcId
  self._sceneId = sceneId
  self._position = position
  self._npcObj = object
  self._visible = true
  self._cfg = NpcTable:GetRecorder(npcId)
  if not self._npcObj then
    local NpcShape = (BeanManager.GetTableByName)("npc.cnpcshape")
    local shape = NpcShape:GetRecorder((self._cfg).NPCShapeID)
    self._npcObj = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateNPC)(shape.assetBundleName, shape.mapPrefabName, position.x * 0.4, 0, position.y * 0.56 * -1)
  end
  do
    self._animator = (self._npcObj):GetComponent("Animator")
    ;
    (self._animator):SetInteger("NPCstate", (self._cfg).turn)
    self._bubbleAnchor = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._npcObj, "EmojiPoint")
    self._hasShowEmoji = false
  end
end

NpcObj.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._npcObj)
  self:RemoveEvent()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_NPCDestroy, self, {sceneId = self._sceneId, npcId = self._npcId})
end

NpcObj.OnCreate = function(self)
  -- function num : 0_2
end

NpcObj.SetActive = function(self, show)
  -- function num : 0_3
  self:SetVisible(show)
end

NpcObj.SetVisible = function(self, show)
  -- function num : 0_4 , upvalues : _ENV
  self._visible = show
  if show then
    (self._npcObj):SetActive(true)
    self:AddEvent()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NPCVisible, self, {visible = true, sceneId = self._sceneId, npcId = self._npcId})
  else
    ;
    (self._npcObj):SetActive(false)
    self:RemoveEvent()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NPCVisible, self, {visible = false, sceneId = self._sceneId, npcId = self._npcId})
  end
end

NpcObj.GetNpcId = function(self)
  -- function num : 0_5
  return self._npcId
end

NpcObj.GetSceneId = function(self)
  -- function num : 0_6
  return self._sceneId
end

NpcObj.GetObj = function(self)
  -- function num : 0_7
  return self._npcObj
end

NpcObj.GetVisible = function(self)
  -- function num : 0_8
  return self._visible
end

NpcObj.GetPosition = function(self)
  -- function num : 0_9
  return self._position
end

NpcObj.AddEvent = function(self)
  -- function num : 0_10 , upvalues : _ENV, NPCManager
  local controller = (SceneManager.GetSceneControllerByID)(self._sceneId)
  if (self._cfg).isShow == 0 then
    self:SetVisible(false)
    return 
  end
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(self._npcObj)
  self._position = {x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z * -1 / 0.56 + 0.5)}
  if (self._cfg).isBlock == 1 then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).AddBlockingPoint)((controller._sceneRef).builder, (self._position).x, (self._position).y, tonumber((self._cfg).width), tonumber((self._cfg).length))
  end
  local poslist, dirlist = (NPCManager.SetPosList)(((controller._sceneRef).actor).object, self._position)
  ;
  (NPCManager.AddNpcEvent)(self._npcId, self, poslist, dirlist)
end

NpcObj.RemoveEvent = function(self)
  -- function num : 0_11 , upvalues : _ENV, NPCManager
  local controller = (SceneManager.GetSceneControllerByID)(self._sceneId)
  if controller then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).RemoveBlockingPoint)((controller._sceneRef).builder, (self._position).x, (self._position).y, tonumber((self._cfg).width), tonumber((self._cfg).length))
  end
  ;
  (NPCManager.RemoveActButton)(self._npcId)
end

NpcObj.SetNPCDirection = function(self, dir)
  -- function num : 0_12
  if self:ShouldFacePlayer() then
    (self._animator):SetInteger("NPCstate", dir)
  end
end

NpcObj.ShouldShowBubble = function(self)
  -- function num : 0_13
  do return (self._cfg).isBubble ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NpcObj.AddSimpleBubble = function(self)
  -- function num : 0_14 , upvalues : _ENV, PrefabLoader, bubbleAssetBundle, bubbleAsset
  if not self._bubble then
    if not self._bubbleAnchor then
      LogError("npc", "no bubble anchor for npc" .. self._npcId)
      return 
    end
    self._bubble = (PrefabLoader.LoadAndInstantiatePrefab)(bubbleAssetBundle, bubbleAsset)
    ;
    ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetParent)((self._bubble).transform, (self._bubbleAnchor).transform, false)
  end
end

NpcObj.RemoveSimpleBubble = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if not self._bubble then
    return 
  end
  ;
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._bubble)
  self._bubble = nil
end

NpcObj.ShouldFacePlayer = function(self)
  -- function num : 0_16
  do return (self._cfg).isFacePlayer == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

NpcObj.BlockInConfig = function(self)
  -- function num : 0_17
  do return (self._cfg).isBlock == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return NpcObj

