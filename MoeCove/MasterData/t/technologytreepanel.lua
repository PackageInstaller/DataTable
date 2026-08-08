---@class TechnologyTreePanel : TechnologyTreePanel_Generate
---##################### 【TechnologyTreePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【TechnologyTreePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local TechnologyTreePanel = require "TechnologyTreePanel_Generate"

function TechnologyTreePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.TechTreeNodeSelect, self.onClickNode},
        {GameMsgType.RefreshTopResource, self.RefreshTopResource},
        {GameMsgType.CommonBackPanelAddClick, self.onCommonBackPanelAddClick},
        --{GameMsgType.CustomBackPanelHelpClick, self.onCustomBackPanelHelpClick},
    }
end

--function TechnologyTreePanel:StartCreating(time)
--
--end

--function TechnologyTreePanel:StartEnter(time)
--
--end

--function TechnologyTreePanel:StartRemoving(time)
--
--end

--function TechnologyTreePanel:StartExit(time)
--
--end

function TechnologyTreePanel:OnOpen(data, initiative)
    if initiative then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.TechnologyTree)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.animator:SetTrigger("Out")
            self.animOverCallBack:SetCallBack(function()
                for _, v in pairs(self.treeNodeList) do
                    GameObject.Destroy(v)
                end
                for _, v in pairs(self.linkList) do
                    GameObject.Destroy(v)
                end
                self.customBackPanel.customBackPanel:ClearBackFunc()
                UIMgr:closeSpecificUI(self)
            end)
        end)
    end
    self.pageId = data.pageId

    self.treeNodeDataList = Me:getTechnologyTreeNodeInfoByPageId(self.pageId)

    self.treeNodeList = {}
    self.linkList = {}
    self.panelOpen = false
    self.allNodeMax = true

    self:initUI()
    self.nowOrder = self.transform:GetComponent("Canvas").sortingOrder 
    self.rightPanel.canvas.sortingLayerName = "UI"
    self.rightPanel.canvas.sortingOrder = self.nowOrder + 10
    self.customBackPanel.customBackPanel:highLight(self.nowOrder + 20)
    GuideMgr:StartGuideTrigger("TechnologyTreePanel")
end

function TechnologyTreePanel:RefreshTopResource()
    self.customBackPanel.customBackPanel:RefreshTopResource()
end

