-- baoruichang
-- 2023/3/30 14:40:21
-- 平行宇宙主界面
local UIUniverseCtrl = BaseClass("UIUniverseCtrl", BaseUICtrl)
local M = UIUniverseCtrl
local EBattleStyle = EnumConst.EBattleStyle

function M:Init()
    self._view.btnShop:onClick(Bind(self, self._OnBtnShopClick))
    self._view.btnTask:onClick(Bind(self, self._OnBtnTaskClick))
    self._view.btn1:onClick(Bind(self, self._OnBtnFight1Click))
    self._view.btn2:onClick(Bind(self, self._OnBtnFight2Click))
end

-- 进入UI，可传参数
function M:OnEnter(activityId)
    self.activityId = activityId
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=self.activityId})
    self.activityCopy = activityCopys[1]
    self:_InitUI()
    GameHelper.DoPlayerAction(PlayerAction.OpenDefauleChapter)
end

function M:_InitUI()
    self.activity = ConfigHelper.GetCfgByLua("activity", self.activityId)
    local endTime = self.activity.endTime
    local nowTime = TimeUtil:GetNowTimeStamp()
    local overTimeTips = TimeUtil.GetTimeFormat(endTime, "%m/%d %H:%M")
    overTimeTips = ConfigHelper.GetLocalString(6152) .. "  " .. overTimeTips
    self._view.labTimer:SetText(overTimeTips)

    -- 已经关闭
    if nowTime > endTime then
        self._view.uiState1:SetState(3)
        self._view.uiState2:SetState(3)
        self._view.labTips:SetText(6151)
        return
    end
    self._view.uiState1:SetState(1)

    -- 特殊战役开启时间
    local specialTime = self.activityCopy.specialTime
    if nowTime < specialTime then
        local tips = TimeUtil.GetTimeFormat(specialTime, "%m/%d %H:%M") .. ConfigHelper.GetLocalString(6153)
        self._view.uiState2:SetState(3)
        self._view.labTips:SetText(tips)
        return
    end
    self._view.uiState2:SetState(1)
    MissionDataMgr:GetInstance():LoadChapter(self.activityCopy.chapterId, Bind(self, self._OnLoadChapter))
end

function M:_OnLoadChapter()
   -- 是否通关简单战役
   local chapterId = self.activityCopy.chapterId
   local passState = MissionDataMgr:GetInstance():IsPassedChapter(chapterId)
   if passState then
       self._view.uiState2:SetState(1)
   else
       self._view.uiState2:SetState(2)
       self._view.labTips:SetText(6150)
   end
end

-- 商店
function M:_OnBtnShopClick()
    UIContextMgr:GetInstance():Show(self.activityCopy.UIShop, self.activityId)
end

-- 任务
function M:_OnBtnTaskClick()
    UIContextMgr:GetInstance():Show(self.activityCopy.UITask, self.activityId)
end

-- 简单关卡
function M:_OnBtnFight1Click()
    if self._view.uiState1:GetState() ~= 1 then
        return
    end
    local chapterId = self:GetContext():GetChapterId(0)
    local chapter = ConfigHelper.GetCfg("chapter", chapterId)
    JumpMgr:GetInstance():Execute(100, EBattleStyle.Normal, chapter)
end

-- 困难关卡
function M:_OnBtnFight2Click()
    if self._view.uiState2:GetState() ~= 1 then
        return
    end
    local chapterId = self:GetContext():GetChapterId(1)
    local chapter = ConfigHelper.GetCfg("chapter", chapterId)
    GameHelper.DoPlayerAction(PlayerAction.OpenEliteChapter)
    JumpMgr:GetInstance():Execute(100, EBattleStyle.Normal, chapter)
end

function M:Close()
    JumpMgr:GetInstance():Execute(1)
    M.super.Close(self)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UIUniverseCtrl

