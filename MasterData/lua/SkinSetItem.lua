--皮肤合集子物体
local clickCB=nil;
function Refresh(_d)
    if _d then
        this.data=_d
        ResUtil.SkinSetIcon:Load(icon,_d.icon.."_w");
        CSAPI.SetText(txt_name,_d.name);
    end
end

function SetClickCB(_cb)
    clickCB=_cb
end

function OnClickSelf()
    if clickCB~=nil then
        clickCB(this)
    end
end