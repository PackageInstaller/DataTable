local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local LoverMainCharCell = class("LoverMainCharCell", Dialog)
LoverMainCharCell.AssetBundleName = "ui/layouts.activitystar"
LoverMainCharCell.AssetName = "ActivityStarMainChar"

function LoverMainCharCell:Ctor(...)
  LoverMainCharCell.super.Ctor(self, ...)
end

function LoverMainCharCell:OnCreate()
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._upTxt = self:GetChild("Txt")
  self._frame:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function LoverMainCharCell:OnDestroy()
end

function LoverMainCharCell:RefreshCell(data)
  local role = Role.Create(data.roleid)
  local image = role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  self._upTxt:SetText(data.boostpercentage .. "%")
end

function LoverMainCharCell:OnCellClick()
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

return LoverMainCharCell
