function Awake()
    anim = ComUtil.GetCom(icon,"Animator")
end

function Refresh(id, _successDic)
    local foolCfg = Cfgs.CfgFood:GetByID(id)
    local isSuccess = _successDic[id]~=nil
    -- icon 
    ResUtil.Coffee:Load(icon, foolCfg.icon)
    -- tick 
    CSAPI.SetGOActive(tick, isSuccess)
end


function SetDD()
    anim:SetTrigger("Incorrect")
end