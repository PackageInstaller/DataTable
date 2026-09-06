local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local CNodeHandBookCfg = BeanManager.GetTableByName("handbook.cnodeconfig_handbook")
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CHankBookNavigation = BeanManager.GetTableByName("handbook.chankbooknavigation")
local RelationRegion3Dialog = class("RelationRegion3Dialog", Dialog)
RelationRegion3Dialog.AssetBundleName = "ui/layouts.tujiannew"
RelationRegion3Dialog.AssetName = "RelationRegion3"

function RelationRegion3Dialog:Ctor(...)
  RelationRegion3Dialog.super.Ctor(self, ...)
  self._cameraState = nil
  self.currentGroupId = nil
  self._groupName = "Modal"
  self._toNext = false
  self._handBookSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.HandBook)
  self._deleget = nil
end

function RelationRegion3Dialog:OnCreate()
  self._teamBtn1 = self:GetChild("TeamBtn1")
  self._teamBtn2 = self:GetChild("TeamBtn2")
  self._teamBtn3 = self:GetChild("TeamBtn3")
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._teamBtn1:Subscribe_PointerClickEvent(function()
    self:OnBtnClicked(1)
  end, self)
  self._teamBtn2:Subscribe_PointerClickEvent(function()
    self:OnBtnClicked(2)
  end, self)
  self._teamBtn3:Subscribe_PointerClickEvent(function()
    self:OnBtnClicked(3)
  end, self)
  self._toggle_0 = self:GetChild("ToggleGroup/_Toggle_0")
  self._toggle_1 = self:GetChild("ToggleGroup/_Toggle_1")
  self._toggle_0:SetIsOnType(true)
  self._toggle_1:SetIsOnType(false)
  self._toggle_0:Subscribe_PointerClickEvent(function()
    self._toggle_0:SetIsOnType(true)
  end, self)
  self._toggle_1:Subscribe_PointerClickEvent(function()
    self._toggle_1:SetIsOnType(false)
    self:ToBookList()
  end, self)
  self._animatorObj = self:GetRootWindow()._uiObject
  self._animator = AnimatorStaticFunctions.Get(self._animatorObj)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function RelationRegion3Dialog:OnDestroy()
  self._deleget:OnEnable()
  self._handBookSceneController:SetCameraAnimatorState(0)
end

function RelationRegion3Dialog:Init(deleget, dialogIndex)
  self._deleget = deleget
  self._dialogIndex = dialogIndex
end

function RelationRegion3Dialog:OnBtnClicked(index)
  local allId = CHankBookNavigation:GetAllIds()
  for i, v in ipairs(allId) do
    local record = CHankBookNavigation:GetRecorder(i)
    if record.regionBtn == self._dialogIndex and record.teamBtn == index then
      self._cameraState = record.camParam
      self.currentGroupId = record.groupID
      break
    end
  end
  self._toNext = true
  self._animator:SetInteger("state", 0)
  self._handBookSceneController:SetCameraAnimatorState(self._cameraState)
  self._handBookSceneController:SetGroupAnimatorStateById(self.currentGroupId, 1)
end

function RelationRegion3Dialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "RelationMainHide" and self._toNext then
    self._toNext = false
    if self._cameraState then
      local dialog = DialogManager.CreateSingletonDialog("handbook.relationteamdialog")
      dialog:Init(self, self.currentGroupId)
      self._cameraState = nil
      self.currentGroupId = nil
    end
  end
end

function RelationRegion3Dialog:OnEnable()
  self._animator:SetInteger("state", 1)
end

function RelationRegion3Dialog:ToBookList()
  self._deleget:ToBookList()
  self:Destroy()
end

function RelationRegion3Dialog:OnBackBtnClicked()
  self:Destroy()
end

return RelationRegion3Dialog
