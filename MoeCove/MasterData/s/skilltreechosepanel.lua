---@class SkillTreeChosePanel : SkillTreeChosePanel_Generate
---##################### 【SkillTreeChosePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillTreeChosePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillTreeChosePanel = require "SkillTreeChosePanel_Generate"

function SkillTreeChosePanel:InitLogic(data)
    self.choseData_1 = {}
    self.choseData_2 = {}
    self.roleUid = nil

    self.nowSelectIndex = nil
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function SkillTreeChosePanel:StartCreating(time)
--
--end

--function SkillTreeChosePanel:StartEnter(time)
--
--end

--function SkillTreeChosePanel:StartRemoving(time)
--
--end

--function SkillTreeChosePanel:StartExit(time)
--
--end

function SkillTreeChosePanel:OnOpen(data, initiative)
    if data then
        self.choseData_1 = data.chose_1
        self.choseData_2 = data.chose_2
        self.roleUid = data.roleUid
        self:setView()
    end
end

function SkillTreeChosePanel:setView()
    for i = 1, 2 do
        local curChoose = self["chose_"..i]
        local skillData = Config.GetSkillInfo(self["choseData_"..i].specialEffect[2])
        curChoose.rangeBg:SetActive(skillData.skillType == GE.SkillType.Active)
        curChoose.skillTxt.text.text = skillData.name
        curChoose.skillMsgTxt.text.text = skillData.desKey
        curChoose.skillTypeBox_2.typeTxt.text.text = skillData.skillTypeDes
        curChoose.skillTypeBox_1.typeTxt.text.text = skillData.rangeTypeDes
        curChoose.preCdTxt.text.text = skillData.preCdKey
        curChoose.skillRangeTxt.text.text = skillData.rangeDes
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillData.icon), curChoose.skillBox.iconImg.image)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillrePlacBg, skillData.skillType), curChoose.skillrePlaceBox.image)
        curChoose.skillrePlaceTxt.text.text = skillData.skillTypeName
        --范围格子显示
        local showConfig = Config.GetSkillRangeShowInfo(skillData.rangeShow)
        if showConfig then
            local lengthNum = #showConfig.DefaultParam / showConfig.WidthNum
            local newScale = math.floor(120 / math.max(showConfig.WidthNum, lengthNum)) - 2
            curChoose.skillRangeList.gridLayoutGroup.cellSize = Vector2.New(newScale, newScale)
            curChoose.skillRangeList.gridLayoutGroup.constraintCount = showConfig.WidthNum
            self:FillTemplateContent(self.rangebox, curChoose.skillRangeList, #showConfig.DefaultParam, function (index,rangebox)
                rangebox.rangeIcon1:SetActive(false)
                rangebox.rangeIcon2:SetActive(false)
                rangebox.rangeIcon3:SetActive(false)
                rangebox.rangeIcon4:SetActive(false)
                if showConfig.DefaultParam[index] ~= 0 then
                    rangebox["rangeIcon"..showConfig.DefaultParam[index]]:SetActive(true)
                end
            end)
        end

    end
end

--选择
function SkillTreeChosePanel:SelectChose(index)
    if index == self.nowSelectIndex then
        return
    end
    self.nowSelectIndex = index
    local changeScale = 1.05
    for i = 1, 2 do
        if i == index then
            self["chose_"..i].transform:DOScale(Vector3.New(changeScale,changeScale,1), 0.15)
            self["chose_"..i].isSelect:SetActive(true)
        else
            self["chose_"..i].transform:DOScale(Vector3.one, 0.15)
            self["chose_"..i].isSelect:SetActive(false)
        end
    end
end

--关闭界面动画
function SkillTreeChosePanel:playOutAnimation()
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
    self.animator:SetTrigger("Out")
end

--function SkillTreeChosePanel:OnClose(initiative)
--
--end

--function SkillTreeChosePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkillTreeChosePanel:OnRefresh(data)
--
--end

--[[
/ImgBg onClick 
--]]
function SkillTreeChosePanel:imgBg_Button_onClick(imgBg)
    self:playOutAnimation()
end

--[[
/Chose_1/SelectBtn onClick 
--]]
function SkillTreeChosePanel:selectBtn_ScaleButton_onClick(selectBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowSelectIndex == nil then
        UICommonUtils.PopToast("请选择一个技能节点")
        return
    end
    local temp = {
        talentID = self["choseData_"..self.nowSelectIndex].id,
        RoleId = self.roleUid,
    }
    Me:talentTreeUnLockPointReq(temp, function()
        UICommonUtils.PopToast("激活成功")
        local SkillTreePanel = UIMgr:GetUI("SkillTreePanel")
        if SkillTreePanel then
            SkillTreePanel:Refresh()
        end
        self:playOutAnimation()
    end)
end

--[[
/Chose_1/SkillBox/Btn onClick 
--]]
function SkillTreeChosePanel:btn_ScaleButton_onClick(btn)

end

--[[
/Chose_1 onClick 
--]]
function SkillTreeChosePanel:chose_1_Button_onClick(chose_1)
    self:play2DSound(self.btnSoundPath)
    self:SelectChose(1)
end

--[[
/Chose_2 onClick 
--]]
function SkillTreeChosePanel:chose_2_Button_onClick(chose_2)
    self:play2DSound(self.btnSoundPath)
    self:SelectChose(2)
end

return SkillTreeChosePanel
