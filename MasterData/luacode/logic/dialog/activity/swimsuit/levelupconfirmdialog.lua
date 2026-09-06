local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local LevelUpConfirmDialog = class("LevelUpConfirmDialog", Dialog)
LevelUpConfirmDialog.AssetBundleName = "ui/layouts.activitysummer"
LevelUpConfirmDialog.AssetName = "ActivitySummerLevelUpConfirm"

function LevelUpConfirmDialog:Ctor(...)
  LevelUpConfirmDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._consumeData = {}
  self._canLevelUp = true
end

function LevelUpConfirmDialog:OnCreate()
  self._consumePanel = self:GetChild("Frame")
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self._consumePanel:GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self._consumePanel:GetPosition()
  self._showText = self:GetChild("Text1")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmText = self:GetChild("CancelButton/_Text")
  self._cancelText = self:GetChild("ConfirmButton/_Text")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function LevelUpConfirmDialog:OnDestroy()
  self._consumeFrame:Destroy()
end

function LevelUpConfirmDialog:SetData(data, name)
  self._constructionId = data.landID
  self._nextConstructionLevel = data.level
  self._itemIDs = data.itemID
  self._itemAmount = data.itemAmount
  self._showText:SetText(TextManager.GetText(CStringRes:GetRecorder(1589).msgTextID, name, self._nextConstructionLevel - 1, self._nextConstructionLevel))
  self._consumeData = {}
  for i = 1, #self._itemIDs do
    table.insert(self._consumeData, {
      itemID = self._itemIDs[i],
      itemNum = self._itemAmount[i]
    })
  end
  self._confirmText:SetText(TextManager.GetText(CStringRes:GetRecorder(2).msgTextID))
  self._cancelText:SetText(TextManager.GetText(CStringRes:GetRecorder(1).msgTextID))
  self._canLevelUp = true
  local num = #self._itemIDs or 0
  local offset = self._size_offset_x / 6
  self._consumePanel:SetSize(self._size_x, offset * num * 2, self._size_y, self._size_offset_y)
  self._consumePanel:SetPosition(self._pos_x, -1 * offset * num, self._pos_y, self._pos_offset_y)
  self._consumeFrame = TableFrame.Create(self._consumePanel, self, false, false, false)
  self._consumeFrame:ReloadAllCell()
end

function LevelUpConfirmDialog:NumberOfCell(frame, index)
  return #self._consumeData
end

function LevelUpConfirmDialog:CellAtIndex(frame, index)
  return "activity.swimsuit.levelupconsumecell"
end

function LevelUpConfirmDialog:DataAtIndex(frame, index)
  return self._consumeData[index]
end

function LevelUpConfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function LevelUpConfirmDialog:OnConfirmBtnClicked()
  if self._canLevelUp then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cupdatesummerconstruction")
    if protocol then
      protocol.ID = self._constructionId
      protocol:Send()
    end
    self:Destroy()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100385)
  end
end

return LevelUpConfirmDialog
