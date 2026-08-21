---@class PlotEditorPanel : PlotEditorPanel_Generate
---##################### 【PlotEditorPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【PlotEditorPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local PlotEditorPanel = require "PlotEditorPanel_Generate"

function PlotEditorPanel:InitLogic(data)
    
end

function PlotEditorPanel:Update()
    if Input.GetKeyDown(KeyCode.Alpha1) and Input.GetKey(KeyCode.LeftControl) then
        --LuaLogger.ds("<<<>>>")
    end
end

function PlotEditorPanel:InitPanel()
    --生成剧情脚本格子
    self.storyData = require("story_"..self.nowStoryID)
    --检查剧情文件正确性
    self:_CheckStoryCorrect(self.storyData)
    ------------------
    local storyScript = self.storyData.storyScript
    local scriptNum = #storyScript
    self:FillTemplateContent(self.storyScriptBox, self.content, scriptNum, function (index,scriptBox)
        --点击事件置空
        scriptBox.addNextBtn.button.onClick:RemoveAllListeners()
        scriptBox.deleteBtn.button.onClick:RemoveAllListeners()
        scriptBox.jumpBtn.button.onClick:RemoveAllListeners()
        scriptBox.saveTemplateBtn.button.onClick:RemoveAllListeners()

        --设置脚本格子内容
        self:_SetStoryScriptBoxData(scriptBox, storyScript[index], index)

        --添加新脚本按钮
        scriptBox.addNextBtn.button.onClick:AddListener(function ()
            if self.templateData[self.nowSelectTemplateID] then
                table.insert(storyScript, index + 1, clone(self.templateData[self.nowSelectTemplateID]))
            else
                table.insert(storyScript, index + 1, clone(storyScript[index]))
                UICommonUtils.PopToast("空模板，按当前脚本内容创建！")
            end
            self:_SaveStoryScript()
            self:InitPanel()
		end)
        --删除当前脚本按钮
        scriptBox.deleteBtn.button.onClick:AddListener(function ()
			table.remove(storyScript, index)
            self:_SaveStoryScript()
            self:InitPanel()
		end)
        --跳转到当前脚本按钮
        scriptBox.jumpBtn.button.onClick:AddListener(function ()
			local StoryPanel = UIMgr:getUIData("StoryPanel")
            if StoryPanel then
                StoryPanel.ui:JumpByIndex(index)
                self:_SetNowDescribe()
            end
		end)
        --保存当前脚本为模板按钮
        scriptBox.saveTemplateBtn.button.onClick:AddListener(function ()
            self["templateText"..self.nowSelectTemplateID].text.text = self:_SetTextFormatting(scriptBox.nameInputField.inputField.text)
			self.templateData[self.nowSelectTemplateID] = clone(storyScript[index])
            self:_SaveScriptTemplate()
		end)
        --显示编号
        scriptBox.nowIndexNum.text.text = index
        scriptBox.allIndexNum.text.text = "/"..scriptNum
	end)

    --设置故事名称
    local storyName = self.storyData.storyName
    self.storyNameInputField.inputField.text = storyName
    --显示当前配置参数
    self:_SetNowDescribe()
    --显示当前故事id
    self.storyIDInputField.inputField.text = self.nowStoryID
end

