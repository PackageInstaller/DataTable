local AwakeTaskItemCtrl = BaseClass("AwakeTaskItemCtrl", BaseUICtrl)
local M = AwakeTaskItemCtrl



function M:Refresh(index, curState, data, callback)
    self.m_Index = index
    self.m_Data = data
    self.m_CallBack = callback
    self.m_CurAnimation = ""

    self._view.state:SetState(curState)
    self._view.rewardState:SetState(data.state + 1)
    self._view.taskPreDes:SetText(data.preDes)
    self._view.taskDes:SetText(data.des)

    local itemGroup = ConfigHelper.GetCfg("itemGroup", data.reward)
    for i=1, 2 do
        local item = itemGroup.items[i]
        local num = itemGroup.cnts[i]
        local name = "reward" .. i

        if item then
            self._view[name]:SetInfo(item, ItemNumberType.TOTLE, num)
            self._view[name]:EnablePopItem(true)
        end

        self._view[name].transform:SetActive(item ~= nil)
    end
end


function M:_PlayAnimaiton()
    if self.m_IsPlaying then
        return
    end

    self.m_IsPlaying = true
    self.m_CurAnimation = (self.m_CurAnimation == "AwakeningUI_TextToImage") and "AwakeningUI_ImageToText" or "AwakeningUI_TextToImage"
    self._view.animator:Play(self.m_CurAnimation)

    self.m_AnimatorTimer = TimerManager:GetInstance():GetTimer(3, Bind(self, self._OnPlayAnimationCalBack), nil, true)
    self.m_AnimatorTimer:Start()
end


function M:__init(view)
    self._view = view
    self._view.rewardBtn:onClick(Bind(self, self._OnRewardClick))
    self._view.itemBtn:onClick(Bind(self, self._OnItemClick))
end


function M:_OnRewardClick()
    if self.m_Data.state == PassConst.TaskState.MissionComplete then
        self.m_CallBack(self.m_Data.id)
    elseif self.m_Data.state == PassConst.TaskState.Doing then
        GameHelper.Jump(self.m_Data.jumpId)
    end
end


function M:_OnItemClick()
    if self.m_Data.state == PassConst.TaskState.TaskComplete then
        self:_PlayAnimaiton()
    end
end


function M:_OnPlayAnimationCalBack()
    self.m_IsPlaying = false
end





return AwakeTaskItemCtrl
