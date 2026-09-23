local animator=nil;
local isPlaying=false;
local canvasGroup=nil;
local dungeonCfg=nil;
local clickImg=nil;
local canvasGroup2=nil;

function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator");
    canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
    canvasGroup2=ComUtil.GetCom(mImg,"CanvasGroup");
    clickImg=ComUtil.GetCom(gameObject,"Image")
end

--显示怪物立绘和攻击状态
function Refresh(_dungeonCfg,delayTime)
    dungeonCfg=_dungeonCfg;
    if _dungeonCfg then 
        local activityData=MultTeamBattleMgr:GetCurData();
        if activityData then
            local isShow=false;
            if activityData:GetActivityState()==MultTeamActivityState.Open and activityData:IsPass(_dungeonCfg.id) then
                CSAPI.SetText(txtState,LanguageMgr:GetByID(77009));
                isShow=true
            elseif activityData:GetActivityState()==MultTeamActivityState.Settlement then
                CSAPI.SetText(txtState,LanguageMgr:GetByID(77010));
                isShow=true
            end
            CSAPI.SetGOActive(stateObj,isShow);
            canvasGroup2.alpha=isShow and 0.3 or 1;
            clickImg.raycastTarget=not isShow;
        end
        if _dungeonCfg.enemyPreview then
            local mCfg = Cfgs.MonsterData:GetByID(_dungeonCfg.enemyPreview[1]);
            if mCfg then
                local modelCfg=Cfgs.character:GetByID(mCfg.model);
                ResUtil.CardIcon:Load(mImg,modelCfg.Card_head);
            end
        end
    end
    if animator and delayTime and isPlaying~=true then
        FuncUtil:Call(function()
            canvasGroup.alpha=1;
            if animator then
                animator:Play("enter");
                FuncUtil:Call(SetAnimaEnd,nil,1250);
            end
        end,nil,delayTime);
        isPlaying=true;
    end
end

function SetAnimaEnd()
    isPlaying=false;
end

function OnClickItem()
    EventMgr.Dispatch(EventType.MTB_Click_Dungeon,dungeonCfg);
end