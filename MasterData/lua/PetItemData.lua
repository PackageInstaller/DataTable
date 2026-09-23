--宠物物品信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgPetItem:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgPetItem中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
    end
end

--根据物品ID初始化
function this:SetCfgByGoodsID(goodID)
    if goodID==nil then
        do return end
    end
    local goodInfo=BagMgr:GetFakeData(goodID);
    if goodInfo and goodInfo:GetDyVal1()==PROP_TYPE.PetItem then--宠物道具使用
        self:InitCfg(goodInfo:GetDyVal2());
    end
end

function this:GetCfg()
    return self.cfg;
end

function this:GetGoods()
    if self.cfg and self.goods==nil then
        self.goods=BagMgr:GetFakeData(self.cfg.item);
        return self.goods
    end
    return self.goods or nil;
end

function this:GetType2()
    return self.cfg and self.cfg.type or 1;
end

function this:GetHappyChange()
    if self.cfg then
        return self.cfg.happyChange
    end
    return 0
end

function this:GetFoodChange()
    if self.cfg  then
        return self.cfg.foodChange
    end
    return 0
end

function this:GetWashChange()
    if self.cfg then
        return self.cfg.washChange
    end
    return 0
end

function this:GetFeedChange()
    return self.cfg and self.cfg.feedChange or 0;
end

--使用之后触发的动画类型
function this:GetUseAnimaName()
    return self.cfg and self.cfg.animation or nil
end

function this:GetID()
    return self.cfg and self.cfg.id or 0;
end

function this:GetSort()
    return self.cfg and self.cfg.sort or 9999;
end

function this:GetGoodsID()
    return self.cfg and self.cfg.item or nil;
end

return this;
