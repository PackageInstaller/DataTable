--地区设置
RegionalSet={}
local this=RegionalSet;
---1:中国内陆
---2：港澳台
---3：日语
---4：英文
---5：韩国
---6:英俄地区
this.CurrentRegion=2;
---地区货币类型
function this.RegionalCurrencyType()
    if this.CurrentRegion==1 then
        return "CNY";
    elseif this.CurrentRegion==2 then
        return "TWD";
    elseif this.CurrentRegion==3 then
        return "JPY";
    elseif this.CurrentRegion==4 then
        return "USD";
    elseif this.CurrentRegion==5 then
        return "KRW";
    elseif this.CurrentRegion==6 then
        return "USD";
    else
        return "CNY";
    end
end