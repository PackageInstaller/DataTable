-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_equip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Equip = require("logic.manager.experimental.types.equip")
local BM_Equip = class("BM_Equip")
BM_Equip.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._equip = (NekoData.Data).equip
end

BM_Equip.GetEquipList = function(self)
  -- function num : 0_1 , upvalues : _ENV, Equip
  local equip = nil
  local equipList = {}
  local userId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  for equipType,list in pairs((self._equip)[userId]) do
    equipList[equipType] = {}
    for index,equipInfo in ipairs(list) do
      equip = (Equip.Create)(equipInfo)
      ;
      (table.insert)(equipList[equipType], equip)
    end
  end
  return equipList
end

BM_Equip.GetEquip = function(self, equipKey)
  -- function num : 0_2 , upvalues : _ENV, Equip
  local userId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid
  for equipType,list in pairs((self._equip)[userId]) do
    for index,equipInfo in ipairs(list) do
      if equipInfo.key == equipKey then
        return (Equip.Create)(equipInfo)
      end
    end
  end
end

return BM_Equip

