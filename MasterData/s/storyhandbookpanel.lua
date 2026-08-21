---@class StoryHandbookPanel : StoryHandbookPanel_Generate
---##################### 【StoryHandbookPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【StoryHandbookPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local StoryHandbookPanel = require "StoryHandbookPanel_Generate"

---@type FiltrateGroupData[]
local storyFiltrateCfg = {
    {
        tagName = LocalStrEnum.StoryHandFiltrate_1,  -- 章节解锁
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},  -- 全部
            {itemName = LocalStrEnum.StoryUnlock_1, val = GE.StoryUnlockState.Unlocked},  -- 已解锁
            {itemName = LocalStrEnum.StoryUnlock_2, val = GE.StoryUnlockState.Locked},    -- 未解锁
        },
    },
    {
        tagName = LocalStrEnum.StoryHandFiltrate_2,  -- 图鉴收藏
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},  -- 全部
            {itemName = LocalStrEnum.StoryCollect_1, val = GE.StoryCollectState.Collected},       -- 收藏
            {itemName = LocalStrEnum.StoryCollect_2, val = GE.StoryCollectState.NotCollected},    -- 未收藏
        },
    },
    {
        tagName = LocalStrEnum.StoryHandFiltrate_3,  -- 活动类型
        selectType = FiltrateSelectType.AllMultiSelect,
        items = {
            {itemName = LocalStrEnum.skinTag_0, isDefault = true},  -- 全部
            {itemName = LocalStrEnum.StoryActivityType_1, val = GE.StoryActivityType.Normal},    -- 常规
            {itemName = LocalStrEnum.StoryActivityType_2, val = GE.StoryActivityType.Festival},  -- 节日
        },
    },
}

function StoryHandbookPanel:InitLogic(data)
    self.nowMode = 1    --当前模式 1主线故事 2活动剧情
    
    -- 排序相关
    self.nowStorySortIndex = 1      -- 当前剧情排序
    self.storySortBtnlist = {}
    self.nowStorySortFace = 1       -- 1升序 2降序
    
    -- 筛选相关
    self.allActivityStoryListData = {}  -- 所有活动剧情列表（未筛选）
    
    ---@type FiltrateData
    self.filterData = {
        groups = storyFiltrateCfg,
        callback = BindCallback_NoParams(self, self.OnFiltrateSelectCallBack)
    }
    
    -- 初始化筛选状态
    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        for j = 1, #group.items do
            group.items[j].isSelect = group.items[j].isDefault
        end
    end
end

--function StoryHandbookPanel:StartCreating(time)
--
--end

--function StoryHandbookPanel:StartEnter(time)
--
--end

--function StoryHandbookPanel:StartRemoving(time)
--
--end

--function StoryHandbookPanel:StartExit(time)
--
--end

function StoryHandbookPanel:OnOpen(data, initiative)
    self._isPlayingOut = false
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HandbooksStory, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self:playOutAndClose()
    end)
    if self.nowMode ~= nil then
        self:SelectToggle(self.nowMode, true)
    else
        self:SelectToggle(1, true)
    end
end

--- 播放退出动画并关闭；安卓 AB 下 out 状态 speed=4 且事件在末帧，AnimCallBack 易被跳过
function StoryHandbookPanel:playOutAndClose()
    if self._isPlayingOut then
        return
    end
    self._isPlayingOut = true
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false

    local finished = false
    local function finish()
        if finished then
            return
        end
        finished = true
        self._isPlayingOut = false
        UIMgr:closeSpecificUI(self)
        self.customBackPanel.customBackPanel:ClearBackFunc()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    end

    self.animator.enabled = true
    -- SetCallBack 与 DoAfter 委托签名不同，不能共用同一个 lua 函数引用
    self.animOverCallBack:SetCallBack(function()
        finish()
    end)
    -- 强制从头播 out，避免停在 out 末态时 SetTrigger 不重播事件
    self.animator:Play("out", 0, 0)
    self.animator:Update(0)
    -- out 时长 1s / speed 4 ≈ 0.25s，留余量兜底
    self:DoAfter(0.4, function()
        finish()
    end)
end