function TechnologyTreePanel:initUI()
    self.detailEffect:SetActive(false)
    self.detailNation:SetActive(false)
    self.nodeDetailBg:SetActive(false)
    self.effectInfoBg:SetActive(false)

    self.customMsgPanel.customMsgPanel:SetBeforeTruntoFunc(function()
        self.customMsgPanel:SetActive(false)
        self.panelOpen = false
        self.rightPanel.animation:Play("InfoOut")
        self.detailEffect:SetActive(false)
        self.customBackPanel.customBackPanel:unHighLight()
    end)
    self.typeTex.text.text = LocalStrEnum["technologyTree_" .. self.pageId]
    self:LoadSpriteAsync(string.format(Config.SpritePath.TechnologyTreePath, "techtree_title_icon_0"..self.pageId), self.typeImg.image)
    self:LoadSpriteAsync(string.format(Config.SpritePath.TechnologyTreePath, "techtree_center_type_0"..self.pageId), self.centerPoint.image)

    --dir
    for i = 1, 4 do
        self["dir"..i]:SetActive(false)
    end
    local dirCfg = Config.GetAllConfig("TechnologyTreeStartTable")
    for _, cfg in pairs(dirCfg) do
        if cfg.page == self.pageId then
            local dir = self["dir"..cfg.orientation]
            dir:SetActive(true)
            dir.dirText.text.text = cfg.startName
        end
    end

    for groupId, nodeData in pairs(self.treeNodeDataList) do
        local linkObj = GameObject.Instantiate(self.link).gameObject
        self.linkList[groupId] = linkObj
        linkObj:SetActive(true)
        linkObj.transform:SetParent(self.linkRoot.transform)
        linkObj.transform.localScale = Vector3.one
        local prePoint = Vector2.New(0, 0)

        local pointCfg = Config.GetTechnologyTreePointInfo(groupId)
        if not pointCfg then
            LuaLogger.e("科技树节点配置不存在:"..groupId)
            return
        end
        local curPoint = Vector2.New(pointCfg.position[1], pointCfg.position[2])

        if nodeData.preGroupId ~= 0 then
            local prePointCfg = Config.GetTechnologyTreePointInfo(nodeData.preGroupId)
            prePoint = Vector2.New(prePointCfg.position[1], prePointCfg.position[2])
        else
            if curPoint.x == 0 then
                if curPoint.y < 0 then
                    prePoint.y = -122
                else
                    prePoint.y = 122
                end
            end
            if curPoint.y == 0 then
                if curPoint.x < 0 then
                    prePoint.x = -122
                else
                    prePoint.x = 122
                end
            end
        end
        
        linkObj.transform.sizeDelta = Vector2.New(math.sqrt(math.pow(curPoint.x - prePoint.x, 2) + math.pow(curPoint.y - prePoint.y, 2)), 23)
        linkObj.transform.localPosition = Vector3.New((curPoint.x + prePoint.x) / 2, (curPoint.y + prePoint.y) / 2, 0)
        local angle = math.atan2(curPoint.y - prePoint.y, curPoint.x - prePoint.x) * 180 / math.pi
        linkObj.transform.localRotation = Quaternion.Euler(0, 0, angle)
        local openObj = linkObj.transform:Find("Open").gameObject

        local nodeObj = GameObject.Instantiate(self.techTreeNode).gameObject
        nodeObj:SetActive(true)
        nodeObj.transform:SetParent(self.nodeRoot.transform)
        nodeObj.transform.localScale = Vector3.New(1, 1, 1)
        nodeObj.transform.localPosition = Vector3.New(pointCfg.position[1], pointCfg.position[2], 0)
        EngineUtil.FillPeer(self.techTreeNode, nodeObj)
        local techTreeNode = nodeObj.techTreeNode
        ---@type TechTreeNodeData
        local data = {
            groupId = groupId,
            level = nodeData.level,
            maxLv = nodeData.maxLv,
            openObj = openObj,
        }
        techTreeNode:InitLogic()
        techTreeNode:refreshUI(data)
        self.treeNodeList[groupId] = nodeObj
        if nodeData.level ~= nodeData.maxLv then
            self.allNodeMax = false
        end
    end
    self:refreshExp()
end

function TechnologyTreePanel:refreshExp()
    local lv = Me:getResearchLevel(self.pageId)
    local exp = Me:getResearchExp(self.pageId)
    
    local lvCfg = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.techTree, lv)
    if not lvCfg then
        LuaLogger.e("科技树等级配置不存在:"..lv)
        return
    end
    self.curLv.text.text = lv
    local curDisExp = exp - lvCfg.exp_sum
    if curDisExp > lvCfg.exp then
        curDisExp = lvCfg.exp
    end
    if self.allNodeMax then
        self.expText.text.text = "<color=#a8acb9>Max</color>"
    else
        self.expText.text.text = string.format("<color=#e69405>%d</color>/<color=#a8acb9>%d</color>", curDisExp, lvCfg.exp)
    end
    
end

function TechnologyTreePanel:refreshNode(lightId)
    self.treeNodeDataList = Me:getTechnologyTreeNodeInfoByPageId(self.pageId)
    for groupId, nodeData in pairs(self.treeNodeDataList) do
        local nodeObj = self.treeNodeList[groupId]
        if nodeObj then
            local techTreeNode = nodeObj.techTreeNode
            ---@type TechTreeNodeData
            local data = {
                groupId = groupId,
                level = nodeData.level,
                maxLv = nodeData.maxLv,
                openObj = self.linkList[groupId].transform:Find("Open").gameObject,
                isLight = lightId ~= nil and lightId == groupId,
            }
            techTreeNode:refreshUI(data)
            if nodeData.level ~= nodeData.maxLv then
                self.allNodeMax = false
            end
        end
    end
    self:refreshExp()
end

