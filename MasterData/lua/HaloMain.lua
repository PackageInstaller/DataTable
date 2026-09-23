--光环主界面
local top=nil;
local eventMgr=nil;
local haloInfo=nil;
local formationView=nil;
local haloStrength=nil;
local roleCardGrid=nil;
local cardData=nil;
local teamData=nil;
local posInfo={2,2};
local isList=false;
local listView=nil;
local isFirst=true;

function Awake()
    top=UIUtil:AddTop2("HaloMain",gameObject,OnClickClose);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Halo_RoleSelected_Change,OnSelectedRoleChange)
    eventMgr:AddListener(EventType.Halo_Upgrade_Ret,OnUpgradeRet)
    eventMgr:AddListener(EventType.Card_Update,OnCardUpdate)
    -- eventMgr:AddListener(EventType.Card_Update,OnCardUpdate)
end

function OnDestroy()
    eventMgr:ClearListener();
end

--data:CharacterCardsData
function OnOpen()
    cardData=data;
    Refresh(isList)
    isFirst=false;
end

function Refresh(_isList)
    if cardData then
        teamData=nil;
        teamData=TeamData.New();
        local coord=cardData:GetCurCoordPos();
        if coord then
            posInfo=coord[1]
        end
        teamData:AddCard({
            cid=cardData:GetID(),
            row=posInfo[1],
            col=posInfo[2],
            index=1
        })
    end
    SetRightState(_isList)
    if haloInfo==nil then
        ResUtil:CreateUIGOAsync("Halo/HaloInfo",leftNode,function(go)
            haloInfo=ComUtil.GetLuaTable(go);
            haloInfo.Refresh(cardData);
            CSAPI.SetAnchor(go,0,0);
        end);
    else
        haloInfo.Refresh(cardData);
    end
    if roleCardGrid==nil then
        ResUtil:CreateUIGOAsync("RoleLittleCard/RoleLittleCard",bottomGrid,function(go)
            roleCardGrid=ComUtil.GetLuaTable(go);
            roleCardGrid.Refresh(cardData);
            roleCardGrid.SetFormation(nil,true)
        end);
    else
        roleCardGrid.Refresh(cardData);
    end
    if formationView==nil then
        ResUtil:CreateUIGOAsync("Formation/FormationView3D",node,function(go)
            formationView=ComUtil.GetLuaTable(go);
            formationView.Init(teamData,false);
            -- formationView.SetLock(true,true);
            formationView.SetScale(0.75);
            formationView.SetRotateAndZoom(false,false)
            formationView.SetLocalPos(200,58.4);
            formationView.clickID=teamData:GetLeaderID()
            local posInfo=formationView.GetHaloRange(posInfo[1],posInfo[2]);
            formationView.SetGridsStyle(posInfo);
        end);
    else
        formationView.CleanCache();
        formationView.Init(teamData,false);
        formationView.SetIsDrag(false);
        formationView.SetRotateAndZoom(false,false)
        -- formationView.SetLock(true,true);
        formationView.clickID=teamData:GetLeaderID()
        local posInfo=formationView.GetHaloRange(posInfo[1],posInfo[2]);
        formationView.SetGridsStyle(posInfo);
    end
end 

function OnClickClose()
    view:Close();
end

function SetRightState(_isList)
    isList=_isList;
    CSAPI.SetGOActive(rightNode,not isList)
    CSAPI.SetGOActive(listNode,isList)
    CSAPI.SetGOActive(mask,isList);
    CSAPI.SetGOActive(mask1,isList);
    if not isList then
        if haloStrength==nil then
            ResUtil:CreateUIGOAsync("Halo/HaloMainRight",rNode,function(go)
                haloStrength=ComUtil.GetLuaTable(go);
                haloStrength.SetData(cardData);
                CSAPI.SetAnchor(go,0,0);
            end);
        else
            haloStrength.SetData(cardData);
        end
    else
        if listView==nil then
            ResUtil:CreateUIGOAsync("Halo/HaloRoleList",lNode,function(go)
                listView=ComUtil.GetLuaTable(go);
                listView.SetData(cardData);
                CSAPI.SetAnchor(go,0,0);
            end);
        else
            listView.SetData(cardData);
        end
    end
    if isFirst~=true then
        CSAPI.SetGOActive(switch1,isList);
        CSAPI.SetGOActive(switch2,not isList);
    end
end

--切换角色选择方式，显示角色列表
function OnClickRoleList()
    SetRightState(true)
end

function OnSelectedRoleChange(eventData)
    if eventData then
        local card=FormationUtil.FindTeamCard(eventData)
        if card then
            data=card;
            cardData=card;
            Refresh(false);
        end
    end
end

function OnUpgradeRet(eventData)
    if eventData and eventData.info then
        local info=HaloData.New();
        info:SetData(eventData.info);
        local oldInfo=cardData:GetHaloInfo();
        if info:GetLv()>oldInfo:GetLv() then
            CSAPI.OpenView("HaloUpgrade",{oldInfo=oldInfo,newInfo=info,card=cardData});
        end
    end
end

function OnCardUpdate(eventData)
    if eventData and (eventData.cid==cardData:GetID()) then
        cardData=FormationUtil.FindTeamCard(eventData.cid)
        Refresh(isList);
    elseif eventData and eventData.proto~=nil and eventData.cid==nil then
        cardData=FormationUtil.FindTeamCard(cardData:GetID())
        Refresh(isList);
    end
end

function OnClickMask()
    if isList and listView then
        Refresh(false);
    end
end