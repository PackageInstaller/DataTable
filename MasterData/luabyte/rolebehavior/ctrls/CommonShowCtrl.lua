
local HitPointType = require "Config.HitPointTypeConst"
--通用的角色展示，含旋转、点击等功能
local CommonShowCtrl = BaseClass("CommonShowCtrl" ,require("RoleBehavior.BaseRoleBehaviorCtrl") )
local M = CommonShowCtrl
local rotateSpeed = 150
local CS_ShowGirl = CS.ShowGirl
local CS_GameHelper = CS.GameX.GameHelper
local eashTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local CS_Camera = CS.UnityEngine.Camera

function M:__init(showGril,heroId,behaviorTypeBorn,_behaviorTypeIdle,offsetIdx)
    self.transform = self._showGirl.transform 
    self.gameObject = self.transform.gameObject
    self._curHeroId = self._showGirl.heroId
    self._lastTime = 0 
    self._isDownValid = false 
    if offsetIdx == nil then 
        offsetIdx = 0 
    end
    self._showGirl:SetStandOffset(offsetIdx)
    self._operateTime = Time.realtimeSinceStartup
    self._behaviorTypeBorn = behaviorTypeBorn
    self._behaviorTypeIdle = _behaviorTypeIdle
    self._screenPointX = 0 
    self._canTouch = false
    self._randomTime = GameHelper.GetParamters(316)[0]
end

function M:_SetTouchInfo(isAdd)
    
    if isAdd then 
        self._onSwipeHandler = self._onSwipeHandler or Bind(self,self.OnSwipe)
        eashTouch.On_Swipe( '+', self._onSwipeHandler)
        self._onTouchUpHandler = self._onTouchUpHandler or Bind(self, self.OnTouchUp)
        eashTouch.On_TouchUp('+', self._onTouchUpHandler)
        self._onTouchDownHandler = self._onTouchDownHandler or Bind(self,self.OnTouchDown)
        eashTouch.On_TouchDown('+',self._onTouchDownHandler)
    else
        if self._onSwipeHandler then 
            eashTouch.On_Swipe( '-', self._onSwipeHandler)
        end
        if self._onTouchUpHandler then 
            eashTouch.On_TouchUp('-', self._onTouchUpHandler)
        end
        if self._onTouchDownHandler then 
            eashTouch.On_TouchDown('-', self._onTouchDownHandler)
        end
    end
end

function M:Hide()
    self:_SetTouchInfo(false)
    if IsNull(self._showGirl) then 
        return
    end
    self._showGirl:Hide()
    IRoleActionMgr:Stop(self._showGirl.m_JSkin.id)
    IRoleActionMgr:ResetState()
end

function M:Show(firstState, ...)
    self:Run(firstState,...)
    self._enterTime = Time.realtimeSinceStartup
    self:_SetTouchInfo(false)
    self:_SetTouchInfo(true)
    if not IsNull(self._showGirl) then 
        self._showGirl:Show()
    end
    self._screenPointX = nil 
end

function M:SetCanTouch(canTouch)
    self._canTouch = canTouch 
end

function M:GirlRotationBack()
    self._operateTime = Time.realtimeSinceStartup
    self._showGirl:GirlRotationBack(0.1)
end

function  M:InitState()
    -- body
    self:AddState(RoleStateName.Born,require("RoleBehavior.States.CommonShow.CommonShowBornState"),true)
    self:AddState(RoleStateName.Idle,require("RoleBehavior.States.CommonShow.CommonShowIdleState"))
    self:AddState(RoleStateName.TouchGirl, require("RoleBehavior.States.CommonShow.CommonShowTouchState"))
end

function M:GetLastOperateTime()
    return self._operateTime
end

function M:OnSwipe(gesture)
    if not IsNull(self._showGirl) then
        if not self._isDownValid then 
            return 
        end
        --出生3秒不要滑动
        -- if  Time.realtimeSinceStartup - self._enterTime < 3 then 
        --     return 
        -- end
        self._showGirl:OnDragGirl( gesture.deltaPosition.x, rotateSpeed);
        self._operateTime = Time.realtimeSinceStartup
    end
end

function M:OnTouchDown(gesture)
    if CS_GameHelper.bClickUI() or IsNull(CS_Camera.main) or IsNull(self._showGirl) then 
        return 
    end
    if self._screenPointX == nil then 
        local screenPoint = CS_Camera.main:WorldToScreenPoint(self._showGirl.transform.position)
        self._screenPointX = screenPoint.x 
    end
    
    local screenX = gesture.position.x 
    if screenX < self._screenPointX - 300 or screenX > self._screenPointX + 300 then 
        return
    end

    self._isDownValid = true 
    self._operateTime = Time.realtimeSinceStartup
end

function M:OnTouchUp(gesture)
    if not self._isDownValid then 
        return 
    end
    self._operateTime = Time.realtimeSinceStartup
    self._isDownValid = false 
    if not self._canTouch then 
        return 
    end
    local mask = LayerMask.GetMask(PhysicsMgr.g_teamALayerName)
    local hit = PhysicsMgr.MouseClickRayCastHit(mask)
    if not IsNull(hit) and not IsNull(hit.collider) then
        if Time.realtimeSinceStartup - self._lastTime < 2 then
            return 
        end
        if CS_GameHelper.bClickUI() then 
            return 
        end
        local hitPointType = CS_ShowGirl.GetHitPointType( self._curHeroId, hit.collider.name)
        if hitPointType == nil or hitPointType == HitPointType.Invalid then 
            return 
        end
        self:ChangeState(RoleStateName.TouchGirl,hitPointType)
        self._lastTime = Time.realtimeSinceStartup
    end 
end

function M:DestorySelf()
    if not IsNull(self._showGirl) then 
        self._showGirl:DestorySelf()
    end
    self:OnDispose()
end

function M:OnDispose()
    self:_SetTouchInfo(false)
    M.super.OnDispose(self)
    self._showGirl = nil 
end


return M 
