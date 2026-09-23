--界面模型管理

ViewModelMgr = {};

local this = ViewModelMgr;

local index = 1;

function this:SetModelCreater(currModelCreater)
    self.list = self.list or {};

    self.list[currModelCreater] = index;
    index = index + 1;
    local addCameraDepth = index - 100;
    CSAPI.AddCameraDepth(currModelCreater.gameObject,addCameraDepth);
    CSAPI.SetLocalPos(currModelCreater.model,0,index * 100,0);
    self:ShowLast();
    --self.modelCreater = currModelCreater;
end


function this:RemoveModelCreater(currModelCreater)
    if(not self.list)then
        return;
    end

    self.list[currModelCreater] = nil;   

     self:ShowLast();


     local modelCreater = self:GetCurrModelCreater();
     if(modelCreater == nil)then
        index = 1;
     end
end



function this:GetCurrModelCreater()
    if(not self.list)then
        return nil;
    end

    local targetModelCreater;
    local currIndex;
    for modelCreater,value in pairs(self.list)do
        if(modelCreater and IsNil(modelCreater.gameObject))then
            self.list[modelCreater] = nil;
        end

        if(not currIndex or value > currIndex)then
            currIndex = value;
            targetModelCreater = modelCreater;
        end
    end

    return targetModelCreater;
end

function this:CreateModel(modelId,followTarget,delay)    
    local currModelCreater = self:GetCurrModelCreater();

    if(currModelCreater)then
        return currModelCreater.CreateModel(modelId,followTarget,delay);
    end

    return nil;
end

function this:ShowLast()
    local currModelCreater = self:GetCurrModelCreater();
    self:ShowTarget(currModelCreater);
end

function this:ShowTarget(target)
     for modelCreater,value in pairs(self.list)do
        modelCreater.ShowModelState(modelCreater == target);
    end
end

return this;