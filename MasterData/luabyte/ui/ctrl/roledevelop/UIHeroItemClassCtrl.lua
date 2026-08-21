local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIHeroItemClassCtrl = BaseClass("UIHeroItemCtrl", CircularScrollViewItem)
local M = UIHeroItemClassCtrl
local HeroRedPointType = EnumConst.HeroRedPointType

function M:Init()
    self._TempOnClickHero = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_CLICKHERO, Bind(self, self.OnClickHero))
    self._itemData = {}
    self._itemData.clickFunc = Bind(self, self._OnClick)
end

function M:RefrehItem()
    if not self.data then
        return
    end
    self:SetRedPoint()
end

function M:UpdateItem(data)
    self.data = data
    if data == nil then
        return
    end
    self._heroId = data.heroId
    self._skinId = data.skinId
    self._selectIndex = data.selectIndex
    self._itemData.heroId = data.heroId
    self._view.HeroItem:UpdateItem(self._itemData)
    self._heroConf = ConfigHelper.GetCfgByLua("hero", self._heroId)
    self:SetRedPoint()
    if self._view.Quality then
        self._view.Quality:SetPic(self.qualityBg .. self._heroConf.rare)
        self._view.Quality:SetActive(true)
    end
    self._view.UIState:SetState(self.data.selectIndex == self._heroId and 2 or 1)
    self._view.imgProfession:SetProfessional(self._heroId)
end

function M:SetRedPoint()
    -- 配置红点参数
    if not self._view.RedPoint then
        return
    end
    if self.data.redType == HeroRedPointType.RoleAction then--看板娘红点
        return
    end
    if self.data.redType == HeroRedPointType.DevelopMain then
        self._view.RedPoint:SetParam(0, self._heroId) --核心强化
        self._view.RedPoint:SetParam(1, self._heroId) --人设
        self._view.RedPoint:SetParam(2, self._heroId) --新战员
        self._view.RedPoint:SetParam(3, self._heroId) --突破红点
        self._view.RedPoint:SetParam(4, self._heroId) --基因首次激活红点
        self._view.RedPoint:SetParam(5, self._heroId) --跃迁红点
        self._view.RedPoint:SetParam(6, self._heroId) --基因光环红点
    elseif self.data.redType == HeroRedPointType.DevelopToggle then
        self._view.RedPoint:SetParam(0, self._heroId) --核心强化
        self._view.RedPoint:SetParam(1, -1) --人设
        self._view.RedPoint:SetParam(2, self._heroId) --新战员
        self._view.RedPoint:SetParam(3, self._heroId) --突破红点
        self._view.RedPoint:SetParam(4, self._heroId) --基因首次激活红点
        self._view.RedPoint:SetParam(5, self._heroId) --跃迁红点
        self._view.RedPoint:SetParam(6, self._heroId) --基因光环红点
    elseif self.data.redType == HeroRedPointType.DevelopData then
        self._view.RedPoint:SetParam(0, -1) --核心强化
        self._view.RedPoint:SetParam(1, self._heroId) --人设
        self._view.RedPoint:SetParam(2, self._heroId) --新战员
        self._view.RedPoint:SetParam(3, -1) --突破红点
        self._view.RedPoint:SetParam(4, -1) --基因首次激活红点
        self._view.RedPoint:SetParam(5, -1) --跃迁红点
        self._view.RedPoint:SetParam(6, -1) --基因光环红点
    end
    self._view.RedPoint:Check()
end

function M:_OnClick()
    --加载英雄过程中不允许切换
    local model = ModuleMgr:GetInstance():GetCurrentModule()
    if model.IsLoadHero and model:IsLoadHero() then
        return
    end
    EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_CLICKHERO, self._heroId)
end

function M:OnClickHero(heroId)
    self._view.UIState:SetState(heroId == self._heroId and 2 or 1)
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_CLICKHERO, self._TempOnClickHero)
    M.super.OnDispose(self)
end

return UIHeroItemClassCtrl
