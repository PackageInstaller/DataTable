---@class ActivityPanel : ActivityPanel_Generate
---##################### 【ActivityPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityPanel = require "ActivityPanel_Generate"
local cjson = require "cjson"

local specialPanelList = {
    [1] = "ActivitySignPanel", --签到
}

function ActivityPanel:InitLogic(data)
    self.activityIdList = {}
    self.msgEventHandler = {
        --活动数据更新刷新本界面 不接管子面板刷新逻辑 用于活动消失重新选择
        {GameMsgType.ActivityMapUpdate, self.RefreshPanel},
        --任务数据刷新 同上
        {GameMsgType.MissionRefresh, self.RefreshPanel},
        {GameMsgType.RedPointRefresh, self.RefreshPanel},
    }
end

--function ActivityPanel:StartCreating(time)
--
--end

--function ActivityPanel:StartEnter(time)
--
--end

--function ActivityPanel:StartRemoving(time)
--
--end

--function ActivityPanel:StartExit(time)
--
--end

-- {
--     mode = number, --主界面活动面板模式
--     activityId = number, --活动id
-- }
function ActivityPanel:OnOpen(data, initiative)
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.ActivityPanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        -- UIMgr:clearAllUI()
        CoveManager.instance():SetGameSceneInfoShowOrHide(true)
        SeaMapMgr:resetLastMode()
        local seaMapRoot = GameObject.Find("SeaMapRoot")
        if seaMapRoot then
            GameObject.Destroy(seaMapRoot)
        end
        -- UIMgr:popUIBase("MainPanel")
        if self.lastPanelName then
            UIMgr:closeSpecificUI(self.lastPanelName)
            self.lastPanelName = nil
        end
        UIMgr:closeCurrentUI()
        ClientData:RecordActivityPanelLastSelectId(nil)
    end)

    -- if initiative then
        self:RefreshPanel(data.activityId)
    -- end
end

--刷新界面
---@param activityId number 选中活动id
function ActivityPanel:RefreshPanel(activityId)
    local eventId = self:initData(activityId)
    self:onSelect(eventId)
end

--检查活动是否已经存在列表里
function ActivityPanel:checkIsExist(activityId, targetList)
    for _, id in pairs(targetList) do
        if id == activityId then
            return true
        end
    end
    return false
end

--初始化数据
---@param activityIdFirst number 优先选中的活动id
---@return number 选中的活动id
function ActivityPanel:initData(activityIdFirst)
    --添加展示活动id
    local showIdList = UICommonUtils.GetActivityShowIdList(GE.ActivityFunctionType.ActivityPanel)
    for _, activityId in ipairs(showIdList) do
        --检测是否已经存在列表里
        if not self:checkIsExist(activityId, self.activityIdList) then
            table.insert(self.activityIdList, activityId)
        end
    end

    --删除不存在的活动id 用于原先存在的活动消失后的表现
    --免删除列表（活动消失后不立刻删除，等重进界面再删）
    local immuneType = {
        GE.ActivityType.FirstCharge
    }
    for i = 1, tablex.size(self.activityIdList), 1 do
        local id = self.activityIdList[i]
        if not self:checkIsExist(id, showIdList) then
            local cfg = Config.GetActivityInfo(id)
            if cfg and tablex.find(immuneType, cfg.Type) then
                LuaLogger.ds("ActivityPanel:initData 免删除活动id=", id)
            else
                table.remove(self.activityIdList, i)
            end
        end
    end
    --排序
    table.sort(self.activityIdList, function(a, b)
        local aCfg = Config.GetActivityInfo(a)
        local bCfg = Config.GetActivityInfo(b)
        return aCfg.index < bCfg.index
    end)
    LuaLogger.ds("ActivityPanel 活动id列表", tablex.dump(self.activityIdList))
    --上一次选中的id
    local stillExist = false
    local index = nil
    for _, id in pairs(self.activityIdList) do
        if ClientData:GetActivityPanelLastSelectId() == id then
            stillExist = true
            break
        end
    end
    --上次选中的活动不存在 则重置 默认选中第一个
    if stillExist then
        index = ClientData:GetActivityPanelLastSelectId()
    else
        --如果传入了活动id则优先选中传入的活动id
        if activityIdFirst and self:checkIsExist(activityIdFirst, self.activityIdList) then
            index = activityIdFirst
        end
    end
    return index and index or self.activityIdList[1]
end

