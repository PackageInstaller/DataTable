local Class = require("glib.class")
local CommDefine = require("cs_share.common_define")
local COUNTER_STATUS = {
  INIT = 1,
  RUNNING = 2,
  PAUSE = 3,
  STOP = 4
}
local TIME_CUT_TIPS_ACTION = CommDefine.TIME_CUT_TIPS_ACTION

function NewObj(oBehavior)
  return CCommCounterMngr:New(oBehavior)
end

CCommSceneCounter = Class("CCommSceneCounter", "CSceneCounter")

function CCommSceneCounter:init(sKey, nMaxCount, nType, oBehavior)
  super(CCommSceneCounter).init(self, sKey)
  self.m_oBehavior = oBehavior
  self.m_nMaxCount = nMaxCount
  self.m_nType = nType
  oBehavior:set_scene_tips(sKey, true, {
    cur_cnt = 0,
    total_cnt = nMaxCount,
    type = nType
  })
end

function CCommSceneCounter:GetCnt()
  return self:GetMemValue()
end

function CCommSceneCounter:AddCnt()
  self:AddMem()
  self.m_oBehavior:set_scene_tips(self:Key(), true, {
    cur_cnt = self:GetCnt(),
    total_cnt = self.m_nMaxCount,
    type = self.m_nType
  })
end

CCommSceneTimeCounter = Class("CCommSceneTimeCounter", "CSceneCounter")

function CCommSceneTimeCounter:init(sKey, nDuration, nType, oBehavior)
  super(CCommSceneTimeCounter).init(self, sKey)
  self.m_oBehavior = oBehavior
  self.m_nStartTime = nil
  self.m_nStopTime = nil
  self.m_nPauseTime = nil
  self.m_nCacheTime = 0
  oBehavior:set_scene_tips(sKey, true, {total_time = nDuration, type = nType})
end

function CCommSceneTimeCounter:Start(nTimeStamp)
  if self.m_nStartTime then
    return
  end
  self.m_nStartTime = nTimeStamp or self.m_oBehavior:get_fight_time()
  self:SetStatus(COUNTER_STATUS.RUNNING)
  self.m_nStopTime = nil
  self.m_oBehavior:set_time_cut_tips(self:Key(), TIME_CUT_TIPS_ACTION.START)
end

function CCommSceneTimeCounter:Pause()
  if self:GetStatus() ~= COUNTER_STATUS.RUNNING then
    return
  end
  self:SetStatus(COUNTER_STATUS.PAUSE)
  self.m_nPauseTime = self.m_oBehavior:get_fight_time()
  self.m_oBehavior:set_time_cut_tips(self:Key(), TIME_CUT_TIPS_ACTION.PAUSE)
end

function CCommSceneTimeCounter:Continue()
  if self:GetStatus() ~= COUNTER_STATUS.PAUSE then
    return
  end
  self:SetStatus(COUNTER_STATUS.RUNNING)
  self.m_nCacheTime = self.m_nCacheTime - self.m_oBehavior:get_fight_time() + self.m_nPauseTime
  self.m_nPauseTime = nil
  self.m_oBehavior:set_time_cut_tips(self:Key(), TIME_CUT_TIPS_ACTION.CONTINUE)
end

function CCommSceneTimeCounter:Stop()
  local status = self:GetStatus()
  if status == COUNTER_STATUS.INIT or status == COUNTER_STATUS.STOP then
    return
  end
  self.m_nStopTime = self.m_oBehavior:get_fight_time()
  self:SetStatus(COUNTER_STATUS.STOP)
  self.m_oBehavior:set_time_cut_tips(self:Key(), TIME_CUT_TIPS_ACTION.STOP)
end

function CCommSceneTimeCounter:GetTime(nTarTimeStamp)
  if self:GetStatus() == COUNTER_STATUS.INIT then
    return 0
  else
    return (self.m_nPauseTime or nTarTimeStamp or self.m_nStopTime or self.m_oBehavior:get_fight_time()) - self.m_nStartTime + self.m_nCacheTime
  end
end

CCommCounterMngr = Class("CCommCounterMngr")

function CCommCounterMngr:init(oBehavior)
  self.m_oBehavior = oBehavior
  self.m_mTimerCounter = {}
  self.m_mNormalCounter = {}
end

function CCommCounterMngr:AddTimeCounter(sKey, nDuration, type)
  local oCounter = CCommSceneTimeCounter:New(sKey, nDuration, type, self.m_oBehavior)
  self.m_mTimerCounter[sKey] = oCounter
end

function CCommCounterMngr:AddNormalCounter(sKey, nMaxCnt, type)
  local oCounter = CCommSceneCounter:New(sKey, nMaxCnt, type, self.m_oBehavior)
  self.m_mNormalCounter[sKey] = oCounter
end

function CCommCounterMngr:GetTimeCounter(sKey)
  return self.m_mTimerCounter[sKey]
end

function CCommCounterMngr:GetNormalCounter(sKey)
  return self.m_mNormalCounter[sKey]
end