---@param data TechnologyTreeNode
function TechnologyTreePanel:refreshLeftInfo(data)
    self.detailNation:SetActive(false)      
    self.detailEffect:SetActive(false)
    ---@type TechnologyTreeTable[]
    local treeCfgList = Config.GetTechnologyTreeListByGroup(data.groupId)
    local curTreeCfg, nextTreeCfg = nil, nil
    for _, cfg in pairs(treeCfgList) do
        if cfg.level == data.level then
            curTreeCfg = cfg
        elseif cfg.level == data.level + 1 then
            nextTreeCfg = cfg
        end
    end
    if data.level == 0 then
        curTreeCfg = nextTreeCfg
        --nextTreeCfg = nil
    end
    if not curTreeCfg then
        return
    end
    self.nodeName.text.text = curTreeCfg.name
    local isMax = data.level == data.maxLv
    self.maxBox:SetActive(isMax)
    if isMax then
        self.lineState1:SetActive(false)
        self.lineState2:SetActive(false)
        self.lineState3:SetActive(true)
    end
    
    self.consumeBox:SetActive(not isMax)
    self:refreshConsumeBox(data, nextTreeCfg)
    if curTreeCfg.type == GE.TechTreeNodeEffectType.Attr or 
        curTreeCfg.type == GE.TechTreeNodeEffectType.HomeLandOutput then
        self.effectBox:SetActive(true)
        self.rewardBox:SetActive(false)
        self.skillBox:SetActive(false)
        --舰种类型
        if curTreeCfg.type == GE.TechTreeNodeEffectType.Attr then
            local existShow = false
            self.effectNode:SetActive(true)
            self.effectBox.rectTransform.anchoredPosition = Vector2.New(13, 83)
            local effectTypeList = curTreeCfg.effectiveScope[1]
            for i = 1, 6 do
                local isin = false
                for _, v in pairs(effectTypeList) do
                    if i == v then
                        isin = true
                        existShow = true
                        break
                    end
                end
                self.effectNode["type"..i]:SetActive(isin)
            end
            if existShow == false then
                self.effectBox.rectTransform.anchoredPosition = Vector2.New(13, 136)
                self.effectNode:SetActive(false)
            end
        else
            self.effectBox.rectTransform.anchoredPosition = Vector2.New(13, 166)
            self.effectNode:SetActive(false)
        end
        if data.level == 0 then
            --只显示点亮效果
            self.curEffect:SetActive(false)
            self.nextEffect:SetActive(true)
            self.nextEffect.desc.text.text = curTreeCfg.describe
            self.nextEffect.lv.text.text = 1
            self.nextEffect.maxLv.text.text = data.maxLv
            self.nextEffect.transform.localPosition = Vector3.New(0, 65, 0)
        else
            self.curEffect:SetActive(true)
            self.curEffect.desc.text.text = curTreeCfg.describe
            self.curEffect.lv.text.text = data.level
            self.curEffect.maxLv.text.text = data.maxLv
            if isMax then
                self.nextEffect:SetActive(false)
            else
                self.nextEffect.transform.localPosition = Vector3.New(0, -148, 0)
                self.nextEffect:SetActive(true)
                self.nextEffect.desc.text.text = nextTreeCfg.describe
                self.nextEffect.lv.text.text = data.level + 1
                self.nextEffect.maxLv.text.text = data.maxLv
            end
        end

    elseif curTreeCfg.type == GE.TechTreeNodeEffectType.Reward then
        self.effectBox:SetActive(false)
        self.rewardBox:SetActive(true)
        self.skillBox:SetActive(false)
        self:FillTemplateContent(self.rewardBoxListNode, self.rewardBoxList, tablex.size(curTreeCfg.reward), function (index, itemObj)
            local customBox = itemObj.item.customBox
            local cfg = Config.GetItemInfo(curTreeCfg.reward[index][2])
            if not cfg then
                LuaLogger.e("科技树配置不存在:"..curTreeCfg.reward[index][2])
                return
            end
            customBox:setMono(self)
            customBox:SetUIData(curTreeCfg.reward[index], {
                isGet = data.level > 0,
                navType = GE.NavigationType.TechnologyTree,
				tipsPassEventState = false,
            })
            itemObj.desc.text.text = cfg.describe
        end)
    elseif curTreeCfg.type == GE.TechTreeNodeEffectType.Skill then
        self.effectBox:SetActive(false)
        self.rewardBox:SetActive(false)
        self.skillBox:SetActive(true)
        self.skillDesc.text.text = curTreeCfg.describe
        local skillCfg = Config.GetSkillInfo(curTreeCfg.getSkill)
        if skillCfg then
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillCfg.icon), self.iconImg.image)
        end
    elseif curTreeCfg.type == GE.TechTreeNodeEffectType.HomeLandOutput then
    end
    self:refreshRightInfoBtn(data)