--- 生成主线故事列表
function StoryHandbookPanel:GenerateMainStoryList()
    -- 遍历PlotChapter表，筛选type为1的主线剧情
    local allPlotChapters = Config.GetAllConfig("PlotChapterTable")
    if not allPlotChapters then
        return
    end

    local mainStoryList = {}
    for id, plotChapter in pairs(allPlotChapters) do
        if plotChapter.type == 1 then
            table.insert(mainStoryList, plotChapter)
        end
    end

    -- 按id或order排序（根据实际需要调整）
    table.sort(mainStoryList, function(a, b)
        return a.timeline < b.timeline
    end)
    local dataCount = tablex.size(mainStoryList)
    -- 使用PlotBox生成在MainStoryList里，末尾多一格用于显示LastOne
    self:FillTemplateContent(self.plotBox, self.mainStoryList, dataCount + 1, function(index, plotBox)
        plotBox:SetActive(true)
        if index > dataCount then
            plotBox.lastOne:SetActive(true)
            plotBox.btn:SetActive(false)
            return
        end
        plotBox.lastOne:SetActive(false)
        plotBox.btn:SetActive(true)

        local plotChapterData = mainStoryList[index]
        -- 检查解锁状态：从剧情图鉴里根据id查
        local isUnlocked = Me:isHandbookUnlocked(GE.HandbookType.Story, plotChapterData.id)
        if plotBox.isLock then
            plotBox.isLock:SetActive(not isUnlocked)
        end

        -- 设置剧情标题和简介
        plotBox.nameTxt.text.text = plotChapterData.title or ""
        plotBox.msgTxt.text.text = plotChapterData.synopsis or ""

        if plotBox.msgBg then
            plotBox.msgBg:SetActive(isUnlocked)
        end

        local backGround = string.format(Config.SpritePath.PlotBgPath, plotChapterData.backGround)
        plotBox.plotImg:SetActive(true)
        self:LoadSpriteAsync(backGround, plotBox.plotImg.image)

        -- 绑定点击事件
        plotBox.btn.scaleButton.onClick:RemoveAllListeners()
        plotBox.btn.scaleButton.onClick:AddListener(function()
            if not isUnlocked then
                return
            end
            UIMgr:popUI("StoryListPanel", {plotChapterId = plotChapterData.id})
        end)
    end)
end

--- 生成活动剧情列表
function StoryHandbookPanel:GenerateActivityStoryList()
    -- 只在第一次加载所有活动剧情配置
    if tablex.size(self.allActivityStoryListData) == 0 then
        local allPlotChapters = Config.GetAllConfig("PlotChapterTable")
        if not allPlotChapters then
            return
        end
        
        for _, plotChapter in pairs(allPlotChapters) do
            if plotChapter.type == 2 then
                table.insert(self.allActivityStoryListData, plotChapter)
            end
        end
    end
     
    -- 应用筛选
    local activityStoryList = self:FiltrateStories()
    
    -- 应用排序
    self:setStorySortView(activityStoryList)

    local dataCount = #activityStoryList
    -- 使用storyLineBox生成在StoryLineList里，末尾多一格用于显示LastOne
    self:FillTemplateContent(self.storyLineBox, self.storyLineList, dataCount + 1, function(index, storyLineBox)
        storyLineBox:SetActive(true)
        if index > dataCount then
            storyLineBox.lastOne:SetActive(true)
            storyLineBox.btn:SetActive(false)
            return
        end
        storyLineBox.lastOne:SetActive(false)
        storyLineBox.btn:SetActive(true)

        local plotChapterData = activityStoryList[index]
        storyLineBox.storyNameTxt.text.text = plotChapterData.title or ""

        local needTag = tablex.next(plotChapterData.tag)
        if needTag then
            storyLineBox.tagBg:SetActive(needTag ~= nil)
            storyLineBox.tagTxt.text.text = LocalStrEnum["PlotTag_txt_"..plotChapterData.tag[1]] or ""
            storyLineBox.tagBg.image.color = Color.NewFromStr(plotChapterData.tag[2])
        end

        storyLineBox.isCollect:SetActive(Me:isHandbookCollected(GE.HandbookType.Story, plotChapterData.id))
        storyLineBox.collectBtn.scaleButton.onClick:RemoveAllListeners()
        storyLineBox.collectBtn.scaleButton.onClick:AddListener(function()
            --请求收藏剧情图鉴
            Me:setHandbookCollectedReq({bookType = GE.HandbookType.Story, id = plotChapterData.id},function()
                storyLineBox.isCollect:SetActive(Me:isHandbookCollected(GE.HandbookType.Story, plotChapterData.id))
            end)
        end)

        local backGround = string.format(Config.SpritePath.PlotBgPath, plotChapterData.backGround)
        storyLineBox.storyImg:SetActive(true)
        self:LoadSpriteAsync(backGround, storyLineBox.storyImg.image)

        storyLineBox.storyMsgTxt.text.text = plotChapterData.synopsis or ""
        local isUnlocked = Me:isHandbookUnlocked(GE.HandbookType.Story, plotChapterData.id)
        if storyLineBox.isLock then
            storyLineBox.isLock:SetActive(not isUnlocked)
        end

        -- 绑定点击事件
        storyLineBox.btn.scaleButton.onClick:RemoveAllListeners()
        storyLineBox.btn.scaleButton.onClick:AddListener(function()
            if not isUnlocked then
                return
            end
            UIMgr:popUI("StoryListPanel", {plotChapterId = plotChapterData.id})
        end)
    end)
