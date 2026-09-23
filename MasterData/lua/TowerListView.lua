local sectionData = nil
local datas = {}
local currLevel = 1
local layout = nil
local currItem = nil
local currIndex = 0
local selIndex= 0
local focusItem = nil
local infoItem = nil
local canvasSize = nil
local topOffset = 30
local downOffset = 30
local resetTime = 0


function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Tower/TowerListItem",LayoutCallBack,true);

    UIUtil:AddTop2("TowerListView" ,topParent, OnClickReturn);
    CSAPI.SetGOActive(animMask,false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.NewTower_ResetCnt_Update,OnResetCntUpdate)
end

function OnResetCntUpdate()
    SetRecover()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas[index]
        lua.SetIndex(#datas-(index - 1))
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
        lua.SetSelect(currIndex == index)
    end
end

function OnItemClickCB(item)
    if selIndex == item.index then
        return
    end
    if currItem then
        currItem.SetSelect(false)
    end
    currItem = item
    currItem.SetSelect(true)
    selIndex = item.index
    currIndex = #datas - item.index + 1
    SetRight()
    if isFirst then
        MoveTo(currIndex)
    end
    isFirst = true
end

function Update()
    if TimeUtil:GetTime() > resetTime then
        return
    end

    if (resetTime > 0) then
        local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
        local hour = timeTab.hour > 0 and timeTab.hour or "0"
        local min = timeTab.minute > 0 and timeTab.minute  or "0"
        LanguageMgr:SetText(txtExplore,49016,hour,min)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
    TowerMgr:ClearSectionId()
end

function OnOpen()
    PlayAnim(400)
    sectionData = DungeonMgr:GetSectionData(data.id)
    -- TowerMgr:SetSectionId(data.id)
    currLevel = openSetting or currLevel
    if sectionData then
        InitDatas()
        CheckNewDungeon()
        InitPanel()
    end
end

function InitDatas()
    datas = TowerMgr:GetArr(sectionData:GetID())
end

--获取最新开启的关卡
function CheckNewDungeon()
    if #datas > 0 then
        for i, v in ipairs(datas) do
            if v:IsOpen() then
                currIndex = i
                break
            end
        end
    end
    if currIndex < 1 then
        currIndex = #datas
    end
end

function InitPanel()
    canvasSize = CSAPI.GetMainCanvasSize()
    CSAPI.SetGOActive(nolImg1,currLevel == 1)
    CSAPI.SetGOActive(hardImg1,currLevel == 2)
    SetLeft()
end

function RefreshPanel()
    SetLeft()
    SetRight()
end

function SetLeft()
    layout:IEShowList(#datas,function ()
        if currItem == nil then
            -- MoveTo(currIndex)
            local lua = layout:GetItemLua(currIndex)
            if lua then
                lua.OnClick()
            end
            InitOpenImg()
        end
    end,currIndex)
end

function InitOpenImg()
    local currOpenIndex = #datas - (currIndex - 1)
    CSAPI.SetParent(openImg,content.gameObject)
    openImg.transform:SetAsFirstSibling()
    local height = downOffset + (139 + 10) * (currOpenIndex - 1) + 139 / 2
    CSAPI.SetRTSize(openImg,8,height + 5000)
end

function SetRight()
    SetText()
    SetRecover()
    SetFocus()
    SetInfo()
    SetBtnState()
end

function SetText()
    local index = #datas - (currIndex - 1)
    local str = StringUtil:NumberToString(index)
    str = StringUtil:SetByColor(str,"FFC146")
    LanguageMgr:SetText(txtIndex,49006,str)
    -- str = index < 10 and "0" .. index or index..""
    -- CSAPI.SetText(txtIndex2, str)
end

function SetRecover()
    local isCanRecover = TowerMgr:GetResetCnt(data.id) > 0
    CSAPI.SetGOActive(recoverImg1,isCanRecover)
    CSAPI.SetGOActive(recoverImg2,not isCanRecover)
    local str = LanguageMgr:GetByID(49012)
    if not isCanRecover then
        local dayDiffs = g_ActivityDiffDayTime * 3600
        resetTime = TimeUtil:GetResetTime(dayDiffs)
    end
    CSAPI.SetText(txtExplore,str)
    SetRed(isCanRecover)
end

function SetFocus()
    if focusItem then
        focusItem.Refresh(datas[currIndex])
    else
        ResUtil:CreateUIGOAsync("Tower/TowerFocus",focusParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(datas[currIndex])
            focusItem = lua
        end)
    end
end

function SetInfo()
    if infoItem then
        infoItem.Refresh(datas[currIndex])
    else
        ResUtil:CreateUIGOAsync("Tower/TowerInfoView",infoParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(datas[currIndex])
            infoItem = lua
        end)
    end
end

function SetBtnState()
    local cfg = datas[currIndex]:GetCfg()
    if cfg then
        local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
        local alpha = (not DungeonMgr:IsDungeonOpen(cfg.id) or (dungeonData and dungeonData:IsPass())) and 0.5 or 1
        CSAPI.SetGOAlpha(btnDirll,alpha)
        CSAPI.SetGOAlpha(btnEnter,alpha)
        local cost = DungeonUtil.GetCost(cfg)
        if cost ~= nil then
            ResUtil.IconGoods:Load(costImg, cost[1] .. "_3")
            CSAPI.SetText(cost,"-" .. cost[2])   
            local cfg = Cfgs.ItemInfo:GetByID(cost[1])
            if cfg then
                CSAPI.SetText(txt_cost, cfg.name)
            end 
        else
            ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .. "_3")
            local costNum = DungeonUtil.GetHot(cfg)
            costNum = StringUtil:SetByColor(costNum .. "", math.abs(costNum) <= PlayerClient:Hot() and "191919" or "CD333E")
            CSAPI.SetText(txtCost, costNum .. "")
            LanguageMgr:SetText(txt_cost, 15004)
        end
    end
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent,b)
end

