local cfg = nil
local sTime,eTime = 0,0
local jumpState = 1

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        SetTitle()
        SetIcon()
        SetTime()
        SetButton()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle,cfg.name)
end

function SetIcon()
    if cfg.icon then
        ResUtil.Summary:Load(icon,cfg.icon)
    end
end

function SetTime()
    if cfg.sTime and cfg.eTime then
        sTime=TimeUtil:GetTimeStampBySplit(cfg.sTime)
        eTime=TimeUtil:GetTimeStampBySplit(cfg.eTime)
        local tab1 = TimeUtil:GetTimeHMS(sTime)
        local tab2 = TimeUtil:GetTimeHMS(eTime)
        CSAPI.SetText(txtTime,string.format("%s%s%s%s-%s%s%s%s%s:%s",tab1.month,LanguageMgr:GetByID(16049),
        tab1.day,LanguageMgr:GetByID(16050),tab2.month,LanguageMgr:GetByID(16049),tab2.day,
        LanguageMgr:GetByID(16050),tab2.hour,tab2.min < 10 and "0"..tab2.min or tab2.min))
    end
end

function SetButton()
    if sTime>0 and eTime>0 then
        local languageId = 0
        local imgName = "btn_01_0"
        local alpha = 1
        if TimeUtil:GetTime() > sTime and TimeUtil:GetTime() <= eTime then
            jumpState = 1
            languageId = 6012
            imgName = imgName .. 1
        elseif TimeUtil:GetTime() <= sTime then
            jumpState = 2
            languageId = 15028
            imgName = imgName .. 2
            alpha = 0.7
        elseif TimeUtil:GetTime() > eTime then
            jumpState = 3
            languageId = 39002
            imgName = imgName .. 2
        end
        CSAPI.LoadImg(btnJump,"UIs/Activity7/"..imgName..".png",true,nil,true)
        CSAPI.SetGOAlpha(btnJump,alpha)
        LanguageMgr:SetText(txtState,languageId)
    end
end

function OnClickJump()
    if not cfg then
        return 
    end

    if jumpState > 1 then
        LanguageMgr:ShowTips(jumpState == 2 and 47004 or 47001)
        return
    end

    if cfg.commodity then
        local comm = ShopMgr:GetFixedCommodity(cfg.commodity)
        if not comm:IsOver() and ShopCommFunc.CheckCanPay(comm,1) then
            if comm:GetBuyLimitType() == ShopBuyLimitType.PlrLv and comm:GetBuyLimitVal() and PlayerClient:GetLv() >= comm:GetBuyLimitVal() then
                ShopCommFunc.OpenPayView2(comm:GetID())
                return
            end
        end
    end

    if cfg.jumpId then
        JumpMgr:Jump(cfg.jumpId)
    end
end