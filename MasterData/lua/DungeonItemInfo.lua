
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Dungeon_InfoPanel_Update, OnPanelUpdate)

    infoFade = ComUtil.GetCom(gameObject, "ActionFade")
    infoCG = ComUtil.GetCom(gameObject, "CanvasGroup")
    infoMove = ComUtil.GetCom(gameObject, "ActionMoveByCurve")

    InitInfo()
end

function OnPanelUpdate(_data)
    if _data then
        currCfg = _data
        infoUtil:Set(_data)
    end
    infoUtil:RefreshPanel()
end

function InitInfo()
    infoUtil = DungeonInfoUtil.New()
    _, goY, _ = CSAPI.GetLocalPos(childNode);
    outPos = {4000, goY, 0};
    enterPos = GetEnterPos()
    CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
    CSAPI.SetGOActive(gameObject, false);
    CSAPI.SetGOActive(clickMask, false)
    CSAPI.SetGOActive(mask, false)
end

function GetEnterPos()
    -- canvasSize = CSAPI.GetMainCanvasSize()
    -- local offset = canvasSize[0] 
    -- return {canvasSize[0] / 2, goY, 0}
    return {0,goY,0}
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Show(cfg, _elseData, callBack)
    currCfg = cfg
    PlayInfoMove(cfg ~= nil, function()
        Refresh(cfg, _elseData, callBack)
        ShowAnim()
    end)
end

function Refresh(cfg, _elseData, callBack)
    currCfg = cfg
    infoUtil:Set(cfg)
    infoUtil:Hidden()
    local type = _elseData or DungeonInfoType.Normal
    local names,path = DungeonInfoNameUtil.GetNames(type)
    path = path or "DungeonItemInfo"
    SetItems(names,path,callBack)
end

function SetItems(typeNames,path,callBack)
    if typeNames and #typeNames > 0 then
        for i, typeName in ipairs(typeNames) do
            if typeName ~= "" then
                if typeName == "Double" or typeName == "Double2" then
                    if IsShowDouble() then
                        infoUtil:Show(typeName, doubleParent, path)
                    end
                elseif i == #typeNames then
                    infoUtil:Show(typeName, layout, path, function(panel)
                        OnButtonClick(panel)
                        if callBack then
                            callBack()
                        end
                    end)
                else
                    infoUtil:Show(typeName, layout, path)
                end
            end
        end
    end
end
------------------------------------------------多倍
function IsShowDouble()
    if not nolSize then
        nolSize = CSAPI.GetRTSize(layout)
    end
    local x,y = nolSize[0],nolSize[1]
    local isShowDouble = false
    if not currCfg or (currCfg.diff and currCfg.diff == 3) then -- 危险等级不显示双倍
        isShowDouble = false
    else
        local sectionData = DungeonMgr:GetSectionData(currCfg.group)
        if sectionData and DungeonUtil.HasMultiDesc(sectionData:GetID())then
            y = y - 80
            isShowDouble = true
        end
    end
    CSAPI.SetRTSize(layout,x,y)
    return isShowDouble
end

function CheckDouble(panel, cb)
    if panel == nil then
        cb()
        return
    end
    local isDouble = panel.IsDouble()
    local multiNum = panel.GetMultiNum()
    local isLimitDouble = panel.IsLimitDouble()
    local isFirstDouble = DungeonMgr:GetFisrtOpenDouble()
    if (not isDouble and multiNum > 0 and not isFirstDouble and not isLimitDouble) then
        DungeonMgr:SetFisrtOpenDouble(true)
        local dialogData = {}
        local name = currCfg.name
        dialogData.content = string.format(LanguageMgr:GetByID(15072), name, multiNum)
        dialogData.okText = LanguageMgr:GetByID(1031)
        dialogData.cancelText = LanguageMgr:GetByID(1003)
        dialogData.okCallBack = function()
            panel.ShowDouble(true)
            cb()
        end
        dialogData.cancelCallBack = function()
            panel.ShowDouble(false)
            cb()
        end
        CSAPI.OpenView("Dialog", dialogData)
    else
        cb()
    end
