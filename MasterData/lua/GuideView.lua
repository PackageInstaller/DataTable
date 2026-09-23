--引导界面

function Awake()
    --AdaptiveConfiguration.SetLuaUIFit("GuiDeView", node.gameObject)
    transPanel = transform.parent.parent;
    canvasGroup = ComUtil.GetCom(node,"CanvasGroup");
end

function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guide_Complete,OnGuideComplete);    
    eventMgr:AddListener(EventType.View_Lua_Ready, OnViewReady);         
    eventMgr:AddListener(EventType.Input_Event_Trigger,OnInputEventTrigger);
    eventMgr:AddListener(EventType.Guide_Custom_Complete,OnCustomComplete);
    eventMgr:AddListener(EventType.Guide_HangUp,OnGuideHangUp);    
    eventMgr:AddListener(EventType.Guide_SetShowState,SetShowState);    
    eventMgr:AddListener(EventType.Guide_View_SetTop,SetTop);   
    --eventMgr:AddListener(EventType.Net_Disconnect,OnNetDisconnect);
end
function OnDestroy()
    --AdaptiveConfiguration.LuaView_Lua_Closed("GuiDeView")
    eventMgr:ClearListener();    
    --EventMgr.Dispatch(EventType.Guide_State_Changed,false);
end

--网络断开连接
function OnNetDisconnect()
    GuideMgr:NetException();
end

--触发输入事件
function OnInputEventTrigger(go) 
    --检测点击目标是否为目标界面的按钮
    local cfg = data.cfg;
    if(not IsNil(go) and not IsNil(transform))then       
        --LogError("点击目标" .. go.name);
        --LogError(cfg);
        if(go.transform:IsChildOf(transform))then
            --LogError("点击目标" .. go.name .. "是自己的子对象");
            return;
        end

        local goName = go.name;
        if(goName and cfg.btn_check)then
            local findResult = string.find(goName,cfg.btn_check);
            if(not findResult or findResult <= 0)then
                return;
            end
        end

        if(cfg.view_open)then        
            local viewGo = CSAPI.GetViewPanel(cfg.view_open);
            if(viewGo)then
                if(not go.transform:IsChildOf(viewGo.transform))then
                    --LogError("点击目标" .. go.name .. "不是" .. viewGo.name .. "的子对象");
                    return;
                end
            end    
        end   
    end

    --自定义完成条件
    local cfg = data.cfg;
    if(cfg.custom_complete)then
        return;
    end

    ApplyComplete()
end

function ApplyComplete()
    if(isShow and not isComplete)then
        isComplete = true;
        SetClickMaskState(true);   
        --LogError("完成：" .. data.cfg.id);
        ResetParent();
        GuideMgr:InputEventTrigger(gameObject); 
    end    

    --CSAPI.SetGOActive(btnSkipLine,false);  
end

function OnCustomComplete()
    ApplyComplete();
end

function OnGuideComplete()
    --LogError("引导关闭：" .. CSAPI.GetTime());
    if(not IsNil(view))then
        view:Close();
    end
end

function OnViewReady(viewKey)    
    --LogError("界面" .. viewKey);
    TryShowGuide();
end

function OnGuideHangUp() 
    HideLastPos();    
    CSAPI.SetGOActive(guider,false);
    SetClickMaskState(false);   
    CSAPI.SetGOActive(btnSkipAll,false);
    CSAPI.SetGOActive(btnSkipLine,false);
end

function OnOpen()
    --LogError("开启引导界面==========================================\n" .. table.tostring(data));

    isShow = false;    
    isComplete = false;
    SetClickMaskState(true);   

    HideLastPos();    

    TryShowGuide();
end

function TryShowGuide()
    if(isShow)then
        return;
    end
    local cfg = data.cfg;

    local isViewOpen = IsViewOpen();
    if(isViewOpen)then
        ApplyShow();
    else
        ResetParent();
        SetClickMaskState(true);   
        CSAPI.SetGOActive(node,false);  
    end

    if(cfg.click_mask_life)then
        FuncUtil:Call(UpdateMaskState,nil,cfg.click_mask_life);
    end
