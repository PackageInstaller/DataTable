local UIVotingItemCtrl = BaseClass("UIVotingItemCtrl")
local M = UIVotingItemCtrl
local StageState = EnumConst.StageState

function M:__init(view)
    self._view = view
end

function M:InitData(data)
    self.data = data
    self._view.TextTime:SetText(data.timer)
    self:InitState(data.state)
    self._view.imageNormal:onClick(Bind(self, self.OnBtnClick))
end

function M:InitState(state)
    if state == StageState.NotOpen then
        --未开启
        self._view.goLock1:SetActive(true)
        self._view.goLock2:SetActive(true)
        self._view.goEnd:SetActive(false)
        self._view.goTime:SetColor(255, 255, 255, 255)
        self._view.imageNormal:SetColor(255, 255, 255, 255)
        self._view.imageNormal.transform.localScale = Vector3.one
    elseif state == StageState.Doing then
        --进行中
        self._view.goLock1:SetActive(false)
        self._view.goLock2:SetActive(false)
        self._view.goEnd:SetActive(false)
        self._view.goTime:SetColor(255, 255, 255, 255)
        self._view.imageNormal:SetColor(255, 255, 255, 255)
        self._view.imageNormal.transform.localScale = Vector3(1.05, 1.05, 1)
    else
        --结束
        self._view.goLock1:SetActive(false)
        self._view.goLock2:SetActive(false)
        self._view.goEnd:SetActive(true)
        self._view.goTime:SetColor(0, 0, 0, 255)
        self._view.imageNormal:SetColor(0, 0, 0, 255)
        self._view.imageNormal.transform.localScale = Vector3(0.93, 0.93, 1)
    end
end

function M:OnBtnClick()
    if self.data.state == StageState.NotOpen then
        GameHelper.TipsById(844)
        return
    end

    if self.data.state == StageState.Over then
        GameHelper.TipsById(843)
        return
    end

    if self.data.state ~= StageState.Doing then
        return
    end

    EventMgr:Broadcast(UIMessageNames.VOTING_CLICKITEM, self.data.id)
end

function M:OnDispose()
    self._view.imageNormal:onClick(nil)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIVotingItemCtrl
