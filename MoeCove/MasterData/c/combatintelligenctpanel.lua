---@class CombatIntelligenctPanel : CombatIntelligenctPanel_Generate
---##################### 【CombatIntelligenctPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CombatIntelligenctPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CombatIntelligenctPanel = require "CombatIntelligenctPanel_Generate"

---@class CombatIntelligenctPanel_InfoObj :UIObj
---@field ui CombatIntelligenctPanel
local InfoObj = class("CombatIntelligenctPanel_InfoObj", UIObj)

local difficultStr = LocalStrEnum.Intelligenct_difficult
difficultStr = string.split(difficultStr, ",")

function InfoObj:Initialize()
    UIObj.Initialize(self)

    ---@type CombatIntelligenctPanel_Generate_infoPrefab
    local peer = self
    peer.content.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnInfoBtnClick))
end

---@param data integer
function InfoObj:SetData(data)
    UIObj.SetData(self)
    ---@type IntelligenceTable
    self.cfg = nil
    ---@type CombatIntelligenceInfo
    self.serverData = nil
    self.data = data
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
       return 
    end
    local pveLevelcfg = Config.GetPveLevelInfo(data)
    if pveLevelcfg == nil then
       return 
    end
    local cfg = Config.GetIntelligenceById(data)
    if cfg == nil then
        return
    end
    self.cfg = cfg
    ---@type CombatIntelligenctPanel_Generate_infoPrefab
    local peer = self

    local bgName = string.format(Config.SpritePath.IntelligenceTypeName, cfg.type)
    self.ui:LoadSpriteAsync(bgName, peer.bgImage.image)

    local iconName = string.format(Config.SpritePath.IntelligenceSignName, cfg.sign)
    self.ui:LoadSpriteAsync(iconName, peer.iconImage.image)

    peer.nameText.text.text = tostring(pveLevelcfg.nameKey)

    local d = Me:getUserLevel()
    local c = cfg.difficulty - d
    local difficult = 0
    if c >= 3 then
        difficult = 3
    elseif c > -3 then
        difficult = 2
    else
        difficult = 1
    end
    local difficultIcon = string.format(Config.SpritePath.IntelligencedifficultyName, difficult)
    self.ui:LoadSpriteAsync(difficultIcon, peer.difficultImage.image)

    local isUnlock = Me:canOpenFunctionByCfg(cfg.unlock)
    if cfg.page == 2 then   ---如果紧急情报 是不锁定的
       isUnlock = true 
    end
    --local names = {"普通", "简单", "困难"}
    peer.difficultText.text.text = difficultStr[difficult]
    peer.difficultImage.gameObject:SetActive(isUnlock)

    peer.lockView:SetActive(not isUnlock)
    peer.lockText.text.text = cfg.unlockStr

    peer.timeView:SetActive(cfg.page == 2)
    if cfg.page == 2 then
        self.serverData = Me:GetCombatIngelligenctInfo()[data]
        self:UpdateTime()
    end
end

function InfoObj:UpdateTime()
    if self.data == nil then
       return
    end
    if self.cfg.page ~= 2 then
       return
    end
    local serverTime = EngineUtil.ServerTime_Seconds()
    local sTime = self.serverData.createTime
    local eTime = sTime + self.cfg.countDown - serverTime
    local t = math.max(eTime, 0)
    local h = math.floor(t / 3600)
    local m = math.floor((t % 3600) / 60)
    local s = t % 60
    local timeStr = string.format("%02d:%02d:%02d", h, m, s)
    
    ---@type CombatIntelligenctPanel_Generate_infoPrefab
    local peer = self
    peer.timeText.text.text = timeStr

    if eTime <= 0 then
       self.ui:RefreshAllInfoObj() 
    end
end

function InfoObj:OnInfoBtnClick()
    self.ui:play2DSound(string.format(Config.AudioPath.SE, "click"))
    ---@type CombatIntelligenctPanel_Generate_infoPrefab
    local peer = self
    if peer.lockView.activeSelf then
       return 
    end

    self.ui:ShowBattleDetails(self.data)
end

function InfoObj:OnFightBtnClick()

    self.ui:play2DSound(string.format(Config.AudioPath.SE, "click"))
    --判断体力是否充足
    local levelId =  self.data
    local levelConfig = Config.GetPveLevelInfo(levelId)
    if levelConfig == nil then
       return 
    end
    local needStrenigthNum = 0
    if levelConfig.type ~= GE.LevelType.Story then
        self.needStrenigthNum = levelConfig.enterCost[2] + levelConfig.victoryCost[2]
    end

    local isEnough = Me:checkNormalTicket(needStrenigthNum)
    if not isEnough then
        UIMgr:popUICover("BuyTicketPanel", {})
        return
    end

    if levelConfig.cleanNum ~= -1 then
        local levelInfo = Me:getLevelDataByid(levelId)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
        local lastCount = levelConfig.cleanNum - (curCount)
        if lastCount <= 0 then
            UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
            return
        end
    end
    Me:setNowSelectLevel(self.data)
    --TODO: 这里记录上次的模式和章节id  来了看这里
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "CombatIntelligenctPanel")
end

