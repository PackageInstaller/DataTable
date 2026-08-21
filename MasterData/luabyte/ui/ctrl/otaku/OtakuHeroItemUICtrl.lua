local OtakuHeroItemUICtrl = BaseClass("OtakuHeroItemUICtrl")
local M = OtakuHeroItemUICtrl

function M:__init(view, pos)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
    self._view.leave.transform:onClick(Bind(self, self._OnClickMinus))
    self._pos = pos
    self._onClickFunc = nil
    self._OnClickMinus = nil
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:_OnClickMinus(go)
    if self._OnClickMinus then
        self._OnClickMinus(self._data.Position)
    end
end

function M:_ClickItem(go)
    if self._state == OtakuHeroDeloyState.Normal or self._state == OtakuHeroDeloyState.Plus then
        if self._onClickFunc then
            self._onClickFunc(self._curHeroId)
        end
    end

    if self._state == OtakuHeroDeloyState.Lock then
        local str = ConfigHelper.GetLocalString(544)
        GameHelper.Tips(string.format(str, self._lockLevel))
    end
end

function M:SetClickCallback(onClickFunc)
    self._onClickFunc = onClickFunc
end

function M:SetMinusClickCallback(onClickFunc)
    self._OnClickMinus = onClickFunc
end

function M:SetItem(data, state, lockLevel)
    self._state = state
    self._data = data
    self._curHeroId = 0

    if state == OtakuHeroDeloyState.Lock then
        self._lockLevel = lockLevel
    end

    self._view.Normal:SetActive(state == OtakuHeroDeloyState.Normal)
    self._view.Plus:SetActive(state == OtakuHeroDeloyState.Plus)
    self._view.Lock:SetActive(state == OtakuHeroDeloyState.Lock)

    if state == OtakuHeroDeloyState.Normal then
        local eater = data:GetEater()
        self._curHeroId = data.HeroId
        self._view.Icon:SetAvatarIcon(data.HeroId, 1)
        self._view.valueLabel:SetText(eater .. "/" .. data.maxEater)
        self._view.valueSlider:SetValue(eater / data.maxEater)
        self._view.work.gameObject:SetActive(eater ~= 0)
        self._view.hunger.gameObject:SetActive(eater == 0)
        self._view.name:SetAvatarName(data.HeroId, RoleType.ERT_Hero)
    end
end

function M:Enable(v)
    self._view:SetActive(v)
end

return OtakuHeroItemUICtrl
