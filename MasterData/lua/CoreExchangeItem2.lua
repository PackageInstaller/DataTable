local str="%s<color=#ffc146>X%s</color>";
function Refresh(_d,stars)
    if _d then
        CSAPI.SetGOActive(n,_d.card==true);
        CSAPI.SetGOActive(txt1,_d.card==true);
        CSAPI.SetGOActive(txt2,_d.card==true);
        if _d.card then
            ResUtil.IconGoods:Load(icon1,string.format("Role_splinter_%s",stars),false,function()
                CSAPI.SetRTSize(icon1,80,80);
            end);
        end
        local cfg=Cfgs.ItemInfo:GetByID(_d.gets[1]);
        if cfg then
            ResUtil.IconGoods:Load(icon2,cfg.icon.."_1",false,function()
                CSAPI.SetRTSize(icon2,46,46);
            end);
            CSAPI.SetText(txt3,string.format(str,cfg.name,_d.gets[2]));
        end
    end
end
