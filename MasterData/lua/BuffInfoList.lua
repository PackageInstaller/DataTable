--BUFF信息列表
local list=nil;
local refreshTime=60;
local currTime=0;

function Awake()
    CSAPI.SetText(noneTips,LanguageMgr:GetByID(2018));
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Main_LifeBuff_Remove, OnRemove);
end

function OnDestroy()
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    RecordMgr:Save(RecordMode.View,CSAPI.GetRealTime(),"ui_id=" .. RecordViews.Buff);	
    PlayerProto:GetLifeBuff(
        function() 
            InitList();
        end
    );
end

function InitList()
    local data=PlayerClient:GetLifeBuff();
    local count=0;
    if data then
        if list then
            for k,v in ipairs(list) do
                if v and v.view then
                    v.view:Close();
                end
            end
        end
        list={};
        for k,v in ipairs(data) do
            local cfg=Cfgs.CfgLifeBuffer:GetByID(v.id);
            if cfg and cfg.bIsShow and (v.expireTime==nil or (v.expireTime and v.expireTime>TimeUtil:GetTime())) then
                local go=ResUtil:CreateUIGO("Menu/BuffInfoItem",Content.transform);
                local tab=ComUtil.GetLuaTable(go);
                tab.Init(v);
                table.insert(list,tab);
                count=count+1;
            end
        end
    end
    CSAPI.SetGOActive(noneTips,count==0);
end

function OnRemove()
    InitList();
end

function Update()
    currTime=currTime+Time.deltaTime;
    if currTime>=refreshTime then
        currTime=0;
        PlayerProto:GetLifeBuff(
            function() 
                InitList();
            end
        );
    end
end

function OnClose()
    view:Close();
end



----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
childNode=nil;
bg_b1=nil;
Content=nil;
noneTips=nil;
view=nil;
end
----#End#----