end

---@param data TechTreeNodeData
---@param nextTreeCfg TechnologyTreeTable
function TechnologyTreePanel:refreshConsumeBox(data, nextTreeCfg)
    if not nextTreeCfg then
        return
    end
    local costList = {}
    for _, v in pairs(nextTreeCfg.cost) do
        table.insert(costList, v)
    end
    self:FillTemplateContent(self.consumeCB, self.consumeRoot, tablex.size(costList), function (index, itemObj)
        local costData = costList[index]
        local customBox = itemObj.customBox
        local data = {
            id = costData[2],
            itemType = GE.ItemTypeIndex.item,
            ownerPanelName = self.uiConfig.id,
        }
        local count = Me:getItemById(costData[2]) and Me:getItemById(costData[2]).num or 0
        if costData[3] ~= 0 then
            data.itemNum = string.format("%d/%d", count, costData[3])
        end
        data.listener = function()
            self.customMsgPanel:SetActive(true)
            self.customMsgPanel.customMsgPanel:SetCanvasAndOrder(self.nowOrder + 20)
            self.customMsgPanel.customMsgPanel:SetPassEventState(false)
            self.customMsgPanel.customMsgPanel:setMono(self)
            self.customMsgPanel.customMsgPanel:SetView({
                type = GE.CustomMsgType.Item,
                config = Config.GetItemInfo(costData[2]),
                Id = costData[2],
                navType = GE.NavigationType.TechnologyTree,
                needNum = costData[3],
            })
        end
        customBox:setMono(self)
        customBox:refreshUI(data)
    end)

    if data.level == 0 and Me:getTechTreeNodeCanUp(data.groupId) == false then
        self.consumeBox.transform.localPosition = Vector3.New(3, -285, 0)
        self.lineState1:SetActive(false)
        self.lineState2:SetActive(true)
        self.lineState3:SetActive(false)
        self.lightBtn:SetActive(false)
        self.lockTip:SetActive(true)

        local preInfo = Me:getTechTreeNodePreInfo(data.groupId)
        if preInfo then
            self.lockTip.tip1:SetActive(true)
            local preLv = Me:getTechTreeNode(preInfo.groupId)
            self.lockTip.tip1.desc.text.text = string.format(LocalStrEnum.technologyTree_5, preInfo.level)
            if preLv >= preInfo.level then
                self.lockTip.tip1.achieve:SetActive(true)
                self.lockTip.tip1.normal:SetActive(false)
                self.lockTip.tip1.desc.text.color = Color.New(73/255, 73/255, 73/255, 1)
            else
                self.lockTip.tip1.achieve:SetActive(false)
                self.lockTip.tip1.normal:SetActive(true)
                self.lockTip.tip1.desc.text.color = Color.New(1, 1, 1, 204/255)
            end
        else
            self.lockTip.tip1:SetActive(false)
        end

        local treeCfg = Config.GetTechnologyTreeListByGroupAndLv(data.groupId, data.level + 1)
        if treeCfg then
            self.lockTip.tip2:SetActive(true)
            self.lockTip.tip2.desc.text.text = string.format(LocalStrEnum.technologyTree_6, treeCfg.techLevel)
            if Me:getResearchLevel(self.pageId) >= treeCfg.techLevel then
                self.lockTip.tip2.achieve:SetActive(true)
                self.lockTip.tip2.normal:SetActive(false)
                self.lockTip.tip2.desc.text.color = Color.New(73/255, 73/255, 73/255, 1)
            else
                self.lockTip.tip2.achieve:SetActive(false)
                self.lockTip.tip2.normal:SetActive(true)
                self.lockTip.tip2.desc.text.color = Color.New(1, 1, 1, 204/255)
            end
        else
            self.lockTip.tip2:SetActive(false)
        end
    else
        self.consumeBox.transform.localPosition = Vector3.New(3, -359, 0)
        self.lineState1:SetActive(true)
        self.lineState2:SetActive(false)
        self.lineState3:SetActive(false)
        self.lockTip:SetActive(false)
        self.lightBtn:SetActive(true)
        self.lightBtn.scaleButton.onClick:RemoveAllListeners()
        self.lightBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            --TODO 客户端提示
            Me:technologyTreeUnlockReq({groupId = data.groupId}, function()
                -- if nextTreeCfg.type == GE.TechTreeNodeEffectType.Reward then
                --     local data = {
                --         id = nextTreeCfg.reward[2],
                --         type = GE.ItemTypeIndex.item,
                --         num = nextTreeCfg.reward[3]
                --     }
                --     Me:ReceiveReward({data})
                -- end
                    --ReceiveRewardPanel
                self:refreshNode(data.groupId)
                self:refreshExp()
                local curData = data
                curData.level = curData.level + 1
                self:refreshLeftInfo(data)
                --面板显示
                local btnSoundPath = string.format(Config.AudioPath.SE, "addpoint")
                self:play2DSound(btnSoundPath)
            end)
        end)
    end

    if tablex.size(nextTreeCfg.costResource) > 0 then
        self.consumeBox.t2:SetActive(true)
        self.consumeRoot:SetActive(true)
        self.consumeIcon:SetActive(true)
        self.consumeCount:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..nextTreeCfg.costResource[2]), self.consumeIcon.image)
        self.consumeCount.text.text = nextTreeCfg.costResource[3]
    else
        self.consumeBox.t2:SetActive(false)
        self.consumeRoot:SetActive(false)
        self.consumeIcon:SetActive(false)
        self.consumeCount:SetActive(false)
        self.lineState1:SetActive(false)
        self.lineState2:SetActive(false)
        self.lineState3:SetActive(true)
    end