function PlotEditorPanel:_SetStoryScriptBoxData(scriptBox, scriptData, index)
    --点击事件置空
    scriptBox.nameInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.wordsInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.wordsInputField.inputField.onValueChanged:RemoveAllListeners()
    scriptBox.wordsInputField.clickListener.onClickEvent = nil
    scriptBox.leftCharInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.rightCharInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.leftEmoteInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.rightEmoteInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.showLeftBtn.button.onClick:RemoveAllListeners()
    scriptBox.showRightBtn.button.onClick:RemoveAllListeners()
    scriptBox.backgroundInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.bGMInputField.inputField.onEndEdit:RemoveAllListeners()
    scriptBox.storyItemInputField.inputField.onEndEdit:RemoveAllListeners()
    --修改对话名称
    scriptBox.nameInputField.inputField.text = scriptData.params.title
    scriptBox.nameInputField.inputField.onEndEdit:AddListener(function ()
        scriptData.params.title = self:_SetTextFormatting(scriptBox.nameInputField.inputField.text)
        self:_SaveStoryScript(index)
    end)
    --修改对话内容
    scriptBox.wordsInputField.inputField.text = scriptData.params.content
    scriptBox.wordsInputField.inputField.onEndEdit:AddListener(function ()
        scriptData.params.content = self:_SetTextFormatting(scriptBox.wordsInputField.inputField.text)
        self:_SaveStoryScript(index)
    end)
    --修改对话内容时实时同步到大窗口
    scriptBox.wordsInputField.inputField.onValueChanged:AddListener(function ()
        self.sCInputField.inputField.text = self:_SetTextFormatting(scriptBox.wordsInputField.inputField.text)
        local wordsLength = #self.sCInputField.inputField.text
        local lineNum = math.ceil(wordsLength / 54)
        self.selectContentText.layoutElement.preferredHeight = lineNum * 40
    end)
    scriptBox.wordsInputField.clickListener.onClickEvent = function ()
        self.sCInputField.inputField.text = self:_SetTextFormatting(scriptBox.wordsInputField.inputField.text)
        local wordsLength = #self.sCInputField.inputField.text
        local lineNum = math.ceil(wordsLength / 54)
        self.selectContentText.layoutElement.preferredHeight = lineNum * 40
        self:_SetNowScriptBox(scriptBox, scriptData, index)
    end
    --更换左侧角色
    scriptBox.leftCharInputField.inputField.text = scriptData.params.leftSpine
    scriptBox.leftCharInputField.inputField.onEndEdit:AddListener(function ()
        local canChange = self:_CheakCharacterResource(scriptBox.leftCharInputField.inputField.text)
        if canChange then
            scriptData.params.leftSpine = self:_SetTextFormatting(scriptBox.leftCharInputField.inputField.text)
            self:_SaveStoryScript(index)
        end
    end)
    --更换右侧角色
    scriptBox.rightCharInputField.inputField.text = scriptData.params.rightSpine
    scriptBox.rightCharInputField.inputField.onEndEdit:AddListener(function ()
        local canChange = self:_CheakCharacterResource(scriptBox.rightCharInputField.inputField.text)
        if canChange then
            scriptData.params.rightSpine = self:_SetTextFormatting(scriptBox.rightCharInputField.inputField.text)
            self:_SaveStoryScript(index)
        end
    end)
    --更换左角色表情
    scriptBox.leftEmoteInputField.inputField.text = scriptData.params.leftEmote
    scriptBox.leftEmoteInputField.inputField.onEndEdit:AddListener(function ()
        local canChange = self:_CheakCharacterEmote(scriptData.params.leftSpine, scriptBox.leftEmoteInputField.inputField.text)
        if canChange then
            scriptData.params.leftEmote = self:_SetTextFormatting(scriptBox.leftEmoteInputField.inputField.text)
            self:_SaveStoryScript(index)
        end
    end)
    --更换右角色表情
    scriptBox.rightEmoteInputField.inputField.text = scriptData.params.rightEmote
    scriptBox.rightEmoteInputField.inputField.onEndEdit:AddListener(function ()
        local canChange = self:_CheakCharacterEmote(scriptData.params.rightSpine, scriptBox.rightEmoteInputField.inputField.text)
        if canChange then
            scriptData.params.rightEmote = self:_SetTextFormatting(scriptBox.rightEmoteInputField.inputField.text)
            self:_SaveStoryScript(index)
        end
    end)
    --当前出场角色
    local isLeft = scriptData.params.showSpine == "left"
    local isRight = scriptData.params.showSpine == "right"
    local isAll = scriptData.params.showSpine == "all"
    local isNone = scriptData.params.showSpine == "none"
    scriptBox.isShowLeft:SetActive((isLeft or isAll) and not isNone)
    scriptBox.isShowRight:SetActive((isRight or isAll) and not isNone)
    scriptBox.showLeftBtn.button.onClick:AddListener(function ()
        scriptBox.isShowLeft:SetActive(not scriptBox.isShowLeft.activeSelf)
        self:_ShowCharSpineIsGray(scriptBox, scriptData, index)
    end)
    scriptBox.showRightBtn.button.onClick:AddListener(function ()
        scriptBox.isShowRight:SetActive(not scriptBox.isShowRight.activeSelf)
        self:_ShowCharSpineIsGray(scriptBox, scriptData, index)
    end)
    --修改当前背景
    scriptBox.backgroundInputField.inputField.text = scriptData.params.background
    scriptBox.backgroundIsChange:SetActive(scriptData.params.background and true or false)
    scriptBox.backgroundInputField.inputField.onEndEdit:AddListener(function ()
        scriptData.params.background = self:_SetTextFormatting(scriptBox.backgroundInputField.inputField.text)
        scriptBox.backgroundIsChange:SetActive(scriptBox.backgroundInputField.inputField.text ~= "")
        self:_SaveStoryScript(index)
    end)
    --修改当前背景音乐
    scriptBox.bGMInputField.inputField.text = scriptData.params.BGM
    scriptBox.bGMIsChange:SetActive(scriptData.params.BGM and true or false)
    scriptBox.bGMInputField.inputField.onEndEdit:AddListener(function ()
        scriptData.params.BGM = self:_SetTextFormatting(scriptBox.bGMInputField.inputField.text)
        scriptBox.bGMIsChange:SetActive(scriptBox.bGMInputField.inputField.text ~= "")
        self:_SaveStoryScript(index)
    end)
    --修改当前展示道具
    scriptBox.storyItemInputField.inputField.text = scriptData.params.showItem
    scriptBox.storyItemInputField.inputField.onEndEdit:AddListener(function ()
        if tonumber(scriptBox.storyItemInputField.inputField.text) then
            scriptData.params.showItem = self:_SetTextFormatting(scriptBox.storyItemInputField.inputField.text)
            self:_SaveStoryScript(index)
        else
            scriptBox.storyItemInputField.inputField.text = scriptData.params.showItem
            UICommonUtils.PopToast("请输入纯数字ID！")
        end
        
    end)
