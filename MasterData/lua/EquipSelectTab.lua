--筛选页签
local data=nil;
local click=nil;
function Refresh(_data,elseData)
    data=_data;    
    local isSelect=_data==elseData
    SetSelect(isSelect)
end

function SetClickCB(_cb)
    click=_cb;
end

function SetSelect(isSelect)
    local imgName="";
    if data>0 then
        imgName=isSelect and string.format("UIs/EquipSelect/btn_2%s_02.png",data+1) or string.format("UIs/EquipSelect/btn_2%s_01.png",data+1)
    else
        imgName=isSelect and "UIs/EquipSelect/btn_21_02.png" or "UIs/EquipSelect/btn_21_01.png"
    end
    CSAPI.LoadImg(img,imgName,true,nil,true);
    CSAPI.SetGOActive(onObj,isSelect==true);
end

function OnClickSelf()
    if click then
        click(data)
    end
end