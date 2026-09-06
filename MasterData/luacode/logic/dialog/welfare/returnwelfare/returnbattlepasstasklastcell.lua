local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CReturnBattlePassReward = BeanManager.GetTableByName("welfare.creturnbattlepassreward")
local ReturnBattlePassTaskLastCell = class("ReturnBattlePassTaskLastCell", Dialog)
ReturnBattlePassTaskLastCell.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassTaskLastCell.AssetName = "ReturnBattlePassCellMax"

function ReturnBattlePassTaskLastCell:Ctor(...)
  ReturnBattlePassTaskLastCell.super.Ctor(self, ...)
end

function ReturnBattlePassTaskLastCell:OnCreate()
  self._txt = self:GetChild("Panel/Normal/Txt")
  self._normalItem = self:GetChild("Panel/Normal/ItemCell")
  self._itemFrame = self:GetChild("Panel/Normal/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/Normal/ItemCell/_BackGround/Icon")
  self._itemChoose = self:GetChild("Panel/Normal/ItemCell/_BackGround/Select")
  self._num = self:GetChild("Panel/Normal/ItemCell/_Count")
  self._reddot = self:GetChild("Panel/Normal/RedDot")
  self._lock = self:GetChild("Panel/Normal/Lock")
  self._effect = self:GetChild("Panel/Effect")
  self._itemIcon:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._itemChoose:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ReturnBattlePassTaskLastCell:OnDestroy()
end

function ReturnBattlePassTaskLastCell:RefreshCell(data)
  self._data = data
  local common = data.common
  local item = Item.Create(common.itemId)
  local imageRecord = item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemIcon:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  self._awardTimes = self._delegate._returnBattlePass.canReceiveMaxAward
  self._num:SetText(NumberManager.GetShowNumber(common.itemNum))
  self._reddot:SetActive(self._awardTimes > 0)
  self._lock:SetActive(not (self._awardTimes > 0))
  local show = self._awardTimes > 0
  if show and not self._effectHandler then
    self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1127))
  elseif not show and self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  local maxLevel = CReturnBattlePassReward:GetRecorder(CReturnBattlePassReward:GetAllIds()[#CReturnBattlePassReward:GetAllIds() - 1]).level
  local s = TextManager.GetText(CStringRes:GetRecorder(1331).msgTextID)
  s = string.gsub(s, "%$parameter1%$", maxLevel)
  self._txt:SetText(s)
end

function ReturnBattlePassTaskLastCell:OnCellClicked()
  if self._awardTimes > 0 then
    local cmd = LuaNetManager.CreateProtocol("protocol.activity.creceivereturnmaxlevel")
    cmd:Send()
  else
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      local itemId = self._data.common.itemId
      tipsDialog:Init({
        item = Item.Create(itemId)
      })
      local width, height = self._normalItem:GetRectSize()
      tipsDialog:SetTipsPosition(width, height, self._normalItem:GetLocalPointInUiRootPanel())
    end
  end
end

return ReturnBattlePassTaskLastCell
