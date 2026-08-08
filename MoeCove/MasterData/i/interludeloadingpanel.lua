---@class InterludeLoadingPanel : InterludeLoadingPanel_Generate
---##################### 【InterludeLoadingPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【InterludeLoadingPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local InterludeLoadingPanel = require "InterludeLoadingPanel_Generate"
local Random = require "Random"

function InterludeLoadingPanel:InitLogic(data)
    -- local random = Random:new(DLuaUtil.GetGreenwichTime())
    -- local random_data = random:range(1, 2)
    -- local spritePath = string.format(Config.SpritePath.LoadingCat, random_data)
    -- self:LoadSpriteAsync(spritePath, function(sprite)
    --     self.cat_L.image.sprite = sprite
    --     self.cat_R.image.sprite = sprite
    -- end)
    self.animOverCallBack:SetCallBackOfName(function(str)
        if str == "init" then
            if self._startCB then
                self._startCB()
            end
            self._startCB = nil
        elseif str == "out" then
            if next(self._endCBList) then
                for _, endFunc in pairs(self._endCBList) do
                    endFunc()
                end
            end
            self._endCBList = {}
            UIMgr:closeLoadingUI(self)
        end
    end)
    self._endCBList = {}
    self._isEnd = false
    self.maxProgress = 0.8 --最终需要加载到的进度 常量
    self.reachTime = 1 --达到最终进度的时间 需要和界面动画同步
    self._realProgress = 0
    self._fakeProgress = 0
    self._finalProgress = 0
end

--function InterludeLoadingPanel:StartCreating(time)
--
--end

--function InterludeLoadingPanel:StartEnter(time)
--
--end

--function InterludeLoadingPanel:StartRemoving(time)
--
--end

function InterludeLoadingPanel:Update2()
    --实时更新进度条
    if not self._isEnd then
        --真假进度条取最大值
        local progress = self._realProgress >= self._fakeProgress and self._realProgress or self._fakeProgress
        progress = progress >= self.maxProgress and self.maxProgress or progress  --最大到0.8
        self.progress.slider.value = progress
        self.precent.text.text = string.format("%.0f%%", progress * 100)
    end
end

--{
--    call = function()
--    needGalo = bool   是否需要galo 2025/2/20 弃用 表现会卡
--    }
function InterludeLoadingPanel:OnOpen(data, initiative)
    -- LuaLogger.ds(tablex.dump(data),"?????????????")
    if initiative then
        --初始化进度条
        self:UpdateProgress(0)
        self._startCB = data.call
        --为nil时默认为true
        self._needGalo = data.needGalo == nil and true or data.needGalo
        -- self:__SetGalo()
        self:__RandomBgAndTips()
        self._isEnd = false
        self._realProgress = 0
        self._fakeProgress = 0
        self._finalProgress = 0
        self.progress.slider.value = 0
        self.precent.text.text = "0%"
        self:__InitFakeProgress()
    end
end

--初始化假进度条
function InterludeLoadingPanel:__InitFakeProgress()
    local schedule = 3  --经过总时间 s
    -- local interval = 0.01  --间隔秒数
    -- local count = schedule / interval
    -- local addNum = self.maxProgress/count
    -- self.Timer = DLuaTimer:DoRepeat(interval, count, function()
    --     self._fakeProgress = self._fakeProgress + addNum
    --     if self._fakeProgress >= self.maxProgress then
    --         DLuaTimer:RemoveTimer(self.Timer)
    --     end
    -- end)
    if self.DOVirtual then
        self.DOVirtual:Kill()
    end
    self.DOVirtual = DG.Tweening.DOVirtual.Float(0, self.maxProgress, schedule, function(v)
        self._fakeProgress = v
        self:Update2()
    end)
end

--更新进度条
function InterludeLoadingPanel:UpdateProgress(progress)
    if not progress or not self._realProgress then
        return
    end
    if progress > self._realProgress then
        self._realProgress = progress
    end
end

--设置galo
function InterludeLoadingPanel:__SetGalo()
    if self._needGalo then
        self.galo.gameObject:SetActive(true)
    else
        self.galo.gameObject:SetActive(false)
    end
end

--随机壁纸 + 文字
function InterludeLoadingPanel:__RandomBgAndTips()
    --随机壁纸
    local path = Config.SpritePath.LoadingBg
    local picList = Config.GetAllConfig("LoadingPictureTable")
    --随机id
    local picId = self:__GetRandomId(picList)
    local picInfo = Config.GetLoadingPictureInfo(picId)
    local picture = tostring(picInfo.picture)
    -- self:LoadSpriteAsync(string.format(path, picInfo.picture, picInfo.picture), function (s)
    --     self.bg.image.sprite = s
    -- end)
    local target = nil
    LuaLogger.ds("InterludeLoadingPanel:__RandomBgAndTips picture", picture)
    if self.bgList.transform:Find(picture) then
        for i = 0, self.bgList.transform.childCount - 1 do
            local child = self.bgList.transform:GetChild(i)
            child.gameObject:SetActive(child.name == picture)
        end
        target = self.bgList.transform:Find(picture)
    else
        LuaLogger.ws("InterludeLoadingPanel:__RandomBgAndTips 配置的picture在界面中未找到对应的child, picture=", picture)
        local randomIndex = UnityEngine.Random.Range(1, self.bgList.transform.childCount)
        for i = 0, self.bgList.transform.childCount - 1 do
            local child = self.bgList.transform:GetChild(i)
            child.gameObject:SetActive(i + 1 == randomIndex)
        end
        target = self.bgList.transform:GetChild(randomIndex - 1)
    end
    --随机文字
    local wordList = Config.GetLoadingTipsInfoByGroup(picInfo.wordgroup)
    local wordId = self:__GetRandomId(wordList)
    local wordInfo = Config.GetLoadingTipsInfo(wordId)
    self.tips.text.text = wordInfo.word
    self:initBackgroundSize(target)
