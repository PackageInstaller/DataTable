local selectIdx=1;
local layout=nil
function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/AISetting/AIConditionItem",LayoutCallBack,true);
end

function OnOpen()
    curDatas={};
    local lId=31005
    if openSetting==nil or openSetting==AIConditionOpenType.Sort then
        lId=31005
    elseif openSetting==AIConditionOpenType.Condition then
        lId=31006
    elseif openSetting==AIConditionOpenType.Target then
        lId=31007
    end
    CSAPI.SetText(txt_title,LanguageMgr:GetByID(lId));
    LanguageMgr:SetEnText(txt_titleTips,lId);
    if data then
        if data.max then
            for i=1,data.max do
                table.insert(curDatas,i);
            end
        else
            curDatas=data.list
        end
        selectIdx=data.select;
    end
    layout:IEShowList(#curDatas);
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item=layout:GetItemLua(index);
    if openSetting==AIConditionOpenType.Sort then
        item.Refresh({txt=_data,index=index},selectIdx==index,OnClickItem);
    else
        item.Refresh({txt=_data.description,cfg=_data,index=index},selectIdx==index,OnClickItem);
    end
    item.ShowLine(index~=#curDatas);
end

function OnClickItem(tab)
    selectIdx=tab.index;
    layout:UpdateList();
end

function OnClickOK()
    if data then
        local val=selectIdx
        if openSetting==nil or openSetting==AIConditionOpenType.Sort then--前端显示的排序为倒序
            val=math.abs(selectIdx-data.max)+1;
        end
        EventMgr.Dispatch(EventType.Team_Confirm_SetAIPrefab,{type=openSetting,val=val,id=data.id});
    end
    view:Close();
end

