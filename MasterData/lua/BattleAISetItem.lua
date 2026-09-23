--AI设置子物体
local clickCB=nil;
function Refresh(d,cData,cb)
    this.data=d
    this.ctrlData=cData;
    clickCB=cb;
    if d then
        SetGrey(false);
        SetBG();
        SetIcon(d:GetIcon());
        if d:IsLeader() or d:IsAssist() then
            SetDescObj(true,d:GetIndex());
        else
            SetDescObj(false);
        end
    else
        SetNull();
    end
end 

--设置描述 index==1 :leader index==6: Assist
function SetDescObj(isShow,index)
    
    if index==1 or index==6 then
        local id=index==1 and 26007 or 26006;
        LanguageMgr:SetText(txt_desc,id);
        LanguageMgr:SetEnText(txt_descTips,id);
        CSAPI.SetGOActive(descObj,isShow);
    else
        CSAPI.SetGOActive(descObj,false);
    end
end

function SetIcon(iconName)
    if iconName then
        ResUtil.RoleCard:Load(icon,iconName);
    end
    CSAPI.SetGOActive(icon,true);
end

function SetBG(isNil)
    if isNil then
        CSAPI.LoadImg(border,"UIs/BattleAISetting/img_19.png",true,nil,true);
        CSAPI.SetRTSize(border,160,160);
    else
        CSAPI.LoadImg(border,"UIs/BattleAISetting/img9_3.png",true,nil,true);
        CSAPI.SetRTSize(border,198,198);
    end
end

function SetGrey(isGrey)
    isGrey=isGrey==true and true or false;
    CSAPI.SetGrey(gameObject,isGrey,true)
end

function SetNull()
    SetBG(true);
    CSAPI.SetGOActive(icon,false);
    SetDescObj(false);
    SetGrey(false);
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selObj,isSelect==true)
end

function OnClickThis()
    if this.data and clickCB then
        clickCB(this);
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
border=nil;
icon=nil;
txt_desc=nil;
txt_descTips=nil;
descObj=nil;
view=nil;
end
----#End#----