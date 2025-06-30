-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerchestdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CBoxShow = (BeanManager.GetTableByName)("dungeonselect.cboxshow")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local TowerChestDialog = class("TowerEventBoxTips", Dialog)
TowerChestDialog.AssetBundleName = "ui/layouts.mainline"
TowerChestDialog.AssetName = "TowerEventBox"
TowerChestDialog.BoxType = {Gold = 5, Normal = 3}
TowerChestDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerChestDialog
  ((TowerChestDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerChestDialog.OnCreate = function(self)
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

TowerChestDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TowerChestDialog.SetData = function(self, index, type, choices)
  -- function num : 0_3 , upvalues : _ENV, CBoxShow, CImagePath
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
    local str = (TextManager.GetText)((CBoxShow:GetRecorder(3)).title)
    ;
    (self._name):SetText(str)
  elseif type == (self.BoxType).Normal then
    local recorder = CBoxShow:GetRecorder(1)
    local imageRecord = CImagePath:GetRecorder(recorder.boximg)
    ;
    (((self._choose).normal).image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (((self._choose).normal).txt):SetText((TextManager.GetText)(recorder.boxName))
    ;
    (self._name):SetText((TextManager.GetText)(recorder.title))
  elseif type == (self.BoxType).Gold then
    local recorder = CBoxShow:GetRecorder(2)
    local imageRecord = CImagePath:GetRecorder(recorder.boximg)
    ;
    (((self._choose).normal).image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (((self._choose).normal).txt):SetText((TextManager.GetText)(recorder.boxName))
    ;
    (self._name):SetText((TextManager.GetText)(recorder.title))
  end
  if choices then
    for i,v in ipairs(choices) do
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R10 in 'UnsetPending'

      (((self._choose).goblin)[i]).value = v
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

TowerChestDialog.OnOpenBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._freeze then
    return 
  end
  local choice = nil
  if self._selected then
    choice = (((self._choose).goblin)[self._selected]).value
  end
  ;
  ((DialogManager.CreateSingletonDialog)("tower.towerchestopendialog")):Init({resultType = self._selected, choice = choice, index = self._index, type = self._type})
  self._freeze = true
end

TowerChestDialog.OnCellClick = function(self, index)
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
  if self._selected == 2 then
    local base = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1178)).msgTextID)
    local strs = {}
    local cgoblinchestconfig = (BeanManager.GetTableByName)("dungeonselect.cgoblinchestconfig")
    for _,i in ipairs(cgoblinchestconfig:GetAllIds()) do
      local recorder = cgoblinchestconfig:GetRecorder(i)
      local str = base:gsub("%$parameter(%d)%$", {["1"] = recorder.weight, ["2"] = (TextManager.GetText)(recorder.describeTextID)})
      strs[#strs + 1] = str
    end
    local str = (table.concat)(strs, "\n")
    ;
    (self._detail):SetText(str)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

TowerChestDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towerchestdialog")
end

return TowerChestDialog