end

function TechnologyTreePanel:refreshRightInfoBtn(data)
    local cfgList = Config.GetTechnologyTreeListByGroup(data.groupId)
    local nodeCount = tablex.size(cfgList)
    if nodeCount <= 1 then
        self.rightInfoBtn:SetActive(false)
        return
    end
    self.rightInfoBtn:SetActive(true)
    self.rightInfoBtn.scaleButton.onClick:RemoveAllListeners()
    self.rightInfoBtn.scaleButton.onClick:AddListener(function()
        self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
        self.nodeDetailBg:SetActive(true)
        local nationList= {}
        if cfgList[1].effectiveScope then
            nationList = cfgList[1].effectiveScope[2] or {}
        end
        local isshowNation = false
        if tablex.size(nationList) == 0 then
            self.detailNation:SetActive(false)
        else
            isshowNation = true
            self.detailNation:SetActive(true)
            for i = 1, 8 do
                local isin = false
                for _, v in pairs(nationList) do
                    if i == v then
                        isin = true
                        break
                    end
                end
                self.detailNation["n"..i]:SetActive(isin)
            end
        end
        --ef list
        self.detailEffect:SetActive(true)
        self.detailEffect.arrow:SetActive(data.maxLv > 5)
        self:FillTemplateContent(self.detailEffect.detailEffectNode, self.detailEffect.detailEffectList, data.maxLv, function (index, itemObj)
            itemObj.desc.text.text = cfgList[index].effectDescribe
            itemObj.light:SetActive(index == data.level)
            itemObj.lv.text.text = index
        end)
    end)
end

function TechnologyTreePanel:onClickNode(data)
    self.curSelectNode = data.groupId
    for _, v in pairs(self.treeNodeList) do
        v.techTreeNode:onClickNode(data)
    end
    if self.panelOpen == false then
        self.rightPanel.animation:Play("InfoIn")
        --self.customBackPanel.customBackPanel:highLight(self.nowOrder + 20)
    end
    self.panelOpen = true
    self:refreshLeftInfo(data)
end

