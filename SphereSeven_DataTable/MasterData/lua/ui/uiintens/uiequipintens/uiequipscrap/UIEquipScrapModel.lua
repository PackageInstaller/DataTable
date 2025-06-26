
--
-- <代码文件解释说明>
--

---@class UIEquipScrapModel : UIBaseModel
local UIEquipScrapModel = BaseClass("UIEquipScrapModel",UIBaseModel)
local base = UIBaseModel
local this = UIEquipScrapModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.equipList = Game.Scene.Player:GetComponent("EquipComponent"):GetEquipList()
end

local function ON_EQUIP_UPDATE(self, data)
    self.equipList = Game.Scene.Player:GetComponent("EquipComponent"):GetEquipList()
    self:UIBroadcast(UIMessageNames.ON_EQUIP_UPDATE, data)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_EQUIP_UPDATE,ON_EQUIP_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_EQUIP_UPDATE)
end

return this
