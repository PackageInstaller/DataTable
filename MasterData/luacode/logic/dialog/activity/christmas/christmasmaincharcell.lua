local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local ChristmasMainCharCell = class("ChristmasMainCharCell", Dialog)
ChristmasMainCharCell.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasMainCharCell.AssetName = "ActivityChristmasMainChar"

function ChristmasMainCharCell:Ctor(...)
  ChristmasMainCharCell.super.Ctor(self, ...)
end

function ChristmasMainCharCell:OnCreate()
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._upTxt = self:GetChild("Txt")
  self._frame:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function ChristmasMainCharCell:OnDestroy()
end

function ChristmasMainCharCell:RefreshCell(data)
  local role = Role.Create(data.roleid)
  local image = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  self._upTxt:SetText(data.boostpercentage .. "%")
end

function ChristmasMainCharCell:OnCellClick()
  local index
  local roleIdList = {}
  local cfgIdList = {}
  for i, v in ipairs(self._delegate._charUpData) do
    if not index and v.id == self._cellData.id then
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

return ChristmasMainCharCell