function OnClickEnter()
    OnBattleEnter()
end

function OnClickDirll()
    OnBattleEnter(true)
end

function OnBattleEnter(isDirll)
    local curData = datas and datas[#datas-(selIndex - 1)]
    if curData then
       local isOpen,lockStr = curData:IsOpen()
        if not isOpen then
            Tips.ShowTips(lockStr)
            return
        end
        if curData:IsPass() then
            return
        end
        local cfg = curData:GetCfg()
        if cfg then
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum or 1,
                disChoosie=true,
                isDirll = isDirll,
                overCB = isDirll and OnFightOverCB or nil,
            }, TeamConfirmOpenType.Tower)
        end
    end
end

function OnFightOverCB(stage, winer, nDamage)
    if currItem and currItem.GetCfg() and currItem.GetCfg().id then
        DungeonMgr:SetCurrId1(currItem.GetCfg().id)
    end
    FightOverTool.OnDirllOver(stage, winer)
end

function OnClickCur()
    if #datas>0 then
        for i, v in ipairs(datas) do
            if v:IsOpen() then
                if currItem and currItem.index ~= #datas - (i - 1) then
                    currItem.SetSelect(false)
                end
                MoveTo(i,function ()
                    local lua = layout:GetItemLua(i)
                    if lua then
                        lua.OnClick()
                    end
                end)
                break
            end
        end
    end
end

function OnClickRecover()
    if TowerMgr:GetResetCnt(data.id) > 0 then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetByID(49022)
        dialogData.okCallBack = function()
            PlayerProto:ResetNewTowerCardInfo(data.id,function ()
                LanguageMgr:ShowTips(35001)
            end)
        end
        CSAPI.OpenView("Dialog", dialogData)
    else
        if (resetTime > 0) then
            local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
            local hour = timeTab.hour > 0 and timeTab.hour or "0"
            local min = timeTab.minute > 0 and timeTab.minute  or "0"
            Tips.ShowTips(LanguageMgr:GetByID(49016,hour,min))
        end
    end
end

function OnClickReturn()
    view:Close()
end

------------------------------------------------UISV------------------------------------------------
function MoveTo(index,callBack)
    local _index = index - 3
    local y = index <=3 and 0 or topOffset + ((139 + 10) * _index) - 10
    -- local y = topOffset + ((139 + 10) * _index) - 10
    
    local vsvSize = CSAPI.GetRealRTSize(vsv.gameObject)
    local itemSize = CSAPI.GetRTSize(content.gameObject)
    y = y > itemSize[1] - vsvSize[1] and itemSize[1] - vsvSize[1] or y
    CSAPI.MoveTo(content, "UI_Local_Move", 0, y, 0, nil, 0.2)
    FuncUtil:Call(function ()
        if callBack then
            callBack()
        end
    end,this,300)
    PlayAnim(300)
    -- CSAPI.SetAnchor(content,0, y)
end

------------------------------------------------UISV------------------------------------------------

function PlayAnim(time,callback)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
        if callback then
            callback()
        end
    end,this,time)
end