--SDK支付选择子物体
local cb=nil;
local image=nil;
function Awake()
    image=ComUtil.GetCom(icon,"Image");
end

function Refresh(_d,_elseData)
    this.data=_d;
    if this.data then
        CSAPI.LoadImg(icon,string.format("UIs/SDK/%s.png",_d.icon),true,nil,true);
        CSAPI.SetText(txt_type,LanguageMgr:GetByID(_d.tipsID));
        CSAPI.SetGOActive(defObj,_d.isDefault==true);
        if _elseData then
            CSAPI.SetGOActive(onObj,_elseData.currType==_d.type);
        else
            CSAPI.SetGOActive(onObj,false);
        end
    end
end

function SetClickCB(_cb)
    cb=_cb;
end

function OnClickItem()
    if cb~=nil then
        cb(this);
    end
end

function SetIndex(i)
    index=i;
end

function GetIndex()
    return index;
end