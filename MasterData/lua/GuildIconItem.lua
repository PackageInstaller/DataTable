--公会图标
local cb=nil;
local isSelect=false;
function Refresh(_data,_elseData)
    this.data=_data;
    elseData=_elseData;
    local cfg=Cfgs.character:GetByID(this.data:GetSkinID())
    if cfg then
        ResUtil.RoleCard:Load(icon, cfg.icon)
    end
    isSelect=_elseData.isSelect;
    CSAPI.SetGOActive(choosie,_elseData.isSelect);
end

function SetClickCB(_cb)
    cb=_cb;
end

function SetIndex(index)
	this.index=index;
end

function OnClickSelf()
    if not isSelect then
        isSelect=true;
        CSAPI.SetGOActive(choosie,isSelect);
    end
    if cb then
        cb(this);
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
icon=nil;
choosie=nil;
view=nil;
end
----#End#----