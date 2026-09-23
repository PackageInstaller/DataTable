--战术格子
local data;
local clickObj=nil;
function Awake()
    clickObj=ComUtil.GetCom(clickNode,"Image");
end

function Refresh(d,isLock)
    data=d;
    if d then
        SetIcon(data.icon);
        SetLock(isLock);
        AddClick(function()
             --打开技能描述界面
            if data then
                CSAPI.OpenView("SkillInfoView",data);
            end
        end);
    else
        InitNull();
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon,iconName~=nil);
    if iconName then
        ResUtil.IconSkill:Load(icon,iconName);
    end
end


function SetLock(isLock)
    CSAPI.SetGOActive(lockImg,isLock);
    local color=isLock==true and {0,0,0,191} or {255,255,255,255}
    CSAPI.SetImgColor(icon,color[1],color[2],color[3],color[4]);
end

function InitNull()
    CSAPI.SetGOActive(icon,false);
end

function AddClick(func)
    clickFunc=func;
end

function OnClickSelf()
   if clickFunc then
        clickFunc();
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
clickNode=nil;
icon=nil;
lockImg=nil;
view=nil;
end
----#End#----