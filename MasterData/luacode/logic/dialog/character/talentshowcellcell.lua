local CAttrEffectIDName = BeanManager.GetTableByName("role.cattreffectidname")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TalentShowCellCell = class("TalentShowCellCell", Dialog)
TalentShowCellCell.AssetBundleName = "ui/layouts.basecharacterinfo"
TalentShowCellCell.AssetName = "BaseCharacterInfoTalentCellSmall"
TalentShowCellCell.cellState = {
  unlock = 1,
  canunlock = 2,
  lock = 3
}
TalentShowCellCell.Type = {property = 1, skill = 2}

function TalentShowCellCell:Ctor(...)
  TalentShowCellCell.super.Ctor(self, ...)
  self._state = TalentShowCellCell.cellState.lock
end

function TalentShowCellCell:OnCreate()
  self._btn = self:GetChild("Btn")
  self._text = self:GetChild("Btn/Text")
  self._btn:Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

function TalentShowCellCell:OnDestroy()
end

function TalentShowCellCell:RefreshCell(data)
  if data.lock then
    if data.can then
      self._state = TalentShowCellCell.cellState.canunlock
    else
      self._state = TalentShowCellCell.cellState.lock
    end
  else
    self._state = TalentShowCellCell.cellState.unlock
  end
  self._record = data.record
  self._pos = data.pos
  self._roleKey = data.roleKey
  local str = ""
  local image
  if data.record.type == TalentShowCellCell.Type.property then
    image = CImagePathTable:GetRecorder(10493)
    local r = CAttrEffectIDName:GetRecorder(data.record.parameter1)
    if r then
      str = TextManager.GetText(CStringres:GetRecorder(1079).msgTextID)
      str = TextManager.GetText(r.classnameTextID) .. string.gsub(str, "%$parameter1%$", tostring(data.record.parameter2))
    else
      LogErrorFormat("TalentShowCellCell", "wrong id %d for table cattreffectidname", data.record.parameter1)
    end
  elseif data.record.type == TalentShowCellCell.Type.skill then
    image = CImagePathTable:GetRecorder(10494)
    str = TextManager.GetText(CStringres:GetRecorder(1093).msgTextID)
  end
  if image then
    self._btn:SetSprite(image.assetBundle, image.assetName)
  end
  self._text:SetText(str)
end

function TalentShowCellCell:OnBtnClicked()
  local dialog
  if self._state == TalentShowCellCell.cellState.unlock then
    dialog = DialogManager.CreateSingletonDialog("character.charactertalentunlockdialog")
  elseif self._state == TalentShowCellCell.cellState.lock then
    dialog = DialogManager.CreateSingletonDialog("character.charactertalentlockdialog")
  elseif self._state == TalentShowCellCell.cellState.canunlock then
    dialog = DialogManager.CreateSingletonDialog("character.charactertalentcanunlockdialog")
  end
  if dialog then
    dialog:SetData({
      record = self._record,
      pos = self._pos,
      roleKey = self._roleKey,
      state = self._state
    })
  end
end

return TalentShowCellCell
