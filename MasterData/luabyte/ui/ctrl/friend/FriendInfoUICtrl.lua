local FriendInfoUICtrl = BaseClass("FriendInfoUICtrl", BaseUICtrl)
local M = FriendInfoUICtrl

function M:Init()
    self._view.deleteBtn:onClick(Bind(self, self._OnClickDelectFriend))
    self._view.copyBtn:onClick(Bind(self, self._OnClickCopeUID))
    self._view.backBtn:onClick(Bind(self, self._OnClickBack))
    self._view.inputField:onEndEdit(Bind(self, self._OnNameChange))
    self._view.btnAdd:SetOnClick(Bind(self, self._OnClickAddFriend))
end

function M:OnEnter(data, index)
    self._index = index
    self._friendData = data
    self:_Show()
    self:_SetHeroItem()
end

function M:_Show()
    local missionpre = ConfigHelper.GetCfgPropByLua("mission", self._friendData.DetailData.MissionId, "chapterLabel") or ConfigHelper.GetLocalString(4177)
    local elite = ConfigHelper.GetCfgPropByLua("mission", self._friendData.DetailData.EliteId, "chapterLabel") or ConfigHelper.GetLocalString(4178)
    local heroId = FriendHelper.GetShowGirlId(self._friendData.BaseData.Avatar)
    local playerIconPath = FriendHelper.GetPlayerIcon(self._friendData.BaseData.PlayerIconId)
    -- 字符串去除富文本中的颜色
    local missionStr1 = string.split(missionpre, ">")
    local missionStr2 = ""
    if #missionStr1 > 1 then
        missionStr1 = missionStr1[2]
        missionStr2 = string.split(missionStr1, "<")
    else
        missionStr2 = missionStr1
    end

    local eliteStr1 = string.split(elite, ">")
    local eliteStr2 = ""
    if #eliteStr1 > 1 then
        eliteStr1 = eliteStr1[2]
        eliteStr2 = string.split(eliteStr1, "<")
    else
        eliteStr2 = eliteStr1
    end
    
    self._view.mainText:SetText(missionStr2[1])
    self._view.aceText:SetText(eliteStr2[1])
    self._view.uidText:SetText(tostring(self._friendData.FriendId))
    self._view.levelText:SetText(tostring(self._friendData.BaseData.Level))
    self._view.roleIcon:SetHeroDrawing(heroId, 1)
    --self._view.headIcon:SetAvatarIcon(heroId, RoleType.ERT_Hero)
    self._view.headIcon:SetPic(playerIconPath)
    
    self._view.reward:Show(self._friendData.FriendId, self._friendData.DetailData.Achievements, self._friendData.DetailData.AchievementsFinishedCount)
    
    local nameStr = string.format("(%s)", self._friendData.BaseData.Nickname)
    local remarkStr = ""
    if  self._friendData.BaseData.Remark ~= nil and self._friendData.BaseData.Remark ~= "" then
        --remarkStr = string.format("(%s)", self._friendData.BaseData.Remark)
        remarkStr = self._friendData.BaseData.Remark
    end

    self._view.playerNameText:SetText(self._friendData.BaseData.Nickname)
    self._view.inputField:SetText(remarkStr)
    self._view.inputField.unity_uiinput.characterLimit = ConfigHelper.GetSystemParam(313)
    --self._view.remarkText:SetText(remarkStr)

    -- if self._friendData.BaseData.Remark == nil or self._friendData.BaseData.Remark == "" then
    --     self._view.nameText:SetText(self._friendData.BaseData.Nickname)
    --     self._view.inputField:SetText(self._friendData.BaseData.Nickname)
    --     self._view.remarkText:SetText("")
    -- else
    --     local nameStr = string.format("(%s)", self._friendData.BaseData.Nickname)
    --     self._view.nameText:SetText(self._friendData.BaseData.Remark)
    --     self._view.inputField:SetText(self._friendData.BaseData.Remark)
    --     self._view.remarkText:SetText(nameStr)
    -- end
    
    --非好友助战禁止修改
    if self._index == -1 and not self._friendData.isFriends then
        self._view.inputField:SetActive(false)
        -- local nameStr = string.format("(%s)", self._friendData.BaseData.Nickname)
        -- self._view.remarkText:SetText(nameStr)
        self._view.stateFri:SetState(2)
    else
        self._view.inputField:SetActive(true)
        self._view.stateFri:SetState(1)
    end
end

function M:_SetHeroItem()
    local data = self._friendData.DetailData.HeroList
    
    for i = 1, 5 do
        local heroId = data[i] == nil and 0 or data[i].HeroId
        local name = string.format("heroItem%s", i)
        
        if heroId ~= 0 then
            if data[i].Skin>0 then
                local skinId = GameHelper.HeroId2SkinId(heroId, data[i].Skin)
                self._view[name]:SetSkinId(skinId, data[i].Level)
            elseif  GameHelper.HaveHeroAwakeSkin(heroId,data[i].AwakeLevel) then
                self._view[name]:SetAwakeId(heroId,data[i].Level)
            else
                self._view[name]:SetHeroId(heroId, data[i].Level)
            end
        end
        
        self._view[name].transform:SetActive(heroId ~= 0)
    end
end

function M:_OnClickDelectFriend()
    GameHelper.Confirm(string.format(ConfigHelper.GetLocalString(5155), self._friendData.BaseData.Nickname), Bind(self, self._OnDelectCallBack))
end

function M:_OnClickAddFriend()
    --添加好友
    FriendDataMgr:GetInstance():SendRequestAddFriendShip(self._friendData.FriendId, Bind(self, self.OnCallBack))
end

function M:OnCallBack(a, b, c)
    GameHelper.Tips("申请添加好友成功")
end

function M:_OnDelectCallBack(isYes)
    if not isYes then
        return 
    end
    
    FriendDataMgr:GetInstance():SendRequsetRemoveFriendData(self._friendData.FriendId)
    self:_OnClickBack()
end

function M:_OnClickCopeUID()
    GameHelper.CopyToClipboard(self._friendData.FriendId)
end

function M:_OnNameChange(name)
    if not name or #name <= 0 then
        --GameHelper.TipsById(4179)
        self._remarkName = self._remarkName == nil and "" or self._remarkName
        --local remarkNameStr = string.format("(%s)", self._remarkName)
        self._remarkName= name
        FriendDataMgr:GetInstance():SendRequsetRemark(self._friendData.FriendId, name, Bind(self, self._OnRemarkCallBack))
        return 
    end
    if ConfigHelper.CheckBlockWord(name) then
        GameHelper.TipsById(666)
        return 
    end
    
    self._remarkName= name
    FriendDataMgr:GetInstance():SendRequsetRemark(self._friendData.FriendId, name, Bind(self, self._OnRemarkCallBack))
end

function M:_OnRemarkCallBack()
    self._remarkName = self._remarkName == nil and "" or self._remarkName

    if self._remarkName == nil or self._remarkName =="" then
        self._view.inputField:SetText("")
    else
        --local remarkNameStr = string.format("(%s)",self._remarkName)
        self._view.inputField:SetText(self._remarkName)
    end

    self._view.playerNameText:SetText(self._friendData.BaseData.Nickname)
    EventMgr:Broadcast(UIMessageNames.FRIEND_DATA_UPDATE, self._index, self._remarkName)
end

function M:_OnClickBack()
    self:Close()
end


function M:OnDispose()
    self._view.btnAdd:RemoveOnClick()
    M.super.OnDispose(self)
end

--设置退出时调用，返回TRUE则为拦截底层逻辑
function M:OnDeviceBack()
    self:Close()
    return true
end


return FriendInfoUICtrl
