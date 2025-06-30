-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/killbosstaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local KillBossTaskCell = class("KillBossTaskCell", Dialog)
local Status = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
KillBossTaskCell.AssetBundleName = "ui/layouts.battlepassnew"
KillBossTaskCell.AssetName = "BattlePassNewTaskCell"
KillBossTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : KillBossTaskCell
  ((KillBossTaskCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

KillBossTaskCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GoBack/GetBtn")
  self._commitBtn_text = self:GetChild("GoBack/GetBtn/_Text")
  ;
  (self._commitBtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1865))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._goBtn_Text = self:GetChild("GoBack/GoBtn/_Text")
  ;
  (self._goBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1718))
  self._normalBack = self:GetChild("GoBack")
  self._greyBack = self:GetChild("Grey")
  self._greyBackText = self:GetChild("Grey/GotBtn/_Text")
  ;
  (self._greyBackText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
  self._itemCell = {}
  self._itemCell = {}
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).cell = self:GetChild("TaskCellItem/Panel/ItemCell")
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).icon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).frame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemCell).count = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  ;
  ((self._itemCell).cell):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._limit = self:GetChild("Limit")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  ;
  (self._commitBtn):Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

KillBossTaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

KillBossTaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Status, Item
  local processStr = ((NekoData.BehaviorManager).BM_Message):GetString(1955, {(((data.task).conditions)[1]).value, (((data.task).conditions)[1]).destValue})
  ;
  (self._name):SetText((TextManager.GetText)((data.cfg).taskTextID) .. processStr)
  local status = (data.task).taskstatus
  local greyShow = status == Status.COMMITED
  ;
  (self._greyBack):SetActive(greyShow)
  ;
  (self._normalBack):SetActive(not greyShow)
  ;
  (self._commitBtn):SetActive(status == Status.FINISHED)
  ;
  (self._goBtn):SetActive(status ~= Status.FINISHED)
  ;
  (self._commitBtn):SetActive(status == Status.FINISHED)
  local item = (Item.Create)(((data.cfg).rewarditem)[1])
  local image = item:GetIcon()
  ;
  ((self._itemCell).icon):SetSprite(image.assetBundle, image.assetName)
  image = item:GetPinJiImage()
  ;
  ((self._itemCell).frame):SetSprite(image.assetBundle, image.assetName)
  ;
  ((self._itemCell).count):SetText((NumberManager.GetShowNumber)(((data.cfg).rewardquantity)[1]))
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self._itemCell).item = item
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

KillBossTaskCell.OnCommitClick = function(self)
  -- function num : 0_4 , upvalues : Status
  if ((self._cellData).task).taskstatus == Status.FINISHED then
    (self._delegate):OnCommitClick(((self._cellData).cfg).id)
  end
end

KillBossTaskCell.OnItemClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = ((self._itemCell).cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._itemCell).item})
    tipsDialog:SetTipsPosition(width, height, ((self._itemCell).cell):GetLocalPointInUiRootPanel())
  end
end

KillBossTaskCell.OnGoBtnClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)
  manager:HandleTask(((self._cellData).cfg).id)
  ;
  (DialogManager.DestroySingletonDialog)("activity.giftoftime.giftoftimemaindialog")
  ;
  (DialogManager.DestroySingletonDialog)("activity.giftoftime.killbosstaskdialog")
end

return KillBossTaskCell

