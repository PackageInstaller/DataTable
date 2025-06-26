-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipchangenewpropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipChangeNewPropCell = class("EquipChangeNewPropCell", Dialog)
EquipChangeNewPropCell.AssetBundleName = "ui/layouts.equip"
EquipChangeNewPropCell.AssetName = "EquipPopPropContrast"
EquipChangeNewPropCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipChangeNewPropCell
  ((EquipChangeNewPropCell.super).Ctor)(self, ...)
end

EquipChangeNewPropCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

EquipChangeNewPropCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipChangeNewPropCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  (self._name):SetText(data.name)
  if data.value > 0 then
    data.value = (math.ceil)(data.value)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1205)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", tostring(data.value))
    ;
    (self._num):SetText(str)
  else
    do
      if data.value < 0 then
        data.value = (math.floor)(data.value)
        local str = (TextManager.GetText)((CStringRes:GetRecorder(1206)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", tostring(data.value))
        ;
        (self._num):SetText(str)
      else
        do
          if data.value == 0 then
            local str = (TextManager.GetText)((CStringRes:GetRecorder(1204)).msgTextID)
            ;
            (self._num):SetText(str)
          else
            do
              ;
              (self._num):SetText("")
            end
          end
        end
      end
    end
  end
end

return EquipChangeNewPropCell

