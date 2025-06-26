---@class UIFightSoulMergeView : UIBaseView
---@field model UIFightSoulMergeModel
---@field ctrl UIFightSoulMergeCtrl
---@field currentFightSoul FightSoul
---@field materialList {fightSoul:FightSoul, addImage:UnityEngine.GameObject, noImage:UnityEngine.GameObject, fightSoulInfo:UnityEngine.Transform, enable:boolean}[]
---@field chooseFightSoul FightSoul @ 选择的战魂 (主战魂或者材料 都用这一个表示)
---@field chooseMaterialIndex number @ 选择的素材index
---@field showFightSoulList FightSoul[] @ 所有可以选择的fightSoul
---@field trueShowFightSoulList FightSoul[] @ 筛选后实际显示的可以选择的fightSoul
local UIFightSoulMergeView = BaseClass("UIFightSoulMergeView",UIBaseView);
local base = UIBaseView
local this = UIFightSoulMergeView
local pfbName = "FightVisitItemMid"

local FIGHT_SOUL_MERGE_COUNT_LIMIT = tonumber(Z_Misc["FIGHT_SOUL_MERGE_COUNT_LIMIT"].Value[1])
local isChoosing = false
local isSkipAnimation = true
local recordOrder = {order = 1,kind = 1, lockFirst = true}  --是否正序  顺序类型 优先显示锁定的
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

---@param self UIFightSoulMergeView
function this.RefreshShow(self)
    UIPublic.InitButton(self.mergeButton, self.currentFightSoul ~= nil and self.hasMaterial)
    UIPublic.InitButton(self.quickChooseButton, self.currentFightSoul ~= nil)
    self.choosePanel:SetActive(isChoosing)
    self.top:SetActive(not isChoosing)
end

---@param self UIFightSoulMergeView
function this.RefreshShowFightSoul(self)
    -- 刷新显示的战魂
    self.mainFightSoul:SetActive(self.currentFightSoul ~= nil)
    if self.currentFightSoul ~= nil then
        UIPublic.InitVsFightSoulItem(self.currentFightSoul, self.mainFightSoul.transform)
        for i = 1, self.starRoot.childCount do
            local child = self.starRoot:GetChild(i - 1)
            child.gameObject:SetActive(i <= self.currentFightSoul.Star)
        end
        self.effectText.text = UIPublic.GetFightSoulEffectText(self.currentFightSoul.TemplateId, self.currentFightSoul.Star)
    end
    self.currentInfo:SetActive(self.currentFightSoul ~= nil)
    self.noneImage:SetActive(self.currentFightSoul == nil)
    if self.currentFightSoul ~= nil then
        self.currentMaxLevelText.text = "MAX LV." .. self.currentFightSoul.maxLevel
    end
    self.nextInfo:SetActive(self.hasMaterial)
end

---@param self UIFightSoulMergeView
---@param materialIndex number | nil @ 主战魂 : nil; 材料 : 对应索引 1-4
function this.OpenChooosePanel(self, materialIndex)
    for key, value in pairs(recordOrder) do
        value = 1
    end
    for key, value in pairs(screenTypes) do
        value = 0
    end
    self.sortButton:SetActive(materialIndex == nil)
    self.screenBtn:SetActive(materialIndex == nil)

    isChoosing = true
    this.RefreshShow(self)

    self.chooseMaterialIndex = materialIndex
    this.RefreshChoosePanel(self)
end

