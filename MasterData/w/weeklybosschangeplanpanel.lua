---@class WeeklyBossChangePlanPanel : WeeklyBossChangePlanPanel_Generate
---##################### 【WeeklyBossChangePlanPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeeklyBossChangePlanPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeeklyBossChangePlanPanel = require "WeeklyBossChangePlanPanel_Generate"

function WeeklyBossChangePlanPanel:InitLogic(data)
    self.selectTagBoxObj = nil
    self.selectTagId = 0
    self.tagGroupId = 0
end

--function WeeklyBossChangePlanPanel:StartCreating(time)
--
--end

--function WeeklyBossChangePlanPanel:StartEnter(time)
--
--end

--function WeeklyBossChangePlanPanel:StartRemoving(time)
--
--end

--function WeeklyBossChangePlanPanel:StartExit(time)
--
--end

function WeeklyBossChangePlanPanel:OnOpen(data, initiative)
    self.tagGroupId = data.tagGroupId
    self.selectTagId = data.tagId
    self.okFunc = data.okFunc
    self:setTagGroupData()
end

function WeeklyBossChangePlanPanel:setTagGroupData()
    local tagCfgList = Config.GetPveBossBattleEffectInfoByTag(self.tagGroupId)
    --LuaLogger.ds(">>>>>>>>tagCfgList",tablex.dump(tagCfgList))
    local tagNum = #tagCfgList + 1
    --生成tag格子
    self:FillTemplateContent(self.weeklyBossTagBox, self.tagBoxList, tagNum, function (index,weeklyBossTagBox)
        local tagBox = weeklyBossTagBox.weeklyBossTagBox
        if index == tagNum then
            --取消选中格子
            tagBox:showCancelSelectBox(function()
                self:selectTagBox(nil, weeklyBossTagBox)
            end)
            return
        end
        local tagId = tagCfgList[index].id
        --初始化格子显示
        local boxData = {
            tagId = tagId,
            isSelected = tagId == self.selectTagId,
            clickFunc = function()
                --点击选择标签
                self:selectTagBox(tagId, weeklyBossTagBox)
            end,
        }
        tagBox:setTagBoxData(boxData)
        if tagId == self.selectTagId then
            self.selectTagBoxObj = weeklyBossTagBox
            self.selectTagBoxObj.weeklyBossTagBox:refreshSelectState(true)
        end
    end)
end

--选中tag格子方法
function WeeklyBossChangePlanPanel:selectTagBox(tagId, tagBox)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if UICommonUtils.Checkobj(self.selectTagBoxObj) then
        self.selectTagBoxObj.weeklyBossTagBox:refreshSelectState(false)
    end
    self.selectTagId = tagId
    self.selectTagBoxObj = tagBox
    self.selectTagBoxObj.weeklyBossTagBox:refreshSelectState(true)
end

--界面关闭
function WeeklyBossChangePlanPanel:animationAndClose()
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--function WeeklyBossChangePlanPanel:OnClose(initiative)
--
--end

--function WeeklyBossChangePlanPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function WeeklyBossChangePlanPanel:OnRefresh(data)
--
--end

--[[
/Bg onClick 
--]]
function WeeklyBossChangePlanPanel:bg_Button_onClick(bg)

end

--[[
/Bg/OkBtn onClick 
--]]
function WeeklyBossChangePlanPanel:okBtn_ScaleButton_onClick(okBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.okFunc then
        self.okFunc(self.selectTagId)
    end
    self:animationAndClose()
end

--[[
/Bg/CancelBtn onClick 
--]]
function WeeklyBossChangePlanPanel:cancelBtn_ScaleButton_onClick(cancelBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:animationAndClose()
end

return WeeklyBossChangePlanPanel
