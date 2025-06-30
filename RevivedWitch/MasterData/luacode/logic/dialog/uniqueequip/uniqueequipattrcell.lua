-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/uniqueequip/uniqueequipattrcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local UniqueEquipAttrCell = class("UniqueEquipAttrCell", Dialog)
UniqueEquipAttrCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipAttrCell.AssetName = "CharEquipPropertyCell"
UniqueEquipAttrCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UniqueEquipAttrCell
  ((UniqueEquipAttrCell.super).Ctor)(self, ...)
end

UniqueEquipAttrCell.OnCreate = function(self)
  -- function num : 0_1
  self._simplePanel = self:GetChild("Prop1")
  self._simplePanel_icon = self:GetChild("Prop1/Image")
  self._simplePanel_name = self:GetChild("Prop1/Name")
  self._simplePanel_num = self:GetChild("Prop1/Num")
  self._normalPanel = self:GetChild("Prop2")
  self._normalPanel_icon = self:GetChild("Prop2/Image")
  self._normalPanel_name = self:GetChild("Prop2/Name")
  self._normalPanel_curNum = self:GetChild("Prop2/Num")
  self._normalPanel_nextNum = self:GetChild("Prop2/Num2")
end

UniqueEquipAttrCell.OnDestroy = function(self)
  -- function num : 0_2
end

UniqueEquipAttrCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, CImagePathTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  if data.nextValue then
    (self._simplePanel):SetActive(false)
    ;
    (self._normalPanel):SetActive(true)
    ;
    (self._normalPanel_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._normalPanel_name):SetText((TextManager.GetText)(record.classnameTextID))
    if record.isDecimal == 1 then
      local str = data.attrValue / 1000 * 100
      ;
      (self._normalPanel_curNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {str}))
      str = data.nextValue / 1000 * 100
      ;
      (self._normalPanel_nextNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {str}))
    else
      do
        ;
        (self._normalPanel_curNum):SetText(data.attrValue)
        ;
        (self._normalPanel_nextNum):SetText(data.nextValue)
        ;
        (self._simplePanel):SetActive(true)
        ;
        (self._normalPanel):SetActive(false)
        ;
        (self._simplePanel_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._simplePanel_name):SetText((TextManager.GetText)(record.classnameTextID))
        if record.isDecimal == 1 then
          local str = data.attrValue / 1000 * 100
          ;
          (self._simplePanel_num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {str}))
        else
          do
            ;
            (self._simplePanel_num):SetText(data.attrValue)
          end
        end
      end
    end
  end
end

return UniqueEquipAttrCell

