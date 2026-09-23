local leftPanel=nil;
local leftInfos={};
local curType=1;
curIndex1, curIndex2 = 1, 1;
local eventMgr=nil;
local top=nil;
local os=nil;
local isAnim = false
local curDatas=nil;
local layout=nil;
local tlua=nil;
local svPosIndex=0;
local refreshTime=5;
function Awake()
    top=UIUtil:AddTop2("CollaborationInvition",gameObject,OnClickClose);
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftNode.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{61017, "Collaboration/btn_05_01"},{61018,"Collaboration/btn_05_02"}}
    leftPanel.Init(this, leftDatas)
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Collaboration/CollaborationInvitionItem",LayoutCallBack,true);
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Collaboration_BindRecoment_Update, OnRecomentListUpdate);
    eventMgr:AddListener(EventType.Collaboration_BindInvite_Update, OnInviteListUpdate);
    eventMgr:AddListener(EventType.Collaboration_InviteOption_Ret,OnInviteOptionRet);
    eventMgr:AddListener(EventType.Collaboration_BindInvite_Ret,OnInviteListUpdate)
    eventMgr:AddListener(EventType.Collaboration_Info_Update,OnInfoUpdate);
    eventMgr:AddListener(EventType.Collaboration_Invite_Req,OnIviteReq);
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
end

function OnOpen()
    leftPanel.Anim();
    if openSetting==1 or openSetting==nil then
        os=eBindInviteOpenType.Invite
        CSAPI.SetText(txt_tDesc,LanguageMgr:GetByID(61019));
        CSAPI.SetText(txtNOFriend,LanguageMgr:GetByID(61030));
    elseif openSetting==2 then
        os=eBindInviteOpenType.Request
        CSAPI.SetText(txt_tDesc,LanguageMgr:GetByID(61021));
        CSAPI.SetText(txtNOFriend,LanguageMgr:GetByID(61031));
    end
    RefreshList(true)
    SetRedInfo();
end

function Refresh()
    leftPanel.Anim();
    SetRedInfo();
    --根据当前类型初始化列表
    if curType==1 then
        os=eBindInviteOpenType.Invite
        CSAPI.SetText(txt_tDesc,LanguageMgr:GetByID(61019));
        CSAPI.SetText(txtNOFriend,LanguageMgr:GetByID(61030));
    elseif curType==2 then
        os=eBindInviteOpenType.Request
        CSAPI.SetText(txt_tDesc,LanguageMgr:GetByID(61021));
        CSAPI.SetText(txtNOFriend,LanguageMgr:GetByID(61031));
    end
    RefreshList(true);
end

function AnimStart()
    isAnim = true
    CSAPI.SetGOActive(clickMask, true)
end

-- 动画完成解除锁屏
function AnimEnd()
    isAnim = false
    CSAPI.SetGOActive(clickMask, false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data, curType==1)
        -- 请求更多数据
        if (index == #curDatas and CollaborationMgr:IsListFull(os)~=true and svPosIndex==0) then
            if os==eBindInviteOpenType.Invite then
                CollaborationMgr:GetNextRecommentList();
                svPosIndex=#curDatas;
            elseif os==eBindInviteOpenType.Request then
                CollaborationMgr:GetNextInvitList();
                svPosIndex=#curDatas;
            end
        end
    end
end

function RefreshPanel()
    --根据类型获取当前列表
    if isAnim then
        return
    end
    if curIndex1 and curIndex1 ~= curType then
        curType = curIndex1
        svPosIndex=0;
        -- Refresh(true);
        Refresh();
    end
end

function OnClickClose()
    CollaborationMgr:CleanCache();
    view:Close();
end

function SendGetList(page)
    if curType==1 then
        CollaborationMgr:GetNextRecommentList(page);
    elseif curType==2 then
        CollaborationMgr:GetNextInvitList(page);
    end
end

--点击刷新
function OnClickRefresh()
    if TimeUtil:GetTime()>=CollaborationMgr:GetNextRefreshTime() then
        SendGetList(0);
        CollaborationMgr:SetNextRefreshTime(TimeUtil:GetTime()+refreshTime);
    else
        LanguageMgr:ShowTips(40006);
    end
end

function RefreshList(isForceRefresh)
    curDatas=nil;
    if isForceRefresh~=true then
        if curType==1 then
            local list=CollaborationMgr:GetBindRecomentInfo();
            --剔除已邀请过的元素
            if list~=nil and #list>0 then
                curDatas={}
                for k,v in ipairs(list) do
                    if CollaborationMgr:IsIniviteMember(v.uid)~=true then
                        table.insert(curDatas,v);
                    end
                end
            end
        elseif curType==2 then
            local list=CollaborationMgr:GetBindInviteInfo();
            if list~=nil and #list>0 then
                curDatas=list;
            end
            -- local list=CollaborationMgr:GetBindInviteInfo();
            -- --剔除已操作过的元素
            -- if list~=nil and #list>0 then
            --     curDatas={}
            --     for k,v in ipairs(list) do
            --         if CollaborationMgr:IsDisMember(v.uid)~=true then
            --             table.insert(curDatas,v);
            --         end
            --     end
            -- end
        end
    end
    local isEmpty=true;
    local isReLoad=false;
    if curDatas~=nil  then
        isEmpty=#curDatas==0
    elseif  isForceRefresh==true then
        SendGetList(0);
        isReLoad=true;
    end
    CSAPI.SetGOActive(emptyObj,isEmpty)
    if curDatas==nil then
        curDatas={}
    end
    if (svPosIndex == 0 and tlua) or isReLoad then
        tlua:AnimAgain()
        AnimStart()
    end
    layout:IEShowList(#curDatas,AnimEnd,svPosIndex);
    svPosIndex = 0
end

--推荐列表更新
function OnRecomentListUpdate()
    RefreshList(nil);
end

--申请绑定列表更新
function OnInviteListUpdate()
    RefreshList(nil);
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnInviteOptionRet(proto)
    if proto and proto.success and proto.isOk then
        if not IsNil(gameObject) and not IsNil(view) then
            view:Close();
        end
    else
        RefreshList(nil);
    end
end

function OnInfoUpdate()
    RefreshList(nil);
end

--重新获取一次邀请列表
function OnIviteReq()
    CollaborationMgr:GetNextInvitList(0);
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.Collaboration);
    for k,v in ipairs(leftPanel.leftItems) do
        if k==2 then
            local isRed=false;
            if redInfo and redInfo.bind==1 then
                isRed=true
            end
            v.SetRed(isRed);
        end
    end
end