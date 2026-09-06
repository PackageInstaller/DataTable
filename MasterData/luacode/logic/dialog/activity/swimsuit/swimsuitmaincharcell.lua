local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local SwimSuitMainCharCell = class("SwimSuitMainCharCell", Dialog)
SwimSuitMainCharCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainCharCell.AssetName = "ActivitySummerMainChar"

function SwimSuitMainCharCell:Ctor(...)
  SwimSuitMainCharCell.super.Ctor(self, ...)
end

function SwimSuitMainCharCell:OnCreate()
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._upTxt = self:GetChild("Txt")
  self._frame:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SwimSuitMainCharCell:OnDestroy()
end

function SwimSuitMainCharCell:RefreshCell(data)
  local role = Role.Create(data.roleid)
  local image = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  self._upTxt:SetText(data.boostpercentage .. "%")
end

function SwimSuitMainCharCell:OnCellClick()
  local index
  local roleIdList = {}
  local cfgIdList = {}
  for i, v in ipairs(self._delegate._charUpData) do
    if not index and v.roleid == self._cellData.roleid then
      index = i
    end
    table.insert(roleIdList, v.roleid)
    table.insert(cfgIdList, 3)
  end
  DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog"):Init({
    roleIdList = roleIdList,
    cfgIdList = cfgIdList,
    index = index
  }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
end

return SwimSuitMainCharCell
