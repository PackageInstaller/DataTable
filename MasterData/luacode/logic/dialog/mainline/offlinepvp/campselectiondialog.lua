local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CampSelectionDialog = class("CampSelectionDialog", Dialog)
CampSelectionDialog.AssetBundleName = "ui/layouts.offlinepvp"
CampSelectionDialog.AssetName = "OffLinePVPChoose"

function CampSelectionDialog:Ctor(...)
  CampSelectionDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function CampSelectionDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._Cell1 = {
    back = self:GetChild("Cell1/Back"),
    photo = self:GetChild("Cell1/Photo"),
    model = self:GetChild("Cell1/Model"),
    name = self:GetChild("Cell1/Name"),
    chooseBtn = self:GetChild("Cell1/ChooseBtn")
  }
  self._Cell2 = {
    back = self:GetChild("Cell2/Back"),
    photo = self:GetChild("Cell2/Photo"),
    model = self:GetChild("Cell2/Model"),
    name = self:GetChild("Cell2/Name"),
    chooseBtn = self:GetChild("Cell2/ChooseBtn")
  }
  self._rePlayBtn = self:GetChild("ChangeBtn")
  self._Cell1.chooseBtn:Subscribe_PointerClickEvent(function()
    self:OnChooseBtnClicked(1)
  end, self)
  self._Cell2.chooseBtn:Subscribe_PointerClickEvent(function()
    self:OnChooseBtnClicked(2)
  end, self)
  self._rePlayBtn:Subscribe_PointerClickEvent(self.OnRePlayBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

function CampSelectionDialog:OnDestroy()
end

function CampSelectionDialog:Init(id)
  self._id = id
  local recorder = CArenaSeasonConfig:GetRecorder(id)
  self._nameList = {
    TextManager.GetText(recorder.factionName1),
    TextManager.GetText(recorder.factionName2)
  }
  self._Cell1.name:SetText(self._nameList[1])
  self._Cell2.name:SetText(self._nameList[2])
  local npcShapeRecorder = CNPCShape:GetRecorder(recorder.factionShape1)
  local imageRecord = cImagePathTable:GetRecorder(npcShapeRecorder.DiamondHeadID)
  self._Cell1.photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  npcShapeRecorder = CNPCShape:GetRecorder(recorder.factionShape2)
  imageRecord = cImagePathTable:GetRecorder(npcShapeRecorder.DiamondHeadID)
  self._Cell2.photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function CampSelectionDialog:OnChooseBtnClicked(index)
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(85, {
    self._nameList[index]
  }, function()
    local protocol = LuaNetManager.CreateProtocol("protocol.battle.ccomfirecamp")
    if protocol then
      protocol.camp = index
      protocol:Send()
    end
  end)
end

function CampSelectionDialog:OnRePlayBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  if dialog then
    local dialogId = CArenaSeasonConfig:GetRecorder(self._id).startDialog
    dialog:SetDialogLibraryId(dialogId, true, dialog.DialogType.Arena)
  end
end

function CampSelectionDialog:OnBackBtnClicked()
  self:Destroy()
end

function CampSelectionDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return CampSelectionDialog
