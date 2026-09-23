--装备技能
local cfg=nil;
local pList={};
local isLock=nil;
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
    isJP=CSAPI.IsADVRegional(3);
    -- isJP=true;
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_Click_LockLimit, OnLockLimit);
end

function OnDestroy()
	eventMgr:ClearListener();
end

--isUp:1：绿色,2:红色，nil不显示 elseData={isForce,isLock,lockStr}
function Refresh(skillCfg,isUp,_elseData)
    cfg=skillCfg;
    currIdx=1;
    isShowLimit=false;
    currTime=0;
    elseData=_elseData
    isLock=elseData and elseData.isLock or false;
    --设置技能框颜色
    if skillCfg then
        CSAPI.SetGOActive(root,true);
        CSAPI.SetGOActive(nullObj,false);
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
        if isJP then
            SetLock(elseData and elseData.isForce or false);
        end
    else
        InitNull();
    end
    if isUp==1 then
        CSAPI.LoadImg(arrow,"UIs/EquipInfo/img_30_01.png",true,nil,true);
    else
        CSAPI.LoadImg(arrow,"UIs/EquipInfo/img_30_02.png",true,nil,true);
    end
    CSAPI.SetGOActive(arrow,isUp~=nil);
end

--isForce:强制使用当前颜色
function SetLock(isForce)
    local color=nil;
    if isForce then
    elseif isLock then
        CSAPI.SetTextColorByCode(txt_Name,"C3C3C8");
        CSAPI.SetImgColorByCode(line2,"C3C3C8");
        CSAPI.SetTextColorByCode(txt_Lv,"C3C3C8");
        CSAPI.SetTextColorByCode(txt_lvVal,"C3C3C8");
        if elseData and elseData.lockStr then
            CSAPI.SetText(txt_unLock,elseData.lockStr);
        end 
    end
    CSAPI.SetGOActive(line2,isLock)
    if isLock then
        --图标设置为禁止
        ResUtil.EquipSkillIcon:Load(icon,"253",false);
    end
end

function InitNull()
    SetBorderColor();
    CSAPI.SetGOActive(root,false);
    CSAPI.SetGOActive(nullObj,true);
end

function Update()
    if isLock and isJP then
        currTime=currTime+Time.deltaTime;
        if currTime>=tipsTimes[currIdx] then
            currIdx=currIdx+1>2 and 1 or currIdx+1;
            SetLayout(currIdx==1);
            currTime=0;
            isShowLimit=false;
        end
    elseif not isLock and currIdx~=1 then
        SetLayout(currIdx==1);
    end
end

function OnClickName()
    if isJP and isLock and isShowLimit~=true then
        EventMgr.Dispatch(EventType.Equip_Click_LockLimit,{parent=gameObject.transform.parent});
    end
end

function OnLockLimit(eventData)
    --判断是否日服，做切换操作
    if isJP and isShowLimit~=true and eventData and isLock and not IsNil(eventData.parent) and not IsNil(gameObject) and eventData.parent==gameObject.transform.parent then
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
        CSAPI.SetTextColor(txt_Name,255,255,255,255);
        CSAPI.SetTextColor(txt_Lv,255,255,255,255,false);
        CSAPI.SetImgColor(line,15,15,25,255);
        CSAPI.SetTextColorByCode(txt_lvVal,"ffc146");
    else
        CSAPI.SetTextColor(txt_Name,0,0,0,255);
        CSAPI.SetTextColor(txt_Lv,0,0,0,255,false);
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

--禁用了
function OnClickSelf()
    -- if this.call then
    --     this.call(cfg);
    -- end
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