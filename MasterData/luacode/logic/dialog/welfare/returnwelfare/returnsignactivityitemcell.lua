local Item = require("logic.manager.experimental.types.item")
local ReturnSignActivityItemCell = class("ReturnSignActivityItemCell", Dialog)
ReturnSignActivityItemCell.AssetBundleName = "ui/layouts.welfare"
ReturnSignActivityItemCell.AssetName = "ReturnWelfareCell"

function ReturnSignActivityItemCell:Ctor(...)
  ReturnSignActivityItemCell.super.Ctor(self, ...)
  self._effect_handler = nil
end

function ReturnSignActivityItemCell:OnCreate()
  self._back1 = self:GetChild("Cell/Back1")
  self._back2 = self:GetChild("Cell/Back2")
  self._select = self:GetChild("Cell/Select")
  self._dayText = self:GetChild("Cell/Day")
  self._icon = self:GetChild("Cell/Icon")
  self._icongrey = self:GetChild("Cell/IconGrey")
  self._num = self:GetChild("Cell/Num")
  self._grey = self:GetChild("Cell/Grey")
  self._rank = self:GetChild("Cell/Rank")
  self._effect = self:GetChild("Cell/Effect")
  self._checkmark = self:GetChild("Cell/CheckMark")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  self._effect:Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
end

function ReturnSignActivityItemCell:OnDestroy()
  if self._effect_handler then
    self._effect:ReleaseEffect(self._effect_handler)
    self._effect_handler = nil
  end
end

local function SetNodeActive(self, get, select, grey)
  self._select:SetActive(select)
  self._grey:SetActive(grey)
  self._icon:SetActive(not get)
  self._icongrey:SetActive(grey)
  self._checkmark:SetActive(grey)
end

function ReturnSignActivityItemCell:RefreshCell(data)
  if self._effect_handler then
    self._effect:ReleaseEffect(self._effect_handler)
    self._effect_handler = nil
  end
  self._back1:SetActive(data.cell == 1)
  self._back2:SetActive(data.cell == 2)
  self._dayText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1062, {
    data.index
  }))
  if data.receive then
    SetNodeActive(self, true, false, true)
  elseif data.index <= self._delegate._totalSignTimes then
    SetNodeActive(self, false, true, false)
  else
    SetNodeActive(self, false, false, false)
  end
  local item = Item.Create(data.itemId)
  local imgRecord = item:GetIcon()
  self._icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._icongrey:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1475, {
    data.itemNum
  }))
  imgRecord = item:GetShopPinJiBackGroundImage()
  self._rank:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

function ReturnSignActivityItemCell:OnCellClick()
  if not self._cellData.receive and self._cellData.index <= self._delegate._totalSignTimes then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceiveaward")
    protocol.actId = self._delegate._activityId
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

function ReturnSignActivityItemCell:OnEffectEnd()
  self._delegate:OnEffectEnd(self._cellData.index)
end

function ReturnSignActivityItemCell:OnEvent(eventName, arg)
  if eventName == "ReceiveEffect" and not self._cellData.receive and self._cellData.index <= self._delegate._totalSignTimes then
    self._effect_handler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1137))
    self._delegate._effectList[self._cellData.index] = self._effect_handler
  end
end

return ReturnSignActivityItemCell
