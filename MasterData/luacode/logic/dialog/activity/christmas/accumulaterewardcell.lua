local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardCell = class("AccumulateRewardCell", Dialog)
AccumulateRewardCell.AssetBundleName = "ui/layouts.activitychristmas"
AccumulateRewardCell.AssetName = "ActivityChristmasAccountCell"

function AccumulateRewardCell:Ctor(...)
  AccumulateRewardCell.super.Ctor(self, ...)
  self._itemList = {}
end

function AccumulateRewardCell:OnCreate()
  self._getPanel = self:GetChild("GetBack")
  self._getPanel_Btn = self:GetChild("GetBack/GetBtn")
  self._gotPanel = self:GetChild("Grey")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("Loading/Num/Num")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._cellPanel = self:GetChild("ItemFrame")
  self._itemTxt = self:GetChild("ItemTxt")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, false, false)
  self._getPanel_Btn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

function AccumulateRewardCell:OnDestroy()
  self._cellFrame:Destroy()
end

function AccumulateRewardCell:RefreshCell(data)
  local record = data.record
  local currencyItem = Item.Create(record.collecttype)
  local image = currencyItem:GetIcon()
  self._itemTxt:SetText(string.gsub(TextManager.GetText(701713), "%$parameter1%$", currencyItem:GetName()))
  self._currencyIcon:SetSprite(image.assetBundle, image.assetName)
  local haveScore = self._delegate._bm:GetScoreByType(record.collecttype)
  self._currencyNum:SetText(haveScore .. "/" .. tostring(record.collectrequirenum))
  self._progress:SetFillAmount(haveScore / record.collectrequirenum)
  if data.status == 0 then
    self._getPanel:SetActive(true)
    self._gotPanel:SetActive(false)
    self._getPanel_Btn:SetInteractable(false)
  elseif data.status == 1 then
    self._getPanel:SetActive(true)
    self._gotPanel:SetActive(false)
    self._getPanel_Btn:SetInteractable(true)
  elseif data.status == 2 then
    self._getPanel:SetActive(false)
    self._gotPanel:SetActive(true)
  end
  while self._itemList[#self._itemList] do
    table.remove(self._itemList, #self._itemList)
  end
  for i, v in ipairs(record.collectbonus) do
    table.insert(self._itemList, {
      id = v,
      num = record.collectbonusnum[i]
    })
  end
  self._cellFrame:ReloadAllCell()
end

function AccumulateRewardCell:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivescorereward")
  protocol.scoreType = self._cellData.record.collecttype
  protocol.rewardId = self._cellData.record.id
  protocol:Send()
end

function AccumulateRewardCell:NumberOfCell(frame)
  return #self._itemList
end

function AccumulateRewardCell:CellAtIndex(frame, index)
  return "activity.starmirage.accumulaterewarditemcell"
end

function AccumulateRewardCell:DataAtIndex(frame, index)
  return self._itemList[index]
end

return AccumulateRewardCell
