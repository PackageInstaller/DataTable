local curType = 1 -- 当前点击的页面
local Objs = nil
local curItem = nil
local timer = 0
local recordBeginTime = 0
local refreshInterval = 0 -- 刷新间隔

local layout = nil
local rItemDatas = {}
local isAnim = false
local svPosIndex = 0 -- 0是当前不变，1返回初始状态
local isOption = false
local isFind = false -- 避免查找为空时隐藏查询按钮
local lastPanel = 0
local tab = nil

-- 进入界面等待好友刷新
local StartRefrshTime = 2
local isRefresh = false

function Awake()
    timeLen = Cfgs.CfgFriendConst:GetByID(eFriendConst.FriendStateUpdate).nVal
    timer = timeLen or 40

    findInput = ComUtil.GetCom(InputFind, "InputField")
    CSAPI.AddInputFieldChange(InputFind, OnFindNameChange)

    applyInput = ComUtil.GetCom(InputApply, "InputField")
    CSAPI.AddInputFieldChange(InputApply, OnApplyDescChange)

    recordBeginTime = CSAPI.GetRealTime()

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    if not IsNil(layout) then
        layout:Init("UIs/Friend/FriendRItem", LayoutCallBack, true)
        tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
    end

    CSAPI.SetGOActive(applyTip,false)
    CSAPI.SetGOActive(optionObj,false)

    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = rItemDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnInfoCallBack)
        lua.Refresh(_data, curType)
    end
end

function OnFindNameChange(str)
    local _str = StringUtil:FilterChar(str);
    findInput.text = _str
end

function OnApplyDescChange(str)
    local _str = StringUtil:FilterChar(str);
    applyInput.text = _str
end

function OnTabChanged(index)
    if curType == index then
        return
    end
    curType = index
    svPosIndex = 1

    RefreshPanel()
end

function OnInit()
    UIUtil:AddTop2("FriendView", topObj, OnClickClose)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Friend_Update, OnFriendFlush)
    eventMgr:AddListener(EventType.Friend_Op, EOp) -- 操作回调（后端返回）: 删除+拉黑+移出黑名单
    eventMgr:AddListener(EventType.Friend_Find, ESearch) -- 根据id查找好友回调
    eventMgr:AddListener(EventType.Friend_Recommend, ERecommend) -- 推荐回调
    eventMgr:AddListener(EventType.Friend_Other, EOther) -- 打开其他选项
    eventMgr:AddListener(EventType.Friend_Apply_Panel, EApply)
    eventMgr:AddListener(EventType.Friend_UI_Remove, ERemove)
end

function OnDestroy()
    eventMgr:ClearListener()
    RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. RecordViews.Friend);
    ReleaseCSComRefs()
end

function Update()
    timer = timer - Time.deltaTime
    if refreshInterval > 0 then
        refreshInterval = refreshInterval - Time.deltaTime
    end
    if (timer < 0 and not isOption) then
        timer = timeLen
        FriendMgr:GetFriendFlush()
    end

    if StartRefrshTime > 0 then
        StartRefrshTime = StartRefrshTime - Time.deltaTime
    end
    if (StartRefrshTime <= 0 and not isRefresh) then -- 打开界面好友刷新超时自动刷新
        RefreshPanel()
        isRefresh = true
        timer = timeLen
    end
end

function OnOpen()
    FriendMgr:GetFriendFlush()
end

function OnFriendFlush()
    isRefresh = true
    RefreshPanel()
end

function EOp()
    RefreshPanel()
end

function RefreshPanel()
    if isAnim then
        return
    end
    if refreshInterval <= 0 then -- 刷新间隔
        -- data
        InitLDatas()
        -- red
        SetRed()
        -- right
        SetCenter()
        -- 好友上限
        CSAPI.SetText(txtLimit1, lItemDatas[1].count .. "")
        CSAPI.SetText(txtLimit2, "/" .. lItemDatas[1].maxCount)

        refreshInterval = 0.1
    end
