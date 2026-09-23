--isUp:1：绿色,2:红色，nil不显示
local item=nil;
function Refresh(data)
    if item==nil then
        ResUtil:CreateUIGOAsync("AttributeNew2/AttributeItem6",node,function(go)
            item=ComUtil.GetLuaTable(go);
            item.Refresh(data.add);
        end)
    else
        item.Refresh(data.add);
    end
    if data.isUp==1 then
        CSAPI.LoadImg(arrow,"UIs/EquipInfo/img_30_01.png",true,nil,true);
    else
        CSAPI.LoadImg(arrow,"UIs/EquipInfo/img_30_02.png",true,nil,true);
    end
    CSAPI.SetGOActive(arrow,data.isUp~=nil);
end