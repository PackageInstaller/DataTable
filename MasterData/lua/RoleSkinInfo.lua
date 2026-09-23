-- 皮肤
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

--[[
CardSkinType = {}
CardSkinType.Break = 1 -- 突破皮肤
CardSkinType.Skin = 2 -- 额外
]]
-- ==============================--
-- desc:
-- time:2019-08-19 11:34:07
-- @_cardId:卡id
-- @_skinid:皮肤id
-- @_minBreakLv:最低可用的突破等级
-- @_type:皮肤类型
-- @_typeNum:         
-- @return
-- ==============================--
function this:Set(_roleID, _cardID, _skinID, _minBreakLv, _type, _isJieJin, _jiejinCondition)
    self.roleID = _roleID
    self.cardID = _cardID
    self.skinID = _skinID
    self.minBreakLv = _minBreakLv or 2
    self.type = _type or CardSkinType.Break
    -- self.typeNum = _typeNum
    self.isJieJin = _isJieJin
    self.jiejinCondition = _jiejinCondition
    self:SetIndex()
end

function this:GetSkinID()
    return self.skinID
end

function this:SetIndex()
    local add = self.type * 10
    self.index = add + self.minBreakLv
end

-- 排序index
function this:GetIndex()
    return self.index
end

-- 某卡牌是否可以使用这个皮肤
-- function this:CheckCanUse(cardData)
function this:CheckCanUse()
    if (self.isJieJin and self.jiejinCondition ~= nil and not MenuMgr:CheckConditionIsOK({self.jiejinCondition})) then
        return false
    end
    if (self.type == CardSkinType.Break) then
        -- local cardData = RoleMgr:GetData(self.cardID)
        -- local lv = cardData and cardData:GetBreakLevel() or 1
        -- if (self.minBreakLv > 1 and lv < self.minBreakLv) then
        --     return false
        -- else
        --     return true
        -- end
        local cRoleData = CRoleMgr:GetData(self.roleID)
        local lv = cRoleData and cRoleData:GetBreakLevel() or 1
        if (lv >= self.minBreakLv) then
            return true
        end
        return false
    else
        return self:GetCanUse()
    end
end

-- 皮肤是否已解锁或获得
function this:CheckCanUseByMaxLV()
    if (self.type == CardSkinType.Break) then
        local cRoleData = CRoleMgr:GetData(self.roleID)
        local lv = cRoleData and cRoleData:GetBreakLevel() or 1
        if (lv >= self.minBreakLv) then
            return true
        end
        return false
    else
        return self:GetCanUse()
    end
end

-- 设置额外皮肤是否可用,过期时间,获得时间
function this:SetCanUse(b, t,t2)
    self.canUse = b
    self.limitTime = t
    self.nTime = t2 or 0
end

function this:GetCanUse()
    return self.canUse or false
end

function this:GetCfg()
    if (not self.cfg) then
        self.cfg = Cfgs.character:GetByID(self:GetSkinID())
    end
    return self.cfg
end

-- function this:GetImg()
-- 	return self.cfg and self.cfg.smallImg or nil
-- end
function this:GetName()
    return self:GetCfg() and self:GetCfg().desc or ""
end

function this:GetEnglishName()
    return self:GetCfg() and self:GetCfg().englishName or ""
end

function this:GetDesc()
    return self:GetCfg() and self:GetCfg().model_desc or ""
end

function this:GetCardId()
    return self.cardID or nil
end

function this:SetRoleId(_id)
    self.roleId = _id
end

function this:GetRoleId()
    return self.roleId
end

-- function this:GetTypeNum()
--     return self.typeNum
-- end

function this:CheckIsNew()
    if (not self:CheckCanUse()) then
        return false
    end
    local cRoleData = CRoleMgr:GetData(self:GetCfg().role_id)
    if (cRoleData) then
        return cRoleData:CheckSkinIsNew(self:GetSkinID())
    end
    return false
end

-- 突破类型皮肤
function this:CheckIsBreakType()
    return self.type == CardSkinType.Break
end

-- 是否是非突破类型皮肤
function this:CheckIsNotBreakType()
    return self.type ~= CardSkinType.Break
end

-- 非突破类型皮肤，是否出售中
function this:IsInSell()
    if (not self:CheckIsNotBreakType()) then
        return false
    end
    local shopId = self:GetCfg().shopId
    local cfg = shopId and Cfgs.CfgCommodity:GetByID(shopId) or nil
    if (cfg) then
        local curTime = TimeUtil:GetTime()
        -- local startTime = cfg.sBuyStart and TimeUtil:GetTimeStampBySplit(cfg.sBuyStart) or nil
        -- local sBuyEnd = cfg.sBuyEnd and TimeUtil:GetTimeStampBySplit(cfg.sBuyEnd) or nil
        local itemData = ShopMgr:GetFixedCommodity(shopId)
        if (itemData and itemData:GetNowTimeCanBuy() and itemData:IsShow()) then
            return true
        end
    end
    return false
end

-- 皮肤类型
function this:GetSkinType()
    return self:GetCfg().skinType or 0
end

-- CardSkinType
function this:GetType()
    return self.type
end

-- 是否是商店物品
function this:CheckIsShopItem()
    return self:GetCfg().shopId ~= nil
end

-- 和谐中
function this:IsHX()
    if (not self:CheckCanUse() and self:CheckIsShopItem()) then
        local cfg = Cfgs.CfgCommodity:GetByID(self:GetCfg().shopId)
        if (cfg and cfg.isShowImg == 1) then
            return true
        end
    end
    return false
end

function this:GetTxt()
    return self:GetCfg().get_txt
end

-- 
function this:IsThisCard(cardID)
    if (self.cardID == cardID) then
        return true
    end
end

function this:CheckIsJieJin()
    return self.isJieJin
end

-- 是否在看板和头像 隐藏
function this:IsHide()
    local cfg=self:GetCfg();
    if cfg then
        return self.cfg.isHide
    else
        LogError("模型表中未找到配置:"..tostring(self:GetSkinID()))
        return false;
    end
end

function this:GetL2dName()
    local cfgModel = Cfgs.character:GetByID(self:GetSkinID())
    return cfgModel.l2dName
end

-- 能否展示l2d 
function this:CanShowL2d()
    if (self:GetL2dName() ~= nil) then
        if (self:CheckIsBreakType()) then
            if(g_FHXOpenRole)then 
                return self:CheckCanUse()
            end
        end
        return true
    end
    return false
end

--是否展示l2d(g_FHXOpenRole为true，突破模型要先突破，商店皮肤不用管)
function this:ToShowL2d()
    if(self:CanShowL2d())then 
        if (self:CheckIsBreakType()) then
            return true
        else
            return g_FHXOpenSkin==nil
        end
    end 
    return false
end

-- 是否是限时皮肤，是否过期，过期时间
function this:IsLimitSkin()
    if (self.limitTime) then
        return true, self.limitTime
    end
    return false
end

--获得时间
function this:GetNTime()
    return self.nTime or 0
end

return this