--刷新左侧按钮列表
function ActivityPanel:refreshLeftBtnList(activityId)
    self:FillTemplateContent(self.leftBtn, self.leftBtnRoot, tablex.size(self.activityIdList), function(index, leftBtn)
        local id = self.activityIdList[index]
        local cfg = Config.GetActivityInfo(id)
        leftBtn:SetActive(true)
        leftBtn.sel:SetActive(activityId == id)
        leftBtn.sel.selName.text.text = cfg.nameKey
        leftBtn.btnName:SetActive(activityId ~= id)
        leftBtn.btnName.text.text = cfg.nameKey
        leftBtn.button.onClick:RemoveAllListeners()
        leftBtn.button.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, "click"))
            self:onClickLeftBtn(id)
        end)
        --红点
        local state = RedPointMgr:getRedPointByActivityId(id)
        leftBtn.redPoint:SetActive(state)
    end)
end

--点击左侧按钮事件
---@param eventId number 活动id
function ActivityPanel:onClickLeftBtn(eventId)
    --防止重复点击
    LuaLogger.ds("ActivityPanel:onClickLeftBtn", "eventId=", eventId, "curSelectId=", self.curSelectId)
    if self.curSelectId == eventId then
        LuaLogger.ds("ActivityPanel:onClickLeftBtn 重复点击，忽略处理")
        return
    end
    self:onSelect(eventId)
end

--通过活动id刷新界面
function ActivityPanel:refreshByEventId(eventId)
    --为了兼容跳转从其他界面返回时刷新界面 self.curSelectId不会变化但self.lastPanelName需要重新pop
    if self.lastPanelName and UIMgr:GetUI(self.lastPanelName) then
        return
    end
    self:onSelect(eventId)
end

--应用选择活动表现逻辑
---@param activityId number 活动id
function ActivityPanel:onSelect(activityId)
    UICommonUtils.RecordWatchedActivity(activityId)
    self:refreshLeftBtnList(activityId)
    self:refreshRightPart(activityId)
    self.curSelectId = activityId
    ClientData:RecordActivityPanelLastSelectId(activityId)
end

--- 刷新右侧子界面
function ActivityPanel:refreshRightPart(activityId)
    for _, id in pairs(self.activityIdList) do
        if activityId == id then
            self.curShowCfg = Config.GetActivityInfo(id)
            break
        end
    end
    if not self.curShowCfg then
        return
    end
    if not self.curShowCfg.panelName or self.curShowCfg.panelName == "" then
        return
    end
    --相同面板不刷新
    if UIMgr:GetUI(self.curShowCfg.panelName)  then
        local isSpecial = false
        for _, v in pairs(specialPanelList) do
            if self.curShowCfg.panelName == v then
                isSpecial = true
                break
            end
        end
        if isSpecial then
            GameMsgMgr:sendEvent(GameMsgType.ActivityPanelUpdate, {
                cfg = self.curShowCfg,
                isFromActivity = true
            })
        end
        return
    end
    self:LoadSpriteAsync(string.format(Config.SpritePath.ActivityBgPath, self.curShowCfg.BgName), function (s)
        UIMgr:popUICover(self.curShowCfg.panelName, {
            cfg = self.curShowCfg,
            isFromActivity = true
        }, function()
            self.bg.image.sprite = s
            --活动角色特殊动画 显示在背景上
            self.activitySignRole:SetActive(self.curShowCfg.panelName == "ActivitySignPanel")
            self.activityFirstChargeRole:SetActive(self.curShowCfg.panelName == "ActivityFirstChargePanel")
            self.activityRoleExchangeRole:SetActive(self.curShowCfg.panelName == "ActivityRoleExchange")
        end)
    end)

    --关闭上一个面板
    if self.lastPanelName then
        UIMgr:closeSpecificUI(self.lastPanelName)
    end
     self.lastPanelName = self.curShowCfg.panelName
end

-- function ActivityPanel:OnClose(initiative)
--     RedPointMgr:Refresh("ActivityPanelRedPoint")
--     self.lastPanelName = nil
-- end

function ActivityPanel:OnDestroy()
	RedPointMgr:Refresh("ActivityPanelRedPoint")
    self.lastPanelName = nil
    self.super:OnDestroy(self)
end

--function ActivityPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/Left/Scroll View/Viewport/LeftBtnRoot/LeftBtn onClick 
--]]
function ActivityPanel:leftBtn_Button_onClick(leftBtn)

end

return ActivityPanel
