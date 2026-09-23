local isGet = false
local isFinish = false

function Awake()
    m_Slider = ComUtil.GetCom(Slider, "Slider")
    cg_node = ComUtil.GetCom(node, "CanvasGroup")
end

function Refresh(_data, _isMax)
    if (_data) then
        data = _data
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        isMax = _isMax -- 如果当天/周奖励已经全部领取

        -- isShowBg1 =(not isMax and isFinish and not isGet) and true or false

        SetNode()
        SetDesc(data:GetDesc())
        SetCount(data:GetCnt(), data:GetMaxCnt())
        SetBtn()
        SetStar()
    end
end

function SetNode()
    local alpha = 1
    if (isMax or isGet) then
        alpha = 0.38
    end
    cg_node.alpha = alpha
end

function SetDesc(str)
    -- CSAPI.SetTextColorByCode(txtDesc, not isFinish and not isGet and "ffffff" or "000000")
    -- CSAPI.SetTextColorByCode(txtDesc, isShowBg1 and "000000" or "ffffff")
    CSAPI.SetText(txtDesc, str)
end

function SetCount(cur, max)
    local str = cur .. " / " .. max
    CSAPI.SetText(txtCount, str)

    m_Slider.value = (max ~= nil and max ~= 0) and cur / max or 0
end

function SetBtn()
    -- red
    local isAdd = false
    --
    CSAPI.SetGOActive(success, isGet)
    -- if (isMax) then
    --     CSAPI.SetGOActive(btn, false)
    -- else
    local btn1_b, btnBg1_b, btnBg2_b = false, false, false
    if (not isGet) then
        if (isFinish) then
            btn1_b = true
            btnBg1_b = true
            isAdd = true
        else
            if (data:GetJumpID() ~= nil) then
                btn1_b = true
                btnBg2_b = true
            end
        end
    end
    CSAPI.SetGOActive(btn, btn1_b)
    CSAPI.SetGOActive(btnBg1, btnBg1_b)
    CSAPI.SetGOActive(btnBg2, btnBg2_b)

    LanguageMgr:SetText(txtBtn1, isFinish and 6011 or 6012)
    LanguageMgr:SetEnText(txtBtn2, isFinish and 6011 or 6012)
    LanguageMgr:SetText(txtSuccess1, isGet and 6013 or 6017)
    LanguageMgr:SetEnText(txtSuccess2, isGet and 6013 or 6017)
    -- end
    local b = false
    if (isAdd and not isMax) then
        b = true
    end
    UIUtil:SetRedPoint(node, b, 429, 66, 0)
end

function SetStar()
    local star = data:GetStarCount() or 0
    CSAPI.SetText(txtStar, "x" .. star)
    CSAPI.SetText(txtStar2, "x" .. star)
end

function OnClick()
    if (data and not isGet and not isMax) then
        if (isFinish) then
            if (MissionMgr:CheckIsReset(data)) then
                -- LanguageMgr:ShowTips(xxx)
                LogError("任务已过期")
            else
                MissionMgr:GetReward(data:GetID())
                if CSAPI.IsADV() or CSAPI.IsDomestic() then BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_DAILYTASK_FINISH); end
            end
        else
            if (data:GetJumpID()) then
                JumpMgr:Jump(data:GetJumpID())
            end
        end

    end
end

