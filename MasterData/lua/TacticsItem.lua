--战术选择物体
local btn=nil;
local grids=nil;
local changeFunc=nil;
local isSelect

function Refresh(d,elseData)
    data=d;
    this.isLock=not data:IsUnLock();
    CSAPI.SetText(text_name,data:GetName());
    -- local x=-288;
    if data:IsUnLock() then
        CSAPI.SetText(text_levelTips,string.format(LanguageMgr:GetTips(1009),tostring(data:GetLv())));
    else
        local s="";
        for k,v in ipairs(Cfgs.CfgPlrAbility:GetAll()) do
            if v.type==1 and v.active_id==data:GetCfgID() then
                s=v.name;
                break;
            end
        end
        CSAPI.SetText(text_levelTips,string.format(LanguageMgr:GetTips(26101),s));
        -- x=-305
    end
    -- CSAPI.SetAnchor(text_levelTips,x,-17.1);
    isSelect=elseData and elseData.isSelect or false;
    SetBtnState(isSelect)
    ResUtil.Ability:Load(icon, data:GetIcon());
    CSAPI.SetScale(icon,0.5,0.5,0.5);
    grids=grids or {};
    for k,v in ipairs(data:GetSkills()) do 
        local item=nil;
        if k<=#grids then
            item=grids[k];
            item.Refresh(v,this.isLock);
        else
            ResUtil:CreateUIGOAsync("Team/TacticsGrid",skillObj,function(go)
                local tab=ComUtil.GetLuaTable(go);
                table.insert(grids,tab);
                item=tab;
                item.Refresh(v,this.isLock);
            end)
        end
    end
end

function SetClickCB(func)   
    changeFunc=func;
end

--设置按钮状态 
function SetBtnState(_isSelect)
    isSelect=_isSelect;
    local color=isSelect and "ffc146" or "FFFFFF";
    CSAPI.SetTextColorByCode(text_name,color);
    CSAPI.SetTextColorByCode(text_levelTips,color);
    CSAPI.SetImgColor(bg,255,255,255,isSelect and 255 or 75);
    CSAPI.SetGOActive(choosie,isSelect==true);
end

--切换按钮
function OnClickBtn()
    --点击按钮
    if changeFunc then
        changeFunc(this);
    end
end

function SetIndex(i)
    index=i
end

function GetIndex()
    return index;
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
bg=nil;
icon=nil;
root=nil;
border=nil;
choosie=nil;
text_name=nil;
text_levelTips=nil;
skillObj=nil;
none=nil;
view=nil;
end
----#End#----