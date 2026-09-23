-- 扫荡编队组件
local state = nil
local grids={}
local dropClick = nil
local canvasGroup = nil
local teamData=nil;
local data = nil

function Awake()
    dropClick = ComUtil.GetCom(dropDownList, "Image");
    canvasGroup = ComUtil.GetCom(dropDownList, "CanvasGroup");
end

function Refresh(d)
    data = d;
    if data then
        local teamID = nil;
        if data.currState then
            SetState(data.currState);
        else
            SetState(data.state);
        end
        for k, v in ipairs(data.options) do
            if v.itemID == data.id then
                teamID = v.id;
                ShowDownListInfo(v);
                break
            end
        end
        if teamID ~= nil then
            CSAPI.SetText(dropVal, "0" .. teamID);
        else
            CSAPI.SetText(dropVal, "-");
        end
        SetTeamData(teamID);
    end
end

function SetState(_state)
    state = _state;
    local gridDisable = false;
    -- CSAPI.SetText(txt_teamTips,"请选择队伍");
    local alpha = 1;
    if grids and grids[6] then
        CSAPI.SetGOActive(grids[6].gameObject, false);
    end
    if state == TeamConfirmItemState.Normal then
        -- CSAPI.SetGOActive(grids[6].gameObject,true);
        -- grids[6].SetDisable(false);
        CSAPI.SetGOActive(gridNode, true);
        CSAPI.SetGOActive(btnSkill, true);
        CSAPI.SetGOActive(btnAI, true);
        CSAPI.SetText(txt_teamName, LanguageMgr:GetByID(25021));
        dropClick.raycastTarget = true;
        -- CSAPI.SetGOActive(dropDownList,true);
        CSAPI.SetGOActive(btnUse, data.showClean);
        CSAPI.SetGOActive(txt_fightTips, true);
        CSAPI.SetGOActive(txt_disable, false);
    elseif state == TeamConfirmItemState.Disable then
        -- CSAPI.SetGOActive(grids[6].gameObject,true);
        -- grids[6].SetDisable(false);
        CSAPI.SetGOActive(gridNode, false);
        CSAPI.SetGOActive(btnSkill, false);
        CSAPI.SetGOActive(btnAI, false);
        dropClick.raycastTarget = false;
        -- CSAPI.SetGOActive(dropDownList,false);
        CSAPI.SetGOActive(btnUse, false);
        CSAPI.SetText(dropVal, "—");
        CSAPI.SetText(txt_teamName, "——");
        CSAPI.SetGOActive(txt_fightTips, false);
        CSAPI.SetText(txt_disable, LanguageMgr:GetByID(25019));
        CSAPI.SetGOActive(txt_disable, true);
        alpha = 0.4;
        gridDisable = true;
    elseif state == TeamConfirmItemState.UnUse then
        -- CSAPI.SetGOActive(grids[6].gameObject,true);
        CSAPI.SetGOActive(gridNode, false);
        CSAPI.SetGOActive(btnSkill, false);
        dropClick.raycastTarget = false;
        -- CSAPI.SetGOActive(dropDownList,false);
        CSAPI.SetGOActive(btnUse, true);
        CSAPI.SetGOActive(btnAI, false);
        CSAPI.SetGOActive(txt_fightTips, false);
        CSAPI.SetText(dropVal, "—");
        CSAPI.SetText(txt_teamName, "——");
        CSAPI.SetText(txt_disable, LanguageMgr:GetByID(25020));
        CSAPI.SetGOActive(txt_disable, true);
        alpha = 0.4;
    elseif state == TeamConfirmItemState.UnAssist then
        -- grids[6].SetDisable(true);
        CSAPI.SetGOActive(gridNode, true);
        -- CSAPI.SetGOActive(grids[6].gameObject,false);
        CSAPI.SetGOActive(btnSkill, true);
        CSAPI.SetGOActive(btnAI, true);
        dropClick.raycastTarget = true;
        CSAPI.SetGOActive(txt_fightTips, true);
        CSAPI.SetText(dropVal, "—");
        CSAPI.SetText(txt_teamName, LanguageMgr:GetByID(25021));
        -- CSAPI.SetGOActive(dropDownList,true);
        CSAPI.SetGOActive(btnUse, data.showClean);
        CSAPI.SetGOActive(txt_disable, false);
    end
    canvasGroup.alpha = alpha;
    CheckModelOpen();
    if grids then
        for i = 1, 5 do
            if grids[i] then
                grids[i].SetDisable(gridDisable);
            end
        end
    end
end

function CheckModelOpen()
    local isOpen,lockStr=MenuMgr:CheckModelOpen(OpenViewType.main, FormationUtil.SkillModuleKey)
    local isOpen2,lockStr2=MenuMgr:CheckModelOpen(OpenViewType.special, FormationUtil.AIModuleKey)
    CSAPI.SetGOActive(sLockImg,isOpen~=true);
    CSAPI.SetGOActive(aLockImg,isOpen2~=true);
