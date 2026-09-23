function Awake()
    EventMgr.AddListener(EventType.Fight_Info_Update,OnFightInfoUpdate);
    EventMgr.AddListener(EventType.Character_Dead,OnCharacterDead);
end

function OnFightInfoUpdate(datas)
    local characterDatas = datas.characterDatas;
    if(characterDatas == nil)then
        return;
    end
    --LogError(characterDatas);
    for _,v in ipairs(characterDatas)do
        local character = CharacterMgr:Get(v.id);
        if(character ~= nil)then      
            if(v.xp ~= nil)then           
                character.UpdateXp(v.xp,v.maxxp);
            end  
            if(v.sp ~= nil)then
                character.UpdateSp(v.sp,v.maxsp);
            end           
        else
            LogError("更新角色信息失败，找不到目标角色==================");
            LogError(v);
        end
    end

end

function OnCharacterDead(id)
    --DebugLog("角色死亡" .. id);
end
