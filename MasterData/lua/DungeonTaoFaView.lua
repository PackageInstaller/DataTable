local curType = 1
local curOpen = 1
local currLevel = 1
local videoGOs = nil
local effectGos = nil
local openInfo = nil
local info = nil
local groupDatas = nil
local currGroupData = nil
local imgs1 = nil
local imgs2 = nil
local btns = nil
local itemInfo = nil
local sectionData = nil

function Awake()
    CSAPI.SetGOActive(action,false)
    CSAPI.SetGOActive(clickMask,false)
end


function OnInit()
    UIUtil:AddTop2("DungeonTaoFa", topObj, OnClickReturn);
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
end

function OnRedPointRefresh()
    SetRed()
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
    imgs1 = {nolImg1,hardImg1,eliteImg1,hellImg1}
    imgs2 = {nolImg2,hardImg2,eliteImg2,hellImg2}
    btns = {btnNol,btnHard,btnElite,btnHell}
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
        ShowTips()
    else
        LogError("获取不到副本数据!")
    end
    CSAPI.SetGOActive(action, true)

    MissionMgr:CheckRedPointData()
end

function SetRed()
    local isRed = MissionMgr:CheckRed2(eTaskType.DupTaoFa,sectionData:GetID())
    UIUtil:SetRedPoint2("Common/Red2", btnMission, isRed, 108, 32, 0)
end


-- 初始化数据
function SetDatas()
    groupDatas = DungeonMgr:GetDungeonGroupDatas(data.id)
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
            end
        end
    end
    if not data.itemId then --无跳转id选中最新关卡
        curType = curOpen
    end
end

function SetButtons()
    for i = 1, #btns do
        if i > #groupDatas then
            CSAPI.SetGOActive(btns[i],false)
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
        ShowInfo()
        SetRed()
    end
end

-- 背景
function SetBg()
    local bgPath = currGroupData:GetBGPath()
    if bgPath ~= nil and bgPath ~= "" then
        ResUtil:LoadBigImg2(bg, bgPath,false)
    end
    local imgPath = currGroupData:GetImgPath()
    if imgPath ~= nil and imgPath ~= "" then
        ResUtil:LoadBigImg(before, imgPath, false)
    end
    CSAPI.SetGOActive(bg,currGroupData:GetShowType() ==1 )
    CSAPI.SetGOActive(before,currGroupData:GetShowType() > 2 and currGroupData:GetShowType() ~= 4)
    -- CSAPI.SetGOActive(mask,currGroupData:GetShowType() ==1)

    local iconName = currGroupData:GetIcon()
    if iconName~=nil and iconName~="" then
        ResUtil.DungeonTaoFa:Load(icon,iconName)
    end
    CSAPI.SetGOActive(icon,currGroupData:GetShowType() ==1)
end

function SetTitle()
    local timeStr =""
    if openInfo then
        if openInfo:IsDungeonOpen() then
            local strs = openInfo:GetTimeStrs()
            timeStr = strs[1] .. " " .. strs[2] .. " - " .. strs[3] .. " " .. strs[4]
        else    
            timeStr = openInfo:GetCloseTimeStr()
        end
    end

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
end

function ShowInfo()
    local cfg = GetCurrCfg()
    local cfgs = GetCfgs() or {}
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo4", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(itemInfo.gameObject, true)
            itemInfo.SetPos(true)
            itemInfo.SetClickCB(OnBattleEnter)
            itemInfo.Refresh(cfg,DungeonInfoType.Danger,function ()
                itemInfo.CallFunc("Danger","ShowDangeLevel",#cfgs > 1,cfgs,currLevel)
                itemInfo.AddTeamReplace(true,OnBattleEnter)
            end)
        end)
    else
        itemInfo.Refresh(cfg,DungeonInfoType.Danger,function ()
            itemInfo.CallFunc("Danger","ShowDangeLevel",#cfgs > 1,cfgs,currLevel)
            itemInfo.AddTeamReplace(true,OnBattleEnter)
        end)
    end
end

function OnBattleEnter()
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    currLevel = itemInfo.GetCurrDanger()
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

function GetCurrCfg(_index)
    local cfg = nil
    local index = _index or curType
    if groupDatas and groupDatas[index] then
        local ids = groupDatas[index]:GetDungeonGroups()
        local id = 0
        if ids and #ids>0 then
            id = index < #groupDatas and ids[1] or ids[currLevel]
        end
        cfg = Cfgs.MainLine:GetByID(id)
    end
    return cfg
end

function GetCfgs()
    return currGroupData and currGroupData:GetDungeonCfgs()
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

-- 任务
function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.DupTaoFa,
        group = data.id,
        title = LanguageMgr:GetByID(6020)
    })
end

-- 关闭界面
function OnClickReturn()
    view:Close()
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
    CSAPI.SetScale(effectObj,offset,offset,offset)
    CSAPI.SetScale(timeObj,offset,offset,offset)
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
    UIUtil:SetObjFade(frontBlack,0, 1,nil, 200)
    FuncUtil:Call(function ()
        UIUtil:SetObjFade(frontBlack,1, 0,nil, 200)
        if cb then
            cb()
        end
    end,this,200)
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