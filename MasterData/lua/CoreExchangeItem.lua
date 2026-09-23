local stars=3;
function Refresh(_d)
    if _d then
        stars=_d.stars;
        ResUtil.RoleCard_BG:Load(star,string.format("img_01_0%s",_d.stars));
        CreateChild(n1,_d.first);
        CreateChild(n2,_d.second);
        CreateChild(n3,_d.third);
    end
    local c=this.index%2==0 and {0,0,0,26} or {152,152,152,26}
    CSAPI.SetImgColor(img,c[1],c[2],c[3],c[4]);
end

function CreateChild(node,data)
    ResUtil:CreateUIGOAsync("Shop/CoreExchangeItem2",node,function(go)
        local lua=ComUtil.GetLuaTable(go);
        lua.Refresh(data,stars);
    end);
end

function SetIndex(_i)
    this.index=_i
end