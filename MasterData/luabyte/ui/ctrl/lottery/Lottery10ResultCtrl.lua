---10连抽结果显示界面
local Lottery10ResultCtrl = BaseClass("Lottery10ResultCtrl",BaseUICtrl)
local M = Lottery10ResultCtrl


function M:Init()
    self._view.tsBtn_once.onClick = function(go)
        if self._onCloseCallback then 
            self._onCloseCallback(false)
        end
        self:_OnClickOnce(go)
    end
    self._view.tsBtn_ten.onClick = function(go)
        if self._onCloseCallback then 
            self._onCloseCallback(false)
        end
        
        self:_OnClickTen(go)
    end
    self._view.trans_bg:onClick( function(go)
        if self._onCloseCallback then 
            self._onCloseCallback(true)
        end
        -- self:Close()
    end)
    self._propertyBar1 = UIUtil.FindComponent(self._view.trans_consume1 , typeof(CS.GameX.PropertyBar) )
    self._propertyBar2 = UIUtil.FindComponent(self._view.trans_consume2 , typeof(CS.GameX.PropertyBar) )
    self._items = {}
    self._itemLength = 0 
    self._lottoCfg = nil 
    self._onCloseCallback = nil 
    self._showNextLotto = false 
end

function M:OnEnter( heros,lottoCfg,showNextLotto , onCloseCallback)
    --herodata排序 品级越高越往前
table.sort(heros,function(a,b)
        if  a.quality == b.quality then
                return a.ChipId < b.ChipId
            else
                return a.quality > b.quality 
            end
        end)
    
    if lottoCfg.page == LotteryType.Noob then --新晋卡池不显示单抽
        self._view.tsBtn_once.gameObject:SetActive(false)
    else 
        self._view.tsBtn_once.gameObject:SetActive(true)
    end
    self._itemLength = 0 
    self._lottoCfg = lottoCfg
    self._itemLength = #heros 
    self._onCloseCallback = onCloseCallback
    self._showNextLotto = showNextLotto 
    self._view.effect_ui_lottery:SetActive(false)
    local itemCtl = require( "UI.Ctrl.Lottery.LotteryResultHeroItem")
    for i = 1 , 10 do --self._itemLength - 1  do 
        local item = nil 
        if self._items[i] == nil then 
            item = itemCtl.New( self._view["view_HeroItem"..(i-1)])
            self._items[i] = item 
        else
            item = self._items[i]
        end
        if i <= self._itemLength then 
            local h = heros[i]
            local heroId = h.ObjId
            local chipId = h.ChipId
            local chipNum = h.ChipNum
            item:SetActive(true)
            item:SetHero( heroId , chipId ,chipNum,self._view.effect_ui_lottery)
        else
            item:SetActive(false)
        end
    end
    -- self._view.trans_BtnGroup:SetActive(showNextLotto)
    self._view.trans_BtnGroup:SetActive(false)
    for i = 1 , 2 do 
        --local cfg = self._lottoCfgs[i]
        -- local cost = cfg.costItem 
        local costItemId 
        local costItemNum 
        local isEnough
        costItemId,costItemNum,isEnough = LotteryHelper.GetCostItemByShow(self._lottoCfg,i == 1)
        self["_propertyBar"..i]:SetWarningNumber(costItemNum)
        self["_propertyBar"..i]:Action(costItemId,costItemNum)
        -- table.insert( self._lotteryCostItems, costItemId )
        -- self["_propertyBar" ..i]:Action(costItemId)
        -- self["_propertyBar" ..i]:SetWarningNumber(costItemNum)
    end
end

--点击设置退出键
function M:OnDeviceBack()
    if self._onCloseCallback then 
        self._onCloseCallback(true)
    end
    return true 
end

function M:_OnClickOnce(go)
    local context = UIContextMgr:GetInstance():GetContext("Lottery")
    local drawData = context._lottoDataGroup:GetDrawDataById(self._lottoCfg.id)
    if not LotteryHelper.CheckLottery( self._lottoCfg ,drawData,1) then 
        GameHelper.TipsById(4135)
        return 
    end
    if not self._showNextLotto then 
        return 
    end
    --self:Close()
    local cfg = self._lottoCfg
    context:Lotto(cfg.id,1,Bind(self,self.LottoResult))
end

function M:LottoResult(isSuc)
    if isSuc then 
        self:Close()
    end
end

function M:_OnClickTen(go)
    local context = UIContextMgr:GetInstance():GetContext("Lottery")
    local drawData = context._lottoDataGroup:GetDrawDataById(self._lottoCfg.id)
    if not LotteryHelper.CheckLottery( self._lottoCfg ,drawData,10) then 
        GameHelper.TipsById(4135)
        return 
    end
    if not self._showNextLotto then 
        return 
    end
    --self:Close()
    local cfg = self._lottoCfg
    context:Lotto(cfg.id,10,Bind(self,self.LottoResult))
end

function M:OnClose()
    self._onCloseCallback = nil 
end

return M 

