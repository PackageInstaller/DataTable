local Item = require("logic.manager.experimental.types.item")
local SActivityDailySupply = LuaNetManager.GetProtocolDef("protocol.activity.sactivitydailysupply")
local DailySupplyCell = class("DailySupplyCell", Dialog)
DailySupplyCell.AssetBundleName = "ui/layouts.activitystar2"
DailySupplyCell.AssetName = "ActivityStar2AccountCell"

function DailySupplyCell:Ctor(...)
  DailySupplyCell.super.Ctor(self, ...)
end

function DailySupplyCell:OnCreate()
  self._gotPanel = self:GetChild("Grey")
  self._getPanel = self:GetChild("GetBack")
  self._getPanel_btn = self:GetChild("GetBack/GetBtn")
  self._txt = self:GetChild("PowerTxt")
  self._getTimeTxt = self:GetChild("PowerTxt/PowerTime")
  self._itemCell = self:GetChild("Item/ItemCell")
  self._itemCell_frame = self:GetChild("Item/ItemCell/_BackGround/Frame")
  self._itemCell_icon = self:GetChild("Item/ItemCell/_BackGround/Icon")
  self._itemCell_count = self:GetChild("Item/ItemCell/_Count")
  self._getPanel_btn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  self:GetChild("GetBack/GetBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2008))
end

function DailySupplyCell:OnDestroy()
end

function DailySupplyCell:RefreshCell(data)
  if data.status == SActivityDailySupply.FETCHED then
    self._gotPanel:SetActive(true)
    self._getPanel:SetActive(false)
  else
    self._gotPanel:SetActive(false)
    self._getPanel:SetActive(true)
    if data.status == SActivityDailySupply.UNLOCKED then
      self._getPanel_btn:SetInteractable(true)
    else
      self._getPanel_btn:SetInteractable(false)
    end
  end
  local item = Item.Create(data.record.itemid)
  local imageRecord = item:GetIcon()
  self._itemCell_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._itemCell_frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemCell_count:SetText(data.record.itemnum)
  self._txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2007, {
    data.record.itemnum
  }))
  local hourStr = string.sub(data.record.missionstart, 11, -1)
  self._getTimeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2006, {hourStr}))
end

function DailySupplyCell:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cfetchactivitysupply")
  protocol.activityId = DataCommon.Activities.StarMirageCopy
  protocol.supply = self._cellData.id
  protocol:Send()
end

return DailySupplyCell
