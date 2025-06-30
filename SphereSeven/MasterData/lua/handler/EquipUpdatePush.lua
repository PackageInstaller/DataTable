
--
-- <代码文件解释说明>
--

local EquipUpdatePush = BaseClass("EquipUpdatePush",IMHandler)

-- 断线重连触发事件
EquipUpdatePush.__init = function(self)

end

EquipUpdatePush.Handle = function(self,pbMsg)
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end
        ---@type EquipComponent
        local EquipComponent = Game.Scene.Player:GetComponent("EquipComponent")

        local data = {isUpdate = false, isRemove = false}
        if pbMsg.equipment_pack ~= nil then
            EquipComponent:UpdateEquip(pbMsg.equipment_pack)
            data.isUpdate = true
        end

        for key, value in pairs(pbMsg.removeds) do
            EquipComponent:Remove(value)
            data.isRemove = true
        end

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_EQUIP_UPDATE, data)
    end)
end

return EquipUpdatePush
