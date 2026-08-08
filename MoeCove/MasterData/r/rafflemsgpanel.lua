---@class RaffleMsgPanel : RaffleMsgPanel_Generate
---##################### 【RaffleMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RaffleMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RaffleMsgPanel = require "RaffleMsgPanel_Generate"

function RaffleMsgPanel:InitLogic(data)
    self.nowPoolId = nil
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function RaffleMsgPanel:StartCreating(time)
--
--end

--function RaffleMsgPanel:StartEnter(time)
--
--end

--function RaffleMsgPanel:StartRemoving(time)
--
--end

--function RaffleMsgPanel:StartExit(time)
--
--end

function RaffleMsgPanel:OnOpen(data, initiative)
    self.nowPoolId = data.poolId
    self:SetView()
end

function RaffleMsgPanel:SetView()
    local poolConfig = Config.GetGachaPoolInfo(self.nowPoolId)
    if not poolConfig then
        return
    end
    --根据配置生成对应显示
    DLuaUtil.ClearChildren(self.teachList.transform)
    self:FillTemplateContent(self.rulesBox, self.teachList, tablex.size(poolConfig.explainTips), function(index, rulesBox)
        local explain = poolConfig.explainTips[index]
        --LuaLogger.ds("explain", tablex.dump(explain))
        rulesBox:SetActive(true)
        rulesBox.titleTxt.text.text = LocalStrEnum[explain.boxname]
        --根据value生成内容
        for _, v in pairs(explain.value) do
            self:setMsgByType(v, rulesBox)
        end
    end)
end

