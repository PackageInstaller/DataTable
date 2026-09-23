local data = nil
local cfgInfo = nil
local isLoadImg = false
local layout = nil
local curDatas = nil
local rightItems1, rightItems2 = nil, nil
local time,timer =  0,0

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/SkinPassList/SkinPassItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, {
            cfgInfo = cfgInfo,
            data = data
        })
    end
end

function OnItemClickCB(item)
    PlayerProto:SkinPassGetReward(data:GetID(), -1)
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedRefresh)
end

function OnRedRefresh()
    SetRed()
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = data:GetEndTime() - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime,55002,timeTab[1],timeTab[2],timeTab[3])
        if time <= 0 then
            EventMgr.Dispatch(EventType.SkinPass_Update)
            return
        end
    end
end

function Refresh(_data)
    data = _data
    if data then
        cfgInfo = data:GetViewCfg()
        InitImg()
        SetTime()
        SetRole()
        SetLevel()
        SetItems()
        SetBtnState()
        SetRed()
    end
end

function SetTime()
    time = data:GetEndTime() - TimeUtil:GetTime()
    if time <= 0 then
        EventMgr.Dispatch(EventType.SkinPass_Update)
    end
end

function SetRole()
    local roleInfo = CRoleMgr:GetFakeData(data:GetRoleId())
    local cfgModel = roleInfo:GetBaseModel()
    local roleName = cfgModel and cfgModel.icon or ""
    if roleName and roleName ~= "" then
        ResUtil.RoleCard:Load(iconRole2, roleName)
    end
    CSAPI.SetText(txtRoleName, roleInfo and roleInfo:GetAlias() or "")
    local pos, scale, img, l2dName = RoleTool.GetImgPosScale(data:GetSkinId(), LoadImgType.Main, false)
    CSAPI.SetAnchor(iconRole1, pos.x, pos.y, pos.z)
    CSAPI.SetScale(iconRole1, scale, scale, 1)
    ResUtil.ImgCharacter:Load(iconRole1, img)
end

function SetLevel()
    local lv = data:GetLv()
    CSAPI.SetText(txtLevel1, lv .. "")
    if data:IsMaxLv() then
        LanguageMgr:SetText(txtLevel2, 320022)
        CSAPI.SetText(txtLevel3, "/" .. LanguageMgr:GetByID(320022))
    else
        local cur, max = data:GetExp()
        CSAPI.SetText(txtLevel2, cur .. "")
        CSAPI.SetText(txtLevel3, "/" .. max)
    end

end

