--技能设置界面


function SetData(setData)
    data = setData;

    if(not data)then
        return;
    end
    character = CharacterMgr:Get(data.id);
    local skillList = character and character.skillList;
    
    if(not skillList)then
        return;
    end
    
    local x,y,z = CSAPI.GetPos(data.posNode);
    CSAPI.SetPos(gameObject,x,y,z);

    --ClearItems();
    InitItems(skillList);
    ClearItems();

    SetShowState(true);      
end

function ClearItems()
    if(items)then
        local count = #items;
        for i = itemIndex,count do
            local index = count - i + itemIndex;
            local item = items[index];
            CSAPI.RemoveGO(item.gameObject);
            table.remove(items,index);
        end
    end
end

function InitItems(skillList)
    itemIndex = 1;
    
    local upgradeType = character and character.data and character.data.isUseCommon;
    
    for _,cfg in ipairs(skillList)do           
        --卡牌普通技能，非OverLoad，非被动     
        --if(cfg.main_type == SkillMainType.CardNormal and not SkillUtil:IsOverloadSkill(cfg.type) and cfg.type ~= SkillType.Passive and cfg.type ~= SkillType.Equip)then
        if(cfg.main_type == SkillMainType.CardNormal and not SkillUtil:IsOverloadSkill(cfg.upgrade_type) and cfg.type ~= SkillType.Passive and cfg.type ~= SkillType.Equip)then
            local item = InitItem(cfg);
            item.SetSelectState(cfg.upgrade_type == upgradeType);
        end
    end
end

function InitItem(cfg)    
    local lua = nil;

    if(items and #items >= itemIndex)then
        lua = items[itemIndex];
    else
        local itemGO = ResUtil:CreateUIGO("Skill/SkillSettingItem", itemNode.transform);
        lua = ComUtil.GetLuaTable(itemGO); 
        items = items or {};
        table.insert(items,lua);
    end

    itemIndex = itemIndex + 1;    
    
    lua.SetData({cfg=cfg,clickCallBack=OnClickItem});      

    return lua;
end

function OnClickItem(clickItem)
    if(items)then
        for _,item in ipairs(items)do
            
            if(item == clickItem)then
                local state = item.GetSelectState();
                local targetState = not state;
                item.SetSelectState(targetState);

                local itemData = item.GetData();
                local upgradeType = nil;
                if(targetState)then
                    upgradeType = itemData.cfg.upgrade_type;
                end
                SetCharacterSkillSetting(data.id,upgradeType);
            else
                item.SetSelectState(false);
            end
        end
    end
end

function SetCharacterSkillSetting(characterId,skillId)    
    if(characterId and g_FightMgr)then
        --LogError("角色ID" .. tostring(characterId) .. "，技能ID" .. tostring(skillId));
        g_FightMgr:SetSkillAI(characterId,skillId);
        if(character and character.data)then
            character.data.isUseCommon = skillId;
        end

        EventMgr.Dispatch(EventType.Fight_AI_Skill_Changed);
    end
end

function OnClickClose()   
    SetShowState(false);      
end



--设置显示状态
function SetShowState(state)      
    local playAction = showState ~= state;    

    showState = state;
    CSAPI.SetGOActive(hideNode,showState);    

    if(playAction)then
        if(showState)then
            CSAPI.ApplyAction(nodes,"Fade_In_Action");    
        else
            CSAPI.ApplyAction(nodes,"Fade_Out_100");    
        end

        CSAPI.MoveTo(nodes,"move_linear_local",showState and 0 or 2000,0,0);    
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
nodes=nil;
hideNode=nil;
itemNode=nil;
view=nil;
end
----#End#----