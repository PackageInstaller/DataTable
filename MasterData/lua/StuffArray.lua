--素材列表工具类
local this={
    stuffList=nil,
    stuffTotalExp=0,
    stuffTotalPrice=0,
    stuffCount=0,
}

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end

--添加选择的素材信息isOverride:为true时直接覆盖原有的素材数量，仅用于物品
function this:AddStuffItem(data,type,count,isOverride)
    if data==nil or type==nil then
        return;
    end
    count=count or 1;
    self.stuffList=self.stuffList or {};
    if self:GetStuffIsMax()==false then
        if type==0 then --装备
            if self.stuffList[data:GetID()]~=nil then
                return
            end
            self.stuffList[data:GetID()]={type=type,data=data,num=1};
            local info = data:GetMaterialInfo();
            self.stuffTotalExp=self.stuffTotalExp+info.exp;
            self.stuffTotalPrice=self.stuffTotalPrice+info.gold;
            self.stuffCount=self.stuffCount+1;
        elseif type==1 then--素材经验(由于素材可以叠加，所以这里使用配置表ID)
            local item=self.stuffList[data:GetID()];
            if item and isOverride~=true then
                item.num=item.num+count;
            else
                self.stuffList[data:GetID()]={type=type,data=data,num=count};
                self.stuffCount=self.stuffCount+1;
            end
            self.stuffTotalExp=self.stuffTotalExp+count;
            self.stuffTotalPrice=self.stuffTotalPrice+g_ClipExpPrcie*count;
        end
        -- for i=1,count do 
        --     table.insert(self.stuffList,{type=type,data=data,num=1});
        --     local info = data:GetMaterialInfo();
        --     self.stuffTotalExp=self.stuffTotalExp+info.exp;
        --     self.stuffTotalPrice=self.stuffTotalPrice+info.gold;
        --     self.stuffCount=self.stuffCount+1;
        -- end
    end
end

--返回同一id的素材数量
function this:GetStuffNumByID(id)
    local num=0;
    if self.stuffList then
        for k,v in pairs(self.stuffList) do
            if v.type==1 then
                if v.data:GetID()==id then
                    num=num+v.num;
                end
            else
                if v.data:GetID()==id then
                    num=num+1;
                end
            end
        end
    end
    return num;
end
--移除素材信息
function this:RemoveStuffItem(id,num)
    if self.stuffList and self.stuffList[id] then
        local item=self.stuffList[id];
        if item.type==0 then
            local info = item.data:GetMaterialInfo();
            self.stuffTotalExp=self.stuffTotalExp-info.exp;
            self.stuffTotalPrice=self.stuffTotalPrice-info.gold;
            self.stuffList[id]=nil;
            self.stuffCount=self.stuffCount-1;
        elseif item.type==1 then
            if num==-1 then
                local tempNum=item.num;
                item.num=0;
                self.stuffTotalExp=self.stuffTotalExp-tempNum;
                self.stuffTotalPrice=self.stuffTotalPrice-tempNum*g_ClipExpPrcie;
            else
                item.num=item.num-num<0 and 0 or item.num-num;
                self.stuffTotalExp=self.stuffTotalExp-num;
                self.stuffTotalPrice=self.stuffTotalPrice-num*g_ClipExpPrcie;
                self.stuffCount=item.num<=0 and self.stuffCount-1 or self.stuffCount;
            end
            self.stuffCount=item.num<=0 and self.stuffCount-1 or self.stuffCount;
            if item.num<=0 then
                self.stuffList[id]=nil;
            end
        end
    end
end

--根据ID返回素材信息
function this:GetStuffByID(id)
    if self.stuffList then
        for k,v in pairs(self.stuffList) do
            if v.data:GetID()==id then
                return v;
            end
        end
    end
    return nil;
end

--根据Index返回素材信息
function this:GetStuffByIndex(index)
    if self.stuffList and self.stuffList[index] then
        return self.stuffList[index];
    end
    return nil;
end

--返回选择的升级素材列表
function this:GetStuffArr()
    local arr={};
    if self.stuffList then
        for k,v in pairs(self.stuffList) do
            if v.type==0 then
                table.insert(arr,v);
            elseif v.type==1 then
                table.insert(arr,v);
            end
        end
    end
    return arr;
end

--是否到达最大选择数量
function this:GetStuffIsMax()
    return self.stuffCount>=EquipMgr.maxStuffNum;
end

--返回每种类型的素材提供的装备经验值
function this:GetExpByType(_type)
    local exp=0;
    if self.stuffList==nil then
        return exp;
    end
    for k, v in pairs(self.stuffList) do
        if v.type==_type then
            local info = v.data:GetMaterialInfo();
            exp=exp+info.exp;
        end
    end
    return exp
end

--返回还能放置的数量
function this:GetEmptyNum()
    return EquipMgr.maxStuffNum-self.stuffCount;
end

--清空选择的素材信息
function this:CleanStuffInfo()
    self.stuffCount=0;
    self.stuffTotalExp=0;
    self.stuffTotalPrice=0;
    self.stuffList=nil;
end

return this;