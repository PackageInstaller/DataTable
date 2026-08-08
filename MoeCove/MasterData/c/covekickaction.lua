
---踢饮料机事件
local CoveActionBase = require("CoveActionBase")
---@class CoveKickAction: CoveActionBase
local CoveKickAction = class("CoveKickAction", CoveActionBase)

function CoveKickAction:ctor(coveBase)
    self.isInit = true
    self.sendEvent = false
end


---@param covePropsId integer propsId
---@param param integer 事件参数
---@param stateDt number 动画时间
function CoveKickAction:Begin(covePropsId, param, stateDt)
    CoveActionBase.Begin(self)
    self.covePropsId = covePropsId
    self.param = param
    self.stateDt = stateDt
    self.sendEvent = false
    self:Action()
end

function CoveKickAction:Action()
    self.covebase:AddAnimOverCallBack(self, self.OnAnimOverCallBack)
    self.covebase._model:PlayAnim(RoleModelAnimEnum.Kick, function()
        if self.stateDt <= 0 then
            self:SendEvent()
            self:Stop()
        end
    end)

    local stateDt = self.stateDt
    if stateDt > 0 then
        self:AddTimeWait(stateDt, function()
            self:SendEvent()
            self:Stop()
        end)
    end
   
end


function CoveKickAction:Stop()
    CoveActionBase.Stop(self)
    self:Exit()
end

function CoveKickAction:Exit()
    CoveActionBase.Exit(self)
    self:DeleteAllWaitTime()
    self.covebase:RemoveAnimOverCallBack(self)
end


function CoveKickAction:Destroy()
    if self.covebase ~= nil then
       self.covebase:RemoveAnimOverCallBack(self)
    end
    
    CoveActionBase.Destroy(self)
end


---@param key string 关键帧事件名
function CoveKickAction:OnAnimOverCallBack(key)
    if key ~= "kick_kf" then
       return
    end
    if not self.isRuning then
       return 
    end
    self:SendEvent()
end


function CoveKickAction:SendEvent()
    local coveProps = CovePropsMgr.instance():GetCoveProps(self.covePropsId)
    if coveProps == nil then
       return 
    end
    if self.sendEvent then
       return 
    end
    self.sendEvent = true
    coveProps:PlayInteractEffect(self.param)


    ---@type HomeTouchConstructionTable?
    local cfg = Config.GetHomeTouchConstructionInfo(self.covePropsId)
    if cfg == nil then
       return
    end
    local serverData = Me:GetCovePropsInfo(self.covePropsId)
    if serverData ~= nil and serverData.getCount >= cfg.dailyAwardNum then
       return
    end

    Me:ReportHomelandCovePropsAddRewardReq(self.covePropsId, self.param, function(res)
        if res.rewards ~= nil and #res.rewards > 0 then
            coveProps:PlayResourceOpenEffect() 
        end
    end)
end

return CoveKickAction
