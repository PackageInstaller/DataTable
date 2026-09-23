--装备技能
local cfg=nil;
local pList={};
local isLock=false;
local clicker=nil;
local exColor=nil;
local isLock2=nil;
local tipsTimes={6,2}
local currTime=0;
local isJP=false;
local currIdx=1;
local isShowLimit=false;
local elseData=nil;
local eventMgr=nil;
function Awake()
    if points then
        pList=ComUtil.GetComsInChildren(points,"Image");
    end
    clicker=ComUtil.GetCom(btnLock,"Image");
    isJP=CSAPI.IsADVRegional(3);
    -- isJP=true;
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Equip_Click_LockLimit, OnLockLimit);
end

function OnDestroy()
    eventMgr:ClearListener();
end
--isLock
function Refresh(skillCfg,_elseData)
    cfg=skillCfg;
    isLock=false
    currIdx=1;
    currTime=0;
    elseData=_elseData
    isLock2=elseData and elseData.isLock or false; --是否未解锁的词条
    if elseData and elseData.lockSkills and cfg then
        for k,v in ipairs(elseData.lockSkills) do
            if cfg.id==v then
                isLock=true;
                break;
            end
        end
    end
    exColor=nil;
    if elseData and elseData.changeIDs and cfg then
        for k,v in ipairs(elseData.changeIDs) do
            if cfg.id==v then
                exColor="00ffbf"
                break;
            end
        end
    end
    if elseData and elseData.disClicker==true then
        clicker.raycastTarget=false
    else
        clicker.raycastTarget=true
    end
    --设置技能框颜色
    if skillCfg then
        CSAPI.SetGOActive(root,true);
        CSAPI.SetGOActive(nullObj,false);
        CSAPI.SetGOActive(btnLock,skillCfg.id<20000)
        SetBorderColor(skillCfg.nQuality);
        --设置图标
        -- CSAPI.SetGOActive(icon,true);
        ResUtil.EquipSkillIcon:Load(icon,skillCfg.group,false);
        CSAPI.SetScale(icon,1,1,1);
        CSAPI.SetRTSize(icon,44,44);
        --设置名称描述
        CSAPI.SetText(txt_Name,skillCfg.sName);
        CSAPI.SetText(txt_lvVal,tostring(skillCfg.nLv));
        if points then
            local cfgs=Cfgs.CfgEquipSkill:GetGroup(skillCfg.group);
            for i=0,pList.Length-1 do
                local go=pList[i].gameObject;
                CSAPI.SetGOActive(go,i+1<=#cfgs);
                if i<=skillCfg.nLv-1 then
                    CSAPI.SetImgColor(go,255,193,70,255);
                else
                    CSAPI.SetImgColor(go,255,255,255,76);
                end
            end
        end
        if elseData and elseData.lockStr and isJP then
            CSAPI.SetText(txt_unLock,elseData.lockStr);
        end
        SetLockIcon()
        if isJP then
            SetLock(exColor~=nil)
        end
    else
        InitNull();
    end
    CSAPI.SetGOActive(arrow,isUp~=nil);
end

function InitNull()
    SetBorderColor();
    CSAPI.SetGOActive(root,false);
    CSAPI.SetGOActive(nullObj,true);
    CSAPI.SetGOActive(btnLock,false)
end

--isForce:强制使用当前颜色
function SetLock(isForce)
    local color=nil;
    if isForce then
        CSAPI.SetImgColorByCode(line2,exColor);
    elseif isLock2 then
        CSAPI.SetTextColorByCode(txt_Name,"C3C3C8");
        CSAPI.SetTextColorByCode(line2,"C3C3C8");
    end
    if isLock2 then
        CSAPI.SetTextColorByCode(txt_Lv,"C3C3C8");
        CSAPI.SetTextColorByCode(txt_lvVal,"C3C3C8");
    end
    CSAPI.SetGOActive(line2,isLock2)
    if isLock2 then
        --图标设置为禁止
        ResUtil.EquipSkillIcon:Load(icon,"253",false);
    end
end

function Update()
    if isLock2 and isJP and isShowLimit then
        currTime=currTime+Time.deltaTime;
        if currTime>=tipsTimes[currIdx] then
            currIdx=currIdx+1>2 and 1 or currIdx+1;
            SetLayout(currIdx==1);
            currTime=0;
            isShowLimit=false;
        end
    elseif not isLock2 and currIdx~=1 and isJP then
        SetLayout(currIdx==1);
    end
end

function OnClickName()
    if isJP and isLock2 and isShowLimit~=true then
        EventMgr.Dispatch(EventType.Equip_Click_LockLimit,{parent=gameObject.transform.parent});
    end
end

function OnLockLimit(eventData)
    --判断是否日服，做切换操作
    if isJP and isShowLimit~=true and eventData and isLock2 and not IsNil(eventData.parent) and not IsNil(gameObject) and eventData.parent==gameObject.transform.parent then
        SetLayout(false);
        currIdx=2;
        currTime=0;
        isShowLimit=true;
    end
end

function SetLayout(isNormal)
    CSAPI.SetGOActive(normalNode,isNormal);
    CSAPI.SetGOActive(unLockNode,not isNormal);
end

function SetBorderColor(colorID)
    -- local color=Cfgs.CfgUIColorEnum:GetByID(colorID or 1);
    colorID=colorID or 1;
    local color=colorID==1 and {r=255,g=255,b=255,a=255} or {r=255,g=193,b=70,a=255}
    CSAPI.SetImgColor(border,color.r,color.g,color.b,color.a,false);
    if colorID==1 then
        CSAPI.SetTextColorByCode(txt_Name,exColor and exColor or "c3c3c8");
        CSAPI.SetTextColorByCode(txt_Lv,"c3c3c8",false);
        CSAPI.SetImgColor(line,15,15,25,255);
        CSAPI.SetTextColorByCode(txt_lvVal,"ffc146");
    else
        CSAPI.SetTextColorByCode(txt_Name,exColor and exColor or "0f0f19");
        CSAPI.SetTextColorByCode(txt_Lv,"0f0f19",false);
        CSAPI.SetImgColor(line,color.r,color.g,color.b,color.a,false);
        CSAPI.SetTextColorByCode(txt_lvVal,"ffc146");
    end
end

function SetClickCB(call)
    this.call=call;
end

function OnClickDetails()
    if this.call then
        this.call(cfg);
    end
end

function OnClickSelf()
    if this.call then
        this.call(cfg);
    end
end

function OnClickLock()
    if cfg then
        isLock=not isLock
        EventMgr.Dispatch(EventType.Equip_Lock_Attribute,{id=cfg.id,isLock=isLock});
        SetLockIcon()
    end
end

function SetLockIcon()
    CSAPI.LoadImg(lockImg,string.format("UIs/EquipInfo/%s.png",isLock and "img_07_02" or "img_07_03"),true,nil,true);
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
icon=nil;
txt_Name=nil;
txt_Lv=nil;
txt_lvVal=nil;
border=nil;
pList=nil;
points=nil;
line=nil;
view=nil;
end
----#End#----