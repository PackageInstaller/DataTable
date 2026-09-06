local TableFrame = require("framework.ui.frame.table.tableframe")
local UniqueEquipLevelUpDialog = class("UniqueEquipLevelUpDialog", Dialog)
UniqueEquipLevelUpDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipLevelUpDialog.AssetName = "CharEquipQHSuccess"

function UniqueEquipLevelUpDialog:Ctor(...)
  UniqueEquipLevelUpDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._dataList = {}
end

function UniqueEquipLevelUpDialog:OnCreate()
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1561))
  self._name = self:GetChild("Name")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._nextTips = self:GetChild("NextImage")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function UniqueEquipLevelUpDialog:OnDestroy()
  self._frame:Destroy()
end

function UniqueEquipLevelUpDialog:SetData(data)
  local imageRecord = data.uniqueEquipItem:GetIcon()
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.uniqueEquipItem:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(data.uniqueEquipItem:GetName())
  for k, v in pairs(data.curattrs) do
    local lastValue = data.lastattrs[k]
    if not lastValue and v ~= 0 or lastValue and lastValue ~= v then
      table.insert(self._dataList, {
        tag = "Attr",
        attrId = k,
        lastValue = lastValue or 0,
        curValue = v
      })
    end
  end
  table.sort(self._dataList, function(a, b)
    return data.uniqueEquipItem:GetIndexByAttrId(a.attrId) < data.uniqueEquipItem:GetIndexByAttrId(b.attrId)
  end)
  if data.lastShowSKillId ~= data.curShowSKillId then
    table.insert(self._dataList, {
      tag = "Skill",
      lastSkillId = data.lastShowSKillId,
      curSkillId = data.curShowSKillId,
      roleId = data.uniqueEquipItem:GetRoleId()
    })
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function UniqueEquipLevelUpDialog:NumberOfCell(frame, index)
  return #self._dataList
end

function UniqueEquipLevelUpDialog:CellAtIndex(frame, index)
  local data = self._dataList[index]
  if data.tag == "Attr" then
    return "uniqueequip.uniqueequiplevelupattrcell"
  elseif data.tag == "Skill" then
    return "uniqueequip.uniqueequiplevelupskillcell"
  end
end

function UniqueEquipLevelUpDialog:DataAtIndex(frame, index)
  return self._dataList[index]
end

function UniqueEquipLevelUpDialog:OnBackBtnClicked()
  self:Destroy()
end

return UniqueEquipLevelUpDialog
