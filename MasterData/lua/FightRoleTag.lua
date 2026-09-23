local isSelect=false;
local scaleAction=nil;
function Awake()
    CSAPI.SetScale(icon,0.33,0.33,0.33);
    scaleAction=ComUtil.GetCom(border,"ActionScaleToTarget");
end

--data{icon,isEnemy}
function Refresh(data,_elseData)
    if this.index==_elseData then
        SetSelect(true,true);
        if callBack then
            callBack(this);
        end
    else
        SetSelect(false,true);
    end
    -- ResUtil.RoleCard:Load(icon,data.icon);
    ResUtil.RoleCard2:Load(icon,data.icon,false);
    -- local imgName= data.isEnemy and "UIs/FightRoleInfo/btn_5_2.png" or "UIs/FightRoleInfo/btn_5_1.png";
    -- local imgName= data.isEnemy and "UIs/Icons/RoleHead/Normal_head/Normal2/btn_5_2.png" or "UIs/Icons/RoleHead/Normal_head/Normal2/btn_5_1.png";    
    -- CSAPI.LoadImg(border,imgName,true,nil,true);
    
    local imgName= data.isEnemy and "btn_5_2" or "btn_5_1";    
    ResUtil.RoleCard2:Load(border,imgName,false);

    SetIsBoss(data.isBoss)
    SetIsDead(data.isDead)
    -- CSAPI.SetGOActive(boss,this.data.GetCharacterType() == CardType.Boss);
end

function SetClickCB(func)
    callBack=func;
end

function SetIndex(_index)
    this.index=_index;
end

function GetIndex()
    return this.index;
end

function OnClickSelf()
    --设置距离
    SetSelect(true);
    if callBack then
        callBack(this);
    end
end

function SetSelect(_isSelect,disTween)
    CSAPI.SetGOActive(selectBg,_isSelect);
    if isSelect and _isSelect==false then --播放移动动画
        if disTween==true then
            CSAPI.SetScale(node,1,1,1);
        else
            scaleAction.targetScale=UnityEngine.Vector3(1,1,1);
            scaleAction:Play();
        end
    elseif isSelect==false and _isSelect==true then--播放弹出的移动动画
        if disTween==true then
            CSAPI.SetScale(border,1.25,1.25,1.25);
        else
            scaleAction.targetScale=UnityEngine.Vector3(1.25,1.25,1.25);
            scaleAction:Play();
        end
    end
    isSelect=_isSelect;
end

function GetLineHeight()
    return isSelect and (129-76)/2+20 or 20;
end

function SetIsBoss(isBoss)  
    CSAPI.SetGOActive(boss,isBoss==true);
end

function SetIsDead(isDead)
    CSAPI.SetGOActive(dead,isDead==true);
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
selectBg=nil;
border=nil;
icon=nil;
view=nil;
end
----#End#----