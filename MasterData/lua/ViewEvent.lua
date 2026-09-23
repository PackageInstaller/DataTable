local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

function this:AddListener(id,func)
    self.list = self.list or {};
    self.list[id] = func;

    EventMgr.AddListener(id,func);
end

function this:ClearListener()
    if(self.list ~= nil)then     
        for id,func in pairs(self.list)do
            EventMgr.RemoveListener(id,func);
        end
    end
    self.list = nil;
end

return this;