---根据类型设置说明内容
---@param data table 说明数据
function RaffleMsgPanel:setMsgByType(data, parent)
    local typeMode = data.type
    if typeMode == GE.RaffleMsgType[1] then
        --抽卡规则文本(带星星)
        --在parent下生成RulesTxt
        local RulesTxt = GameObject.Instantiate(self.rulesTxt)
        RulesTxt.gameObject.transform:SetParent(parent.transform)
        RulesTxt.gameObject.transform.localScale = Vector3(1,1,1)
        RulesTxt.gameObject.transform.localPosition = Vector3(1,1,0)
        RulesTxt.transform:GetComponent(TypeInfo.TextMeshProUGUI).text = LocalStrEnum[data.txt]
        RulesTxt:SetActive(true)
        if data.Line and data.Line ~= "" then
            RulesTxt.transform:Find("Line").gameObject:SetActive(true)
        else
            RulesTxt.transform:Find("Line").gameObject:SetActive(false)
        end
    elseif typeMode == GE.RaffleMsgType[2] then
        --占位符
        local cube = GameObject.Instantiate(self.cube)
        cube.gameObject.transform:SetParent(parent.transform)
        cube.gameObject.transform.localScale = Vector3(1,1,1)
        cube.gameObject.transform.localPosition = Vector3(1,1,0)
        cube:SetActive(true)
    elseif typeMode == GE.RaffleMsgType[3] then
        --稀有度文本（带SSR图标）
        local RankMsgTxt = GameObject.Instantiate(self.rankMsgTxt)
        RankMsgTxt.gameObject.transform:SetParent(parent.transform)
        RankMsgTxt.gameObject.transform.localScale = Vector3(1,1,1)
        RankMsgTxt.gameObject.transform.localPosition = Vector3(1,1,0)
        RankMsgTxt.transform:GetComponent(TypeInfo.TextMeshProUGUI).text = LocalStrEnum[data.txt]
        --生成对应品质的图标
        local rankIcon = RankMsgTxt.transform:Find("RankIconImg").gameObject
        local qualityIcon = string.format(Config.SpritePath.roleQualityIcon, tonumber(data.rank))
        self:LoadSpriteAsync(qualityIcon, function (s)
            rankIcon.transform:GetComponent(TypeInfo.Image).sprite = s
            rankIcon:SetActive(true)
        end)
        RankMsgTxt:SetActive(true)
    elseif typeMode == GE.RaffleMsgType[4] then
        --普通文本
        local MsgTxt = GameObject.Instantiate(self.msgTxt)
        MsgTxt.gameObject.transform:SetParent(parent.transform)
        MsgTxt.gameObject.transform.localScale = Vector3(1,1,1)
        MsgTxt.gameObject.transform.localPosition = Vector3(1,1,0)
        MsgTxt.transform:GetComponent(TypeInfo.TextMeshProUGUI).text = LocalStrEnum[data.txt]
        MsgTxt:SetActive(true)
    elseif typeMode == GE.RaffleMsgType[5] then
        --英雄图标列表
        local MsgViewBox = GameObject.Instantiate(self.msgViewBox)
        MsgViewBox.gameObject.transform:SetParent(parent.transform)
        MsgViewBox.gameObject.transform.localScale = Vector3(1,1,1)
        MsgViewBox.gameObject.transform.localPosition = Vector3(1,1,0)
        MsgViewBox:SetActive(true)

        --在这个节点下生成对应的英雄图标
        for _, v in pairs(data.value) do
            --LuaLogger.ds("heroIconData", tablex.dump(v))
            local gachaMsgBox = GameObject.Instantiate(self.gachaMsgBox)
            gachaMsgBox.gameObject.transform:SetParent(MsgViewBox.transform)
            gachaMsgBox.gameObject.transform.localScale = Vector3(1,1,1)
            gachaMsgBox.gameObject.transform.localPosition = Vector3(1,1,0)
            gachaMsgBox:SetActive(true)

            local roleConfig = Config.GetCharacterInfo(v.id)
            local skinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
            --LuaLogger.ds("skinConfig", tablex.dump(skinConfig))
            local resourceFolder = nil
            if tonumber(skinConfig.resourceFolder) ~= nil then
                resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
            else
                resourceFolder = skinConfig.resourceFolder
            end
            local roleBox = gachaMsgBox.transform:Find("RoleBox")
            --角色头像
            local path = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
            self:LoadSpriteAsync(path, function(s)
                local iconNode = roleBox.transform:Find("RoleIconImg")
                iconNode:GetComponent(TypeInfo.Image).sprite = s
                iconNode.gameObject:SetActive(true)
            end)
            self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme2, roleConfig.rank), function(s)
                local RankFarmeImg = roleBox.transform:Find("RankFarmeImg")
                RankFarmeImg:GetComponent(TypeInfo.Image).sprite = s
                RankFarmeImg.gameObject:SetActive(true)
            end)
            local RoleTypeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
            self:LoadSpriteAsync(RoleTypeIconPath, function (s)
                local TypeIcon = roleBox.transform:Find("TypeIcon")
                TypeIcon:GetComponent(TypeInfo.Image).sprite = s
                TypeIcon.gameObject:SetActive(true)
            end)

            local nameNode = gachaMsgBox.transform:Find("NameTxt")
            nameNode:GetComponent(TypeInfo.TextMeshProUGUI).text = roleConfig.name
            local msgNode = gachaMsgBox.transform:Find("MsgTxt")
            msgNode:GetComponent(TypeInfo.TextMeshProUGUI).text = v.txt
        end
        if data.Line and data.Line ~= "" then
            MsgViewBox.transform:Find("Line").gameObject:SetActive(true)
        else
            MsgViewBox.transform:Find("Line").gameObject:SetActive(false)
        end
    end
end

-- function RaffleMsgPanel:OnClose(initiative)
--     DLuaUtil.ClearChildren(self.teachList.transform)
-- end

--function RaffleMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RaffleMsgPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function RaffleMsgPanel:mask_Button_onClick(mask)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

--[[
/BoxBg/TitleSideBg/CloseBtn onClick 
--]]
function RaffleMsgPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(self.btnSoundPath)
    self:playCloseAnim()
end

function RaffleMsgPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end


return RaffleMsgPanel
