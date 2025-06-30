-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossstageawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CBossRushStageReward = (BeanManager.GetTableByName)("dungeonselect.cbossrushstagereward")
local CWeeklyBossRushStageReward = (BeanManager.GetTableByName)("dungeonselect.cweeklybossrushstagereward")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local CBossRushStageShow = (BeanManager.GetTableByName)("dungeonselect.cbossrushstageshow")
local BossStageAwardCell = class("BossStageAwardCell", Dialog)
BossStageAwardCell.AssetBundleName = "ui/layouts.mainline"
BossStageAwardCell.AssetName = "BossRushRewardCell"
local ItemCellCount = 3
BossStageAwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossStageAwardCell
  ((BossStageAwardCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

BossStageAwardCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : ItemCellCount, _ENV
  self._text = self:GetChild("Difficulty")
  self._itemCell = {}
  for i = 1, ItemCellCount do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemCell)[i] = {}
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).cell = self:GetChild("ItemCell" .. i)
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).icon = self:GetChild("ItemCell" .. i .. "/_BackGround/Icon")
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).frame = self:GetChild("ItemCell" .. i .. "/_BackGround/Frame")
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._itemCell)[i]).count = self:GetChild("ItemCell" .. i .. "/_Count")
      ;
      (((self._itemCell)[i]).cell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemClicked(i)
  end
)
    end
  end
  self._getAwardBtn = self:GetChild("GetBtn")
  self._hasReceivedBtn = self:GetChild("GetBtn1")
  ;
  (self._getAwardBtn):Subscribe_PointerClickEvent(self.OnGetAwardBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshGetBtnStatus, Common.n_ReceiveBossPanelStageAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshGetBtnStatus, Common.n_SReceiveWeekAward, nil)
end

BossStageAwardCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BossStageAwardCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : CBossRushStageReward, CWeeklyBossRushStageReward, _ENV, ItemCellCount, Item
  local tableName = CBossRushStageReward
  if (self._delegate)._isWeekBoss then
    tableName = CWeeklyBossRushStageReward
  end
  local cfg = tableName:GetRecorder((self._cellData).stageId)
  if not cfg then
    return 
  end
  ;
  (self._text):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr(cfg.stagecondition, nil, (self._delegate)._isWeekBoss))
  local count = #cfg.rewardid
  if ItemCellCount < count then
    LogErrorFormat("BossStageAwardCell", "(cweek)BossRushStageReward stage %s rewardid listNumber %s is more than 3", (self._cellData).stageId, count)
    count = 3
  end
  for i = count + 1, ItemCellCount do
    (((self._itemCell)[i]).cell):SetActive(false)
  end
  for i = 1, count do
    (((self._itemCell)[i]).cell):SetActive(true)
    local item = (Item.Create)((cfg.rewardid)[i])
    local image = item:GetIcon()
    ;
    (((self._itemCell)[i]).icon):SetSprite(image.assetBundle, image.assetName)
    image = item:GetPinJiImage()
    ;
    (((self._itemCell)[i]).frame):SetSprite(image.assetBundle, image.assetName)
    ;
    (((self._itemCell)[i]).count):SetText((NumberManager.GetShowNumber)((cfg.rewardnum)[i]))
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self._itemCell)[i]).item = item
  end
  ;
  (self._hasReceivedBtn):SetActive((self._cellData).awardStatus == 2)
  ;
  (self._getAwardBtn):SetActive((self._cellData).awardStatus ~= 2)
  ;
  (self._getAwardBtn):SetInteractable((self._cellData).awardStatus == 1)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BossStageAwardCell.RefreshGetBtnStatus = function(self, notification)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if (notification.userInfo).stageId == (self._cellData).stageId then
    (self._cellData).awardStatus = 2
    ;
    (self._hasReceivedBtn):SetActive(true)
    ;
    (self._getAwardBtn):SetActive(false)
  end
end

BossStageAwardCell.OnGetAwardBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._cellData).awardStatus == 0 then
    return 
  end
  if (self._delegate)._isWeekBoss then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.creceiveweekaward")
    protocol.id = (self._delegate)._bossRushId
    protocol.stageId = (self._cellData).stageId
    protocol:Send()
  else
    do
      local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.creceivestageaward")
      protocol.id = (self._delegate)._bossRushId
      protocol.stageId = (self._cellData).stageId
      protocol:Send()
    end
  end
end

BossStageAwardCell.OnItemClicked = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  local width, height = (((self._itemCell)[index]).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = ((self._itemCell)[index]).item})
    tipsDialog:SetTipsPosition(width, height, (((self._itemCell)[index]).cell):GetLocalPointInUiRootPanel())
  end
end

return BossStageAwardCell