end

function UpdateMaskState()
    local isViewOpen = IsViewOpen();
    if(isViewOpen)then
        return;
    end
    SetClickMaskState(false);   
end

function ApplyShow()   
    local cfg = data.cfg;
    local delayShowTime = cfg.delay_show;
    
    SetClickMaskState(delayShowTime and true or false);   
    if(delayShowTime)then
        FuncUtil:Call(Show,nil,delayShowTime);
        CSAPI.SetGOActive(node,false);   
    else
        Show();
    end
end

function InitParent()

    originParent = originParent or (transPanel and transPanel.parent);

    local cfg = data.cfg;
    if(not cfg.origin_parent and cfg.view_open)then
        local go = CSAPI.GetViewPanel(cfg.view_open);
        if(go)then
            local trans = go.transform;
            CSAPI.SetParent(transPanel,trans.parent);

            transPanel:SetSiblingIndex(trans:GetSiblingIndex() + 1);
        end
    elseif(originParent)then
        CSAPI.SetParent(transPanel,originParent);
        SetLastSibling();
    end
end

function ResetParent()
    if(originParent)then
        CSAPI.SetParent(transPanel,originParent);
    end
end
function SetTop()
    ResetParent();
    if(transPanel)then
        transPanel:SetAsLastSibling();
    end
end

function IsViewOpen()
    local cfg = data.cfg;
    if(cfg.view_open)then--指定目标界面被打开
        --LogError("界面" .. tostring(cfg.view_open) .. ":" .. tostring(CSAPI.IsViewOpen(cfg.view_open)));
        return CSAPI.IsViewOpen(cfg.view_open);
    end
    return true;
end

function Show()
    if(isShow)then
        return;
    end
    --LogError("新引导显示" .. data.cfg.id .. "：" .. CSAPI.GetTime());

    isShow = true;
    --EventMgr.Dispatch(EventType.Guide_State_Changed,true);
    EventMgr.Dispatch(EventType.Guide_Scroll_Switch,false,true);
    SetClickMaskState(false);  
    CSAPI.SetGOActive(node,true);  

    local cfg = data.cfg;
    local showCfg = GetShowCfg(cfg);

    local resName = showCfg.name or "Mask";    

    if(cfg.canvas_match and CSAPI.GetCanvasMatch() < 0.5)then
        resName = resName .. "_Match";
    end

    if(resName and posNode)then
        local posGO = ResUtil:CreateUIGO("Guide/" .. resName,posNode.transform);
        posLua = ComUtil.GetLuaTable(posGO);
        --LogError(cfg);
        if(cfg.view_node and cfg.view_open)then
            local viewGO = CSAPI.GetView(cfg.view_open); 
            local viewLua = ComUtil.GetLuaTable(viewGO);  
            local viewNode = viewLua[cfg.view_node];
       
            if(viewNode)then
                if(posLua)then
                    posLua.FixPos(viewNode);
                end
            else
                LogError(string.format("界面%s不存在节点%s",cfg.view_open,cfg.view_node));
            end
        end

        itemGO = ResUtil:CreateUIGO("Guide/GuideItem",posLua.GetPos().transform);
        itemLua = ComUtil.GetLuaTable(itemGO);
        itemLua.Set(cfg);

        if(currShowState == false)then
             itemLua.SetShowState(false);
        end
    end
        
    CSAPI.SetGOActive(guider,not StringUtil:IsEmpty(showCfg.desc));
    CSAPI.SetGOActive(btnSkipAll,not StringUtil:IsEmpty(showCfg.desc));

    --LogError(cfg);
    CSAPI.SetGOActive(btnSkipLine,cfg.skip and true or false);
    --CSAPI.SetGOActive(btnSkipLine,true);
    --CSAPI.SetGOActive(btnSkipLine,not StringUtil:IsEmpty(showCfg.desc));
    if(_G.Guid_Skin_Btn)then
        CSAPI.SetGOActive(btnSkipLine,true);
    end
    CSAPI.SetText(guiderName,showCfg.iconName or "");

    local descContent = showCfg.desc or "";
    descContent = string.format(descContent,PlayerClient:GetName() or "");
    CSAPI.SetText(descText,descContent);

    local hasIcon = not StringUtil:IsEmpty(showCfg.icon);
    
    if(hasIcon)then
        --ResUtil.RoleCard:Load(guiderImg,showCfg.icon);
        ResUtil.RoleCard:Load(guiderImg,showCfg.icon);
    end


    ----测试用，设置引导id显示
    CSAPI.SetText(txtID,tostring(cfg.id));
    
    --CSAPI.SetAnchor(guiderImg,(cfg.guider_pos and 1 or -1) * 400,160);--引导者位置
    --CSAPI.SetScale(guiderImg,cfg.guider_flip and -1 or 1,1,1);--引导者翻转
    --CSAPI.SetScale(descbg,cfg.guider_pos and -1 or 1,1,1);--对话框翻转
    
    local descPosX = cfg.desc_pos and cfg.desc_pos[1] or 0;
    local descPosY = cfg.desc_pos and cfg.desc_pos[2] or 0;
    CSAPI.SetAnchor(guider,descPosX,descPosY);--描述位置

    local descW = cfg.desc_size and cfg.desc_size[1] or 1000;
    local descH = cfg.desc_size and cfg.desc_size[2] or 197;
    
    CSAPI.SetRTSize(desc,descW,descH);

    if(cfg.to_next)then
        SetClickMaskState(true);
        FuncUtil:Call(function()
            SetClickMaskState(false);
            SetBtnNextState(true);
        end,nil,500,true);
        CSAPI.SetGOActive(txtNext,true);  
    else
        SetBtnNextState(false);
        CSAPI.SetGOActive(txtNext,false); 
    end    

    CSAPI.SetGOActive(btnSkip,cfg.skip and true or false); 
    
    InitParent();

    --SetLastSibling();
