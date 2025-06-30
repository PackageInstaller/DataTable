-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/relationteamdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local CNodeHandBookCfg = (BeanManager.GetTableByName)("handbook.cnodeconfig_handbook")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CNpcHandBookCfg = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local RelationTeamDialog = class("RelationTeamDialog", Dialog)
RelationTeamDialog.AssetBundleName = "ui/layouts.tujiannew"
RelationTeamDialog.AssetName = "RelationTeam"
RelationTeamDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RelationTeamDialog, _ENV
  ((RelationTeamDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._raycastHits = nil
  self._deleget = nil
  self.currentGroupId = nil
  self._handBookSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).HandBook)
end

RelationTeamDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : PhysicsStaticFunctions
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._toggle_0 = self:GetChild("ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("ToggleGroup/_Toggle_1")
  ;
  (self._toggle_0):SetIsOnType(true)
  ;
  (self._toggle_1):SetIsOnType(false)
  ;
  (self._toggle_0):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    (self._toggle_0):SetIsOnType(true)
  end
, self)
  ;
  (self._toggle_1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    (self._toggle_1):SetIsOnType(false)
    self:ToBookList()
  end
, self)
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackClicked, self)
end

RelationTeamDialog.Init = function(self, deleget, currentGroupId)
  -- function num : 0_2
  self._deleget = deleget
  self.currentGroupId = currentGroupId
end

RelationTeamDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._deleget):OnEnable()
  ;
  (self._handBookSceneController):SetCameraAnimatorState(1)
  ;
  (self._handBookSceneController):SetGroupAnimatorStateById(self.currentGroupId, 0)
end

RelationTeamDialog.OnBackClicked = function(self, args)
  -- function num : 0_4 , upvalues : UIManager, PhysicsStaticFunctions, _ENV, SceneObjectClick, CNpcHandBookCfg
  local position = args.position
  local camera = (self._handBookSceneController):GetCamera()
  local outputViewPos = (UIManager.ScreenToViewportPointInMargin)("HandBook", position.x, position.y, position.z)
  local ray = (camera:ViewportPointToRay(outputViewPos))
  local count = nil
  self._raycastHits = (PhysicsStaticFunctions.RaycastNonAlloc)(ray, self._raycastHits, 1000000, Layers.SceneObjectClickLayerID)
  if count == 0 then
    return 
  end
  local raycastHit = (self._raycastHits)[0]
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)((raycastHit.collider).gameObject)
  if sceneObjectClick == nil then
    return 
  end
  if sceneObjectClick.StringData == "Lock" then
    return 
  end
  if sceneObjectClick.IntData ~= 0 then
    local roleid = (CNpcHandBookCfg:GetRecorder(sceneObjectClick.IntData)).roleID
    if sceneObjectClick.StringData == "NpcUnLock" then
      ((DialogManager.CreateSingletonDialog)("handbook.npcdetailinfodialog")):Refresh(sceneObjectClick.IntData)
    else
      if sceneObjectClick.StringData == "AllUnLock" then
        ((DialogManager.CreateSingletonDialog)("handbook.handbooksceneroledetailinfodialog")):Refresh(roleid, sceneObjectClick.IntData)
      else
        if sceneObjectClick.StringData == "RoleUnLock" then
          ((DialogManager.CreateSingletonDialog)("handbook.handbooksceneroledetailinfodialog")):Refresh(roleid)
        end
      end
    end
  else
    do
      if sceneObjectClick.IntData2 ~= 0 then
        local npcid = nil
        for k,v in ipairs(CNpcHandBookCfg:GetAllIds()) do
          local recoder = CNpcHandBookCfg:GetRecorder(v)
          if recoder.roleID == sceneObjectClick.IntData2 then
            npcid = v
          end
        end
        do
          if sceneObjectClick.StringData == "AllUnLock" or sceneObjectClick.StringData == "RoleUnLock" then
            ((DialogManager.CreateSingletonDialog)("handbook.handbooksceneroledetailinfodialog")):Refresh(sceneObjectClick.IntData2, npcid)
          else
            ;
            ((DialogManager.CreateSingletonDialog)("handbook.npcdetailinfodialog")):Refresh(npcid)
          end
        end
      end
    end
  end
end

RelationTeamDialog.ToBookList = function(self)
  -- function num : 0_5
  (self._deleget):ToBookList()
  self:Destroy()
end

RelationTeamDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return RelationTeamDialog

