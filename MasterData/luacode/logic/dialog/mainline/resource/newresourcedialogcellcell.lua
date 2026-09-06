local TypeInfoTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeontype")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local NewResourceDialogCellCell = class("NewResourceDialogCellCell", Dialog)
NewResourceDialogCellCell.AssetBundleName = "ui/layouts.mainline"
NewResourceDialogCellCell.AssetName = "ResourceDungeonWorldCell"

function NewResourceDialogCellCell:Ctor(...)
  NewResourceDialogCellCell.super.Ctor(self, ...)
end

function NewResourceDialogCellCell:OnCreate()
  self._whole = self:GetChild("Frame")
  self._back = self:GetChild("Frame/Back")
  self._lockImg = self:GetChild("Frame/Lock")
  self._notOpen = self:GetChild("Frame/Txt1")
  self._openTime = self:GetChild("Frame/Time")
  self._img = self:GetChild("Frame/Map")
  self._name = self:GetChild("Frame/Title")
  self._grey = self:GetChild("Frame/Grey")
  self._conditionLabel = self:GetChild("Frame/Txt2")
  self._conditionTxt = self:GetChild("Frame/Txt3")
  self._new = self:GetChild("Frame/New")
  self._notOpen:SetText(NekoData.BehaviorManager.BM_Message:GetString(1052))
  self._back:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function NewResourceDialogCellCell:OnDestroy()
end

local function SetActive(self, f1, f2, f3, f4, f5, f6, f7, f8, f9)
  self._lockImg:SetActive(f1)
  self._notOpen:SetActive(f2)
  self._name:SetActive(f4)
  self._grey:SetActive(f5)
  self._conditionLabel:SetActive(f6)
  self._conditionTxt:SetActive(f7)
  self._new:SetActive(f8)
end

local function GetLocalTipsInfo(self)
  for k, value in pairs(DataCommon.LocalTips) do
    if value.typeId and value.typeId == self._data.id then
      return value
    end
  end
end

function NewResourceDialogCellCell:RefreshCell(data)
  self._data = data
  local data = data
  local record = TypeInfoTable:GetRecorder(data.id)
  self._record = record
  self._whole:SetActive(true)
  if data.lock then
    SetActive(self, true, false, true, true, true, true, true, false, false)
    self._conditionTxt:SetText(TextManager.GetText(record.unlockConditionDescTextID))
  elseif not data.open then
    SetActive(self, false, true, false, true, true, false, false, false, false)
  else
    local new, clear = false, false
    if data.clearAll then
      clear = true
    else
      new = true
    end
    local showNew = false
    local localTipsInfo = GetLocalTipsInfo(self)
    if localTipsInfo then
      showNew = NekoData.BehaviorManager.BM_Game:ShowLocalTips(localTipsInfo)
    end
    SetActive(self, false, false, true, true, false, false, false, showNew, clear)
  end
  local image = ImageTable:GetRecorder(record.image)
  if image then
    self._img:SetSprite(image.assetBundle, image.assetName)
  end
  self._name:SetText(TextManager.GetText(record.nameTextID))
  local strId
  if record.startCondition == 3 then
    strId = 1049
  elseif record.startCondition == 4 then
    strId = 1050
  elseif record.startCondition == 5 then
    strId = 1051
  end
  if strId then
    self._openTime:SetText(NekoData.BehaviorManager.BM_Message:GetString(strId))
  else
    LogErrorFormat("NewResourceDialogCellCell", "There is no corresponding strId by typeId：%s", data.id)
  end
end

function NewResourceDialogCellCell:OnCellClicked(args, window, fromItemTipsJump)
  if self._data.lock then
    NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(self._record.unlockConditionDescTextID))
  elseif not self._data.open then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100404)
  else
    DialogManager.CreateSingletonDialog("mainline.resource.resourcefloordialog"):SetData(self._data, fromItemTipsJump)
    local localTipsInfo = GetLocalTipsInfo(self)
    if localTipsInfo then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(localTipsInfo)
      self._new:SetActive(false)
    end
  end
end

return NewResourceDialogCellCell