end

--- 选择切换按钮
---@param index number 按钮索引
---@param refresh boolean 是否强制刷新
function StoryHandbookPanel:SelectToggle(index, refresh)
    if self.nowMode == index and not refresh then
        return
    end
    self.nowMode = index

    self.mainStoryBtn.bg:SetActive(self.nowMode ~= 1)
    self.mainStoryBtn.isOn:SetActive(self.nowMode == 1)
    self.activeStoryBtn.bg:SetActive(self.nowMode ~= 2)
    self.activeStoryBtn.isOn:SetActive(self.nowMode == 2)
    self.mainStoryMode:SetActive(self.nowMode == 1)
    self.storyLineMode:SetActive(self.nowMode == 2)

    -- 仅在对应 Mode 激活后再生成列表并绑定 onClick。
    -- FillTemplateContent 在安卓 AB 走 InstantiateAsync；对 inactive 节点绑点击，监听器易丢失
    -- （ScaleButton 按下缩放仍在，表现为“有动画无回调”）
    if self.nowMode == 1 then
        self:GenerateMainStoryList()
    else
        self:StorySortInfo()
        self:GenerateActivityStoryList()
    end
end

-------------------------------排序-----------------------------------------
--剧情排序初始化
function StoryHandbookPanel:StorySortInfo()
    local nowType = GE.StoryHandBookSortType[GE.StoryHandBookSortTypeName[self.nowStorySortIndex]]
    self.sortTxt.text.text = LocalStrEnum["storyHandFilterType"..nowType]
    self.storySortBtnlist = {}
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.StoryHandBookSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.storySortBtnlist, temp)
        sortTypeBtn:SetActive(true)
        sortTypeBtn.sortTypeTxtOff.text.text = LocalStrEnum["storyHandFilterType"..GE.StoryHandBookSortType[GE.StoryHandBookSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text = LocalStrEnum["storyHandFilterType"..GE.StoryHandBookSortType[GE.StoryHandBookSortTypeName[index]]]
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            if self.nowStorySortIndex ~= index then
                self.nowStorySortIndex = index
                local nowType = GE.StoryHandBookSortType[GE.StoryHandBookSortTypeName[self.nowStorySortIndex]]
                self.sortTxt.text.text = LocalStrEnum["storyHandFilterType"..nowType]
                self:GenerateActivityStoryList()
            end
            self.sortSelectList:SetActive(false)
            self.sortMask:SetActive(false)
        end)
    end)
end

--设置剧情排序详情
function StoryHandbookPanel:setStorySortView(storyList)
    local ascending = self.nowStorySortFace == 1
    
    table.sort(storyList, function(a, b)
        local primaryA, primaryB
        local secondaryA, secondaryB
        
        -- 根据排序类型获取比较值
        if self.nowStorySortIndex == 1 then
            -- 默认排序（按id）
            primaryA = a.id
            primaryB = b.id
            secondaryA = a.id
            secondaryB = b.id
        elseif self.nowStorySortIndex == 2 then
            -- 剧情顺序（这里先用id，你可以根据实际字段修改）
            -- TODO: 如果有专门的剧情顺序字段，请在这里替换
            primaryA = a.id  -- 或者 a.order 或其他字段
            primaryB = b.id  -- 或者 b.order 或其他字段
            secondaryA = a.id
            secondaryB = b.id
        end
        
        -- 主要排序比较
        if primaryA ~= primaryB then
            if ascending then
                return primaryA < primaryB
            else
                return primaryA > primaryB
            end
        end
        
        -- 次要排序比较（默认按id升序）
        if secondaryA and secondaryB then
            return secondaryA < secondaryB
        end
        
        return false
    end)
end

--刷新排序显示
function StoryHandbookPanel:refreshSortView()
    for k,v in pairs(self.storySortBtnlist) do
        v.obj.isOpen:SetActive(v.key == self.nowStorySortIndex)
    end
end

---筛选回调
function StoryHandbookPanel:OnFiltrateSelectCallBack(filtrateOperation)
    if filtrateOperation == nil then
        return
    end

    -- 更新筛选状态
    -- filtrateOperation[i] 包含第i组中被选中项的索引数组
    for i = 1, #self.filterData.groups do
        local g = filtrateOperation[i]
        
        if g == nil then
            goto continue
        end
        
        local group = self.filterData.groups[i]
        
        -- 先将所有项设为未选中
        for j = 1, #group.items do
            group.items[j].isSelect = false
        end
        
        -- 然后将返回数组中的索引对应项设为选中
        for _, selectedIndex in ipairs(g) do
            if selectedIndex >= 1 and selectedIndex <= #group.items then
                group.items[selectedIndex].isSelect = true
            end
        end
        
        ::continue::
    end

    -- 重新筛选并刷新显示
    self:GenerateActivityStoryList()
