function Refresh(data)
    this.data=data;
    CSAPI.SetText(txt,data.title);
    SetSelect(data.isSelect);
    if data.isSelect then
        OnClickSelf();
    end
end

function SetSelect(isSelect)
    local color= {189,189,189,255}
    local bg="UIs/Screen/columns.png";
    if isSelect==true then
        color= {198,255,0,255} ;
        bg="UIs/Screen/columns2.png";
    end
    CSAPI.SetTextColor(txt,color[1],color[2],color[3],color[4]);
    CSAPI.LoadImg(gameObject,bg,false,nil,true);
    CSAPI.SetGOActive(select,isSelect);
end

function SetClickCB(cb)
    this.callBack=cb;
end

function OnClickSelf()
    SetSelect(true);
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
select=nil;
txt=nil;
view=nil;
end
----#End#----