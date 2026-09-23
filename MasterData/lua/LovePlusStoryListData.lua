local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(cfg)
    self.cfg = cfg
end

--返回开始对话的信息
function this:GetBeginPlotData()
    local id=self.cfg and self.cfg.storyID
    if id~=nil then
        local data = LovePlusStoryData.New();
        data:InitCfg(id);
        return data;
    end
    return nil
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetTitle()
    return self.cfg and self.cfg.title
end

function this:GetName()
    return self.cfg and self.cfg.name
end

function this:GetIcon()
    return self.cfg and self.cfg.icon
end

function this:GetNextIds()
    return self.cfg and self.cfg.nextParagraphID
end

function this:GetLastId()
    return self.cfg and self.cfg.lastNodeID
end

function this:GetPos()
    return self.cfg and self.cfg.pos
end

--剧情开始id
function this:GetStartId()
    return self.cfg and self.cfg.storyID
end

function this:SetIsPass(b)
    self.isPass = b
end

function this:IsPass()
    return self.isPass
end

--是否开启
function this:IsOpen()
    if self.isPass then --通关默认开启
        return true
    end
    if self.cfg then
        return LovePlusMgr:IsOpen(eLovePlusUnLockType.Story,self:GetID())
    end
    return false --默认开启
end

return this