local MonsterBookCell = class("MonsterBookCell", Dialog)
MonsterBookCell.AssetBundleName = "ui/layouts.tujian"
MonsterBookCell.AssetName = "MonsterBookCell"
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

function MonsterBookCell:Ctor(...)
  MonsterBookCell.super.Ctor(self, ...)
end

function MonsterBookCell:OnCreate()
  self._normal = self:GetChild("Normal")
  self._normalBack = self:GetChild("Normal/Back")
  self._icon = self:GetChild("Normal/Monster")
  self._select = self:GetChild("Select")
  self._lock = self:GetChild("Lock")
  self._lockMonsterIcon = self:GetChild("Lock/Monster_black")
  self._num = self:GetChild("Num")
  self._normal:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetChild("Lock/Back"):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MonsterBookCell:OnDestroy()
end

function MonsterBookCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(data.miniIcon)
  if data.forceUnlock or NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(data.id, HandBookTypeEnum.MONSTER) then
    self._lock:SetActive(false)
    self._normal:SetActive(true)
    if imageRecord then
      self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  else
    self._lock:SetActive(true)
    self._normal:SetActive(false)
    if imageRecord then
      self._lockMonsterIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
  self._num:SetText(data.monsterNumber)
  self._select:SetActive(self._delegate._selectId == data.id)
  self._normalBack:SetActive(self._delegate._selectId ~= data.id)
end

function MonsterBookCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self._delegate:OnSelectMonster(self._cellData)
end

function MonsterBookCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseMonster" then
    if self._cellData.id == arg then
      self._select:SetActive(true)
      self._normalBack:SetActive(false)
    else
      self._select:SetActive(false)
      self._normalBack:SetActive(true)
    end
  end
end

return MonsterBookCell
