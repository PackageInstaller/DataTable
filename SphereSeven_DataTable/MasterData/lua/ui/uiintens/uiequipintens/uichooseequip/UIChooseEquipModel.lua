
--
-- <代码文件解释说明>
--

---@class UIChooseEquipModel : UIBaseModel
---@field oldEquip Equip | nil
local UIChooseEquipModel = BaseClass("UIChooseEquipModel",UIBaseModel)
local base = UIBaseModel
local this = UIChooseEquipModel

function this:OnCreate()
    base.OnCreate(self)
end

local equipSlot = {
    "Hand1Equip",
    "Hand2Equip",
    "BodyEquip",
    "HeadEquip",
    "FootEquip",
    "AdornEquip",
}

function this:OnEnable(data)
    if data == nil then data = {} end
    base.OnEnable(self)
    self.characterId = data.characterId
    self.slot = data.slot
    self.callBack = data.callBack
    -- local character = Game.Scene.Player:GetComponent("CardComponent"):Get(self.characterId)

    self:RefreshEquips()
    self:OnRefresh()
end

function this:OnRefresh()
    
end

--- 每次在view修改 slot 和 oldEquip 时都需要调用这个方法
function this:RefreshEquips()
    -- 直接每次在这里获取一次 当前的 equip 是什么
    local character = Game.Scene.Player:GetComponent("CardComponent"):Get(self.characterId)
    local equipComponent = Game.Scene.Player:GetComponent("EquipComponent")

    self.equips = {}
    for slot, value in ipairs(equipSlot) do
        local equipId = character[value]
        local equip
        if equipId ~= nil then
            equip = equipComponent:Get(equipId)
        end
        self.equips[slot] = equip
    end
    self.equipId = character[equipSlot[self.slot]]
    self.oldEquip = self.equips[self.slot]
end

function this:RefreshShowEquips()
    local equipComponent = Game.Scene.Player:GetComponent("EquipComponent")
    ---@type Equip[]
    self.showEquips = equipComponent:GetEquipList(self.slot, self.characterId)
    if self.oldEquip ~= nil then
        table.removeget(self.showEquips, function(equip)
            return equip.Id == self.oldEquip.Id
        end)
    end
end

local function ON_CARD_INFO_CHG(self)
    self:UIBroadcast(UIMessageNames.ON_CARD_INFO_CHG_ChOOSE_EQUIP)
end

local function  ON_EQUIP_UPDATE(self, data)
    self:UIBroadcast(UIMessageNames.ON_EQUIP_UPDATE, data)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_CARD_INFO_CHG,ON_CARD_INFO_CHG)
    self:AddDataListener(DataMessageNames.ON_EQUIP_UPDATE,ON_EQUIP_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_CARD_INFO_CHG)
    self:RemoveDataListener(DataMessageNames.ON_EQUIP_UPDATE)
end

return this