end

---筛选剧情列表
---@return table 筛选后的剧情配置列表
function StoryHandbookPanel:FiltrateStories()
    local unlockStateList = {}      -- 解锁状态筛选条件
    local collectStateList = {}     -- 收藏状态筛选条件
    local activityTypeList = {}     -- 活动类型筛选条件
    
    local filterLists = {unlockStateList, collectStateList, activityTypeList}
    
    -- 解析筛选条件
    for i = 1, #self.filterData.groups do
        local group = self.filterData.groups[i]
        local filterList = filterLists[i]
        
        if group.selectType == FiltrateSelectType.AllMultiSelect then
            local allSelected = false
            for j = 1, #group.items do
                local item = group.items[j]
                if item.isSelect then
                    if item.isDefault then
                        -- 选中"全部"
                        allSelected = true
                        break
                    else
                        table.insert(filterList, item.val)
                    end
                end
            end
            -- 如果选中"全部"，filterList保持为空，表示不筛选这个维度
            if allSelected then
                filterList = {}
                filterLists[i] = filterList
            end
        end
    end
    
    -- 筛选剧情
    local result = {}
    
    for _, plotChapter in pairs(self.allActivityStoryListData) do
        local plotId = plotChapter.id
        
        -- 筛选解锁状态
        if #unlockStateList > 0 then
            local isUnlocked = Me:isHandbookUnlocked(GE.HandbookType.Story, plotId)
            local matchUnlock = false
            for _, state in ipairs(unlockStateList) do
                if (state == GE.StoryUnlockState.Unlocked and isUnlocked) or 
                   (state == GE.StoryUnlockState.Locked and not isUnlocked) then
                    matchUnlock = true
                    break
                end
            end
            if not matchUnlock then
                goto continue
            end
        end
        
        -- 筛选收藏状态
        if #collectStateList > 0 then
            local isCollected = Me:isHandbookCollected(GE.HandbookType.Story, plotId)
            local matchCollect = false
            for _, state in ipairs(collectStateList) do
                if (state == GE.StoryCollectState.Collected and isCollected) or 
                   (state == GE.StoryCollectState.NotCollected and not isCollected) then
                    matchCollect = true
                    break
                end
            end
            if not matchCollect then
                goto continue
            end
        end
        
        -- 筛选活动类型
        if #activityTypeList > 0 then
            -- 从tag[1]获取活动类型
            local plotTagType = plotChapter.tag and plotChapter.tag[1] or nil
            if not plotTagType then
                -- 如果没有tag信息，默认跳过
                goto continue
            end
            
            local matchActivity = false
            for _, aType in ipairs(activityTypeList) do
                -- GE.StoryActivityType.Normal(1) 对应 GE.PlotTagType.Normal(1)
                -- GE.StoryActivityType.Festival(2) 对应 GE.PlotTagType.Festival(2)
                if plotTagType == aType then
                    matchActivity = true
                    break
                end
            end
            if not matchActivity then
                goto continue
            end
        end
        
        table.insert(result, plotChapter)
        ::continue::
    end
    
    return result
end
-----------------------------------------------------------------------------

--function StoryHandbookPanel:OnClose(initiative)
--
--end

--function StoryHandbookPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function StoryHandbookPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/StoryLineMode/SortPanel/SortBg/SortBtn onClick 
--]]
function StoryHandbookPanel:sortBtn_ScaleButton_onClick(sortBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        self:refreshSortView()
    end
end

--[[
/AdjustRoot/StoryLineMode/SortPanel/SortBg/SortStateBtn onClick 
--]]
function StoryHandbookPanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowStorySortFace == 1 then
        self.nowStorySortFace = 2
    elseif self.nowStorySortFace == 2 then
        self.nowStorySortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowStorySortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowStorySortFace == 1)
    self:GenerateActivityStoryList()
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/AdjustRoot/StoryLineMode/SortPanel/FiltrateBtn onClick 
--]]
function StoryHandbookPanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("SkinGoodsFiltrateBox", self.filterData)
end

--[[
/AdjustRoot/StoryLineMode/SortPanel/SortMask onClick 
--]]
function StoryHandbookPanel:sortMask_Button_onClick(sortMask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/AdjustRoot/ToggleBg/MainStoryBtn onClick 
--]]
function StoryHandbookPanel:mainStoryBtn_ScaleButton_onClick(mainStoryBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SelectToggle(1)
end

--[[
/AdjustRoot/ToggleBg/ActiveStoryBtn onClick 
--]]
function StoryHandbookPanel:activeStoryBtn_ScaleButton_onClick(activeStoryBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SelectToggle(2)
end

return StoryHandbookPanel
