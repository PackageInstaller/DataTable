
function Refresh(buff)
    local cfg=buff:GetCfg();
    if cfg then   
        local data=buff:GetData();
        ResUtil.IconBuff:Load(icon,cfg.icon);
        -- local borderName="blue_buff";
        -- if cfg.icon_Type==2 then
        --     borderName="red_buff";
        -- elseif cfg.icon_Type==3 then
        --     borderName="purple_buff";
        -- end
        -- ResUtil.IconBuff:Load(border,borderName);
        if data then 
            if data.round then
                CSAPI.SetText(txt_round,tostring(data.round));
            else
                CSAPI.SetText(txt_round,"");
            end
            if buff:GetShowCount()~=nil  then
                CSAPI.SetText(txt_count,tostring(buff:GetShowCount()));
            else
                CSAPI.SetText(txt_count,"");
            end
        end
    end
end

function SetBorderHide()
    CSAPI.SetImgColor(border,255,255,255,0)
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
border=nil;
icon=nil;
txt_round=nil;
txt_count=nil;
view=nil;
end
----#End#----