end

------------------------------------------------接口
function IsShow()
    return isInfoShow
end

function IsSweepOpen()
    local panel = infoUtil:GetPanel("Button")
    return panel and panel:IsSweepOpen()
end

function ClearLastItem()
    lastCfg = nil
end

function SetLayoutPos(pos)
    CSAPI.SetAnchor(layout,pos[1],pos[2])
end

function CallFunc(panelName,panelFuncName,...)
    if panelName == nil or panelName == "" then
        return nil
    end
    local panel = infoUtil:GetPanel(panelName)
    if panel == nil then
        -- LogError("没找到对应名称的组件!!" .. panelName)
        return nil
    end

    if panel[panelFuncName] == nil then
        -- LogError("没找到对应方法名的方法!!" .. panelFuncName)
        return nil
    end

    return panel[panelFuncName](...)
end

function SetPanelPos(panelName,x,y)
    if panelName == nil or panelName == "" then
        return nil
    end
    local panel = infoUtil:GetPanel(panelName)
    if panel == nil then
        -- LogError("没找到对应名称的组件!!" .. panelName)
        return nil
    end
    CSAPI.SetAnchor(panel.gameObject,x,y)
end

function SetFunc(panelName,oldFuncName,newFunc)
    if panelName == nil or panelName == "" then
        return nil
    end
    local panel = infoUtil:GetPanel(panelName)
    if panel == nil then
        return nil
    end

    if panel[oldFuncName] == nil then
        return nil
    end

    panel[oldFuncName] = newFunc
end

function SetGOActive(panelName,goName,b)
    if panelName == nil or panelName == "" then
        return nil
    end
    local panel = infoUtil:GetPanel(panelName)
    if panel == nil or panel[goName] == nil then
        return nil
    end
    CSAPI.SetGOActive(panel[goName].gameObject,b)
end

function GetPanelObj(panelName,goName)
    if panelName == nil or panelName == "" then
        return nil
    end
    local panel = infoUtil:GetPanel(panelName)
    if panel == nil or panel[goName] == nil then
        return nil
    end
    return panel[goName]
end
------------------------------------------------按钮回调

function SetClickCB(_cb1, _cb2,_cb3)
    enterCB = _cb1
    sweepCB = _cb2
    storyCB = _cb3
    if enterCB then
        local _enterCB = enterCB
        enterCB = function()
            local doublePanel = infoUtil:GetPanel("Double")
            CheckDouble(doublePanel, _enterCB)
        end
    end
end

function OnButtonClick(panel)
    if enterCB then
        panel.OnClickEnter = enterCB
    end
    if sweepCB then
        panel.OnClickSweep = sweepCB
    end
    if storyCB and panel.SetStoryCB then
        panel.SetStoryCB(storyCB)
    end
end

function SetClickMaskCB(_cb)
    maskCB = _cb
    CSAPI.SetGOActive(mask, true)
end

function OnClickMask()
    if maskCB then
        maskCB()
    end
end
------------------------------------------------动效
function PlayAnim(time, callback)
    CSAPI.SetGOActive(clickMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(clickMask, false)
        if callback then
            callback()
        end
    end, this, time)
end

-- 右边信息栏移动
function PlayInfoMove(isShow, callBack)
    if IsNil(gameObject) then
        return
    end
    local animTime = 200
    if isShow then
        CSAPI.SetGOActive(gameObject, true);
        if isInfoShow and lastCfg ~= currCfg then
            lastCfg = currCfg
            infoFade:Play(1, 0, 100, 0, function()
                CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
                infoCG.alpha = 1
                PlayMoveAction(childNode, GetEnterPos())
                if callBack then
                    callBack()
                end
            end)
            animTime = 300
        else
            lastCfg = currCfg
            infoFade:Play(0, 1)
            PlayMoveAction(childNode, GetEnterPos(), function()
                isInfoShow = true
            end)
            if callBack then
                callBack()
            end
        end
    elseif isInfoShow then
        PlayMoveAction(childNode, {outPos[1], outPos[2], outPos[3]}, function()
            CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
            isInfoShow = false;
            CSAPI.SetGOActive(gameObject, false);
        end)
        lastCfg = nil
    end
    PlayAnim(animTime)
