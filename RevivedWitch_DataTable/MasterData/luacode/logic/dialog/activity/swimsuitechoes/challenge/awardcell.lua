-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/awardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AwardCell = class("AwardCell", Dialog)
local CSRchallengeReward = (BeanManager.GetTableByName)("activity.csrchallengereward")
local Item = require("logic.manager.experimental.types.item")
AwardCell.AssetBundleName = "ui/layouts.activitysummer2"
AwardCell.AssetName = "ActivitySummer2ChallengeRewardCell"
AwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AwardCell
  ((AwardCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

AwardCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GetBack/GetBtn")
  self._commitBtn_text = self:GetChild("GetBack/GetBtn/_Text")
  ;
  (self._commitBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1865))
  self._normalBack = self:GetChild("GetBack")
  self._greyBack = self:GetChild("Grey")
  self._greyBackText = self:GetChild("Grey/GotBtn/_Text")
  ;
  (self._greyBackText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  self._itemCell = {}
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).cell = self:GetChild("TaskCellItem/Panel/ItemCell")
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).icon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).frame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).count = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  ;
  ((self._itemCell).cell):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._progress = self:GetChild("Loading/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  ;
  (self._commitBtn):Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

AwardCell.OnDestroy = function(self)
  -- function num : 0_2
end

AwardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSRchallengeReward, _ENV, Item
  local recoder = CSRchallengeReward:GetRecorder(data.id)
  local num = data.num
  local processStr = ((NekoData.BehaviorManager).BM_Message):GetString(1955, {num, recoder.neededPoint})
  ;
  (self._progress):SetFillAmount(num / recoder.neededPoint)
  ;
  (self._progressNum):SetText(processStr)
  ;
  (self._name):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2170, {recoder.neededPoint}))
  local greyShow = data.status == 2
  ;
  (self._greyBack):SetActive(greyShow)
  ;
  (self._normalBack):SetActive(not greyShow)
  ;
  (self._commitBtn):SetInteractable(data.status == 1)
  local item = (Item.Create)(recoder.itemID)
  local image = item:GetIcon()
  ;
  ((self._itemCell).icon):SetSprite(image.assetBundle, image.assetName)
  image = item:GetPinJiImage()
  ;
  ((self._itemCell).frame):SetSprite(image.assetBundle, image.assetName)
  ;
  ((self._itemCell).count):SetText((NumberManager.GetShowNumber)(recoder.itemNum))
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._itemCell).item = item
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

AwardCell.OnCommitClick = function(self)
  -- function num : 0_4
  if (self._cellData).status == 1 then
    (self._delegate):OnCommitClick((self._cellData).id)
  end
end

AwardCell.OnItemClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = ((self._itemCell).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._itemCell).item})
    tipsDialog:SetTipsPosition(width, height, ((self._itemCell).cell):GetLocalPointInUiRootPanel())
  end
end

return AwardCell