end

function InitLDatas()
    lItemDatas = {}
    local strs = {LanguageMgr:GetByID(12022), LanguageMgr:GetByID(12023), LanguageMgr:GetByID(12024),
                  LanguageMgr:GetByID(12025)}
    local states = {1, 0, 4, 2} -- 对应枚举 eFriendState
    for i, v in ipairs(strs) do
        local _datas = FriendMgr:GetDatasByState(states[i])
        local _count = #_datas
        local _maxCount = i == 1 and FriendMgr:GetMaxCount() or -1
        local tab = {
            name = v,
            count = _count,
            index = i,
            maxCount = _maxCount,
            datas = _datas
        } -- i 同时对应了states
        table.insert(lItemDatas, tab)
    end
end

-- 红点
function SetRed()
    local isRed = false
    for i = 1, 4 do
        isRed = false
        local datas = lItemDatas[i].datas or {}
        if #datas > 0 then
            if i == 3 then
                isRed = true
            elseif i == 1 then
                for _, data in ipairs(datas) do
                    local friendData = FriendMgr:GetData(data.uid)
                    if friendData:IsNew() and friendData:IsOnLine() then
                        isRed = true
                        break
                    end
                end
            end
        end
        UIUtil:SetRedPoint(this["redParent" .. i].gameObject,isRed)
    end
end

