DormRoleActionTookUp2 = oo.class(DormRoleActionBase)

local this = DormRoleActionTookUp2

function this:Enter()
    Input, GetMouseButton, GetMouseButtonDown, GetMouseButtonUp, Physics = UIUtil:GetFuncs()

    -- 播放抓起动画
    self.dormRole.dormRoleStateMachine:PlayByActionType("click_grab")
    -- 抓起状态
    self.dormRole.SetTookUp(true)

    --self.dormRole.tool:AddBubble("", self.dormRole.data:GetID(), 0)

    -- 位置
    self.pos = self.dormRole.transform.position
    self.perPos = self.pos
    -- 落地动画
    self.isEndIng = false
    self.restoreTime = 0.15

    -- 相机禁止滑动(如果不禁止，需要同时调整Camera和Camera2的fov)
    DormMgr:SetSceneCameraAction(false)
    self.isEnter = true
end

function this:Update()
    if (not self.isEnter) then
        return
    end
    if (self.isEndIng) then
        self.restoreTime = self.restoreTime - Time.deltaTime
        local y = self.restoreTime / 0.15 * 2
        self.dormRole.SetDrop(y)
        if (self.restoreTime <= -0.3) then
            self:OnComplete()
        end
    else
        if (GetMouseButton(0)) then
            self.pos = Input.mousePosition
            if (self.pos ~= self.perPos) then
                self.perPos = self.pos
                local ray = self.dormRole.tool:SceneCamera():ScreenPointToRay(self.pos)
                local hits = Physics.RaycastAll(ray, 1000, 1 << DormLayer.ground)
                if (hits and hits.Length > 0) then -- 需要修改groud层级和添加碰撞体
                    local hit = hits[0]
                    self.dormRole.SetTookUpPos({
                        x = hit.point.x,
                        y = 0,
                        z = hit.point.z
                    })
                end
            end
        end
        if (GetMouseButtonUp(0)) then
            self.dormRole.dormRoleStateMachine:ExitActionByType("grab") -- 落地动画
            self.dormRole.SetTookUp(false)
            self.isEndIng = true
        end
    end
end

function this:OnComplete()
    self.isEnter = false
    DormMgr:SetSceneCameraAction(true)
    if (not self.dormRole.CheckIsIn()) then
        local action, dormAction2 = Dorm_GetActionType("click_grab", self.dormRole)
        self.dormRole.ChangeAction(action, dormAction2)
    end
end

return this
