
--
-- <代码文件解释说明>
--

---@class UIGameEventLevelStoreModel : UIBaseModel
local UIGameEventLevelStoreModel = BaseClass("UIGameEventLevelStoreModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventLevelStoreModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.eventId = data.eventId
    self.moduleId = data.moduleId
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    self.gameEvent = gameEventComponent:GetGameEvent(self.eventId)
    self.module = gameEventComponent:GetGameEventModule(self.moduleId)

    self.UILandladyId = 1011
    self.imageIndex = 0
    if self.module.config.ImageParams[1] ~= nil then
        self.UILandladyId = self.module.config.ImageParams[1]
    end
    if self.module.config.ImageParams[2] ~= nil then
        self.imageIndex = self.module.config.ImageParams[2]
    end

    ---@type ShopComponent
    local shopComponent = Game.Scene.Player:GetComponent("ShopComponent")

    local group = self.module.config.ModuleParams[1]
    self.goods = {}
    for key, value in pairs(Z_Store) do
        if value.Group == group then
            local good = shopComponent.PurchasesDetailList[value.StoreType][value.Id]
            if UIPublic.GiftPackageIsShow(value) then
                if good ~= nil then
                    local is_sell_out = good.buy_times >= value.QuotaNum
                    if value.QuotaPeriod == 0 then
                        is_sell_out = false
                    end
                    table.insert(self.goods, {
                        id = value.Id,
                        buy_times = good.buy_times,
                        refresh_time = good.refresh_time,
                        is_sell_out = is_sell_out,
                        config = value,
                        weight = value.Weight
                    })
                else
                    table.insert(self.goods, {
                        id = value.Id,
                        buy_times = 0,
                        refresh_time = 0,
                        is_sell_out = false,
                        config = value,
                        weight = value.Weight
                    })
                end
            end
        end
    end
    table.sort(self.goods, function(a, b)
        -- is_sell_out 为true的在后面
        if a.weight ~= b.weight then
            return a.weight > b.weight
        end
        if a.is_sell_out ~= b.is_sell_out then
            return not a.is_sell_out
        end
        -- 未售罄的按照id排序
        return a.id < b.id
    end)
end

local function OnItemInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_ITEM_INFO_CHG)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_ITEM_INFO_CHG, OnItemInfoChg)
    -- self:AddDataListener(DataMessageNames.xxx,func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_INFO_CHG)
    -- self:RemoveDataListener(DataMessageNames.xxx)
end

return this
