
function Awake()
    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do
            OnCharacterCreate(character);
        end
    end
end

function OnInit()
    InitListener();  
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Character_Create,OnCharacterCreate); 
end
function OnDestroy()
    eventMgr:ClearListener();
end

--创建角色
function OnCharacterCreate(character)
    local go = ResUtil:CreateUIGO("Fight/CharacterInfoItem",nodes.transform);
    local item = ComUtil.GetLuaTable(go);
    item.Set(character);  
end