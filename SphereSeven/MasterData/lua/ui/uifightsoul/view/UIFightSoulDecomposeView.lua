--
-- <代码文件解释说明>
--

---@class UIFightSoulDecomposeView : UIBaseView
---@field model UIFightSoulDecomposeModel
---@field ctrl UIFightSoulDecomposeCtrl
local UIFightSoulDecomposeView = BaseClass("UIFightSoulDecomposeView",UIBaseView)
local base = UIBaseView
local this = UIFightSoulDecomposeView

local PrefabName = "FightVisitItemMid_Decompose"

local FIGHT_SOUL_DECOMPOSE_SHOW_ITEM_ID = tonumber(Z_Misc["FIGHT_SOUL_DECOMPOSE_SHOW_ITEM_ID"].Value[1])
local FIGHT_SOUL_DECOMPOSE_LIMIT = tonumber(Z_Misc["FIGHT_SOUL_DECOMPOSE_LIMIT"].Value[1])

local recordOrder = {order = 1,kind = 1, lockFirst = true, firstChooseFuns = nil}  --是否正序  顺序类型 优先显示锁定的
local screenTypes = {
    --- 职业
    abiliType = 0,
    --- 星级
    star = 0, 
    --- 稀有度
    rare = 0,
    --- 是否装备
    isEquip = 0
}

local rareType = {
    [Rarity.R] = true,
    [Rarity.SR] = false,
    [Rarity.SSR] = false,
}

local statusType = {
    isLevelUp = FightSoulScreenType.isLevelUp.None,
    isMerge = FightSoulScreenType.isMerge.None,
}

---@param self UIFightSoulDecomposeView
local function InitNumTxt(self)
    self.rewards = {}
    self.rewardIds = {}
    for key, value in pairs(self.chooseFightSouls) do
        local rare = value.config.Rare
        local rewardId = Z_FightSoulDecompose[rare].RewardId
        local rewardList = Z_Reward[rewardId]
        for _, v in ipairs(rewardList) do
            if self.rewards[v.ObjId] == nil then
                self.rewards[v.ObjId] = v.Count * value.Star
                table.insert(self.rewardIds, v.ObjId)
            else
                self.rewards[v.ObjId] = self.rewards[v.ObjId] + v.Count * value.Star
            end
        end
    end
    if self.rewardIds[1] ~= nil then
        local id = self.rewardIds[1]
        self.item1.gameObject:SetActive(true)
        UIUtil.SetSprite(self.item1,AtlasConfig.Item,GetItemIcon(Z_Item[id]),true)
        self.item1Count.text = "x" .. self.rewards[id]
    else
        self.item1.gameObject:SetActive(false)
    end
    
    if self.rewardIds[2] ~= nil then
        local id = self.rewardIds[2]
        self.item2.gameObject:SetActive(true)
        UIUtil.SetSprite(self.item2,AtlasConfig.Item,GetItemIcon(Z_Item[id]),true)
        self.item2Count.text = "x" .. self.rewards[id]
    else
        self.item2.gameObject:SetActive(false)
    end

    self:InitButton()
end

function this:InitButton()
    local _bool = false
    if table.count(self.chooseIds)>0 then
        _bool = true
    end
    self.getItem.gameObject:SetActive(_bool)
    UIPublic.InitButton(self.confirmButton,_bool,1)
end

---@param self UIFightSoulDecomposeView
local function OnScreen(self)
    local uiData = {}
    uiData.recordOrder = recordOrder
    uiData.screenTypes = screenTypes
    uiData.callBack = function(list,kind)
        screenTypes = table.clone(list)
        recordOrder.kind = kind
        self:RefreshFightSoulListData()
        self:RefreshFightSoulList()
        self.scroll:MoveTop()
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulSort,uiData)
end

---@param self UIFightSoulDecomposeView
local function OnSort(self)
    recordOrder.order = (recordOrder.order == 1 and {2}or {1})[1]
    self:RefreshSortButton()
    self:RefreshFightSoulListData()
    self:RefreshFightSoulList()
end

