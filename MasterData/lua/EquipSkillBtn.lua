--data；name:名字,isLight:是否显示高亮 _elseData
function Refresh(_data,_elseData)
    this.data=_data;
    if _data then
        CSAPI.SetText(text,_data.name);
        SetLight(_elseData and _elseData.isSelect or false);
    end
end

function SetLight(isLight)
    local color={255,255,255,255};
    if isLight then
        color={255,193,70,255};
    end
    CSAPI.SetImgColor(gameObject,color[1],color[2],color[3],color[4]);
    CSAPI.SetTextColor(text,color[1],color[2],color[3],color[4]);
end


function SetClickCB(cb)
    this.callBack=cb;
end

function OnClickSelf()
    if this.callBack then
        this.callBack(this);
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
text=nil;
view=nil;
end
----#End#----