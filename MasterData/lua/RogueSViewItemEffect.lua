function Awake()
    animator = ComUtil.GetCom(gameObject, "Animator")
end

function SetState(_data, isSelect, index)
    data = _data
    -- 常规
    local isPass = data:IsPass()
    CSAPI.SetGOActive(icon14, isPass)
    CSAPI.SetGOActive(icon14easy, not isPass)
    CSAPI.SetGOActive(icon17, not isPass)
     
    CSAPI.SetGOActive(level_icon07, not isPass)
    CSAPI.SetGOActive(level_icon16, isPass)

    -- 选中 
    SetSelect(isSelect)

    -- 动画 
    local animName = data:GetCfg().nType == 1 and "level_easy_loop" or "level_hard_loop"
    animator:Play(animName)

    -- num
    local iconName1 = "img_" .. index .. "_h"
    ResUtil.RogueSNum:Load(UI_old, iconName1, true)
    local iconName2 = "img_" .. index
    ResUtil.RogueSNum:Load(UI_new, iconName2, true)
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(bg, isSelect)
    CSAPI.SetGOActive(switch01, isSelect)
    CSAPI.SetGOActive(particle, isSelect)
    CSAPI.SetGOActive(arrow, isSelect)
end

function CheckUnLock()
    if (data:CheckIsUnLock()) then
        data:SetIsUnLock(false)
        local animName = data:GetCfg().nType == 1 and "level_easy_unlock" or "level_hard_unlock"
        FuncUtil:Call(function()
            animator:Play(animName)
        end, nil, 100)

    end
end
