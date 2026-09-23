--战斗站位信息子物体
function Refresh(_data)
    this.data=_data;
    local color=_data.IsEnemy() and {255,0,64,255} or {255,193,70,255};
    SetColor(color);
end

function SetSize(width,height)
    CSAPI.SetRTSize(gameObject,width,height);
end

function SetColor(color)
    CSAPI.SetImgColor(gameObject,color[1],color[2],color[3],color[4]);
end

function SetPoint(isShow)
    CSAPI.SetGOActive(point,isShow);
end

--type:1-3 isMirror:是否翻转
function SetImg(type,angle)
    if  type==1 then
        CSAPI.LoadImg(gameObject,"UIs/FightRoleInfo/img_18_02.png",false,nil,true);
    elseif type==2 then
        CSAPI.LoadImg(gameObject,"UIs/FightRoleInfo/img_18_03.png",false,nil,true);
    else
        CSAPI.LoadImg(gameObject,"UIs/FightRoleInfo/img_18_04.png",false,nil,true);
    end
    CSAPI.SetAngle(gameObject,angle[1],angle[2],angle[3]);
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
point=nil;
view=nil;
end
----#End#----