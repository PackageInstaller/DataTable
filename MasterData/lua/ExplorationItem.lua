--测绘子物体
local data=nil;
-- local nIconT=nil;
-- local pIconT=nil;
local tGrid=nil;
local dGrid=nil;
local nGrid=nil;
-- function Awake()
    -- nIconT=ComUtil.GetCom(n_iconTween,"ActionUIMaterialFloat");
    -- pIconT=ComUtil.GetCom(p_iconTween,"ActionUIMaterialFloat");
-- end
function Refresh(_d)
    data=_d;
    InitNormal(data.base);
    InitPlus(data.plus);
    local curData=ExplorationMgr:GetCurrData();
    if data and curData and data.base:GetLv()==curData:GetCurrLv() then
        CSAPI.SetGOActive(txtBg,true);
    else
        CSAPI.SetGOActive(txtBg,false);
    end
    -- PlayIconTween();
end

function InitNormal(n)
    if n then
        CSAPI.SetGOActive(normal,true);
        local state=n:GetState();
        local isUnLock=false;
        if state==ExplorationRewardState.Available or state==ExplorationRewardState.UnLock  then
            isUnLock=true;
        end
        if nGrid==nil then --普通奖励格子
            ResUtil:CreateUIGOAsync("Exploration/ExplorationGrid",nObj,function(go)
                nGrid=ComUtil.GetLuaTable(go)
                nGrid.Refresh(n:GetRewardData()[1],state,n.cfg.tag~=nil,isUnLock);
                nGrid.SetClickCB(OnClickNormal);
            end);
        else
            nGrid.Refresh(n:GetRewardData()[1],state,n.cfg.tag~=nil,isUnLock);
            nGrid.SetClickCB(OnClickNormal);
        end
        CSAPI.SetGOActive(shadow,state==ExplorationRewardState.Lock);
        SetLv(n:GetLv()); 
    else
        CSAPI.SetGOActive(normal,false);
    end
end

function InitPlus(p)
    if p then
        CSAPI.SetGOActive(plus,true);
        local rewards = p:GetRewardData();
        local pState=p:GetState();
        local hasEff1=false;
        local hasEff2=false;
        if p.cfg.tag==1 or p.cfg.tag==2 then
            hasEff1=true;
        end
        if p.cfg.tag==2 or p.cfg.tag==3 then
            hasEff2=true;
        end
        local isUnLock=false;
        if pState==ExplorationRewardState.Available or pState==ExplorationRewardState.UnLock  then
            isUnLock=true;
        end
        if tGrid==nil then --第一个奖励格子
            ResUtil:CreateUIGOAsync("Exploration/ExplorationGrid",topObj,function(go)
                tGrid=ComUtil.GetLuaTable(go)
                tGrid.Refresh(rewards[1],pState,hasEff1,isUnLock);
                tGrid.SetClickCB(OnClickPlus);
            end);
        else
            tGrid.Refresh(rewards[1],pState,hasEff1,isUnLock);
            tGrid.SetClickCB(OnClickPlus);
        end
        if #rewards>1 then
            CSAPI.SetGOActive(downObj,true);
            if dGrid==nil then --第二奖励格子
                ResUtil:CreateUIGOAsync("Exploration/ExplorationGrid",downObj,function(go)
                    dGrid=ComUtil.GetLuaTable(go)
                    dGrid.Refresh(rewards[2],pState,hasEff2,isUnLock);
                    dGrid.SetClickCB(OnClickPlus);
                end);
            else
                dGrid.Refresh(rewards[2],pState,hasEff2,isUnLock);
                dGrid.SetClickCB(OnClickPlus);
            end
        else
            CSAPI.SetGOActive(downObj,false);
        end
        if pState==ExplorationRewardState.Lock then
            CSAPI.SetGOActive(pShadow,true);
            CSAPI.SetGOActive(tLockObj,true);
            CSAPI.SetGOActive(dLockObj,#rewards>1);
        else
            CSAPI.SetGOActive(pShadow,false);
        end
        
    else
        CSAPI.SetGOActive(plus,false);
    end
end

-- function PlayIconTween() --播放扫光动画
--     if nIconT then
--         nIconT:Play();
--     end
--     -- if pIconT then
--     --     pIconT:Play();
--     -- end
-- end

function SetLv(lv)
    CSAPI.SetText(txt_lv,LanguageMgr:GetByID(1033)..lv)
end

function OnClickAvailable(state,cfgId,rId,lv) 
    if state==ExplorationRewardState.Available then --可领取
        ExplorationProto:GetReward(cfgId,rId,lv);
    end
end

function OnClickNormal(tab)
    local curData=ExplorationMgr:GetCurrData();
    local state=data.base:GetState();
    if state==ExplorationRewardState.Available then
        OnClickAvailable(state,curData:GetCfgID(),curData:GetBaseRewardID(),data.base:GetLv());
    else
        GridClickFunc.OpenNotGet(tab);
    end
end

function OnClickPlus(tab)
    local curData=ExplorationMgr:GetCurrData();
    local state=data.plus:GetState();
    if state==ExplorationRewardState.Available then
        OnClickAvailable(state,curData:GetCfgID(),curData:GetExRewardID(),data.base:GetLv());
    else
        GridClickFunc.OpenNotGet(tab);
    end
end

function OnClickShadow()
    local curData=ExplorationMgr:GetCurrData();
    local state=data.plus:GetState();
    if state~=ExplorationState.Plus  then
        -- CSAPI.OpenView("ExplorationBuy");
        UIUtil:OpenExplorationBuy()
    end
end