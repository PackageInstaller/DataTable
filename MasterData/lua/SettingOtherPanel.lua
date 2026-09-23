local liveIndex = nil
local equipIndex = nil
local timer = 0;
local names = {s_wait_scale.waitTime, s_wait_scale.timeFormat, s_wait_scale.style, s_wait_scale.tips, s_wait_scale.time,
               s_wait_scale.electric, s_wait_scale.date, s_wait_scale.rotate}
local tabNames = {"djsjTab", "sjgsTab", "djfgTab", "gntsTab", "sjxsTab", "dlxsTab", "rqxsTab", "lhxsTab"}
local languageTab = nil
local languageIndex = 0

function SetCloseCallBack(_cb)
    cb = _cb
end

function Awake()
    CSAPI.SetGOActive(mask, false)

    liveIndex = SettingMgr:GetValue(s_other_live_key) or s_other_live_default
    equipIndex = SettingMgr:GetValue(s_other_equipLock_key) or s_other_equipLock_default
    if not liveIndex or liveIndex == 0 then
        liveIndex = s_other_live_default
    end
    if not equipIndex or equipIndex == 0 then
        equipIndex = s_other_equipLock_default
    end

    SetLive()
    SetAuto()

    InitWaitSetting()
    JPObjState();
    ZbmsobjState();

    InitLanguage()
end

-- 直播模式
function SetLive()
    CSAPI.SetGOActive(zbms_open, liveIndex == 1)
    CSAPI.SetGOActive(zbms_close, liveIndex == 2)
end

-- 自动上锁
function SetAuto()
    CSAPI.SetGOActive(zdss_open, equipIndex == 1)
    CSAPI.SetGOActive(zdss_close, equipIndex == 2)
end

function OnClickLive()
    local index = liveIndex == 1 and 2 or 1
    if index == 1 then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(7008)
        dialogData.okCallBack = function()
            liveIndex = 1
            SetLive()
            SettingMgr:SaveValue(s_other_live_key, liveIndex)
            EventMgr.Dispatch(EventType.Setting_Live_Change, liveIndex)
            LanguageMgr:ShowTips(7011)
        end
        CSAPI.OpenView("Dialog", dialogData)
    else
        liveIndex = 2
        SetLive()
        SettingMgr:SaveValue(s_other_live_key, liveIndex)
        EventMgr.Dispatch(EventType.Setting_Live_Change, liveIndex)
        LanguageMgr:ShowTips(7010)
    end
end

function OnClickTips()
    CSAPI.OpenView("Prompt", {
        content = LanguageMgr:GetTips(7009)
    })
end

function OnClickAuto()
    local index = equipIndex == 1 and 2 or 1
    CSAPI.SetGOActive(mask, true)
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "zdss",
        time = 1000,
        timeOutCallBack = function()
            LanguageMgr:ShowTips(7012)
            CSAPI.SetGOActive(mask, false)
        end
    })

    PlayerProto:Setting(index == 1, function(b)
        CSAPI.SetGOActive(mask, false)
        if b then
            EventMgr.Dispatch(EventType.Net_Msg_Getted, "zdss")
            equipIndex = index
            SetAuto()
            SettingMgr:SaveValue(s_other_equipLock_key, equipIndex)
            LanguageMgr:ShowTips(index == 1 and 7011 or 7010)
        else
            LanguageMgr:ShowTips(7012)
        end
    end)
end

function SetFade(isOpen, callback)
    if isOpen then
        CSAPI.SetGOActive(gameObject, true)
        UIUtil:SetObjFade(gameObject, 0, 1, callback, 200)
    else
        UIUtil:SetObjFade(gameObject, 1, 0, function()
            CSAPI.SetGOActive(gameObject, false)
            if callback then
                callback()
            end
        end, 200)
    end
end

--------------------------------------------待机设置--------------------------------------------
function InitWaitSetting()
    local info = g_HoldOnTime
    if info then
        LanguageMgr:SetText(txtDjsj1, 68010, info[1])
        LanguageMgr:SetText(txtDjsj2, 68010, info[2])
        LanguageMgr:SetText(txtDjsj3, 68010, info[3])
    end
    for i, v in ipairs(names) do
        this["curIndex" .. i] = SettingMgr:GetValue(v)
        this["tab" .. i] = ComUtil.GetCom(this[tabNames[i]].gameObject, "CTab")
        this["tab" .. i].defaultSelIndex = this["curIndex" .. i]
        this["tab" .. i]:AddSelChangedCallBack(this["OnTabChanged" .. i])
    end
end

function OnTabChanged1(index)
    if CheckIsChange(1, index) then

    end
end

function OnTabChanged2(index)
    if CheckIsChange(2, index) then

    end
end

function OnTabChanged3(index)
    if CheckIsChange(3, index) then
        SetUnity()
    end
end

function OnTabChanged4(index)
    if CheckIsChange(4, index) then
        SetCustom(index)
    end
end

function OnTabChanged5(index)
    if CheckIsChange(5, index) then
        SetCustom(index)
    end
