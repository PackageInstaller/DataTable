local WorldInfoTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local Item = require("logic.manager.experimental.types.item")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local OfflinePvpRewardCell = class("OfflinePvpRewardCell", Dialog)
OfflinePvpRewardCell.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpRewardCell.AssetName = "OffLinePVPRewardCell"

function OfflinePvpRewardCell:Ctor(...)
  OfflinePvpRewardCell.super.Ctor(self, ...)
end

function OfflinePvpRewardCell:OnCreate()
  self._progress = self:GetChild("Panel/ProgressBack/Progress")
  self._currentNum = self:GetChild("Panel/ProgressBack/Progress/Current")
  self._currentNumText = self:GetChild("Panel/ProgressBack/Progress/Current/Txt2")
  self._scoreNum = self:GetChild("Panel/Num")
  self._itemFrame = self:GetChild("Panel/Normal/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/Normal/ItemCell/_BackGround/Icon")
  self._itemSelect = self:GetChild("Panel/Normal/ItemCell/_BackGround/Select")
  self._itemCount = self:GetChild("Panel/Normal/ItemCell/_Count")
  self._getIcon = self:GetChild("Panel/Normal/Get")
  self._lockIcon = self:GetChild("Panel/Normal/Lock")
  self._effect = self:GetChild("Panel/Normal/Effect")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._itemSelect:SetActive(false)
  _, self._progressWidth = self._progress:GetWidth()
  local anchor, offset = self._currentNum:GetXPosition()
  self._currentNumXPos = {anchor = anchor, offset = offset}
end

function OfflinePvpRewardCell:OnDestroy()
end

function OfflinePvpRewardCell:RefreshCell(data)
  self._item = Item.Create(data.itemId)
  local imageRecord = self._item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCount:SetText(NumberManager.GetShowNumber(data.itemCount))
  self._progress:SetFillAmount(data.percent)
  if data.percent >= 0 and data.percent <= 1 then
    self._currentNum:SetActive(true)
    self._currentNumText:SetText(self._delegate._totalScore)
    self._currentNum:SetXPosition(data.percent, self._currentNumXPos.offset)
  else
    self._currentNum:SetActive(false)
  end
  self._scoreNum:SetText(data.score)
  self._getIcon:SetActive(data.gain)
  self._lockIcon:SetActive(data.lock)
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  if not self._cellData.lock and not self._cellData.gain then
    self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1057))
  end
end

function OfflinePvpRewardCell:OnCellClicked()
  if not self._cellData.lock and not self._cellData.gain then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.copenreward")
    csend.process = self._cellData.rewardId
    csend:Send()
  elseif self._cellData.itemType == 0 then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
    end
  elseif self._cellData.itemType == 1 then
    local roleID = CRoleItem:GetRecorder(self._cellData.itemId).roleid
    local dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
        roleIdList = {roleID},
        cfgIdList = {7},
        index = 1
      }, dialog.ShowType.BaseLevelInfo)
    end
  end
end

return OfflinePvpRewardCell
