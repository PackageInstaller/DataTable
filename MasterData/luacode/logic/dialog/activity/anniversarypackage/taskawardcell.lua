local TaskAwardcell = class("TaskAwardcell", Dialog)
local Item = require("logic.manager.experimental.types.item")
local CommonAwardsSatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
TaskAwardcell.AssetBundleName = "ui/layouts.activity1yearanniversary"
TaskAwardcell.AssetName = "Activity1YearOtherTaskProgressCell"

function TaskAwardcell:Ctor(...)
  TaskAwardcell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TaskAwardcell:OnCreate()
  self._processLine = self:GetChild("LinebBack/Line")
  self:GetChild("GetBack2/Text1")
  self:GetChild("GetBack1/Text2")
  self._itemCell = {
    panel = self:GetChild("Item"),
    mask = self:GetChild("Item/ItemCell/_BackGround/Mask"),
    frame = self:GetChild("Item/ItemCell/_BackGround/Frame"),
    icon = self:GetChild("Item/ItemCell/_BackGround/Icon"),
    count = self:GetChild("Item/ItemCell/_Count"),
    receivedBtn = self:GetChild("GetBack1"),
    getBtn = self:GetChild("GetBack2"),
    score = self:GetChild("NumFrame/Num")
  }
  self._itemCell.icon:Subscribe_PointerClickEvent(self.OnItemClicked, self)
end

function TaskAwardcell:OnDestroy()
end

function TaskAwardcell:RefreshCell(data)
  local state = data.state
  self._data = data
  self._itemCell.mask:SetActive(state ~= CommonAwardsSatus.UNLOCKED)
  self._itemCell.getBtn:SetActive(state == CommonAwardsSatus.UNLOCKED)
  self._itemCell.receivedBtn:SetActive(state == CommonAwardsSatus.FETCHED)
  local itemId = data.cfg.rewardItem[1]
  local needNum = data.cfg.rewardQuantity[1]
  local maxScore = data.cfg.rewardNum
  if itemId and itemId ~= 0 then
    local item = Item.Create(itemId)
    self._itemCell.panel:SetActive(true)
    self._itemCell.icon:SetSprite(item:GetIconAB())
    self._itemCell.frame:SetSprite(item:GetPinJiImageAB())
    self._itemCell.count:SetText(NumberManager.GetNumber(needNum))
    self._itemCell.score:SetText(maxScore)
    self._itemCell.item = item
  else
    self._itemCell.panel:SetActive(false)
    self._itemCell.score:SetText(maxScore)
    self._itemCell.getBtn:SetActive(false)
    self._itemCell.receivedBtn:SetActive(false)
  end
  self._processLine:SetFillAmount(data.process)
end

function TaskAwardcell:OnItemClicked()
  if self._data.state == CommonAwardsSatus.UNLOCKED then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cfetchanniversarymissionaward")
    csend.awardId = self._data.cfg.id
    csend:Send()
  else
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._itemCell.item
      })
    end
  end
end

return TaskAwardcell
