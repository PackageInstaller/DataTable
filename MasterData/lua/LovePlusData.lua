local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:InitCfg(cfg)
    self.cfg = cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetTitle()
    return self.cfg and self.cfg.datechapter or ""
end

function this:GetName()
    local cfg =self:GetRoleCfg()
    if cfg and cfg.sAliasName then
        return cfg.sAliasName
    end
     return ""
end

--角色配置
function this:GetRoleCfg()
    if self.cfg and self.cfg.roleId then
        local cfg = Cfgs.CfgCardRole:GetByID(self.cfg.roleId)
        if cfg then
            return cfg
        end
    end
end

--入口图片配置
function this:GetImgCfgs()
    if self.imgCfgs == nil then
        local cfgs = {}
        if self.cfg and self.cfg.entranceImg then
            local _cfgs = Cfgs.CfgDateSeriesImg:GetGroup(self.cfg.entranceImg)
            if _cfgs then
                for _, cfg in pairs(_cfgs) do
                    table.insert(cfgs,cfg)
                end
            end
        end
        if #cfgs>0 then
            table.sort(cfgs,function (a,b)
                return a.id < b.id
            end)
            self.imgCfgs = cfgs
        end
    end
    return self.imgCfgs
end

--聊天图片配置
function this:GetChatImgCfgs()
    if self.chatImgCfgs == nil then
        local cfgs = {}
        if self.cfg and self.cfg.chatSeriesImg then
            local _cfgs = Cfgs.CfgDateSeriesImg:GetGroup(self.cfg.chatSeriesImg)
            if _cfgs then
                for _, cfg in pairs(_cfgs) do
                    table.insert(cfgs,cfg)
                end
            end
        end
        if #cfgs>0 then
            table.sort(cfgs,function (a,b)
                return a.id < b.id
            end)
            self.chatImgCfgs = cfgs
        end
    end
    return self.chatImgCfgs
end

function this:GetBGM()
    return self.cfg and self.cfg.bgm
end

function this:GetShopId()
    return self.cfg and self.cfg.shopId
end

function this:SetPrograss(num)
    self.prograss = num or 0
end

function this:GetPrograss()
    return self.prograss or 0
end

function this:IsOpen()
    local isOpen = false
    if self.cfg and self.cfg.begTime then
        local sTime = TimeUtil:GetTimeStampBySplit(self.cfg.begTime)
        isOpen = TimeUtil:GetTime() >= sTime
    end
    return isOpen
end

function this:IsEnd()
    local isEnd = false
    if self.cfg and self.cfg.endTime then
        local eTime = TimeUtil:GetTimeStampBySplit(self.cfg.endTime)
        isEnd = TimeUtil:GetTime() >= eTime
    end
    return isEnd
end

return this