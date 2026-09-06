local Item = require("logic.manager.experimental.types.item")
local CBossRushStageReward = BeanManager.GetTableByName("dungeonselect.cbossrushstagereward")
local CWeeklyBossRushStageReward = BeanManager.GetTableByName("dungeonselect.cweeklybossrushstagereward")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local CBossRushStageShow = BeanManager.GetTableByName("dungeonselect.cbossrushstageshow")
local BossStageAwardCell = class("BossStageAwardCell", Dialog)
BossStageAwardCell.AssetBundleName = "ui/layouts.mainline"
BossStageAwardCell.AssetName = "BossRushRewardCell"
local ItemCellCount = 3

function BossStageAwardCell:Ctor(...)
  BossStageAwardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function BossStageAwardCell:OnCreate()
  self._text = self:GetChild("Difficulty")
  self._itemCell = {}
  for i = 1, ItemCellCount do
    self._itemCell[i] = {}
    self._itemCell[i].cell = self:GetChild("ItemCell" .. i)
    self._itemCell[i].icon = self:GetChild("ItemCell" .. i .. "/_BackGround/Icon")
    self._itemCell[i].frame = self:GetChild("ItemCell" .. i .. "/_BackGround/Frame")
    self._itemCell[i].count = self:GetChild("ItemCell" .. i .. "/_Count")
    self._itemCell[i].cell:Subscribe_PointerClickEvent(function()
      self:OnItemClicked(i)
    end)
  end
  self._getAwardBtn = self:GetChild("GetBtn")
  self._hasReceivedBtn = self:GetChild("GetBtn1")
  self._getAwardBtn:Subscribe_PointerClickEvent(self.OnGetAwardBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshGetBtnStatus, Common.n_ReceiveBossPanelStageAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshGetBtnStatus, Common.n_SReceiveWeekAward, nil)
end

function BossStageAwardCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BossStageAwardCell:RefreshCell()
  local tableName = CBossRushStageReward
  if self._delegate._isWeekBoss then
    tableName = CWeeklyBossRushStageReward
  end
  local cfg = tableName:GetRecorder(self._cellData.stageId)
  if not cfg then
    return
  end
  self._text:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(cfg.stagecondition, nil, self._delegate._isWeekBoss))
  local count = #cfg.rewardid
  if count > ItemCellCount then
    LogErrorFormat("BossStageAwardCell", "(cweek)BossRushStageReward stage %s rewardid listNumber %s is more than 3", self._cellData.stageId, count)
    count = 3
  end
  for i = count + 1, ItemCellCount do
    self._itemCell[i].cell:SetActive(false)
  end
  for i = 1, count do
    self._itemCell[i].cell:SetActive(true)
    local item = Item.Create(cfg.rewardid[i])
    local image = item:GetIcon()
    self._itemCell[i].icon:SetSprite(image.assetBundle, image.assetName)
    image = item:GetPinJiImage()
    self._itemCell[i].frame:SetSprite(image.assetBundle, image.assetName)
    self._itemCell[i].count:SetText(NumberManager.GetShowNumber(cfg.rewardnum[i]))
    self._itemCell[i].item = item
  end
  self._hasReceivedBtn:SetActive(self._cellData.awardStatus == 2)
  self._getAwardBtn:SetActive(self._cellData.awardStatus ~= 2)
  self._getAwardBtn:SetInteractable(self._cellData.awardStatus == 1)
end

function BossStageAwardCell:RefreshGetBtnStatus(notification)
  if notification.userInfo.stageId == self._cellData.stageId then
    self._cellData.awardStatus = 2
    self._hasReceivedBtn:SetActive(true)
    self._getAwardBtn:SetActive(false)
  end
end

function BossStageAwardCell:OnGetAwardBtnClick()
  if self._cellData.awardStatus == 0 then
    return
  end
  if self._delegate._isWeekBoss then
    local protocol = LuaNetManager.CreateProtocol("protocol.ranking.creceiveweekaward")
    protocol.id = self._delegate._bossRushId
    protocol.stageId = self._cellData.stageId
    protocol:Send()
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.ranking.creceivestageaward")
    protocol.id = self._delegate._bossRushId
    protocol.stageId = self._cellData.stageId
    protocol:Send()
  end
end

function BossStageAwardCell:OnItemClicked(index)
  local width, height = self._itemCell[index].cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell[index].item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell[index].cell:GetLocalPointInUiRootPanel())
  end
end

return BossStageAwardCell
