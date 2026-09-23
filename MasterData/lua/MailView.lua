local itemName = "Mail/MailItem"
local itemName2 = "Mail/MailItem2"
local itemPath = "UIs/Mail/MailItem"
local selectID = nil
local layout = nil
local textDesc = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init(itemPath, LayoutCallBack, true)
    -- 打开界面检测一次红点
    MailMgr:CheckRedPointData()

    textDesc = ComUtil.GetCom(txtDesc, "HyperlinkText")
    if not IsNil(textDesc) then
        FuncUtil:Call(function ()
            textDesc:SetClickCB(OnTextClick)
        end,this,100)
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, {
            ["selectID"] = selectID
        })
    end
end

function OnTextClick(s)
    if s ~= nil and s ~= "" then
        local ss = StringUtil:StrReplace(s,'"',"",2)
        if tonumber(ss) then
            JumpMgr:Jump(tonumber(ss))
        else
            if selectID then
                local data = MailMgr:GetData(selectID)
                if data and data:GetMCfgId() then
                    MailProto:GetAttachMail(data:GetID(),data:GetMCfgId())
                end
            end
            UnityEngine.Application.OpenURL(s)
        end
    end
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mail_Operate, EOperate)
    eventMgr:AddListener(EventType.Mail_AddNotice, SetPanel)
end

function OnDisable()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("MailView", gameObject, OnClickClose)
end

-- 点选（与MailOperateType.Read存在重复刷新的情况（需优化））
function ItemClickCB(_selectID)
    selectID = _selectID
    RefreshPanel()
end

function EOperate(proto)
    if (proto.operate_type == MailOperateType.Read or proto.operate_type == MailOperateType.Get) then
        if (proto.operate_type == MailOperateType.Read) then
            selectID = proto.ids[1]
        end
        RefreshPanel()
    else
        OnOpen()
    end

    local data = MailMgr:GetData(selectID)
    local item_gains = {}
    if (data) then
        if data.rewards then
            for i, v in pairs(data.rewards) do
                table.insert(item_gains, {
                    id = v.id,
                    num = v.num
                })
            end
        end
        
        local taData = {
            subject = data.name or "",
            content = data.from or "",
            item_gain = item_gains,
            send_time = TimeUtil:GetTimeStr2(data.start_time or 0)
        }

        if CSAPI.IsADV() == false then
            BuryingPointMgr:TrackEvents("mail", taData)
        end

    end  
end

