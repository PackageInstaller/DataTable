-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/rolebooknewdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local UIManager = ((CS.PixelNeko).UI).UIManager
local CNodeHandBookCfg = (BeanManager.GetTableByName)("handbook.cnodeconfig_handbook")
local CCardRoleBookCfg = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CNpcHandBookCfg = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local RoleBookNewDialog = class("RoleBookNewDialog", Dialog)
RoleBookNewDialog.AssetBundleName = "ui/layouts.tujiannew"
RoleBookNewDialog.AssetName = "RelationMain"
local DialogConfig = {"handbook.relationregion1dialog", "handbook.relationregion2dialog", "handbook.relationregion3dialog", "handbook.relationregion4dialog", "handbook.relationregion5dialog"}
RoleBookNewDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleBookNewDialog, _ENV
  ((RoleBookNewDialog.super).Ctor)(self, ...)
  self._baseSceneController = nil
  self._handBookSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).HandBook)
  self._dialogIndex = 0
  self._dialogIndexLast = self._dialogIndex
  self._raycastHits = nil
  self._toNext = false
end

RoleBookNewDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, AnimatorStaticFunctions, PhysicsStaticFunctions
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
  self._regionBtn1 = self:GetChild("RegionBtn1")
  self._regionBtn2 = self:GetChild("RegionBtn2")
  self._regionBtn3 = self:GetChild("RegionBtn3")
  self._regionBtn4 = self:GetChild("RegionBtn4")
  self._regionBtn5 = self:GetChild("RegionBtn5")
  ;
  (self._regionBtn1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self
    self:OnBtnClicked(1)
  end
, self)
  ;
  (self._regionBtn2):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self
    self:OnBtnClicked(2)
  end
, self)
  ;
  (self._regionBtn3):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_4 , upvalues : self
    self:OnBtnClicked(3)
  end
, self)
  ;
  (self._regionBtn4):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_5 , upvalues : self
    self:OnBtnClicked(4)
  end
, self)
  ;
  (self._regionBtn5):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_6 , upvalues : self
    self:OnBtnClicked(5)
  end
, self)
  self._baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  self._handBookSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).HandBook)
  ;
  (SceneManager.SetSceneActive)(self._handBookSceneController)
  ;
  (self._baseSceneController):SetRootGameObjectActive(false)
  ;
  (self._handBookSceneController):SetUnLockNode()
  ;
  (self._handBookSceneController):SetRootGameObjectActive(true)
  ;
  (UIBackManager.SetUIBackShow)(false)
  self._animatorObj = (self._rootWindow)._uiObject
  self._animator = (AnimatorStaticFunctions.Get)(self._animatorObj)
  ;
  (self._rootWindow):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  self._raycastHits = (PhysicsStaticFunctions.CreateRaycastHits)(1)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackClicked, self)
end

RoleBookNewDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (SceneManager.SetSceneActive)(self._baseSceneController)
  ;
  (self._baseSceneController):SetRootGameObjectActive(true)
  ;
  (self._handBookSceneController):SetRootGameObjectActive(false)
end

RoleBookNewDialog.OnBtnClicked = function(self, index)
  -- function num : 0_3 , upvalues : DialogConfig
  if DialogConfig[index] then
    self._dialogIndex = index
    self._toNext = true
    ;
    (self._animator):SetInteger("state", 0)
    ;
    (self._handBookSceneController):SetCameraAnimatorState(1)
    ;
    (self._handBookSceneController):PlayBackgroundTimeline(index)
  end
end

RoleBookNewDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : DialogConfig, _ENV
  if stateName == "RelationMainHide" and self._toNext then
    self._toNext = false
    if DialogConfig[self._dialogIndex] then
      ((DialogManager.CreateSingletonDialog)(DialogConfig[self._dialogIndex])):Init(self, self._dialogIndex)
      self._dialogIndexLast = self._dialogIndex
      self._dialogIndex = 0
    end
  end
end

RoleBookNewDialog.OnBackClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager, PhysicsStaticFunctions, _ENV, SceneObjectClick, CNpcHandBookCfg
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
        ((DialogManager.CreateSingletonDialog)("handbook.roledetailinfodialog")):Refresh(roleid, sceneObjectClick.IntData)
      else
        if sceneObjectClick.StringData == "RoleUnLock" then
          ((DialogManager.CreateSingletonDialog)("handbook.roledetailinfodialog")):Refresh(roleid)
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
            ((DialogManager.CreateSingletonDialog)("handbook.roledetailinfodialog")):Refresh(sceneObjectClick.IntData2, npcid)
          else
            ;
            ((DialogManager.CreateSingletonDialog)("handbook.npcdetailinfodialog")):Refresh(npcid)
          end
        end
      end
    end
  end
end

RoleBookNewDialog.OnEnable = function(self)
  -- function num : 0_6
  (self._animator):SetInteger("state", 1)
  ;
  (self._handBookSceneController):PlayBackgroundToMainTimeline(self._dialogIndexLast)
  self._dialogIndexLast = 0
  ;
  (self._handBookSceneController):SetCameraAnimatorState(0)
end

RoleBookNewDialog.ToBookList = function(self)
  -- function num : 0_7
  (self._delegate):SetRoleList(true)
  ;
  (self._delegate):SetPage(4)
end

return RoleBookNewDialog

