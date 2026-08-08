---@class StoryListPanel : StoryListPanel_Generate
---##################### 【StoryListPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【StoryListPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local StoryListPanel = require "StoryListPanel_Generate"

function StoryListPanel:InitLogic(data)
    self.chapterId = nil    --章节id
    self.nowSelectIndex = nil  --当前选择的剧情索引
end

--function StoryListPanel:StartCreating(time)
--
--end

--function StoryListPanel:StartEnter(time)
--
--end

--function StoryListPanel:StartRemoving(time)
--
--end

--function StoryListPanel:StartExit(time)
--
--end

function StoryListPanel:isPlotUnlocked(plotConfig)
    for _, storyId in ipairs(plotConfig.content) do
        if not Me:isHandbookUnlocked(GE.HandbookType.Story, storyId) then
            return false
        end
    end
    return true
end

function StoryListPanel:OnOpen(data, initiative)
    self._isPlayingOut = false
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.StoryListPanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self:playOutAndClose()
    end)

    self.chapterId = data.plotChapterId
    self.plotConfigList = Config.GetPlotInfoByChapter(self.chapterId)
    table.sort(self.plotConfigList, function(a, b)
        return a.id < b.id
    end)

    -- 查找第一个已解锁的剧情；打开时只刷一次列表，避免 setView + selectBox 双重建
    local defaultSelectIndex = 1
    for index, plotConfig in ipairs(self.plotConfigList) do
        if self:isPlotUnlocked(plotConfig) then
            defaultSelectIndex = index
            break
        end
    end

    self.nowSelectIndex = defaultSelectIndex
    self:setView(false)
    self:setArtView()
end

--- 播放退出动画并关闭；安卓 AB 下 out 状态 speed=4 且事件在末帧，AnimCallBack 易被跳过
function StoryListPanel:playOutAndClose()
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
    self.animator:Play("out", 0, 0)
    self.animator:Update(0)
    self:DoAfter(0.4, function()
        finish()
    end)
end

---@param animate boolean|nil 是否播放选中尺寸动画；打开界面时传 false，切换页签时传 true
function StoryListPanel:setView(animate)
    local animDuration = animate and 0.3 or 0
    self:FillTemplateContent(self.storyBox, self.storyBoxList, tablex.size(self.plotConfigList), function(index, storyBox)
        storyBox:SetActive(true)
        local plotConfig = self.plotConfigList[index]
        storyBox.indexTxt.text.text = "[ "..index.." ]"
        storyBox.storyNameTxt.text.text = plotConfig.title

        local isUnlocked = self:isPlotUnlocked(plotConfig)
        storyBox.isNone:SetActive(not isUnlocked)
        storyBox.isLock:SetActive(not isUnlocked)
        storyBox.isOpen:SetActive(isUnlocked)

        local isSelect = self.nowSelectIndex == index
        storyBox.isSelect:SetActive(isSelect)
        if isSelect then
            storyBox.bg:SetActive(false)
            storyBox.icon:SetActive(isUnlocked)
        else
            storyBox.bg:SetActive(true)
            if isUnlocked then
                storyBox.icon:SetActive(false)
            end
        end

        local targetWidth = isSelect and 620 or 580
        storyBox.rectTransform:DOKill()
        if animDuration > 0 then
            storyBox.rectTransform:DOSizeDelta(Vector2.New(targetWidth, storyBox.rectTransform.sizeDelta.y), animDuration)
        else
            storyBox.rectTransform.sizeDelta = Vector2.New(targetWidth, storyBox.rectTransform.sizeDelta.y)
        end

        storyBox.button.onClick:RemoveAllListeners()
        storyBox.button.onClick:AddListener(function()
            if not isUnlocked then
                return
            end
            self:selectBox(index)
        end)
    end)
end

function StoryListPanel:selectBox(index)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowSelectIndex == index then
        return
    end
    self.nowSelectIndex = index
    self:setView(true)
    self:setArtView()
end

