--复活界面

function Awake()
    LanguageMgr:SetText(goTitle,1087)--CSAPI.SetText(goTitle,StringConstant.fight_title_transform);
end

function OnOpen()
    if(data)then
        local character = CharacterMgr:Get(data);
        local transDatas = character.GetTransDatas();
        local transformState = character.GetTransformState();
       
        for _,transData in ipairs(transDatas)do
           if(transData.index ~= transformState)then
                local go = ResUtil:CreateUIGO("Fight/TransformerItem",itemNode.transform);
                local lua = ComUtil.GetLuaTable(go);                
                lua.Set(transData,OnClickItem);
            end
        end
    end
end

function OnClickItem(transData)   
    EventMgr.Dispatch(EventType.Input_Select_Transform_Target,transData);
    OnClickClose();  
end

--关闭
function OnClickClose()    
    view:Close();
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
goTitle=nil;
itemNode=nil;
view=nil;
end
----#End#----