-- 进度条 （例子可参考 MenuView）
Bar = {}
local this = Bar
function this.New(o)
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins
end

function this:Stop()
    self.isShow = false
end

-- ==============================--
-- desc: 初始化(需要由表读取每级数据)
-- time:2019-08-23 11:19:21
-- @_fill:  滑动条Go   看_isImage需求
-- @_excel: 经验表
-- @_key:   exp 的 key
-- @_lvCB:  等级回调  （lv）   当前等级
-- @_expCB: exp回调   （curExp,curmaxExp） 当前等级经验，当前等级总经验
-- @_timer: 需要的滑动时长 默认2s
-- @_endCB: 动画结束回调
-- @return 
-- ==============================--
function this:Init(_fill, _excel, _key, _lvCB, _expCB, _timer, _endCB, _isFill)
    self.isFill = _isFill
    if (self.isFill) then
        self.fill = ComUtil.GetCom(_fill, "Image")
    else
        self.fill = ComUtil.GetCom(_fill, "Slider")
    end
    self.allExp = self:SetAllExp(_excel, _key)
    self.lvCB = _lvCB
    self.expCB = _expCB
    self.timer = _timer or 2
    self.endCB = _endCB
    self.isInit = false
    self.isShow = false
end

function this:ChangeTimer(_timer)
    self.timer = _timer
end

-- ==============================--
-- desc: 开始显示
-- time:2019-08-23 11:10:05
-- @_curLv:  当前等级
-- @_curExp: 当前等级已有经验
-- @_getExp: 获得多少经验  可用 self:SetExp() 计算
-- @return 
-- ==============================--
function this:Show(_curLv, _curExp, _getExp)
    self.isShow = false
    if (_getExp > 0) then
        self.curLv = _curLv
        self.curExp = _curExp
        self.getExp = _getExp
        self.curGetExp = _getExp
        self.isShow = true
    end
end

function this:Update()
    if (not self.isInit and not self.isShow) then
        return
    end
    if (self.curGetExp > 0) then
        self.per = Time.deltaTime / self.timer * self.getExp
        if (self.per > self.curGetExp) then
            self.per = self.curGetExp
        end
        self.curExp = self.curExp + self.per
        self.curMaxExp = self.allExp[self.curLv] or 0
        while self.curMaxExp > 0 and self.curExp >= self.curMaxExp do
            self.curLv = self.curLv + 1
            self.curExp = self.curExp - self.curMaxExp
            self.curMaxExp = self.allExp[self.curLv] or 0
        end
        if (self.isFill) then
            self.fill.fillAmount = self.curMaxExp == 0 and 1 or self.curExp / self.curMaxExp
        else
            self.fill.value = self.curMaxExp == 0 and 1 or self.curExp / self.curMaxExp
        end
        self.curGetExp = self.curGetExp - self.per
        self:LvCallBack()
        self:ExpCallBack()
    else
        self:LvCallBack()
        self:ExpCallBack()
        self.isShow = false
        if (self.endCB) then
            self.endCB()
        end
    end
end

-- 等级回调
function this:LvCallBack()
    if (self.lvCB) then
        self.lvCB(self.curLv)
    end
end

-- 当前经验回调
function this:ExpCallBack()
    if (self.expCB) then
        if (self.curMaxExp == 0) then
            local max = self.allExp[self.curLv - 1] or 0
            self.expCB(max, max)
        else
            self.expCB(self.curExp, self.curMaxExp)
        end
    end
end

-- ==============================--
-- desc: 封装一个数组
-- time:2019-08-23 01:54:21
-- @excel: 表
-- @key:   exp的key
-- @return 
-- ==============================--
function this:SetAllExp(excel, key)
    local datas = {}
    for i, v in ipairs(excel) do
        datas[i] = v[key]
    end
    return datas
end

-- ==============================--
-- desc: 计算当前获得的经验
-- time:2019-08-23 01:54:48
-- @excel: 表
-- @key:   exp的key
-- @oldLv: 旧等级
-- @oldExp:旧等级时的经验
-- @self.curLv: 新等级
-- @self.curExp:新等级下的经验
-- @return 
-- ==============================--
function this:SetExp(_excel, _key, _oldLv, _oldExp, _curLv, _curExp)
    local datas = self:SetAllExp(_excel, _key)
    local count = 0
    for i = _oldLv, _curLv - 1 do
        count = count + datas[i]
    end
    count = count - _oldExp + _curExp
    return count > 0 and count or 0
end

---------------------------------------------------------------------------------------------
-- ==============================--
-- desc: 倒计时（每0.1秒执行一次）
-- time:2020-06-03 02:07:19
-- @_fill:
-- @_startTime: 开始时间
-- @_endTim: 结束时间
-- @_timer:
-- @_expCB:返回当前剩余时间
-- @_endCB:倒计时结束时返回一次
-- @return 
-- ==============================--
function this:Init2(_fill, _expCB, _endCB, _rever)
    self.fill = ComUtil.GetCom(_fill, "Slider")
    self.expCB = _expCB
    self.endCB = _endCB
    self.timer = 0
    self.isShow = false
    self.rever = _rever
end

