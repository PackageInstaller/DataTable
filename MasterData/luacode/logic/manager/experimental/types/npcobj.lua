local NpcTable = BeanManager.GetTableByName("npc.cnpc")
local NPCManager = require("logic.scene.npcmanager")
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local NpcObj = class("NpcObj")
local cvarconfig = BeanManager.GetTableByName("var.cvarconfig")
local bubbleAssetBundle = cvarconfig:GetRecorder(50).Value
local bubbleAsset = cvarconfig:GetRecorder(51).Value
NpcObj.DirType = {
  North = 1,
  South = 3,
  East = 2,
  West = 4,
  Default = 4
}

function NpcObj:Ctor(npcId, sceneId, position, object)
  self._npcId = npcId
  self._sceneId = sceneId
  self._position = position
  self._npcObj = object
  self._visible = true
  self._cfg = NpcTable:GetRecorder(npcId)
  if not self._npcObj then
    local NpcShape = BeanManager.GetTableByName("npc.cnpcshape")
    local shape = NpcShape:GetRecorder(self._cfg.NPCShapeID)
    self._npcObj = CS.PixelNeko.P1.Scene.TrapHelper.CreateNPC(shape.assetBundleName, shape.mapPrefabName, position.x * 0.4, 0, position.y * 0.56 * -1)
  end
  self._animator = self._npcObj:GetComponent("Animator")
  self._animator:SetInteger("NPCstate", self._cfg.turn)
  self._bubbleAnchor = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._npcObj, "EmojiPoint")
  self._hasShowEmoji = false
end

function NpcObj:Destroy()
  CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._npcObj)
  self:RemoveEvent()
  LuaNotificationCenter.PostNotification(Common.n_NPCDestroy, self, {
    sceneId = self._sceneId,
    npcId = self._npcId
  })
end

function NpcObj:OnCreate()
end

function NpcObj:SetActive(show)
  self:SetVisible(show)
end

function NpcObj:SetVisible(show)
  self._visible = show
  if show then
    self._npcObj:SetActive(true)
    self:AddEvent()
    LuaNotificationCenter.PostNotification(Common.n_NPCVisible, self, {
      visible = true,
      sceneId = self._sceneId,
      npcId = self._npcId
    })
  else
    self._npcObj:SetActive(false)
    self:RemoveEvent()
    LuaNotificationCenter.PostNotification(Common.n_NPCVisible, self, {
      visible = false,
      sceneId = self._sceneId,
      npcId = self._npcId
    })
  end
end

function NpcObj:GetNpcId()
  return self._npcId
end

function NpcObj:GetSceneId()
  return self._sceneId
end

function NpcObj:GetObj()
  return self._npcObj
end

function NpcObj:GetVisible()
  return self._visible
end

function NpcObj:GetPosition()
  return self._position
end

function NpcObj:AddEvent()
  local controller = SceneManager.GetSceneControllerByID(self._sceneId)
  if self._cfg.isShow == 0 then
    self:SetVisible(false)
    return
  end
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(self._npcObj)
  self._position = {
    x = math.floor(x / 0.4 + 0.5),
    y = math.floor(z * -1 / 0.56 + 0.5)
  }
  if self._cfg.isBlock == 1 then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.AddBlockingPoint(controller._sceneRef.builder, self._position.x, self._position.y, tonumber(self._cfg.width), tonumber(self._cfg.length))
  end
  local poslist, dirlist = NPCManager.SetPosList(controller._sceneRef.actor.object, self._position)
  NPCManager.AddNpcEvent(self._npcId, self, poslist, dirlist)
end

function NpcObj:RemoveEvent()
  local controller = SceneManager.GetSceneControllerByID(self._sceneId)
  if controller then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.RemoveBlockingPoint(controller._sceneRef.builder, self._position.x, self._position.y, tonumber(self._cfg.width), tonumber(self._cfg.length))
  end
  NPCManager.RemoveActButton(self._npcId)
end

function NpcObj:SetNPCDirection(dir)
  if self:ShouldFacePlayer() then
    self._animator:SetInteger("NPCstate", dir)
  end
end

function NpcObj:ShouldShowBubble()
  return self._cfg.isBubble ~= 0
end

function NpcObj:AddSimpleBubble()
  if not self._bubble then
    if not self._bubbleAnchor then
      LogError("npc", "no bubble anchor for npc" .. self._npcId)
      return
    end
    self._bubble = PrefabLoader.LoadAndInstantiatePrefab(bubbleAssetBundle, bubbleAsset)
    CS.PixelNeko.Lua.TransformStaticFunctions.SetParent(self._bubble.transform, self._bubbleAnchor.transform, false)
  end
end

function NpcObj:RemoveSimpleBubble()
  if not self._bubble then
    return
  end
  CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._bubble)
  self._bubble = nil
end

function NpcObj:ShouldFacePlayer()
  return self._cfg.isFacePlayer == 1
end

function NpcObj:BlockInConfig()
  return self._cfg.isBlock == 1
end

return NpcObj
