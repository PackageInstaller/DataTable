-- baoruichang
local UIAwakeBtnCtrl = BaseClass("UIAwakeConCtrl", UIBaseComponent)
local M = UIAwakeBtnCtrl
local EQuality = EnumConst.EQuality
local NumPicPath = EnumConst.NumPicPath
local tIndexof = table.indexof
local JBattleLevel = CS.GameBase.JBattleLevel

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self._OnBtnClick))
end

function M:UpdateData(data)
    self._data = data
    local heroAwake = data.heroAwake
    self._view.imgNum:SetPic(NumPicPath .. data.id)
    if tIndexof(heroAwake.effectType, 1) then
        self._view.tipsState:SetState(2)
    elseif tIndexof(heroAwake.effectType, 3) then
        self._view.tipsState:SetState(3)
        self._view.iconSkill:SetPic(heroAwake.icon)
    elseif tIndexof(heroAwake.effectType, 4) then
        self._view.tipsState:SetState(3)
        local heroId = heroAwake.heroId
        local lv = data.id
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        local skinId = heroData:GetSkinId()
        local battleLevel1s = JBattleLevel.GetHeroBattleByLv(skinId, 1)
        if battleLevel1s.Count <= 0 then
            Logger.LogError("错误")
            return
        end
        local battleLevel = battleLevel1s[0]
        local nextGrade = battleLevel.nextGrade[battleLevel.nextGrade.Length - 1]
        battleLevel1s = JBattleLevel.GetHeroBattleByGrade(skinId, nextGrade)
        if battleLevel1s.Count <= 0 then
            Logger.LogError("错误")
            return
        end
        battleLevel = battleLevel1s[0]
        self._view.iconSkill:SetPic(battleLevel.icon)
    else
        self._view.tipsState:SetState(1)
    end
    self._view.state:SetState(self._data.isOpen and 1 or 3)
end

function M:GetHeroAwake()
    if self._data then
        return self._data.heroAwake
    end
    return 0
end

function M:_OnBtnClick()
    if self._data.clickFunc then
        self._data.clickFunc(self._data.id)
    end
end

function M:SetSelectState(selectId)
    if selectId == self._data.id then
        self._view.state:SetState(2)
        return
    end
    if self._data.isOpen then
        self._view.state:SetState(1)
        return
    end
    self._view.state:SetState(3)
end

return UIAwakeBtnCtrl