end

--去除输入内容格式
function PlotEditorPanel:_SetTextFormatting(inputText)
    if not inputText then
        return ""
    end
    return string.gsub(inputText, "\r\n", "")
end

--检查资源是否加载
function PlotEditorPanel:_CheakCharacterResource(resName)
    resName = self:_SetTextFormatting(resName)
    --TODO 测试逻辑，后续逻辑需要配置配合
    local storySetting = self.storyData.setting
    for k, v in pairs(storySetting) do
        if v.type == GE.StoryScriptType.CreateSpine then
            if v.params.name == resName then
                return true
            end
        end
    end
    --表中存在的资源，可写入文件
    local canLoad = resName == "npc_001" or resName == "npc_002" or resName == "npc_003"
    if canLoad then
        local setData = {
            params = {
				name = resName,
			},
			type = "CreateSpine",
        }
        table.insert(storySetting, setData)
        return true
    end
    --空值不显示角色
    if resName == "" then
        return true
    end
    UICommonUtils.PopToast("未注册或不存在的资源！")
    return false
end

--检查表情是否存在
function PlotEditorPanel:_CheakCharacterEmote(spineName, emoteName)
    emoteName = self:_SetTextFormatting(emoteName)
    local StoryPanel = UIMgr:getUIData("StoryPanel")
    local charSpine
    if StoryPanel then
        charSpine = StoryPanel.ui:GetCharSpine(spineName)
    end
    if not UICommonUtils.Checkobj(charSpine) then
        UICommonUtils.PopToast("未配置角色！")
        return false
    end

    local objSpine = charSpine.transform:GetChild(0):GetComponent("SkeletonGraphic")
    local spineAnimList = objSpine.Skeleton.Data.Animations:ToArray()
    local resultStrList = {}
    string.gsub(emoteName,'[^'..","..']+',function ( w )
        table.insert(resultStrList, w)
    end)
    --匹配多表情切换检测
    for _, v in pairs(resultStrList) do
        local haveEmote = false
        for i = 0, spineAnimList.Length - 1 do
            --LuaLogger.ds("~~~~~!!!!!~~~~~",tostring(spineAnimList[i].Name))
            if v == tostring(spineAnimList[i].Name) then
                haveEmote = true
            end
        end
        if not haveEmote then
            UICommonUtils.PopToast("不存在的表情！")
            return false
        end
    end
    return true
end

