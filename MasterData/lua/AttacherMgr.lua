--关联器管理，可以创建多个不同用途的管理器，例如：占位关联管理，人物装备关联管理

local this = {};

function this.New(name)
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
    if(name ~= nil)then
        ins.name = name;
    end
    ins:Init();
	return ins;
end

--关联列表
this.list = nil;

function this:Init()
    self.list = self.list or {};
end

--获取（或者添加）关联器
--owner：如果列表中不存在，则创建一个关联器
function this:GetOrAdd(owner,name)
    if(owner == nil)then
        return nil;
    end
    
    local attacher = self:Get(owner);
    if(attacher == nil)then
        attacher = Attacher.New(name); 
        attacher:SetOwner(owner);
        self.list[owner] = attacher;
    end
    
    return attacher;
end

function this:Get(owner)
    return self.list[owner];
end

--移除
function this:Remove(owner)
    if(owner)then
        self.list[owner] = nil;
    end
end
--清空
function this:Clean()
    self.list = {};
end

return this;