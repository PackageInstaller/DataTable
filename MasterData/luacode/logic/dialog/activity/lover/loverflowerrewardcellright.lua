local LoverFlowerRewardCell = class("LoverFlowerRewardCell", Dialog)
LoverFlowerRewardCell.AssetBundleName = "ui/layouts.activityvalentines"
LoverFlowerRewardCell.AssetName = "ActivityValentinesFlowerCell2"

function LoverFlowerRewardCell:Ctor(...)
  LoverFlowerRewardCell.super.Ctor(self, ...)
end

function LoverFlowerRewardCell:OnCreate()
  self._back = self:GetChild("Award/ItemCell/_BackGround")
  self._count = self:GetChild("Award/ItemCell/_Count")
  self._itemImg = self:GetChild("Award/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Award/ItemCell/_BackGround/Frame")
  self._canGetEffect = self:GetChild("Award/Effect")
  self._gottenTag = self:GetChild("Award/Get")
  self._canGetDot = self:GetChild("Dot")
  self._greyDot = self:GetChild("DotGrey")
  self._canGetNum = self:GetChild("NumGrey/Num")
  self._progress = self:GetChild("LineGrey/Line")
  self._greyNum = self:GetChild("NumGrey")
  self._progressLine = self:GetChild("LineGrey")
  self._back:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function LoverFlowerRewardCell:OnDestroy()
end

function LoverFlowerRewardCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._itemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetText(data.itemCount)
  self._canGetNum:SetNumber(data.popularity)
  self._greyNum:SetNumber(data.popularity)
  if data.progress == -1 then
    self._progressLine:SetActive(false)
  else
    self._progressLine:SetActive(true)
    self._progress:SetFillAmount(data.progress)
  end
  if data.gotten then
    self._canGetDot:SetActive(true)
    self._greyDot:SetActive(false)
    self._gottenTag:SetActive(true)
    self._canGetNum:SetActive(true)
    self._canGetEffect:SetActive(false)
  elseif data.canGet then
    self._canGetDot:SetActive(true)
    self._greyDot:SetActive(false)
    self._gottenTag:SetActive(false)
    self._canGetNum:SetActive(true)
    self._canGetEffect:SetActive(true)
  else
    self._canGetDot:SetActive(false)
    self._greyDot:SetActive(true)
    self._gottenTag:SetActive(false)
    self._canGetNum:SetActive(false)
    self._canGetEffect:SetActive(false)
  end
end

function LoverFlowerRewardCell:OnCellClicked()
  if not self._cellData.gotten and self._cellData.canGet then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.creceiveflowerreward")
    csend.rewardType = self._cellData.id // 100
    csend.id = self._cellData.id
    csend:Send()
  else
    local width, height = self._back:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._cellData.item
      })
      tipsDialog:SetTipsPosition(width, height, self._back:GetLocalPointInUiRootPanel())
    end
  end
end

function LoverFlowerRewardCell:OnEvent(eventName, arg)
  if eventName == "RefreshProgress" then
    if arg.id == self._cellData.id then
      self._cellData.progress = arg.progress
      self._progress:SetFillAmount(arg.progress)
    end
  elseif eventName == "RewardGotten" then
    if arg == self._cellData.id then
      self._cellData.gotten = true
      self._canGetDot:SetActive(true)
      self._greyDot:SetActive(false)
      self._gottenTag:SetActive(true)
      self._canGetNum:SetActive(true)
      self._canGetEffect:SetActive(false)
    end
  elseif eventName == "RewardCanGet" and arg == self._cellData.id then
    self._cellData.canGet = true
    self._canGetDot:SetActive(true)
    self._greyDot:SetActive(false)
    self._gottenTag:SetActive(false)
    self._canGetNum:SetActive(true)
    self._canGetEffect:SetActive(true)
  end
end

return LoverFlowerRewardCell
