--[[一、规则
1、有单抽/10抽动画，单抽不显示结果界面
2、每张卡必带前后2个视频（进场视频，退场视频）,5星卡进场动画视频前还有小队动画
3、
二、流程
打开界面，隐藏界面UI，展示抽卡动画--》卡牌小队动画或进场动画--》展示完后点击背景或者跳过
1.1 点击背景：退场动画--》下一张卡小队动画或进场动画或展示结果
1.2 跳过：退场动画--》展示未抽到过的卡（01）或展示结果
]] local isPlayBox = false -- 开箱动画是否已播放
local isCanShowNext = false
-- local starEffectNames = {"ShowRole_Blue", "ShowRole_Purple", "ShowRole_Gold", "ShowRole_Color"}
local starEffectNames = {"role_3star", "role_4star", "role_5star", "role_6star"}

function Awake()
    -- CSAPI.SetGOActive(uis, false)
    CSAPI.SetAnchor(uis, 0, 10000, 0)
    CSAPI.SetGOActive(objAnim, false)

    CSAPI.SetGOActive(showBg, false)

    -- ResUtil:PlayVideo("create_bg", bg)
    -- SettingMgr:SetMusic(false)
    -- CSAPI.StopBGM() --  EventMgr.Dispatch(EventType.Replay_BGM) 恢复
    CSAPI.AddEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.AddEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
end
---截图前一帧通知
function ShareView_NoticeTheNextFrameScreenshot(Data)
    CSAPI.SetGOActive(skip, false);
    CSAPI.SetGOActive(down, false);
    CSAPI.SetGOActive(ShareBtn, false)
end
---截图完成通知
function ShareView_NoticeScreenshotCompleted(Data)
    CSAPI.SetGOActive(skip, true);
    CSAPI.SetGOActive(down, true);
    OpenShareBtn();
end
function OnClickShareBtn()
    CSAPI.OpenView("ShareView",{LocationSource=1})
end
function OnInit()
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Card_Update, EClickLock)
    eventMgr:AddListener(EventType.Guide_Close_View, ViewClose)
end

function OnDestroy()
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
    eventMgr:ClearListener()
    RoleAudioPlayMgr:StopSound()

    -- RemoveAni()
end