end

function SetLastSibling()
    if(transPanel)then
        transPanel:SetAsLastSibling();  
    end
end

function SetItemPos(data)
    local x,y,z = CSAPI.GetPos(data.targetPos);
    CSAPI.SetPos(data.itemPos,x,y,z);
end

function GetShowCfg(cfg)
    GuideBehaviour = GuideMgr:GetBehaviour();
    if(cfg.name)then   
        local func = GuideBehaviour["GuideBehaviourShowCfg_" .. cfg.name];

        if(func)then
            local targetCfg = func(GuideBehaviour);
            if(targetCfg)then
                return targetCfg;
            end
        end
    end

    return cfg;
end

function HideLastPos()
    if(posLua)then
        posLua.Hide();
    end
    posLua = nil;
end

function OnClickSkip()
    EventMgr.Dispatch(EventType.Guide_Skip);
end

function OnClickSkipLine()
    FightGridSelMgr.CloseInput(false);--部分引导关闭了输入，跳过时恢复

    EventMgr.Dispatch(EventType.Guide_Skip_Line);
end

function OnClickSkipAll()
    GuideMgr:SkipAll();
end

function OnClickNext()
    if(isShow)then
        SetBtnNextState(false);   
        CSAPI.SetGOActive(txtNext,false);    
        --LogError("点击下一步");
        OnInputEventTrigger();
    end
end

function SetBtnNextState(state)
    --LogError("state:" .. tostring(state));
    CSAPI.SetGOActive(btnNext,state);   
end
function SetClickMaskState(state)
    --LogError("clickMask:" .. tostring(state));
    CSAPI.SetGOActive(clickMask,state);   
end
function SetShowState(state)
    SetClickMaskState(not state); 
    currShowState = state;
    canvasGroup.alpha = state and 1 or 0;
    if(itemLua)then
        itemLua.SetShowState(state);
    end
end