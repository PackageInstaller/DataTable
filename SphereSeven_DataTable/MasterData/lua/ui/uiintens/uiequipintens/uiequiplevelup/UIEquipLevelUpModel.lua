
--
-- <代码文件解释说明>
--

---@class UIEquipLevelUpModel : UIBaseModel
local UIEquipLevelUpModel = BaseClass("UIEquipLevelUpModel",UIBaseModel)
local base = UIBaseModel
local this = UIEquipLevelUpModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.equipId = data.equipId
    ---@type Equip
    self.equip = Game.Scene.Player:GetComponent("EquipComponent"):Get(self.equipId)
    self:OnRefresh()
end

function this:OnRefresh()

end

local function ON_EQUIP_UPDATE(self, data)
    self.equip = Game.Scene.Player:GetComponent("EquipComponent"):Get(self.equipId)
    self:UIBroadcast(UIMessageNames.ON_EQUIP_UPDATE, data)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_EQUIP_UPDATE, ON_EQUIP_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_EQUIP_UPDATE)
end

return this
