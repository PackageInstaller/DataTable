local str="%s<color=#ffc146>X%s</color>";
function Refresh(_d)
    if _d then
        ResUtil.IconGoods:Load(icon1,string.format("Role_splinter_%s",_d.stars),true);
        ResUtil.RoleCard_BG:Load(icon2,string.format("img_01_0%s",_d.stars));
        local cfg=Cfgs.ItemInfo:GetByID(_d.gets[1]);
        if cfg then
            ResUtil.IconGoods:Load(icon3,cfg.icon.."_1",false,function()
                CSAPI.SetRTSize(icon3,46,46);
            end);
            CSAPI.SetText(txt3,string.format(str,cfg.name,_d.gets[2]));
        end
    end
    local c=this.index%2==0 and {0,0,0,26} or {152,152,152,26}
    CSAPI.SetImgColor(img,c[1],c[2],c[3],c[4]);
end

function SetIndex(_i)
    this.index=_i
end