---@param self UIFightSoulMergeView
function this.RefreshChoosePanel(self)
    self.showFightSoulList = {}
    if self.chooseMaterialIndex == nil then
        -- 主战魂
        for key, value in pairs(self.model.fightSoulList) do
            table.insert(self.showFightSoulList, value)
        end
    else
        -- 材料
        local nowChooseIds = {}
        for key, value in pairs(self.materialList) do
            if self.chooseMaterialIndex ~= key and value.fightSoul ~= nil then
                table.insert(nowChooseIds, value.fightSoul.Id)
            end
        end
        self.chooseFightSoul = self.materialList[self.chooseMaterialIndex].fightSoul
        for key, value in pairs(self.model.fightSoulList) do
            if value.TemplateId == self.currentFightSoul.TemplateId and value.Id ~= self.currentFightSoul.Id and not table.contains(nowChooseIds, value.Id) then
                -- 同类型 + 不是同一个
                table.insert(self.showFightSoulList, value)
            end
        end
    end
    this.RefreshFightSoulListData(self)
    this.RefreshFightSoulList(self)
end

---@param self UIFightSoulMergeView
function this.RefreshFightSoulListData(self)
    self.trueShowFightSoulList = {}
    for k,v in table.pairsByKeys(self.showFightSoulList) do
        table.insert(self.trueShowFightSoulList,v)
    end
    self.trueShowFightSoulList = UIPublic.FightSoulScreenFunc(self.trueShowFightSoulList,screenTypes)
    table.sort(self.trueShowFightSoulList, function(a,b) return UIPublic.FightSoulSortFunc(a,b,recordOrder)end )

    if recordOrder.order ~= 1 then
        self.trueShowFightSoulList = table.reverseTable(self.trueShowFightSoulList)
    end
end

---@param self UIFightSoulMergeView
function this.RefreshFightSoulList(self)
    -- self.vs_hint:SetActive(table.count(self.fightSoulShowList) == 0)
    self.scroll:RefreshData(self.trueShowFightSoulList)
end

---@param self UIFightSoulMergeView
---@param fightSoul FightSoul
function this.OnChooseFightSoulItem(self, fightSoul)
    if self.chooseMaterialIndex ~= nil and fightSoul.Lock then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(2037)) -- 该战魂已被锁定
        return
    end
    if self.chooseFightSoul ~= nil and fightSoul.Id == self.chooseFightSoul.Id then
        self.chooseFightSoul = nil
    else
        self.chooseFightSoul = fightSoul
    end
end

---@param self UIFightSoulMergeView
function this.AddMainFightSoulButton(self)
    self.chooseFightSoul = self.currentFightSoul
    this.OpenChooosePanel(self)
end

--- 刷新整体的材料显示
---@param self UIFightSoulMergeView
function this.RefreshMaterialShow(self, index)
    if self.currentFightSoul == nil then
        return
    end
    if self.materialList[index].fightSoul == nil then
        self.materialList[index].fightSoulInfo.gameObject:SetActive(false)
    else
        self.materialList[index].fightSoulInfo.gameObject:SetActive(true)
        UIPublic.InitVsFightSoulItemMId(self.materialList[index].fightSoul, self.materialList[index].fightSoulInfo)
    end

    local star = self.currentFightSoul.Star
    self.hasMaterial = false
    for key, value in pairs(self.materialList) do
        if not value.enable then
            value.fightSoul = nil
        else
            if value.fightSoul ~= nil then
                star = star + value.fightSoul.Star
                self.hasMaterial = true
            end
        end
    end

    if star >= FIGHT_SOUL_MERGE_COUNT_LIMIT then
        star = FIGHT_SOUL_MERGE_COUNT_LIMIT
    end
    self.nextInfo:SetActive(self.hasMaterial)
    if self.hasMaterial then
        self.nextEffectText.text = UIPublic.GetFightSoulEffectText(self.currentFightSoul.TemplateId, star)
        for i = 1, self.nextStarRoot.childCount do
            local child = self.nextStarRoot:GetChild(i - 1)
            child.gameObject:SetActive(i <= star)
        end
        self.nextMaxLevelText.text = "MAX LV." .. UIPublic.GetFightSoulMaxLevelByStar(star)
    end
end