---@param self UIFightSoulDecomposeView
local function OnQuickSelectButton(self)
    local uiData = {}
    uiData.rareType = rareType
    uiData.statusType = statusType
    uiData.callBack = function(rare, status)
        rareType = rare
        statusType = status
        self:QuickFilter()
        self:RefreshFightSoulList()
        self.scroll:MoveTop()
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulFilter,uiData)
end

--- 刷新排序按钮显示
function this:RefreshSortButton()
    local txt = self.sortButton.transform:Find("Text"):GetComponent("Text")
    txt.text = (recordOrder.order == 1 and {LangUtil.GetSysLang(154)} or {LangUtil.GetSysLang(153)})[1]
end

function this:RefreshFightSoulListData()
    self.fightSoulShowList = {}
    for k,v in table.pairsByKeys(self.model.fightSoulList) do
        table.insert(self.fightSoulShowList,v)
    end
    self.fightSoulShowList = UIPublic.FightSoulScreenFunc(self.fightSoulShowList,screenTypes)
    table.sort(self.fightSoulShowList, function(a,b) return UIPublic.FightSoulSortFunc(a,b,recordOrder)end )

    if recordOrder.order ~= 1 then
        self.fightSoulShowList = table.reverseTable(self.fightSoulShowList)
    end
end

function this:QuickFilter()
    self.chooseFightSouls = {}
    self.chooseIds = {}
    local count = 0
    ---@param fightSoul FightSoul
    for _, fightSoul in ipairs(self.fightSoulShowList) do
        if rareType[fightSoul.config.Rare] and not fightSoul.Lock and not fightSoul.isEquip then
            if statusType.isLevelUp == FightSoulScreenType.isLevelUp.None or 
                (statusType.isLevelUp == FightSoulScreenType.isLevelUp.LevelUp and fightSoul.level > 1) or
                (statusType.isLevelUp == FightSoulScreenType.isLevelUp.NotLevelUp and fightSoul.level == 1)
            then
                if statusType.isMerge == FightSoulScreenType.isMerge.None then
                    self.chooseFightSouls[fightSoul.Id] = fightSoul
                    table.insert(self.chooseIds, fightSoul.Id)
                    count = count + 1
                    if count >= FIGHT_SOUL_DECOMPOSE_LIMIT then
                        break
                    end
                elseif statusType.isMerge == FightSoulScreenType.isMerge.Merge then
                    if fightSoul.Star > 1 then
                        self.chooseFightSouls[fightSoul.Id] = fightSoul
                        table.insert(self.chooseIds, fightSoul.Id)
                        count = count + 1
                        if count >= FIGHT_SOUL_DECOMPOSE_LIMIT then
                            break
                        end
                    end
                else
                    if fightSoul.Star == 1 then
                        self.chooseFightSouls[fightSoul.Id] = fightSoul
                        table.insert(self.chooseIds, fightSoul.Id)
                        count = count + 1
                        if count >= FIGHT_SOUL_DECOMPOSE_LIMIT then
                            break
                        end
                    end
                end
            end
        end
    end
end

function this:RefreshFightSoulList()
    self.hint:SetActive(table.count(self.fightSoulShowList) == 0)
    self.scroll:RefreshData(self.fightSoulShowList)
    InitNumTxt(self)
end

