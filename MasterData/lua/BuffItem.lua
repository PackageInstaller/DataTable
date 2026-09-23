
function Awake()
    txtRound = ComUtil.GetCom(goRound,"Text");  
    txtNum = ComUtil.GetCom(goNum,"Text");  
    action=ComUtil.GetCom(goRound,"ActionFade");
end

--设置Buff
function SetBuff(targetBuff)
    

    if(targetBuff == nil) then
        LogError("无法刷新buff，buff数据无效！！！");
    end
    --SetActionEnable(true)
    buff = targetBuff;
    local cfg = buff:GetCfg();
    local data = buff:GetData();
--    LogError("更新buff=============");
--    LogError(data);
--    LogError(cfg);
    ResUtil.IconBuff:Load(icon,cfg.icon);
    if(data)then
        if(goRoundNode)then
            CSAPI.SetGOActive(goRoundNode,data.round ~= nil);
        end

        if(txtRound and data.round)then
            txtRound.text = data.round .. "";
        else
            txtRound.text = "";
        end

        local nShieldCount = nil;
        if(data.nShieldCount)then
            nShieldCount = data.nShieldCount;
        elseif(data["OnCreate"])then
            for _,v in ipairs(data["OnCreate"])do
                if(v.nShieldCount)then
                    nShieldCount = v.nShieldCount;
                end
            end
        end

        local nCount = data.nCount;

        if(nShieldCount)then
            txtNum.text = nShieldCount .. "";
        elseif(nCount)then
            txtNum.text = nCount .. "";
        else
            txtNum.text = "";
        end
    end

    UpdateFlag(data.targetID);

    if(goId)then
        CSAPI.SetText(goId,data.uuid);
    end
end

function Remove()
    CSAPI.RemoveGO(gameObject);
end

function OnRecycle()
    Clear();
end

function Clear()
    buff = nil;
end

function SetActionEnable(isEnable)
    if(IsNil(action))then
        return;
    end
    if isEnable then
        action.enabled=true;
    else
        action.enabled=false;
        if canvasGroup==nil then
            canvasGroup=ComUtil.GetCom(goRound,"CanvasGroup");
        end
        canvasGroup.alpha=1;
    end
end

function UpdateFlag(characterId)
    local cfg = buff:GetCfg();
    local data = buff:GetData();
    --LogError("flag:" .. tostring(cfg.flag_key));
    if(cfg.flag_key and data.targetID == characterId)then
        --LogError("标志：" .. table.tostring(data));
        local character = CharacterMgr:Get(characterId);
        if(character)then
            local flagData = character.GetFlagData(cfg.flag_key);
            if(txtNum)then
                txtNum.text = (flagData and flagData.val > 0) and (flagData.val .. "") or "";
            end
        end
    end
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
icon=nil;
goRoundNode=nil;
goRound=nil;
goNum=nil;
goId=nil;
view=nil;
end
----#End#----