function this.OnScreen(self)
    local uiData = {}
    uiData.recordOrder = recordOrder
    uiData.screenTypes = screenTypes
    uiData.callBack = function(list,kind)
        screenTypes = table.clone(list)
        recordOrder.kind = kind
        this.RefreshFightSoulListData(self)
        this.RefreshFightSoulList(self)
        self.scroll:MoveTop()
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulSort, uiData)
end


function this.OnSort(self)
    recordOrder.order = (recordOrder.order == 1 and {2}or {1})[1]
    this.RefreshSortButton(self)
    this.RefreshFightSoulListData(self)
    this.RefreshFightSoulList(self)
end

--- 刷新排序按钮显示
---@param self UIFightSoulMergeView
function this.RefreshSortButton(self)
    local txt = self.sortButton.transform:Find("Text"):GetComponent("Text")
    txt.text = (recordOrder.order == 1 and {LangUtil.GetSysLang(154)} or {LangUtil.GetSysLang(153)})[1]
end

--- 清空材料 1.选择主战魂, 2.清空主战魂, 3.融合成功, 4.初始化
---@param self UIFightSoulMergeView
function this.ClearMaterialData(self)
    for index, value in ipairs(self.materialList) do
        value.fightSoul = nil
    end
    local showCount
 
    if self.currentFightSoul == nil then
        showCount = FIGHT_SOUL_MERGE_COUNT_LIMIT
    else
        showCount = FIGHT_SOUL_MERGE_COUNT_LIMIT - self.currentFightSoul.Star
    end
    for index, value in ipairs(self.materialList) do
        if index <= showCount then
            value.addImage:SetActive(true)
            value.noImage:SetActive(false)
            self.materialList[index].enable = true
        else
            value.addImage:SetActive(false)
            value.noImage:SetActive(true)
            self.materialList[index].enable = false
        end
        value.fightSoulInfo.gameObject:SetActive(false)
        this.RefreshMaterialShow(self, index)
    end

end

--- 点击一圈的素材
---@param self UIFightSoulMergeView
function this.OnClickMaterial(self, materialIndex)
    if self.materialList[materialIndex].enable == false then
        return
    end
    local star = self.currentFightSoul.Star
    for key, value in pairs(self.materialList) do
        if value.fightSoul ~= nil then
            star = star + value.fightSoul.Star
        end
    end
    if self.materialList[materialIndex].fightSoul == nil and star >= FIGHT_SOUL_MERGE_COUNT_LIMIT then
        -- 点了空位置 并且已经满了
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1160))
        return
    end
    this.OpenChooosePanel(self, materialIndex)
end

---@param self UIFightSoulMergeView
function this.OnConfirmChooseButton(self)
    if self.chooseMaterialIndex == nil then
        -- 选择主战魂
        if self.currentFightSoul ~= self.chooseFightSoul then
            self.currentFightSoul = self.chooseFightSoul
            this.RefreshShowFightSoul(self)
            this.ClearMaterialData(self)
        end
    else
        -- 选择材料
        if self.materialList[self.chooseMaterialIndex].fightSoul ~= self.chooseFightSoul then
            self.materialList[self.chooseMaterialIndex].fightSoul = self.chooseFightSoul
            this.RefreshMaterialShow(self, self.chooseMaterialIndex)
        end
    end
    isChoosing = false
    this.RefreshShow(self)
end

function this.OnCancelChooseButton(self)
    isChoosing = false
    this.RefreshShow(self)
end

function this.OnMerge(self)
    ---@type protocol.FightSoulMergeReq
    local req = {}
    req.uid = self.currentFightSoul.Id
    req.materials = {}
    for key, value in pairs(self.materialList) do
        if value.fightSoul ~= nil then
            table.insert(req.materials, value.fightSoul.Id)
        end
    end
    this.ClearMaterialData(self)
    this.RefreshShowFightSoul(self)
    coroutine.start(function()
        ---@type protocol.FightSoulDecomposeResp
        local fightSoulReq = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.FightSoulMergeReq, req)
    end)
end

