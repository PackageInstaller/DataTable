--宠物物品格子
local elseData=nil;
local quality=0;

function Awake()
    CSAPI.SetScale(icon,0.6,0.6,0.6);
end

--- func desc
---@param _d GridDataBase和它的衍生类
---@param _elseData table ={state =1:背包 =2:商店,price=int,isSelect=bool,commodity=commodity}
function Refresh(_d,_elseData)
    this.data=_d;
    this.elseData=_elseData;
    local isSelect=false;
    if _d then
        CSAPI.SetGOActive(icon,true);
        CSAPI.SetGOActive(numObj,true);
        _d:GetIconLoader():Load(icon, _d:GetIcon());
        quality=_d:GetQuality();
        if _elseData then
            isSelect=_elseData.isSelect;
            if _elseData.state==2 then
                CSAPI.SetGOActive(mIconNode,true);
                CSAPI.SetText(txtNum,tostring(_elseData.price));
            else
                CSAPI.SetGOActive(mIconNode,false);
                CSAPI.SetText(txtNum,tostring(_d:GetCount()));
            end
        else
            CSAPI.SetGOActive(mIconNode,false);
            CSAPI.SetText(txtNum,tostring(_d:GetCount()));
        end
    end
    SetSelect(isSelect);
end

function InitNull()
    quality=0;
    CSAPI.SetGOActive(icon,false);
    SetSelect();
    CSAPI.SetGOActive(numObj,false);
end

function SetSelect(isSelect)
    if quality==0 then
        CSAPI.SetGOActive(selectBg,false);
    else
        if isSelect then
            CSAPI.SetImgColorByCode(selectBg,"AF3636");
        else
            CSAPI.SetImgColorByCode(selectBg,PetQualityColor[quality]);
        end
        CSAPI.SetGOActive(selectBg,true);
    end
end

function SetIndex(idx)
    this.index=idx;
end

function GetIndex()
    return this.index or -1;
end

function SetClickCB(func)
	this.callBack = func;
end
function OnClickGrid()
    if this.callBack~=nil then
        this.callBack(this);
    end
end
