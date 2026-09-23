local this={};

function this.New()
    this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
    return tab;
end

--layout:layout对象,listNum:列表长度 childSize:子物体宽高 maxShowNum:最大显示数量 lerp:每次递减大小 minScale:最小缩放,isVer:是否是竖着排列
function this:Init(layout,listNum,childSize,maxShowNum,lerp,minScale,isVer)
    self.layout=layout;
    self.listNum=listNum;
    self.iWidth=childSize[1];
    self.iHeight=childSize[2];
    self.disNum=maxShowNum;
    self.lerp=lerp or 0.1;
    self.minScale=minScale or 0.9;
    self.transform=self.layout.transform;
    self.isHor=isVer~=true;
end

--在滑动过程中调用
function this:Update()
    local idx=self.layout:GetCurIndex()+1;
    self:RefreshChildStyle(idx)
end

function this:RefreshChildStyle(index)
    --设置所有子物体的层级
    for i=self.disNum,1,-1 do
        local upIdx=index-i;
        local nextIdx=index+i;
        local layer=math.abs(i-self.disNum);
        if upIdx>=1 then
            local upItem=self.layout:GetItemLua(upIdx);
            if upItem then
                -- Log("UpId:"..tostring(upIdx).."\t realIdx:"..tostring(layer))
                upItem.SetSibling(layer);
                self:SetChildScale(upItem);
            end
        end
        if nextIdx<=self.listNum then
            local nextItem=self.layout:GetItemLua(nextIdx);
            if nextItem then
                -- Log("NextId:"..tostring(nextIdx).."\t realIdx:"..tostring(layer))
                nextItem.SetSibling(layer);
                self:SetChildScale(nextItem);
            end
        end
    end
    local c=self.layout:GetItemLua(index);
    if(c) then 
        self:SetChildScale(c);
        c.SetSibling(self.disNum);
    else 
        --LogError("无该index:"..tostring(index)) --因为滑动距离过大导致
    end 
end

function this:SetChildScale(lua)
    if lua and lua["GetPos"] and lua["SetScale"] then
        local pos=lua.GetPos();
        local p2=self.transform:InverseTransformPoint(UnityEngine.Vector3(pos[1],pos[2],pos[3]));
        local scale=1;
        if self.isHor then
            scale=1-self.lerp*(math.abs(p2.x)/(self.iWidth/2));
        else
            scale=1-self.lerp*(math.abs(p2.y)/(self.iHeight/2));            
        end
        scale=scale>self.minScale and scale or self.minScale;
        lua.SetScale(scale)
    end
end

function this:Clear()
    self.layout=nil;
    self.listNum=0;
    self.iWidth=0;
    self.iHeight=0;
    self.disNum=0;
    self.lerp=0.1;
    self.minScale= 0.9;
    self.transform=nil;
    self.isHor=true;
end

return this;