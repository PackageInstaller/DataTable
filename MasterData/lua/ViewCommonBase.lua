ViewCommonBase = oo.class();
local this = ViewCommonBase;

function this:Init(view)
    self.view = view;
end

--ָ�����������볡
function this:InPart(index,delay)
    local part = self.view["part" .. index];
    local inNode = self.view["inNode" .. index];
    local inParent = self.view["in" .. index];

    CSAPI.SetParent(part,inNode);
    CSAPI.SetGOActive(inParent,false);

    self:DelayIn(inParent,delay)  
end
function this:DelayIn(go,delay)
    FuncUtil:Call(CSAPI.SetGOActive,nil,delay,go,true);
end

function this:OutPart(index,delay)
   local outParent = self.view["out" .. index];
    CSAPI.SetGOActive(outParent,false);
    FuncUtil:Call(self.DelayOut,self,delay,index);
end
function this:DelayOut(index)
    local part = self.view["part" .. index];
    local outNode = self.view["outNode" .. index];
    local outParent = self.view["out" .. index];

    CSAPI.SetGOActive(outParent,true);
    CSAPI.SetParent(part,outNode);
end

function this:Close(delay)
    if(delay)then
        FuncUtil:Call(self.DoClose,self,delay);
    else
        self:DoClose();
    end
end

function this:DoClose()
    if(self.view and IsNil(self.view.view) == false)then
        self.view.view:Close();
        self.view = nil;
    end
end

return this;