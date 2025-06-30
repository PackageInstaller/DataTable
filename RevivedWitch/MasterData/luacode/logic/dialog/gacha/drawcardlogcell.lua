-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/drawcardlogcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TextStaticFunctions = (((CS.PixelNeko).Lua).UI).TextStaticFunctions
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CCardPool = (BeanManager.GetTableByName)("item.ccardpool")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CUniqueEquipItem = (BeanManager.GetTableByName)("item.cuniqueequipitem")
local DrawCardLogCell = class("DrawCardLogCell", Dialog)
DrawCardLogCell.AssetBundleName = "ui/layouts.gacha"
DrawCardLogCell.AssetName = "GachaRecordCell"
DrawCardLogCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DrawCardLogCell
  ((DrawCardLogCell.super).Ctor)(self, ...)
end

DrawCardLogCell.OnCreate = function(self)
  -- function num : 0_1
  local transform = ((self:GetRootWindow())._uiObject).transform
  self._time = (transform:Find("Time")).gameObject
  self._txt = (transform:Find("Txt")).gameObject
  self._detail = (transform:Find("Detail")).gameObject
end

DrawCardLogCell.OnDestroy = function(self)
  -- function num : 0_2
end

DrawCardLogCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCardPool, _ENV, TextStaticFunctions, CStringres
  local cardPoolRecord = CCardPool:GetRecorder(data.poolId)
  if cardPoolRecord.cardpooltype == 2 then
    self._isEquipCardPool = true
  end
  local str = ""
  str = str .. (os.date)("%Y-%m-%d", data.time // 1000) .. " "
  str = str .. (os.date)("%H", data.time // 1000) .. ":"
  str = str .. (os.date)("%M", data.time // 1000) .. ":"
  str = str .. (os.date)("%S", data.time // 1000)
  ;
  (TextStaticFunctions.SetText)(self._time, str)
  if data.drawType == 1 then
    local str = ""
    str = (TextManager.GetText)((CStringres:GetRecorder(1156)).msgTextID)
    local poolName = (TextManager.GetText)(cardPoolRecord.poolNameTextID)
    str = (string.gsub)(str, "%$parameter1%$", poolName)
    str = (string.gsub)(str, "%$parameter2%$", 1)
    ;
    (TextStaticFunctions.SetText)(self._txt, str)
    str = self:GetRoleName(data, 1)
    str = (string.sub)(str, 1, -3)
    ;
    (TextStaticFunctions.SetText)(self._detail, str)
  else
    do
      local str = ""
      str = (TextManager.GetText)((CStringres:GetRecorder(1156)).msgTextID)
      local poolName = (TextManager.GetText)(cardPoolRecord.poolNameTextID)
      str = (string.gsub)(str, "%$parameter1%$", poolName)
      str = (string.gsub)(str, "%$parameter2%$", 10)
      ;
      (TextStaticFunctions.SetText)(self._txt, str)
      local msg = ""
      for i = 1, 10 do
        msg = msg .. self:GetRoleName(data, i)
      end
      msg = (string.sub)(msg, 1, -3)
      ;
      (TextStaticFunctions.SetText)(self._detail, msg)
    end
  end
end

DrawCardLogCell.GetRoleName = function(self, data, id)
  -- function num : 0_4 , upvalues : CRoleItem, RoleConfigTable, _ENV, CItemAttrTable, CUniqueEquipItem
  if not self._isEquipCardPool then
    if (CRoleItem:GetRecorder((data.cardList)[id])).roleid ~= nil then
      local num = (CRoleItem:GetRecorder((data.cardList)[id])).roleid
      local level = (RoleConfigTable:GetRecorder(num)).rarity
      if RoleConfigTable:GetRecorder(num) ~= nil then
        local name = (TextManager.GetText)((RoleConfigTable:GetRecorder(num)).nameTextID)
        local msg = ""
        if level == 1 then
          msg = ((NekoData.BehaviorManager).BM_Message):GetString(1623, {"R", name}) .. " / "
        else
          if level == 2 then
            msg = ((NekoData.BehaviorManager).BM_Message):GetString(1623, {"SR", name}) .. " / "
          else
            if level == 3 then
              msg = ((NekoData.BehaviorManager).BM_Message):GetString(1623, {"SSR", name}) .. " / "
            else
              if level == 4 then
                msg = ((NekoData.BehaviorManager).BM_Message):GetString(1623, {"UR", name}) .. " / "
              end
            end
          end
        end
        return msg
      else
        do
          do
            do return "" end
            do return "" end
            local itemId = (data.cardList)[id]
            local itemRecord = CItemAttrTable:GetRecorder(itemId)
            if itemRecord then
              local itemtypeid = itemRecord.itemtypeid
              local msg = ""
              if itemtypeid == (DataCommon.ItemType).UniqueEquip then
                local itemNameStr = ""
                local roleNameStr = ""
                itemNameStr = (TextManager.GetText)(itemRecord.nameTextID)
                local uniqueEquipItemRecord = CUniqueEquipItem:GetRecorder(itemId)
                if uniqueEquipItemRecord then
                  local roleId = uniqueEquipItemRecord.roleid
                  local roleConfigRecord = RoleConfigTable:GetRecorder(roleId)
                  if roleConfigRecord then
                    if roleId == DataCommon.LeaderId then
                      roleNameStr = ((NekoData.BehaviorManager).BM_Message):GetString(1433)
                    else
                      roleNameStr = (TextManager.GetText)(roleConfigRecord.nameTextID)
                    end
                  else
                    LogErrorFormat("DrawCardLogCell", "role with id %s is not exist in roleconfig", roleId)
                  end
                else
                  do
                    do
                      LogErrorFormat("DrawCardLogCell", "uniqueEquip with id %s is not exist in cuniqueequipitem", itemId)
                      msg = ((NekoData.BehaviorManager).BM_Message):GetString(1563, {itemNameStr, roleNameStr})
                      if itemtypeid == 299 or itemtypeid == 811 or itemtypeid == 555 then
                        msg = (TextManager.GetText)(itemRecord.nameTextID)
                      else
                        local num = (data.cardNumList)[id]
                        msg = ((NekoData.BehaviorManager).BM_Message):GetString(1564, {(TextManager.GetText)(itemRecord.nameTextID), num})
                      end
                      do
                        do
                          msg = msg .. " / "
                          do return msg end
                          LogErrorFormat("DrawCardLogCell", "item with id %s is not exist in citemattr", itemId)
                          do return "" end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return DrawCardLogCell