function this:OnDecompose()
    if table.count(self.chooseIds) == 0 then 
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1306)) -- 没有选择战魂
        return
    end
    local req = {}
    req.uids = {}
    for k,v in pairs(self.chooseIds) do
        table.insert(req.uids,v)
    end

    ---@type ToolTipGetItemData
    local uiData = {}
    uiData.itemText = LangUtil.GetSysLang(252) -- 分解可获得
    uiData.items = {}
    if self.rewardIds[1] ~= nil then
        uiData.items[1] = {}
        uiData.items[1].id = self.rewardIds[1]
        uiData.items[1].count = self.rewards[self.rewardIds[1]]
    end
    if self.rewardIds[2] ~= nil then
        uiData.items[2] = {}
        uiData.items[2].id = self.rewardIds[2]
        uiData.items[2].count = self.rewards[self.rewardIds[2]]
    end

    uiData.callBack = function()
        coroutine.start(function()
            ---@type protocol.FightSoulDecomposeResp
            local fightSoulReq = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.FightSoulDecomposeReq, req)
            UIPublic.OpenRewardUI(fightSoulReq.reward_results)
            self.chooseIds = {}
            self.chooseFightSouls = {}
            InitNumTxt(self)
        end)
    end

    local hasSRorSSR = false
    local hasLevelUp = false
    local hasMerge = false
    local hasIsEquip = false

    ---@param value FightSoul
    for key, value in pairs(self.chooseFightSouls) do
        if not hasSRorSSR and value.config.Rare == Rarity.SR or value.config.Rare == Rarity.SSR then
            hasSRorSSR = true
        end
        if not hasLevelUp then
            if value.level > 1 or value.exp > 0 then
                hasLevelUp = true
            end
        end
        if not hasMerge and value.Star > 1 then
            hasMerge = true
        end
        
        if value.isEquip then
            hasIsEquip = true
        end
    end

    local bottomText = {}
    if hasIsEquip then
        -- if bottomText == nil then
        --     bottomText = LangUtil.GetSysLang(1163) -- 选中已装备的战魂
        -- else
        --     bottomText = bottomText .. "\n" .. LangUtil.GetSysLang(1163)
        -- end
        table.insert(bottomText, LangUtil.GetSysLang(1163))
    end
    if hasSRorSSR then
        -- if bottomText == nil then
        --     bottomText = LangUtil.GetSysLang(1164) -- 选中SR以上品级的战魂
        -- else
        --     bottomText = bottomText .. "\n" .. LangUtil.GetSysLang(1164)
        -- end
        table.insert(bottomText, LangUtil.GetSysLang(1164))
    end
    if hasLevelUp then
        -- if bottomText == nil then
        --     bottomText = LangUtil.GetSysLang(1165) -- 归魂中包含已升级的战魂，是否继续?
        -- else
        --     bottomText = bottomText .. "\n" .. LangUtil.GetSysLang(1165)
        -- end
        table.insert(bottomText, LangUtil.GetSysLang(1165))
    end
    if hasMerge then
        -- if bottomText == nil then
        --     bottomText = LangUtil.GetSysLang(1166) -- 归魂中包含已合成的战魂，是否继续?
        -- else
        --     bottomText = bottomText .. "\n" .. LangUtil.GetSysLang(1166)
        -- end
        table.insert(bottomText, LangUtil.GetSysLang(1166))
    end

    if table.count(bottomText) > 0 then
        uiData.topText = LangUtil.GetSysLang(787) -- 确定要进行战魂归魂吗
        uiData.bottomText = bottomText
    else
        uiData.bottomText = LangUtil.GetSysLang(787) -- 确定要进行战魂归魂吗
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipGetItem, uiData)
end

---@param self UIFightSoulDecomposeView
local function RemoveFightSoul(self,id)
    table.removebyvalue(self.chooseIds,id)
    self.chooseFightSouls[id] = nil
    InitNumTxt(self)
end

---@param self UIFightSoulDecomposeView
------@param fightSoul FightSoul
local function AddFightSoul(self, fightSoul)
    if table.any(self.chooseIds,function(v) return v == fightSoul.Id  end) then
        RemoveFightSoul(self,fightSoul.Id)
        return
    end
    if table.count(self.chooseIds) >= FIGHT_SOUL_DECOMPOSE_LIMIT then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(2030))
        return
    end
    table.insert(self.chooseIds,fightSoul.Id)
    self.chooseFightSouls[fightSoul.Id] = fightSoul
    InitNumTxt(self)
end

---@param self UIFightSoulDecomposeView
local function OnFightSoulItem(self,id)
    local fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(id)

    if fightSoul.Lock then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(2037)) -- 战魂已被锁定
        return
    end
    AddFightSoul(self,fightSoul)
    this.InitButton(self)
