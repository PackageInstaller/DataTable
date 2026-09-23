
local selected=false;
function Refresh(data,cb)
    this.data=data.data;
    this.callBack=cb;
    if this.data then
        CSAPI.SetText(txt,this.data.sName);
        SetSelect(data.isSelect);
    end
end

function SetSelect(isSelect)
    local color= {189,189,189,255}
    local bg="UIs/Screen/frame_click.png";
    if isSelect==true then
        color= {0,0,0,255} ;
        bg="UIs/Screen/green_click.png";
    end
    selected=isSelect;
    CSAPI.SetTextColor(txt,color[1],color[2],color[3],color[4]);
    CSAPI.LoadImg(select,bg,false,nil,true);
end

function OnClickSelf()
    SetSelect(not selected);
    if this.callBack then
        this.callBack(this);
    end
end

function GetChoosieID()
    if selected and this.data then
        return this.data.id;
    end
    return nil;
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
select=nil;
txt=nil;
view=nil;
end
----#End#----