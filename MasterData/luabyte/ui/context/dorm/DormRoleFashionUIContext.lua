local M = BaseClass("DormRoleFashionUIContext", BaseContext)
local MessageId = Proto.MessageId

function M:Init()
    NetPack:RegistResponse(MessageId.ResponseChangeDormFashion, Bind(self, self.OnResponseChangeDormFashion))
    self.isHave = false
end

function M:Open(heroId)
    self:UpdateHeroData(heroId)
    self:_Show(heroId)
end

function M:GetData()
    local dataList = {}
    local configs = RechargeDataMgr:GetInstance():GetClothCfgs()
    local roomskins = self:GetHeroAllSkins()
    for key, skin in pairs(roomskins) do
        local data = {}
        local shopCfg = nil
        for key, value in pairs(configs) do
            if value.itemId == skin.id then
                shopCfg = value
            end
        end
        data.shopCfg = shopCfg
        data.skinCfg = skin
        table.insert(dataList, data)
    end
    return dataList
end

function M:GetItemFromSkin(skinId)
    local itemCfg = ConfigHelper.GetCfgByLua("item", skinId) or {}
    return itemCfg
end

function M:UpdateHeroData(heroId)
    self.heroId = heroId
    self.curHeroData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    self.isHave = true
end 

function M:GetHeroData()
    return self.curHeroData
end

function M:GetCurHeroFashion()
    return self.curHeroData.Fashion
end

function M:GetHeroAllSkins()
    local cfgs = ConfigHelper.GetCfgsByLua("roomSkin",{heroId = self.heroId})
    return cfgs
end

function M:C2S_Dress(fashionId, callback)
    -- 穿时装
    self.changeFashinCallback = callback
    local data = {}
    data.HeroId = self.heroId
    data.FashionId = fashionId
    NetPack:SendMessage(MessageId.RequestChangeDormFashion, data)
end

function M:OnResponseChangeDormFashion(_, result, msg)
    if result ~= 0 then return end
    self.curHeroData:UpdateFashion(msg.FashionId)
    EventMgr:Broadcast(UIMessageNames.ROLE_FASHION_CHANGE)
    if self.changeFashinCallback then
        self.changeFashinCallback()
    end 
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return M
