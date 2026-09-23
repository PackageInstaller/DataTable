local isHide = false
function Awake()
    CSAPI.SetGOActive(btnDetail,false)
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data,_elseData)
    data =_data;
    if _elseData ==  CommodityItemType.SingleSelection and index == 1 then
        CSAPI.SetGOActive(btnChange, false)
    else
        CSAPI.SetGOActive(btnChange, true)
    end
    if data then
        CSAPI.SetText(txt_name,data:GetName());
        CSAPI.SetText(txt_num,"X"..data:GetCount());
        CSAPI.SetTextColorByCode(txt_name,"ffffff")
    else
        LanguageMgr:SetText(txt_name,73006)
        CSAPI.SetText(txt_num,"");
        CSAPI.SetTextColorByCode(txt_name,"ffc146")
    end
end

function OnClickDetail()
    --显示物品详情
    if data then
        UIUtil:OpenGoodsInfo(data,2)
    end
end

function OnClickChange()
    if cb then
        cb(this)
    end
end