function CombatIntelligenctPanel:InitLogic(data)

    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.CombatIntelligenctPanel)


    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        UIMgr:closeSpecificUI(self)
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)


    self.contentScrollRect.loopListView2:InitListView(0, BindCallback_NoParams(self, self.OnContentValueChange))



    ---@type table<MenuType, UnityEngine.UI.Toggle>
    self.menuToggles = {}
     local stuff = "togType_"
    local toggleView = self.menuToggleView.rectTransform
    local childCount = toggleView.childCount
    for i = 0, childCount - 1 do
        local trs = toggleView:GetChild(i)
        if not string.startswith(trs.name, stuff) then
			goto continue
		end
        ---@type UnityEngine.UI.Toggle
        local toggle = trs:GetComponent(TypeInfo.Toggle)
		if toggle == nil then
			goto continue
		end
		local index = string.sub(trs.name, string.len(stuff) + 1)
        index = tonumber(index)
		toggle.onValueChanged:AddListener(BindCallback(self, self.OnMenuToggleValueChange, index))

        self.menuToggles[index] = toggle
		::continue::
    end
    self.battleDetails.combatIntelligenctPanel_BattleDetails:SetParentUI(self)

    ---@type CombatIntelligenctPanel_InfoObj[] 情报数据
    self.infoObjs = {}

    ---@type integer[]
    self.infoDatas = {}

    ---@type integer
    self.menuType = nil

    ---@type boolean?
    self.breakMenuToggleEvent = nil

    ---@type boolean 是否强制刷新当前界面
    self.refreshAllInfoObj = false
end

--function CombatIntelligenctPanel:StartCreating(time)
--
--end

--function CombatIntelligenctPanel:StartEnter(time)
--
--end

--function CombatIntelligenctPanel:StartRemoving(time)
--
--end

--function CombatIntelligenctPanel:StartExit(time)
--
--end

function CombatIntelligenctPanel:OnOpen(data, initiative)
    local toggle = self.menuToggles[1]
    self.breakMenuToggleEvent = true
    toggle.isOn = true
    self.breakMenuToggleEvent = nil
    self.menuType = 0

    ---@type integer 界面显示状态 0正常  1打开战斗信息界面中 2返回菜单中
    self.isShowDetails = 0
    self:SetMenuType(1)
    self.battleDetails.gameObject:SetActive(false)

	local InterludeLoadingPanel = UIMgr:getUIData("InterludeLoadingPanel")
    if InterludeLoadingPanel then

        LoadingMgr:SetLoadingOver(function()
            if CoveManager.instance() then
                CoveManager.instance():SetHomelandShowOrHide(true)
                CoveManager.instance():setFocusState(false)
                CoveManager.instance()._buildingMgr:FocusingBuild11(10019)
                CoveManager.instance()._buildingMgr:changeBtnState(false)
            end
        end, nil, "CombatIntelligenctPanel2")
    end
    GuideMgr:StartGuideTrigger("CombatIntelligenctPanel")
end

function CombatIntelligenctPanel:Update()

    if self.menuType == 2 then
        for i = 1, #self.infoObjs do
            local obj = self.infoObjs[i]
            obj:UpdateTime()
        end 
    end

    if self.refreshAllInfoObj then
        self:RefreshAllInfoObj_Excute()
    end
end

function CombatIntelligenctPanel:OnClose(initiative)
    -- CoveManager.instance():setCameraMoveable(true)
    -- CoveManager.instance()._buildingMgr:changeBtnState(true)
    -- CoveManager.instance():ChangeVCam(CoveManager.instance().homeFuncVcamObj, false, true, 1)
end

function CombatIntelligenctPanel:OnDestroy()
    CoveManager.instance():setCameraMoveable(true)
    local guideStepId = GuideMgr:GetNowStepId()
    if not guideStepId == 40014 then
        CoveManager.instance()._buildingMgr:changeBtnState(true)
    end
    CoveManager.instance():ChangeVCam(CoveManager.instance().homeFuncVcamObj, false, true, 1)
    -- CoveManager.instance()._buildingMgr:ClearFocusingBuild(self.constuctId)
    -- if self.super.OnDestroy ~= nil then
	--     self.super:OnDestroy(self)
    -- end

    self.super:OnDestroy(self)
end

--function CombatIntelligenctPanel:OnRefresh(data)
--
--end

function CombatIntelligenctPanel:OnMenuToggleValueChange(menuType, isOn)
    if self.breakMenuToggleEvent then
        return    
    end
    if not isOn then
       return 
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:SetMenuType(menuType)
end

