-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2rewardpreviewcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TowerV2RewardPreviewCell = class("TowerV2RewardPreviewCell", Dialog)
TowerV2RewardPreviewCell.AssetBundleName = "ui/layouts.stair"
TowerV2RewardPreviewCell.AssetName = "StairRewardPreviewCell"
TowerV2RewardPreviewCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2RewardPreviewCell
  ((TowerV2RewardPreviewCell.super).Ctor)(self, ...)
end

TowerV2RewardPreviewCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemBoard = self:GetChild("Item3")
  self._icon = self:GetChild("Item3/ItemCell/_BackGround/Icon")
  self._count = self:GetChild("Item3/ItemCell/_Count")
  self._frame = self:GetChild("Item3/ItemCell/_BackGround/Frame")
  self._lock = self:GetChild("Item3/Lock")
  self._level = self:GetChild("Num3")
  self._bar = self:GetChild("ProgressBack/Progress")
  self._got = self:GetChild("Item3/Get")
  self._effect = self:GetChild("Effect")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

TowerV2RewardPreviewCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerV2RewardPreviewCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._itemBoard):SetActive(data.item ~= nil)
  if data.item then
    (self._icon):SetActive(true)
    ;
    (self._frame):SetActive(true)
    local imageRecord = (data.item):GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = (data.item):GetPinJiImage()
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._count):SetText((data.item):GetCount())
  else
    (self._icon):SetActive(false)
    ;
    (self._frame):SetActive(false)
  end
  ;
  (self._level):SetText(data.pt)
  local current = (((NekoData.BehaviorManager).BM_TowerV2):GetReachedCount())
  -- DECOMPILER ERROR at PC60: Overwrote pending register: R3 in 'AssignReg'

  local p = .end
  if data.pt == 0 then
    p = current / data.nextpt
  elseif data.nextpt then
    p = (current - data.pt) / (data.nextpt - data.pt)
  else
    p = 0
  end
  ;
  (self._lock):SetActive((current < data.pt and data.item))
  ;
  (self._bar):SetFillAmount(p)
  ;
  (self._got):SetActive((self._cellData).got)
  ;
  (self._effect):SetActive((data.pt > current or data.item) and not (self._cellData).got)
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

TowerV2RewardPreviewCell.OnCellClicked = function(self, args)
  -- function num : 0_4 , upvalues : _ENV, ItemTypeEnum
  local current = ((NekoData.BehaviorManager).BM_TowerV2):GetReachedCount()
  local total = (self._cellData).pt
  if current < total or (self._cellData).got then
    local tipsDialog = nil
    local width, height = (self:GetRootWindow()):GetRectSize()
    if ((self._cellData).item):GetItemType() == ItemTypeEnum.EQUIP then
      if ((self._cellData).item):IsGained() then
        tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
        if tipsDialog then
          tipsDialog:Init(((self._cellData).item):GetKey())
          tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      else
        tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
        if tipsDialog then
          tipsDialog:Init(((self._cellData).item):GetID())
          tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_1 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      end
    else
      tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData)
        tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
      end
    end
  else
    do
      if (self._cellData).id ~= 0 then
        ((NekoData.BehaviorManager).BM_TowerV2):RequestAward((self._cellData).id)
      end
    end
  end
end

return TowerV2RewardPreviewCell

