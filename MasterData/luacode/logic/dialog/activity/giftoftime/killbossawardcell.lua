local KillBossAwardCell = class("KillBossAwardCell", Dialog)
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local CWeeklyBonus = BeanManager.GetTableByName("activity.cweeklybonus")
local Item = require("logic.manager.experimental.types.item")
KillBossAwardCell.AssetBundleName = "ui/layouts.battlepassnew"
KillBossAwardCell.AssetName = "BattlePassNewWeeklyRewardCell"

function KillBossAwardCell:Ctor(...)
  KillBossAwardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function KillBossAwardCell:OnCreate()
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GetBack/GetBtn")
  self._commitBtn_text = self:GetChild("GetBack/GetBtn/_Text")
  self._commitBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1865))
  self._normalBack = self:GetChild("GetBack")
  self._greyBack = self:GetChild("Grey")
  self._greyBackText = self:GetChild("Grey/GotBtn/_Text")
  self._greyBackText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  self._itemCell = {}
  self._itemCell = {}
  self._itemCell.cell = self:GetChild("TaskCellItem/Panel/ItemCell")
  self._itemCell.icon = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Icon")
  self._itemCell.frame = self:GetChild("TaskCellItem/Panel/ItemCell/_BackGround/Frame")
  self._itemCell.count = self:GetChild("TaskCellItem/Panel/ItemCell/_Count")
  self._itemCell.cell:Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._progress = self:GetChild("Loading/Progress")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._commitBtn:Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

function KillBossAwardCell:OnDestroy()
end

function KillBossAwardCell:RefreshCell(data)
  local recoder = CWeeklyBonus:GetRecorder(data.id)
  local num = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetBossTime()
  num = math.min(recoder.neededNum, num)
  local processStr = NekoData.BehaviorManager.BM_Message:GetString(1955, {
    num,
    recoder.neededNum
  })
  self._progress:SetFillAmount(num / recoder.neededNum)
  self._progressNum:SetText(processStr)
  self._name:SetText(NekoData.BehaviorManager.BM_Message:GetString(1951, {
    recoder.neededNum
  }))
  local greyShow = data.awardStatus == 2
  self._greyBack:SetActive(greyShow)
  self._normalBack:SetActive(not greyShow)
  self._commitBtn:SetInteractable(data.awardStatus == 1)
  local item = Item.Create(recoder.rewardID)
  local image = item:GetIcon()
  self._itemCell.icon:SetSprite(image.assetBundle, image.assetName)
  image = item:GetPinJiImage()
  self._itemCell.frame:SetSprite(image.assetBundle, image.assetName)
  self._itemCell.count:SetText(NumberManager.GetShowNumber(recoder.rewardNum))
  self._itemCell.item = item
end

function KillBossAwardCell:OnCommitClick()
  if self._cellData.awardStatus == 1 then
    self._delegate:OnCommitClick(self._cellData.id)
  end
end

function KillBossAwardCell:OnItemClicked()
  local width, height = self._itemCell.cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell.item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell.cell:GetLocalPointInUiRootPanel())
  end
end

return KillBossAwardCell
