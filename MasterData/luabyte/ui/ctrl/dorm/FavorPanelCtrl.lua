local FavorPanelCtrl = BaseClass("FavorPanelCtrl")
local M = FavorPanelCtrl

--用于让工具检测出来
local imgUrlFormat = {
    "UI/SpritePics/dormitory/ui_dormitory_text_00",
    "UI/SpritePics/dormitory/ui_dormitory_text_01",
    "UI/SpritePics/dormitory/ui_dormitory_text_02",
    "UI/SpritePics/dormitory/ui_dormitory_text_03",
    "UI/SpritePics/dormitory/ui_dormitory_text_04",
    "UI/SpritePics/dormitory/ui_dormitory_text_05",
    "UI/SpritePics/dormitory/ui_dormitory_text_06",
    "UI/SpritePics/dormitory/ui_dormitory_text_07",
    "UI/SpritePics/dormitory/ui_dormitory_text_08",
    "UI/SpritePics/dormitory/ui_dormitory_text_09",
    "UI/SpritePics/dormitory/ui_dormitory_text_plus",
}

function M:__init(view)
    self._view = view
    self._view.Button.transform:onClick(Bind(self, self._OnClickBtn))
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.imgUrl = "UI/SpritePics/dormitory/ui_dormitory_text_0"
    self.DormFavorEventHandle = Bind(self, self.DormFavorEvent)
    IGameEventMgr:RegisterEventHandleByTypeName("DormFavorEvent", self.DormFavorEventHandle)
end

function M:UpdateData(heroId, favorLevel, curFavor, nextFavor, stage)
    if heroId == 0 then
        return
    end

    self.heroId = heroId
    local favorLevel = favorLevel
    local curFavor = curFavor
    local nextFavor = nextFavor
    local stage = stage
    self._view.favorLevel:SetText(tostring(favorLevel))
    self._view.favorProgress:SetText("<size=30>" .. curFavor .. "</size>/" .. nextFavor)

    for i = 1, 4 do
        self._view["Star" .. i]:SetActive(i <= stage)
    end


    if stage == 1 then
        self._view.Name:SetText(560)
    end

    if stage == 2 then
        self._view.Name:SetText(561)
    end

    if stage == 3 then
        self._view.Name:SetText(562)
    end

    if stage == 4 then
        self._view.Name:SetText(563)
    end

    self:CheckFavorUp(favorLevel)
end

function M:CheckFavorUp(curLevel)
    local favorUp, level = OtakuHelper.CheckFavorUp(self.heroId, curLevel)

    if favorUp == true then
        UIContextMgr:GetInstance():Show("FavorUpUI", self.heroId, level, curLevel)
    end
end

--点击按钮打开好感度界面
function M:_OnClickBtn(go)
    if self.dormAction.state == DormConst.RoleState.Gift or self.dormAction.state == DormConst.RoleState.Interact then
        return
    end
    UIContextMgr:GetInstance():Close("Dorm")
    UIContextMgr:GetInstance():Show("FavorContentPanel", self.heroId)
end

function M:DormFavorEvent(handler)
    self:UpValue(handler.value)
end

--好感度飘字
function M:UpValue(num)
    local value = tostring(num)
    local len = string.len(value)
    if len == 1 then
        self._view.UpValueState:SetState(1)
        self._view.UpValue1:SetPic(self.imgUrl..value)
    end

    if len == 2 then
        self._view.UpValueState:SetState(2)
        self._view.UpValue1:SetPic(self.imgUrl..string.sub(value,2,2))
        self._view.UpValue2:SetPic(self.imgUrl..string.sub(value,1,1))
    end

    if len == 3 then
        self._view.UpValueState:SetState(3)
        self._view.UpValue3:SetPic(self.imgUrl..string.sub(value,1,1))
        self._view.UpValue2:SetPic(self.imgUrl..string.sub(value,2,2))
        self._view.UpValue1:SetPic(self.imgUrl..string.sub(value,3,3))
    end
    self._view.UpValueAnimator:AnimatorPlay("FavorValueEff")
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormFavorEvent", self.DormFavorEventHandle)
    self.dormAction = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return FavorPanelCtrl
