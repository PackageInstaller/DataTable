local TaskAwardcell = class("TaskAwardcell", Dialog)
local Item = require("logic.manager.experimental.types.item")
TaskAwardcell.AssetBundleName = "ui/layouts.activitycommon"
TaskAwardcell.AssetName = "ActivityCommon1TaskProgressCell"

function TaskAwardcell:Ctor(...)
  TaskAwardcell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TaskAwardcell:OnCreate()
  self._processLineBack = self:GetChild("LinebBack")
  self._processLine = self:GetChild("LinebBack/Line")
  self._DotGrey = self:GetChild("DotGrey")
  self._Dot = self:GetChild("DotGrey/Dot")
  self:GetChild("Item/GetBack2/Text1")
  self:GetChild("Item/GetBack1/Text2")
  self._itemCell = {
    mask = self:GetChild("Item/ItemCell/_BackGround/Mask"),
    frame = self:GetChild("Item/ItemCell/_BackGround/Frame"),
    icon = self:GetChild("Item/ItemCell/_BackGround/Icon"),
    count = self:GetChild("Item/ItemCell/_Count"),
    receivedBtn = self:GetChild("Item/GetBack1"),
    getBtn = self:GetChild("Item/GetBack2"),
    score = self:GetChild("NumFrame/Num"),
    getBack2 = self:GetChild("NumFrame/NumBack2"),
    getBack1 = self:GetChild("NumFrame/NumBack1")
  }
  self._itemCell.getBtn:Subscribe_PointerClickEvent(self.OnCommitClick, self)
end

function TaskAwardcell:OnDestroy()
end

function TaskAwardcell:RefreshCell(data)
  local state = data.state
  self._data = data
  self._itemCell.mask:SetActive(state ~= 1)
  self._itemCell.getBack1:SetActive(state ~= 0)
  self._itemCell.getBack2:SetActive(state == 0)
  if state == 0 then
    self._Dot:SetActive(false)
  else
    self._Dot:SetActive(true)
  end
  self._itemCell.getBtn:SetActive(state == 1)
  self._itemCell.receivedBtn:SetActive(state == 2)
  local itemId = data.cfg.rewardItem
  local needNum = data.cfg.rewardNum
  local maxScore = data.cfg.needNum
  self._processLineBack:SetActive(true)
  local item = Item.Create(itemId)
  self._itemCell.icon:SetSprite(item:GetIconAB())
  self._itemCell.frame:SetSprite(item:GetPinJiImageAB())
  self._itemCell.count:SetText(NumberManager.GetNumber(needNum))
  self._itemCell.score:SetText(maxScore)
  self._processLine:SetFillAmount(data.process)
end

function TaskAwardcell:OnCommitClick()
  if self._data.state == 1 then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.creceivetaskshop")
    csend.activityId = self._delegate._delegate._actId
    csend.rewardID = self._data.cfg.id
    csend:Send()
  end
end

function TaskAwardcell:OnItemClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell.item
    })
  end
end

return TaskAwardcell
