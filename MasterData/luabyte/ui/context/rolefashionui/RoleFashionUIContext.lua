local M = BaseClass("RoleFashionUIContext", BaseContext)
local MessageId = Proto.MessageId

function M:Init()
    NetPack:RegistResponse(MessageId.ResponseChangeFashion, Bind(self, self.OnResponseChangeFashion))
    self.isFromShop = false
    self.isHave = false
end

function M:Open(heroId, isFromShop)
    self:UpdateHeroData(heroId)
    self.isFromShop = isFromShop
    self:_Show(heroId, self.isFromShop)
end

function M:GetData()
    local dataList = {}
    local configs = RechargeDataMgr:GetInstance():GetClothCfgs()
    if self.isFromShop then
        for key, value in pairs(configs) do
            local data = {}
            local skinCfg = ConfigHelper.GetCfgByLua("skin", value.itemId)
            data.shopCfg = value
            data.skinCfg = skinCfg
            table.insert(dataList, data)
        end
    else
        local skins = self:GetHeroAllSkins()
        for key, skin in pairs(skins) do
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
    end
    return dataList
end

function M:GetItemFromSkin(skinId)
    -- JSkin中id即为skinId
    local itemCfg = ConfigHelper.GetCfgByLua("item", skinId) or {}
    return itemCfg
end

function M:UpdateHeroData(heroId)
    self.heroId = heroId
    if IHeroDataMgr:HasHero(self.heroId) then
        self.curHeroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
        self.isHave = true
    else
        --获取英雄模板数据
        self.curHeroData = IHeroDataMgr:GetHeroDataById(self.heroId)
        self.isHave = false
    end
end 

function M:GetHeroData()
    return self.curHeroData
end

function M:GetCurHeroSkin()
    return IHeroDataMgr:GetHeroSkin(self.heroId, self.curHeroData:GetFashion())
end

function M:GetCurHeroFashion()
    return self.curHeroData:GetFashion()
end

function M:GetHeroSkin()
    return self.curHeroData:GetSkinCfg()
end

function M:GetHeroAllSkins()
    return self.curHeroData:GetHeroAllSkins()
end

function M:GetDressingId()
    -- 服务器正在穿的时装
end

function M:C2S_Dress(fashionId, callback)
    -- 穿时装
    self.changeFashinCallback = callback
    local data = {}
    data.HeroId = self.heroId
    data.FashionId = fashionId
    NetPack:SendMessage(MessageId.RequestChangeFashion, data)
end

function M:OnResponseChangeFashion(_, result, msg)
    if result ~= 0 then return end
    self.curHeroData:SetFashion(msg.FashionId)
    EventMgr:Broadcast(UIMessageNames.ROLE_FASHION_CHANGE)
    if self.changeFashinCallback then
        self.changeFashinCallback()
    end 
end

function M:C2S_BuyFashion(data)
    -- 购买时装
    UIContextMgr:GetInstance():Show("ClothBuyPopupUI", data)
end

function M:C2S_GoToGet()
    -- 跳转获取
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return M