--- 快速放置战魂素材
---@param self UIFightSoulMergeView
function this.QuickChoose(self)
    if self.currentFightSoul == nil then
        return
    end
    ---@type FightSoul[]
    local allSameFightSouls = {}
    for index, value in ipairs(Game.Scene.Player:GetComponent("FightSoulComponent"):GetSameFightSoulList(self.currentFightSoul.TemplateId)) do
        if value.Id ~= self.currentFightSoul.Id
            and value.level == 1
            and value.exp == 0
            and value.Star == 1
            and not value.Lock then
            table.insert(allSameFightSouls, value)
        end
    end
    for index, value in ipairs(self.materialList) do
        if value.enable then
            value.fightSoul = allSameFightSouls[index]
            this.RefreshMaterialShow(self, index)
        end
    end
    this.RefreshShow(self)
end

---@param self UIFightSoulMergeView
function this.OnLangCreate(self)
    LangUtil.BindText(self.langRc:GetObject("TitleText")).text = LangUtil.GetSysLang(257)
    LangUtil.BindText(self.langRc:GetObject("CancelText")).text = LangUtil.GetSysLang(146)
    LangUtil.BindText(self.langRc:GetObject("ConfirmText")).text = LangUtil.GetSysLang(1159)
    LangUtil.BindText(self.screenBtn.transform:Find("Text")).text = LangUtil.GetSysLang(155)
    LangUtil.BindText(self.langRc:GetObject("MergeText")).text = LangUtil.GetSysLang(260)
    LangUtil.BindText(self.langRc:GetObject("QuickChooseText")).text = LangUtil.GetSysLang(1167) -- 快速放置
    LangUtil.BindText(self.langRc:GetObject("SkipAnimationText")).text = LangUtil.GetSysLang(1168) -- 跳过动画
    LangUtil.BindText(self.sortButton.transform:Find("Text"))
    self.effectText = LangUtil.BindText(self.langRc:GetObject("EffectText"))
    self.nextEffectText = LangUtil.BindText(self.langRc:GetObject("NextEffectText"))

    self.currentMaxLevelText = LangUtil.BindText(self.langRc:GetObject("CurrentMaxLevelText"))
    self.nextMaxLevelText = LangUtil.BindText(self.langRc:GetObject("NextMaxLevelText"))
end

