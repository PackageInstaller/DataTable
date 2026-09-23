local layout=nil;
local curDatas={};
local eventMgr=nil;
function Awake()
    layout = ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/MultTeamBattle/MultTeamRewardItem",LayoutCallBack,true,1);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.MTB_Data_Update,OnDataUpdate)
end

function OnDestroy()
    eventMgr:ClearListener();
 end

function OnDataUpdate()
    Refresh()
end

function OnOpen()
    Refresh()
end

function  Refresh()
    local activityData=MultTeamBattleMgr:GetCurData();
    if activityData then
        curDatas={};
        local cfg=activityData:GetRewardCfg();
        if cfg then
            for k, v in ipairs(cfg.infos) do
                local state=nil;
                local str=nil;
                local rewards={};
                if activityData:GetRound()>=v.timesMin and activityData:GetRound()<=v.timesMax then
                    if activityData:IsSettle() then
                        state=3;
                    elseif activityData:GetActivityState()==MultTeamActivityState.Settlement then
                        state=2;
                    elseif activityData:GetActivityState()==MultTeamActivityState.Open then
                        state=1;
                    end
                end
                if v.timesMin==v.timesMax then
                    str=LanguageMgr:GetByID(77036,v.timesMin);
                else
                    str=LanguageMgr:GetByID(77026,v.timesMin,v.timesMax);
                end
                for _,val in ipairs(v.reward) do
                    local info=GridUtil.RandRewardConvertToGridObjectData({id=val[1],num=val[2],type=v[3] or RandRewardType.ITEM})
                    table.insert(rewards,info);
                end
                table.insert(curDatas,{
                    round=str,
                    reward=rewards,
                    state=state,
                });
            end
        end
        layout:IEShowList(#curDatas);
    end
end

function LayoutCallBack(index)
    local d=curDatas[index]
    local grid=layout:GetItemLua(index);
    grid.Refresh(d);
end

function OnClickClose()
    view:Close();
end