local sectionData = nil
local datas = {}
local datas2 = {}
local layout = nil
local layout2 = nil
local currItem = nil
local currIndex = 0
local selIndex = 0
local focusItem = nil
local infoItem = nil
local canvasSize = nil
local topOffset = 432
local downOffset = 306
local resetTime = 0
local isShowRecover = false
local isCanRecover = false
local isShowRecoverTips = false
local cfgGood = nil
-- Abattoir 19
-- 塔图片
local imgGOs = {}

function Awake()
    layout = ComUtil.GetCom(vsv, "UISV");
    layout:Init("UIs/Tower2/TowerListItem", LayoutCallBack, true);

    layout2 = ComUtil.GetCom(vsv2, "UISV");
    layout2:Init("UIs/RoleLittleCard/RoleLittleCard", LayoutCallBack2, true);

    UIUtil:AddTop2("EternityWarzone", topParent, OnClickReturn);
    CSAPI.SetGOActive(animMask, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.NewTower_CardInfo_Update_Finish, OnCardInfoUpdate)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Bag_Update,OnItemUpdate)

    if not IsNil(centerImg.gameObject) then
        table.insert(imgGOs, centerImg.gameObject)
    end

    CSAPI.SetGOActive(recoverObj, false)
end

function OnCardInfoUpdate()
    SetRecover()
    if isShowRecover then
        ShowRecover(isShowRecover)
    end
    if isShowRecoverTips then
        isShowRecoverTips = false
        LanguageMgr:ShowTips(75007)
    end
end

function OnItemUpdate()
    ShowRecover(isShowRecover)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas[index]
        lua.SetIndex(#datas - (index - 1))
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, _data:IsHard() and 2 or 1)
        lua.SetSelect(selIndex ~= 0 and currIndex == index)
    end
end

