-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2chestdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cstairboxshow = (BeanManager.GetTableByName)("dungeonselect.cstairboxshow")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local TowerV2ChestDialog = class("TowerV2ChestDialog", Dialog)
TowerV2ChestDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2ChestDialog.AssetName = "TowerEventBox"
TowerV2ChestDialog.BoxType = {Gold = 5, Normal = 3}
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2ChestDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2ChestDialog
  ((TowerV2ChestDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2ChestDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("TitleBack/Title")
  self._name = self:GetChild("Title")
  self._choose = {
normal = {board = self:GetChild("ChooseNormal"), image = self:GetChild("ChooseNormal/Image"), txt = self:GetChild("ChooseNormal/Txt"), select = self:GetChild("ChooseNormal/Select")}
, 
goblin = {
{board = self:GetChild("Choose1"), image = self:GetChild("Choose1/Image"), txt = self:GetChild("Choose1/Txt"), select = self:GetChild("Choose1/Select")}
, 
{board = self:GetChild("Choose2"), image = self:GetChild("Choose2/Image"), txt = self:GetChild("Choose2/Txt"), select = self:GetChild("Choose2/Select")}
}
}
  for i,v in pairs((self._choose).goblin) do
    do
      (v.board):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCellClick(i)
  end
)
    end
  end
  self._txt = self:GetChild("Text1")
  self._detail = self:GetChild("Text2")
  self._openBtn = self:GetChild("OpenBtn")
  ;
  (self._openBtn):Subscribe_PointerClickEvent(self.OnOpenBtnClicked, self)
  self._back = self:GetChild("BackBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

TowerV2ChestDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._autoTimer then
    (GameTimer.RemoveTask)(self._autoTimer)
  end
end

TowerV2ChestDialog.SetData = function(self, id, index, type, controller)
  -- function num : 0_3 , upvalues : _ENV, cstairboxshow, CImagePath, bm_towerv2
  self._controller = controller
  self._id = id
  self._index = index
  self._type = type
  local normal = type == (self.BoxType).Normal or type == (self.BoxType).Gold
  ;
  (((self._choose).normal).board):SetActive(normal)
  for _,v in pairs((self._choose).goblin) do
    (v.board):SetActive(not normal)
  end
  ;
  (self._txt):SetActive(not normal)
  ;
  (self._detail):SetActive(not normal)
  if not normal then
    self:OnCellClick(1)
    local str = (TextManager.GetText)((cstairboxshow:GetRecorder(3)).title)
    ;
    (self._name):SetText(str)
  else
    if type == (self.BoxType).Normal then
      local recorder = cstairboxshow:GetRecorder(1)
      local imageRecord = CImagePath:GetRecorder(recorder.boximg)
      ;
      (((self._choose).normal).image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (((self._choose).normal).txt):SetText((TextManager.GetText)(recorder.boxName))
      ;
      (self._name):SetText((TextManager.GetText)(recorder.title))
    elseif type == (self.BoxType).Gold then
      local recorder = cstairboxshow:GetRecorder(2)
      local imageRecord = CImagePath:GetRecorder(recorder.boximg)
      ;
      (((self._choose).normal).image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (((self._choose).normal).txt):SetText((TextManager.GetText)(recorder.boxName))
      ;
      (self._name):SetText((TextManager.GetText)(recorder.title))
    end
    if bm_towerv2:IsInAutoExplore() then
      self._autoTimer = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_3_0 , upvalues : self
    self:OnOpenBtnClicked()
  end
)
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

TowerV2ChestDialog.OnOpenBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._freeze then
    return 
  end
  if self._autoTimer then
    (GameTimer.RemoveTask)(self._autoTimer)
  end
  local choice = nil
  if self._selected then
    choice = (((self._choose).goblin)[self._selected]).value
  end
  ;
  ((DialogManager.CreateSingletonDialog)("towerv2.towerv2chestopendialog")):Init({resultType = self._selected, choice = choice, index = self._index, type = self._type, id = self._id})
  self._freeze = true
end

TowerV2ChestDialog.OnCellClick = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  if self._freeze then
    return 
  end
  for i,v in pairs((self._choose).goblin) do
    (v.select):SetActive(i == index)
  end
  self._selected = index
  ;
  (self._txt):SetActive(self._selected == 2)
  ;
  (self._detail):SetActive(self._selected == 2)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

TowerV2ChestDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2chestdialog")
  ;
  (self._controller):OnDialogDestroy(self._index)
end

return TowerV2ChestDialog