--修改显示角色
function PlotEditorPanel:_ShowCharSpineIsGray(scriptBox, scriptData, index)
    local leftShow = scriptBox.isShowLeft.activeSelf
    local rightShow = scriptBox.isShowRight.activeSelf
    if leftShow and rightShow then
        scriptData.params.showSpine = "all"
    elseif leftShow and not rightShow then
        scriptData.params.showSpine = "left"
    elseif not leftShow and rightShow then
        scriptData.params.showSpine = "right"
    else
        scriptData.params.showSpine = "none"
    end
    self:_SaveStoryScript(index)
end

--设置当前选择脚本格子
function PlotEditorPanel:_SetNowScriptBox(scriptBox, scriptData, index)
    self.nowScriptBox = scriptBox
    self.nowScriptData = scriptData
    self.nowScriptIndex = index
end

--清空当前选择脚本格子
function PlotEditorPanel:_ClearNowScriptBox()
    self.nowScriptBox = nil
    self.nowScriptData = nil
    self.nowScriptIndex = nil
    self.sCInputField.inputField.text = ""
end

function PlotEditorPanel:_SaveStoryScript(index)
    --删除空字段
    for _, v in pairs(self.storyData.storyScript) do
        for k, value in pairs(v.params) do
            if value == "" then
                v.params[k] = nil
            end
        end
    end
    --保存文件
    local name = string.format("story_%s.lua", self.nowStoryID)
    local path = string.format(Config.StoryLuaPath, name)
    local file = io.open(path,"w")
    io.output(file)
    tablex.dumpSetting.ShowIndex = false
    io.write("local screenPlay =  "..tablex.dump(self.storyData).."\nreturn screenPlay")
    io.close(file)

    --设置上次修改位置
    if index then
        self.lastAlterText.text.text = index
    end
end

--设置当前脚本id及部分参数
function PlotEditorPanel:_SetNowDescribe()
    local StoryPanel = UIMgr:getUIData("StoryPanel")
    if StoryPanel then
        local uiPanel = StoryPanel.ui
        self.nowIDText.text.text = uiPanel.sprictIndex
        if uiPanel.nowBackground then
            self.nowBgText.text.text = uiPanel.nowBackground.."(<color=#0096FF>"..uiPanel.nowBackgroundID.."</color>)"
        end
        if uiPanel.nowBGM then
            self.nowBGMText.text.text = uiPanel.nowBGM.."(<color=#0096FF>"..uiPanel.nowBGMID.."</color>)"
        end
        if uiPanel.nowItem then
            self.nowItemText.text.text = uiPanel.nowItem.."(<color=#0096FF>"..uiPanel.nowItemID.."</color>)"
        else
            self.nowItemText.text.text = ""
        end
    end
end

--脚本模板初始化
function PlotEditorPanel:_ScriptTemplateInit()
    self.templateData = require("Story_Template")
    for i = 1, 4 do
        if self.templateData[i] then
            self["templateText"..i].text.text = self.templateData[i].params.title
        else
            self["templateText"..i].text.text = "未添加"
        end
        self["templateBtn"..i].toggle.isOn = false
    end
    self.templateBtn1.toggle.isOn = true
    self.templateFrame1:SetActive(true)
    self.nowSelectTemplateID = 1
end

--保存模板
function PlotEditorPanel:_SaveScriptTemplate()
    local name = "Story_Template.lua"
    local path = string.format(Config.CommonPath.."/script/table/lua/cfg/story/%s", name)
    local file = io.open(path,"w")
    io.output(file)
    tablex.dumpSetting.ShowIndex = false
    io.write("local Template =  "..tablex.dump(self.templateData).."\nreturn Template")
    io.close(file)
end

--检查文件正确性
function PlotEditorPanel:_CheckStoryCorrect(storyData)
    local storyScript = self.storyData.storyScript
    --检测资源加载设置是否完整
    for _, value in pairs(storyScript) do
        self:_CheakCharacterResource(value.params.leftSpine)
        self:_CheakCharacterResource(value.params.rightSpine)
    end
end

--function PlotEditorPanel:StartCreating(time)
--
--end

--function PlotEditorPanel:StartEnter(time)
--
--end

--function PlotEditorPanel:StartRemoving(time)
--
--end

--function PlotEditorPanel:StartExit(time)
--
--end