function OnItemClickCB(item)
    if selIndex == item.index then
        return
    end
    if item.GetLock() or item.IsPass() then
        LanguageMgr:ShowTips(item.GetLock() and 75001 or 75005)
        return
    end
    if selIndex > 0 then
        local lua = layout:GetItemLua(#datas - (selIndex - 1))
        if lua then
            lua.SetSelect(false)
        end
    end
    currItem = item
    currItem.SetSelect(true)
    selIndex = item.index
    currIndex = #datas - item.index + 1
    SetInfoPanel()
    SetRecover()
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = datas2[index]
        lua.SetClickCB(OnItemClickCB2)
        lua.Refresh(_data,{hideFormat = true})
    end
end

function OnItemClickCB2(item)

end

function Update()
    if TimeUtil:GetTime() > resetTime or not isShowRecover then
        return
    end

    if (resetTime > 0) then
        local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
        LanguageMgr:SetText(txtDesc, 312010, timeTab.day < 10 and "0" .. timeTab.day or timeTab.day,
            timeTab.hour < 10 and "0" .. timeTab.hour or timeTab.hour,
            timeTab.minute < 10 and "0" .. timeTab.minute or timeTab.minute)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
    TowerMgr:ClearSectionId()
end

function OnOpen()
    PlayAnim(400)
    sectionData = DungeonMgr:GetSectionData(data.id)
    if sectionData then
        InitDatas()
        CheckNewDungeon()
        InitPanel()
    end
end

function InitDatas()
    datas = TowerMgr:GetArr(sectionData:GetID())
end

-- 获取最新开启的关卡
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
    SetTower()
    SetRecover()
    SetRed()
    CheckRecoverTips()
end

function RefreshPanel()
    SetTower()
    SetRecover()
    SetInfoPanel()
end

function SetTower()
    CSAPI.SetScriptEnable(sr,"ScrollRect",true)
    layout:IEShowList(#datas, function()
        if not datas[1]:IsPass() then
            local lua = layout:GetItemLua(currIndex)
            if lua then
                lua.OnClick()
            end
        else
            SetInfoPanel()
        end
        InitImgState()
        FuncUtil:Call(function ()
            CSAPI.SetScriptEnable(sr,"ScrollRect",false)
        end,this,200)
    end, currIndex)
end

function InitImgState()
    local cloneGO = imgGOs[1]
    if not IsNil(cloneGO) then
        for i = 1, math.floor(#datas / 2) + 2 do
            if i > 1 then
                CSAPI.CloneGO(cloneGO, imgLayout.transform)
            end
        end
    end
    CSAPI.SetParent(imgLayout, content.gameObject)
    imgLayout.transform:SetAsFirstSibling()
    CSAPI.SetAnchor(imgLayout, 0, 0)

    local currOpenIndex = #datas - (currIndex - 1)
    local height = downOffset + (114 + 112) * (currOpenIndex - 1) + 114 / 2
    CSAPI.SetRTSize(openImg, 21, height)
    imgObj.transform:SetAsLastSibling()
    bottomImg.transform:SetAsLastSibling()
end

function SetInfoPanel()
    CSAPI.SetGOActive(infoObj, currItem ~= nil)
    ShowInfoAnim()
    if currItem then
        SetText()
        SetFocus()
        SetInfo()
        SetBtnState()
    end
end

function SetText()
    local index = #datas - (currIndex - 1)
    local str = StringUtil:NumberToString(index)
    str = StringUtil:SetByColor(str, "FFC146")
    LanguageMgr:SetText(txtIndex, 49006, str)
end

function SetRecover()
    SetRecoverBtn()
    resetTime = TimeUtil:NextWeekIndexTimeStamp(1, g_ActivityDiffDayTime)
end

function SetRecoverBtn()
    CSAPI.SetAnchor(btnRecover, currItem ~= nil and -524 or -169, -439)
end

function SetFocus()
    if focusItem then
        focusItem.Refresh(datas[currIndex])
    else
        ResUtil:CreateUIGOAsync("Tower/TowerFocus", focusParent, function(go)
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
        ResUtil:CreateUIGOAsync("Tower2/TowerInfo2View", infoParent, function(go)
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
        CSAPI.SetGOAlpha(btnDirll, alpha)
        CSAPI.SetGOAlpha(btnEnter, alpha)
        local cost = DungeonUtil.GetCost(cfg)
        if cost ~= nil then
            ResUtil.IconGoods:Load(costImg, cost[1] .. "_3")
            CSAPI.SetText(cost, "-" .. cost[2])
            local cfg = Cfgs.ItemInfo:GetByID(cost[1])
            if cfg then
                CSAPI.SetText(txt_cost, cfg.name)
            end
        else
            ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .. "_3")
            local costNum = DungeonUtil.GetHot(cfg)
            costNum = StringUtil:SetByColor(costNum .. "",
                math.abs(costNum) <= PlayerClient:Hot() and "191919" or "CD333E")
            CSAPI.SetText(txtCost, costNum .. "")
            LanguageMgr:SetText(txt_cost, 15004)
        end
    end
end

function SetRed()
    local isRed = MissionMgr:CheckRed2(sectionData:GetTaskType(), sectionData:GetID())
    UIUtil:SetRedPoint(redParent1, isRed)
end

function CheckRecoverTips()
    local isRed = MissionMgr:CheckRed2(sectionData:GetTaskType(), sectionData:GetID())
    if not isRed and DungeonActivityMgr:CheckRed(sectionData:GetID()) then -- 恢复红点
        local info = FileUtil.LoadByPath("section_activity_recover") or {}
        if info[sectionData:GetID()] ~= nil then
           LanguageMgr:ShowTips(75004) 
        end
        info[sectionData:GetID()] = {
            time = TimeUtil:GetTime()
        }
        FileUtil.SaveToFile("section_activity_recover", info)
        DungeonMgr:CheckRedPointData()
    end
end

function OnClickEnter()
    local isLock, lockStr = currItem.GetLock()
    if isLock then
        Tips.ShowTips(lockStr)
        return
    end
    if currItem.IsPass() then
        return
    end
    if currItem.GetCfg() then
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = currItem.GetCfg().id,
            teamNum = currItem.GetCfg().teamNum or 1,
            disChoosie = true,
            isNotAssist = true
        }, TeamConfirmOpenType.Tower)
    end
end

function OnClickDirll()
    local isLock, lockStr = currItem.GetLock()
    if isLock then
        Tips.ShowTips(lockStr)
        return
    end
    if currItem.IsPass() then
        return
    end
    if currItem.GetCfg() then
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = currItem.GetCfg().id,
            teamNum = currItem.GetCfg().teamNum or 1,
            isDirll = true,
            overCB = OnFightOverCB,
            disChoosie = true,
            isNotAssist = true
        }, TeamConfirmOpenType.Tower)
    end
end

function OnFightOverCB(stage, winer, nDamage)
    if currItem and currItem.GetCfg() and currItem.GetCfg().id then
        DungeonMgr:SetCurrId1(currItem.GetCfg().id)
    end
    FightOverTool.OnDirllOver(stage, winer)