--根据选中的剧情设置右侧剧情预览
function StoryListPanel:setArtView()
    if not self.nowSelectIndex then
        return
    end
    local plotConfig = self.plotConfigList[self.nowSelectIndex]
    --TODO 根据plotConfig设置右侧剧情预览UI

    local isUnlocked = self:isPlotUnlocked(plotConfig)

    --如果未解锁，隐藏background
    if not isUnlocked then
        self.background:SetActive(false)
        self.isNone:SetActive(true)
        self.storyMsgTxt:SetActive(false)
        self.playBtn:SetActive(false)
        return
    end

    self.isNone:SetActive(false)
    self.storyMsgTxt:SetActive(true)
    self.playBtn:SetActive(true)

    self.storyMsgTxt.text.text = plotConfig.synopsis
    --已解锁，显示background
    local backGround = string.format(Config.SpritePath.AVGScene, plotConfig.storyImage[1],plotConfig.storyImage[1])
    self.background:SetActive(true)
    self:LoadSpriteAsync(backGround, self.background.image)

    --显示右侧角色
    local roleImageIdList = {["L"] = nil, ["M"] = nil, ["R"] = nil}
    local roleCount = tablex.size(plotConfig.storyImage[2])

    if roleCount == 2 then
        roleImageIdList.L = plotConfig.storyImage[2][1]
        roleImageIdList.R = plotConfig.storyImage[2][2]
    elseif roleCount == 3 then
        roleImageIdList.L = plotConfig.storyImage[2][1]
        roleImageIdList.M = plotConfig.storyImage[2][2]
        roleImageIdList.R = plotConfig.storyImage[2][3]
    elseif roleCount == 1 then
        roleImageIdList.M = plotConfig.storyImage[2][1]
    end

    self.role_L:SetActive(false)
    self.role_M:SetActive(false)
    self.role_R:SetActive(false)

    for pos, imageId in pairs(roleImageIdList) do
        local roleObj = self["role_"..pos]
        if imageId then
            local roleConfig = Config.GetCharacterInfo(imageId)
            -- CharacterTable.isOpen 为 0 时不显示该角色
            if not roleConfig or roleConfig.isOpen ~= 1 then
                roleObj:SetActive(false)
            else
                local skinData = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
                roleObj.rectTransform.localScale = Vector3.New(skinData.imgRate / 2 , skinData.imgRate / 2, 1)
                roleObj.rectTransform.anchoredPosition = Vector2.New(roleObj.rectTransform.anchoredPosition.x, skinData.imgOffset[2] / 2)
                local roleImagePath = string.format(Config.SpritePath.RolePortrait, imageId, imageId)
                roleObj:SetActive(true)
                self:LoadSpriteAsync(roleImagePath, roleObj.image)
            end
        else
            roleObj:SetActive(false)
        end
    end

    if roleCount == 3 then
        self.role_L.rectTransform.anchoredPosition = Vector2.New(-300, self.role_L.rectTransform.anchoredPosition.y)
        self.role_R.rectTransform.anchoredPosition = Vector2.New(300, self.role_R.rectTransform.anchoredPosition.y)
    elseif roleCount == 2 then
        self.role_L.rectTransform.anchoredPosition = Vector2.New(-200, self.role_L.rectTransform.anchoredPosition.y)
        self.role_R.rectTransform.anchoredPosition = Vector2.New(200, self.role_R.rectTransform.anchoredPosition.y)
    end
end

--function StoryListPanel:OnClose(initiative)
--
--end

--function StoryListPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function StoryListPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/MsgBg/PlayBtn onClick 
--]]
function StoryListPanel:playBtn_ScaleButton_onClick(playBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.nowSelectIndex then
        return
    end

    local plotConfig = self.plotConfigList[self.nowSelectIndex]
    local savedSelectIndex = self.nowSelectIndex  -- 保存当前选中的索引
    AudioMgr:pauseBGM()
    
    -- 播放配置中content内的全部剧情，依次播放
    local storyIds = plotConfig.content
    
    local currentIndex = 1
    
    local function playNextStory()
        if currentIndex > #storyIds then
            -- 所有剧情播放完毕，恢复BGM并重新选中原本的剧情
            StoryMgr:storyArraryEndToGameScene()
            AudioMgr:resumBGM()
            self:selectBox(savedSelectIndex)
            return
        end
        LuaLogger.ds("storyIds[currentIndex]", storyIds[currentIndex])
        StoryMgr:playStoryByArraryId(storyIds[currentIndex], function()
            playNextStory()
        end)
        currentIndex = currentIndex + 1
    end
    
    playNextStory()

end

return StoryListPanel
