--好感动
--预制体 FavorContentPanel_New
local FavorContentPanelCtrl = BaseClass("FavorContentPanelCtrl", BaseUICtrl)
local M = FavorContentPanelCtrl

function M:Init()
    self.FavorScrollView = self._view.FavorScrollView
    self.FavorScrollView:Init(require("UI.Ctrl.Dorm.FavorItemCtrl"), require("UI.View.Dorm.FavorItemView"))
    self.LockScrollView = self._view.LockScrollView
    self.LockScrollView:Init(require("UI.Ctrl.Dorm.LockItemCtrl"), require("UI.View.Dorm.LockItemView"))
    self._stageTabs = {}
    
    for i = 1, 4 do
        local tab = require("UI.Ctrl.Dorm.StageTabCtrl").New(self._view["Tab" .. i])
        self._stageTabs[i] = tab
    end
    
    self._selectStageCallback = EventMgr:AddListener(UIMessageNames.FAVOR_SELECT_STAGE, Bind(self, self._OnSelectStage))
    self._selectLevelCallback = EventMgr:AddListener(UIMessageNames.FAVOR_SELECT_LEVEL, Bind(self, self._OnSelectLevel))
    self._module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
end

--初始化好感度界面
function M:OnEnter(heroId)
    self.dormAction.state = DormConst.RoleState.Favor
    
    if heroId == 0 then
        return 
    end
    
    self._heroId = heroId
    self.favorLevel = 0
    self.stage = 0
    local curFavor = 0
    local nextFavor = 0
    local favorProgress = 0
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local favor = 0
    
    if not IsNull(rshd) then
        favor = rshd:GetFavor()
    end
    
    self.favorLevel, curFavor, nextFavor, favorProgress, self.stage = OtakuHelper.GetHeroFeeling(heroId, favor)
    self._view.favorLevel:SetText(tostring(self.favorLevel))
    self._view.favorProgress:SetText(curFavor .. "<color=#737573>/" .. nextFavor .. "</color>")
    self._view.favourSlider.fillAmount = favorProgress
    
    if self.stage == 1 then
        self._view.Name:SetText(560)
    end
    
    if self.stage == 2 then
        self._view.Name:SetText(561)
    end
    
    if self.stage == 3 then
        self._view.Name:SetText(562)
    end
    
    if self.stage == 4 then
        self._view.Name:SetText(563)
    end
    
    self._view.Head:SetAvatarIcon(heroId, RoleType.ERT_Hero)
    self:InitStage(heroId, self.stage)
    self:InitFavorScrollView(heroId, self.stage, self.favorLevel, self.favorLevel)
end

--初始化好感度列表
function M:InitFavorScrollView(heroId, stage, favorLevel, curLevel)
    favorLevel  = favorLevel==0 and 1 or favorLevel
    self.itemList = OtakuHelper.GetFeelingLevelByStage(heroId, stage, favorLevel, curLevel)
    self.FavorScrollView:SetDataList(self.itemList)
    self:InitLock(heroId, favorLevel)
end

--初始化阶段选项按钮
function M:InitStage(heroId, stage)
    self.stageList = OtakuHelper.GetFeelingStages(heroId, self.favorLevel, stage)
    
    for i = 1, 4 do
        if self.stageList[i] then
            self._stageTabs[i]:UpdateItem(self.stageList[i])
        else
            self._stageTabs[i]:Enable(false)
        end
    end
end

-- 初始化好感度解锁
function M:InitLock(heroId, level)
    self.lockList = OtakuHelper.GetFellingLevelUnlock( heroId, level, self.favorLevel)

    if self.lockList == nil then
        self._view.PanelList.transform:SetActive(false)
    else
        self._view.PanelList.transform:SetActive(true)
        local str = ConfigHelper.GetLocalString(183)
        self._view.LockText:SetTextFormat(str, level)
        self.LockScrollView:SetDataList(self.lockList)
    end
end

--好感度等级选项回调
function M:_OnSelectLevel(parm)
    local dataList = self.FavorScrollView:GetDataList()
    
    for i, v in ipairs(dataList) do
        --选择好感度等级
        if v.feelingLevel ~= parm then
            v.isSelect = false
        else
            v.isSelect = not v.isSelect
        end
        
        self:InitLock(self._heroId, parm)
    end
    
    self.FavorScrollView:UpdateList()
end

--阶段选项回调
function M:_OnSelectStage(stage)
    for i, v in ipairs(self.stageList) do
        if v.stage ~= stage then
            v.isSelect = false
        else
            v.isSelect = not v.isSelect
        end
    end
    
    for i = 1, 4 do
        self._stageTabs[i]:UpdateItem(self.stageList[i])
    end
    
    --切换阶段后重置好感度列表
    if stage == self.stage then
        self:InitFavorScrollView(self._heroId, stage, self.favorLevel, self.favorLevel)
    else
        local favorLevel = OtakuHelper.GetMinLevelByStage(self._heroId, stage)
        self:InitFavorScrollView(self._heroId, stage, favorLevel, self.favorLevel)
    end
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnBack()
    UIContextMgr:GetInstance():Show("Dorm", self._module.roleStudio, self._module.dormData)
    self:Close()
end

function M:OnClose()
    self.dormAction.state = DormConst.RoleState.Command
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.FAVOR_SELECT_STAGE, self._selectStageCallback)
    EventMgr:RemoveListener(UIMessageNames.FAVOR_SELECT_LEVEL, self._selectLevelCallback)
    self.dormAction = nil
    M.super.OnDispose(self)
end

return FavorContentPanelCtrl
