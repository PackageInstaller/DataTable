local UndecidedRoadRewardCell = class("UndecidedRoadRewardCell", Dialog)
local CWeidingcollect = BeanManager.GetTableByName("dungeonselect.cweidingcollect")
local Item = require("logic.manager.experimental.types.item")
UndecidedRoadRewardCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRewardCell.AssetName = "ActivityRoadRewardCell"

function UndecidedRoadRewardCell:Ctor(...)
  UndecidedRoadRewardCell.super.Ctor(self, ...)
end

function UndecidedRoadRewardCell:OnCreate()
  self._getBtn = self:GetChild("GetBack/GetBtn")
  self._grey = self:GetChild("Grey")
  self._backGround = self:GetChild("ItemCell/_BackGround")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._countNum = self:GetChild("ItemCell/_Count")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicken, self)
  self._backGround:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function UndecidedRoadRewardCell:OnDestroy()
end

function UndecidedRoadRewardCell:RefreshCell(data)
  self._data = data
  local record = CWeidingcollect:GetRecorder(data.stageId)
  self._item = Item.Create(record.collectbonus[1])
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local curNum = NekoData.BehaviorManager.BM_UndecidedRoad:GetTotalScore()
  if curNum > record.collectrequirenum then
    curNum = record.collectrequirenum
  end
  self._countNum:SetText(NumberManager.GetShowNumber(record.collectbonusnum[1]))
  if record.collectrequirenum == 0 then
    self._progress:SetFillAmount(1)
  else
    self._progress:SetFillAmount(curNum / record.collectrequirenum)
  end
  self._progressNum:SetText(curNum .. "/" .. tostring(record.collectrequirenum))
  if data.status == 0 then
    self._grey:SetActive(false)
    self._getBtn:SetInteractable(false)
  elseif data.status == 1 then
    self._grey:SetActive(false)
    self._getBtn:SetInteractable(true)
  elseif data.status == 2 then
    self._grey:SetActive(true)
    self._getBtn:SetInteractable(true)
  end
end

function UndecidedRoadRewardCell:OnGetBtnClicken()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.creceivereward")
  if csend then
    csend.rewardId = self._data.stageId
    csend:Send()
  end
end

function UndecidedRoadRewardCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return UndecidedRoadRewardCell
