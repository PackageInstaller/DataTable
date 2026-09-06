local Item = require("logic.manager.experimental.types.item")
local SignActivityItemCell = class("SignActivityItemCell", Dialog)
SignActivityItemCell.AssetBundleName = "ui/layouts.welfare"
SignActivityItemCell.AssetName = "SignActivityDayCell"

function SignActivityItemCell:Ctor(...)
  SignActivityItemCell.super.Ctor(self, ...)
  self._effect_handler = nil
end

function SignActivityItemCell:OnCreate()
  self._select = self:GetChild("Cell/Select")
  self._dayText = self:GetChild("Cell/Day")
  self._icon = self:GetChild("Cell/Icon")
  self._num = self:GetChild("Cell/Num")
  self._grey = self:GetChild("Cell/Grey")
  self._get = self:GetChild("Cell/Get")
  self._rank = self:GetChild("Cell/Rank")
  self._effect = self:GetChild("Cell/Effect")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SignActivityItemCell:OnDestroy()
  if self._effect_handler then
    self._effect:ReleaseEffect(self._effect_handler)
    self._effect_handler = nil
  end
end

local function SetNodeActive(self, get, select, grey)
  self._get:SetActive(get)
  self._select:SetActive(select)
  self._grey:SetActive(grey)
end

function SignActivityItemCell:RefreshCell(data)
  if self._effect_handler then
    self._effect:ReleaseEffect(self._effect_handler)
    self._effect_handler = nil
  end
  self._dayText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1062, {
    data.index
  }))
  if data.receive then
    SetNodeActive(self, true, false, false)
  elseif data.index <= self._delegate._totalSignTimes then
    SetNodeActive(self, false, true, false)
    self._effect_handler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1057))
  else
    SetNodeActive(self, false, false, false)
  end
  local item = Item.Create(data.itemId)
  local imgRecord = item:GetIcon()
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._num:SetText(data.itemNum)
  imgRecord = item:GetShopPinJiBackGroundImage()
  self._rank:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

function SignActivityItemCell:OnCellClick()
  if not self._cellData.receive and self._cellData.index <= self._delegate._totalSignTimes then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceiveaward")
    protocol.actId = self._delegate._activityId
    protocol.index = self._cellData.index
    protocol:Send()
  else
    local width, height = self:GetRootWindow():GetRectSize()
    local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if dialog then
      dialog:Init({
        item = Item.Create(self._cellData.itemId)
      })
      dialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

return SignActivityItemCell
