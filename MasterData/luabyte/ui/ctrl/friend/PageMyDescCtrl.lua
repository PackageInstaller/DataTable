local PageMyDescCtrl = BaseClass("PageMyDescCtrl", BaseUICtrl)
local M = PageMyDescCtrl


function M:Hide()
    self._view:SetActive(false)
end

function M:OpenPanel()
    local missionpre = ConfigHelper.GetCfgPropByLua("mission", IPlayerData.missionId, "chapterLabel") or "0"
    local heroId = FriendHelper.GetShowGirlId(IPlayerData.pictureId)
    local curHeadIcon = IPlayerData.headIcon
    local heros = IHeroDataMgr:GetHeros()
    local nowData = GameHelper.GetDateTime(IPlayerData.creatTick)
    local time = string.format("%04d-%02d-%02d", nowData.Year, nowData.Month, nowData.Day)

    -- 字符串去除富文本中的颜色
    local missionStr1 = string.split(missionpre, ">")
    local missionStr2 = ""
    if #missionStr1 > 1 then
        missionStr1 = missionStr1[2]
        missionStr2 = string.split(missionStr1, "<")
    else
        missionStr2 = missionStr1
    end

    self:_RefreshAchievementBox()
    self._view.mimssionText:SetText(missionStr2[1])
    self._view.uidText:SetText(tostring(INetPack.accountId))
    self._view.nameText:SetText(IPlayerData.NickName)
    self._view.levelText:SetText(tostring(IPlayerData.level))
    self._view.numText:SetText(time)
    self._view.heroNumText:SetText(tostring(heros.Count))
    self:UpdateHeroDrawing(heroId)
    self:UpdateHeadIcon(curHeadIcon)
    self._view:SetActive(true)
end

function M:UpdateHeroDrawing(heroId)
    local curHeroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    local fationId = curHeroData:GetFashion()
    local awakeShow = curHeroData:isAwakeShow()
    if  fationId>0 then
        self._view.roleFashionIcon:SetActive(false)
        self._view.roleIcon:SetActive(true)
        self._view.roleIcon:SetHeroDrawing(heroId)
    else
        if awakeShow then
            self._view.roleFashionIcon:SetActive(true)
            self._view.roleIcon:SetActive(false)
            self._view.roleFashionIcon:SetHeroDrawing(heroId)
        else
            self._view.roleFashionIcon:SetActive(false)
            self._view.roleIcon:SetActive(true)
            self._view.roleIcon:SetHeroDrawing(heroId)
        end
    end
end

function M:UpdateHeadIcon(headIcon)
    local cfg = ConfigHelper.GetCfgByLua("headIcon", headIcon)
    self._view.headIcon:SetPic(cfg.icon)
end

function M:_RefreshAchievementBox()
    local data = AchievementDataMgr:GetInstance():AchievementInfoData()
    local num = AchievementDataMgr:GetInstance():DoneNum()
    self._view.reward:Show(0, data, num)
end

function M:__init(view)
    self._view = view
    self._view.copyBtn.transform:onClick(Bind(self, self._OnClickCopy))
    self._view.PlayerHead:onClick(Bind(self, self._OnClickHead))
end

function M:_OnClickCopy()
    GameHelper.CopyToClipboard(INetPack.accountId)
end

function M:_OnClickHead()
    UIContextMgr:GetInstance():Show("HeadIconChange", Bind(self, self.UpdateHeadIcon))
end

return PageMyDescCtrl
