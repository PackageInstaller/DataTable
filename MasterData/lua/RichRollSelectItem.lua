--骰子物体
local func=nil;
function Refresh(data,nowIdx)
    if data~=nil then
        --加载图标
        this.data=data;
        CSAPI.LoadImg(img,string.format("UIs/RichMan/img_06_0%s.png",this.data),true,nil,true);
        SetSelect(nowIdx==GetIndex());
    end
end

function SetSelect(isSelect)
    -- local scale=isSelect and 1 or 0.7;
    -- CSAPI.SetScale(img,scale,scale,scale);
    local color=isSelect and "f9b616" or "a29f95"
    CSAPI.SetImgColorByCode(img,color);
    CSAPI.SetGOActive(selectObj,isSelect);
end

function GetIndex()
    return this.index;
end

function SetScale(s)
    CSAPI.SetScale(img,s,s,s);
end

function GetPos()
    local pos={100000,100000,0};
    local x,y,z=CSAPI.GetPos(img);
    pos={x,y,z}
    return pos;
end

function SetSibling(index)
    index=index or 0;
    if index==-1 then
        transform:SetAsLastSibling();
    else
        transform:SetSiblingIndex(index);
    end
end

function SetIndex(i)
    this.index=i;
end

function SetClickCB(_func)
    func=_func;
end

function OnClick()
    if func~=nil then
        func(this);
    end
end