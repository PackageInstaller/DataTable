--玩家头像框
local data=nil;
local cb=nil;
function Refresh(_d,_cb)
    data=_d;
    cb=_cb
    if _d then
       UIUtil:AddHeadByID(gridNode,1,data.icon_frame,data.icon_id,data.sel_card_ix);
       if data.lv then
         CSAPI.SetText(txt_lv,tostring(data.lv or 1));
       else
         CSAPI.SetText(txt_lv,tostring(data.level or 1));
       end
       CSAPI.SetText(txtName,data.name);
       CSAPI.SetGOActive(lvObj,true);
       CSAPI.SetGOActive(txtName,true);
    end
end

function OnClickSelf()
    if cb then
       cb(data) 
    end
end