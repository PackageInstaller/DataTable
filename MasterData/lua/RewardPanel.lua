-- 奖励面板
local fullNum = 6; -- 超过这个数量将中心点设置为0,1
local contentRect = nil;
local isCanBack = false
-- local sv = nil;
local layout = nil;
local fade = nil
local fade1 = nil
local UIMaskGo = nil
--tower
local m_Slider = nil
local updateInfo = nil
local isBarPlay = false
local rewards = nil
local isShowMaskTips=true;

function Awake()
    contentRect = ComUtil.GetCom(Content, "RectTransform");
    layout = ComUtil.GetCom(hpage, "UISlideshow")
    layout:Init("UIs/Popup/RewardItem", LayoutCallBack, true)

    -- sv = ComUtil.GetCom(sr, "ScrollRect");
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")

    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
    m_Slider = ComUtil.GetCom(weekSlider,"Slider")
    CSAPI.SetGOActive(txtTips, false)
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RewardPanel_Post_Close, OnClickMask)
end

function OnDisable()
    eventMgr:ClearListener()
    CloseCallBack();
end

function OnDestroy()
    CloseCallBack();
    ReleaseCSComRefs()
end

function Update()
    if updateInfo and isBarPlay then
        updateInfo.cur = updateInfo.cur + updateInfo.addCount
        if updateInfo.cur >  updateInfo.target then
            updateInfo.cur = updateInfo.target
            isBarPlay = false
        end
        m_Slider.value = updateInfo.cur / updateInfo.max
        CSAPI.SetText(txtNum,updateInfo.cur .."/"..updateInfo.max)
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        if index < 13 then
            lua.SetDelay((index - 1) * 50 + 400)
        else
            lua.SetDelay(-1)
        end
        lua.SetIndex(index)
        lua.Refresh(rewards[index])
    end
end

function CloseCallBack()
    -- 关闭回调
    if (data.closeCallBack) then
        local callBack = data.closeCallBack;
        local caller = data.caller;
        data.closeCallBack = nil;
        data.caller = nil;
        callBack(caller);
    end
end

-- rewardDatas list|sNumInfo  
function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    rewards = data[1]
    if (rewards) then
        if not openSetting or not openSetting.isNoShrink then --合并
            rewards = RewardUtil.SetShrink(rewards)
        end
        SetTowerTips()
        ShowList()
        CheckEquipExpConvert()
    end
    CSAPI.SetGOActive(txtMask, isShowMaskTips)
    -- CSAPI.SetGOActive(txtMask, isFirst10 and "" or StringConstant.role_141)	
end
function CheckEquipExpConvert()
    -- 检查是否存在素材芯片
    if rewards == nil then
        do
            return
        end
    end
    local chipExpInfo, hasExp = RewardUtil.CheckChipExpInfo(rewards);
    if chipExpInfo ~= nil then
        FuncUtil:Call(function()
            Tips.ShowEquipExpTips(chipExpInfo)
        end, nil, 500)
    end
    local isAutoConvert = false;
    -- 检查是否存在经验物品
    for k, v in ipairs(rewards) do
        if (v.type == nil) then -- 没有type则视作物品
            v.type = RandRewardType.ITEM
        end
        if (v.type == RandRewardType.ITEM) then
            local cfg = Cfgs.ItemInfo:GetByID(v.id);
            if cfg.id == ITEMS_ID.EQUIP_EXP then
                isAutoConvert = true;
                break
            end
        end
    end
    if (isAutoConvert or hasExp) and EquipMgr:CheckHasConvert() then
        CSAPI.SetText(txtTips, LanguageMgr:GetTips(79001));
        CSAPI.SetGOActive(txtTips, true)
        isShowMaskTips=false;
        -- CSAPI.SetAnchor(hpage, 0,10)
    end
end



--每周信息
function SetTowerTips()
    local add = 0        
    local addStr = ""
    if rewards and #rewards >0 then
        for i,v in ipairs(rewards)do 
            if(v.id == ITEM_ID.BIND_DIAMOND and v.num)then --微晶id                    
                add = v.num
            end
            if v.id == ITEM_ID.POWER_CEILING and v.num then --微晶上限id
                addStr= " (+".. v.num ..")"
                v.towerTip = LanguageMgr:GetByID(21108, v.num)
            end
        end
    end
    if (openSetting and openSetting.isTower) then
        local info = TowerMgr:GetTowerData()
        if add > 0 then
            updateInfo = {cur = info.cur,target = info.cur + add>info.max and info.max or info.cur + add,max = info.max, addCount = math.modf(add * 0.02) == 0 and 1 or math.modf(add * 0.02)}
            FuncUtil:Call(function ()
                if gameObject then
                    isBarPlay = true
                end
            end,nil,767)
            info = TowerMgr:AddTowerCur(add)
            m_Slider.value = updateInfo.cur / updateInfo.max
        else
            m_Slider.value = info.cur / info.max
        end
        CSAPI.SetGOActive(txtLimit, info.cur>=info.max)
        if(rewards and #rewards > 0)then
            CSAPI.SetAnchor(txtLimit,0, 21)
        else
            CSAPI.SetAnchor(txtLimit,0, -87)
        end
        CSAPI.SetAnchor(hpage,0,-95)
        CSAPI.SetGOActive(weekPrograss, true)
    elseif addStr ~= "" then
        local info = TowerMgr:GetTowerData()
        CSAPI.SetText(txtNum, info.cur .. "/" .. info.max .. addStr)
        m_Slider.value = info.cur / info.max
        CSAPI.SetGOActive(txtLimit, info.cur>=info.max)
        if(rewards and #rewards > 0)then
            CSAPI.SetAnchor(txtLimit,0, 21)
        else
            CSAPI.SetAnchor(txtLimit,0, -87)
        end
        CSAPI.SetAnchor(hpage,0,-95)
        CSAPI.SetGOActive(weekPrograss, true)
    else
        CSAPI.SetAnchor(hpage,0,-46)
        CSAPI.SetGOActive(weekPrograss, false)
    end
end

function ShowList()
    -- 当物品数量不足13个时多余位置添加空物品框
    if not srClick then
        srClick = ComUtil.GetCom(sr, "ScrollRect")
    end

    local num = #rewards > 12 and 12 or #rewards

    AnimStart()
    FuncUtil:Call(AnimEnd, nil, (num - 1) * 50 + 400 + 400)
    layout:IEShowList(#rewards)
end

function OnClickMask()
    if not isCanBack then
        return
    end
    -- if(isClosed) then
    -- 	return
    -- end
    -- isClosed = true	
    EventMgr.Dispatch(EventType.RewardPanel_Close);
    EventMgr.Dispatch(EventType.Money_Update);
    EventMgr.Dispatch(EventType.Dungeon_Group_Open)

    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end

function OnClickNext()
    local index = layout:GetCurPage()
    layout:MoveToIndex(index + 1)
end

function OnClickBack()
    local index = layout:GetCurPage()
    layout:MoveToIndex(index - 1)
end

function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg1 = nil;
    black = nil;
    goShaderRaw = nil;
    shaderObj = nil;
    txtTitle1 = nil;
    txtMask = nil;
    shaderRoot = nil;
    shaderCamera = nil;
    shaderNode = nil;
    shader2 = nil;
    node = nil;
    hpage = nil;
    sr = nil;
    Content = nil;
    bar = nil;
    points = nil;
    mask2 = nil;
    barAction = nil;
    view = nil;
end
----#End#----