---@param menuType MenuType
function CombatIntelligenctPanel:SetMenuType(menuType)

    if self.menuType == menuType then
        return
    end
    self.menuType = menuType

    local datas = {}
    local cfg = Config.GetIntelligenceTable()
    for k, v in pairs(cfg) do
        if v.page ~= menuType then
            goto continue
        end
        if v.page == 2 then
           goto continue 
        end
        if not Me:canOpenFunctionByCfg(v.show) then
            goto continue
        end
        
        local levelData = Me:getLevelDataByid(v.id)
        if levelData ~= nil and levelData.completeNum > 0 then
           goto continue 
        end

        table.insert(datas, v.id)
        ::continue::
    end

    --添加特殊情报
    local serverTime = EngineUtil.ServerTime_Seconds()
    local infoData = Me:GetCombatIngelligenctInfo()
    if infoData ~= nil then
        for k, v in pairs(infoData) do
            if tablex.indexof(datas, v.id) > 0 then
               goto continue 
            end
            --判断是否过期
            if v.finish then
                goto continue
            end
            local infoCfg = Config.GetIntelligenceById(v.id)
            if infoCfg == nil then
               goto continue 
            end
            if infoCfg.page ~= menuType then
                goto continue
            end
            local dur = infoCfg.countDown
            if serverTime > v.createTime + dur then
               goto continue 
            end
            table.insert(datas, v.id)
            ::continue::
        end
    end

    table.sort(datas, function(a, b)
        local acfg = Config.GetIntelligenceById(a)
        local bcfg = Config.GetIntelligenceById(b)
        if acfg == nil then
           return false 
        end
        if bcfg == nil then
           return true 
        end
        local ua = Me:canOpenFunctionByCfg(acfg.unlock)
        local ub = Me:canOpenFunctionByCfg(bcfg.unlock)
        if acfg.page == 2 then  ---紧急情报 只有解锁的那一刻服务器判断
           ua = false 
        end
        if bcfg.page == 2 then
           ub = false 
        end
        if ua ~= ub then
           return ua 
        end
        if acfg.type ~= bcfg.type then
           return acfg.type < bcfg.type 
        end
        if acfg.sort ~= bcfg.sort then
            return acfg.sort > bcfg.sort
        end
        if acfg.id ~= bcfg.id then
           return acfg.id > bcfg.id 
        end
        return false
    end)

    self.contentScrollRect.gameObject:SetActive(#datas ~= 0)
    self.emptyView.gameObject:SetActive(#datas == 0)

    if #datas == 0 then
        return
    end
    self.infoDatas = datas
    self.contentScrollRect.loopListView2:SetListItemCount(0, false)
    self.contentScrollRect.loopListView2:SetListItemCount(#datas, true)
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopListView2
---@param index integer
---@param row integer
---@param col integer
function CombatIntelligenctPanel:OnContentValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("infoPrefab")
    end
    local obj = loopItem.gameObject
    ---@type CombatIntelligenctPanel_InfoObj?
    local infoObj = nil
    for i = 1, #self.infoObjs do
        local rObj = self.infoObjs[i]
        if rObj.gameObject == obj then
            infoObj = rObj
            break
        end
    end
    if infoObj == nil then
        ---@type CombatIntelligenctPanel_InfoObj
        infoObj = InfoObj:Create(obj, self, self.infoPrefab)
        table.insert(self.infoObjs, infoObj)
    end
    local data = self.infoDatas[index+1]
    data = data or nil
    infoObj:SetData(data)
    return loopItem
end

function CombatIntelligenctPanel:RefreshAllInfoObj()

    self.refreshAllInfoObj = true
end

function CombatIntelligenctPanel:RefreshAllInfoObj_Excute()
    self.refreshAllInfoObj = false
    local menuType = self.menuType
    self.menuType = -1
    self:SetMenuType(menuType)
end

function CombatIntelligenctPanel:ShowBattleDetails(levelId)
    if self.isShowDetails ~= 0 then
        return
    end
    self.isShowDetails = 1

    local rTrs = self.contentView.rectTransform
    rTrs:DOKill()
    rTrs:DOAnchorPosX(800, 0.5)

    ---@type UnityEngine.RectTransform
    local rTrs = self.battleDetails.gameObject.transform
    rTrs.anchoredPosition = Vector2.New(700, 0)
    rTrs:DOKill()
    rTrs:DOAnchorPosX(0, 0.5):OnComplete(function()
	    self.isShowDetails = 0
	end)
    self.battleDetails.combatIntelligenctPanel_BattleDetails:setLevelDetails(levelId)
    return
end

function CombatIntelligenctPanel:OnCloseBattleDetailsView()

    if self.isShowDetails ~= 0 then
        return
    end
    self.isShowDetails = 2
    local rTrs = self.contentView.rectTransform
    rTrs:DOKill()
    rTrs:DOAnchorPosX(0, 0.5)

    ---@type UnityEngine.RectTransform
    local rTrs = self.battleDetails.gameObject.transform
    rTrs:DOKill()
    rTrs:DOAnchorPosX(700, 0.5):OnComplete(function()
        self.isShowDetails = 0
	    self.battleDetails.gameObject:SetActive(false)
	end)
    return
end

return CombatIntelligenctPanel
