local DefaultColumnNums = 2
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local UniqueEquipUnlockDialog = class("UniqueEquipUnlockDialog", Dialog)
UniqueEquipUnlockDialog.AssetBundleName = "ui/layouts.baseshop"
UniqueEquipUnlockDialog.AssetName = "ExclusiveEquipGet"

function UniqueEquipUnlockDialog:Ctor(...)
  UniqueEquipUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._showNextTips = false
  self._gameTimerID = nil
  self._attrList = {}
end

function UniqueEquipUnlockDialog:OnCreate()
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1559))
  self._title = self:GetChild("Panel/Name")
  self._charName = self:GetChild("Panel/CharName")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._attrPanel = self:GetChild("Panel/Property")
  self._attrFrame = TableFrame.Create(self._attrPanel, self, false, false)
  self._attrFrame_width, self._attrFrame_height = self._attrPanel:GetRectSize()
  self._attrFrame_anchoredx, self._attrFrame_anchoredy = self._attrPanel:GetAnchoredPosition()
  self._skillEffect = self:GetChild("Panel/Txt2")
  self._nextTips = self:GetChild("NextImage")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._nextTips:SetActive(self._showNextTips)
  self._gameTimerID = GameTimer.AddTask(2, -1, function()
    self._showNextTips = true
    self._nextTips:SetActive(self._showNextTips)
  end)
end

function UniqueEquipUnlockDialog:OnDestroy()
  self._attrFrame:Destroy()
  if self._gameTimerID then
    GameTimer.RemoveTask(self._gameTimerID)
    self._gameTimerID = nil
  end
end

function UniqueEquipUnlockDialog:SetData(data)
  self._title:SetText(data.uniqueEquipItem:GetName())
  local imageRecord = data.uniqueEquipItem:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.uniqueEquipItem:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local role = Role.Create(data.uniqueEquipItem:GetRoleId())
  if role:GetRoleId() == DataCommon.LeaderId then
    self._charName:SetText(NekoData.BehaviorManager.BM_Message:GetString(1433))
  else
    self._charName:SetText(role:GetRoleName())
  end
  for k, v in pairs(data.attrs) do
    if v ~= 0 then
      table.insert(self._attrList, {attrId = k, attrValue = v})
    end
  end
  self._skillEffect:SetText(NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(data.showSKillId))
  table.sort(self._attrList, function(a, b)
    return data.uniqueEquipItem:GetIndexByAttrId(a.attrId) < data.uniqueEquipItem:GetIndexByAttrId(b.attrId)
  end)
  self._attrFrame:ReloadAllCell()
  local cellPanelWidth = self._attrFrame_width / DefaultColumnNums * #self._attrList
  self._attrPanel:SetSize(0, cellPanelWidth, 0, self._attrFrame_height)
  self._attrPanel:SetAnchoredPosition(self._attrFrame_anchoredx, self._attrFrame_anchoredy)
  self._attrFrame:ReloadAllCell()
end

function UniqueEquipUnlockDialog:NumberOfCell(frame, index)
  return #self._attrList
end

function UniqueEquipUnlockDialog:CellAtIndex(frame, index)
  return "uniqueequip.uniqueequipunlockattrcell"
end

function UniqueEquipUnlockDialog:DataAtIndex(frame, index)
  return self._attrList[index]
end

function UniqueEquipUnlockDialog:OnBackBtnClicked()
  if self._showNextTips then
    self:Destroy()
  end
end

return UniqueEquipUnlockDialog
