local this = MgrRegister("GoldenRebateMgr")

function this:Init()
    self.dailyKeys="GoldenRebateDaily";
end

function this:GetData(id)
    if self.datas and id then
        for k, v in ipairs(self.datas) do
            if v:GetID()==id then
                return v;
            end
        end
    end
end

function this:Update(proto)
    self.datas=self.datas or {};
    if proto==nil or (proto and proto.data==nil) then
        do return end
    end
    for k, v in ipairs(proto.data) do
        local data=self:GetData(v.id)
        if data then
            data:SetData(v);
        else
            local tab=GoldenRebateInfo.New();
            tab:SetData(v);
            table.insert(self.datas,tab)
        end
    end
end

function this:SetIsDailyShow(isShow)
    if isShow~=self.isDailyOn then
        TipsMgr:SaveDailyTips(self.dailyKeys, isShow);
    end
    self.isDailyOn=isShow
end

function this:GetIsDailyShow()
    return TipsMgr:IsShowDailyTips(self.dailyKeys);
end

function this:Clear()
    self.datas={};
    self.dailyKeys="GoldenRebateDaily";
end

return this