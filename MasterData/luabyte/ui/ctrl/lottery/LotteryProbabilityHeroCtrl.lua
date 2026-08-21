local LotteryProbabilityHeroCtrl = BaseClass("LotteryProbabilityHeroCtrl",UIBaseComponent)
local M = LotteryProbabilityHeroCtrl


function M:Init(quality,probability,upHeroIds,normalHeroIds)
    self._view.title:Init(quality,probability)
    local upNumber = 0
    local normalHeroNumber = 0
    local upView = {}
    local normalView = {}
    if  upHeroIds ~= nil then
        upNumber = #upHeroIds
        for i = 1, #upHeroIds do
            local obj = self._view.upPrefab:Instantiate()
            obj.transform:SetParent(self._view.upPrefab.transform.parent)
            obj.transform.localScale = self._view.upPrefab.transform.localScale;
            obj.transform.localPosition = self._view.upPrefab.transform.localPosition;
            local data = IHeroDataMgr:GetHeroDataById(upHeroIds[i])
            local continue = true;
            if data == nil then
                obj:SetActive(false)
                continue = false
            end

            if continue then
                obj:SetHeroId(upHeroIds[i],1,1)
                obj:GetImage():onClickAction(function() 
                    IUIContextMgr:Show("RoleInformationUI",  {upHeroIds[i] }, 1, 2,quality<3)
                end)
                obj:SetActive(true);
            end
            table.insert(upView,obj)
        end
    end

    if  normalHeroIds ~= nil then
        normalHeroNumber = #normalHeroIds
        for i = 1 ,#normalHeroIds do
            local obj = self._view.normalPrefab:Instantiate()
            obj.transform:SetParent(self._view.normalPrefab.transform.parent)
            obj.transform.localScale = self._view.normalPrefab.transform.localScale;
            obj.transform.localPosition = self._view.normalPrefab.transform.localPosition;
            local data = IHeroDataMgr:GetHeroDataById(normalHeroIds[i])
            local continue = true;
            if data == nil then
                obj:SetActive(false)
                continue = false
            end

            if continue then
                obj:SetHeroId(normalHeroIds[i],1,1)
                obj:GetImage():onClickAction(function() 
                    IUIContextMgr:Show("RoleInformationUI",  {normalHeroIds[i] }, 1, 2,quality<3)
                end)
                obj:SetActive(true);
            end
            table.insert(normalView,obj)
        end
    end

    --格式化
    local defaultWidth = self._view.upScroll:GetRectSizeDelta().x
    local defaultNormalWidth = self._view.normalScroll:GetRectSizeDelta().x
    local upX = (defaultWidth/4) * upNumber
    local normalX = (defaultWidth+defaultNormalWidth)-upX
    self._view.upScroll:GetRectTransform():SetRectSizeDeltaX(upX)
    self._view.normalScroll:GetRectTransform():SetRectSizeDeltaX(normalX)

    --是否可以滑动
    --local lastView = normalView[#normalView]


    self._view.normalScroll:SetEnable((upNumber + normalHeroNumber) > 9)
    self._view.normalScroll:SetHorizontal((upNumber + normalHeroNumber) > 9)
    

    self._view:SetActive(true)
end


return LotteryProbabilityHeroCtrl
