local data=nil;
local elseData=nil;
local currNum=0;
local tween=nil;
local quality=0;
local clickImg=nil;
function Awake()
    tween=ComUtil.GetCom(addTween,"ActionScaleT");
    clickImg=ComUtil.GetCom(gameObject,"Image");
end
--- func desc
---@param _d GridDataBase和它的衍生类
---@param _elseData table ={state =1:背包 =2:商店,currNum=currNum}
function Refresh(_d,_elseData)
    data=_d;
    elseData=_elseData;
    quality=0;
    currNum=_elseData and _elseData.currNum or 1;
    if _d then
        _d:GetIconLoader():Load(icon, _d:GetIcon());
        quality=_d:GetQuality();
        local isSelect=false;
        if _elseData then
            isSelect=_elseData.isSelect;
            if _elseData.state==2 then
                CSAPI.SetGOActive(mIconNode,true);
                CSAPI.SetText(txtNum,tostring(_elseData.price*currNum));
            else
                CSAPI.SetGOActive(mIconNode,false);
                CSAPI.SetText(txtNum,tostring(currNum));
            end
        else
            CSAPI.SetGOActive(mIconNode,false);
            CSAPI.SetText(txtNum,tostring(currNum));
        end
    end
    SetQuality()
    SetAddNum(currNum)
end

function SetNull()
    CSAPI.SetRTSize(icon,0,0);
    quality=0;
    SetQuality()
    SetAddNum(0)
end

function SetQuality()
    if quality==0 then
        CSAPI.SetGOActive(selectBg,false);
    else
        CSAPI.SetImgColorByCode(selectBg,PetQualityColor[quality]);
        CSAPI.SetGOActive(selectBg,true);
    end
end

function SetAddNum(num)
    num=num or 0;
    CSAPI.SetGOActive(addNum,num>1);
    CSAPI.SetGOActive(btnRemove,num>1);
    CSAPI.SetGOActive(numObj,num>0);
    currNum=num;
    if elseData and elseData.state==2 then
        CSAPI.SetGOActive(mIconNode,true);
        CSAPI.SetText(txtNum,tostring(elseData.price*currNum));
    else
        CSAPI.SetGOActive(mIconNode,false);
        CSAPI.SetText(txtNum,tostring(currNum));
    end
    if num>1 then
       CSAPI.SetText(txtAddNum,tostring(num));
    end
    if tween then
        tween:Play();
    end
end

function SetIndex(idx)
    this.index=idx;
end

function GetIndex()
    return this.index or -1;
end

function OnClickAdd()
    OnClickGrid();
end

function OnClickRemove()
    currNum =currNum or 0;
    if currNum>0 then
        SetAddNum(currNum-1);
    end
    if this.removeCB then
        this.removeCB(currNum);
    end
end

function SetClickCB(func,func2)
	this.callBack = func;
    this.removeCB=func2;
    if clickImg then
        clickImg.raycastTarget=this.callBack~=nil;
    end
end

function OnClickGrid()
    if this.callBack~=nil then
        this.callBack(data);
    end
end