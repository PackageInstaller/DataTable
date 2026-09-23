--复活界面

function Awake()
    LanguageMgr:SetText(goTitle,1086)--CSAPI.SetText(goTitle,StringConstant.fight_title_relive);

    local deads = GetReliveList();--CharacterMgr:GetDeadsByTeam(TeamUtil.ourTeamId);
    --LogError(deads);
    if(deads)then
        for id,deadData in pairs(deads)do
            local go = ResUtil:CreateUIGO("Fight/ReliveItem",itemNode.transform);
            local lua = ComUtil.GetLuaTable(go);                
            lua.Set(deadData,OnClickItem);
        end
    end

end

--获取复活列表
function GetReliveList()
    local deadDatas = g_FightMgr:GetDeathObj(TeamUtil.myNetTeamId);
    local deads = {};
    if(deadDatas)then
        for _,deadData in ipairs(deadDatas)do
            local cfgId = deadData.cfgid;
            local cfg = Cfgs.CardData:GetByID(cfgId) or Cfgs.MonsterData:GetByID(cfgId);
            if(cfg and not cfg.isRisen)then
                deads[deadData.oid] = {id = deadData.oid,cfgId = cfgId,teamId = TeamUtil.ourTeamId};
            end
        end        
    end

    return deads;
end

function OnClickItem(characterGoodsData)   
    selCharacterGoodsData = characterGoodsData;   
   
    local name = characterGoodsData and characterGoodsData.cfg.name or "";
	local dialogData =
	{
		content = string.format(LanguageMgr:GetByID(25004),name);
		okCallBack = OnSure;
	};
	CSAPI.OpenView("Dialog", dialogData);
     
end


function OnSure()
    if(not selCharacterGoodsData)then
        return;
    end
    EventMgr.Dispatch(EventType.Input_Select_Relive_Target,selCharacterGoodsData);
    CloseView(); 
end

--关闭
function OnClickClose()   
    EventMgr.Dispatch(EventType.Input_Select_Cancel);  
    CloseView();
end

function CloseView()
    if(not IsNil(view))then
        view:Close();
        view = nil;
    end
end