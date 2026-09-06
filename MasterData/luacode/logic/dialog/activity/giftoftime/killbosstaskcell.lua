local KillBossTaskCell = class("KillBossTaskCell", Dialog)
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")
local Item = require("logic.manager.experimental.types.item")
KillBossTaskCell.AssetBundleName = "ui/layouts.battlepassnew"
KillBossTaskCell.AssetName = "BattlePassNewTaskCell"

function KillBossTaskCell:Ctor(...)
  KillBossTaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function KillBossTaskCell:OnCreate()
  self._name = self:GetChild("ItemTxt")
  self._commitBtn = self:GetChild("GoBack/GetBtn")
  self._commitBtn_text = self:GetChild("GoBack/GetBtn/_Text")
  self._commitBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1865))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._goBtn_Text = self:GetChild("GoBack/GoBtn/_Text")
  self._goBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1718))
  self._normalBack = self:GetChild("GoBack")
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
  self._limit = self:GetChild("Limit")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._commitBtn:Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

function KillBossTaskCell:OnDestroy()
end

function KillBossTaskCell:RefreshCell(data)
  local processStr = NekoData.BehaviorManager.BM_Message:GetString(1955, {
    data.task.conditions[1].value,
    data.task.conditions[1].destValue
  })
  self._name:SetText(TextManager.GetText(data.cfg.taskTextID) .. processStr)
  local status = data.task.taskstatus
  local greyShow = status == Status.COMMITED
  self._greyBack:SetActive(greyShow)
  self._normalBack:SetActive(not greyShow)
  self._commitBtn:SetActive(status == Status.FINISHED)
  self._goBtn:SetActive(status ~= Status.FINISHED)
  self._commitBtn:SetActive(status == Status.FINISHED)
  local item = Item.Create(data.cfg.rewarditem[1])
  local image = item:GetIcon()
  self._itemCell.icon:SetSprite(image.assetBundle, image.assetName)
  image = item:GetPinJiImage()
  self._itemCell.frame:SetSprite(image.assetBundle, image.assetName)
  self._itemCell.count:SetText(NumberManager.GetShowNumber(data.cfg.rewardquantity[1]))
  self._itemCell.item = item
end

function KillBossTaskCell:OnCommitClick()
  if self._cellData.task.taskstatus == Status.FINISHED then
    self._delegate:OnCommitClick(self._cellData.cfg.id)
  end
end

function KillBossTaskCell:OnItemClicked()
  local width, height = self._itemCell.cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell.item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell.cell:GetLocalPointInUiRootPanel())
  end
end

function KillBossTaskCell:OnGoBtnClick()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID)
  manager:HandleTask(self._cellData.cfg.id)
  DialogManager.DestroySingletonDialog("activity.giftoftime.giftoftimemaindialog")
  DialogManager.DestroySingletonDialog("activity.giftoftime.killbosstaskdialog")
end

return KillBossTaskCell
