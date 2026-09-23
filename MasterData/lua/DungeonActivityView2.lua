local sectionData = nil
local curType = 1
local curOpen = 1
local currLevel = 1
local blackFade = nil
local blackFade2 = nil
local videoGOs = nil
local effectGos = nil
local openInfo = nil
local info = nil
local groupDatas = nil
local currGroupData = nil
local imgs1 = nil
local imgs2 = nil
local btns = nil
local layout = nil
local svUtil = nil
local curDatas = nil

function Awake()
    blackFade = ComUtil.GetCom(frontBlack, "ActionFade")
    blackFade2 = ComUtil.GetCom(black, "ActionFade")
    CSAPI.SetGOActive(action,false)
    CSAPI.SetText(txtLockTime, "")

    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/DungeonActivity2/DungeonDangerNum", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    svUtil = SVCenterDrag.New()
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.Refresh(_data)
    item.SetSelect(index == currLevel)
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= currLevel then
        local item = layout:GetItemLua(currLevel)
        if item then
            item.SetSelect(false)
        end
        currLevel = index + 1
        local item = layout:GetItemLua(currLevel)
        if (item) then
            item.SetSelect(true);
        end
        SetArrows()
    end
    svUtil:Update()
end

function SetArrows()
    CSAPI.SetGOActive(btnFirst,currLevel ~= 1)
    CSAPI.SetGOActive(btnLast,currLevel ~= #curDatas)
end

function OnInit()
    UIUtil:AddTop2("DungeonActivity2", topObj, OnClickReturn);
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    eventMgr:AddListener(EventType.Loading_Complete,OnLoadComplete)
end

function OnRedPointRefresh()
    SetRed()
end

function OnLoadComplete()
    if openSetting and openSetting.isDungeonOver then
        ShowTips()
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()
    end
end

function OnOpen()
    imgs1 = {nolImg1,hardImg1,eliteImg1,hellImg1,exImg1}
    imgs2 = {nolImg2,hardImg2,eliteImg2,hellImg2,exImg2}
    btns = {btnNol,btnHard,btnElite,btnHell,btnEx}
    if data and data.id then
        sectionData = DungeonMgr:GetSectionData(data.id)
        if sectionData then
            openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        end
        SetDatas()
    end

    if groupDatas and #groupDatas > 0 then
        AnimMask(500)
        SetButtons()
        SetScale()
        RefreshPanel()
    else
        LogError("获取不到副本数据!")
    end
    blackFade2:Play(1,0,200)
    CSAPI.SetGOActive(action, true)

    MissionMgr:CheckRedPointData()
end

function SetRed()
    local isRed = MissionMgr:CheckRed2(eTaskType.DupTaoFa,sectionData:GetID())
    UIUtil:SetRedPoint2("Common/Red2", btnMission, isRed, 79, 42, 0)

    if DungeonActivityMgr:HasBuffBattle(sectionData:GetID()) then
        local isRed2 = MissionMgr:CheckRed2(eTaskType.PointsBattle,sectionData:GetID())
        UIUtil:SetRedPoint(exRedParent, isRed2, 0, 0, 0)
        UIUtil:SetRedPoint(btnEnter, isRed2 and curType == #curDatas, 236, 68, 0)
    end
end

function SetTeamReplace()
    local cfgDungeon = GetCurrCfg()
    if cfgDungeon and cfgDungeon.isHideReplace then
        CSAPI.SetGOActive(btnReplace,false)
    else
        CSAPI.SetGOActive(btnReplace,true)
    end
end

-- 初始化数据
function SetDatas()
    groupDatas = DungeonMgr:GetDungeonGroupDatas(data.id)
    local dungeonIds = {}
    if groupDatas and #groupDatas>0 then
        for i, v in ipairs(groupDatas) do
            if v:IsOpen() then
                curOpen = i
            end

            local ids = v:GetDungeonGroups()
            if ids and #ids > 0 then
                for k, m in ipairs(ids) do
                    if data.itemId and data.itemId == m then
                        curType = i
                        if #ids > 1 then
                            currLevel = k
                        end
                    end
                end
                if #ids > 1 then
                    dungeonIds = ids
                end
            end
        end
    end
    if not data.itemId then --无跳转id选中最新关卡
        curType = curOpen
    elseif DungeonMgr:GetCurrDungeonIsFirst() then --第一次战斗结束
        DungeonMgr:SetCurrDungeonNoFirst()
        curType = curOpen
    end

    curDatas = {}
    for i, v in ipairs(dungeonIds) do
        local cfg = Cfgs.MainLine:GetByID(v)
        table.insert(curDatas,cfg)
    end
    svUtil:Init(layout, #curDatas, {100, 100}, 3, 0.1, 0.58)
end

function SetButtons()
    for i = 1, #btns do
        if i > #groupDatas then
            CSAPI.SetGOActive(btns[i].gameObject,false)
        end
    end
end

-- 设置按钮初始大小
function SetScale()
    if groupDatas and #groupDatas > 0 then
        for i = 1, #groupDatas do
            local scale = curType == i and 1 or 0.58
            CSAPI.SetScale(imgs2[i], scale, scale, scale)
            CSAPI.SetGOActive(imgs1[i], curType == i)
        end
    end
end

-- 刷新
function RefreshPanel()
    currGroupData = groupDatas[curType]
    if currGroupData then
        SetBg()
        SetBGScale()
        PlayVideo()
        PlayEffect()
        SetTitle()
        SetState()
        SetLevel()
        SetPower()
        SetRank()
        SetTeamReplace()
        SetRed()
    end
end

-- 背景
function SetBg()
    CSAPI.LoadImg(btnEnter,"UIs/DungeonActivity2/btn_01_0" .. curType .. ".png",true, nil, true)
    local bgPath = currGroupData:GetBGPath()
    if bgPath ~= nil and bgPath ~= "" then
        ResUtil:LoadBigImg2(bg, bgPath,false)
    end
    local imgPath = currGroupData:GetImgPath()
    if imgPath ~= nil and imgPath ~= "" then
        ResUtil:LoadBigImg(before, imgPath, false)
    end
    CSAPI.SetGOActive(bg,currGroupData:GetShowType() ~= 3 and currGroupData:GetShowType() ~= 2)
    CSAPI.SetGOActive(before,currGroupData:GetShowType() > 2 and currGroupData:GetShowType() ~= 4)
end

function SetTitle()
    local title = ""
    local timeStr =""
    if openInfo then
        title = openInfo:GetName()
        if openInfo:IsDungeonOpen() then
            local strs = openInfo:GetTimeStrs()
            timeStr = strs[1] .. " " .. strs[2] .. " - " .. strs[3] .. " " .. strs[4]
        else    
            timeStr = openInfo:GetCloseTimeStr()
        end
    end
    CSAPI.SetText(txtTitle,title)
    CSAPI.SetText(txtTime,timeStr)
end

-- 状态
function SetState()
    if groupDatas and #groupDatas>0 then
        for i = 1, #groupDatas do
            CSAPI.SetImgColor(imgs2[i], 255, 255, 255, curType == i and 255 or 179)
        end
    end
    
    CSAPI.SetGOActive(hardLock, curOpen < 2)
    CSAPI.SetGOActive(eliteLock, curOpen < 3)
    CSAPI.SetGOActive(hellLock, curOpen < 4)
    CSAPI.SetGOActive(exLock, curOpen < 5)
end

function SetLevel()
    local ids = currGroupData:GetDungeonGroups()
    CSAPI.SetGOActive(levelObj, ids and #ids > 1)
    if ids and #ids>1 then
        layout:IEShowList(#curDatas, nil, currLevel)
        OnValueChange()
    end
end

function SetPower()
    local ids = currGroupData:GetDungeonGroups()
    CSAPI.SetGOActive(powerObj, not(ids and #ids > 1))
    local cfg = GetCurrCfg()
    if cfg and cfg.lvTips then
        CSAPI.SetText(txtPower,cfg.lvTips .. "")
    end
end

function SetRank()
    CSAPI.SetGOActive(btnRank,currGroupData:IsEx())
end

-- 普通
function OnClickNol()
    if curType ~= 1 then
        curType = 1
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

-- 困难
function OnClickHard()
    if curOpen < 2 then
        LanguageMgr:ShowTips(24002)
        return
    end
    if curType ~= 2 then
        curType = 2
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end
--精英
function OnClickElite()
    if curOpen < 3 then
        LanguageMgr:ShowTips(24002)
        return
    end
    if curType ~= 3 then
        curType = 3
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

-- 地狱
function OnClickHell()
    if curOpen < 4 then
            LanguageMgr:ShowTips(24002)
        return
    end
    if curType ~= 4 then
        curType = 4
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

--积分
function OnClickEx()
    if curOpen < 5 then
            LanguageMgr:ShowTips(24002)
        return
    end
    if curType ~= 5 then
        curType = 5
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

-- 任务
function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.DupTaoFa,
        group = data.id,
        title = LanguageMgr:GetByID(6020)
    })
end

-- 怪物说明
function OnClickExplain()
    local cfgDungeon = GetCurrCfg()
    local list = {};
    if cfgDungeon and cfgDungeon.enemyPreview then
        for k, v in ipairs(cfgDungeon.enemyPreview) do
            local cfg = Cfgs.CardData:GetByID(v);
            table.insert(list, {
                id = v,
                isBoss = k == 1
            });
        end
        CSAPI.OpenView("FightEnemyInfo", list);
    end
end

-- 进入编队
function OnClickEnter()
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if currGroupData:IsEx() then
        CSAPI.OpenView("BuffBattle",{id =currGroupData:GetID()})
        return
    end
    local cfg = GetCurrCfg()
    if cfg and DungeonMgr:IsDungeonOpen(cfg.id) then
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = cfg.id,
            teamNum = cfg.teamNum
        }, TeamConfirmOpenType.Dungeon)
    else
        if curType == #groupDatas then
            LanguageMgr:ShowTips(24008)
        else
            LanguageMgr:ShowTips(24002)
        end
    end
end

function OnClickLast()
    if (currLevel ~= #curDatas) then
        layout:MoveToCenter(#curDatas)
    end
end

function OnClickFirst()
    if (currLevel ~= 1) then
        layout:MoveToCenter(1)
    end
end

function OnClickExplain2()
    local cfg = GetCurrCfg()
    local explainData = {}
    explainData.title = LanguageMgr:GetByID(37033)
    explainData.content = cfg and cfg.introduce or ""
    explainData.pos= {249,-244}
    explainData.anchors = {1,0,1,0}
    CSAPI.OpenView("ExplainBox", explainData)
end

function OnClickRank()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickReplace()
    UIUtil:OpenTeamReplaceView(GetCurrCfg().id,OnClickEnter)
end

-- 关闭界面
function OnClickReturn()
    view:Close()
end

function GetCurrCfg(_index)
    local cfg = nil
    local index = _index or curType
    if groupDatas and groupDatas[index] then
        local ids = groupDatas[index]:GetDungeonGroups()
        local id = 0
        if ids and #ids>0 then
            id = #ids > 1 and ids[currLevel] or ids[1] 
        end
        cfg = Cfgs.MainLine:GetByID(id)
    end
    return cfg
end
-------------------------------------------video-------------------------------------------
-- 播放背景视频
function PlayVideo()
    videoGOs = videoGOs or {}
    for i, v in pairs(videoGOs) do
        CSAPI.SetGOActive(v, false)
    end
    if currGroupData:GetShowType() < 2 or not currGroupData:GetVideoName() then
        return
    end

    local name = currGroupData:GetVideoName()
    local goVideo = videoGOs[name]
    if not goVideo then
        goVideo = ResUtil:PlayVideo(name, videoParent);
        videoGOs[name] = goVideo.gameObject
    else
        CSAPI.SetGOActive(goVideo, true)
    end
end
-------------------------------------------effect-------------------------------------------
function PlayEffect()
    effectGos = effectGos or {}
    for i, v in pairs(effectGos) do
        CSAPI.SetGOActive(v, false)
    end
    if currGroupData:GetShowType() < 3 or not currGroupData:GetEffectName() then
        return
    end

    local name = currGroupData:GetEffectName()
    local goEffect = effectGos[name]
    if not goEffect then
        ResUtil:CreateBGEffect(name, 0,0,0,effectObj,function (go)
            effectGos[name] = go
        end);
    else
        CSAPI.SetGOActive(goEffect, true)
    end
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1,offset2 = size[0] / 1920,size[1] / 1080
    local offset = offset1>offset2 and offset1 or offset2
    local child = bg.transform:GetChild(0)
    if child then
        CSAPI.SetScale(child.gameObject,offset,offset,offset)
    end
end

-------------------------------------------anim-------------------------------------------
-- 按钮动画
function PlayButtonAnim()
    if groupDatas and #groupDatas>0 then
        for i = 1, #groupDatas do
            AnimScaleTo(imgs2[i].gameObject, curType == i)
            CSAPI.SetGOActive(imgs1[i], curType == i)
            AnimScaleTo(imgs1[i].gameObject, curType == i)
        end
    end
end

-- 缩放动画
function AnimScaleTo(go, isSel, cb)
    local scale = isSel and 1 or 0.58
    CSAPI.SetUIScaleTo(go, nil, scale, scale, scale, cb, 0.2)
end

-- 切换动画
function AnimBlackTo(cb)
    AnimMask(400)
    blackFade:Play(0, 1, 200, 0, function()
        blackFade:Play(1, 0, 200)
        if cb then
            cb()
        end
    end)
end

function AnimMask(delay)
    CSAPI.SetGOActive(clickMask, true)
    FuncUtil:Call(function()
        if gameObject then
            CSAPI.SetGOActive(clickMask, false)
        end
    end, nil, delay)
end
-------------------------------------------tips-------------------------------------------
function ShowTips()
    local info = FileUtil.LoadByPath("Dungeon_TaoFa_OpenInfo_".. data.id .."_" .. PlayerClient:GetUid() ..".txt") or {1}
    if curOpen < 2 and info[curOpen + 1] then --重置本地数据
        info = {}
        FileUtil.SaveToFile("Dungeon_TaoFa_OpenInfo_".. data.id .."_" .. PlayerClient:GetUid() ..".txt",info)
        return
    end
    if curOpen > 1 and info[curOpen] == nil then -- 没记录则弹出提示
        info[curOpen] = 1
        FileUtil.SaveToFile("Dungeon_TaoFa_OpenInfo_".. data.id .."_" .. PlayerClient:GetUid() ..".txt",info)
        if groupDatas and curOpen >= #groupDatas then --全开启
            local dungeonData = DungeonMgr:GetData(GetCurrCfg(curOpen).id)
            if dungeonData and dungeonData:IsPass() then --已通关则不用提示
                return
            end
        end
        LanguageMgr:ShowTips(34002)
    end
end

