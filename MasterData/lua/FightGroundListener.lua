
function Awake()
    --EventMgr.AddListener(EventType.Scene_Load_Complete,OnSceneLoadComplete);
    EventMgr.AddListener(EventType.Character_Removed,OnCharacterRemoved);    
end

----�����������
--function OnSceneLoadComplete(param)
--    --Log(param.id);
--    if(param ~= nil) then
--       local cfgScene = Cfgs.scene:GetByID(param);
--       FightGroundMgr:Init(cfgScene.fight_ground_key);    
--    end
--end

--��ɫ�Ƴ�
function OnCharacterRemoved(character)
    if(character)then
        FightGroundMgr:PutOut(character);
    end
end