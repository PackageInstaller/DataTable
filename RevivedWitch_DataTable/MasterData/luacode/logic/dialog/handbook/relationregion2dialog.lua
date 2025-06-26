-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/relationregion2dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local CNodeHandBookCfg = (BeanManager.GetTableByName)("handbook.cnodeconfig_handbook")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CHankBookNavigation = (BeanManager.GetTableByName)("handbook.chankbooknavigation")
local RelationRegion2Dialog = class("RelationRegion2Dialog", Dialog)
RelationRegion2Dialog.AssetBundleName = "ui/layouts.tujiannew"
RelationRegion2Dialog.AssetName = "RelationRegion2"
RelationRegion2Dialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RelationRegion2Dialog, _ENV
  ((RelationRegion2Dialog.super).Ctor)(self, ...)
  self._cameraState = nil
  self.currentGroupId = nil
  self._groupName = "Modal"
  self._toNext = false
  self._handBookSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).HandBook)
  self._deleget = nil
end

RelationRegion2Dialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : AnimatorStaticFunctions
  self._teamBtn1 = self:GetChild("TeamBtn1")
  self._teamBtn2 = self:GetChild("TeamBtn2")
  self._teamBtn3 = self:GetChild("TeamBtn3")
  self._teamBtn4 = self:GetChild("TeamBtn4")
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._teamBtn1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnBtnClicked(1)
  end
, self)
  ;
  (self._teamBtn2):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnBtnClicked(2)
  end
, self)
  ;
  (self._teamBtn3):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self
    self:OnBtnClicked(3)
  end
, self)
  ;
  (self._teamBtn4):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self
    self:OnBtnClicked(4)
  end
, self)
  self._toggle_0 = self:GetChild("ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("ToggleGroup/_Toggle_1")
  ;
  (self._toggle_0):SetIsOnType(true)
  ;
  (self._toggle_1):SetIsOnType(false)
  ;
  (self._toggle_0):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_4 , upvalues : self
    (self._toggle_0):SetIsOnType(true)
  end
, self)
  ;
  (self._toggle_1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_5 , upvalues : self
    (self._toggle_1):SetIsOnType(false)
    self:ToBookList()
  end
, self)
  self._animatorObj = (self:GetRootWindow())._uiObject
  self._animator = (AnimatorStaticFunctions.Get)(self._animatorObj)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

RelationRegion2Dialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._deleget):OnEnable()
  ;
  (self._handBookSceneController):SetCameraAnimatorState(0)
end

RelationRegion2Dialog.Init = function(self, deleget, dialogIndex)
  -- function num : 0_3
  self._deleget = deleget
  self._dialogIndex = dialogIndex
end

RelationRegion2Dialog.OnBtnClicked = function(self, index)
  -- function num : 0_4 , upvalues : CHankBookNavigation, _ENV
  local allId = CHankBookNavigation:GetAllIds()
  for i,v in ipairs(allId) do
    local record = CHankBookNavigation:GetRecorder(i)
    if record.regionBtn == self._dialogIndex and record.teamBtn == index then
      self._cameraState = record.camParam
      self.currentGroupId = record.groupID
      break
    end
  end
  do
    self._toNext = true
    ;
    (self._animator):SetInteger("state", 0)
    ;
    (self._handBookSceneController):SetCameraAnimatorState(self._cameraState)
    ;
    (self._handBookSceneController):SetGroupAnimatorStateById(self.currentGroupId, 1)
  end
end

RelationRegion2Dialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_5 , upvalues : _ENV
  if stateName == "RelationMainHide" and self._toNext then
    self._toNext = false
    if self._cameraState then
      local dialog = (DialogManager.CreateSingletonDialog)("handbook.relationteamdialog")
      dialog:Init(self, self.currentGroupId)
      self._cameraState = nil
      self.currentGroupId = nil
    end
  end
end

RelationRegion2Dialog.OnEnable = function(self)
  -- function num : 0_6
  (self._animator):SetInteger("state", 1)
end

RelationRegion2Dialog.ToBookList = function(self)
  -- function num : 0_7
  (self._deleget):ToBookList()
  self:Destroy()
end

RelationRegion2Dialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return RelationRegion2Dialog

