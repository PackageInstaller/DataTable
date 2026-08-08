---@class StoryChapterPanel : StoryChapterPanel_Generate
---##################### 【StoryChapterPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【StoryChapterPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local StoryChapterPanel = require "StoryChapterPanel_Generate"

function StoryChapterPanel:InitLogic(data)

end

function StoryChapterPanel:InitPanel()
    self:setStoryChapterData()
end

--function StoryChapterPanel:StartCreating(time)
--
--end

--function StoryChapterPanel:StartEnter(time)
--
--end

--function StoryChapterPanel:StartRemoving(time)
--
--end

--function StoryChapterPanel:StartExit(time)
--
--end

function StoryChapterPanel:OnOpen(data, initiative)
    self:InitPanel()
end

function StoryChapterPanel:setStoryChapterData()
    self:FillTemplateContent(self.storyBox, self.content, 3, function(index, storyBox)
        storyBox.chapterNameText.text.text = "章节"..index
        storyBox.chapterBox.scaleButton.onClick:RemoveAllListeners()
        storyBox.chapterBox.scaleButton.onClick:AddListener(function()
            storyBox.sceneList:SetActive(not storyBox.sceneList.activeSelf)
            if storyBox.sceneList.activeSelf then
                local portraitPath = string.format(Config.SpritePath.RolePortrait, "1000"..math.random(1, 6))
                self:LoadSpriteAsync(portraitPath, self.chapterPicture.image)
            end
        end)

        local sceneCount = math.random(1, 5)
        storyBox.sceneList.transform.sizeDelta = Vector2.New(storyBox.sceneList.transform.sizeDelta.x, 30 + (100 * sceneCount))
        self:FillTemplateContent(storyBox.sceneBox, storyBox.sceneList, sceneCount, function(index, sceneBox)
            sceneBox.sceneNameText.text.text = "回目"..index
            sceneBox.scaleButton.onClick:RemoveAllListeners()
            sceneBox.scaleButton.onClick:AddListener(function()

            end)
        end)
    end)
end

--function StoryChapterPanel:OnClose(initiative)
--
--end

--function StoryChapterPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function StoryChapterPanel:OnRefresh(data)
--
--end

--[[
/BackPanel/BackBtn onClick 
--]]
function StoryChapterPanel:backBtn_ScaleButton_onClick(backBtn)
    UIMgr:closeUI(self)
end

--[[
/BackPanel/BackMainlBtn onClick 
--]]
function StoryChapterPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/BackPanel/HelpBtn onClick 
--]]
function StoryChapterPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

return StoryChapterPanel
