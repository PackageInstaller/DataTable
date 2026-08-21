local OtakuOverviewInfoCtrl = BaseClass("OtakuOverviewInfoCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuOverviewInfoCtrl


function M:OpenPanel()
    local count = OtakuRoomDataMgr:GetInstance():GetUnlockLiveSpaceNum()
    local curCount = OtakuRoomDataMgr:GetInstance():GetAllLiveSpaceHeroUp()
    self._view.numText:SetText(tostring(curCount))
    self._view.maxText:SetText(tostring(count))
end

function M:Update(roomId, type, liveSpace)
    self.m_RoomId = roomId
    for i,v in ipairs(self.m_Skills) do
        v:SetActive(false)
    end

    for i,v in ipairs(self.m_Items) do
        v:SetActive(false)
    end

    self.m_SkillIndex = 0 
    for i,v in ipairs(liveSpace) do
        local item =  self.m_Items[i]

        if not item then
            item = self._view.heroItem:Instantiate()
            self.m_Items[#self.m_Items + 1] = item
        end

        item:SetActive(true)
        self:_SetHero(item, v, type)
    end
end

function M:Refresh(roomId, type, liveSpace)
    if self.m_RoomId ~= roomId then
        return
    end

    self:Update(roomId, type, liveSpace)
end

function M:_SetHero(item, data, type)
    local state = data:State()

    if state == OtakuType.DeployState.Lock then
        item.state:SetState(1)
        return
    end

    if state == OtakuType.DeployState.Normal then
        item.state:SetState(2)
        return
    end

    local maxSatiety = OtakuHelper.MaxSatiety(data:HeroId())
    local heroData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(data:HeroId())
    local eater = heroData:GetEater()
    item.numText:SetText(tostring(eater))
    item.maxText:SetText(tostring(maxSatiety))
    item.nameText:SetAvatarName(data:HeroId(), 1)

    local satietyRatio = eater / maxSatiety
    satietyRatio = satietyRatio > 1 and 1 or satietyRatio
    satietyRatio = MathUtil.GetPreciseDecimal(satietyRatio, 2)
    if satietyRatio < 0.2 then
        item.state:SetState(3)
    else
        item.state:SetState(4) 
    end

    self:_SetSkill(type, data)
end

function M:_SetSkill(type, data)
    local heroData = IHeroDataMgr:GetMyHeroDataById(data:HeroId())
    local powerIds = heroData:GetPowerIds()
    local count = powerIds.Length
    for i=0, count-1 do
        local power = powerIds[i]
        local powerCfg = ConfigHelper.GetCfg("power", power)

        if powerCfg.label == type and power ~= 1 and power ~= 2 then
            self.m_SkillIndex  = self.m_SkillIndex  + 1
            self:_SetSkillItem(self.m_SkillIndex, data:HeroId(), powerCfg.powerName, powerCfg.powerDes)
        end
    end
end

function M:_SetSkillItem(index, heroId, name, desc)
    local item =  self.m_Skills[index]

    if not item then
        item = self._view.skillItem:Instantiate()
        self.m_Skills[#self.m_Skills + 1] = item
    end

    item:SetActive(true)
    item.headImg:SetAvatarIcon(heroId, 1)
    item.nameText:SetText(name)
    item.descText:SetText(desc)
end

function M:Init()
    self.m_Items = {}
    self.m_Skills = {}
    self._view.heroItem:SetActive(false)
    self._view.skillItem:SetActive(false)
    self:ShowPanel()
end

function M:OnDispose()
    for i,v in ipairs(self.m_Items) do
        v:OnDispose()
    end
    M.super.OnDispose(self)
end


return OtakuOverviewInfoCtrl