function PlotEditorPanel:OnOpen(data, initiative)
    local StoryPanel = UIMgr:getUIData("StoryPanel")
    if StoryPanel then
        StoryPanel.ui.transform:SetParent(self.storyPanelNode.transform)
        StoryPanel.ui.transform.sizeDelta = Vector2.New(0, 0)
        StoryPanel.ui.transform.localPosition = Vector3.New(0, 0, 0)
    end

    self.nowStoryID = data.storyID
    self:InitPanel()
    self:_ScriptTemplateInit()
end

--function PlotEditorPanel:OnClose(initiative)
--
--end

--function PlotEditorPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function PlotEditorPanel:OnRefresh(data)
--
--end

--[[
/ListBg/StoryScriptBox/NameBox/NameInputField onEndEdit 
--]]
function PlotEditorPanel:nameInputField_InputField_onEndEdit(nameInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/NameBox/NameInputField onValueChanged 
--]]
function PlotEditorPanel:nameInputField_InputField_onValueChanged(nameInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/WordsBox/WordsInputField onEndEdit 
--]]
function PlotEditorPanel:wordsInputField_InputField_onEndEdit(wordsInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/WordsBox/WordsInputField onValueChanged 
--]]
function PlotEditorPanel:wordsInputField_InputField_onValueChanged(wordsInputField,content)
    --不使用的方法
end

--[[
/ReloadBtn onClick 
--]]
function PlotEditorPanel:reloadBtn_Button_onClick(reloadBtn)
    UICommonUtils.CheckOrCreatStoryFileById(self.nowStoryID)
    local StoryPanel = UIMgr:getUIData("StoryPanel")
    if StoryPanel then
        StoryPanel.ui:ReloadScript(self.nowStoryID)
        self:InitPanel()
        self:_SetNowDescribe()
        self:_ScriptTemplateInit()
        self:_ClearNowScriptBox()
    end
end

--[[
/ListBg/StoryScriptBox/TypeBox/TypeBg onClick 
--]]
function PlotEditorPanel:typeBg_Button_onClick(typeBg)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/AddNextBtn onClick 
--]]
function PlotEditorPanel:addNextBtn_Button_onClick(addNextBtn)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/DeleteBtn onClick 
--]]
function PlotEditorPanel:deleteBtn_Button_onClick(deleteBtn)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/JumpBtn onClick 
--]]
function PlotEditorPanel:jumpBtn_Button_onClick(jumpBtn)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/LeftCharBox/LeftCharInputField onEndEdit 
--]]
function PlotEditorPanel:leftCharInputField_InputField_onEndEdit(leftCharInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/LeftCharBox/LeftCharInputField onValueChanged 
--]]
function PlotEditorPanel:leftCharInputField_InputField_onValueChanged(leftCharInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/RightCharBox/RightCharInputField onEndEdit 
--]]
function PlotEditorPanel:rightCharInputField_InputField_onEndEdit(rightCharInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/RightCharBox/RightCharInputField onValueChanged 
--]]
function PlotEditorPanel:rightCharInputField_InputField_onValueChanged(rightCharInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/ShowCharBox/ShowLeftBtn onClick 
--]]
function PlotEditorPanel:showLeftBtn_Button_onClick(showLeftBtn)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/ShowCharBox/ShowRightBtn onClick 
--]]
function PlotEditorPanel:showRightBtn_Button_onClick(showRightBtn)
    --不使用的方法
end

--[[
/NextBtn onClick 
--]]
function PlotEditorPanel:nextBtn_Button_onClick(nextBtn)
    local StoryPanel = UIMgr:getUIData("StoryPanel")
    if StoryPanel then
        StoryPanel.ui:EditorPlayStory()
        self:_SetNowDescribe()
    end
end

--[[
/StoryName/StoryNameInputField onEndEdit 
--]]
function PlotEditorPanel:storyNameInputField_InputField_onEndEdit(storyNameInputField,content)
    self.storyData.storyName = self:_SetTextFormatting(self.storyNameInputField.inputField.text)
    self:_SaveStoryScript()
end

