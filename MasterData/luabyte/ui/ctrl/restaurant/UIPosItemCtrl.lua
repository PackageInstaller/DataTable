-- baoruichang
-- 2023/5/29 17:49:58
local UIPosItemCtrl = BaseClass("UIPosItemCtrl", UIBaseComponent)
local M = UIPosItemCtrl
local ETableState = EnumConst.ETableState
local sfmt = string.format
local mCeil = math.ceil -- 向上取整
local mModf = math.modf -- 向下取整
local USETIME = 3

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self._onClick))
end

function M:UpdateData(data)
    self.data = data
    self._view.uiState:SetState(data.state)
    if data.state == ETableState.None then
        return
    end
    if data.state == ETableState.Lock then
        local lockTips = ConfigHelper.GetLocalString(6237)
        lockTips = sfmt(lockTips, data.lockTips)
        self._view.lockTips:SetText(lockTips)
        return
    end
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    self.useTime = 0
    if data.state == ETableState.Use then
        self.resTimer = USETIME
        self._view.imgHead:SetAvatarIcon(data.heroId, RoleType.ERT_Hero)
        self._view.imgProfession:SetProfessional(data.heroId)
        self._timer = TimerManager:GetInstance():GetTimer(0.03, Bind(self, self.UpdateUseState), self)
        self._timer:Start()
        self:UpdateUseState()
        return
    end
    -- 清理中
    local nowTimer = TimeUtil.GetNowTimeStamp()
    -- 剩余时间
    self.resTimer = data.endTimer - nowTimer
    self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
    self:TimerCallBack()
    self._timer:Start()
end

-- 更新使用中的状态
function M:UpdateUseState()
    self.resTimer = self.resTimer - 0.03
    local num = (USETIME - self.resTimer) / USETIME
    num = num > 1 and 1 or num
    self._view.scrollBarUse.size = num
    local strTimer = TimeUtil.SecToStringFormat(mModf(self.resTimer))
    self._view.labTimerUse:SetText(strTimer)
    self._view.labNumUse:SetText(tostring(mModf(num * 100)))
    if self.resTimer <= 0 then
        self._timer:Stop()
        self._timer = nil
        self.data.heroId = nil
        self.data.state = ETableState.Cleaning
        self:UpdateData(self.data)
    end
end

function M:TimerCallBack()
    self.resTimer = self.resTimer - 1
    self.resTimer = self.resTimer < 0 and 0 or self.resTimer
    local num = 1 - self.resTimer / self.data.clearTime
    num = num > 1 and 1 or num
    local strTimer = TimeUtil.SecToStringFormat(self.resTimer)
    local labNum = mModf(num * 100)
    if self.resTimer > 0 then -- 时间未到 向下取整任然为100手动设置为99
        labNum = labNum >= 100 and 99 or labNum
    end
    self._view.labTimerClear:SetText(strTimer)
    self._view.scrollBarClear.size = num
    self._view.labNumClear:SetText(tostring(labNum))
    if self.resTimer <= 0 then
        if self._timer then
            self._timer:Stop()
            self._timer = nil
            self.data.state = ETableState.None
            self:UpdateData(self.data)
        end
    end
end

function M:GetUserId()
    if not self.data then
        return
    end
    return self.data.heroId
end

function M:_onClick()
    if not self.data then
        return
    end
    if self.data.state ~= ETableState.None then
        return
    end
    UIContextMgr:GetInstance():Show(UIDefine.UICookChooseHero, self.data.callBack, self.data.nullNum)
end

function M:OnDestroy()
    M.super.OnDestroy(self)
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

return UIPosItemCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--						  . ' \\| |// `.
--                       / \\||| : |||// \
--                     / _||||| -:- |||||- \
--                       | | \\\ - --/ | |
--                     | \_| ''\---/'' | |
--                      \ .-\__ `-` ___/-. /
--                   ___`. .' /--.--\ `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

