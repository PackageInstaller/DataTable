local CCardRoleConfig_HandBook = BeanManager.GetTableByName("handbook.ccardroleconfig_handbook")
local BookListCharCell = class("BookListCharCell", Dialog)
BookListCharCell.AssetBundleName = "ui/layouts.tujiannew"
BookListCharCell.AssetName = "BookListCharCell"
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

function BookListCharCell:Ctor(...)
  BookListCharCell.super.Ctor(self, ...)
  self._lock = true
  self._id = nil
end

function BookListCharCell:OnCreate()
  self._jobIcon = self:GetChild("Cell/Job")
  self._rankIcon = self:GetChild("Cell/Rank")
  self._rankIconBack = self:GetChild("Cell/RankBack")
  self._photo = self:GetChild("Cell/Photo")
  self._frame = self:GetChild("Cell/Frame")
  self._lockIcon = self:GetChild("Cell/Lock")
  self._element = self:GetChild("Cell/Element")
  self._handbookNumber = self:GetChild("Cell/SortText")
  self._rankIcon:SetActive(false)
  self._rankIconBack:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BookListCharCell:OnDestroy()
end

function BookListCharCell:RefreshCell(data)
  local handbookNumber = CCardRoleConfig_HandBook:GetRecorder(data:GetId()).sortText
  self._handbookNumber:SetText(handbookNumber)
  local spriteRecord = data:GetVocationImageRecord()
  self._jobIcon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetSmallRarityFrameRecord()
  self._frame:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetElementImageRecord()
  self._element:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._id = data:GetId()
  self._lock = not NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(self._id)
  self._lockIcon:SetActive(self._lock)
end

function BookListCharCell:OnCellClicked()
  if self._lock then
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("handbook.roledetailinfodialog")
  if dialog then
    dialog:Refresh(self._id)
  end
end

return BookListCharCell
