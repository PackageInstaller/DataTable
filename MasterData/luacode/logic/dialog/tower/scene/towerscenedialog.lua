local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local UIManager = CS.PixelNeko.UI.UIManager
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local TowerSceneDialog = class("InteractModalDialog", Dialog)
TowerSceneDialog.AssetBundleName = "ui/layouts.mainline"
TowerSceneDialog.AssetName = "TowerLevelMain"
local bm_tower = NekoData.BehaviorManager.BM_Tower

function TowerSceneDialog:Ctor(...)
  TowerSceneDialog.super.Ctor(self, ...)
  self._groupName = "Operation"
  self._controller = nil
  self._raycastHits = nil
  self._freezeCount = 0
end

function TowerSceneDialog:OnCreate()
  self._back = self:GetChild("BackBtn")
  self._reset = self:GetChild("RefreshBtn")
  self._title = self:GetChild("TitleBack/Title")
  self._resume = self:GetChild("GoOnBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackClick, self)
  self._reset:Subscribe_PointerClickEvent(self.OnResetClick, self)
  self._resume:Subscribe_PointerClickEvent(self.Resume, self)
  self._raycastHits = PhysicsStaticFunctions.CreateRaycastHits(1)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  self._rootWindow:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._rootWindow:Subscribe_DragEvent(self.OnDrag, self)
  self._rootWindow:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._rootWindow:Subscribe_CancelDragEvent(self.OnEndDrag, self)
end

function TowerSceneDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerSceneDialog:Init(sceneController)
  self._controller = sceneController
  if bm_tower:GetTileType(bm_tower:GetCurrentPos()) ~= 99 then
    self:Pause()
  else
    self:Resume()
  end
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1177).msgTextID
  str = TextManager.GetText(str)
  str = str:gsub("%$parameter(%d)%$", {
    ["1"] = TextManager.GetText(BeanManager.GetTableByName("dungeonselect.ctowerdungeontype"):GetRecorder(bm_tower:GetCurrentTowerID()).nameTextID),
    ["2"] = TextManager.GetText(BeanManager.GetTableByName("dungeonselect.cfloorname"):GetRecorder(bm_tower:GetCurrentFloor() + 1).floorName)
  })
  self._title:SetText(str)
end

function TowerSceneDialog:IsHit(position)
  local mainCamera = self._controller:GetMainCamera()
  local outputViewPos = UIManager.ScreenToViewportPointInMargin("DormMain", position.x, position.y, 0)
  local ray = mainCamera:ViewportPointToRay(outputViewPos)
  local count
  self._raycastHits, count = PhysicsStaticFunctions.RaycastNonAllocSort(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return
  end
  return self._raycastHits[0].collider.gameObject
end

function TowerSceneDialog:OnMouseClicked(args)
  if self._freezeCount > 0 then
    return
  end
  local object = self:IsHit(args.position)
  if object then
    self._controller:OnTileClick(object)
  end
end

function TowerSceneDialog:AddNewModal()
end

function TowerSceneDialog:OnBeginDrag(args)
  self._drag = true
  self._controller:MoveCamera(0, 0)
end

function TowerSceneDialog:OnDrag(args)
  if self._drag then
    self._controller:MoveCamera(-args.delta.x / 100, -args.delta.y / 100)
  end
end

function TowerSceneDialog:OnEndDrag(args)
  self._drag = false
  self._controller:MoveCamera(0, 0)
end

function TowerSceneDialog:Freeze()
  self._freezeCount = self._freezeCount + 1
  self:GetRootWindow():SetActive(false)
end

function TowerSceneDialog:Thaw()
  self._freezeCount = math.max(0, self._freezeCount - 1)
  if self._freezeCount == 0 then
    self:GetRootWindow():SetActive(true)
  end
end

function TowerSceneDialog:Pause()
  self._freezeCount = self._freezeCount + 1
end

function TowerSceneDialog:Resume()
  self._freezeCount = math.max(0, self._freezeCount - 1)
  self._resume:SetActive(false)
  self._controller:OnCurrentTileClick()
end

function TowerSceneDialog:OnBackClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(59, nil, function()
    self:Freeze()
    EffectFactory.CreateJumpBackEffect(66):Run()
  end)
end

function TowerSceneDialog:OnResetClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(48, nil, function()
    bm_tower:Reset(bm_tower:GetCurrentTowerID())
    self:Freeze()
  end)
end

return TowerSceneDialog
