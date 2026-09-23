--宠物页签
local isLock=false;
local data=nil;
local key=nil;
local clickImg=nil;
function Awake()
    clickImg=ComUtil.GetCom(gameObject,"Image");
end

function Refresh(_d,_elseData)
    local isOn=false
    data=_d;
    if _d then
        CSAPI.SetText(txtName,LanguageMgr:GetByID(_d.lId));
        if _elseData then
            isOn=_d.id==_elseData.idx;
            key=_elseData.key;
        end
    end
    isLock=_d.isLock==true
    -- clickImg.raycastTarget=not isLock;
    CSAPI.SetGOActive(lockImg,isLock);
    local color={109,146,178,255};
    if isLock then
        color={209,186,162,255};
    elseif isOn then
        color={175,54,54,255}
    end
    CSAPI.SetImgColor(bg,color[1],color[2],color[3],color[4]);
    CSAPI.SetGOActive(onImg,isOn);
end

function OnClickSelf()
    if not isLock and data then
        EventMgr.Dispatch(EventType.PetActivity_Head_Click,{data=data,key=key})
    elseif isLock and data then
        Tips.ShowTips(LanguageMgr:GetTips(data.lID));
    end
end