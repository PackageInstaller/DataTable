-- baoruichang
-- 2023/6/13 19:53:28
-- UITurntableThrow
local UITurntableThrowCtrl = BaseClass("UITurntableThrowCtrl", BaseUICtrl)
local M = UITurntableThrowCtrl
local MessageId = Proto.MessageId
local mRandom = math.random

function M:Init()
    self._view.btn:onClick(Bind(self, self._onClick))
    self._view.btnImg:onClick(Bind(self, self._onClickImg))
end

-- 进入UI，可传参数
function M:OnEnter(activityId)
    self.activityId = activityId
end

function M:_onClick()
    if self._timer then
        self._timer:Stop()
    end
    self.refTimer = 0
    self._timer = TimerManager:GetInstance():GetTimer(0.05, Bind(self, self._callBack))
    self._timer:Start()
end

function M:_callBack()
    self.refTimer = self.refTimer + 0.05
    self._view.tfMask.sizeDelta = Vector2(self._view.tfMask.sizeDelta.x, 100 * self.refTimer / 5);
    if self._timer and self.refTimer >= 5 then
        self._timer:Stop()
        self._timer = nil
    end
end

function M:_onClickImg()
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    local Points = 0
    if self.refTimer < 1 then
        Points = 1
    elseif self.refTimer < 3 then
        Points = 2
    else
        Points = 3
    end
    Points = Points * 2 - mRandom(0, 1)
    self:RequestThrowTurntablePoints(Points)
end

------------------------------------Start-------------------------------------------
function M:RequestThrowTurntablePoints(Points)
    self.tempResponseThrowTurntablePointsCallback = NetPack:RegistResponse(MessageId.ResponseThrowTurntablePoints, Bind(self, self.ResponseThrowTurntablePointsCallback))
    local request = {}
    request.ActivityId = self.activityId
    request.Points = Points
    NetPack:SendMessage(MessageId.RequestThrowTurntablePoints, request)
end

function M:ResponseThrowTurntablePointsCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseThrowTurntablePoints, self.tempResponseThrowTurntablePointsCallback)
    self.tempResponseThrowTurntablePointsCallback = nil
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    GameHelper.ShowGetItemsByItems(msg.Awards)
end
------------------------------------End-------------------------------------------

function M:OnDispose()
    M.super.OnDispose(self)
end

return UITurntableThrowCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |// `.
--                       / ..||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' |_. |
--                     \ .-.\__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 \ \ `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                       西江月·世事一场大梦
--                                      <苏轼>
--                          世事一场大梦，
--                          人生几度秋凉？
--                          夜来风叶已鸣廊。
--                          看取眉头鬓上。
--                          酒贱常愁客少，
--                          月明多被云妨。
--                          中秋谁与共孤光。
--                          把盏凄然北望。
