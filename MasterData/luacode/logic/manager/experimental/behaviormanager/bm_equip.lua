local Equip = require("logic.manager.experimental.types.equip")
local BM_Equip = class("BM_Equip")

function BM_Equip:Ctor()
  self._equip = NekoData.Data.equip
end

function BM_Equip:GetEquipList()
  local equip
  local equipList = {}
  local userId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  for equipType, list in pairs(self._equip[userId]) do
    equipList[equipType] = {}
    for index, equipInfo in ipairs(list) do
      equip = Equip.Create(equipInfo)
      table.insert(equipList[equipType], equip)
    end
  end
  return equipList
end

function BM_Equip:GetEquip(equipKey)
  local userId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  for equipType, list in pairs(self._equip[userId]) do
    for index, equipInfo in ipairs(list) do
      if equipInfo.key == equipKey then
        return Equip.Create(equipInfo)
      end
    end
  end
end

return BM_Equip
