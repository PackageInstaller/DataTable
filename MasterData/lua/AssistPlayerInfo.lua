--支援玩家信息界面 data:好友id
local eventMgr=nil;
local items={};
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Friend_Find,FindRet)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnOpen()
    if data then
        local fData=FriendMgr:GetData(data.uid);
        if fData  then
            Refresh(fData)
        else
            FriendMgr:Search("#".. data.uid) --获取好友信息
        end
    end
end


function FindRet(proto)
    if proto and data and #proto.info>=1 and proto.info[1].uid==data.uid then
        local d = FriendInfo.New()
        d:InitData(proto.info[1])
        Refresh(d)
    end
end

function Refresh(d)
    if d then
            -- local cfgModel = Cfgs.character:GetByID(d:GetIconId());
            -- if cfgModel then
            --     ResUtil.RoleCard:Load(icon,cfgModel.icon);
            -- end
            UIUtil:AddHeadByID(border,0.8,d:GetFrameId(),d:GetIconId());
            --计算最近登陆时间
            if d:IsOnLine() then
                CSAPI.SetText(txt_time,LanguageMgr:GetByID(26028));
            else
                local timer = TimeUtil:GetTime() - d.last_save_time
                local tab = TimeUtil:GetTimeTab(timer)
                local timeStr=""
                if(tab[1] > 0) then
                    local day=tab[1]>=7 and 7 or tab[1]
                    timeStr= LanguageMgr:GetTips(6006, day)
                elseif(tab[2] > 0) then
                    timeStr= LanguageMgr:GetTips(6007, tab[2])
                else
                    tab[3] = tab[3] <= 0 and 1 or tab[3]
                    timeStr= LanguageMgr:GetTips(6008, tab[3])
                end
                CSAPI.SetText(txt_time,LanguageMgr:GetByID(26029,timeStr));
            end
            SetState(d:GetState())
            CSAPI.SetText(txt_lv,tostring(d.level));
            CSAPI.SetText(txt_name,d:GetName());
            if d:GetSign()~=nil and d:GetSign()~="" then
                CSAPI.SetText(txt_desc,"");
                -- CSAPI.SetText(txt_desc,d:GetSign());
            else
                CSAPI.SetText(txt_desc,"");
                -- CSAPI.SetText(txt_desc,LanguageMgr:GetByID(26025));
            end
            local list=FriendMgr:GetAssistCardByUID(d:GetUid());
            CreateGrids(list);
    end
end

function SetState(state)
    if state==eFriendState.Pass then
        CSAPI.SetGOActive(btnOK,false);
        CSAPI.SetGOActive(txt_state,true);
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(26027));
    elseif state==eFriendState.Waiting or state==eFriendState.Apply then
        CSAPI.SetGOActive(btnOK,false);
        CSAPI.SetGOActive(txt_state,true);
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(26026));
    else
        CSAPI.SetGOActive(btnOK,true);
        CSAPI.SetGOActive(txt_state,false);
    end
end

function CreateGrids(list)
    for i=1,g_AssitTeamMaxCnt do
        local d=nil;
        if list and i<=#list then
            d=list[i];
        end
        if items and i>#items then
            ResUtil:CreateUIGOAsync("RoleLittleCard/RoleLittleCard",layout,function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(d,{key="AssistPlayerInfo"});
                lua.SetClickCB(OnClickItem);
                table.insert(items,lua);
            end)
        elseif items then
            items[i].Refresh(d,{key="AssistPlayerInfo"});
            items[i].SetClickCB(OnClickItem);
        end
    end
end

function OnClickItem(tab)
    if tab and tab.cardData~=nil then
        FormationUtil.LookCard(tab.cardData:GetID());
    end
end

function OnClickMask()
    view:Close();
end

--发送好友申请
function OnClickOK()
    if FriendMgr:CanAdd() then
        local datas={{uid=data.uid,state=eFriendState.Apply,apply_msg=""}};
        FriendMgr:Op(datas);
        SetState(eFriendState.Waiting)
    end
end