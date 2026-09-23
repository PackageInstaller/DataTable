--data；name:名字,isLight:是否显示高亮
function Refresh(_data)
    this.data=_data;
    if _data then
        CSAPI.SetText(txt_name,_data.name);
        CSAPI.SetText(txt_lvVal,tostring(_data.lv));
    end
end

function SetClickCB(cb)
    this.callBack=cb;
end

function OnClickItem()
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
bg=nil;
txt_lv=nil;
txt_lvVal=nil;
txt_name=nil;
view=nil;
end
----#End#----