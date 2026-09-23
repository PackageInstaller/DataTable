local info = nil
local sTime,eTime = 0,0
local isLock = false

function Refresh(_info)
    info = _info
    if info then
        SetTime()    
        SetTitle()
        SetIcon()
        SetLock()
    end
end

function SetTitle()
    CSAPI.SetText(txtName,info.name)
end

function SetIcon()
    if info.icon then
        ResUtil.Summary:Load(icon,"1/" .. info.icon)
    end
end

function SetTime()
    if info.sTime and info.eTime then
        sTime=TimeUtil:GetTimeStampBySplit(info.sTime)
        eTime=TimeUtil:GetTimeStampBySplit(info.eTime)
        local tab1 = TimeUtil:GetTimeHMS(sTime)
        local tab2 = TimeUtil:GetTimeHMS(eTime)
        if info.isHideEnd then
            CSAPI.SetGOActive(timeObj2,false)
            CSAPI.SetText(txtTime1,GetStr(tab1.month).."/"..GetStr(tab1.day))
            CSAPI.SetText(txtTime3,GetStr(tab1.hour)..":".. GetStr(tab1.min))
        else
            CSAPI.SetGOActive(timeObj2,true)
            CSAPI.SetText(txtTime1,GetStr(tab1.month).."/"..GetStr(tab1.day))
            CSAPI.SetText(txtTime2,GetStr(tab2.month).."/"..GetStr(tab2.day))
            CSAPI.SetText(txtTime3,GetStr(tab1.hour)..":".. GetStr(tab1.min))
            CSAPI.SetText(txtTime4,GetStr(tab2.hour)..":".. GetStr(tab2.min))
        end
    end
end

function GetStr(i)
    return i < 10 and "0" .. i or i
end

function SetLock()
    isLock = sTime>0 and TimeUtil:GetTime() <= sTime
    CSAPI.SetGOActive(lockObj,isLock)
end

function OnClickJump()
    if not info then
        return 
    end

    if isLock then
        LanguageMgr:ShowTips(47004)
        return
    end

    if info.commodity then
        local comm = ShopMgr:GetFixedCommodity(info.commodity)
        if not comm:IsOver() and ShopCommFunc.CheckCanPay(comm,1) then
            if comm:GetBuyLimitType() == ShopBuyLimitType.PlrLv and comm:GetBuyLimitVal() and PlayerClient:GetLv() >= comm:GetBuyLimitVal() then
                ShopCommFunc.OpenPayView2(comm:GetID())
                return
            end
        end
    end

    if info.jumpId then
        JumpMgr:Jump(info.jumpId)
    end
end