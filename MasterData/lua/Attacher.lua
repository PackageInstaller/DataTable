--关联器，用于表示一个对象与其他一个或者多个对象的关系。

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


--拥有者
this.owner = nil;
--关联列表
this.list = nil;

function this:Init()
    self.list = self.list or {};
end

--设置拥有者
function this:SetOwner(owner)
    self.owner = owner;
end
function this:GetOwner()
    return owner;
end

--设置关联目标
--target：目标
function this:SetAttach(key,target)
    self.list[key] = target;
end
--获取关联器
function this:GetAttach(key)
    return self.list[key];
end

--添加（无key）
function this:Add(target)
    table.insert(self.list,target);
end
--移除指定对象
function this:Remove(target)
    local key = nil;
    for k,v in pairs(self.list) do
        if(v == target)then
            key = k;
            break;
        end
    end 

    if(key ~= nil)then
        table.remove(self.list,key);
    end
end

--添加一组（无key）
function this:AddList(list)
    for _,v in pairs(list) do
        table.insert(self.list,v);
    end
end

--清空
function this:Clean()
    self.list = {};
end
return this;