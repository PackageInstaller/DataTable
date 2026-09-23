--战斗前AI设置
local items = {}
local skillItems={};
local currItem=nil;--当前选择的队员物体
local configs={};--自动设置的配置，为nil为自动
local isAuto=false;
local ctrlData=nil;
local eventMgr=nil;
function Awake()
	for i = 1, 6 do
		ResUtil:CreateUIGOAsync("BattleAISetting/BattleAISetItem", grid, function(go)
			local lua = ComUtil.GetLuaTable(go)
			table.insert(items, lua)
		end)
	end
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.AIPreset_Use,OnUseAI);
end

function OnUseAI(eventData)
	-- if(ctrlData.nTeamID == nil) then
	-- 	LogError("缺少队伍id" .. table.tostring(ctrlData,true));
	-- 	return;
	-- end
	-- local teamData=TeamMgr:GetFightTeamData(ctrlData.nTeamID);
	-- if teamData then --刷新预设下标
	-- 	for k,v in ipairs(teamData.data) do
    --         if v:GetID()==eventData.cid then
    --             v:SetStrategyIndex(eventData.index);
    --         end
    --     end
	-- end
	-- RefreshGrids();
end

function Refresh(currCharacter)
    if(not currCharacter)then
        return;
    end
	data=currCharacter;
	ctrlData = currCharacter:GetData();
	if(ctrlData.nTeamID == nil) then
        LogError("缺少队伍id" .. table.tostring(ctrlData,true));
		return;
	end
	isAuto=FightClient:IsAutoFight();
	SetAutoStyle(isAuto)
   
	CSAPI.SetGOActive(skillObj,false);
	--获取队伍角色数据
	-- LogError(DungeonMgr:GetFightTeamId())
	-- LogError(ctrlData)
	RefreshGrids();
end 

function RefreshGrids()
	local teamData=TeamMgr:GetFightTeamData(ctrlData.nTeamID);
	-- LogError(teamData:GetData());
	if teamData then
		for k,v in ipairs(items) do
			local teamItem=teamData:GetItemByIndex(k);
			if teamItem then
				items[k].Refresh(teamItem,ctrlData);
			else
				items[k].SetNull();
			end
		end
	end
end

function SetAutoStyle(isOn)
	CSAPI.SetGOActive(onObj,isOn);
	CSAPI.SetGOActive(offObj, not isOn);
end

function OnClickAuto()
	isAuto=not isAuto;
	SetAutoStyle(isAuto);
    FightClient:SetAutoFight(isAuto);
end

function OnClickSetting()
	-- Tips.ShowTips("暂未开放");
	-- local dungeonCfg=Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
	-- CSAPI.OpenView("BattleStrategy",{teamMax=BattleMgr:GetTeamCount(),isBattle=true});
	local teamData=TeamMgr:GetFightTeamData(ctrlData.nTeamID);
	CSAPI.OpenView("AIPrefabSetting",{teamData=teamData,oid=ctrlData.oid,dupType=1},2);
end

function OnDestroy()    
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txtTitle=nil;
autoObj=nil;
txtOpen=nil;
onObj=nil;
offObj=nil;
btnSetting=nil;
grid=nil;
view=nil;
end
----#End#----