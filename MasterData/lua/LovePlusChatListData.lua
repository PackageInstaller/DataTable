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

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetUnLockType()
    return self.cfg and self.cfg.unLockType
end

function this:GetStoryIDs()
    return self.cfg and self.cfg.storyID 
end

function this:SetIsShow(b)
    self.isShow = b
end

--已显示过
function this:IsShow()
    return self.isShow == true
end

function this:SetIsOpen(b)
    self.isOpen = b
end

--已解锁但未显示
function this:IsOpen()
    if self.isShow == true then
        return true
    end
    return self.isOpen == true
end

return this