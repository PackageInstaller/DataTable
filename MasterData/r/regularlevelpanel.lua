---@class RegularLevelPanel : RegularLevelPanel_Generate
---##################### 【RegularLevelPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RegularLevelPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RegularLevelPanel = require "RegularLevelPanel_Generate"

function RegularLevelPanel:InitLogic(data)
    self.selectRegularType = 1
end

function RegularLevelPanel:InitPanel()
    self:setRegularTypeData()
    self:setLevelGroupData()
end

--function RegularLevelPanel:StartCreating(time)
--
--end

--function RegularLevelPanel:StartEnter(time)
--
--end

--function RegularLevelPanel:StartRemoving(time)
--
--end

--function RegularLevelPanel:StartExit(time)
--
--end

function RegularLevelPanel:OnOpen(data, initiative)
    self:InitPanel()
end

function RegularLevelPanel:setRegularTypeData()
    self:FillTemplateContent(self.typeBox, self.regularTypeList, 2, function (index,typeBox)
        typeBox.typeText.text.text = "常驻模式"..index
        typeBox.scaleButton.onClick:RemoveAllListeners()
        typeBox.scaleButton.onClick:AddListener(function ()
            self.selectRegularType = index
            self:setLevelGroupData()
		end)
    end)
end

function RegularLevelPanel:setLevelGroupData()
    if self.selectRegularType == 1 then

    end
    local needChapter = {}
    local chapterConfig = Config.GetAllConfig("ChapterTable")
    for _, data in pairs(chapterConfig) do
        if data.Type == GE.ChapterType.Material then
            table.insert(needChapter, data)
        end
    end
    self:FillTemplateContent(self.levelGroupBox, self.levelGroupList, #needChapter, function (index,levelGroupBox)
        levelGroupBox.groupText.text.text = needChapter[index].name
        levelGroupBox.scaleButton.onClick:RemoveAllListeners()
        levelGroupBox.scaleButton.onClick:AddListener(function ()
            UIMgr:popUI("MaterialLevelPanel",{chapterId = needChapter[index].id})
        end)
    end)
end

--function RegularLevelPanel:OnClose(initiative)
--
--end

--function RegularLevelPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RegularLevelPanel:OnRefresh(data)
--
--end

--[[
/BackBtn onClick 
--]]
function RegularLevelPanel:backBtn_ScaleButton_onClick(backBtn)
    UIMgr:closeUI(self)
end

--[[
/BackMainlBtn onClick 
--]]
function RegularLevelPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)
    --TODO回到主界面
end

return RegularLevelPanel
