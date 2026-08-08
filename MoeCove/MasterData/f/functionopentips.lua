---@class FunctionOpenTips : FunctionOpenTips_Generate
---##################### 【FunctionOpenTips Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【FunctionOpenTips Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local FunctionOpenTips = require "FunctionOpenTips_Generate"

function FunctionOpenTips:InitLogic(data)
    self.animOverCallBack:SetCallBackOfName(function(name)
        --入场结束
		if name == "InEnd" then
            self:setCloseBtnState(true)
        --退场结束
        elseif name == "OutEnd" then
            self:process()
        end
	end)
end

--function FunctionOpenTips:StartCreating(time)
--
--end

--function FunctionOpenTips:StartRemoving(time)
--
--end

--function FunctionOpenTips:StartShowing(time)
--
--end

-- {
--     finishCallback = function    --结束回调
--     type = {int},                  --类型 1关卡解锁 2功能解锁
-- }
function FunctionOpenTips:OnOpen(data, initiative)
    if initiative then
        self.isFirstOpen = true
        self._type = data.type
        self.finishCallback = data.finishCallback
        self:process()
    end
    self.buttonSkip:SetActive(GV.IsEditor)
end

function FunctionOpenTips:SetFinishCallback(cb)
    self.finishCallback = cb
end

function FunctionOpenTips:setCloseBtnState(bool)
    self.closeBg.button.enabled = bool
end

function FunctionOpenTips:process()
    --枚举对应关闭列表
    local closeList = {
        self.functionPart,
        self.levelNormal,
        self.levelRed,
        self.title.levelNormal,
        self.title.levelHard,
        self.title.functionPart,
        self.lightBlue,
        self.lightRed,
    }
    for k, v in pairs(closeList) do
        v:SetActive(false)
    end
    --关闭特效
    local effectList = {
        self.blueEffect,
        self.redEffect,
        self.redEffect_1,
        self.blueEffect_1,
    }
    for k, v in pairs(effectList) do
        v:SetActive(false)
    end
    --关闭背景点击
    self:setCloseBtnState(false)
    local maxNum = tablex.size(self._type)
    local index = 0
    for _, id in pairs(self._type) do
        index = index + 1
        --功能开启
        if id == 2 then
            local unWatchList, watchedList = UICommonUtils.GetUnwatchedFunctionList()
            if tablex.size(unWatchList) > 0 then
                self.functionPart:SetActive(true)
                
                self.lightBlue:SetActive(true)
                self.title.functionPart:SetActive(true)
                local showId = unWatchList[1]
                table.insert(watchedList, tostring(showId))
                local functionConfig = Config.GetFunctionOpenInfo(showId)
                --名称
                local name = functionConfig.FunctionName
                self.functionPart.desc.text.text = name
                --图标
                self:LoadSpriteAsync(string.format(Config.SpritePath.FunctionOpenTips, functionConfig.Pic), self.functionPart.icon.image)
                Me:RecordCustomData({
                    [GE.CustomDataKey.FunctionOpenWatched] = watchedList
                })
                --特效开
                self.blueEffect.right.rectTransform.anchoredPosition = Vector2.New(1,0)
                self.blueEffect.left.rectTransform.anchoredPosition = Vector2.New(-1,0)
                self.blueEffect:SetActive(true)
                self.blueEffect_1:SetActive(true)
                --首次进入
                if not self.isFirstOpen then
                    self.animator:SetTrigger("In")
                    self.isFirstOpen = false
                else
                    --二次进入
                    self.animator:SetTrigger("In")
                end
                break
            end
        --关卡
        elseif id == 1 then
            local unWatchList, watchedList = UICommonUtils.GetUnwatchedLevelList()
            if tablex.size(unWatchList) > 0 then
                table.sort(unWatchList, function(a, b) return a < b end)
                local showId = unWatchList[1]
                local chapterInfo = Config.GetChapterInfo(showId)
                table.insert(watchedList, tostring(showId))
                local desc
                --普通
                if chapterInfo.Type == GE.ChapterType.MainStory then
                    self.lightBlue:SetActive(true)
                    self.levelNormal:SetActive(true)
                    self.title.levelNormal:SetActive(true)
                    --名称
                    self.levelNormal.desc.text.text = chapterInfo.name
                    --标题
                    self.levelNormal.titleText.text.text = chapterInfo.numDesc
                    --特效开
                    self.blueEffect.right.rectTransform.anchoredPosition = Vector2.New(2.5,0)
                    self.blueEffect.left.rectTransform.anchoredPosition = Vector2.New(-2.5,0)
                    self.blueEffect:SetActive(true)
                    self.blueEffect_1:SetActive(true)
                else
                    --困难
                    self.lightRed:SetActive(true)
                    self.levelRed:SetActive(true)
                    self.title.levelHard:SetActive(true)
                    --名称
                    self.levelRed.desc.text.text = chapterInfo.name
                    --标题
                    self.levelRed.titleText.text.text = chapterInfo.numDesc
                    --特效开
                    self.redEffect:SetActive(true)
                    self.redEffect_1:SetActive(true)
                end
                --名称
                Me:RecordCustomData({
                    [GE.CustomDataKey.LevelOpenWatched] = watchedList
                })
                --首次进入
                if not self.isFirstOpen then
                    self.animator:SetTrigger("In")
                    self.isFirstOpen = false
                else
                    --二次进入
                    self.animator:SetTrigger("In")
                end
                break
            end
        end
        if index >= maxNum then
            UIMgr:closeUI(self)
            if self.finishCallback then
                self.finishCallback()
            end
        end
    end
end

--function FunctionOpenTips:OnClose(initiative)
--
--end

--function FunctionOpenTips:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function FunctionOpenTips:OnRefresh(data)
--
--end

--[[
/closeBg onClick 点击背景遮罩
--]]
function FunctionOpenTips:closeBg_Button_onClick(closeBg)
    self:setCloseBtnState(false)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
end

--[[
/closeBg/buttonSkip onClick 
--]]
function FunctionOpenTips:buttonSkip_Button_onClick(buttonSkip)
    local result = {}
    local maxNum = tablex.size(self._type)
    local index = 0
    for _, id in pairs(self._type) do
        index = index + 1
        --功能开启
        if id == 2 then
            local unWatchList, watchedList = UICommonUtils.GetUnwatchedFunctionList()
            if tablex.size(unWatchList) > 0 then
                for _, v in pairs(unWatchList) do
                    table.insert(watchedList, tostring(v))
                end
                result[GE.CustomDataKey.FunctionOpenWatched] = watchedList
            end
        --关卡
        elseif id == 1 then
            local unWatchList, watchedList = UICommonUtils.GetUnwatchedLevelList()
            if tablex.size(unWatchList) > 0 then
                for _, v in pairs(unWatchList) do
                    table.insert(watchedList, tostring(v))
                end
                result[GE.CustomDataKey.LevelOpenWatched] = watchedList
            end
        end
    end
    if tablex.size(result) > 0 then
        Me:RecordCustomData(result)
    end
    UIMgr:closeUI(self)
end

return FunctionOpenTips
