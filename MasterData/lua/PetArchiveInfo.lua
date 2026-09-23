--宠物图鉴信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgPetArchive:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgPetArchive中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetGoods()
    if self.cfg and self.goods==nil then
        self.goods=BagMgr:GetFakeData(self.cfg.item);
        return self.goods
    end
    return self.goods or nil;
end

function this:GetDesc()
    return self.cfg and self.cfg.getDes or nil;
end

function this:GetQuality()
    return self.cfg and self.cfg.quality or 1;
end

function this:GetIcon()
    local goods=self:GetGoods();
    return goods and goods:GetIcon() or nil;
end

function this:IsLock()
    return PetActivityMgr:ItemIsLock(self:GetID());
end

function this:GetNO()
    return self.cfg and self.cfg.number or 0;
end

function this:GetNONumb()
    local num=self.cfg and self.cfg.number or 1
    local str="";
    if num>9 then
        return LanguageMgr:GetByID(62037)..num;
    else
        return LanguageMgr:GetByID(62037).."0"..num;
    end
    return str;
end


return this;