end

-- 移动动画
function PlayMoveAction(go, pos, callBack)
    infoMove.target = go
    local x, y, z = CSAPI.GetLocalPos(go)
    infoMove.startPos = UnityEngine.Vector3(x, y, z)
    infoMove.targetPos = UnityEngine.Vector3(pos[1], pos[2], pos[3])
    infoMove:Play(function()
        if callBack then
            callBack()
        end
    end)
end

--------------------------------------------活动用
function SetIsActive(b)
    isActive = b
end

function ShowAnim()
    if isActive then
        CSAPI.SetGOActive(enterAnim, false)
        CSAPI.SetGOActive(enterAnim, true)
    end
end

function SetPos(isShow)
    local pos = isShow and GetEnterPos() or outPos
    CSAPI.SetLocalPos(childNode, pos[1], pos[2], pos[3])
end

function SetItemPos(typeName,x,y)
    local panel = infoUtil:GetPanel(typeName)
    if panel then
        panel.SetPos(x,y)
    end
end

function GetCurrDanger()
    local panel = infoUtil:GetPanel("Danger")
    return panel and panel.GetCurrDanger() or 1
end

------------------------------------------------剧情
function IsStoryFirst()
    local plotButton = infoUtil:GetPanel("PlotButton")
    if plotButton then
        return plotButton.isStoryFirst
    end
end
------------------------------------------------阵容推荐
function AddTeamReplace(isShow,callBack,iconRes,textCode,parent,x,y)
    if currCfg and currCfg.isHideReplace then
        if teamReplaceButton then
            CSAPI.SetGOActive(teamReplaceButton.gameObject,false)
        end
        return
    end
    if not isShow then
        if teamReplaceButton ~= nil then
            CSAPI.SetGOActive(teamReplaceButton.gameObject,false)
        end
        return
    end
    parent = parent or teamReplaceParent
    x = x or 0
    y = y or 0
    local isNative = iconRes ~= nil
    iconRes = iconRes or "Common/btn_18_01"
    textCode = textCode or "000000"
    if teamReplaceButton == nil then
        local go = ResUtil:CreateUIGO("Common/TeamReplaceButton",parent.transform,x,y)
        teamReplaceButton= ComUtil.GetLuaTable(go)
        teamReplaceButton.SetClickCB(function()
                UIUtil:OpenTeamReplaceView(currCfg and currCfg.id,callBack)
            end)
        teamReplaceButton.Refresh(iconRes,isNative)
        teamReplaceButton.SetTextColor(textCode)
    else
        CSAPI.SetGOActive(teamReplaceButton.gameObject,true)
        teamReplaceButton.Refresh(iconRes,isNative)
        teamReplaceButton.SetTextColor(textCode)
    end
end

------------------------------------------------图片替换
--对单个组件进行替换
function ReplacePanelImg(panelName,goName,resName,imgName,imgColor)
    imgColor = imgColor or {255,255,255,255}
    if (resName == nil or resName == "") or (imgName == nil or imgName == "")  then
        return
    end
    local obj = GetPanelObj(panelName,goName)
    if obj == nil then
        return
    end
    ResUtil[resName]:Load(obj.gameObject,imgName,false)
    CSAPI.SetImgColor(obj.gameObject,imgColor[1],imgColor[2],imgColor[3],imgColor[4])
end

--对所有组件进行替换
function ReplacePanelImgs(goName,resName,imgName,imgColor)
    local panels = infoUtil:GetPanels()
    if panels then
        for k, v in pairs(panels) do
            ReplacePanelImg(k,goName,resName,imgName,imgColor)
        end
    end
end