--[[
/StoryName/StoryNameInputField onValueChanged 
--]]
function PlotEditorPanel:storyNameInputField_InputField_onValueChanged(storyNameInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/BackgroundBox/BackgroundInputField onEndEdit 
--]]
function PlotEditorPanel:backgroundInputField_InputField_onEndEdit(backgroundInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/BackgroundBox/BackgroundInputField onValueChanged 
--]]
function PlotEditorPanel:backgroundInputField_InputField_onValueChanged(backgroundInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/BGMBox/BGMInputField onEndEdit 
--]]
function PlotEditorPanel:bGMInputField_InputField_onEndEdit(bGMInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/BGMBox/BGMInputField onValueChanged 
--]]
function PlotEditorPanel:bGMInputField_InputField_onValueChanged(bGMInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/StoryItemBox/StoryItemInputField onEndEdit 
--]]
function PlotEditorPanel:storyItemInputField_InputField_onEndEdit(storyItemInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/StoryItemBox/StoryItemInputField onValueChanged 
--]]
function PlotEditorPanel:storyItemInputField_InputField_onValueChanged(storyItemInputField,content)
    --不使用的方法
end

--[[
/ReloadBtn/StoryIDInputField onEndEdit 
--]]
function PlotEditorPanel:storyIDInputField_InputField_onEndEdit(storyIDInputField,content)
    if tonumber(storyIDInputField.inputField.text) then
        self.nowStoryID = self:_SetTextFormatting(storyIDInputField.inputField.text)
    else
        storyIDInputField.inputField.text = self.nowStoryID
        UICommonUtils.PopToast("请输入纯数字ID！")
    end
    
end

--[[
/ReloadBtn/StoryIDInputField onValueChanged 
--]]
function PlotEditorPanel:storyIDInputField_InputField_onValueChanged(storyIDInputField,content)
    --不使用的方法
end

--[[
/SCInputField onEndEdit 
--]]
function PlotEditorPanel:sCInputField_InputField_onEndEdit(sCInputField,content)
    if not self.nowScriptBox then
        self.sCInputField.inputField.text = ""
        return
    end
    self.nowScriptBox.wordsInputField.inputField.text = self:_SetTextFormatting(self.sCInputField.inputField.text)
    self.nowScriptData.params.content = self:_SetTextFormatting(self.sCInputField.inputField.text)
    self:_SaveStoryScript(self.nowScriptIndex)
end

--[[
/SCInputField onValueChanged 
--]]
function PlotEditorPanel:sCInputField_InputField_onValueChanged(sCInputField,content)
    --不使用的方法
end

--[[
/PromptBg/TemplateGroup/TemplateBtn1 onValueChanged 
--]]
function PlotEditorPanel:templateBtn1_Toggle_onValueChanged(templateBtn1,isOn)
    if isOn then
        self.nowSelectTemplateID = 1
    end
end

--[[
/PromptBg/TemplateGroup/TemplateBtn2 onValueChanged 
--]]
function PlotEditorPanel:templateBtn2_Toggle_onValueChanged(templateBtn2,isOn)
    if isOn then
        self.nowSelectTemplateID = 2
    end
end

--[[
/PromptBg/TemplateGroup/TemplateBtn3 onValueChanged 
--]]
function PlotEditorPanel:templateBtn3_Toggle_onValueChanged(templateBtn3,isOn)
    if isOn then
        self.nowSelectTemplateID = 3
    end
end

--[[
/PromptBg/TemplateGroup/TemplateBtn4 onValueChanged 
--]]
function PlotEditorPanel:templateBtn4_Toggle_onValueChanged(templateBtn4,isOn)
    if isOn then
        self.nowSelectTemplateID = 4
    end
end

--[[
/ListBg/StoryScriptBox/SaveTemplateBtn onClick 
--]]
function PlotEditorPanel:saveTemplateBtn_Button_onClick(saveTemplateBtn)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/LeftEmoteBox/LeftEmoteInputField onEndEdit 
--]]
function PlotEditorPanel:leftEmoteInputField_InputField_onEndEdit(leftEmoteInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/LeftEmoteBox/LeftEmoteInputField onValueChanged 
--]]
function PlotEditorPanel:leftEmoteInputField_InputField_onValueChanged(leftEmoteInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/RightEmoteBox/RightEmoteInputField onEndEdit 
--]]
function PlotEditorPanel:rightEmoteInputField_InputField_onEndEdit(rightEmoteInputField,content)
    --不使用的方法
end

--[[
/ListBg/StoryScriptBox/RightEmoteBox/RightEmoteInputField onValueChanged 
--]]
function PlotEditorPanel:rightEmoteInputField_InputField_onValueChanged(rightEmoteInputField,content)
    --不使用的方法
end

return PlotEditorPanel
