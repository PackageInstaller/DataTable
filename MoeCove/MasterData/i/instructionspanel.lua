---@class InstructionsPanel : InstructionsPanel_Generate
---##################### 【InstructionsPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【InstructionsPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local InstructionsPanel = require "InstructionsPanel_Generate"

function InstructionsPanel:InitLogic(data)
    self.tabId = nil
    self.nowPage = 1  --当前页
    self.maxPage = 1  --最大页数
    self.toggleObjList = {}  --toggle列表
    self.closeFunc = nil  --关闭回调
end

--function InstructionsPanel:StartCreating(time)
--
--end

--function InstructionsPanel:StartEnter(time)
--
--end

--function InstructionsPanel:StartRemoving(time)
--
--end

--function InstructionsPanel:StartExit(time)
--
--end

function InstructionsPanel:OnOpen(data, initiative)
    LuaLogger.ds("InstructionsPanel:OnOpen", tablex.dump(data))
    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    self.tabId = data.tabId
    self.closeFunc = data.closeFunc
    self:setView()
    self:setViewByPage(self.nowPage)
end

function InstructionsPanel:setView()
    local functionTabInfo = Config.GetFunctionTabInfo(self.tabId)
    self.maxPage = tablex.size(functionTabInfo.functionDes or {})
    --TODO: 根据页数生成下方toggleBox
    if self.maxPage <= 1 then
        return
    end
    self:FillTemplateContent(self.toggleBox, self.toggleList, self.maxPage, function(index, toggleBox)
        toggleBox:SetActive(true)
        self.toggleObjList[index] = toggleBox
        toggleBox.button.onClick:RemoveAllListeners()
        toggleBox.button.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self:setViewByPage(index)
        end)
    end)
end

--根据页码显示
function InstructionsPanel:setViewByPage(page)
    local functionTabInfo = Config.GetFunctionTabInfo(self.tabId)
    if not functionTabInfo then
        return
    end
    if page < 1 or page > self.maxPage then
        return
    end

    self.nowPage = page or 1
    self.nextBtn:SetActive(self.nowPage < self.maxPage)
    self.lastBtn:SetActive(self.nowPage > 1)

    for key, value in pairs(self.toggleObjList) do
        value.isOn:SetActive(self.nowPage == key)
    end

    local functionDes = functionTabInfo.functionDes
    LuaLogger.ds("functionDes", tablex.dump(functionDes))
    --确认页码内配置信息
    --确认是图片还是文字
    if functionDes[page].type == GE.InstructionsType.picture then
        --加载对应图片
        local InstructionsIcon = string.format(Config.SpritePath.InstructionsTypeIconPath, functionDes[page].pic)
        self.msgImg:SetActive(true)
        self:LoadSpriteAsync(InstructionsIcon, self.msgImg.image)
        self.msgTipsList:SetActive(true)
        self.listView:SetActive(false)
        local keyList = functionDes[page].key
        --生成文字说明框
        self:FillTemplateContent(self.msgTips, self.msgTipsList, tablex.size(keyList), function(index, msgTips)
            msgTips:SetActive(true)
            msgTips.msgTxt.text.text = LocalStrEnum[keyList[index]] or ""
        end)
    elseif functionDes[page].type == GE.InstructionsType.text then
        self.msgImg:SetActive(false)
        self.msgTipsList:SetActive(false)
        --判断要加载的
        self.listView:SetActive(true)
        local functionDesData = functionDes[page].functionDes
        self:FillTemplateContent(self.teachBox, self.teachList, tablex.size(functionDesData), function(index, teachBox)
            teachBox:SetActive(true)
            local tempData = functionDesData[index]
            teachBox.titleTxt.text.text = LocalStrEnum[tempData.title] or ""
            if tempData.functionDesType == nil then
                teachBox.teachTxt:SetActive(true)
                teachBox.iconView:SetActive(false)
                teachBox.teachTxt.text.text = LocalStrEnum[tempData.key] or ""
            elseif tempData.functionDesType == GE.InstructionsContentType.iconList then
                teachBox.teachTxt:SetActive(false)
                teachBox.iconView:SetActive(true)
                teachBox.msgView:SetActive(false)
                local tempValue = tempData.value
                self:FillTemplateContent(self.iconMsgBox, teachBox.iconView, tablex.size(tempValue), function(k, iconMsgBox)
                    iconMsgBox:SetActive(true)
                    local data = tempValue[k]
                    local AttributeIcon = string.format(Config.SpritePath.AttributeIconName, data.pic)
                    iconMsgBox.iconImg:SetActive(true)
                    self:LoadSpriteAsync(AttributeIcon, iconMsgBox.iconImg.image)
                    iconMsgBox.iconExplainTxt.text.text = LocalStrEnum[data.key] or ""
                end)
            elseif tempData.functionDesType == GE.InstructionsContentType.gachaMsgList then
                teachBox.teachTxt:SetActive(tempData.key ~= "" and tempData.key ~= nil)
                teachBox.teachTxt.text.text = LocalStrEnum[tempData.key] or ""
                teachBox.iconView:SetActive(false)
                teachBox.msgView:SetActive(true)
                local tempValue = tempData.value
                self:FillTemplateContent(self.gachaMsgBox, teachBox.msgView, tablex.size(tempValue), function(k, gachaMsgBox)
                    gachaMsgBox:SetActive(true)
                    local data = tempValue[k]
                    local roleConfig = Config.GetCharacterInfo(data.id)
                    local skinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
                    local resourceFolder = nil
                    if tonumber(skinConfig.resourceFolder) ~= nil then
                        resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
                    else
                        resourceFolder = skinConfig.resourceFolder
                    end
                    --角色头像
                    gachaMsgBox.roleBox.roleIconImg:SetActive(true)
                    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey), gachaMsgBox.roleBox.roleIconImg.image)
                    gachaMsgBox.roleBox.rankFarmeImg:SetActive(true)
                    self:LoadSpriteAsync(string.format(Config.SpritePath.roleNewRankFarmeBg, roleConfig.rank), gachaMsgBox.roleBox.rankFarmeImg.image)
                    gachaMsgBox.nameTxt.text.text = roleConfig.name
                    gachaMsgBox.msgTxt.text.text = data.msg
                end)
            end
        end)
    end
end

--分页显示

--左右切换逻辑

--点击按钮跳转至某一页

--显示图标文字说明相关

--function InstructionsPanel:OnClose(initiative)
--
--end

--function InstructionsPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function InstructionsPanel:OnRefresh(data)
--
--end

--[[
/bg/NextBtn onClick 
--]]
function InstructionsPanel:nextBtn_ScaleButton_onClick(nextBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setViewByPage(self.nowPage + 1)
end

--[[
/bg/LastBtn onClick 
--]]
function InstructionsPanel:lastBtn_ScaleButton_onClick(lastBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:setViewByPage(self.nowPage - 1)
end

--[[
/Custom/toggleBox onClick 
--]]
function InstructionsPanel:toggleBox_Button_onClick(toggleBox)

end

--[[
/maskImg onClick 
--]]
function InstructionsPanel:mask_Button_onClick(maskImg)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.closeFunc then
        self.closeFunc()
    end
    self:playCloseAnim()
end

--界面关闭
function InstructionsPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return InstructionsPanel
