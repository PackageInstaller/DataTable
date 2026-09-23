--宠物图鉴格子
local cb=nil;
local stars=nil;
local elseData=nil;

function Awake()
    stars={starImg1,starImg2,starImg3}
    CSAPI.SetScale(icon,0.3,0.3,0.3);
end

function Refresh(_d,_elseData)
    this.data=_d;
    elseData=_elseData;
    if this.data then
        CSAPI.SetGOActive(NOObj,true);
        CSAPI.SetGOActive(qualityObj,true);
        SetIcon(this.data:GetIcon(),_elseData and _elseData.isPre==true or false);
        SetQuality(this.data:GetQuality());
        CSAPI.SetText(txtNO,this.data:GetNONumb());
    else
        InitNull();
    end
end

function InitNull()
    CSAPI.SetGOActive(NOObj,false);
    CSAPI.SetGOActive(qualityObj,false);
    SetIcon();
end

function InitNull2()
    CSAPI.SetGOActive(NOObj,false);
    CSAPI.SetGOActive(qualityObj,false);
    CSAPI.SetGOActive(icon,false);
end

function SetQuality(num)
    num=num~=nil and num or 0;
    if not IsNil(stars) then
        for i=1,#stars do
            CSAPI.SetGOActive(stars[i],num>=i);
        end
    end
end

function SetIcon(resName,isLock)
    if resName then
        if isLock then
            CSAPI.SetImgColor(icon,181,157,131,255);
            CSAPI.LoadImg(icon,"UIs/Pet/img_04_15.png",true,nil,true);    
            CSAPI.SetScale(icon,1,1,1);
        else
            CSAPI.SetImgColor(icon,255,255,255,255);
            ResUtil.IconGoods:Load(icon,resName);
            CSAPI.SetScale(icon,0.3,0.3,0.3);
        end
    else
        CSAPI.SetImgColor(icon,255,255,255,255);
        CSAPI.LoadImg(icon,"UIs/Pet/img_04_19.png",true,nil,true);   
        CSAPI.SetScale(icon,1,1,1);   
    end
    CSAPI.SetGOActive(icon,true);
end

function SetClickCB(_cb)
    cb=_cb;
end

function SetIndex(i)
    this.index=i;
end

function GetIndex()
    return this.index;
end

function OnClick()
    if cb then
        cb(this)
    end
end