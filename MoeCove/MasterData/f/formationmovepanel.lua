---@class FormationMovePanel : FormationMovePanel_Generate
---##################### 【FormationMovePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【FormationMovePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local FormationMovePanel = require "FormationMovePanel_Generate"
local battleCore = require "BattleCore"
local battleMgr = battleCore:getBattleMgr()

function FormationMovePanel:InitLogic(data)
    self.boxList = {}
    self.nowDrawData = {}
end

--function FormationMovePanel:StartCreating(time)
--
--end

--function FormationMovePanel:StartEnter(time)
--
--end

--function FormationMovePanel:StartRemoving(time)
--
--end

--function FormationMovePanel:StartExit(time)
--
--end

function FormationMovePanel:OnOpen(data, initiative)
    self.data = data
    self:SetView()
end

--设置显示
function FormationMovePanel:SetView()
    local levelConfig = battleMgr:getLevelConfig()
    local posNum = math.max(6, levelConfig.maxPerson)
    self:FillTemplateContent(self.roleBox, self.teamList, posNum, function (index, roleBox)
        local dragListener = roleBox.dragListener
        roleBox:SetActive(true)
        if (index > levelConfig.maxPerson) then
            roleBox.roleInfo:SetActive(false)
            roleBox.noLocationImg:SetActive(true)
            dragListener.onBeginDragEvent = nil
            dragListener.onDragEvent = nil
            dragListener.onEndDragEvent = nil
            return
        else
            roleBox.roleInfo:SetActive(true)
            roleBox.noLocationImg:SetActive(false)
        end
        roleBox.indexText.text.text = index
        local roleData = Me:getPlayerHero(self.data.nowData[index])
        --print("FormationMovePanel id",self.data.nowData[index])
        if roleData then
            local roleHeadBox = roleBox.roleHeadBox
            roleHeadBox.roleHeadBox:setMono(self)
            roleHeadBox.roleHeadBox:refreshUI({
                roleId = roleData.id,
                -- roleImgScale = 1.3,
            })
            roleHeadBox.roleHeadBox.noTag:SetActive(false)

            roleBox.emptyImg:SetActive(false)
            roleBox.roleHeadBox:SetActive(true)
        else
            roleBox.emptyImg:SetActive(true)
            roleBox.roleHeadBox:SetActive(false)
        end
        
        local temp = {
            obj = roleBox,
            data = self.data.nowData[index],
            key = index
        }

        table.insert(self.boxList, temp)
        dragListener.onBeginDragEvent = function (data)
            self:_onRoleStartDrag(self.data.nowData[index], index, roleBox)
        end
        dragListener.onDragEvent = function (data)
            self:_onRoleDrag(data)
        end
        dragListener.onEndDragEvent = function (data)
            self:_onRoleStopDrag(data)
        end
    end)
end

function FormationMovePanel:_onRoleStartDrag(id, index, roleBox)
    if id == nil then
        UICommonUtils.PopToast("位置为空")
        return
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local roleConfig = Config.GetCharacterInfo(id)
    local obj = GameObject.Instantiate(roleBox)

    self.nowDrawData = index

    obj:SetActive(true)
    obj.transform:Find("RoleInfo/IndexBg").gameObject:SetActive(false)
    -- obj.transform:Find("NameText"):GetComponent(TypeInfo.TextMeshProUGUI).text = roleConfig.name
    obj.transform:SetParent(self.tempRoleRoot.transform)
    obj.transform.localPosition = Vector3.zero
    obj.transform.localScale = Vector3.one
    self.tempRoleRoot:SetActive(true)
    self._isRoleDragStarted = true
end

function FormationMovePanel:_onRoleDrag(params)
    if (not self._isRoleDragStarted) then
        return
    end
    local tempPos = Vector2.zero
    local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform, params, UIMgr.uiCamera, tempPos)
    self.tempRoleRoot.transform.localPosition = screenPos
end

function FormationMovePanel:_onRoleStopDrag(params)
    if (not self._isRoleDragStarted) then
        return
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local nowSetBox = nil
    for key, value in pairs(self.boxList) do
        if Mathf.Sqrt((self.tempRoleRoot.transform.localPosition - value.obj.transform.localPosition).magnitude) < 10 then
            if value.data ~= nil then
                nowSetBox = value
            else
                nowSetBox = nil
            end
        end
    end
    if nowSetBox then
        local temp = self.data.nowData[nowSetBox.key]
        self.data.nowData[nowSetBox.key] = self.data.nowData[self.nowDrawData]
        self.data.nowData[self.nowDrawData] = temp
        self:SetView()
    else
        UICommonUtils.PopToast("不可以和空的交换位置哦")
    end

    self.tempRoleRoot:SetActive(false)
    self._isRoleDragStarted = false
    DLuaUtil.ClearChildren(self.tempRoleRoot.transform)
end

--function FormationMovePanel:OnClose(initiative)
--
--end

--function FormationMovePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function FormationMovePanel:OnRefresh(data)
--
--end

--退出动画
function FormationMovePanel:Out()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeUI(self)
    end)
end

--[[
/mask onClick 
--]]
function FormationMovePanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    ---@class FormationPanelUIData
    ---@field ui FormationPanel
    self._uiFormation = UIMgr:getUIData("FormationPanel")
    if (self._uiFormation) then
        self._uiFormation.ui:SetMoveList(tablex.clone(self.data.nowData))
    end
    self:Out()
end

--[[
/PanelBg/TitleBg/CloseBtn onClick 
--]]
function FormationMovePanel:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self._uiFormation = UIMgr:getUIData("FormationPanel")
    if (self._uiFormation) then
        self._uiFormation.ui:SetMoveList(tablex.clone(self.data.nowData))
    end
    self:Out()
end

--[[
/RoleBox onClick 
--]]
function FormationMovePanel:roleBox_ScaleButton_onClick(roleBox)

end

--[[
/RoleItem onClick 
--]]
function FormationMovePanel:roleItem_ScaleButton_onClick(roleItem)

end

return FormationMovePanel
