
local timer = 0
local slider = 0
local grids = nil
local data = nil
local isGetReward = nil

function Awake()    
    barProgress = ComUtil.GetCom(fillLv, "Image")
    slider= ComUtil.GetCom(numSlider, "Slider")
end

function OnOpen()
    CSAPI.SetText(txtDesc,LanguageMgr:GetByID(16112))
    ChangeViewState(0)
    InitReward();
    DownloadProto:CheckDownloadReward(CheckDownloadRewardCB)
end

function CheckDownloadRewardCB(proto)
    
    -- local percent = SilentDownloadMgr:GetInfo_CurrentDownloadProgressPecent()
    local apkVer = tonumber(CSAPI.APKVersion())
    local percent = apkVer <= 6 and 1 or SilentDownloadMgr:GetInfo_CurrentDownloadProgressPecent()
    isGetReward = proto.isGet
    --已经领取了奖励
    if isGetReward == true and percent >= 1 then
        -- LogError("已经领取过奖励了")        
        ChangeViewState(5)
    else
        if apkVer > 6 then            
            if SilentDownloadMgr:GetInitState() == false then
                ChangeViewState(1)
            end
        end
        UpdateSilentDownloadProgress()
    end
end

function GetDownloadRewardCB(proto)
    local isSuccess = proto.result
    --已经领取了奖励
    if isSuccess == false then
        LogError("领取失败")
    else
        -- Log("领取成功")
    end
    view:Close();
end

function Update()
    if (Time.time < timer) then return end
    timer = Time.time + 1

    -- local percent = SilentDownloadMgr:GetInfo_CurrentDownloadProgressPecent()
    -- LogError("当前下载进度 ： " .. percent .. "%" )
    -- if SilentDownloadMgr:GetInitState() == true then
    -- end
    UpdateSilentDownloadProgress()
end

function OnClickRewardBtn()
    DownloadProto:GetDownloadReward(GetDownloadRewardCB)    
    -- view:Close();
end

function OnClickMiniBtn()
    view:Close();
end

function OnClickDownloadBtn()
    SilentDownloadMgr:InitSilentDownloadState(true);
    SilentDownloadMgr:RefreshCurrentState(true)    
    if apkVer == 7 then PlayerPrefs.SetInt("SilentDownloadMode", 3); end
    ChangeViewState(3)
end
--- 0:默认状态 1:下载还没开始 2:按需下载中 3:自动下载中 4:下载结束未领取 5:下载结束已领取
---@param state any
function ChangeViewState(state)
    -- LogError("ChangeViewState " .. state)
    if state == 0 then
        slider.value = 0
        CSAPI.SetText(txtPercent,"0%")
        CSAPI.SetGOActive(btnReward, false)
        CSAPI.SetGOActive(btnMini, true)
        CSAPI.SetGOActive(btnDownload, false)
    elseif state == 1 then
        slider.value = 0
        CSAPI.SetText(txtPercent,"0%")
        CSAPI.SetGOActive(btnReward, false)
        CSAPI.SetGOActive(btnMini, true)
        CSAPI.SetGOActive(btnDownload, true)
    elseif state == 2 then
        CSAPI.SetGOActive(btnReward, false)
        CSAPI.SetGOActive(btnMini, true)
        CSAPI.SetGOActive(btnDownload, true)
    elseif state == 3 then
        CSAPI.SetGOActive(btnReward, false)
        CSAPI.SetGOActive(btnMini, true)
        CSAPI.SetGOActive(btnDownload, false)
    elseif state == 4 then
        slider.value = 1
        CSAPI.SetText(txtPercent,"100%")
        CSAPI.SetGOActive(btnReward, true)
        CSAPI.SetGOActive(btnMini, false)
        CSAPI.SetGOActive(btnDownload, false)
        -- CSAPI.SetGOActive(txtDesc, false)
        -- if progressTextRoot ~= nil then
        --     CSAPI.SetLocalPos(progressTextRoot.gameObject,0,30,0);
        -- end
        -- CSAPI.SetGOActive(txtDesc, true)
    elseif state == 5 then
        slider.value = 1
        CSAPI.SetText(txtPercent,"100%")
        CSAPI.SetGOActive(btnReward, false)
        CSAPI.SetGOActive(btnMini, true)
        CSAPI.SetGOActive(btnDownload, false)
        -- CSAPI.SetGOActive(txtDesc, false)
        -- if progressTextRoot ~= nil then
        --     CSAPI.SetLocalPos(progressTextRoot.gameObject,0,30,0);
        -- end

        -- CSAPI.SetGOActive(getObj, true)
        -- CSAPI.SetText(txtDesc,"已经领取过奖励了")
        -- CSAPI.SetText(txtDesc,LanguageMgr:GetByID(16118))
        -- CSAPI.SetGOActive(txtDesc, true)
    end

    if isGetReward then
        CSAPI.SetText(txtDesc,LanguageMgr:GetByID(16118))
        CSAPI.SetGOActive(txtDesc, true)
        CSAPI.SetGOActive(getObj, true)
    else
        CSAPI.SetText(txtDesc,LanguageMgr:GetByID(16112))
        CSAPI.SetGOActive(txtDesc, true)
        CSAPI.SetGOActive(getObj, false)
    end
end

function UpdateSilentDownloadProgress()
    local apkVer = tonumber(CSAPI.APKVersion())
    if apkVer <= 6 then
        ChangeViewState(isGetReward and 5 or 4)
        slider.value = 1
        CSAPI.SetText(txtPercent,"100%")
    elseif apkVer > 6 then
        local percent = SilentDownloadMgr:GetInfo_CurrentDownloadProgressPecent()
        if apkVer == 7 then
            -- 7.0版本的包下载进度会有异常，需要特殊处理
            if SilentDownloadMgr:GetInfo_DownloadSizeTotal() ~= 0 and SilentDownloadMgr:GetInfo_DownloadedSize() == 0 then
                percent = 0
            end
        end
        slider.value = percent
        local percentStr = string.format("%.2f", percent * 100)
        CSAPI.SetText(txtPercent,percentStr .. "%")
        
        if (percent == 1.0) then
            ChangeViewState(isGetReward and 5 or 4)
        else      
            ChangeViewState(SilentDownloadMgr:GetInitState() and 3 or 2)      
        end
        -- LogError("当前下载进度 ： " .. percent .. "%" )
    end
end
function InitReward()
    -- [11002,2,2]
    -- RefreshRewardData(g_DownloadReward)
    local cfg = Cfgs.global_setting:GetByID("g_DownloadReward")
    local valueTable=Json.decode(cfg["value"]);
    for i, cfgItem in ipairs(valueTable) do
        local _item = ResUtil:CreateUIGO("Grid/GridItem", hLayout.transform)
        -- _item.transform.localScale=UnityEngine.Vector3(1,1,1)
        local lua = ComUtil.GetLuaTable(_item)
        local data={{id=cfgItem[1],num=cfgItem[2],type=cfgItem[3]}}
        local dataNew=GridUtil.GetGridObjectDatas(data)
        lua.Refresh(dataNew[1]);        
        local result, clickCB = GridFakeData(data[1])
        lua.SetClickCB(clickCB)
    end
    
end