end

--初始化背景适配
function InterludeLoadingPanel:initBackgroundSize(target)
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local screen_width = rootTransform.rect.width
    local screen_height = rootTransform.rect.height
    local kv_width = target:GetComponent("RectTransform").rect.width
    local kv_height = target:GetComponent("RectTransform").rect.height
    local scale_width = screen_width / kv_width
    local scale_height = screen_height / kv_height
    local scale = math.max(scale_width, scale_height)
    self.bgList.rectTransform.localScale = Vector3.New(scale, scale, 1)
    self.bgList.rectTransform.localScale = Vector3.New(scale, scale, 1)
end

--取随机id data = {id = 10001, weight = 100} weight可选 没有则默认为100 
function InterludeLoadingPanel:__GetRandomId(data)
    local random = UnityEngine.Random
    -- 获取所有的picId和权重
    local targetList = {}
    local totalWeight = 0
    for k, v in pairs(data) do
        local weight = v.weight or 100
        table.insert(targetList, {id = v.id, weight = weight})
        totalWeight = totalWeight + weight
    end

    -- 生成一个在 [0, totalWeight] 范围内的随机数
    local randomWeight = random.Range(0, totalWeight)
    
    -- 根据权重选择目标picId
    local cumulativeWeight = 0
    for _, target in pairs(targetList) do
        cumulativeWeight = cumulativeWeight + target.weight
        if randomWeight <= cumulativeWeight then
            return target.id
        end
    end
end

function InterludeLoadingPanel:ChangeState()
    local temp = UIMgr:getUIData("InterludeLoadingPanel")
    if temp then
        local canvas = temp.ui.gameObject:GetComponent(TypeInfo.Canvas)
        canvas.sortingOrder = 10000
    end
end

--加载结束 外部调用
function InterludeLoadingPanel:PlayOverAnim(callback)
    self:__IsEnd()
    local temp = UIMgr:getUIData("InterludeLoadingPanel")
    temp.bClose = false
    self.animator:SetTrigger("out")
    if callback then
        table.insert(self._endCBList, callback)
    end
end

--加载结束 内部调用 进度条拉满
function InterludeLoadingPanel:__IsEnd()
    if self._isEnd then
        return
    end
    self._isEnd = true
    -- DLuaTimer:RemoveTimer(self.Timer)
    if self.DOVirtual then
        self.DOVirtual:Kill()
    end
    --加载结束最后0.2s进度条拉满
    self.progress.slider:DOValue(1, self.reachTime):SetEase(DG.Tweening.Ease.Linear):OnUpdate(function()
        --实时更新百分比
        local currentValue = self.progress.slider.value
        self.precent.text.text = string.format("%.0f%%", currentValue * 100)
    end)
    -- local CurrentProgress = self._realProgress >= self._fakeProgress and self._realProgress or self._fakeProgress
    -- CurrentProgress = CurrentProgress >= self.maxProgress and self.maxProgress or CurrentProgress
    -- self._finalProgress = CurrentProgress
    -- LuaLogger.ds("结束时后的最终进度: ", self._finalProgress)
    -- self.precent.text.text = string.format("%.0f%%", self._finalProgress * 100)
    -- local time = 0.1
    -- local needProgress = 1 - self._finalProgress
    -- LuaLogger.ds("需要补充的进度: ", needProgress)
    -- local count = self.reachTime/time
    -- self.Timer2 = DLuaTimer:DoRepeat(time, count, function()
    --     self._finalProgress = self._finalProgress + needProgress/count
    --     LuaLogger.ds("当前进度: ", self._finalProgress)
    --     --尝试修复因卡顿导致的120%
    --     if self._finalProgress >= 1 then
    --         self.precent.text.text = "100%"
    --         DLuaTimer:RemoveTimer(self.Timer2)
    --     end
    --     self.precent.text.text = string.format("%.0f%%", self._finalProgress * 100)
    -- end)
    self._realProgress = 0
    self._fakeProgress = 0
end

--function InterludeLoadingPanel:OnClose(initiative)
--
--end

--function InterludeLoadingPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function InterludeLoadingPanel:OnRefresh(data)
--
--end

--[[
/Progress onValueChanged 
--]]
function InterludeLoadingPanel:progress_Slider_onValueChanged(progress,value)

end

return InterludeLoadingPanel
