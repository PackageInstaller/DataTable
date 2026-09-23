--引导界面

function Set(cfg)
    currCfg = cfg;
    local isCommonCtrl = not cfg.custom_ctrl;
   
    EventMgr.Dispatch(EventType.Input_Event_State,isCommonCtrl,true);	
    CSAPI.SetGOActive(btn,not isCommonCtrl);

    local btnFindState = not isCommonCtrl and cfg.btn_check and true or false;
    CSAPI.SetGOActive(btnFind,btnFindState);

    if(cfg.mask_alpha)then
        local canvasGroup = ComUtil.GetCom(mask, "CanvasGroup");
        canvasGroup.alpha = cfg.mask_alpha * 0.01;
    end

    CSAPI.SetGOActive(frame,not cfg.no_click_frame);
    CSAPI.SetGOActive(aniFrame,cfg.name and (not cfg.no_ani_frame) and true or false);

    FuncUtil:Call(CSAPI.SetGOActive,nil,100,clickMask,false);

    if(cfg.hand_angle)then
        CSAPI.SetAngle(frame,0,0,cfg.hand_angle);
    end
    --CSAPI.SetAngle(frame,0,0,180);

    if(cfg.click_frame_focus)then
        PlayAniAction()
    end
end

--启动动画
function PlayAniAction()
    CSAPI.SetScale(frame,0,0,0);
    CSAPI.SetGOActive(aniClickMask,true);
    CSAPI.ApplyAction(mask,"action_guide");

    FuncUtil:Call(OnAniActionComplete,nil,1000);
end
function OnAniActionComplete()
    CSAPI.SetScale(frame,1,1,1);
    CSAPI.SetGOActive(aniClickMask,false);
end


function SetPos(go)
    
end

function OnClick()
    if(currCfg)then
        GuideMgr:ApplyBehaviour(currCfg);
        currCfg = nil;
    end
end


function OnClickSkip()
    --g_SkipGuide = 5;
    if(not g_SkipGuide or g_SkipGuide <= 0)then
        return;
    end

    local clickTime = CSAPI.GetTime();
    if(not lastClickTime or clickTime - lastClickTime < 1)then        
        clickedCount = clickedCount or 0;
        clickedCount = clickedCount + 1;
        
        if(clickedCount >= g_SkipGuide)then
            clickedCount = 0;
            
            FightGridSelMgr.CloseInput(false);--部分引导关闭了输入，跳过时恢复
            EventMgr.Dispatch(EventType.Guide_Skip_Line);
        end
    else
        clickedCount = 1;
    end
    --LogError(clickedCount);
    lastClickTime = clickTime;
end

function OnClickFindBtn()
    if(currCfg)then          
        if(GuideMgr:ApplyCallBtn(currCfg))then
            currCfg = nil;
        end
    end
end


function SetShowState(state)
    CSAPI.SetGOActive(showNode,state);
end