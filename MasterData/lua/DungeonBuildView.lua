local layout = nil
local tlua = nil
local sectionData = nil
local datas = {}
local openInfo = nil
local curDatas = {}
local curDatas2 = {}
local currLevel = 1
local isDungeonOver = false
local overTipsId = 0
local isDungeonUnLock = false
local offsetScale = 0
-- hard
local isHardOpen = false
local hardTips = ""
local isHardUnLockAnim = false
--extra
local isExtraOpen = false
local extraTips = ""
-- item
local selIndex = 0
local curIndex = 0
local currItem = nil
local lastShowInfo = nil
-- item2
local items = nil
local curIndex2 = 0
local selIndex2 = 0
local currItem2 = nil
-- danger
local currDanger = 1
-- info
local itemInfo = nil
local infoAnim = nil
-- posInfo
local lastPos = {}
-- tab
local levelTab = nil
-- left
local isShowList = false
-- build
local currBuildIndex = 0
local currBuildType = 0
local buildTips = ""
local cfgVariants = nil
local previewTab= nil
local currPreviewIndex = 1
local isShowBuild = false --选择建造
local isBuilding = false --建造中
local isPreview = false --预览图
local isAllBuilding = false --全造完
local isFirstBuilding = false --当前关卡第一次建造
local isBuildChange = false --建造改变

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity19/DungeonBuildItem2", LayoutCallBack, true)
    -- tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType, "DTU")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh, function() -- 购买刷新
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        EventMgr.Dispatch(EventType.Universal_Purchase_Refresh_Panel, curCount)
    end)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, CheckNew) -- 双倍刷新
    eventMgr:AddListener(EventType.ShareView_NoticeTheNextFrameScreenshot, OnShareStart) -- 开始截图
    eventMgr:AddListener(EventType.ShareView_NoticeScreenshotCompleted, OnShareFinish) -- 分享结束

    InitAnim()

    levelTab = ComUtil.GetCom(levelTabs, "CTab")
    levelTab:AddSelChangedCallBack(OnTabChanged)

    previewTab = ComUtil.GetCom(previewTabs, "CTab")
    previewTab:AddSelChangedCallBack(OnPreviewTabChange)

    CSAPI.SetGOActive(infoMask, false)
    CSAPI.SetGOActive(itemObj, false)
    CSAPI.SetGOActive(bulidObj, false)
    CSAPI.SetGOActive(buildShowObj, false)
    CSAPI.SetGOActive(lineObj, false)
    CSAPI.SetGOActive(previewObj, false)
    CSAPI.SetGOActive(buildChangeObj,false)
    CSAPI.SetGOActive(hardEffect,false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas2[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, currLevel)
        lua.SetSelect(selIndex2 == 0 or index == selIndex2)
    end
end

function OnItemClickCB(item)
    if selIndex2 == item.index then
        return
    end

    currItem2 = item
    curIndex2 = item.index
    selIndex2 = item.index
    SetItemFade()
    if currItem2.IsBuild() then
        if isActive then
            ShowInfo()
            PlayAnim(300)
        end
        ShowVsvAnim(false,function ()
             CSAPI.SetGOActive(itemObj,false)
        end)
        ShowBuildPanel(true)
        ShowBuildAnim2(true)
        PlayAnim(700)
    else
        ShowInfo(item)
        PlayAnim(300)
    end
end

function OnLoadComplete()
    if isDungeonOver then
        -- isHardUnLockAnim = true
        if isHardUnLockAnim then
            ShowUnLockHardAnim()
        elseif isDungeonUnLock then
            isDungeonUnLock = false
            ShowDungeonUnLockAnim()
        end
        isDungeonOver = false

        if overTipsId > 0 then
            FuncUtil:Call(function()
                LanguageMgr:ShowTips(overTipsId)
                overTipsId = 0
            end, this, 200)
        end
    end
end

function OnTabChanged(level)
    if level == currLevel then
        return
    end
    if level == 2 and not isHardOpen then
        Tips.ShowTips(hardTips)
        levelTab.selIndex = currLevel
        return
    end
    if level == 3 and not isExtraOpen then
        Tips.ShowTips(extraTips)
        levelTab.selIndex = currLevel
        return
    end
    ShowChangeLevel(level, currLevel)
    if level == 2 and currLevel == 3 then
        currLevel = level
        return
    end
    if level == 3 then
        if currLevel == 1 then
            currLevel = level
            ShowChangeDungeon(function()
                ShowBGItems(SelectLastItem)
            end)
        else
            currLevel = level
            SelectLastItem()
        end
    else
        currLevel = level
        ShowChangeDungeon(ShowBGItems)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("DungeonBuild", topParent, OnClickBack, OnClickHome);
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        InitDatas()
        InitAnimState()
        InitBGState()
        InitPreviewPanel()
        if sectionData:GetStoryID() and (not PlotMgr:IsPlayed(sectionData:GetStoryID())) then -- 第一次观看入场剧情
            PlotMgr:TryPlay(sectionData:GetStoryID(), function()
                PlotMgr:Save()
                InitPanel()
            end, this, true);
        else
            InitPanel()
        end
    end
end

function InitDatas()
    datas = {}
    local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
    if _datas and #_datas > 0 then
        local ids = nil
        for _, v in ipairs(_datas) do
            table.insert(datas, v)
            if data.itemId then
                for i = 1, 2 do
                    ids = v:GetDungeonCfgIDs(i)
                    if ids and #ids > 0 then
                        for k, m in ipairs(ids) do
                            if m == data.itemId then
                                currLevel = i
                            end
                        end
                    end
                end
            end
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end

    isHardOpen, hardTips = datas[1]:IsOpen(2)
    isExtraOpen, extraTips = datas[#datas]:IsOpen(2)

    if not data.itemId then
        currLevel = isHardOpen and 2 or 1
    end
    curDatas = datas
end

-- 正常进入 --跳转进入 --完成关卡后进入
function InitAnimState()
    curIndex = GetCurIndex(data.itemId)
    if data.itemId then
        if openSetting and openSetting.isDungeonOver then -- 战斗结束
            isDungeonOver = true
            if DungeonMgr:GetCurrDungeonIsFirst() then -- 首通
                DungeonMgr:SetCurrDungeonNoFirst()
                isDungeonUnLock = true
                local cfg = Cfgs.MainLine:GetByID(data.itemId)
                if cfg and cfg.passTips then
                    overTipsId = cfg.passTips
                end
            end
        end
    end
end

function GetCurIndex(_itemId)
    local index = curIndex
    if curDatas and #curDatas > 0 then
        index = #curDatas
        for i, v in ipairs(curDatas) do
            if _itemId then -- 跳转
                local ids = v:GetDungeonCfgIDs(currLevel)
                if ids and #ids > 0 then
                    for k, id in ipairs(ids) do
                        if id == _itemId then
                            index = i
                            curIndex2 = k
                            break
                        end
                    end
                end
            elseif v:IsOpen() and not v:IsPass() then -- 正常
                index = i
                break
            end
        end
    end
    return index
end

function InitBGState()
    local scale = CSAPI.GetScale(bg)
    offsetScale = CSAPI.GetSizeOffset() - 1
    if offsetScale > 0 then
        CSAPI.SetScale(bg, scale + offsetScale, scale + offsetScale, scale + offsetScale)
    end
end

function InitPanel()
    CheckNew()
    InitLevel()
    ShowEnterAnim()
    ShowBGItems(SetBGItemsPos)
    CSAPI.SetGOActive(btnShare, CSAPI.IsSharePicture())
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonBuild") then
        LanguageMgr:ShowTips(8012)
    end
end

function OnClickBack()
    if isBuilding then
        OnClickCancel()
    elseif isBuildChange then
        OnClickSure2()
    elseif isActive then
        curIndex2 = 0
        selIndex2 = 0
        SetItemFade()
        ShowInfo()
    elseif isShowBuild then
        ShowBuildAnim2(false,function ()
            CSAPI.SetGOActive(itemObj,true)
            ShowVsvAnim(true)
            ShowBuildPanel(false)
            curIndex2 = 0
            selIndex2 = 0
            SetItemFade()
        end)
        PlayAnim(1000)
    elseif isShowList then
        if currItem then
            currItem.ShowSelAnim(false)
            currItem = nil
        end
        ShowBGItem()
        curIndex = 0
        selIndex = 0
        ShowListPanel()
        local x,y= CSAPI.GetLocalPos(bg)
        MoveToTarget(x,y,1,0.2)
        if currLevel == 3 then
            levelTab.selIndex = 2
            OnTabChanged(2)
        end
    elseif isPreview then
        ShowPreviewPanel(false)
    else
        view:Close()
    end
end

function OnClickHome()
    UIUtil:ToHome()
end

function OnClickRank()
UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end
-----------------------------------------------level-----------------------------------------------
function InitLevel()
    CSAPI.SetGOActive(hardLock, not isHardOpen)
    CSAPI.SetGOActive(extraLock, not isExtraOpen)
    levelTab.selIndex = currLevel
    FuncUtil:Call(function()
        ShowChangeLevel(currLevel)
    end,this,450)

    ShowEnterLevelAnim()
end

-----------------------------------------------bg-----------------------------------------------
function ShowBGItems(callBack)
    items = items or {}
    ItemUtil.AddItems("DungeonActivity19/DungeonBuildItem", items, curDatas, bg, OnBGItemClickCB, 1, {level = currLevel, isAllBuild = IsAllBuildng()}, callBack)
end

function OnBGItemClickCB(item)
    if selIndex == item.index then
        return
    end
    if currLevel == 2 and item.index == #curDatas then
        levelTab.selIndex = 3
        OnTabChanged(3)
        return
    end
    if currItem then
        currItem.SetSelect(false)
    end
    currItem = item
    currItem.SetSelect(true)
    selIndex = item.index
    curIndex = item.index
    UIUtil:SetObjFade(item.gameObject,1,0,nil,200)
    local info = item.GetInfo()
    MoveToTargetByInfo(info[1],function ()
        ShowBGItem(item)
    end)
    ShowListPanel(true,true)
end

function SetBGItemsPos()
    if #items > 0 then
        for i, v in ipairs(items) do
            CSAPI.SetGOAlpha(v.gameObject,0)
            v.SetPos()
            FuncUtil:Call(function ()
                CSAPI.SetGOAlpha(v.gameObject,1)
                v.ShowEnterAnim()
                if i == curIndex then
                    if data.itemId then
                        v.OnClick()
                    else
                        SetPos(v.GetInfo())
                    end
                end
            end,this,450)
        end
    end
end

-- -444.7977
function ShowBGItem(item)
    if lastShowInfo then
        lastShowInfo.item.transform:SetParent(bg.transform)
        CSAPI.SetParent(lastShowInfo.item.gameObject,bg.gameObject)
        lastShowInfo.item.transform:SetSiblingIndex(lastShowInfo.item.index - 1)
        lastShowInfo = nil
    end

    if item and item.transform then
        local scale = CSAPI.GetScale(item.transform.parent.gameObject)
        local x,y = CSAPI.GetLocalPos(item.gameObject)
        item.transform:SetParent(itemShowParent.transform)
        x,y = CSAPI.GetLocalPos(item.gameObject)
        lastShowInfo = {item = item,pos = {x,y}}
        UIUtil:SetObjFade(item.gameObject,0,1,nil,200)
    end
end

function BackToMap(callBack)
    local animTime = 0
    if currItem2 then
        currItem2 = nil
        curIndex2 = 0
        selIndex2 = 0
        SetItemFade()
    end
    if isActive then
        ShowInfo()
        animTime = 300
    end
    if isShowBuild then
        ShowBuildPanel(false)
    end
    if isShowList then
        if currItem then
            currItem.ShowSelAnim(false)
            currItem = nil
        end
        ShowBGItem()
        curIndex = 0
        selIndex = 0
        ShowListPanel()
        -- MoveToTarget(0,0,1,0.2)
        animTime = 300
        if currLevel == 3 then
            levelTab.selIndex = 2
            OnTabChanged(2)
        end
    end
    PlayAnim(animTime)
    FuncUtil:Call(function ()
        if callBack then
            callBack()
        end
    end,this,animTime)
end

function SelectLastItem()
    if items and items[#items] then
        items[#items].OnClick()
    end
end
-----------------------------------------------Items-----------------------------------------------
function ShowListPanel(b,isAnim)
    isShowList = b
    local animTime = 0
    if b then
        CSAPI.SetGOActive(infoMask, true)
        CSAPI.SetGOActive(itemObj, true)
        SetListDatas()
        if isAnim then
            -- tlua:AnimAgain()
            ShowVsvAnim(true)
            animTime = 700
        end
        SetItems()
        ShowInfoMaskAnim(true)
    else
        ShowInfoMaskAnim(false)
        if isAnim then
            ShowVsvAnim(false, function()
                CSAPI.SetGOActive(infoMask, false)
                CSAPI.SetGOActive(itemObj, false)
            end)
            animTime = 200
        else
            CSAPI.SetGOActive(infoMask, false)
            CSAPI.SetGOActive(itemObj, false)
        end
    end
    PlayAnim(animTime)
end

function SetListDatas()
    if curDatas and curDatas[curIndex] then
        curDatas2 = curDatas[curIndex]:GetDungeonCfgs(currLevel == 1 and 1 or 2)
    end
end

function SetItems()
    layout:IEShowList(#curDatas2, OnFirstLoadSuccsed, curIndex2)
end

function OnFirstLoadSuccsed()
    if isFirst then
        return
    end
    isFirst = true
    if data.itemId and not isDungeonUnLock then
        local lua = layout:GetItemLua(curIndex2)
        if lua then
            lua.OnClick()
        end
    end
end

function SetItemFade()
    if curDatas2 and #curDatas2> 0 then
        for i, v in ipairs(curDatas2) do
            local lua = layout:GetItemLua(i)
            if lua then
                if selIndex2 > 0 then
                    lua.SetFade(selIndex2 == i)
                else
                    lua.SetFade(true)
                end
            end
        end
    end
end
-----------------------------------------------build-----------------------------------------------
function ShowBuildPanel(b)
    isShowBuild = b
    CSAPI.SetGOActive(buildShowObj,b)
    if b then
        local cfgDungeon = currItem2.GetCfg()
        CSAPI.SetText(txtPointName,cfgDungeon.name)
        local dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
        isFirstBuilding = not (dungeonData and dungeonData:IsPass())
        local buildInfo = dungeonData and dungeonData:GetNGrade()
        if cfgDungeon.UnlockBuildingID then
            local cfgBuild = nil
            local cfgGood = nil
            local code = nil
            local cost = nil
            buildTips = ""
            for i, v in ipairs(cfgDungeon.UnlockBuildingID) do
                cfgBuild = Cfgs.Building:GetByID(v)
                if cfgBuild then
                    if cfgBuild.UiIcon then --设置图标
                        ResUtil.DungeonBuild:Load(this["icon" .. i].gameObject,"Show/" .. sectionData:GetID() .."/" .. cfgBuild.UiIcon)
                    end
                    CSAPI.SetText(this["txtBuildName" .. i].gameObject,cfgBuild.name or "")
                    cost = cfgBuild.Costs
                    if buildInfo and dungeonData:IsPass() and (buildInfo[1] > 0 or buildInfo[2] > 0) then --已建造
                        if buildInfo[i] == 0 then --消耗增加
                            cost = cfgBuild.Costs2
                        else --建造了就不需要设置数量
                            cost = nil
                        end
                    end
                    if cost then --可建造
                        cfgGood= Cfgs.ItemInfo:GetByID(cost[1][1])
                        if cfgGood then
                            if BagMgr:GetCount(cfgGood.id) < cost[1][2] then
                                buildTips = LanguageMgr:GetTips(15000,cfgGood.name)
                            end
                        end
                        CSAPI.SetText(this["txtNeed" .. i].gameObject,cost[1][2] .. "")
                    end
                end
            end
        end
        if dungeonData and dungeonData:IsPass() then --已建造
            local isAllBuild = IsAllBuildng()
            if buildInfo then
                CSAPI.SetGOActive(btnBuild1,buildInfo[1] == 0 and isAllBuild)
                CSAPI.SetGOActive(btnBuild2,buildInfo[2] == 0 and isAllBuild)
                CSAPI.SetGOActive(btnChange1,buildInfo[1] == 1 and isAllBuild)
                CSAPI.SetGOActive(btnChange2,buildInfo[2] == 1 and isAllBuild)
                SetTextAndCode(txtBuildDesc1.gameObject,buildInfo[1],isAllBuild)
                SetTextAndCode(txtBuildDesc2.gameObject,buildInfo[2],isAllBuild)
                LanguageMgr:SetText(txtNeedStr1,buildInfo[1] == 0 and 15156 or 15150)
                LanguageMgr:SetText(txtNeedStr2,buildInfo[2] == 0 and 15156 or 15150)
            end
        else --未建造
            CSAPI.SetGOActive(btnBuild1,true)
            CSAPI.SetGOActive(btnBuild2,true)
            CSAPI.SetGOActive(btnChange1,false)
            CSAPI.SetGOActive(btnChange2,false)
            SetTextAndCode(txtBuildDesc1.gameObject,0,false)
            SetTextAndCode(txtBuildDesc2.gameObject,0,false)
            LanguageMgr:SetText(txtNeedStr1,15150)
            LanguageMgr:SetText(txtNeedStr2,15150)
        end
    end
end

function SetTextAndCode(go,type,isCanChange)
    local id,code=0,""
    if type == 2 then
        id = 15151
        code = "70703A"
    elseif not isCanChange then
        id = 15153
        code = "C3AC84"
    end
    CSAPI.SetGOActive(go,id> 0)
    if id > 0 then
        LanguageMgr:SetText(go,id)
        CSAPI.SetTextColorByCode(go,code)
    end
end

function ShowBuildingPanel(b)
    isBuilding = b
    -- CSAPI.SetGOActive(buildShowObj,not b)
    CSAPI.SetGOActive(bulidObj,b)
    CSAPI.SetGOActive(node,not b)
    if currItem then
        currItem.SetFakeBuildIcon(b,currBuildIndex)
    end
end

function ShowBuildChangePanel(b)
    isBuildChange = b
    CSAPI.SetGOActive(buildChangeObj,b)
end

--建造关全通关
function IsAllBuildng()
    if not isAllBuilding and #curDatas > 0 then
        local cfgBuild = nil
        for i, v in ipairs(curDatas) do
            if not v:IsBuild() then
                return false
            end
        end
        isAllBuilding = true
        return true
    end
    return isAllBuilding
end

function OnClickBuild(go)
    if buildTips ~= "" then
        Tips.ShowTips(buildTips)
        return
    end
    currBuildIndex = go.name == "btnBuild1" and 1 or 2
    currBuildType = 1
    ShowBuildPanel(false)
    ShowBuildingPanel(true)
end

function OnClickChange(go)
    currBuildIndex = go.name == "btnChange1" and 1 or 2
    currBuildType = 2
    ShowBuildPanel(false)
    ShowBuildingPanel(true)
end

function OnClickDesc(go)
    if currItem2 then
        local dungeonData = DungeonMgr:GetDungeonData(currItem2.GetCfg().id)
        if dungeonData and dungeonData:IsPass() then
            local buildInfo = dungeonData:GetNGrade()
            if buildInfo then
                local index = go.name == "txtBuildDesc1" and 1 or 2
                if buildInfo[index] ~= 2 then
                    LanguageMgr:ShowTips(8048)
                end
            end
        end
    end
end

function OnClickSure()
    if currItem2 then
        FightProto:DuplicateBuild(currBuildType,currItem2.GetCfg().id,currBuildIndex,OnBuildCallBack)
    end
end

function OnBuildCallBack(proto)
    if proto and proto.data then
        DungeonMgr:AddDungeonData(proto.data)
    end
    if isBuilding then
        ShowBuildingAnim(function ()
            LanguageMgr:ShowTips(8047)
            ShowBuildingPanel(false)
            if currItem then
                currItem.Refresh(curDatas[curIndex],  {level = currLevel, isAllBuild = IsAllBuildng()})
            end
            if currBuildType == 1 then
                local cfgBuild = currItem2 and currItem2.GetBuildCfg(currBuildIndex)
                if cfgBuild and cfgBuild.BuildingStoryID and (not PlotMgr:IsPlayed(cfgBuild.BuildingStoryID)) then
                    PlotMgr:TryPlay(cfgBuild.BuildingStoryID, BuildPlotOver, this, true);
                else
                    SetBuild()
                end
            else
                SetBuild()
            end
            
        end)
        CSAPI.PlayTempSound(currBuildType == 1 and "BuildingDreamsInNecro_BuildingCreate_Effect_01" or "BuildingDreamsInNecro_BuildingChange_Effect_01")
    end
    -- layout:UpdateList()
end

function BuildPlotOver()
    PlotMgr:Save()
    SetBuild()
end

function SetBuild()
    if isFirstBuilding then
        if IsAllBuildng() then
            ShowBuildChangePanel(true)
        else
            ShowDungeonUnLockAnim()
        end
    else
        ShowBuildPanel(true)
        ShowBuildAnim2(true)
    end
end

function OnClickCancel()
    ShowCancelAnim(function ()
        ShowBuildingPanel(false)
        ShowBuildPanel(true)
    end)
end

function OnClickSure2()
    ShowBuildChangePanel(false)
    BackToMap(function ()
        ShowBGItems()
        MoveToTargetByInfo(items[1].GetInfo()[1])
    end)
    PlayAnim(500)
end
-----------------------------------------------preview-----------------------------------------------
function InitPreviewPanel()
    local _cfgs = Cfgs.Variant:GetGroup(sectionData:GetID())
    cfgVariants = {}
    if _cfgs then
        for k, v in pairs(_cfgs) do
            table.insert(cfgVariants,v)
        end
    end
    if #cfgVariants > 0 then
        table.sort(cfgVariants,function (a,b)
            return a.id < b.id
        end)
        local txts = nil
        local go = nil
        local tab = nil
        local imgGo = nil
        for i, v in ipairs(cfgVariants) do
            if i > 1 then
                go = CSAPI.CloneGO(previewItem.gameObject,previewTabs.transform)
                tab = ComUtil.GetCom(go,"CTabNormal")
                tab.tabIndex = i
                txts = ComUtil.GetComsInChildren(go,"Text")
                imgGo = CSAPI.CloneGO(previewBg.gameObject,previewBgParent.transform)
            else
                txts = ComUtil.GetComsInChildren(previewItem.gameObject,"Text")
                imgGo = previewBg.gameObject
            end
            if txts and txts.Length > 0 then
                for i = 0, txts.Length - 1 do
                    txts[i].text = v.name or ""
                end
            end
            if not IsNil(imgGo) and v.PreviewImage then
                ResUtil:LoadBigImg(imgGo,"UIs/DungeonActivity/Build/" .. v.PreviewImage .. "/bg",true)
            end
        end
    end
end

function ShowPreviewPanel(b)
    isPreview = b
    CSAPI.SetGOActive(previewObj,b)
    if b then
        local index = currPreviewIndex
        currPreviewIndex = 0
        previewTab.selIndex = index
        OnPreviewTabChange(index)
    end
end

function OnClickPreview()
    ShowPreviewPanel(true)
end

function OnPreviewTabChange(index)
    if currPreviewIndex == index then
        return
    end
    currPreviewIndex = index
    for i = 0, previewBgParent.transform.childCount - 1 do
        CSAPI.SetGOActive(previewBgParent.transform:GetChild(i).gameObject,(i + 1) == index)
    end
end
-----------------------------------------------share-----------------------------------------------
function OnClickShare()
    CSAPI.OpenView("ShareView",{LocationSource=6})
end

function OnShareStart()
    ShowSharePanel(true)
end

function OnShareFinish()
    ShowSharePanel(false)
end

function ShowSharePanel(b)
    CSAPI.SetGOActive(node,not b)
    CSAPI.SetGOActive(topParent,not b)
    if #items > 0 then
        for i, v in ipairs(items) do
            v.SetShowShare(b)
        end
    end
    local scale = 1
    if b then
        CSAPI.SetAnchor(bg,0,0)
        local size1 = CSAPI.GetRTSize(bg)
        local size2 = CSAPI.GetMainCanvasSize()
        local wScale,hScale = size2[0] / size1[0],size2[1] / size1[1]
        scale = wScale > hScale and wScale or hScale
    end
    CSAPI.SetScale(bg,scale,scale,1)
end
-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonActivity19/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(cfg, type, OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg, type, OnLoadCallBack)
    end
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    itemInfo.CallFunc("Double", "SetTextColor", "4a4643", "4a4643", "4a4643","a73329")
    itemInfo.CallFunc("Double", "SetButtonImg", "img_02_07", "img_02_08")
    -- itemInfo.CallFunc("Danager", "SetColors", {{218, 210, 196, 255}, {110, 81, 69, 255}, {110, 81, 69, 128}})
    itemInfo.CallFunc("Output", "ShowOutput", true, "spec_04")
    itemInfo.CallFunc("Target", "SetGoal", "492722", "492722", "Christmas_01", "summer2_01")
    if currItem2 then
        -- itemInfo.CallFunc("Danger", "ShowDangeLevel", currItem.IsDanger(), currItem.GetCfgs(), currDanger)
        itemInfo.AddTeamReplace(currItem2.GetType() == DungeonInfoType.Build, OnBattleEnter, "Common/btn_18_08",
            "e4d3c0")
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title", 11, 408)
        itemInfo.SetPanelPos("Level", 11, 318)
        itemInfo.SetPanelPos("Target", 11, 185)
        itemInfo.SetPanelPos("Details", 11, -200)
        itemInfo.SetPanelPos("Button", 11, -334)
        if currItem then
            itemInfo.SetPanelPos("Output", 11, currItem2.IsPlot() and -27 or -17)
            itemInfo.SetPanelPos("Plot", 11, currItem2.IsSpecial() and 184 or 226)
        end
        itemInfo.SetPanelPos("PlotButton", 11, -325)
        itemInfo.SetPanelPos("Danger", 11, -19)
        itemInfo.SetItemPos("Double", -206, -437)
        CSAPI.SetRTSize(itemInfo.layout, 779, 1004)
    end
end

-- 进入
function OnBattleEnter()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if currItem2 then
        local cfg = currItem2:GetCfg()
        if cfg then
            local cost = DungeonUtil.GetCost(cfg)
            if cost then
                local cur = BagMgr:GetCount(cost[1])
                if cur < cost[2] then
                    OnBuyFunc()
                    return
                end
            end
            -- local cfgs = currItem2.GetCfgs()
            -- if cfgs and #cfgs > 1 then
            --     cfg = cfgs[itemInfo.CallFunc("Danger", "GetCurrDanger")]
            -- end
            if cfg then
                if cfg.arrForceTeam ~= nil then -- 强制上阵编队
                    CSAPI.OpenView("TeamForceConfirm", {
                        dungeonId = cfg.id,
                        teamNum = cfg.teamNum
                    })
                else
                    CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                        dungeonId = cfg.id,
                        teamNum = cfg.teamNum
                    }, TeamConfirmOpenType.Dungeon)
                end
            end
        end
    end
end

function OnPayFunc(count)
    PlayerProto:BuyArachnidCount(count, sectionData:GetID())
end

function OnBuyFunc()
    local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
    if sectionData:GetBuyGets() then
        UIUtil:OpenPurchaseView(nil, nil, curCount, sectionData:GetBuyCount(), sectionData:GetBuyCost(),
            sectionData:GetBuyGets(), OnPayFunc)
    end
end

function OnStoryCB(isStoryFirst)
    if not isStoryFirst then
        return
    end
    local index = currItem2.index

    RefreshDatas()
    ShowBGItems()
    layout:UpdateList()
    ShowDungeonUnLockAnim()
    -- if currLevel == 2 then -- 困难不播动效
    --     return
    -- end
    isHardOpen, hardTips = datas[1]:IsOpen(2)
    CSAPI.SetGOActive(hardLock, not isHardOpen)
    -- isHardOpen = true
    -- ShowUnLockHardAnim()
end

function RefreshDatas()
    datas = {}
    local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
    if _datas and #_datas > 0 then
        local ids = nil
        for _, v in ipairs(_datas) do
            table.insert(datas, v)
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end

    curDatas = datas
end
-----------------------------------------------sv-----------------------------------------------
function MoveToTargetByInfo(info, callBack)
    if info then
        local x, y = info.pos and info.pos[1] or 0, info.pos and info.pos[2] or 0
        local scale = info.scale or 1
        local time = info.time or 0.2
        MoveToTarget(-x, -y, scale, time)
        if callBack then
            FuncUtil:Call(function()
                callBack()
            end, this, time * 1000 + 20)
        end
    end
end

function MoveToTarget(x, y, scale, time, callBack)
    x = x or 0
    y = y or 0
    scale = scale or 1
    if offsetScale > 0 then
        x = x * (1 + offsetScale)
        y = y * (1 + offsetScale)
        scale = scale + offsetScale
    end
    CSAPI.SetAnchor(localObj, x, y)
    x, y = CSAPI.GetLocalPos(localObj)
    time = time or 0.2
    ScaleTo(scale, time)
    MoveToTargetByAnim(x, y, time, callBack)
    -- CSAPI.MoveTo(bg, "UI_Local_Move", x, y, 0, callBack, time)
end

function ScaleTo(scale, time)
    if bg and not IsNil(bg.gameObject) then
        CSAPI.SetUIScaleTo(bg, nil, scale, scale, scale, nil, time)
    end
end

function SetPos(info)
    if info then
        local scale = info[1].scale
        CSAPI.SetScale(bg, scale, scale, 1)
        local pos = info[1].pos
        CSAPI.SetAnchor(localObj, pos[1], pos[2])
        local x, y = CSAPI.GetLocalPos(localObj)
        CSAPI.SetLocalPos(bg, -x, -y)
    end
end
-----------------------------------------------anim-----------------------------------------------
local moveAction, vsvAnim, buildAnim1, buildAnim2, maskAnim,nodeAnim
local levelAnims = {}
local animInfos = {}
local isAnim = false
function PlayAnim(delay, cb)
    if delay <= 0 then
        return
    end
    if isAnim then
        table.insert(animInfos,{time = delay,func = cb})
        return
    end
    CSAPI.SetGOActive(animMask, true)
    isAnim = true
    FuncUtil:Call(function()
        if cb then
            cb()
        end
        isAnim = false
        if #animInfos > 0 then
            local info = table.remove(animInfos,1)
            PlayAnim(info.time,info.func)
        else
            CSAPI.SetGOActive(animMask, false)
        end
    end, this, delay)
end

function InitAnim()
    CSAPI.SetGOActive(animMask, false)

    moveAction = ComUtil.GetCom(bg, "ActionMoveByCurve")
    table.insert(levelAnims, ComUtil.GetCom(easyObj, "Animator"))
    table.insert(levelAnims, ComUtil.GetCom(hardObj, "Animator"))
    table.insert(levelAnims, ComUtil.GetCom(extraObj, "Animator"))

    vsvAnim = ComUtil.GetCom(vsv, "Animator")
    buildAnim1 = ComUtil.GetCom(bulidObj, "Animator")
    buildAnim2 = ComUtil.GetCom(buildShowObj, "Animator")
    maskAnim = ComUtil.GetCom(infoMask, "Animator")
    nodeAnim  = ComUtil.GetCom(node, "Animator")
end

function MoveToTargetByAnim(x, y, time, callBack)
    local _x, _y = CSAPI.GetLocalPos(bg)
    moveAction.startPos = UnityEngine.Vector3(_x, _y, 0)
    moveAction.targetPos = UnityEngine.Vector3(x, y, 0)
    moveAction.time = time * 1000
    moveAction:Play(callBack)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function ShowEnterAnim()
    if isDungeonOver or data.itemId ~= nil then
        return
    end
    if not IsNil(nodeAnim) then
        nodeAnim:Play("entry")
    end
    -- ShowEffect(enterAction)
    PlayAnim(450)
end

function ShowEnterLevelAnim()
    for i, v in ipairs(levelAnims) do
        if not IsNil(v) then
            v:Play("Nsel")
        end
    end
end

function ShowUnLockHardAnim()
    PlayAnim(400)
    CSAPI.SetGOActive(hardLock, true)
    UIUtil:SetObjFade(hardLock, 1, 0, function()
        isHardOpen = true
        -- curIndex = 1
        levelTab.selIndex = 2
        OnTabChanged(2)
    end, 400)
end

function ShowChangeLevel(cur, last)
    PlayAnim(700)
    if last then
        if not IsNil(levelAnims[last]) then
            levelAnims[last]:Play("Nsel")
        end
    end
    if cur then
        if not IsNil(levelAnims[cur]) then
            levelAnims[cur]:Play("sel")
        end
    end
    CSAPI.SetGOActive(hardEffect,cur ~= 1)
    -- ShowEffect(svAction)
end

function ShowChangeDungeon(cb)
    if #items > 0 then
        for i, v in ipairs(items) do
            v.ShowQuitAnim()
        end
        FuncUtil:Call(function()
            if cb then
                cb()
            end
            for i, v in ipairs(items) do
                v.ShowEnterAnim()
            end
        end, this, 100)
    end
end

function ShowDungeonUnLockAnim()
    local index2 = curIndex2 + 1
    if index2 <= #curDatas2 then --解锁.
        if isActive then
            currItem2 = nil
            curIndex2 = 0
            selIndex2 = 0
            SetItemFade()
            ShowInfo()
        end
        local lua = layout:GetItemLua(index2)
        if lua and lua.IsOpen() then
            lua.ShowUnLockAnim()
        end
        CSAPI.PlayTempSound("BuildingDreamsInNecro_BuildingUnlock_Effect_01")
        PlayAnim(800)
    elseif curIndex + 1 <= #curDatas then --建造关
        local index = curIndex + 1
        BackToMap(function ()
            local item = items[index]
            item.OnClick()
        end)
        PlayAnim(800)
    end
end

function ShowVsvAnim(b, callBack)
    local time = b and 700 or 250
    if not IsNil(vsvAnim) then
        vsvAnim:Play(b and "entry" or "quit")
    end

    FuncUtil:Call(function()
        if callBack then
            callBack()
        end
    end, this, time)
end

function ShowBuildAnim1(b, callBack)
    local time = b and 700 or 250
    if not IsNil(buildAnim1) then
        buildAnim1:Play(b and "entry" or "quit")
    end

    FuncUtil:Call(function()
        if callBack then
            callBack()
        end
    end, this, time)
end

function ShowBuildAnim2(b, callBack)
    local time = b and 700 or 250
    if not IsNil(buildAnim2) then
        buildAnim2:Play(b and "entry" or "quit")
    end

    FuncUtil:Call(function()
        if callBack then
            callBack()
        end
    end, this, time)
end

function ShowInfoMaskAnim(b, callBack)
    local time = 200
    if not IsNil(maskAnim) then
        maskAnim:Play(b and "infoMask_entry" or "infoMask_quit")
    end

    FuncUtil:Call(function()
        if callBack then
            callBack()
        end
    end, this, time)
end

function ShowBuildingAnim(callBack)
    if currItem then
        CSAPI.SetGOActive(currItem.build,true)
        currItem.PlayShowAnim("build1")
    end
    ShowBuildAnim1(false)
    FuncUtil:Call(function ()
        if currItem then
            currItem.PlayShowAnim("build2")
        end
    end,this,1000)
    FuncUtil:Call(function ()
        if currItem then
            CSAPI.SetGOActive(currItem.build,false)
        end
        if callBack then
            callBack()
        end
    end,this,2500)
    PlayAnim(2500)
end

function ShowCancelAnim(callBack)
    if currItem then
        currItem.PlayShowAnim("quit")
    end
    ShowBuildAnim1(false)
    FuncUtil:Call(function ()
        if callBack then
            callBack()
        end
    end,this,500)
    PlayAnim(500)
end