function this:Show2(_startTime, _endTime, _o_end, _isEnd)
    self.isShow = false
    if (TimeUtil:GetTime() < _endTime) then
        self.startTime = _startTime
        self.endTime = _endTime
        self.isShow = true
        self.o_end = _o_end
        self.isEnd = _isEnd
        self.timer = 0
        if (self.isEnd) then
            self.perAdd = (self.endTime - TimeUtil:GetTime()) / 50 -- 每帧添加量
        end
        self.isShow = true
    else
        if (self.expCB) then
            self.expCB(0)
        end
        if (self.endCB) then
            self.endCB()
        end
    end
end
function this:Update3()
    if (not self.isShow) then
        return
    end
    self.timer = self.timer - Time.deltaTime
    if (self.isEnd) then
        self.endTime = self.endTime - self.perAdd
        self:SetCalTime3()
    else
        if (self.timer <= 0) then
            self.timer = 0.1
            self:SetCalTime3()
        end
    end
end

function this:Update2()
    if (not self.isShow) then
        return
    end
    self.timer = self.timer - Time.deltaTime

    if (self.isEnd) then
        self.endTime = self.endTime - self.perAdd
        self:SetCalTime2()
    else
        if (self.timer <= 0) then
            self.timer = 0.1
            if (self.rever) then
                self.fill.value = 1 - (TimeUtil:GetTime() - self.startTime) / (self.endTime - self.startTime)
            else
                self.fill.value = (TimeUtil:GetTime() - self.startTime) / (self.endTime - self.startTime)
            end
            local needTime = self.endTime - TimeUtil:GetTime()
            needTime = needTime < 0 and 0 or needTime
            if (self.expCB) then
                self.expCB(needTime)
            end
            if (needTime <= 0) then
                self.isShow = false
                if (self.endCB) then
                    self.endCB()
                end
            end
        end
    end
end

function this:SetCalTime2()
    local percent = (TimeUtil:GetTime() - self.startTime + self.o_end - self.endTime) / (self.o_end - self.startTime)
    if (self.rever) then
        self.fill.value = 1 - percent
    else
        self.fill.value = percent
    end
    local needTime = self.endTime - TimeUtil:GetTime()
    needTime = needTime < 0 and 0 or needTime
    if (self.expCB) then
        self.expCB(needTime)
    end
    if (needTime <= 0) then
        self.isShow = false
        if (self.endCB) then
            self.endCB()
        end
    end
end

---------------------------------------------------------------------------------------------
-- ==============================--
-- desc: 倒计时（每0.1秒执行一次）
-- time:2020-06-03 02:07:19
-- @_fill: 倾斜或切割形的进度条
-- @_startTime: 开始时间
-- @_endTim: 结束时间
-- @_timer:
-- @_expCB:返回当前剩余时间
-- @_endCB:倒计时结束时返回一次
-- @return 
-- ==============================--
function this:Init3(_barMaskObj, _barObj, _expCB, _endCB)
    self.barMaskObj = _barMaskObj
    self.barObj = _barObj
    self.barMaskX = CSAPI.GetAnchor(_barMaskObj)
    self.barObjX = CSAPI.GetAnchor(_barObj)
    self.barObjLen = CSAPI.GetRTSize(_barObj)[0]

    self.expCB = _expCB
    self.endCB = _endCB
    self.timer = 0
    self.isShow = false
end

function this:Show3(_startTime, _endTime, _o_end, _isEnd)
    self.isShow = false
    if (TimeUtil:GetTime() < _endTime) then
        self.startTime = _startTime
        self.endTime = _endTime
        self.o_end = _o_end
        self.isEnd = _isEnd
        self.timer = 0
        if (self.isEnd) then
            self.perAdd = (self.endTime - TimeUtil:GetTime()) / 50
        end
        self.isShow = true
    else
        if (self.expCB) then
            self.expCB(0, 1)
            local addX = self.barObjLen
            CSAPI.SetAnchor(self.barMaskObj, self.barMaskX + addX, 0, 0)
            CSAPI.SetAnchor(self.barObj, self.barObjX - addX, 0, 0)
        end
        if (self.endCB) then
            self.endCB()
        end
    end
end

function this:Update3()
    if (not self.isShow) then
        return
    end
    self.timer = self.timer - Time.deltaTime
    if (self.isEnd) then
        self.endTime = self.endTime - self.perAdd
        self:SetCalTime3()
    else
        if (self.timer <= 0) then
            self.timer = 0.1
            self:SetCalTime3()
        end
    end
end

function this:SetCalTime3()
    local percent = (TimeUtil:GetTime() - self.startTime + self.o_end - self.endTime) / (self.o_end - self.startTime)
    local addX = self.barObjLen * percent
    CSAPI.SetAnchor(self.barMaskObj, self.barMaskX + addX, 0, 0)
    CSAPI.SetAnchor(self.barObj, self.barObjX - addX, 0, 0)
    local needTime = self.endTime - TimeUtil:GetTime()
    needTime = needTime < 0 and 0 or needTime
    if (self.expCB) then
        self.expCB(needTime, percent)
    end
    if (needTime <= 0) then
        self.isShow = false
        if (self.endCB) then
            self.endCB()
        end
    end
end

return this
