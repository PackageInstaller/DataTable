
function Awake()
    tmRound = ComUtil.GetCom(goRound,"TextMesh");  
end

--设置Buff
function SetBuff(targetBuff)
    if(targetBuff == nil) then
        LogError("无法刷新buff，buff数据无效！！！");
    end
    
    buff = targetBuff;
    local cfg = buff:GetCfg();
    local data = buff:GetData();

    ResUtil.IconBuff:LoadSR(icon,cfg.icon);
    CSAPI.SetGOActive(goRoundNode,data.round~= nil);
    if(data.round ~= nil)then
        tmRound.text = data.round .. "";
    end
end
--获取Buff
function  GetBuff()
    return buff;
end

function Remove()
    CSAPI.RemoveGO(gameObject);
end