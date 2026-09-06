local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local TowerV2RewardPreviewCell = class("TowerV2RewardPreviewCell", Dialog)
TowerV2RewardPreviewCell.AssetBundleName = "ui/layouts.stair"
TowerV2RewardPreviewCell.AssetName = "StairRewardPreviewCell"

function TowerV2RewardPreviewCell:Ctor(...)
  TowerV2RewardPreviewCell.super.Ctor(self, ...)
end

function TowerV2RewardPreviewCell:OnCreate()
  self._itemBoard = self:GetChild("Item3")
  self._icon = self:GetChild("Item3/ItemCell/_BackGround/Icon")
  self._count = self:GetChild("Item3/ItemCell/_Count")
  self._frame = self:GetChild("Item3/ItemCell/_BackGround/Frame")
  self._lock = self:GetChild("Item3/Lock")
  self._level = self:GetChild("Num3")
  self._bar = self:GetChild("ProgressBack/Progress")
  self._got = self:GetChild("Item3/Get")
  self._effect = self:GetChild("Effect")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function TowerV2RewardPreviewCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2RewardPreviewCell:RefreshCell(data)
  self._itemBoard:SetActive(data.item ~= nil)
  if data.item then
    self._icon:SetActive(true)
    self._frame:SetActive(true)
    local imageRecord = data.item:GetIcon()
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = data.item:GetPinJiImage()
    self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._count:SetText(data.item:GetCount())
  else
    self._icon:SetActive(false)
    self._frame:SetActive(false)
  end
  self._level:SetText(data.pt)
  local current = NekoData.BehaviorManager.BM_TowerV2:GetReachedCount()
  local p
  if data.pt == 0 then
    p = current / data.nextpt
  elseif data.nextpt then
    p = (current - data.pt) / (data.nextpt - data.pt)
  else
    p = 0
  end
  self._lock:SetActive(current < data.pt and data.item)
  self._bar:SetFillAmount(p)
  self._got:SetActive(self._cellData.got)
  self._effect:SetActive(current >= data.pt and data.item and not self._cellData.got)
end

function TowerV2RewardPreviewCell:OnCellClicked(args)
  local current = NekoData.BehaviorManager.BM_TowerV2:GetReachedCount()
  local total = self._cellData.pt
  if current < total or self._cellData.got then
    local tipsDialog
    local width, height = self:GetRootWindow():GetRectSize()
    if self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
      if self._cellData.item:IsGained() then
        tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
        if tipsDialog then
          tipsDialog:Init(self._cellData.item:GetKey())
          tipsDialog:SetTipsParmFunc(function()
            local width, height = self:GetRootWindow():GetRectSize()
            local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
            return {
              width = width,
              height = height,
              posX = pos.x,
              posY = pos.y
            }
          end)
        end
      else
        tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
        if tipsDialog then
          tipsDialog:Init(self._cellData.item:GetID())
          tipsDialog:SetTipsParmFunc(function()
            local width, height = self:GetRootWindow():GetRectSize()
            local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
            return {
              width = width,
              height = height,
              posX = pos.x,
              posY = pos.y
            }
          end)
        end
      end
    else
      tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData)
        tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
      end
    end
  elseif self._cellData.id ~= 0 then
    NekoData.BehaviorManager.BM_TowerV2:RequestAward(self._cellData.id)
  end
end

return TowerV2RewardPreviewCell