---@param self UIFightSoulMergeView
function this.OnCreate(self)
    base.OnCreate(self)
    self.currentFightSoul = nil
    self.hasMaterial = false
    self.mainFightSoul = self.rc:GetObject("MainFightSoul")

    self.top = self.rc:GetObject("Top")
    self.returnButton = self.rc:GetObject("ReturnButton")
    UIUtil.AddBtnEvent(self.returnButton, function(v)
        if isChoosing then
            this.OnCancelChooseButton(self)
        else
            self.ctrl.CloseSelf()
            if self.callback ~= nil then
                self.callback()
            end
        end
    end)

    self.addMainFightSoulButton = self.rc:GetObject("AddMainFightSoulButton")
    UIUtil.AddBtnEvent(self.addMainFightSoulButton, function(v) this.AddMainFightSoulButton(self) end)

    self.choosePanel = self.rc:GetObject("ChoosePanel")
    isChoosing = false
    
    self.materialList = {}
    self.materialRoot = self.rc:GetObject("MaterialRoot").transform
    for i = 0, self.materialRoot.childCount - 1 do
        local child = self.materialRoot:GetChild(i)
        local material = {}
        material.fightSoul = nil
        material.addImage = child:Find("AddImage").gameObject
        material.noImage = child:Find("NoImage").gameObject
        material.fightSoulInfo = child:Find("FightVisitItemMid")
        UIUtil.AddBtnEvent(child.gameObject, function(v) this.OnClickMaterial(self, i + 1) end)
        self.materialList[i + 1] = material
    end

    self.confirmButton = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(self.confirmButton, function(v) this.OnConfirmChooseButton(self) end)
    self.cancelButton = self.rc:GetObject("CancelButton")
    UIUtil.AddBtnEvent(self.cancelButton, function(v) this.OnCancelChooseButton(self) end)
    self.closeChoosePanelButton = self.rc:GetObject("CloseChoosePanelButton")
    UIUtil.AddBtnEvent(self.closeChoosePanelButton, function(v) this.OnCancelChooseButton(self) end)

    self.scrollView = self.rc:GetObject("ScrollView")
    self.showFightSoulList = {}
    self.trueShowFightSoulList = {}
    self.chooseFightSoul = nil
    ---@type VerticalScroll
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(12)
    self.scroll:Clear()
    self.scroll:ScrollInit(self.trueShowFightSoulList, self.scrollView, pfbName, function (arg)
        local gameObject = arg.go
        local fightSoul = arg.data
        local select = gameObject.transform:Find("Select").gameObject
        local NoSelect = gameObject.transform:Find("NoSelect").gameObject
        UIUtil.AddBtnEvent(gameObject,function()
            this.OnChooseFightSoulItem(self,fightSoul)
            self.scroll:RefreshData(self.trueShowFightSoulList)
        end)
        UIPublic.InitVsFightSoulItemMId(fightSoul, gameObject.transform)
        LangUtil.GetSpriteLang(52, function(sprite) select:GetComponent("Image").sprite = sprite end)
        select:SetActive(self.chooseFightSoul ~= nil and fightSoul.Id == self.chooseFightSoul.Id)
    end)

    self.sortButton = self.rc:GetObject("SortButton")
    UIUtil.AddBtnEvent(self.sortButton, function(v) this.OnSort(self) end)
    self.screenBtn = self.rc:GetObject("ScreenButton")
    UIUtil.AddBtnEvent(self.screenBtn, function() this.OnScreen(self) end)

    self.starRoot = self.rc:GetObject("StarRoot").transform
    self.nextInfo = self.rc:GetObject("NextInfo")
    self.nextStarRoot = self.rc:GetObject("NextStarRoot").transform
    self.noneImage = self.rc:GetObject("NoneImage")
    self.currentInfo = self.rc:GetObject("CurrentInfo")

    self.mergeButton = self.rc:GetObject("MergeButton")
    UIUtil.AddBtnEvent(self.mergeButton, function(v) this.OnMerge(self) end)

    self.quickChooseButton = self.rc:GetObject("QuickChooseButton")
    UIUtil.AddBtnEvent(self.quickChooseButton, function(v) this.QuickChoose(self) end)

    self.isSkipAnimation = self.rc:GetObject("IsSkipAnimation")
    self.skipAnimationButton = self.rc:GetObject("SkipAnimationButton")
    UIUtil.AddBtnEvent(self.skipAnimationButton, function(v) 
        isSkipAnimation = not isSkipAnimation
        self.isSkipAnimation:SetActive(isSkipAnimation)
    end)
    self.isSkipAnimation:SetActive(isSkipAnimation)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

---@param self UIFightSoulMergeView
function this.OnRefresh(self)
    if self.model.fightSoulId ~= nil then
        local fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(self.model.fightSoulId)
        local oldFightSoul = self.currentFightSoul
        self.currentFightSoul = fightSoul
        this.ClearMaterialData(self)
    end
    self.callback = self.model.callback
    this.RefreshSortButton(self)
    this.RefreshShow(self)
    this.RefreshShowFightSoul(self)
    for index, value in ipairs(self.materialList) do
        this.RefreshMaterialShow(self, index)
    end
end

local function ON_FIGHTSOUL_DATA_UPDATE(self)
    this.OnRefresh(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE, ON_FIGHTSOUL_DATA_UPDATE)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

---@param self UIFightSoulMergeView
function this.OnDisable(self)
    base.OnDisable(self)
end

---@param self UIFightSoulMergeView
function this.OnDestroy(self)
    base.OnDestroy(self)
    self.scroll:Dispose()
end

return this;

