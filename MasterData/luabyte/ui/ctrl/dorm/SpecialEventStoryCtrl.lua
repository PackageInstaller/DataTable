local SpecialEventStoryCtrl = BaseClass("SpecialEventStoryCtrl", BaseUICtrl)
local M = SpecialEventStoryCtrl

function M:Init()
    self.powerItems = {}
    for i = 1, 2 do
        local itemCtrl = require("UI.Ctrl.Dorm.PowerItemCtrl").New(self._view["PowerItem" .. i])
        self.powerItems[i] = itemCtrl
    end

    self.nextStepId = 0
    self.curStepId = 0
    self.speaker = 0
    self.isLockStory = false
    self.skip = nil
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.curFuritureData = DormHelper.GetCurrentFurnitureData()
    self._view.Raycast.transform:onClick(Bind(self, self._OnClickNext))
    self._view.BtnSkip.transform:onClick(Bind(self, self._OnClickSkip)) 
    self._roomStorySelectCallback = EventMgr:AddListener(UIMessageNames.FAVOR_SELECT_ROOM_STORY,
        Bind(self, self._OnSelectRoomStory))
end

function M:OnEnter(heroId, type, groupId, closeCallback)
    self.stroyList = OtakuHelper.GetFavorStoryByGroupId(groupId)
    self.heroId = heroId
    self.type = type
    self.roomStoryId = groupId
    self.closeCallback = closeCallback

    if self.stroyList then
        self.UIType = self.stroyList[1].ui
        if self.UIType == DormConst.SpecialEventUIType.Normal then
            self._view.Root1.transform:SetActive(true)
            self.dialogText = self._view.txt_dialog1
        end

        if self.UIType == DormConst.SpecialEventUIType.Single then
            self._view.Root2.transform:SetActive(true)
            self.dialogText = self._view.txt_dialog2
        end
        self:SetStroy(self.stroyList[1])
    end
end

--设置剧情
function M:SetStroy(data)
    self.nextStepId = data.nextStepId[1]
    self.curStedpId = data.stepId
    self.curData = data
    if data.skipWords == 1 then
        self._view.BtnSkip:SetActive(true)
    else
        self._view.BtnSkip:SetActive(false)
    end
    --npc说话
    if data.speaker == 0 then
        self._view.TalkPanel:SetActive(true)
        --接入少女动作接口
        DormHelper.PlayActionById(self.curFuritureData, data.action)
        self.speaker = data.speaker
        self._view.txt_name:SetAvatarName(data.heroId, RoleType.ERT_Hero)
        local dialog = ConfigHelper.GetLocalStringByPlayerName(data.words[1])
        self:SetText(dialog)
        self.skip = data.skip[1]
        if self.type == DormConst.StoryType.InteractRewardStory and (#self.curData.favor > 0 or #self.curData.reward > 0) then
            self.rewardStepId = self.curStedpId
            self.selectIndex = 0
        end
    end

    --玩家说话
    if data.speaker == 1 then
        --玩家选项
        if #data.words > 1 then
            self.speaker = data.speaker
            self._view.CommandPanel:SetActive(true)
            for i = 1, 2 do
                self.powerItems[i]:UpdateItem(data.words[i], data.nextStepId[i], i, self.type, data.skip[i])
            end
            self.isLockStory = true
        else
            local txt = ConfigHelper.GetLocalString(5159)
            self._view.txt_name:SetText(txt)
            self.speaker = data.speaker
            local dialog = ConfigHelper.GetLocalStringByPlayerName(data.words[1])
            self:SetText(dialog)
            self.skip = data.skip[1]
        end
    end

    --旁白说话
    if data.speaker == 2 then
        local txt = ConfigHelper.GetLocalString(1317)
        self._view.txt_name:SetText(txt)
        self.speaker = data.speaker
        local dialog = ConfigHelper.GetLocalStringByPlayerName(data.words[1])
        self:SetText(dialog)
        self.skip = data.skip[1]
    end
end

function M:SetText(dialog)
    self.dialogText:SetDoTweenText(dialog)
end

--点击切换下一段对话
function M:_OnClickNext(go)
    if self.isLockStory == true then
        return
    end

    if self.dialogText.textDoFinish == false then
        self.dialogText:ClickNext2()
    else
        self:NextStep()
    end
end

--点击跳过
function M:_OnClickSkip(go)
    --获取剩余剧情列表
    local remainStory = {}
    for key, value in pairs(self.stroyList) do
        if key > self.curStedpId then
            table.insert(remainStory, value)
        end
    end
    table.sort(remainStory, function(a,b) return a.stepId < b.stepId end)
    self.nextStepId = 0
    for i = 1, #remainStory do
        if remainStory[i].skipWords == 2 then
            self.nextStepId = remainStory[i].stepId
        end
    end
    self:NextStep()
end

function M:_OnSelectRoomStory(nextStepId, skip, index)
    --关闭选择界面
    self._view.CommandPanel.gameObject:SetActive(false)
    self.isLockStory = false
    self.nextStepId = nextStepId
    self.skip = skip
    if self.type == DormConst.StoryType.InteractRewardStory and (#self.curData.favor > 0 or #self.curData.reward > 0) then
        self.rewardStepId = self.curStedpId
        self.selectIndex = index - 1
    end
    self:NextStep()
end

function M:NextStep()
    --没有下一步关闭界面
    if self.nextStepId == 0 then
        if self.type == DormConst.StoryType.InteractRewardStory then
            --互动表演奖励剧情领奖
            DormDataMgr:RequestLoveValueAward(self.heroId, 1, 0, self.roomStoryId, self.rewardStepId, self.selectIndex, Bind(self, self.LoveValueAwardCallBack))
            return
        end

        if self.type == DormConst.StoryType.SpecialEventStory then
            DormHelper.UnlockSpecialEvent()
        end
        if self.skip ~= nil then
            if self.skip == DormConst.SkipType.Gift then
                self.dormAction:RoleCommand(DormConst.DormRouletteType.Gift)
            end
        end

        self:Close()
    else
        --切换下一句对话
        self:SetStroy(self.stroyList[self.nextStepId])
    end
end

--互动表演奖励剧情领奖回调
function M:LoveValueAwardCallBack(msg)
    if  #msg.Awards > 0 then
        GameHelper.ShowGetItemsByItems(msg.Awards, Bind(self, self.Close))
    else
        self:Close()
    end
end

function M:OnClose()
    --结束剧情回调
    if self.closeCallback then
        self.closeCallback()
    end
end

function M:OnDispose()
    if self._roomStorySelectCallback then
        EventMgr:RemoveListener(UIMessageNames.FAVOR_SELECT_ROOM_STORY, self._roomStorySelectCallback)
    end
    self._roomStorySelectCallback = nil
    for _, ctrl in pairs(self.powerItems) do
        ctrl:OnDispose()
    end
    self.powerItems = {}
    self.nextStepId = 0
    self.curStepId = 0
    self.speaker = 0
    self.isLockStory = false
    self.skip = nil
    self.dormAction = nil
    self.curFuritureData = nil
    self.module = nil
    M.super.OnDispose(self)
end

return SpecialEventStoryCtrl
