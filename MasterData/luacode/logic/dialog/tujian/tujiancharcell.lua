local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local TuJianCharCell = class("TuJianCharCell", Dialog)
TuJianCharCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharCell.AssetName = "TuJianCharCell"

function TuJianCharCell:Ctor(...)
  TuJianCharCell.super.Ctor(self, ...)
end

function TuJianCharCell:OnCreate()
  self._unlockedBack = self:GetChild("BackUnLocked")
  self._lockedBack = self:GetChild("BackLocked")
  self._photo = self:GetChild("Mask/Photo")
  self._rank = self:GetChild("Rank")
  self._job = self:GetChild("Job")
  self._title = self:GetChild("Title")
  self._name = self:GetChild("Name")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function TuJianCharCell:OnDestroy()
end

function TuJianCharCell:RefreshCell(data)
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  local record = CImagePathTable:GetRecorder(CNpcShapeTable:GetRecorder(roleConfig.shapeID).bustID) or DataCommon.DefaultImageAsset
  self._photo:SetSprite(record.assetBundle, record.assetName)
  if data.id ~= 1 then
    self._rank:SetActive(true)
    record = CImagePathTable:GetRecorder(CRoleRarityCfgTable:GetRecorder(roleConfig.rarity).imgid) or DataCommon.DefaultImageAsset
    self._rank:SetSprite(record.assetBundle, record.assetName)
  else
    self._rank:SetActive(false)
  end
  if roleConfig.rarity == 1 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 2 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgSR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 3 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgSSR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 4 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgUR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 5 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgEX) or DataCommon.DefaultImageAsset
  end
  self._job:SetSprite(record.assetBundle, record.assetName)
  self._title:SetText(tostring(TextManager.GetText(roleConfig.titleTextID)))
  local name = TextManager.GetText(roleConfig.nameTextID)
  self._name:SetText(tostring(string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)))
  if data.own then
    self._lockedBack:SetActive(false)
    self._unlockedBack:SetActive(true)
  else
    self._lockedBack:SetActive(true)
    self._unlockedBack:SetActive(false)
  end
end

function TuJianCharCell:OnCellClick()
  DialogManager.CreateSingletonDialog("tujian.tujiancharacterinfodialog"):Refresh(self._cellData)
end

function TuJianCharCell:OnBackPressed()
  self:Destroy()
  return true, true
end

return TuJianCharCell