end

function OnClickCur()
    if #datas > 0 then
        for i, v in ipairs(datas) do
            if v:IsOpen() then
                if currItem and currItem.index ~= #datas - (i - 1) then
                    currItem.SetSelect(false)
                end
                MoveTo(i, function()
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
    ShowRecover(true)
end

function ShowRecover(isShow)
    isShowRecover = isShow
    CSAPI.SetGOActive(recoverObj, isShowRecover)
    if isShowRecover then
        datas2 = TowerMgr:GetRecoverArr(data.id)
        layout2:IEShowList(#datas2)
        local reward = g_EternityWarzoneGoods and g_EternityWarzoneGoods[1]
        if reward then
            cfgGood = Cfgs.ItemInfo:GetByID(reward[1])
            if cfgGood and cfgGood.icon then
                ResUtil.IconGoods:Load(icon, cfgGood.icon .. "_1")
            end
            CSAPI.SetText(txtGood, BagMgr:GetCount(cfgGood.id) .. "/" .. reward[2])
            isCanRecover = BagMgr:GetCount(cfgGood.id) >= reward[2]
            CSAPI.SetGOAlpha(btnUse, isCanRecover and 1 or 0.5)
        end
        CSAPI.SetGOActive(nolImg, #datas2 > 0)
        CSAPI.SetGOActive(txtDesc, #datas2 > 0)
        CSAPI.SetGOActive(emptyObj, #datas2 <= 0)
        if isCanRecover then
            isCanRecover = #datas2 > 0
        end
    end
end

function OnClickSure()
    if not isCanRecover then
        if #datas2 <= 0 then
            LanguageMgr:ShowTips(75006)
        else
            LanguageMgr:ShowTips(75002)
        end
        return
    end
    local dialogData = {}
    dialogData.content = LanguageMgr:GetByID(312015)
    dialogData.okCallBack = function()
        isShowRecoverTips = true
        PlayerProto:ResetEternalBattleCardInfo(data.id)
    end
    CSAPI.OpenView("Dialog", dialogData)
end

function OnClickBack()
    if currItem then
        currItem.SetSelect(false)
        currItem = nil
        selIndex = 0
    end
    SetInfoPanel()
    SetRecoverBtn()
end

function OnClickReturn()
    if isShowRecover then
        ShowRecover(false)
        return
    end
    view:Close()
end

function OnClickReward()
    if sectionData then
        UIUtil:ShowMissionReward(sectionData:GetTaskType(), sectionData:GetID())
    end
end

function OnClickRank()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickItem()
    if g_EternityWarzoneShop then
        local comm = ShopMgr:GetFixedCommodity(g_EternityWarzoneShop)
        local page = ShopMgr:GetPageByID(comm:GetShopID())
        if comm:HasOtherPrice(ShopPriceKey.jCosts1) then
            CSAPI.OpenView("ShopMultPayView", {
                commodity = comm,
                pageData = page,
                callBack = OnCardInfoUpdate
            });
        else
            CSAPI.OpenView("ShopPayView", {
                commodity = comm,
                pageData = page,
                callBack = OnCardInfoUpdate
            });
        end
    end
end
------------------------------------------------UISV------------------------------------------------
function MoveTo(index, callBack)
    local _index = index - 3
    local y = index <= 3 and 0 or topOffset + ((114 + 112) * _index) - 10
    -- local y = topOffset + ((139 + 10) * _index) - 10
    local vsvSize = CSAPI.GetRealRTSize(vsv.gameObject)
    local itemSize = CSAPI.GetRTSize(content.gameObject)
    y = y > itemSize[1] - vsvSize[1] and itemSize[1] - vsvSize[1] or y
    CSAPI.MoveTo(content, "UI_Local_Move", 0, y, 0, nil, 0.2)
    FuncUtil:Call(function()
        if callBack then
            callBack()
        end
    end, this, 300)
    PlayAnim(300)
    -- CSAPI.SetAnchor(content,0, y)
end

------------------------------------------------UISV------------------------------------------------

function PlayAnim(time, callback)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
        if callback then
            callback()
        end
    end, this, time)
end

function ShowInfoAnim()
    local x = currItem ~= nil and -302 or 0
    CSAPI.MoveTo(vsv, "UI_Local_Move", x, 0, 0, nil, 0.2)
    CSAPI.MoveTo(btnObj, "UI_Local_Move", x, 0, 0, nil, 0.2)
end
