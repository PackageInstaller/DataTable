local grids={};
local layout=nil;
local curDatas={};
function Awake()
    layout=ComUtil.GetCom(hsv,"UISV");
    layout:Init("UIs/Grid/GridItem",LayoutCallBack,true,0.6);
end

function Refresh(_d)
    if _d then
        CSAPI.SetText(txtRound,_d.round);
        --显示奖励内容
        curDatas=_d.reward;
        layout:IEShowList(#curDatas)
        CSAPI.SetGOActive(btnS,_d.state==2);
        CSAPI.SetGOActive(txtTips,_d.state==1);
    else
        CSAPI.SetGOActive(btnS,false);
        CSAPI.SetGOActive(txtTips,false);
    end
end

function LayoutCallBack(idx)
    local d=curDatas[idx];
    local item=layout:GetItemLua(idx);
    item.Refresh(d);
    item.SetClickCB(OnClickGrid);
end

function OnClickGrid(tab)
    if tab and tab.data then
        local data=BagMgr:GetFakeData(tab.data:GetID());
        UIUtil:OpenGoodsInfo(data, 3);
    end
end

function OnClickS()
    EventMgr.Dispatch(EventType.MTB_Click_Reward);
end
