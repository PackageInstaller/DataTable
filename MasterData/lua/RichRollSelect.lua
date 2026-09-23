--固定步数选择
local top=nil;
local eventMgr=nil;
local curData={1,2,3,4,5,6};
local nowIdx=1;
local items={};

function OnOpen()
    UIUtil:ShowAction(node,nil,UIUtil.active2);
    Refresh();
end

function Refresh()
    --显示物品名称、数量  
    local activityData=RichManMgr:GetCurData();
    local sp=activityData:GetSpecialDice();
    CSAPI.SetText(txtName,sp:GetName());
    CSAPI.SetText(txtNum,LanguageMgr:GetByID(1036)..sp:GetCount());
    --创建子物体
    ItemUtil.AddItems("RichMan/RichRollSelectItem", items, curData, layout, OnClickItem,1,nowIdx)
end

function OnClickItem(lua)
    if lua and lua.GetIndex()~=nowIdx then
        items[nowIdx].SetSelect(false)
        nowIdx=lua.GetIndex()
        items[nowIdx].SetSelect(true)
    end
end

function OnClickUse()
    local point=curData[nowIdx];
    local activityData=RichManMgr:GetCurData();
    -- local gridInfo=activityData:GetCurPosGridInfo();
    -- local pos=(gridInfo:GetSort()+point)%32==0 and 32 or (gridInfo:GetSort()+point)%32;
    -- local proto={point=point,index=pos,mapId=1001,throwCnt=activityData:GetThrowCnt()+1};
    -- OperateActiveProto:RichManThrowRet(proto);
    -- Close();
    -- LogError(proto);
    local sp=activityData:GetSpecialDice();
    if sp:GetCount()>=1 then
        --发送投掷协议
        OperateActiveProto:RichManThrow(false,point);
        EventMgr.Dispatch(EventType.RichMan_Mask_Changed,true)
        Close();
    else
        --提示骰子数量不足
         Tips.ShowTips(LanguageMgr:GetTips(15000,sp:GetName()))
    end
end

function OnClick()
    Close();
end

function Close()
    if view~=nil then
        view:Close();
    end
end

function OnClickAnyway()
    Close();
end