local RoleGeneUpTipsCtrl = BaseClass("RoleGeneUpTipsCtrl", BaseUICtrl)
local M = RoleGeneUpTipsCtrl

function M:Init()
    self._view.btnMask:onClick(Bind(self, self._OnClickClose))
    self._view.tipMask:onClick(Bind(self, self._OnClickClose))
end

function M:OnEnter(state, curEffects, nextEffects, icon)
    self._isPlay = false
    self._view.state:SetState(state)
    if state == 1 then
        self:_GeneUp(curEffects, nextEffects, icon)
    else
        -- curEffects = heroId, nextEffects = geneLineStar
        self:_SuitUp(curEffects, nextEffects)
    end
end

function M:_GeneUp(curEffects, nextEffects, icon)
    for i = 1, 5 do
        local name = "Attr" .. i
        self._view[name]:SetActive(false)
    end

    local index = 0
    for k, v in pairs(curEffects) do
        local name = "Attr" .. (index + 1)
        self._view[name]:Update(k, v, nextEffects[k])
        self._view[name]:SetActive(true)
        index = index + 1
    end

    self._view.icon:SetPic(icon)
end

function M:_SuitUp(heroId, geneLineStar)
    self._view.tipsPanel:OpenPanel(heroId)
    self._isPlay = true
    self._view.tipsPanel:PlayAnimation(geneLineStar, Bind(self, self._EndPlayAnimation))
end

function M:_EndPlayAnimation()
    self._isPlay = false
end

function M:_OnClickClose()
    if self._isPlay then
        return
    end

    self:Close()
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return RoleGeneUpTipsCtrl
