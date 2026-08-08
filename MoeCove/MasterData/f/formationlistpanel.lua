---@class FormationListPanel : FormationListPanel_Generate
---##################### 【FormationListPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【FormationListPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local FormationListPanel = require "FormationListPanel_Generate"

function FormationListPanel:InitLogic(data)
    self.AllFormationList = {}
    self.nowSelectId = 0
    self.formationListBoxTable = {}
    ---@type FormationInfo[]
    self.nowTeamList = {}
end

--function FormationListPanel:StartCreating(time)
--
--end

--function FormationListPanel:StartEnter(time)
--
--end

--function FormationListPanel:StartRemoving(time)
--
--end

--function FormationListPanel:StartExit(time)
--
--end

---@class FormationListPanelUIData
---@field nowData FormationInfo[]

---@param data FormationListPanelUIData
function FormationListPanel:OnOpen(data, initiative)
    self.AllFormationList = ClientData:GetNowFormationList()
    self.data = data
    self.nowTeamList = {}
    self:SetView()
end

function FormationListPanel:SetView()
    local maxIndex = 1
    for _,v in ipairs(self.data.nowData) do
        table.insert(self.nowTeamList, v)
    end

    self:FillTemplateContent(self.roleBox, self.nowFormation.dataList, Config.GetConfigInfo("FormationHeroCount"), function (index, roleBox)
        roleBox:SetActive(true)
        if (index > #self.nowTeamList) then
            roleBox.emptyImg:SetActive(true)
            roleBox.roleHeadBox:SetActive(false)
            return
        else
            roleBox.roleHeadBox:SetActive(true)
            roleBox.emptyImg:SetActive(false)
        end
        local roleHeadBox = roleBox.roleHeadBox
        roleHeadBox.roleHeadBox:setMono(self)
        roleHeadBox.roleHeadBox:refreshUI({
            roleId = self.nowTeamList[index].roleCid,
            roleImgScale = 1
        })
    end)
    self:FillTemplateContent(self.formationListBox, self.content, Config.GetConfigInfo("FormationCount"), function (index, formationListBox)
        formationListBox:SetActive(true)
        formationListBox.teamName.text.text = "预编组_"..index
        local temp = { 
            key = index,
            obj = formationListBox,
        }
        table.insert(self.formationListBoxTable, temp)
        formationListBox.button.onClick:RemoveAllListeners()
        formationListBox.button.onClick:AddListener(function()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.nowSelectId = index
            self:formationListBoxOnClick()
        end)
        self:FillTemplateContent(self.roleBox, formationListBox.dataList, Config.GetConfigInfo("FormationHeroCount"), function (i, roleBox)
            roleBox:SetActive(true)
            if not self.AllFormationList[index] or (i > #self.AllFormationList[index].formationList) then
                roleBox.emptyImg:SetActive(true)
                roleBox.roleHeadBox:SetActive(false)
                return
            else
                roleBox.roleHeadBox:SetActive(true)
                roleBox.emptyImg:SetActive(false)
                maxIndex = index
            end

            local roleHeadBox = roleBox.roleHeadBox
            roleHeadBox.roleHeadBox:setMono(self)
            roleHeadBox.roleHeadBox:refreshUI({
                roleId = self.AllFormationList[index].formationList[i].roleCid,
                roleImgScale = 1
            })
            roleHeadBox.roleHeadBox.noTag:SetActive(false)
        end)
    end)
    if maxIndex == Config.GetConfigInfo("FormationCount") then
        maxIndex = 1
    end
    self.nowSelectId = maxIndex
    self:formationListBoxOnClick()
end

--更改当前选择显示状态
function FormationListPanel:formationListBoxOnClick()
    for _, v in pairs(self.formationListBoxTable) do
        if self.nowSelectId == v.key then
            v.obj.isSelect:SetActive(true)
            v.obj.bgImg:SetActive(false)
        else
            v.obj.isSelect:SetActive(false)
            v.obj.bgImg:SetActive(true)
        end
    end
end

--function FormationListPanel:OnClose(initiative)
--
--end

--function FormationListPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function FormationListPanel:OnRefresh(data)
--
--end

--退出动画
function FormationListPanel:Out()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeUI(self)
    end)
end

--[[
/mask onClick 
--]]
function FormationListPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

---@class FormationPanelData
---@field ui FormationPanel

--[[
/Bg/BgImg/LoadBtn onClick 
--]]
function FormationListPanel:loadBtn_ScaleButton_onClick(loadBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.nowSelectId == 0 then
        UICommonUtils.PopToast("请选择一个队伍")
        return
    end

    local teamData = ClientData:GetFormationMapById(self.nowSelectId)
    ---@type FormationPanelData
    self._uiFormation = UIMgr:getUIData("FormationPanel")
    if self._uiFormation and teamData then
        self._uiFormation.ui:LoadFormation(teamData)
    end
    self:Out()

end

--[[
/Bg/BgImg/SaveBtn onClick 
--]]
function FormationListPanel:saveBtn_ScaleButton_onClick(saveBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local okFunc = function()
        Me:changeFormationListReq({ id = self.nowSelectId, formationList = self.nowTeamList }, function()
            UICommonUtils.PopToast(LocalStrEnum.FormationSaved)
            self:Out()
        end)
    end
    local hasData = self.AllFormationList[self.nowSelectId] ~= nil
    if hasData then
        UIMgr:popUI("MsgBox", {
            title = LocalStrEnum.PromptTitle, 
            content = LocalStrEnum.FormationReplaceDesc,
            type = MsgBoxType.OKCancel,
            okCallback = okFunc,
        })
    else
        okFunc()
    end
end

--[[
/PanelBg/TitleBg/CloseBtn onClick 
--]]
function FormationListPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

return FormationListPanel
