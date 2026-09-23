-- 交易订单界面
local MatrixTradingInfo = require "MatrixTradingInfo"

-- local resIds = {60104, 60105, 60106}
local items = {}
local timer = 0
local tNexGiftsEx = nil
local fid = nil
local isAnimEnd = false
local maxCount, curCount = 0, 0
local friends = {}
local friendsLen = 0

function Awake()
    --初始化菜单项
	AdaptiveConfiguration.SetLuaObjUIFit("MatrixTrading",gameObject)
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/Matrix/MatrixTradingItem", LayoutCallBack, true)
    animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)

    CSAPI.SetGOActive(mask, true)

    friends = FriendMgr:GetDatasByState(eFriendState.Pass)
    friendsLen = #friends

    textMove = ComUtil.GetCom(objTxtL, "TextMove")
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetFid(fid)
        lua.Refresh(_data, TradingItemCB, buildId, tNexGiftsEx)
    end
end

function OnInit()
    UIUtil:AddTop2("MatrixTrading", gameObject, function()
        local scene = SceneMgr:GetCurrScene()
        if (scene.key == "MajorCity") then
            view:Close()
            return
        end
        if (fid) then
            local str = LanguageMgr:GetTips(2106)
            UIUtil:OpenDialog(str, function()
                CSAPI.OpenView("MatrixTrading")
            end)
        else
            view:Close()
        end
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Building_Update, function(ids)
        if (ids and buildId and ids[buildId]) then
            RefreshPanel()
        end
    end)
    eventMgr:AddListener(EventType.Bag_Update, function()
        RefreshPanel()
    end)
    eventMgr:AddListener(EventType.Matrix_Trading_FlrUpgrade, FlrTradeOrdersCB)
end

function OnDestroy()
    AdaptiveConfiguration.LuaView_Lua_Closed("MatrixTrading")
    eventMgr:ClearListener()
end

-- data:好友id
function OnOpen()
    isAnimEnd = false
    if (data) then
        RequireNewData()
    else
        fid = nil
        buildingData = MatrixMgr:GetBuildingDataByType(BuildsType.TradingCenter)
        buildId = buildingData:GetId()
        RefreshPanel()
    end
    -- 
    if not IsNil(textMove) then
        textMove:SetText(LanguageMgr:GetByID(10101))
    end
end

function Update()
    if (tNexGiftsEx) then
        if (Time.time > timer) then
            timer = Time.time + 1
            SetTime()
            if (TimeUtil:GetTime() > tNexGiftsEx) then
                tNexGiftsEx = nil
                RequireNewData()
            end
        end
    end
end

-- 到点，请求新数据
function RequireNewData()
    if (data) then
        BuildingProto:FlrTradeOrders(data)
    else
        -- 由MatrixView统一刷新
    end
end
function FlrTradeOrdersCB(proto)
    if (proto.fid == nil) then
        -- 访问失败，无好友订单信息，后端弹出提示，保持当前界面不变
    else
        fid = data
        -- 关闭好友列表
        -- local go = CSAPI.GetView("MatrixTradingFriend")
        -- if (matrixf) then
        --     local lua = ComUtil.GetLuaTable(go)
        --     lua.view:Close()
        -- end
        if (matrixTradingFriend) then
            CSAPI.SetGOActive(matrixTradingFriend.gameObject, false)
        end
        --
        SetFidDatas(proto)
    end
end

function RefreshPanel()
    if (not fid) then
        SetDatas() -- 自己的数据
    end
    SetCount()
    SetMats()
    SetItems()
    SetLike()

    -- tips
    -- CSAPI.SetGOActive(objTitle3, fid == nil)
    local langID = fid == nil and 10103 or 10216
    LanguageMgr:SetText(txtTitle3, langID)

    --
    SetBtnLR()
end

-- 订单长度
function SetMaxCount(proto)
    curCount = 0
    maxCount = 0
    addCount = 0
    if (proto) then
        for i, v in pairs(proto.giftsEx) do
            maxCount = maxCount + 1
        end
        -- curCount = maxCount
    else
        maxCount, addCount = buildingData:GetTradingCount()
    end
end

-- 好友的订单数据(只显示实单)
function SetFidDatas(_proto)
    proto = _proto
    buildLv = proto.lv
    SetMaxCount(proto)
    tNexGiftsEx = proto.tNexGiftsEx

    curDatas = {}
    local cRoleInfos = {}
    if (proto.roles) then
        for i, v in pairs(proto.roles) do
            cRoleInfo = CRoleMgr:GetCRoleInfo(v)
            cRoleInfos[v.id] = cRoleInfo
        end
    end
    for i, v in ipairs(proto.giftsEx) do
        local cRoleInfo = v.rid and cRoleInfos[v.rid] or nil
        local info = MatrixTradingInfo.New()
        info:SetData(i, v, cRoleInfo)
        table.insert(curDatas, info)
        if (info:BCnt() > 0) then
            curCount = curCount + 1
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            if (a:GetIsRareNum() == b:GetIsRareNum()) then
                return a:GetID() < b:GetID()
            else
                return a:GetIsRareNum() > b:GetIsRareNum()
            end
        end)
    end
    RefreshPanel()