end

function SetTeamData(index)
    local skillId = nil
    if index ~= nil and type(index) == "number" then
        TeamMgr.currentIndex = index;
        if teamData then
            TeamMgr:DelEditTeam(index);
        end
        teamData = TeamMgr:GetEditTeam();
        -- RefreshFormationTab();
        skillId = teamData:GetSkillGroupID()
    else
        if teamData then
            TeamMgr:RemoveAssistTeamIndex(teamData:GetAssistID());
        end
        teamData = nil;
    end
    if teamData ~= nil then
        local haloStrength = teamData:GetHaloStrength();
        CSAPI.SetText(txt_fight, tostring(teamData:GetTeamStrength() + haloStrength));
    else
        CSAPI.SetText(txt_fight, tostring(0))
    end
    SetSkillIcon(skillId);
    CreateGrids(teamData, grids, gridNode, OnClickGrid);
end

--创建并显示格子信息
function CreateGrids(teamData, grids,parent, cb)
    for i=1,5 do
        local data=nil;
        if teamData then
            data=teamData:GetItemByIndex(i);
        end
        if i>#grids then
            ResUtil:CreateUIGOAsync("TeamConfirm/TeamConfirmGrid",parent,function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(data,i);
                lua.SetCB(cb);
                table.insert(grids,lua);
            end);
        else
            local lua=grids[i]
            lua.Refresh(data,i);
            lua.SetCB(cb);
        end
    end
end

function SetSkillIcon(cfgId)
    if cfgId==nil or cfgId==-1 then
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
        return
    end
    local tactice=TacticsMgr:GetDataByID(cfgId);
    if tactice then
        CSAPI.SetText(txtSkill,tactice:GetName());
        ResUtil.Ability:Load(skillIcon, tactice:GetIcon().."_1",false);
    else
        CSAPI.SetText(txtSkill,LanguageMgr:GetByID(26015))
        CSAPI.LoadImg(skillIcon,"UIs/TeamConfirm/btn_13_06.png",true,nil,true);
    end
end
--------------------------------下拉框
function ShowDownListInfo(option)
    if option and option.id ~= -1 then
        CSAPI.SetText(txt_teamName, tostring(option.name));
        CSAPI.SetText(dropVal, tostring(option.desc));
    elseif option.id == -1 then
        CSAPI.SetText(txt_teamName, LanguageMgr:GetByID(25021));
        CSAPI.SetText(dropVal, tostring("—"));
    end
end

function OnClickDownList() -- 点击下拉框
    local p1 = view.myParent:InverseTransformPoint(dropDownList.transform.position);
    local index = 1;
    local oNum = 1;
    if data then
        index = data.id;
        oNum = data.options and #data.options or 1;
    end
    local pos = UnityEngine.Vector3(p1.x, p1.y, 0);
    data.ShowDownList(pos, data.id, OnDropValChange, nil);
end

-- 下拉框的值改变之后
function OnDropValChange(option)
    ShowDownListInfo(option);
    if option.id == -1 then
        SetTeamData(nil);
    else
        SetTeamData(option.id);
    end
end

--------------------------------点击
function OnClickGrid(tab)
    if data.forceNPC~=nil then--强制上阵NPC时无法改变队员
        return;
    end
    if teamData==nil then
        Tips.ShowTips(LanguageMgr:GetTips(14008));
        return
    end
    local isAssist=false
    for k,v in ipairs(grids) do
        if v==tab then
            isAssist=k==6;
            break;
        end
    end
    local canAddAssist=GetState()~=TeamConfirmItemState.UnAssist
    -- TeamMgr.currentIndex=teamData:GetIndex();
    if isAssist then
        local cid=nil;
        SetTeamData(teamData:GetIndex());
        if assistData then
            cid=assistData.card:GetID();
        end
        CSAPI.OpenView("TeamView",{team=teamData,cid=cid,canEmpty=false,NPCList=data.NPCList,closeFunc=OnChange,selectType=TeamSelectType.Support,is2D=true,canAssist=canAddAssist},TeamOpenSetting.PVE);
    else
        SetTeamData(teamData:GetIndex());
        CSAPI.OpenView("TeamView",{team=teamData,canEmpty=false,NPCList=data.NPCList,closeFunc=OnChange,selectType=TeamSelectType.Normal,is2D=true,canAssist=canAddAssist},TeamOpenSetting.PVE);
    end
end

function GetState()
    return state;
end

--队员变更后
function OnChange(_assist)
    assistData=_assist;
    EventMgr.Dispatch(EventType.Team_Card_Refresh);
end

function GetTeamIndex()
    if teamData then
        return teamData.index
    else
        return nil;
    end
end

function GetTeamData()
    return teamData
end

function GetDuplicateTeamData()
    return TeamMgr:DuplicateTeamData(data.id,teamData);
end