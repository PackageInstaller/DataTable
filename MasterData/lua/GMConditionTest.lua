local inputID=nil;
local inputCond=nil;
local items={};
local cond=nil;
local teamData=nil;
local isTrueCard=true;
function Awake()
    inputCond = ComUtil.GetCom(input_cond, "InputField");
    inputID = ComUtil.GetCom(input_id, "InputField");
    -- inputCond.text="3,20,16"
    -- inputCond.text="120010|120020"
    -- inputCond.text="498011,199013,230050"--必须编入总队长、禁止编入治疗角色,队伍人数只能三个
    -- inputCond.text="110040,120010";
    -- inputCond.text="120020|120030"; --只能编入乐团或者不朽的角色
    -- inputCond.text="170500";
    -- inputCond.text="121000000300";--品质大于等于R3
    -- inputCond.text="121100100300";--品质小于等于R3
    -- inputCond.text="121205205000";--总等级大于50
    -- inputCond.text="310063"--必须编入1个携带穿甲芯片的角色
    -- inputCond.text="329020020211"--最多编入1个携带切割芯片的角色
    -- inputCond.text="121305305000";--总等级小于50
    inputCond.text="170400,121000000500|121204204000"
    inputID.text="50010";
    -- inputID.text="";
    teamData=GetTeamData();
    -- LogError(teamData:GetData())
end

function GetTeamData()
    -- local d={
    --     index = 1,
    --     leader = 10040,
    --     name = FormationUtil.GetDefaultName(1),
    --     data = {
    --         -- {
	-- 		-- 	cid = 10040,
	-- 		-- 	row = 1,
	-- 		-- 	col = 1,
	-- 		-- 	index =1,
	-- 		-- 	isLeader=true,
	-- 		-- },
    --         -- {
	-- 		-- 	cid = 10010,
	-- 		-- 	row = 2,
	-- 		-- 	col = 2,
	-- 		-- 	index =2,
	-- 		-- }
    --     },
    -- }
    -- local team=TeamData.New();
    -- team:SetData(d)
    local team=TeamMgr:GetTeamData(1,true);
    return team;
end

function OnClickClose()
  CSAPI.SetGOActive(gameObject,false)
end

--验证
function OnClick()
    local condStr=nil;
    local id=nil;
    if inputCond.text~=nil and inputCond.text~="" then
        condStr=inputCond.text;
    end
    if inputID.text~=nil and inputID.text~="" then
        id=inputID.text;
    end
    if condStr==nil then
        LogError("条件不得为空！");
        return
    end
    cond=TeamCondition.New();
	cond:Init(condStr)
    local list={};
    if isTrueCard then
        if id==nil then
            for k,card in pairs(RoleMgr:GetDatas()) do
                local result,eCode=cond:CheckCard(teamData,card)
                if result then
                    table.insert(list,card);
                end
                LogError(card:GetCfgID().."\t"..card:GetName().."\t"..tostring(result).."\t"..tostring(eCode~=nil and LanguageMgr:GetByID(eCode) or "无").."\t"..tostring(eCode))
            end
        else
            local card=RoleMgr:GetData(tonumber(id));
            if isTrueCard then
                local teamItem=TeamItemData.New();
                local tempData = {
                    cid = card:GetID(),
                    row = 1,
                    col = 1,
                    index=teamData:GetRealCount()+1,
                }
                teamItem:SetData(tempData);
                teamData:AddCard(teamItem);
            end
            if card~=nil then
                local isOK,eCode=cond:CheckCard(teamData,card) 
                if isOK then
                    table.insert(list,card);
                end
                LogError(card:GetCfgID().."\t"..card:GetName().."\t"..tostring(result).."\t"..tostring(eCode~=nil and LanguageMgr:GetByID(eCode) or "无").."\t"..tostring(eCode))
            end
        end
    else
        if id==nil then
            for k,v in pairs(Cfgs.CardData:GetAll()) do
                if v.get_from_gm then
                    local card=RoleMgr:GetFakeData(v.id);
                    local result,eCode=cond:CheckCard(teamData,card)
                    if result then
                        table.insert(list,card);
                    end
                    LogError(card:GetCfgID().."\t"..card:GetName().."\t"..tostring(result).."\t"..tostring(eCode~=nil and LanguageMgr:GetByID(eCode) or "无").."\t"..tostring(eCode))
                end
            end
        else
            local card=RoleMgr:GetFakeData(tonumber(id));
            if card~=nil then
                local isOK,eCode=cond:CheckCard(teamData,card) 
                if isOK then
                    table.insert(list,card);
                end
                LogError(card:GetCfgID().."\t"..card:GetName().."\t"..tostring(result).."\t"..tostring(eCode~=nil and LanguageMgr:GetByID(eCode) or "无").."\t"..tostring(eCode))
            end
        end
    end
    
    LogError("编队数据："..tostring(cond:CheckPass(teamData)));
    Output(list);
end

function Output(list)
    local num=0;
    if list~=nil then
        num=#list;
    end
    local realNum=num>=#items and num or #items;
    for i=1,realNum do
        local lua=#items>=i and items[i] or nil;
        if lua~=nil then
            if i>num then
                lua.Hide();
            else
                lua.Show(list[i]);
            end
        elseif i<=num then
            ResUtil:CreateUIGOAsync("GMConditionTestItem", Content,function(go)
                lua=ComUtil.GetLuaTable(go)
                lua.Show(list[i]);
                table.insert(items,lua);
            end)
        end
    end
end