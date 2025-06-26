-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/scene/towerscenedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local TowerSceneDialog = class("InteractModalDialog", Dialog)
TowerSceneDialog.AssetBundleName = "ui/layouts.mainline"
TowerSceneDialog.AssetName = "TowerLevelMain"
local bm_tower = (NekoData.BehaviorManager).BM_Tower
TowerSceneDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerSceneDialog
  ((TowerSceneDialog.super).Ctor)(self, ...)
  self._groupName = "Operation"
  self._controller = nil
  self._raycastHits = nil
  self._freezeCount = 0
end

TowerSceneDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : PhysicsStaticFunctions
  self._back = self:GetChild("BackBtn")
  self._reset = self:GetChild("RefreshBtn")
  self._title = self:GetChild("TitleBack/Title")
  self._resume = self:GetChild("GoOnBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackClick, self)
  ;
  (self._reset):Subscribe_PointerClickEvent(self.OnResetClick, self)
  ;
  (self._resume):Subscribe_PointerClickEvent(self.Resume, self)
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  ;
  (self._rootWindow):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  ;
  (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
  ;
  (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

TowerSceneDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerSceneDialog.Init = function(self, sceneController)
  -- function num : 0_3 , upvalues : bm_tower, _ENV
  self._controller = sceneController
  if bm_tower:GetTileType(bm_tower:GetCurrentPos()) ~= 99 then
    self:Pause()
  else
    self:Resume()
  end
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1177)).msgTextID
  str = (TextManager.GetText)(str)
  str = str:gsub("%$parameter(%d)%$", {["1"] = (TextManager.GetText)((((BeanManager.GetTableByName)("dungeonselect.ctowerdungeontype")):GetRecorder(bm_tower:GetCurrentTowerID())).nameTextID), ["2"] = (TextManager.GetText)((((BeanManager.GetTableByName)("dungeonselect.cfloorname")):GetRecorder(bm_tower:GetCurrentFloor() + 1)).floorName)})
  ;
  (self._title):SetText(str)
end

TowerSceneDialog.IsHit = function(self, position)
  -- function num : 0_4 , upvalues : UIManager, PhysicsStaticFunctions, _ENV
  local mainCamera = (self._controller):GetMainCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("DormMain", position.x, position.y, 0)
  local ray = (mainCamera:ViewportPointToRay(outputViewPos))
  local count = nil
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAllocSort)(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return 
  end
  return (((self._raycastHits)[0]).collider).gameObject
end

TowerSceneDialog.OnMouseClicked = function(self, args)
  -- function num : 0_5
  if self._freezeCount > 0 then
    return 
  end
  local object = self:IsHit(args.position)
  if object then
    (self._controller):OnTileClick(object)
  end
end

TowerSceneDialog.AddNewModal = function(self)
  -- function num : 0_6
end

TowerSceneDialog.OnBeginDrag = function(self, args)
  -- function num : 0_7
  self._drag = true
  ;
  (self._controller):MoveCamera(0, 0)
end

TowerSceneDialog.OnDrag = function(self, args)
  -- function num : 0_8
  if self._drag then
    (self._controller):MoveCamera(-(args.delta).x / 100, -(args.delta).y / 100)
  end
end

TowerSceneDialog.OnEndDrag = function(self, args)
  -- function num : 0_9
  self._drag = false
  ;
  (self._controller):MoveCamera(0, 0)
end

TowerSceneDialog.Freeze = function(self)
  -- function num : 0_10
  self._freezeCount = self._freezeCount + 1
  ;
  (self:GetRootWindow()):SetActive(false)
end

TowerSceneDialog.Thaw = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self._freezeCount = (math.max)(0, self._freezeCount - 1)
  if self._freezeCount == 0 then
    (self:GetRootWindow()):SetActive(true)
  end
end

TowerSceneDialog.Pause = function(self)
  -- function num : 0_12
  self._freezeCount = self._freezeCount + 1
end

TowerSceneDialog.Resume = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self._freezeCount = (math.max)(0, self._freezeCount - 1)
  ;
  (self._resume):SetActive(false)
  ;
  (self._controller):OnCurrentTileClick()
end

TowerSceneDialog.OnBackClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(59, nil, function()
    -- function num : 0_14_0 , upvalues : self, _ENV
    self:Freeze()
    ;
    ((EffectFactory.CreateJumpBackEffect)(66)):Run()
  end
)
end

TowerSceneDialog.OnResetClick = function(self)
  -- function num : 0_15 , upvalues : _ENV, bm_tower
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(48, nil, function()
    -- function num : 0_15_0 , upvalues : bm_tower, self
    bm_tower:Reset(bm_tower:GetCurrentTowerID())
    self:Freeze()
  end
)
end

return TowerSceneDialog