end

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))

    LangUtil.BindText(self.screenButton.transform:Find("Text")).text = LangUtil.GetSysLang(155)
    LangUtil.BindText(self.sortButton.transform:Find("Text"))

    self.item1Count = LangUtil.BindText(self.item1.transform:Find("Text"), FontType.All_Number)
    self.item2Count = LangUtil.BindText(self.item2.transform:Find("Text"), FontType.All_Number)

    self.getItem = LangUtil.BindText(self.langRc:GetObject("GetItem"))
    self.getItem.text = LangUtil.GetSysLang(269)
    self.holdNumText = LangUtil.BindText(self.langRc:GetObject("HoldNumValue"))
    LangUtil.BindText(self.langRc:GetObject("HoldNumText")).text = LangUtil.GetSysLang(354)
end

function this:OnCreate()
    base.OnCreate(self)
    ---@param a FightSoul
    ---@param b FightSoul
    recordOrder.firstChooseFuns = function(a, b)
        if a.isEquip ~= b.isEquip then
            return not a.isEquip and b.isEquip 
        end
        if a.Lock ~= b.Lock then
            return a.Lock
        end
        return nil
    end

    UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UIFightSoulDecompose)

    self.hint = self.rc:GetObject("Hint")
    self.chooseIds = {}
    self.chooseFightSouls = {}
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    self.cancelButton = self.rc:GetObject("CancelButton")
    self.quickSelectButton = self.rc:GetObject("QuickSelectButton")
    UIUtil.AddBtnEvent(self.confirmButton, function()
        self:OnDecompose()
    end)
    UIUtil.AddBtnEvent(self.cancelButton, function()
        self.ctrl.CloseSelf()
    end)
    UIUtil.AddBtnEvent(self.quickSelectButton, function()
        OnQuickSelectButton(self)
    end)
    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"),
        UIWindowNames.UIFightSoulDecompose,
        486
    )

    self.sortButton = self.rc:GetObject("SortButton")
    self.screenButton = self.rc:GetObject("ScreenButton")
    UIUtil.AddBtnEvent(self.screenButton, function() OnScreen(self) end)
    UIUtil.AddBtnEvent(self.sortButton, function() OnSort(self) end)

    self.item1 = self.rc:GetObject("Item1"):GetComponent("Image")
    self.item2 = self.rc:GetObject("Item2"):GetComponent("Image")

    self.fightSoulShowList = {}
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(15)
    self.scrollView = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.scroll:Clear()
    self.scroll:ScrollInit(self.fightSoulShowList, self.scrollView, PrefabName, function (arg)
        local gameObject = arg.go
        ---@type FightSoul
        local fightSoul = arg.data
        local select = gameObject.transform:Find("Select").gameObject
        local selectImage = gameObject.transform:Find("SelectImage").gameObject
        UIPublic.InitVsFightSoulItemMId(fightSoul,gameObject)
        UIUtil.AddBtnEventNoBug(gameObject, function()
            if fightSoul.isEquip or fightSoul.Lock then
                return
            end
            OnFightSoulItem(self, fightSoul.Id)
            local isSelect = table.first(self.chooseIds,function(v) return v == fightSoul.Id  end)
            select:SetActive(isSelect)
            selectImage:SetActive(isSelect)
        end)
        local isSelect = table.first(self.chooseIds,function(v) return v == fightSoul.Id  end)
        select:SetActive(isSelect or fightSoul.isEquip or fightSoul.Lock)
        selectImage:SetActive(isSelect)
    end)

end

function this:OnEnable()
    base.OnEnable(self)
    self.chooseIds = {}
    self.chooseFightSouls = {}
    self:OnRefresh()
end

function this:OnRefresh()
    self.holdNumText.text = table.count(self.model.fightSoulList).."/"..Game.Scene.Player:GetComponent("FightSoulComponent"):GetBagCapacity()
    self:RefreshSortButton()
    InitNumTxt(self)
    this.InitButton(self)
    this.RefreshFightSoulListData(self)
    this.RefreshFightSoulList(self)
end

local function OnFightSoulDataUpdate(self)
    self:OnRefresh()
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.comTopView:InitComTop(self, self:GetName())
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE, OnFightSoulDataUpdate)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

function this:OnDisable()
    base.OnDisable(self)
    screenTypes = {star = 0,rare = 0,isEquip = 0, isLevelUp = 0}
    recordOrder.order = 1
end

function this:OnDestroy()
    base.OnDestroy(self)
    self.scroll:Dispose()
end

return this
