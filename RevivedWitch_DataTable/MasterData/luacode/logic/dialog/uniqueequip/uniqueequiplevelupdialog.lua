-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/uniqueequip/uniqueequiplevelupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UniqueEquipLevelUpDialog = class("UniqueEquipLevelUpDialog", Dialog)
UniqueEquipLevelUpDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipLevelUpDialog.AssetName = "CharEquipQHSuccess"
UniqueEquipLevelUpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UniqueEquipLevelUpDialog
  ((UniqueEquipLevelUpDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._dataList = {}
end

UniqueEquipLevelUpDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  (self:GetChild("Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1561))
  self._name = self:GetChild("Name")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("ItemCell/_BackGround/Icon")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._nextTips = self:GetChild("NextImage")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

UniqueEquipLevelUpDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

UniqueEquipLevelUpDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local imageRecord = (data.uniqueEquipItem):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.uniqueEquipItem):GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((data.uniqueEquipItem):GetName())
  for k,v in pairs(data.curattrs) do
    local lastValue = (data.lastattrs)[k]
    if not lastValue then
      do
        (table.insert)(self._dataList, {tag = "Attr", attrId = k, lastValue = (lastValue or v == 0) and not lastValue or lastValue == v or 0, curValue = v})
        -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (table.sort)(self._dataList, function(a, b)
    -- function num : 0_3_0 , upvalues : data
    do return (data.uniqueEquipItem):GetIndexByAttrId(a.attrId) < (data.uniqueEquipItem):GetIndexByAttrId(b.attrId) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if data.lastShowSKillId ~= data.curShowSKillId then
    (table.insert)(self._dataList, {tag = "Skill", lastSkillId = data.lastShowSKillId, curSkillId = data.curShowSKillId, roleId = (data.uniqueEquipItem):GetRoleId()})
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

UniqueEquipLevelUpDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._dataList
end

UniqueEquipLevelUpDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  local data = (self._dataList)[index]
  if data.tag == "Attr" then
    return "uniqueequip.uniqueequiplevelupattrcell"
  else
    if data.tag == "Skill" then
      return "uniqueequip.uniqueequiplevelupskillcell"
    end
  end
end

UniqueEquipLevelUpDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._dataList)[index]
end

UniqueEquipLevelUpDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return UniqueEquipLevelUpDialog

