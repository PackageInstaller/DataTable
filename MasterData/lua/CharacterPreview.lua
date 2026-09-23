local arr = 
{
"amelia_kit",
"andeliya",
"ares",
"athena",
"bennie_buck",
"berthe_petit",
--"blood_warlock",
"carrie_grange",
--"chimera",
"conductor",
"debby_mana",
"dominuo_mask",
"dorothy_harmony",
"double_guns",
"gram",
"hana_el",
"hera",
"hero",
"heroine",
"jucca_juspian",
"king_thunder",
"lisha_s_yege",
"liz_drygen",
"martina",
"martina_kotz",
"martinaT",
"meiqiaoer",
"monica_seles",
"niccolo_paganini",
"nicole_Isabel",
"norah_zero",
"poseidon",
"Robilita_Albera",
"sakai_rei",
"summon_robot1",
"tara_yale",
"tina_Gibson",
"victoria_winslow",
"vivien_bloomfield",
"ximera",
"zeus",
};

function Awake()
    for k,v in ipairs(arr)do
        local go = ResUtil:CreateUIGO("Common/CharacterPreviewItem",node.transform);
        go.name = v;

--        local x = (k - 1) % 10;
--        local y = math.floor((k - 1) / 10);

--        CSAPI.SetAnchor(go,x * 200,y * -100);

        local lua = ComUtil.GetLuaTable(go);
        lua.SetCallBack(OnItemCallBack);
    end
end

function OnItemCallBack(go)
    Show(go.name);
    CSAPI.SetGOActive(bg,false);
end

function Start()
    Show(arr[1]);
end

function Show(characterName)
    if(lastCharacter)then
        CSAPI.RemoveGO(lastCharacter);
        lastCharacter = nil;
    end

    ResUtil:LoadCharacterRes(characterName .. "/" .. characterName,0,0,0,nil,OnResLoaded);
end

function OnResLoaded(go)
    lastCharacter = go;
    CSAPI.SetAngle(go,0,90,0);

    _G.characterPreviewCamera:SetFollowTarget(go);
end

function OnClickSelect()
    CSAPI.SetGOActive(bg,true);
end

function OnClickBG()
    CSAPI.SetGOActive(bg,false);
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
bg=nil;
node=nil;
view=nil;
end
----#End#----