function TechnologyTreePanel:refreshEffectList()
    local showList = {}
    for groupId, nodeData in pairs(self.treeNodeDataList) do
        if nodeData.level > 0 then
            local treeCfg = Config.GetTechnologyTreeListByGroupAndLv(groupId, nodeData.level)
            if treeCfg and treeCfg.type ~= GE.TechTreeNodeEffectType.Reward then
                table.insert(showList, treeCfg)
            end
        end
    end
    self.effectInfoBg.empty:SetActive(tablex.size(showList) == 0)
    self:FillTemplateContent(self.effectListBox, self.effectList, tablex.size(showList), function(index, effectBox)
        local cfg = showList[index]
        if cfg ~= nil then
            effectBox.efName.text.text = cfg.name
            effectBox.efDesc.text.text = cfg.describe
            if cfg.effectiveScope then
                local nationList = cfg.effectiveScope[2] or {}
                for i = 1, 8 do
                    local isin = false
                    for _, v in pairs(nationList) do
                        if i == v then
                            isin = true
                            break
                        end
                    end
                    effectBox["n"..i]:SetActive(isin)
                end
            end
        end
    end)
end

function TechnologyTreePanel:onCommonBackPanelAddClick()
    if self.panelOpen == true then
        self.rightPanel.animation:Play("InfoOut")
        self.detailEffect:SetActive(false)
    end
    self.customBackPanel.customBackPanel:unHighLight()
    for _, v in pairs(self.treeNodeList) do
        GameObject.Destroy(v)
    end
    for _, v in pairs(self.linkList) do
        GameObject.Destroy(v)
    end
end

-- function TechnologyTreePanel:onCustomBackPanelHelpClick()
--     if self.panelOpen == true then
--         self.rightPanel.animation:Play("InfoOut")
--         self.detailEffect:SetActive(false)
--         self.panelOpen = false
--     end
--     self.customBackPanel.customBackPanel:unHighLight()
-- end

function TechnologyTreePanel:OnClose(initiative)
    -- for _, v in pairs(self.treeNodeList) do
    --     GameObject.Destroy(v)
    -- end
    -- for _, v in pairs(self.linkList) do
    --     GameObject.Destroy(v)
    -- end
end

-- function TechnologyTreePanel:OnDestroy()
-- 	self.super:OnDestroy(self)
-- end

--function TechnologyTreePanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/TypeInfo/TypeInfoBtn onClick 
--]]
function TechnologyTreePanel:typeInfoBtn_ScaleButton_onClick(typeInfoBtn)

end

--[[
/Bg onClick 
--]]
function TechnologyTreePanel:bg_Button_onClick(bg)
end

--[[
/Main onClick 
--]]
function TechnologyTreePanel:main_Button_onClick(main)
    for _, v in pairs(self.treeNodeList) do
        v.techTreeNode:onClickNode()
    end
    if self.panelOpen == true then
        self.rightPanel.animation:Play("InfoOut")
        --self.customBackPanel.customBackPanel:unHighLight()
        self.detailEffect:SetActive(false)
    end
    self.panelOpen = false
end

--[[
/AdjustRoot/RightPanel/ConsumeBox/LightBtn onClick 
--]]
function TechnologyTreePanel:lightBtn_ScaleButton_onClick(lightBtn)

end

--[[
/AdjustRoot/EffectBtn onClick 
--]]
function TechnologyTreePanel:effectBtn_ScaleButton_onClick(effectBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.effectInfoBg:SetActive(true)
    self:refreshEffectList()
end

--[[
/EffectInfoBg/EffectInfoPanel/CloseEfInfo onClick 
--]]
function TechnologyTreePanel:closeEfInfo_ScaleButton_onClick(closeEfInfo)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.effectInfoBg:SetActive(false)
end

--[[
/AdjustRoot/RightPanel/RightInfoBtn onClick 
--]]
function TechnologyTreePanel:rightInfoBtn_ScaleButton_onClick(rightInfoBtn)

end

--[[
/NodeDetailBg onClick 
--]]
function TechnologyTreePanel:nodeDetailBg_Button_onClick(nodeDetailBg)
    self.nodeDetailBg:SetActive(false)
    self.detailNation:SetActive(false)
    self.detailEffect:SetActive(false)
end

--[[
/EffectInfoBg onClick 
--]]
function TechnologyTreePanel:effectInfoBg_Button_onClick(effectInfoBg)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.effectInfoBg:SetActive(false)
end

return TechnologyTreePanel
