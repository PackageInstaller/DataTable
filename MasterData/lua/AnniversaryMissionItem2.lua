local data = nil
local slider = nil

function Awake()
    slider = ComUtil.GetCom(Slider, "Slider")
end

function Refresh(_data)
    data = _data
    if data then
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        CSAPI.SetGOAlpha(node,isGet and 0.5 or 1)
        SetDesc()
        SetNum()
        SetStar()
        SetBtn()
    end
end

function SetDesc()
    CSAPI.SetText(txtDesc, data:GetDesc())
end

function SetNum()
    local cur, max = data:GetCnt(), data:GetMaxCnt()
    CSAPI.SetText(txtCount, cur .. "/" .. max)
    slider.value = cur / max
end

function SetStar()
    local cfg = data:GetCfg()
    CSAPI.SetText(txtStar, "x" .. (cfg.nAnniversaryStar or 0))
    CSAPI.SetText(txtStar2, "x" .. (cfg.nAnniversaryStar or 0))
end

function SetBtn()
    CSAPI.SetGOActive(btn, (not isGet and (isFinish or data:GetJumpID() ~= nil)))
    CSAPI.SetGOActive(success, isGet)
    if (isFinish or (not isGet and data:GetJumpID() ~= nil)) then
        CSAPI.SetGOActive(btnBg1, isFinish)
        CSAPI.SetGOActive(btnBg2, not isFinish)

        LanguageMgr:SetText(txtBtn1, isFinish and 6011 or 6012)
        LanguageMgr:SetEnText(txtBtn2, isFinish and 6011 or 6012)
    end

    local b = isFinish and not isGet and true or false
    UIUtil:SetRedPoint(node, b, 720, 60, 0)
end

function OnClick()
    if (data) then
        if (not isGet and isFinish) then
            MissionMgr:GetReward(data:GetID())
        elseif (not isGet and not isFinish) then
            if (data:GetJumpID()) then
                JumpMgr:Jump(data:GetJumpID())
            end
        end
    end
end
