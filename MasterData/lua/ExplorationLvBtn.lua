--勘探等级按钮
local currLv=0;
--- func desc
---@param data table={lv,state,isSelect}
function Refresh(data)
    if data then
        currLv=data.lv;
        SetSelect(data.isSelect);
        SetLv(data.lv);
        SetState(data.state);
    end
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selectBg,isSelect);
end

function SetLv(lv)
    local lvStr="";
    if lv<10 then
        lvStr="0"..lv
    else
        lvStr=tostring(lv)
    end
    CSAPI.SetText(txt_lv,lvStr);
end

function SetState(state)
    local isShow=true;
    if state==1 then--完成但是未领取
        CSAPI.LoadImg(point,"UIs/Exploration/img_04_01.png",true,nil,true);
    elseif state==2 then--已领取
        CSAPI.LoadImg(point,"UIs/Exploration/img_04_02.png",true,nil,true);
    else--其余
        isShow=false;
    end
    CSAPI.SetGOActive(point,isShow);
end

function OnClickSelf()
    EventMgr.Dispatch(EventType.Exploration_Click_Lv,currLv)
end