end

function OnTabChanged6(index)
    if CheckIsChange(6, index) then
        SetCustom(index)
    end
end

function OnTabChanged7(index)
    if CheckIsChange(7, index) then
        SetCustom(index)
    end
end

function OnTabChanged8(index)
    if CheckIsChange(8, index) then
        SetCustom(index)
    end
end

function CheckIsChange(curIndex, index)
    if this["curIndex" .. curIndex] ~= index then
        this["curIndex" .. curIndex] = index
        SettingMgr:SaveValue(names[curIndex], index)
        return true
    end
    return false
end

-- 统一设置
function SetUnity()
    if this["curIndex3"] < 2 then
        local index = this["curIndex3"]
        for i = 4, 8 do
            if CheckIsChange(i, index) then
                this["tab" .. i].selIndex = index
            end
        end
    end
end

-- 自定义设置
function SetCustom(index)
    local isCustom = false
    for i = 4, 8 do
        if this["curIndex" .. i] ~= index then
            isCustom = true
            break
        end
    end
    if isCustom then
        if this["curIndex3"] < 2 then
            CheckIsChange(3, 2)
            this["tab3"].selIndex = 2
        end
    else
        if this["curIndex3"] == 2 then
            CheckIsChange(3, index)
            this["tab3"].selIndex = index
        end
    end
end

function OnClickEnter()
    CSAPI.OpenView("MenuStandby")
    if cb then
        cb()
    end
end
---区分海外和国内隐藏/显示
function JPObjState()
    if CSAPI.IsADVRegional(3) then
        CSAPI.SetGOActive(JPObj, true)
    else
        CSAPI.SetGOActive(JPObj, false)
    end

end
function OnClickUserAgreementTxt(go)
    Log("用户协议")
    ShiryuSDK.ShowSdkCommonUI(7)
end

function OnClickPrivacytxt(go)
    Log("隐私协议")
    ShiryuSDK.ShowSdkCommonUI(6)
end
---直播开关按钮
function ZbmsobjState()
    if CSAPI.IsADV() then
        CSAPI.SetGOActive(zbmsObj, false)
        CSAPI.SetAnchor(zdssObj, CSAPI.csGetAnchor(zbmsObj)[0], CSAPI.csGetAnchor(zbmsObj)[1],
            CSAPI.csGetAnchor(zbmsObj)[2]);
    end
end

function Update()
    if (Time.time < timer) then
        return
    end
    timer = Time.time + 1

    RefreshDownloadBtn()
end

function OnClickRewardBtn()
    OnClickDownloadBtn()
end
function OnClickDownloadBtn()
    CSAPI.OpenView("SilentDownload")
end
function RefreshDownloadBtn()
    local apkVer = tonumber(CSAPI.APKVersion())
    local percent = apkVer <= 6 and 1 or SilentDownloadMgr:GetInfo_CurrentDownloadProgressPecent()
    -- local percent = SilentDownloadMgr:GetInfo_CurrentDownloadProgressPecent()
    -- 下载完成，未领取奖励
    local canReward = percent >= 1 and not MenuMgr:GetDownloadRewardState()
    -- 下载完成，已经领取奖励
    local hasRewarded = percent >= 1 and MenuMgr:GetDownloadRewardState()
    CSAPI.SetGOActive(rewardBtn, canReward)
    CSAPI.SetGOActive(completeBtn, hasRewarded)
    CSAPI.SetGOActive(downloadBtn, not canReward and not hasRewarded)
    -- 暂时屏蔽功能入口
    -- CSAPI.SetGOActive(node.transform:Find("downloadObj").gameObject,false)

    -- if canReward then
    -- else if hasRewarded then
    --     CSAPI.SetGOActive(rewardBtn,true)
    --     CSAPI.SetGOActive(completeBtn,false)
    --     CSAPI.SetGOActive(downloadBtn,false)

    -- else

    -- end
    -- 未下载完
end

--------------------------------------------语音设置--------------------------------------------
function InitLanguage()
    CSAPI.SetGOActive(languageObj, CSAPI.RegionalCode() == 6)
    if CSAPI.RegionalCode() == 6 then -- 英俄
        local list = this["g_LanguageSetting" .. CSAPI.GetRegionalLanguage()]
        if list and #list > 0 then
            for i, v in ipairs(list) do
                if this["lang" .. v] and not IsNil(this["lang" .. v].gameObject) then
                    CSAPI.SetGOActive(this["lang" .. v].gameObject, true)
                end
            end
        end
        languageTab = ComUtil.GetCom(langTab, "CTab")
        languageTab.defaultSelIndex = CSAPI.GetDefaultLanguageIndex()
        languageIndex = CSAPI.GetDefaultLanguageIndex()
        languageTab:AddSelChangedCallBack(OnLangTabChange)
    end
end

function OnLangTabChange(index)
    if languageIndex ~= index then
        languageIndex = index
        LanguageMgr:ToChangeLanguage(index)
    end
end