-- 预加载立绘
function PreLoadImgs()
    local arr = {}
    for i, v in ipairs(infos) do
        local img = nil
        if (isFirst10) then
            local cfg = Cfgs.CardData:GetByID(v.id)
            local modelCfg = Cfgs.character:GetByID(cfg.model)
            img = modelCfg and modelCfg.img or nil
        else
            local _curData = RoleMgr:GetData(v.id)
            img = _curData and _curData:GetDrawImg()
        end

        if (img) then
            table.insert(arr, img)
        end
    end
    if (#arr > 0) then
        ResUtil:PreloadBigImgs_Character(arr)
    end
end

-- 角色展示  {卡牌{.sic}或表{.id}，池id，品质提升{x,x},是否隐藏开箱动画跳过按钮}
function OnOpen()

    bgm = CSAPI.StopBGM() --  EventMgr.Dispatch(EventType.Replay_BGM) 恢复

    infos = data[1]
    poolId = data[2]
    if CSAPI.IsADV() then AdvGuiDeScore.SetpoolId(poolId) end
    quality_up = data[3] -- 品质提升 array [1]:前 [2]:后

    -- 开箱动画不带跳过按钮
    disableSkipBtnState = data[4]
    --	if(disableSkipBtnState) then
    --		CSAPI.SetGOActive(btnSkip, false)
    --	end
    -- goodsDatas = data[5] --获得的物品
    isFirst10 = openSetting and openSetting == 3 or false -- 首次10连（无卡牌数据要自己组装）

    if (#infos <= 1) then
        CSAPI.SetGOActive(skip, false)
    end

    PreLoadImgs()

    -- 首抽隐藏右侧
    HideBtns()
    -- 奖励面板数据
    SetRewardDatas()

    -- 不需要开箱动画
    if (openSetting == 2) then
        isPlayBox = true
    end

    Show()
end

function Show()
    -- 开箱动画
    if (isPlayBox == false) then
        isPlayBox = true
        CSAPI.PlayUICardSound("ui_card_draw_ambience") -- 开箱背景音效
        ShowOpenBoxAni()
    else
        Show2()
    end
end

function Show2()
    isCanShowNext = false
    -- 前一张卡的退场动画
    if (hadPer) then
        hadPer = false
        ExitMV()
    else
        RoleAudioPlayMgr:StopSound()
        curInfo = GetInfo()
        curData = curInfo and GetCardData(curInfo) or nil
        hadPer = curData ~= nil
        if (curData) then
            if CSAPI.IsADV() or CSAPI.IsDomestic() then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_STRUCTURE_FINISH)
            end
            local cfg = curData:GetQuality() > 5 and Cfgs.CfgTeamEnum:GetByID(curData:GetCamp()) or nil
            if (cfg and cfg.mvName) then
                TeamMV(cfg.mvName)
            else
                EnterMV()
            end
        else
            ViewClose()
        end
    end
end

function Show3()
    SetBG()
    SetDesc()
    SetNew()
    SetName()
    SetTeam()
    -- SetMech()
    -- SetStar()
    -- SetLock()
    SetDOP()
    SetPosEnum()
    SetIcon()
    SetLightLR()
    SetDown()
    SetColor6()
    -- CSAPI.SetGOActive(uis, true)
    CSAPI.SetAnchor(uis, 0, 0, 0)
    CSAPI.SetGOActive(objAnim, true)
    -- isCanShowNext = true
    CSAPI.PlayUICardSound("ui_card_draw_hero_appear")
end

function SetColor6()
    CSAPI.SetGOActive(color6Obj, curData:GetQuality() > 5)
end

function HideBtns()
    CSAPI.SetGOActive(BtnLock, not isFirst10)
    CSAPI.SetGOActive(BtnAmplification, not isFirst10)
    CSAPI.SetGOActive(BtnShare, not isFirst10)
end

-- 获取卡牌数据
function GetCardData(_data)
    local _curData = nil
    if (isFirst10) then
        _curData = RoleMgr:GetFakeData(_data.id, 1)
    else
        _curData = RoleMgr:GetData(_data.id)
    end
    return _curData
end

-- 获取当前需要展示的卡牌
function GetInfo()
    isNew = false
    if (infos and #infos > 0) then
        local run = true
        while run do
            _info = infos[1]
            isNew = infos[1].num < 2 and true or false
            table.remove(infos, 1)

            -- 非10连必定展示第一张
            if (#rewards ~= 10) then
                return _info
            end

            if (not isNew and isSkip) then
                _info = nil
            end

            -- 配置跳过
            if (CheckSkip()) then
                _info = nil
            end

            if (_info) then
                return _info
            end
            if (#infos <= 0) then
                run = false
                return nil
            end
        end
    else
        return nil
    end
end

-- 配置跳过(首抽是否硬性跳过)
function CheckSkip()
    local jump = false
    if (isSkip) then
        if (isFirst10) then
            jump = g_SkipFirstCreate and g_SkipFirstCreate == 1 and true or false
        else
            jump = g_SkipCreate and g_SkipCreate == 1 and true or false
        end
    end
    return jump
end

function SetBG()

end

function SetDesc(curCfg)
    if (not IsNil(gameObject) and curCfg) then
        local script = SettingMgr:GetSoundScript(curCfg)
        CSAPI.SetText(txtTalk, script or "")
    else
        CSAPI.SetText(txtTalk, "")
    end
end

function SetNew()
    CSAPI.SetGOActive(new, isNew)
end

function SetName()
    local _name = curData and curData:GetName() or ""
    CSAPI.SetText(txtName, _name)
    CSAPI.SetText(txtName2, curData:GetCfg().nameEng)
end

function SetTeam()
    local cfg = Cfgs.CfgTeamEnum:GetByID(curData:GetCamp())
    local teamIconName = curData:GetModelCfg().teamIcon
    if cfg.cIcon then
        ResUtil:LoadBigImg(imgTeamSmall, "UIs/Create/" .. cfg.cIcon .. "/bg_small", true)
        ResUtil:LoadBigImg(imgTeamBig, "UIs/Create/" .. cfg.cIcon .. "/bg_big", true)
        CSAPI.SetText(txtTeam, cfg.sName)
    end

    CSAPI.SetGOActive(imgTeamSmall, cfg.cIcon ~= nil)
    CSAPI.SetGOActive(imgTeamBig, cfg.cIcon ~= nil)
end

-- 角色定位
function SetPosEnum()
    local str = ""
    local _nums = curData:GetCfg().pos_enum
    if (_nums) then
        for i, v in ipairs(_nums) do
            local cfg = Cfgs.CfgRolePosEnum:GetByID(v)
            if (str == "") then
                str = cfg.sName
            else
                str = cfg.sName .. " " .. str
            end
        end
    end
    CSAPI.SetText(txtPos2, str)
end

function SetDOP()
    local time = TimeUtil:GetTimeHMS(TimeUtil:GetTime(), " %Y.%m.%d")
    CSAPI.SetText(txtDOP, string.format("DOP//:%s", time)) --DOP//:%s

    local x = -30
    local _q = curData:GetQuality() or 3
    if (_q < 5) then
        x = _q == 4 and -95 or -160
    end
    CSAPI.SetAnchor(imgDOP, x, 0, 0)
end

function SetIcon()
    local modelId = curData and curData:GetCfg().model or nil
    if (modelId) then
        RoleTool.LoadImg(icon, modelId, LoadImgType.CreateShowView, function()
            RoleAudioPlayMgr:PlayByType(curData:GetSkinID(), RoleAudioType.get, nil, SetDesc, nil)
        end)
    end
end

function SetLightLR()
    local quality = curData:GetQuality()
    local name = "img_2_06"
    if (quality == 5) then
        name = "img_2_02"
    elseif (quality < 5) then
        name = quality == 4 and "img_2_05" or "img_2_04"
    end
    CSAPI.LoadImg(rightL, "UIs/CreateShow/" .. name .. ".png", true, nil, true)
    CSAPI.LoadImg(rightR, "UIs/CreateShow/" .. name .. ".png", true, nil, true)

    CSAPI.SetGOActive(obj6, quality == 6)
end

-- 素材
function SetDown()
    -- local goodsData = goodsDatas ~= nil and goodsDatas[curData:GetID()] or nil
    local goodsData = nil
    if (openSetting == 2) then
        local cfg = Cfgs.CardData:GetByID(curInfo.id)
        goodsData = GCalHelp:CalCardCoreElemByCfg(cfg, curInfo.num)
    else
        goodsData = curInfo.items
    end
    CSAPI.SetGOActive(down, goodsData ~= nil)
    if (goodsData) then
        if (#goodsData >= 2) then
            -- 重复获得    
            SetDownItem(goodsData[1], item1, txtItem1)
            -- 额外获得
            SetDownItem(goodsData[2], item2, txtItem2)
        else
            -- 重复获得    
            SetDownItem(nil, item1, txtItem1)
            -- 额外获得
            SetDownItem(goodsData[1], item2, txtItem2)
        end
    end
end

function SetDownItem(data, item, txt)
    CSAPI.SetGOActive(item, data ~= nil)
    if (data) then
        CSAPI.SetText(txt, data.num .. "")
        local tab = ResUtil:CreateRandRewardGrid(data, item.transform)
        CSAPI.SetAnchor(tab.gameObject, -137, 0, 0)
        CSAPI.SetScale(tab.gameObject, 0.5, 0.5, 1)
        tab.SetClickCB(nil)
        if (curData:GetQuality() > 5) then
            tab.LoadFrame(6)
        end
    end
end

-- 奖励面板数据
function SetRewardDatas()
    rewards = {}
    if (openSetting == 2) then
        return
    end
    for i, v in ipairs(infos) do
        local cfg = nil
        -- if(isFirst10) then
        -- 	cfg = Cfgs.CardData:GetByID(v.id)
        -- else
        -- 	local _curData = RoleMgr:GetData(v.sid)
        -- 	cfg = _curData:GetCfg()
        -- end
        cfg = Cfgs.CardData:GetByID(v.id)
        if (cfg) then
            table.insert(rewards, {
                id = cfg.id,
                num = 1,
                type = RandRewardType.CARD,
                isNew = v.num < 2,
                goodsData = v.items
            })

            if CSAPI.IsADV() then
                local Quality=cfg["quality"]
                AdvGuiDeScore.SetQuality(Quality)
            end
        end
    end
end

-- 展示结果
function ShowRewardPanel()
    if (#rewards == 10) then
        CSAPI.OpenView("CreateRoleView", {rewards, isFirst10, poolId})
    else
        if CSAPI.IsADV() then AdvGuiDeScore.GameAdvGuiDeScore() end
        -- SettingMgr:SetMusic(true)
        -- EventMgr.Dispatch(EventType.Replay_BGM)
        --CSAPI.ReplayBGM(bgm)
    end
end

--非正常抽卡流程，需要恢复bgm
function ReplayBGM()
    CSAPI.ReplayBGM(bgm)
end

--------------------------------放大-------------------------------------
-- 放大
function OnClickBig()
    if (isTween) then
        return
    end
    SetAmplification(true)
end

-- 设置放大
function SetAmplification(_show)
    if (isShow and isShow == _show) then
        return
    end
    isShow = _show
    if (_show) then
        local modelId = curData and curData:GetCfg().model or nil
        local pos, imgScale = RoleTool.GetImgPosScale(modelId, LoadImgType.CreateShowView)

        CSAPI.SetGOActive(showBg, true)
        CSAPI.SetParent(iconParent, showBg)
        if (not uiHandle) then
            uiHandle = ComUtil.GetCom(showBg, "UIHandle")
            uiHandle.isMoveLimit = false 
        end
        uiHandle:InitParm(1, 1, g_CardLookScale[1] / imgScale, g_CardLookScale[2] / imgScale) -- 对应的是父类不是role
        uiHandle:Init(iconParent, function()
            SetAmplification(false)
        end)
    else
        uiHandle:Init(nil)
        CSAPI.SetAnchor(iconParent, 0, 0)
        CSAPI.SetParent(iconParent, rolePoint)
        CSAPI.SetGOActive(showBg, false)
    end
    -- LeftSide
    if (curStarEffect) then
        local LeftSide = curStarEffect.transform:GetChild(0)
        if (LeftSide) then
            CSAPI.SetGOActive(LeftSide.gameObject, not isShow)
        end
    end
end

---------------------------------------------------------------------
function OnClickShare()
    Log("无ui")
    -- CSAPI.OpenView("RoleShareView", curData)
end

-- 点击背景
function OnClickBg()
    if (criMovie) then
        -- 小队动画
        criMovie:Pause(true)
        CSAPI.RemoveGO(criMovie.gameObject)
        criMovie = nil
    elseif (isCanShowNext) then
        -- 下一个
        Show2()
    end
end

-- end
function OnClickSkip()
    -- if(boxAni) then
    -- 	StartShow()
    -- else
    if (isCanShowNext) then
        isSkip = true
        CSAPI.SetGOActive(btnSkip, false)
        OnClickBg()
    end
    -- end
end

-- 显示开箱动画 
function ShowOpenBoxAni()
    -- datas 
    local cardDatas = {}
    for i, v in ipairs(infos) do
        table.insert(cardDatas, GetCardData(v))
    end
    -- panel
    local go = ResUtil:CreateUIGO("CreateShow/CreateBox", transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Refresh(cardDatas, function(_isSkip)
        if (_isSkip and #infos > 1) then
            -- 全程跳过（限10连，1抽的还是要展示）
            isSkip = true
        end
        Show2()
    end)

    if (disableSkipBtnState) then
        lua.SetSkipState(false);
    end
end

--------------------------------动画-------------------------------------
-- 进场动画
function EnterMV()
    CSAPI.SetAnchor(uis, 0, 10000, 0)
    CSAPI.SetGOActive(objAnim, false)
    local quality = curData:GetQuality() or 3
    AddEnterMV(quality)
    if (quality >= 5) then
        CSAPI.PlayUICardSound("ui_card_draw_hero_golden_02")
    elseif (quality >= 4) then
        CSAPI.PlayUICardSound("ui_card_draw_transition")
    else
        CSAPI.PlayUICardSound("ui_card_draw_hero_bule")
    end
    OpenShareBtn();
end
---判断是否可以打开分享按钮
function OpenShareBtn()
    local quality = curData:GetQuality() or 3
    if quality>=6 and CSAPI.IsSharePicture() then
        CSAPI.SetGOActive(ShareBtn, true);
    else
        CSAPI.SetGOActive(ShareBtn, false);
    end
end
-- 星星特效
function AddEnterMV(quality)
    if (curStarEffect) then
        CSAPI.SetGOActive(curStarEffect, false)
    end
    starEffects = starEffects or {}
    if (starEffects[quality]) then
        curStarEffect = starEffects[quality]
        CSAPI.SetGOActive(curStarEffect, true)
        HideExitMV()
    else
        local effectName = starEffectNames[quality - 2]
        ResUtil:CreateEffect("OpenBox/" .. effectName, 0, 0, 0, starParent, function(go)
            curStarEffect = go
            starEffects[quality] = go
            -- -- 自适应Baiping
            -- local arr = CSAPI.GetMainCanvasSize()
            -- local baiping = go.transform:Find("Baiping")
            -- CSAPI.SetScale(baiping.gameObject, arr.x, arr.y, 1)
            HideExitMV()
        end)
    end

    -- FuncUtil:Call(function()
    --     isCanShowNext = true
    -- end, nil, 1500)
end

function HideEnterMV()
    if (create_enter) then
        CSAPI.SetGOActive(create_enter.gameObject, false)
    end
end
-- 退场动画
function ExitMV()
    UIUtil:SetPObjMove(rolePoint, 0, -300, 0, 0, 0, 0, Show2, 300, 0)
    UIUtil:SetObjFade(rolePoint, 1, 0, nil, 299, 0)
end
-- -- 退场动画
-- function ExitMV()
--     if (not exitEffect) then
--         ResUtil:CreateEffect("OpenBox/RoleChangeEffect", 0, 0, 0, exitParent, function(go)
--             exitEffect = go
--             -- 自适应Baiping
--             local arr = CSAPI.GetMainCanvasSize()
--             local baiping = go.transform:Find("baiping")
--             CSAPI.SetScale(baiping.gameObject, arr.x, arr.y, 1)
--             --
--             FuncUtil:Call(Show2, nil, 300)
--         end)
--     else
--         CSAPI.SetGOActive(exitEffect, false)
--         CSAPI.SetGOActive(exitEffect, true)
--         FuncUtil:Call(Show2, nil, 300)
--     end
-- end

function HideExitMV()
    -- if (exitEffect) then
    --     CSAPI.SetGOActive(exitEffect, false)
    -- end
    Show3()
    FuncUtil:Call(function()
        isCanShowNext = true
    end, nil, 1500)
end

-- 小队动画
function TeamMV(mvName)
    criMovie = ResUtil:PlayVideo(mvName, MVParent)
    --UIUtil:SetPerfectScale(criMovie.gameObject)
    criMovie:AddCompleteEvent(function()
        EnterMV()
        criMovie = nil
    end)

    CSAPI.PlayUICardSound("ui_card_draw_hero_golden_01")
end

function ViewClose()
    CSAPI.ReplayBGM(bgm)
    if(showCB) then 
        showCB()
    else 
        ShowRewardPanel()
    end 
    -- view:Close()

    -- 延迟关闭，放置CreateView的突然显示盒消失
    FuncUtil:Call(function()
        view:Close()
        if (rewards and #rewards ~= 10) then
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "BackToCreate")
            PopupPackMgr:CheckByCondition({3})
            PhysicalRewardMgr:CheckShowReward()
        end 
    end, nil, 1)
end


function SetShowRewardPanel(cb)
    showCB = cb
end