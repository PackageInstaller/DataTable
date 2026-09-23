--公会搜索子物体
local isRequest=false; --是否申请过
local data=nil;
local elseData=nil;

function Refresh(_data,_elseData)
    data=_data;
    elseData=_elseData;
    if data then
        CSAPI.SetText(txt_name,data.name);
        CSAPI.SetText(txt_lv,tostring(data.apply_lv));
        local type=data.activity_type==GuildActivityType.Active and LanguageMgr:GetByID(27003) or LanguageMgr:GetByID(27004)
        CSAPI.SetText(txt_type,type);
        CSAPI.SetText(txt_num,data.mem_cnt.."/"..g_GuildMaxMenCnt);
        -- CSAPI.LoadImg(icon,data.icon); --公会头像
        if data.icon then
            local cfg=Cfgs.character:GetByID(data.icon)
            if cfg then
                ResUtil.RoleCard:Load(icon, cfg.icon)
            end
        else
            CSAPI.SetRectSize(icon,0,0,0);
        end
        CSAPI.SetImgColor(btnOK,249,190,0,255);
        CSAPI.SetTextColor(btnOK,0,0,0,255);
        isRequest=GuildMgr:HasRequestInfo(data.id);
        if data.ratify_type==GuildRatifyType.Auto then
            --自动
            CSAPI.SetText(txt_ok,LanguageMgr:GetByID(27013));
        else
            if isRequest then
                CSAPI.SetImgColor(btnOK,89,89,89,255);
                CSAPI.SetTextColor(btnOK,255,255,255,255);
                local txt=LanguageMgr:GetByID(27014);
                if elseData and elseData.isList~=true then
                    txt=LanguageMgr:GetByID(27016)
                end
                CSAPI.SetText(txt_ok,txt);
            else
                CSAPI.SetText(txt_ok,LanguageMgr:GetByID(27015));
            end
        end
    end
end

function OnClickSelf()
    --显示公会详情
    CSAPI.OpenView("GuildInfo",data);
end

--点击申请
function OnClickOk()
    if data then
        if isRequest~=true then
            local dialogdata = {};
            local content=data.ratify_type==GuildRatifyType.Auto and LanguageMgr:GetTips(17010) or LanguageMgr:GetTips(17011);
            dialogdata.content = string.format(content,data.name);
            dialogdata.okCallBack = function()
                GuildProto:Join(data.id);
                Refresh(data,elseData);
            end
            CSAPI.OpenView("Dialog", dialogdata)
        elseif elseData and elseData.isList then
            --取消加入
            local dialogdata = {};
            dialogdata.content = string.format(LanguageMgr:GetTips(17012),data.name);
            dialogdata.okCallBack = function()
                GuildProto:CancleApply(data.id);
            end
            CSAPI.OpenView("Dialog", dialogdata)
        end 
    end
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
icon=nil;
txt_name=nil;
txt_lv=nil;
txt_type=nil;
txt_num=nil;
btnOK=nil;
txt_ok=nil;
view=nil;
end
----#End#----