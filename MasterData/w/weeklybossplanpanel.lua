---@class WeeklyBossPlanPanel : WeeklyBossPlanPanel_Generate
---##################### 【WeeklyBossPlanPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeeklyBossPlanPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeeklyBossPlanPanel = require "WeeklyBossPlanPanel_Generate"

function WeeklyBossPlanPanel:InitLogic(data)

end

--function WeeklyBossPlanPanel:StartCreating(time)
--
--end

--function WeeklyBossPlanPanel:StartEnter(time)
--
--end

--function WeeklyBossPlanPanel:StartRemoving(time)
--
--end

--function WeeklyBossPlanPanel:StartExit(time)
--
--end

function WeeklyBossPlanPanel:OnOpen(data, initiative)
    self.bossId = data.bossId
    self.closeFunc = data.closeFunc
    self:setTaglistData()
end

function WeeklyBossPlanPanel:setTaglistData()
    local bossActData = Me:getBossActivityData()
    local needBossData = bossActData.bossLevelMap and bossActData.bossLevelMap[self.bossId] or {}
    --处理选中的tag列表
    self.isSelectedTagMap = {}
    for _, tagId in pairs(needBossData.tagList or {}) do
        local tagConfig = Config.GetPveBossBattleEffectInfo(tagId)
        self.isSelectedTagMap[tagConfig.MainEffectId] = tagId
    end
    local bossLevelConfig = Config.GetPveBossBattleLevelInfo(self.bossId)
    local planTagList = bossLevelConfig.MainEffect or {}
    local planDefaultDescList = bossLevelConfig.MainEffectDesc or {}
    --生成tag格子
    self:FillTemplateContent(self.weeklyBossTagBox, self.tagBoxList, #planTagList, function (index,weeklyBossTagBox)
        local tagGroupId = planTagList[index]
        local tagBox = weeklyBossTagBox.weeklyBossTagBox
        local tagId = self.isSelectedTagMap[tagGroupId]
        --初始化格子显示
        local boxData = {
            tagId = tagId,
            isSelected = false,
            defaultDesc = planDefaultDescList[index],
            clickFunc = function()
                UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
                tagId = self.isSelectedTagMap[tagGroupId]
                --点击选择标签
                UIMgr:popUICover("WeeklyBossChangePlanPanel", {tagGroupId = tagGroupId, tagId = tagId, okFunc = function(selectedTagId)
                    --更新选中状态
                    self.isSelectedTagMap[tagGroupId] = selectedTagId
                    tagBox:refreshTagBoxData(selectedTagId)
                    self:showTotalTagAddition()
                end})
            end,
        }
        tagBox:setTagBoxData(boxData)
    end)
    self:showTotalTagAddition()
end

--显示标签总加成
function WeeklyBossPlanPanel:showTotalTagAddition()
    local totalAddition = 1
    for _, tagId in pairs(self.isSelectedTagMap) do
        local tagConfig = Config.GetPveBossBattleEffectInfo(tagId)
        totalAddition = totalAddition + (tagConfig.ScoreAddition or 0)
    end
    local ptcTxt = string.format("%s%%", tostring(totalAddition * 100))
    self.nowPtcTxt.text.text = ptcTxt
end

--function WeeklyBossPlanPanel:OnClose(initiative)
--
--end

--function WeeklyBossPlanPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeeklyBossPlanPanel:OnRefresh(data)
--
--end

--界面关闭
function WeeklyBossPlanPanel:playCloseAnim()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    local needData = {
        bossId = self.bossId,
        tagList = tablex.values(self.isSelectedTagMap),
    }
    Me:setWeeklyBossTagReq(needData, function ()
        if self.closeFunc then
            self.closeFunc()
        end
    end)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--[[
/Mask onClick 
--]]
function WeeklyBossPlanPanel:mask_Button_onClick(mask)
    self:playCloseAnim()
end

--[[
/BoxBg/CloseBtn onClick 
--]]
function WeeklyBossPlanPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:playCloseAnim()
end

return WeeklyBossPlanPanel