function SetItems()
    curDatas = data:GetShowRewardInfos()
    layout:IEShowList(#curDatas, OnLoadItemSuccess(), GetCurIndex())
end

function GetCurIndex()
    local curIndex = #curDatas
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if (v.level > data:GetLv()) or (not data:IsRewardGet(i)) then
                curIndex = i
                break
            end
        end
    end
    return curIndex
end

function OnLoadItemSuccess()
    CSAPI.SetParent(lineBg1, itemParent)
    CSAPI.SetParent(lineCur1, itemParent)
    lineBg1.transform:SetAsFirstSibling()
    lineCur1.transform:SetSiblingIndex(1)
    local padding, cellX, spacingX = {12, 60}, 124, 39
    local len = padding[1] + #curDatas * (cellX + spacingX) - spacingX + padding[2]
    CSAPI.SetRTSize(lineBg1, len - 88, 21)
    if data:GetLv() > 0 then
        CSAPI.SetRTSize(lineCur1, (data:GetLv() - 1) * (cellX + spacingX), 31)
    end
    -- 右下处理
    CSAPI.SetText(txtIndex1, #curDatas + 1 .. "")
    CSAPI.SetText(txtIndex2, #curDatas + 2 .. "")
    CSAPI.SetGOActive(rigthImg2, data:GetLv() >= #curDatas + 1)
    CSAPI.SetGOActive(rigthImg4, data:GetLv() >= #curDatas + 2)
    local lineLen = data:GetLv() >= #curDatas + 1 and 114 or 0
    lineLen = data:GetLv() >= #curDatas + 2 and 305 or lineLen
    CSAPI.SetRTSize(lineCur2, lineLen, 31)
end

-- 右下角按钮状态
function SetBtnState()
    local isBuy = data:IsBuy()
    CSAPI.SetGOActive(btnUnLock, not isBuy)
    CSAPI.SetGOActive(btnMission, not data:IsMaxLv())
    CSAPI.SetGOActive(btnUpgrade, not data:IsMaxLv())
    for i = 1, 4 do
        if i <= 2 then
            CSAPI.SetGOActive(this["itemLock" .. i].gameObject, false)
        else
            CSAPI.SetGOActive(this["itemLock" .. i].gameObject, (not isBuy))
        end
    end

    local infos = data:GetShowRewardInfos(true)
    local isGet, isFinish = false, false
    local dungeonData = nil
    for i = 1, 2 do
        if infos[i] then
            this["rightItems" .. i] = this["rightItems" .. i] or {}
            GridAddRewards(this["rightItems" .. i], infos[i].fullReward, this["rightItemParent" .. i].gameObject)
            _, isGet = data:IsRewardGet(infos[i].level)
            dungeonData = DungeonMgr:GetDungeonData(infos[i].group and infos[i].group[1])
            isFinish = data:GetLv() >= infos[i].level and dungeonData and dungeonData:IsPass()
            CSAPI.SetGOActive(this["getImg" .. i].gameObject, isGet)
            CSAPI.SetGOActive(this["finishImg" .. i].gameObject,isBuy and isFinish and not isGet)
            -- CSAPI.SetGOActive(this["btnMask" .. i].gameObject, (isFinish and not isGet) or (not data:IsBuy()))
            CSAPI.SetGOAlpha(this["rightItemParent" .. i].gameObject, isGet and 0.5 or 1)
        end
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParent, data:IsTaskRed())
end

function OnClickRole()
    local comm = ShopMgr:GetFixedCommodity(data:GetRoleShopId())
    if comm then
        local key = (comm:GetCfg() and comm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
        ShopCommFunc.HandlePayLogic(comm, 1, nil, OnBuySuccess, key)
    end
end

function OnClickTips()
    local explainData = {}
    explainData.title = LanguageMgr:GetByID(320016)
    explainData.content = LanguageMgr:GetByID(320017)
    explainData.size = {390, 446}
    CSAPI.OpenView("ExplainBox", explainData)
end

function OnClickMission()
    CSAPI.OpenView("SkinPassMission", {
        type = eTaskType.SkinPass,
        group = data:GetID(),
        isMax = data:IsMaxLv()
    })
end

function OnClickUnLock()
    local comm = ShopMgr:GetFixedCommodity(data:GetSkinShopId())
    -- LogError("recharge " .. data:GetSkinShopId())
    if comm then
        local key = (comm:GetCfg() and comm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
        ShopCommFunc.OpenPayView(comm, OnBuySuccess, false, key)
        -- ShopCommFunc.HandlePayLogic(comm, 1, nil, OnBuySuccess, key)
    end
end

function OnBuySuccess()

end

function OnClickItem(go)
    if data:IsBuy() and (go.name == "btnItem3" or go.name == "btnItem4") then
        if data:IsDungeonCanGet(go.name == "btnItem3" and 1 or 2) then
            PlayerProto:SkinPassGetReward(data:GetID(), -1)
            return
        end
    end
    local dialogData = {}
    if go.name == "btnItem1" or go.name == "btnItem3" then -- 皮肤关
        dialogData.title = LanguageMgr:GetByID(320007)
        dialogData.content = data:IsBuy() and LanguageMgr:GetByID(320011) or LanguageMgr:GetByID(320010)
        if go.name == "btnItem3" and not data:IsBuy() then
            dialogData.okText = LanguageMgr:GetByID(320009)
        else
            dialogData.okText = LanguageMgr:GetByID(data:GetLv() >= #curDatas + 1 and
                                                    320012 or 320021)
        end
    elseif go.name == "btnItem2" or go.name == "btnItem4" then -- 挑战关
        dialogData.title = LanguageMgr:GetByID(320008)
        dialogData.content = data:IsBuy() and LanguageMgr:GetByID(320019) or LanguageMgr:GetByID(320018)
        if go.name == "btnItem4" and not data:IsBuy() then
            dialogData.okText = LanguageMgr:GetByID(320009)
        else
            dialogData.okText = LanguageMgr:GetByID(data:GetLv() >= #curDatas + 2 and
                                                    320012 or 320021)
        end
    end
    dialogData.rewards = data:GetDungeonRewards((go.name == "btnItem1" or go.name == "btnItem3") and 1 or 2)
    dialogData.okCallBack = function()
        if not data:IsBuy() and (go.name == "btnItem3" or go.name == "btnItem4") then
            ShowUnLock()
        elseif data:GetLv() >= #curDatas + ((go.name == "btnItem1" or go.name == "btnItem3") and 1 or 2) then
            CSAPI.OpenView("SkinPassTeam", {
                dungeonId = data:GetDungeonId((go.name == "btnItem1" or go.name == "btnItem3") and 1 or 2)
            })
        else
            ShowUpgrade()
        end
    end
    CSAPI.OpenView("RewardTips", dialogData)
end

function ShowUnLock()
    if CSAPI.IsViewOpen("RewardTips") then
        CSAPI.CloseView("RewardTips")
    end
    OnClickUnLock()
end

function ShowUpgrade()
    if CSAPI.IsViewOpen("RewardTips") then
        CSAPI.CloseView("RewardTips")
    end
    OnClickUpgrade()
end

function OnClickRole()
    local comm = ShopMgr:GetFixedCommodity(data:GetRoleShopId())
    if comm then
        local key = (comm:GetCfg() and comm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
        ShopCommFunc.OpenPayView(comm, OnBuySuccess, false, key)
        -- ShopCommFunc.HandlePayLogic(comm, 1, nil, OnBuySuccess, key)
    end
end

function OnClickUpgrade()
    CSAPI.OpenView("SkinPassStage", {
        id = data:GetID()
    })
end
----------------------------------------------------图标加载----------------------------------------------------
function InitImg()
    if isLoadImg or not cfgInfo then
        return
    end
    isLoadImg = true

    for k, v in pairs(cfgInfo) do
        if this[tostring(k)] and not IsNil(this[tostring(k)].gameObject) then
            LoadImg(this[tostring(k)].gameObject, tostring(v))
        end
    end
end

function LoadImg(go, iconName)
    if IsNil(go) or (not iconName or iconName == "") or (not cfgInfo) then
        return
    end
    CSAPI.LoadImg(go, "UIs/SkinPass" .. cfgInfo.id .. "/" .. iconName .. ".png", false, nil, true)
    if go.name == "itemLock1" or go.name == "itemLock2" or go.name == "itemLock3" or go.name == "itemLock4" then
        CSAPI.SetImgColor(go, 255, 255, 255, 153)
    elseif go.name == "lineBg1" or go.name == "lineBg2" then
        CSAPI.SetImgColor(go, 255, 255, 255, 76)
    elseif go.name == "lineCur1" or go.name == "lineCur2" then
        CSAPI.SetImgColor(go, 255, 193, 70, 255)
    else
        CSAPI.SetImgColor(go, 255, 255, 255, 255)
    end
end