-- 设置窗口 
-- 1-好友，2-搜索，3-申请，4-拉黑
function SetCenter()
    local index = 5

    rItemDatas, index = GetFriendDatas()

    if #rItemDatas < 1 and not isFind then
        SetObjs(5)
        SetEmptyPanel()
        CSAPI.SetGOActive(vsv, false)
        return
    else
        SetObjs(index)
    end

    CSAPI.SetGOActive(vsv, true)
    if svPosIndex == 1 then
        tlua:AnimAgain()
    end
    AnimStart()
    layout:IEShowList(#rItemDatas, AnimEnd, svPosIndex)
    svPosIndex = 0
    isFind = false
end

function GetFriendDatas()
    local data = {}
    local index = curType

    if (index == 1) then -- 好友
        data = lItemDatas[1].datas
    elseif (index == 2) then -- 搜索
        SetFindPanel()
        data = findDatas
    elseif (index == 3) then -- 收到申请
        data = lItemDatas[3].datas
    elseif (index == 4) then -- 黑名单
        data = lItemDatas[4].datas
    end
    return data, index
end

function SetObjs(index)
    index = index - 1
    if (not Objs) then
        Objs = {findObj, waitObj, heiObj, emptyObj}
    end
    for i, v in ipairs(Objs) do
        CSAPI.SetGOActive(v.gameObject, i == index)
        if i == index and lastPanel ~= i then
            PanelAnim(v.gameObject)
            lastPanel = i
        end
    end
end

-- 空
function SetEmptyPanel()
    local ids = {12012, 0, 12033, 12028}
    local type = curType > 0 and curType or 1
    LanguageMgr:SetText(txtNOFriend, ids[type] .. "")
    CSAPI.SetGOActive(emptyObj, ids[type] ~= 0)
end

-- 其他选项
function EOther(_data)
    curItem = _data.item
    if (_data.isDorm) then
        if (not dormCG) then
            dormCG = ComUtil.GetCom(btnDorm, "CanvasGroup")
        end
        if (not orderCanvasGroup) then
            orderCanvasGroup = ComUtil.GetCom(btnOrder, "CanvasGroup")
        end
        local isOpenOrder = IsOpenTrading(curItem)
        local isOpenDorm = IsOpenDorm(curItem)
        if isOpenOrder or isOpenDorm then
            dormCG.alpha = isOpenDorm and 1 or 0.4
            CSAPI.SetGOActive(lockImg1, not isOpenDorm)
            CSAPI.SetGOActive(dormImg, isOpenDorm)

            orderCanvasGroup.alpha = isOpenOrder and 1 or 0.4
            CSAPI.SetGOActive(lockImg2, not isOpenOrder)
            CSAPI.SetGOActive(orderImg, isOpenOrder)
        else
            dormCG.alpha = 0.4
            CSAPI.SetGOActive(lockImg1, true)
            CSAPI.SetGOActive(dormImg, false)
            orderCanvasGroup.alpha = 0.4
            CSAPI.SetGOActive(lockImg2, true)
            CSAPI.SetGOActive(orderImg, false)
        end
    end
    CSAPI.SetGOActive(otherBtns, not _data.isDorm)
    CSAPI.SetGOActive(dormBtns, _data.isDorm)
    local x, y = curItem:GetBtnPos()
    local itemX, itemY = CSAPI.GetLocalPos(_data.item.gameObject) -- item相对RGrid
    local gridX, gridY = CSAPI.GetLocalPos(RGrid.gameObject) -- RGrid相对sv
    local btnY = itemY + gridY - 71 - 24
    if btnY < -691 then
        RectifyRItemPos(_data.item)
        btnY = -691
    end
    local btnX = x - 35
    CSAPI.SetAnchor(optionObj, btnX, btnY)

    OptionAnim(true)
end

function RectifyRItemPos(_item) -- 矫正画面最下边RItem位置
    if _item.GetIndex() > 4 then
        CSAPI.SetLocalPos(RGrid, 0, 180 * (_item.GetIndex() - 4) + 100)
    end
end

function IsOpenTrading(curItem)
    if curItem and curItem.data and curItem.data.build_opens then
        local openInfo = curItem.data.build_opens
        local isOpen, LockStr = MatrixMgr:BuildingIsOpen(BuildsType.TradingCenter)
        if isOpen then
            isOpen = openInfo[2] == 1
            LockStr = not isOpen and LanguageMgr:GetTips(6013) or LockStr
        end
        return isOpen, LockStr
    else
        return false, LanguageMgr:GetTips(6013)
    end
end

function IsOpenDorm(curItem)
    if curItem and curItem.data and curItem.data.build_opens then
        local openInfo = curItem.data.build_opens
        local isOpen, LockStr = DormMgr:DormIsOpen()
        if isOpen then
            isOpen = openInfo[1] == 1
            LockStr = not isOpen and LanguageMgr:GetTips(6014) or LockStr
        end
        return isOpen, LockStr
    else
        return false, LanguageMgr:GetTips(6014)
    end
end

function OnClickBlack()
    if curItem then
        local dialogdata = {}
        dialogdata.content = LanguageMgr:GetTips(6002)
        dialogdata.okCallBack = function()
            local tabs = {{
                uid = curItem:GetUid(),
                state = eFriendState.Black
            }}
            FriendMgr:Op(tabs)
            OptionAnim(false)
        end
        CSAPI.OpenView("Dialog", dialogdata)
    end
end

function OnClickDetele()
    if curItem then
        local len = FriendMgr:GetDelCnt()
        local max = Cfgs.CfgFriendConst:GetByID(eFriendConst.DailyDelLimit).nVal
        local dialogdata = {}
        dialogdata.content = len < max and LanguageMgr:GetTips(6000) or LanguageMgr:GetTips(6001)
        if (len < max) then
            dialogdata.okCallBack = function()
                local tabs = {{
                    uid = curItem:GetUid(),
                    state = eFriendState.Delete
                }}
                FriendMgr:Op(tabs)
                OptionAnim(false)
            end
        end
        CSAPI.OpenView("Dialog", dialogdata)
    end
end

-- 打开好友宿舍
function OnClickDorm()
    local isOpen, lockStr = IsOpenDorm(curItem)
    if isOpen then
        DormMgr:OpenFidDorm(curItem:GetUid())
    else
        Tips.ShowTips(lockStr)
    end
end

-- 打开好友基建订单
function OnClickOrder()
    local isOpen, lockStr = IsOpenTrading(curItem)
    if isOpen then
        MatrixMgr:OpenMatrixTrading(curItem:GetUid())
    else
        Tips.ShowTips(lockStr)
    end
end

----------------------------------------搜索----------------------------------------------
-- 查找面板
function SetFindPanel()
    -- uid
    CSAPI.SetText(txtUID, PlayerClient:GetUid() .. "")

    isFind = true
    if (findInput.text ~= "") then
        if (findDatas and #findDatas > 0) then
            local data = FriendMgr:GetData(findDatas[1]:GetUid())
            if (data ~= nil and data:GetState() ~= eFriendState.BeBlack) then
                findDatas = {}
                table.insert(findDatas, data)
            end
        else
            findDatas = {}
        end
        -- isFind = true
    else
        -- 推荐列表
        findDatas = FriendMgr:GetRecommends()
        if findDatas and #findDatas <= 0 then
            OnClickRefresh()
            return
        end
    end
end

-- 推荐回调
function ERecommend()
    findDatas = FriendMgr:GetRecommends()
    if (#findDatas > 0) then
        SetCenter()
    end
end

-- 查找回调
function ESearch(proto)
    findDatas = {}
    if (proto.info and #proto.info > 0) then
        for i, v in ipairs(proto.info) do
            local _findData = v
            if (_findData) then
                local data = FriendMgr:GetData(_findData.uid)
                if (data == nil) then
                    local _data = FriendMgr:CreateFakeData(_findData)
                    table.insert(findDatas, _data)
                    -- elseif(data:GetState() ~= eFriendState.BeBlack) then
                else
                    table.insert(findDatas, data)
                end
            end
        end
    end

    SetCenter()
end

-- 查找
function OnClickFind()
    local newStr = findInput.text
    if (newStr and newStr ~= "" and newStr ~= PlayerClient:GetID()) then
        FriendMgr:Search(newStr)
    else
        LanguageMgr:ShowTips(6010)
        -- OnClickRefresh()
    end
end

-- 手动刷新
function OnClickRefresh()
    FriendMgr:GetRecomend(true)
    findInput.text = ""
end

function OnClickCopy()
    if not copyText then
        copyText = ComUtil.GetCom(txtUID, "Text")
    end
    if copyText.text ~= "" then
        -- UnityEngine.GUIUtility.systemCopyBuffer = "#" .. copyText.text
        UnityEngine.GUIUtility.systemCopyBuffer = copyText.text
        LanguageMgr:ShowTips(6011)
    end
end

----------------------------------------申请----------------------------------------------
function OnClickRefuse()
    local _datas = {}
    for i, v in ipairs(lItemDatas[3].datas) do
        table.insert(_datas, {
            uid = v:GetUid(),
            state = eFriendState.Deny
        })
    end
    if (#_datas > 0) then
        FriendMgr:Op(_datas)
    end
end

function EApply(item)
    curItem = item
    OnClickApply()
    -- ShowApplyWindow(true)
    -- CSAPI.SetGOActive(clickMask, true)
end

function OnClickApply()
    if (FriendMgr:CanAdd() and curItem) then
        local str = applyInput.text
        local datas = {{
            uid = curItem:GetUid(),
            state = eFriendState.Apply,
            apply_msg = str
        }}
        FriendMgr:Op(datas)
    else
        LanguageMgr:ShowTips(6005)
    end
    OnClickBack()
end

function ShowApplyWindow(isShow)
    if isShow then
        applyInput.text = ""
        CSAPI.SetGOActive(applyTip, true)
        CSAPI.SetUIScaleTo(applyNode, nil, 1, 1, 1, nil, 0.2)
    else
        CSAPI.SetUIScaleTo(applyNode, nil, 0, 0, 1, function()
            CSAPI.SetGOActive(applyTip, false)
        end, 0.2)
    end
end

------------------------------------------拉黑--------------------------------------------
-- 拉黑面板
function OnClickRelive()
    local _datas = {}
    for i, v in ipairs(lItemDatas[4].datas) do
        table.insert(_datas, {
            uid = v:GetUid(),
            state = eFriendState.DelBlack
        })
    end
    if (#_datas > 0) then
        FriendMgr:Op(_datas)
    end
end

------------------------------------------------------------------------------------------
function OnInfoCallBack(_item)
    CSAPI.OpenView("PlayerInfoView", {
        uid = _item.GetUid(),
        supports = _item.GetSupports(),
        iconName = _item.GetIconName()
    })
end

function OnClickClose()
    view:Close()
end

function OnClickBack()
    if isAnim then
        return
    end
    if isOption then
        OptionAnim(false)
        return
    end
    CSAPI.SetGOActive(clickMask, false)
    CSAPI.SetGOActive(otherBtns, false)
    ShowApplyWindow(false)
end

function OnClickFrameClose()
    CSAPI.SetGOActive(frameNode, false)
    CSAPI.SetGOActive(faceObj, false)
    CSAPI.SetGOActive(textObj, false)
end

------------------------------------------动效----------------------------------------------
-- 动画锁屏
function AnimStart()
    isAnim = true
    CSAPI.SetGOActive(clickMask, true)
end

-- 动画完成解除锁屏
function AnimEnd(isMask)
    isAnim = false
    if not isMask then
        CSAPI.SetGOActive(clickMask, false)
    end
end

-- 选项动效
function OptionAnim(isOpen)
    if isOpen then
        AnimStart()
        isOption = true
        optionObj.transform.parent = btnMask.transform
        CSAPI.SetGOActive(btnMask, true)
        CSAPI.SetGOActive(optionObj, true)
        UIUtil:SetObjFade(optionObj,0, 1,function()
            AnimEnd()
        end, 100)
    else
        UIUtil:SetObjFade(optionObj,1, 0,function()
            optionObj.transform.parent = sr.transform
            CSAPI.SetGOActive(btnMask, false)
            CSAPI.SetGOActive(optionObj, false)
            isOption = false
            AnimEnd()
        end, 100)
    end
end

function PanelAnim(_obj)
    local panelObj = ComUtil.GetCom(_obj, "ActionFade")
    if not panelObj then
        panelObj = _obj:AddComponent(typeof(CS.ActionFade));
    end
    panelObj:Play(0, 1, 300, 0)
end

function ERemove()
    AnimStart()
    FuncUtil:Call(function()
        InitLDatas()
        rItemDatas = GetFriendDatas()
        -- tlua2:AnimAgain()
        layout:UpdateList()
    end, nil, 750)
    FuncUtil:Call(function()
        AnimEnd()
        RefreshPanel()
    end, nil, 1100)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    leftParent = nil;
    txt_limit = nil;
    txtLimit1 = nil;
    txtLimit2 = nil;
    FriendObj = nil;
    findObj = nil;
    InputFind = nil;
    txt_Desc = nil;
    btnFind = nil;
    txtBtnFind = nil;
    btnRefresh = nil;
    txtBtnRefresh = nil;
    txt_myUID = nil;
    txtUID = nil;
    btnCopy = nil;
    txt_copy = nil;
    waitObj = nil;
    btnRefuse = nil;
    txt_refuse = nil;
    heiObj = nil;
    btnRelieve = nil;
    txt_relieve = nil;
    emptyObj = nil;
    txtNOFriend = nil;
    vsv = nil;
    RGrid = nil;
    otherBtns = nil;
    txtDel = nil;
    txtBlack = nil;
    clickMask = nil;
    applyTip = nil;
    tipTitle = nil;
    tipTitle2 = nil;
    tipTitle1 = nil;
    InputApply = nil;
    txt_apply = nil;
    btnApply = nil;
    txtApply = nil;
    start = nil;
    view = nil;
end
----#End#----