function OnOpen()
    SetPanel()

    -- 选中第一个
    if (datas and #datas > 0) then
        local data = datas[1]
        if (data:GetIsRead() == MailReadType.No) then
            MailMgr:MailOperate({data:GetID()}, MailOperateType.Read)
        else
            ItemClickCB(data:GetID())
        end
    end


end

function SetPanel()
    datas = MailMgr:GetArr()
    RefreshPanel()
end

function RefreshPanel()
    -- 显隐
    SetObjs()
    -- list
    layout:IEShowList(#datas)
    -- 选中
    SetEntity()
    -- 数量
    SetCount()
end

function SetObjs()
    local isHad = #datas > 0
    for i = 1, 5 do
        CSAPI.SetGOActive(this["emptyObj" .. i], i > #datas)
    end
    -- CSAPI.SetGOActive(emptyObj5, not isHad)
    CSAPI.SetGOActive(btnDelete, isHad)
    -- CSAPI.SetGOActive(txtCount, isHad)
    CSAPI.SetGOActive(btnGetAll, isHad)
    CSAPI.SetGOActive(empty, not isHad)

    deleteIDs = MailMgr:GetDeleteIDs()
    getIDs = MailMgr:CanGetIDs()
    if (isHad) then
        if (not deleteCanvasGroup) then
            deleteCanvasGroup = ComUtil.GetCom(btnDelete, "CanvasGroup")
        end
        if (not deleteImg) then
            deleteImg = ComUtil.GetCom(btnDelete, "Image")
        end
        deleteCanvasGroup.alpha = #deleteIDs > 0 and 1 or 0.2
        deleteImg.raycastTarget = #deleteIDs > 0
    end
    if (not getCanvasGroup) then
        getCanvasGroup = ComUtil.GetCom(btnGetAll, "CanvasGroup")
    end
    if (not getImg) then
        getImg = ComUtil.GetCom(btnGetAll, "Image")
    end
    getCanvasGroup.alpha = #getIDs > 0 and 1 or 0.2
    getImg.raycastTarget = #getIDs > 0
end

function SetEntity()
    if (selectID) then
        local data = MailMgr:GetData(selectID)
        if (data) then
            CSAPI.SetGOActive(entity, true)
            -- name
            CSAPI.SetText(txtName, data:GetName())
            -- desc
            CSAPI.SetText(txtDesc, data:Desc())
            -- form
            CSAPI.SetText(txtFrom, data:GetFrom())
            -- time
            CSAPI.SetText(txtTime, data:StartTime())
            -- reward
            SetRewards(data:GetRewards(), data:GetIsGet())
            return
        else
            selectID = nil
        end
    end
    CSAPI.SetGOActive(entity, false)
end

function SetRewards(rewards, isGet)
    if (rewards and #rewards > 0) then
        CSAPI.SetGOActive(svNode, true)
        if (items and #items > 0) then
            for i, v in ipairs(items) do
                CSAPI.RemoveGO(v.gameObject)
            end
        end
        items = {}
        for i, v in ipairs(rewards) do
            local go = ResUtil:CreateUIGO(itemName2, svContent.transform)
            local item = ComUtil.GetLuaTable(go)
            local data = {
                reward = v,
                isGet = isGet
            }
            item.Refresh(data)
            table.insert(items, item)
        end
        -- 按钮
        CSAPI.SetGOActive(btnGet,isGet ~= MailGetType.Yes)
        CSAPI.SetGOActive(btnDel,isGet == MailGetType.Yes)
    else
        CSAPI.SetGOActive(btnGet,false)
        CSAPI.SetGOActive(btnDel,true)
        CSAPI.SetGOActive(svNode, false)
    end
end
function SetCount()
    local noReadC = MailMgr:GetNotReadCount()
    -- 未读
    CSAPI.SetText(txtCount1, noReadC .. "")
    -- 未领取附件
    CSAPI.SetText(txtCount2, #getIDs .. "")
    -- 数量
    local str = "0/0"
    if #datas > 0 then
        str = string.format("%s/%s", StringUtil:SetByColor(#datas, "FFC146"), g_MailMaxSize)
    end
    CSAPI.SetText(txtCount, str)
end

-- 删除已读
function OnClickDelete()
    if (#deleteIDs > 0) then
        local tips = {}
        tips.content = LanguageMgr:GetTips(11000)
        tips.okCallBack = function()
            MailMgr:MailOperate(deleteIDs, MailOperateType.Delete)
        end
        CSAPI.OpenView("Dialog", tips)
    end
end

-- 领取或删除单个
function OnClick()
    if (selectID) then
        local data = MailMgr:GetData(selectID)
        if (data:GetRewards() and #data:GetRewards() > 0 and data:GetIsGet() ~= MailGetType.Yes) then
            MailMgr:MailOperate({data:GetID()}, MailOperateType.Get)
        else
            MailMgr:MailOperate({data:GetID()}, MailOperateType.Delete)
        end
    end
end

-- 一键领取
function OnClickGetAll()
    if (#getIDs > 0) then
        MailMgr:MailOperate(getIDs, MailOperateType.Get)
    end
end

function OnClickClose()
    view:Close()
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    txt1 = nil;
    txtCount = nil;
    txt2 = nil;
    txtCount1 = nil;
    txt3 = nil;
    txtCount2 = nil;
    vsv = nil;
    entity = nil;
    txtName = nil;
    group = nil;
    txtDesc = nil;
    txtTime = nil;
    txtFrom = nil;
    rewardParent = nil;
    svNode = nil;
    svContent = nil;
    btnGet = nil;
    empty = nil;
    txtEmpty = nil;
    btnDelete = nil;
    txtDelete = nil;
    txtDelete2 = nil;
    btnGetAll = nil;
    txtGetAll = nil;
    txtGetAll2 = nil;
    view = nil;
end
----#End#----