end

-- 自己的订单数据（实单+空单/假单+锁单）
function SetDatas()
    if (not buildingData) then
        return
    end
    buildLv = buildingData:GetCfg().id
    SetMaxCount()
    tNexGiftsEx = buildingData:GetData().tNexGiftsEx
    local curRoleID = buildingData:GetTradingCurRoleID()
    local roleCount = 0
    curDatas = {}
    local giftsEx = buildingData:GetData().giftsEx or {}
    for i, v in pairs(giftsEx) do
        local cRoleInfo = v.rid and CRoleMgr:GetData(v.rid) or nil
        local info = MatrixTradingInfo.New()
        info:SetData(i, v, cRoleInfo)
        table.insert(curDatas, info)
        if (v.rid ~= nil) then
            roleCount = roleCount + 1
        end
        if (info:BCnt() > 0) then
            curCount = curCount + 1
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            if (a:GetIsRareNum() == b:GetIsRareNum()) then
                return a:GetID() < b:GetID()
            else
                return a:GetIsRareNum() > b:GetIsRareNum()
            end
        end)
    end

    -- curCount = #curDatas
    -- 假单(可以上驻员)
    -- 未上有订单加成的角色+有订单加成的角色
    local needAdd = false
    if (not curRoleID) then
        -- 剩余未入驻驻员是否有订单加成的角色
        local arr = CRoleMgr:GetArr()
        for i, v in ipairs(arr) do
            local roomId = v:GetRoomBuildID()
            local abilityCfg = v:GetAbilityCfg()
            if (v:GetCfg().bAddToBuild == true and (roomId == nil or roomId ~= buildId) and
                (abilityCfg ~= nil and abilityCfg.type == RoleAbilityType.Seller)) then
                needAdd = true
                break
            end
        end
    end
    if (needAdd) then
        local info = MatrixTradingInfo.New()
        info:SetData()
        table.insert(curDatas, info)
    end

    -- 空单（已上驻员）
    for i = roleCount + 1, addCount do
        local cRoleInfo = CRoleMgr:GetData(curRoleID)
        local info = MatrixTradingInfo.New()
        info:SetData(nil, {
            id = nil,
            num = 0,
            rid = curRoleID
        }, cRoleInfo)
        table.insert(curDatas, info)
    end

    -- 锁单
    local curID = buildingData:GetCfg().id
    local maxID = Cfgs.CfgBTradeLvl:GetByID(#CfgBTradeLvl).id
    for i = curID + 1, maxID do
        local cur = Cfgs.CfgBTradeLvl:GetByID(i - 1).orderNumLimit
        local nex = Cfgs.CfgBTradeLvl:GetByID(i).orderNumLimit
        local add = nex - cur
        for k = 1, add do
            local info = MatrixTradingInfo.New()
            info:SetData(nil, nil, nil, i)
            table.insert(curDatas, info)
        end
    end
    -- local curLimit = buildingData:GetCfg().orderNumLimit
    -- local maxLimit = Cfgs.CfgBTradeLvl:GetByID(#CfgBTradeLvl).orderNumLimit
    -- for i = curLimit + 1, maxLimit do
    -- 	local info = MatrixTradingInfo.New()
    -- 	info:SetData(nil, nil, nil, i)
    -- 	table.insert(curDatas, info)
    -- end
end

function SetCount()
    local friendName = ""
    if (fid) then
        local info = FriendMgr:GetData(fid)
        friendName = info ~= nil and info:GetName() or ""
    end
    if (friendName ~= "") then
        LanguageMgr:SetText(txtTitle1, 10131, friendName, buildLv)
    else
        LanguageMgr:SetText(txtTitle1, 10102, buildLv)
    end

    local str = maxCount > curCount and StringUtil:SetByColor(maxCount, "00FFBF") or maxCount
    CSAPI.SetText(txtTitle2, curCount .. "/" .. str)
end

function SetMats()
    topItems = topItems or {}
    topDatas = {}
    for i, id in ipairs(g_TradeOrderCostId) do
        local data = BagMgr:GetFakeData(id)
        table.insert(topDatas, data)
    end
    ItemUtil.AddItemsImm("Grid/GridItem", topItems, topDatas, grid, ItemClickCB1)
    for i, v in ipairs(topDatas) do
        CSAPI.SetText(this["txt" .. i], v:GetCount() .. "")
    end
    for i, v in ipairs(topItems) do
        v.SetCount()
    end
end

function ItemClickCB1(item)
    local cfg = Cfgs.CfgBCompoundOrder:GetByID(item.data:GetID())
    if (cfg) then
        -- CSAPI.OpenView("MatrixCompoundEnsure", {cfg})
        MatrixMgr:OpenCompoundPanel(cfg.id)
    end
end

function SetItems()
    if (not isAnimEnd) then
        CSAPI.SetGOActive(mask, true)
        animLua:AnimAgain()
    end

    layout:IEShowList(#curDatas, FirstAnim)
end

-- 首次调用完毕回调
function FirstAnim()
    if (not isAnimEnd) then
        isAnimEnd = true
        CSAPI.SetGOActive(mask, false)
    end
end

function TradingItemCB(itemData)
    local id = itemData:GetID()
    local enough, alsoNeed = itemData:IsEnough()
    if (id) then
        if (enough) then
            local str = LanguageMgr:GetTips(2316)
            UIUtil:OpenDialog(str, function()
                if (fid) then
                    BuildingProto:TradeFlrOrder(fid, id, TradeFlrOrderCB)
                else
                    BuildingProto:Trade(buildId, id)
                end
            end)
        else
            local str = LanguageMgr:GetTips(2102)
            UIUtil:OpenDialog(str, function()
                local cfg = Cfgs.CfgBCompoundOrder:GetByID(itemData:GetCostID())
                if (cfg) then
                    -- CSAPI.OpenView("MatrixCompoundEnsure", {cfg, alsoNeed})
                    -- MatrixMgr:OpenCompoundPanel(cfg.id, function(go)
                    --     local tab = ComUtil.GetLuaTable(go)
                    --     tab.SetCurCount(cfg.id, alsoNeed)
                    -- end)
                    MatrixMgr:OpenCompoundPanel(cfg.id)
                end
            end)
        end
    else
        -- 加速
        if (not fid) then
            CSAPI.OpenView("MatrixTradingSpeedUp", itemData)
        end
    end
end

function TradeFlrOrderCB(proto)
    local cfgID = nil
    for i, v in ipairs(curDatas) do
        if (v:GetID() == proto.orderId) then
            cfgID = v:GetCfgID()
            break
        end
    end
    curCount = 0
    if (cfgID) then
        for i, v in ipairs(curDatas) do
            if (v:GetCfgID() == cfgID) then
                v:SetBcnt()
            end
            if (v:BCnt() > 0) then
                curCount = curCount + 1
            end
        end
        layout:UpdateList()
    end
    SetCount()

end

function SetTime()
    if (tNexGiftsEx > 0 and tNexGiftsEx >= TimeUtil:GetTime()) then
        needTime = tNexGiftsEx - TimeUtil:GetTime()
    else
        needTime = 0
    end
    CSAPI.SetText(txtNextTime, TimeUtil:GetTimeStr(needTime))
end

function SetLike()
    local id = nil
    local code = "ffffff"
    if (fid) then
        local agreeNum = proto.agreeNum == nil and 0 or proto.agreeNum
        id = agreeNum > 0 and "10130" or "10129"
        code = agreeNum > 0 and "ff4d7a" or "ffffff"
    else
        id = 10116
    end
    local str = LanguageMgr:GetByID(id)
    str = StringUtil:SetByColor(str, code)
    CSAPI.SetText(txtLike, str)
    CSAPI.SetImgColorByCode(imgLike, code)
end

function OnClickLike()
    if (fid) then
        if (proto.agreeNum and proto.agreeNum > 0) then
            return
        end
        BuildingProto:Agree(fid, function(_proto)
            if (fid == _proto.fid) then
                proto.agreeNum = 1
                SetLike()
                LanguageMgr:ShowTips(2105)
            end
        end)
    else
        CSAPI.OpenView("MatrixTradingRecord")
    end
end

function OnClickFriend()
    if (matrixTradingFriend) then
        CSAPI.SetGOActive(matrixTradingFriend.gameObject, true)
        matrixTradingFriend.Refresh({"MatrixTrading", fid,friends})
    else
        ResUtil:CreateUIGOAsync("Matrix/MatrixTradingFriend", gameObject, function(go)
            matrixTradingFriend = ComUtil.GetLuaTable(go)
            matrixTradingFriend.Refresh({"MatrixTrading", fid,friends})
        end)
    end
end

function SetBtnLR()
    CSAPI.SetGOActive(btnL, fid ~= nil)
    CSAPI.SetGOActive(btnR, fid ~= nil)
end

function OnClickL()
    if (fid) then
        local index = 1
        for k, v in ipairs(friends) do
            if (fid == v:GetUid()) then
                index = k
            end
        end
        data = nil
        for k = index - 1, 1, -1 do
            if (friends[k]:IsTradingOpen()) then
                data = friends[k]:GetUid()
                break
            end
        end
        if (not data) then
            LanguageMgr:ShowTips(2317)
        end
        OnOpen()
    end
end

function OnClickR()
    if (fid) then
        local index = 1
        for k, v in ipairs(friends) do
            if (fid == v:GetUid()) then
                index = k
            end
        end
        data = nil
        if (index < friendsLen) then
            for k = index + 1, friendsLen do
                if (friends[k]:IsTradingOpen()) then
                    data = friends[k]:GetUid()
                    break
                end
            end
        end
        if (not data) then
            LanguageMgr:ShowTips(2317)
        end
        OnOpen()
    end
end
