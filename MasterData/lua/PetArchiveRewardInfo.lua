--宠物图鉴奖励信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId,idx)
    if cfgId then
        self.cfg=Cfgs.CfgPetArchiveReward:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgPetRandomReward中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or 0;
end

function this:GetArchive()
    return self.cfg and self.cfg.archive or nil;
end

function this:GetReward()
    return self.cfg and self.cfg.reward or nil;
end

function this:GetArchiveList()
    local ids=self:GetArchive();
    if ids then
        local list={};
        for k, v in ipairs(ids) do
            local item=PetArchiveInfo.New();
            item:InitCfg(v);
            table.insert(list,item);
        end
        return list;
    end
    return nil;
end

--1:未解锁，2：未领取,3：已领取
function this:GetState()
    local state=1;
    local ids=self:GetArchive();
    if ids then
        local isFull=true
        for k,v in ipairs(ids) do
            if PetActivityMgr:ItemIsLock(v) then
                isFull=false;
                break;
            end
        end
        if isFull then
            state=PetActivityMgr:BookIsLock(self:GetID()) and 2 or 3;
        end
    end
    return state;
end

return this;