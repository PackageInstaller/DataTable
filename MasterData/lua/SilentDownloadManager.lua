local this = MgrRegister("SilentDownloadManager")

function this:Init()
    
    this.enableTrackEvent = true
    this.hasPopSelectView = false
    self:Clear()
    
    if tonumber(CSAPI.APKVersion()) >= 9 then
        EventMgr.AddListener(EventType.Version_SilentDownload_Error_MD5, this.OnVersionSilentDownloadError)
    end
    -- 兼容旧包
    if tonumber(CSAPI.APKVersion()) > 6 then
        EventMgr.AddListener(EventType.Version_SilentDownload_Select, this.OnShowSilentDownloadSelect)
        -- LogError("Regist EventType.Version_SilentDownload_Select")
    end
    -- EventMgr.AddListener(EventType.Login_Success,this.CheckInternation);
    this.CheckInternation()
end

function this.CheckInternation()
    -- Log("CheckInternation")
    if CSAPI.IsDomestic() and (CSAPI.OpenHarmony == nil or CSAPI.Currentplatform ~= CSAPI.OpenHarmony) then
        local recordInternationState = PlayerPrefs.GetInt("Internation_State",0);
        if recordInternationState == 0 then
            -- Log("TrackEvent mj_EnableInternation")
            PlayerPrefs.SetInt("Internation_State",1);
            BuryingPointMgr:TrackEvents("mj_EnableInternation", {})
        end
    end
end

function this.OnVersionSilentDownloadError()
    if this.enableTrackEvent then
        this.enableTrackEvent = false
        local dialogData = {};
        dialogData.caller = self;
        dialogData.content = LanguageMgr:GetTips(1054);
        dialogData.okCallBack = function()        
            local _datas = {}        
                BuryingPointMgr:TrackEvents(ShiryuEventName.Unity_DownFile_MD5_Different_Quit, _datas)
            CSAPI.Quit();
        end
        CSAPI.OpenView("Prompt",dialogData);
        -- LogError("Send Event")
    end
end

function this.OnShowSilentDownloadSelect()
        
    local apkVer = tonumber(CSAPI.APKVersion())
    if apkVer == 7 then
        SilentDownloadMgr:IncreaseDownloadNum()
    end
    if this.hasPopSelectView then
        return
    end
    -- 在用户选择下载方案之前，弹窗可能会被弹起多次，这里仅显示一次弹窗，选择之前默认边玩边下载，不阻塞下载进程
    SilentDownloadMgr:SetDownloadMode(1)
    -- 如果玩家没有选择任意选项就退出游戏，下次进入游戏则不会再有弹窗，如果在这种情况下需要有弹窗，可以重置玩家的选择
    -- PlayerPrefs.SetInt("SilentDownloadMode", 0);

    local sizeMB = SilentDownloadMgr:GetInfo_DownloadSizeTotal() / 1024
    sizeMB = math.floor(sizeMB)
    local dialogdata = {
        okText = LanguageMgr:GetByID(16110),
        okText2 = "COMPLETE DOWNLOAD",
        cancelText = LanguageMgr:GetByID(16111),
        cancelText2 = "DOWNLOAD WHILE PLAYING",
        --content = "进入战斗失败，点击重试",
        -- content = "检测到有未下载的资源，点击确定开始静默下载，点击取消将为您边玩边下载",
        content = LanguageMgr:GetTips(9013),
        okCallBack = function()
            if CS.CSAPI.GetWiFiState() == true then
                -- 刷新静默下载状态
                SilentDownloadMgr:InitSilentDownloadState(true);
                SilentDownloadMgr:RefreshCurrentState(true)    
                if apkVer == 7 then PlayerPrefs.SetInt("SilentDownloadMode", 3); end                  
            else
                local dialogdata_ok = {
                    okText = LanguageMgr:GetByID(16115),
                    okText2 = "DOWNLOAD",
                    cancelText = LanguageMgr:GetByID(1002),
                    cancelText2 = "CANCEL",
                    --content = "进入战斗失败，点击重试",
                    -- content = "检测到不是wifi网络，是否继续下载？",
                    content = string.format(LanguageMgr:GetTips(9012), sizeMB),
                    okCallBack = function()                            
                        -- 刷新静默下载状态
                        SilentDownloadMgr:InitSilentDownloadState(true);
                        SilentDownloadMgr:RefreshCurrentState(true)
                        if apkVer == 7 then PlayerPrefs.SetInt("SilentDownloadMode", 3); end
                    end,
                    cancelCallBack = function()
                        CSAPI.Quit();
                    end
                }
                CSAPI.OpenView("Dialog", dialogdata_ok);     
            end            
        end,
        cancelCallBack = function()
            if CS.CSAPI.GetWiFiState() == true then                
                Tips.ShowTips(LanguageMgr:GetTips(9017));
                -- 边玩边下载
                SilentDownloadMgr:SetDownloadMode(1)
                if apkVer == 7 then PlayerPrefs.SetInt("SilentDownloadMode", 1); end
            else
                local dialogdata_cancel = {
                    okText = LanguageMgr:GetByID(16115),
                    okText2 = "DOWNLOAD",
                    cancelText = LanguageMgr:GetByID(1002),
                    cancelText2 = "CANCEL",
                    --content = "进入战斗失败，点击重试",
                    -- content = "检测到不是wifi网络，是否继续下载？",
                    content = string.format(LanguageMgr:GetTips(9012), sizeMB),
                    okCallBack = function()                                          
                        Tips.ShowTips(LanguageMgr:GetTips(9017));    
                        -- 边玩边下载
                        SilentDownloadMgr:SetDownloadMode(1)
                        if apkVer == 7 then PlayerPrefs.SetInt("SilentDownloadMode", 1); end
                    end,
                    cancelCallBack = function()
                        CSAPI.Quit();
                    end
                }
                CSAPI.OpenView("Dialog", dialogdata_cancel);
            end
        end
    }
    CSAPI.OpenView("Dialog", dialogdata);
    this.hasPopSelectView = true
end

function this:Clear()
    if tonumber(CSAPI.APKVersion()) >= 9 then
        EventMgr.RemoveListener(EventType.Version_SilentDownload_Error_MD5, OnVersionSilentDownloadError)
    end
    if tonumber(CSAPI.APKVersion()) > 6 then
        EventMgr.RemoveListener(EventType.Version_SilentDownload_Select, OnShowSilentDownloadSelect)
    end
end


return this
