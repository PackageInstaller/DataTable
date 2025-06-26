-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/editheaddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local EditHeadDialog = class("EditHeadDialog", Dialog)
EditHeadDialog.AssetBundleName = "ui/layouts.setting"
EditHeadDialog.AssetName = "SettingPhoto"
EditHeadDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EditHeadDialog
  ((EditHeadDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._selectedHeadPhoto = {id = nil, lock = true}
  self._headPhotoId = nil
  self._selectedHeadFrame = {id = nil, lock = true}
  self._headFrameId = nil
  self._headPhotoList = {}
  self._headFrameList = {}
  self._tag = nil
end

EditHeadDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._cancleBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._headPhoto = self:GetChild("Back/HeadPhoto/Photo")
  self._headFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._headGrey = self:GetChild("Back/HeadPhoto/Grey")
  self._headLock = self:GetChild("Back/HeadPhoto/Lock")
  self._framePanel = self:GetChild("Back/Frame")
  self._photoName = self:GetChild("Back/PhotoName/Name")
  self._photoSource = self:GetChild("Back/PhotoGet/Txt")
  self._headPhotoBtn = self:GetChild("Back/Group/GroupBtn1")
  self._headFrameBtn = self:GetChild("Back/Group/GroupBtn2")
  self._frame = (GridFrame.Create)(self._framePanel, self, true, 5)
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._headPhotoBtn):Subscribe_PointerClickEvent(self.OnHeadPhotoBtnClicked, self)
  ;
  (self._headFrameBtn):Subscribe_PointerClickEvent(self.OnHeadFrameBtnClicked, self)
  self:Init()
end

EditHeadDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

EditHeadDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, HeadPhotoTable, HeadPhotoFrameTable, CImagePathTable
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  for k,v in pairs(userInfo.avatarIds) do
    local list = {}
    list.id = k
    list.lock = v == 0
    ;
    (table.insert)(self._headPhotoList, list)
  end
  ;
  (table.sort)(self._headPhotoList, function(a, b)
    -- function num : 0_3_0 , upvalues : HeadPhotoTable
    local aRecord = HeadPhotoTable:GetRecorder(a.id)
    local bRecord = HeadPhotoTable:GetRecorder(b.id)
    if aRecord.order < bRecord.order then
      return true
    else
      return false
    end
  end
)
  for k,v in pairs(userInfo.frameIds) do
    local list = {}
    list.id = k
    list.lock = v == 0
    list.unlockButVisible = (HeadPhotoFrameTable:GetRecorder(k)).unlockvisibleornot == 1
    if not list.lock or list.unlockButVisible then
      (table.insert)(self._headFrameList, list)
    end
  end
  ;
  (table.sort)(self._headFrameList, function(a, b)
    -- function num : 0_3_1 , upvalues : HeadPhotoFrameTable
    local aRecord = HeadPhotoFrameTable:GetRecorder(a.id)
    local bRecord = HeadPhotoFrameTable:GetRecorder(b.id)
    if aRecord.order < bRecord.order then
      return true
    else
      return false
    end
  end
)
  self._headPhotoId = userInfo.avatarId
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._selectedHeadPhoto).id = self._headPhotoId
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._selectedHeadPhoto).lock = false
  self._headFrameId = userInfo.frameId
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._selectedHeadFrame).id = self._headFrameId
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._selectedHeadFrame).lock = false
  self:OnHeadPhotoBtnClicked()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(self._headPhotoId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(self._headFrameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

EditHeadDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

EditHeadDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._headPhotoId == (self._selectedHeadPhoto).id and self._headFrameId == (self._selectedHeadFrame).id then
    self:Destroy()
  else
    do
      if self._headPhotoId ~= (self._selectedHeadPhoto).id then
        local cchangeuseravatar = (LuaNetManager.CreateProtocol)("protocol.user.cchangeuseravatar")
        if cchangeuseravatar then
          cchangeuseravatar.avatarId = (self._selectedHeadPhoto).id
          cchangeuseravatar:Send()
        end
      end
      if self._headFrameId ~= (self._selectedHeadFrame).id then
        local cchangeuserframe = (LuaNetManager.CreateProtocol)("protocol.user.cchangeuserframe")
        if cchangeuserframe then
          cchangeuserframe.frameId = (self._selectedHeadFrame).id
          cchangeuserframe:Send()
        end
      end
    end
  end
end

EditHeadDialog.OnHeadPhotoBtnClicked = function(self)
  -- function num : 0_6 , upvalues : HeadPhotoTable, HeadPhotoFrameTable, _ENV, CImagePathTable
  (self._headPhotoBtn):SetSelected(true)
  ;
  (self._headFrameBtn):SetSelected(false)
  ;
  (self._headGrey):SetActive(false)
  ;
  (self._headLock):SetActive(false)
  ;
  (self._confirmBtn):SetInteractable(not (self._selectedHeadPhoto).lock)
  local headPhotoRecord = HeadPhotoTable:GetRecorder((self._selectedHeadPhoto).id)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((self._selectedHeadFrame).id)
  ;
  (self._photoName):SetText((TextManager.GetText)(headPhotoRecord.nameTextID))
  ;
  (self._photoSource):SetText((TextManager.GetText)(headPhotoRecord.descriptionTextID))
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._tag = "HeadPhoto"
  ;
  (self._frame):ReloadAllCell()
end

EditHeadDialog.OnHeadFrameBtnClicked = function(self)
  -- function num : 0_7 , upvalues : HeadPhotoTable, HeadPhotoFrameTable, _ENV, CImagePathTable
  (self._headPhotoBtn):SetSelected(false)
  ;
  (self._headFrameBtn):SetSelected(true)
  ;
  (self._headGrey):SetActive(false)
  ;
  (self._headLock):SetActive(false)
  ;
  (self._confirmBtn):SetInteractable(not (self._selectedHeadFrame).lock)
  local headPhotoRecord = HeadPhotoTable:GetRecorder((self._selectedHeadPhoto).id)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((self._selectedHeadFrame).id)
  ;
  (self._photoName):SetText((TextManager.GetText)(headPhotoFrameRecord.nameTextID))
  ;
  (self._photoSource):SetText((TextManager.GetText)(headPhotoFrameRecord.descriptionTextID))
  self._tag = "HeadFrame"
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._frame):ReloadAllCell()
end

EditHeadDialog.SetSelectedId = function(self, data)
  -- function num : 0_8 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
  (self._headGrey):SetActive(true)
  ;
  (self._headLock):SetActive(true)
  if self._tag == "HeadPhoto" then
    local headPhotoRecord = HeadPhotoTable:GetRecorder(data.id)
    if not data.lock then
      self._selectedHeadPhoto = data
      ;
      (self._headGrey):SetActive(false)
      ;
      (self._headLock):SetActive(false)
    end
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._photoName):SetText((TextManager.GetText)(headPhotoRecord.nameTextID))
    ;
    (self._photoSource):SetText((TextManager.GetText)(headPhotoRecord.descriptionTextID))
  end
  do
    if self._tag == "HeadFrame" then
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.id)
      if not data.lock then
        self._selectedHeadFrame = data
        ;
        (self._headGrey):SetActive(false)
        ;
        (self._headLock):SetActive(false)
      end
      if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
        do
          imageRecord = DataCommon.DefaultImageAsset
          ;
          (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          ;
          (self._photoName):SetText((TextManager.GetText)(headPhotoFrameRecord.nameTextID))
          ;
          (self._photoSource):SetText((TextManager.GetText)(headPhotoFrameRecord.descriptionTextID))
          ;
          (self._confirmBtn):SetInteractable(not data.lock)
          ;
          (self._frame):FireEvent("ChangedSelected", data)
        end
      end
    end
  end
end

EditHeadDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if self._tag == "HeadPhoto" then
    return #self._headPhotoList
  end
  if self._tag == "HeadFrame" then
    return #self._headFrameList
  end
end

EditHeadDialog.CellAtIndex = function(self, frame)
  -- function num : 0_10
  return "systemsetting.headphotocell"
end

EditHeadDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if self._tag == "HeadPhoto" then
    return (self._headPhotoList)[index]
  end
  if self._tag == "HeadFrame" then
    return (self._headFrameList)[index]
  end
end

return EditHeadDialog

