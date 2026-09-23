
function OnOpen()
    if data then
        --显示敌人立绘
        -- local pos, scale, imgName = RoleTool.GetImgPosScale(data.model, LoadImgType.details);
        -- if(data) then
        local modelCfg=Cfgs.character:GetByID(data.model);
        if modelCfg then
            ResUtil.RoleCard:Load(roleImg,modelCfg.icon);
        end
        -- end
        --显示敌人名称
        CSAPI.SetText(txt_name,data.name);
        --显示敌人描述
        CSAPI.SetText(txt_desc,data.desc or "暂无说明");
    end
end

function OnClickMask()
    view:Close();
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
root=nil;
roleImg=nil;
txt_name=nil;
txt_desc=nil;
view=nil;
end
----#End#----