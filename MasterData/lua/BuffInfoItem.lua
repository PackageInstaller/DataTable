-- BUFF信息物体
local lifeTime=0;
function Awake()
    CSAPI.SetText(time, LanguageMgr:GetByID(2016));
end

function Init(item)
    if item then
        local cfg = Cfgs.CfgLifeBuffer:GetByID(item.id)
        if cfg then
            -- local cfg2 = Cfgs.CfgCardPropertyEnum:GetByID(cfg.nType)
            -- if cfg2 then 
            --     CSAPI.SetText(txt_title, cfg2.sName)
            -- end
            CSAPI.SetText(txtName,cfg.name);
            -- ResUtil.LifeBuff:Load(img,cfg.icon,false); 
            local desc=cfg.sDesc;
            local list=StringUtil:SubStrByLength(desc,19);
            local otherLines=StringUtil:GetCharNum(desc,"\n");
            local lines=#list+otherLines;
            local descHeight=42*lines>137 and 137 or 42*lines;
            CSAPI.SetRTSize(content,480,descHeight);
            CSAPI.SetRTSize(gameObject,518.71,220.81-(137-descHeight));
            CSAPI.SetText(content, cfg.sDesc)
            if item.expireTime~=nil then
                lifeTime=item.expireTime-TimeUtil:GetTime();
                RefreshTime();
            else
                lifeTime=nil;
                CSAPI.SetText(timeVal,LanguageMgr:GetByID(2017));
            end
        end
    end
end

function Update()
    if lifeTime~=nil then
        if lifeTime>0 then
            lifeTime=lifeTime-Time.deltaTime;
            RefreshTime();
        else
            -- view:Close();
            EventMgr.Dispatch(EventType.Main_LifeBuff_Remove);
        end
    end
end

function RefreshTime()
    local str=TimeUtil:GetTimeStr(lifeTime);
    CSAPI.SetText(timeVal, str);
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
txtName=nil;
content=nil;
timeObj=nil;
time=nil;
timeVal=nil;
view=nil;
end
----#End#----