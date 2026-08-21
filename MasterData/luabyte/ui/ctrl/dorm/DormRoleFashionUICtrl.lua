local DormRoleFashionUICtrl = BaseClass("DormRoleFashionUICtrl", BaseUICtrl)
local M = DormRoleFashionUICtrl
local RoleFashionCardItemCtrl = require("UI.Ctrl.Dorm.DormRoleFashionCardItemCtrl")
local RoleFashionCardItemView = require("UI.View.Dorm.DormRoleFashionCardItemView")


function M:Init()
    self.m_RoleFashionChange = EventMgr:AddListener(UIMessageNames.ROLE_FASHION_CHANGE,
        Bind(self, self._OnRoleFashionChange))
    self.m_Context = self:GetContext()

    self:InitFashionCardList()
    self:AddListener()

    self:_FashionCallbacks()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
end

function M:OnEnter(heroId)
    self.heroId = heroId
    self.curHeroData = self.m_Context:GetHeroData()
    self:ShowAllSkins()
end

-- 初始化时装列表组件
function M:InitFashionCardList()
    self._view.fashionCardList:Init(RoleFashionCardItemCtrl, RoleFashionCardItemView)
    -- 注册选中时的回调函数
    self._view.fashionCardList:SetCenterChangedAction(Bind(self, self._SelectedItemCallback))
end

-- 显示皮肤列表
function M:ShowAllSkins()
    local index = 0
    local defaultIndex = 0
    self.dataList = self.m_Context:GetData()
    local fashionId = self.m_Context:GetCurHeroFashion()
    for _, value in pairs(self.dataList) do
        index = index + 1
        if fashionId == value.skinCfg.roomSignId then
            defaultIndex = index
        end
    end
    self._view.fashionCardList:SetDataList(self.dataList)
    self._view.fashionCardList:GoToItemByIndex(defaultIndex, true)
end

-- 按钮监听事件
function M:AddListener()
    self._view.btnDress:onClick(Bind(self, self._OnClickDress))
    self._view.btnGoToGet:onClick(Bind(self, self._OnClickGoToGet))
    self._view.arrowLeft:onClick(Bind(self, self._OnClickArrowLeft))
    self._view.arrowRight:onClick(Bind(self, self._OnClickArrowRight))
end

function M:SetHeroItem()
    self._view.HeroHeadItem:SetHeroId(self.heroId)
    self._view.HeroHeadItem:SetIcon(self.m_SelectedSkin.skinCfg.icon)
end

-- 关闭当前人物和背景
function M:HideHeroAndBg()
    self.model:HideHero()
    self.model:ClearSceneBg()
end

function M:_OnRoleFashionChange()
    local centerItem = self._view.fashionCardList:GetItemByIdx(self.m_CurItemId)
    self:_SelectedItemCallback(self.m_CurItemId, centerItem)
end

-- 向左选中
function M:_OnClickArrowLeft()
    self._view.fashionCardList:MoveLeftArrow()
end

-- 向右选中
function M:_OnClickArrowRight()
    self._view.fashionCardList:MoveRightArrow()
end

--跳到某一个索引
function M:_SetCenterChild(idx)
    self._view.fashionCardList:SetCenterChild(idx)
end

-- 不同状态对应不同的回调函数
function M:_FashionCallbacks()
    self.fashionBtnStateEnum = {
        Dressing = 1,
        Dressable = 2,
        Buyable = 3,
        SkipGet = 4,
        NotGet = 5,
        NotHaveHero = 6
    }
    -- 同一按钮的几种状态回调, 通过state的id控制
    self.fashionCallbacks = {
        -- 1. 已拥有_穿戴中
        [1] = function()
            -- 按钮不可点击
        end,
        -- 2. 已拥有_穿戴按钮
        [2] = function()
            -- 穿戴按钮
        end,
        -- 3. 未拥有_可购买
        [3] = function()
            -- 购买按钮逻辑
        end,
        -- 4. 未拥有_可跳转获取
        [4] = function()
            -- 可跳转逻辑
        end,
        -- 5. 未拥有_无法获取
        [5] = function()
            -- 无法购买逻辑
        end,
        -- 6. 已拥有_没有战员
        [6] = function()
        end
    }
end

-- 选中的item回调，此处的curItemId索引从1开始，注意
function M:_SelectedItemCallback(curItemId, centerItem)
    self.m_CurItemId = curItemId -- 当前选中的item索引，lua索引从1开始
    self.m_SelectedSkin = self.dataList[self.m_CurItemId]
    self.heroId = self.m_SelectedSkin.skinCfg.heroId
    self.m_Context:UpdateHeroData(self.m_SelectedSkin.skinCfg.heroId)
    self.curHeroData = self.m_Context:GetHeroData()
    self:_RefreshViewAfterSelected()
    self.module:ShowHeroModel(self.m_SelectedSkin.skinCfg.id)
    self._curSkinId = self.m_SelectedSkin.skinCfg.id
end

function M:GetSelectedIndex()
    return self.m_CurItemId
end

-- 获取当前时装的状态显示指定的按钮
function M:_ShowFashionBtn()
    -- 服务器返回的参数或者读表获取时装的当前状态
    if self.m_SelectedSkin.skinCfg.roomSignId == self.m_Context:GetCurHeroFashion() then
        self.m_CurBtnState = self.fashionBtnStateEnum.Dressing
    elseif self.m_SelectedSkin.skinCfg.roomSignId == 0 or IItemDataMgr:GetItemById(self.m_SelectedSkin.skinCfg.id) then
        if self.m_Context.isHave then
            self.m_CurBtnState = self.fashionBtnStateEnum.Dressable
        else
            self.m_CurBtnState = self.fashionBtnStateEnum.NotHaveHero
        end
    else
        self.m_CurBtnState = self.fashionBtnStateEnum.NotGet
    end
    self._view.state:SetState(self.m_CurBtnState)
end

----------------------------------界面按钮回调-----------------------------
-- 穿戴按钮 state id 2
function M:_Callback()
    self.fashionCallbacks[self._view.state:GetState()]() 
end

function M:_OnClickDress()
    -- 异步显示刷新, 传一个回调进去
    self.m_Context:C2S_Dress(self.m_SelectedSkin.skinCfg.roomSignId)
end

-- 跳转按钮 state id 4
function M:_OnClickGoToGet()
    -- 异步显示刷新, 传一个回调进去
    self.m_Context:C2S_GoToGet()
end

-------------------------------界面按钮回调-----------------------------------------------

-------------------------------同步数据---------------------------------------------------
-- 已选择item后刷新界面其他数据
function M:_RefreshViewAfterSelected()
    local itemCfg = self.m_Context:GetItemFromSkin(self.m_SelectedSkin.skinCfg.id)
    self._view.wayValue:SetText(ConfigHelper.GetLocalString(itemCfg.wayValue1))
    self._view.fashionLeftName:SetText(ConfigHelper.GetLocalString(itemCfg.name))
    self._view.fashionRightName:SetText(ConfigHelper.GetLocalString(itemCfg.name))
    self._view.fashionDes:SetText(ConfigHelper.GetLocalString(itemCfg.desc))
    self:SetHeroItem()

    self:_ShowFashionBtn()
end

-------------------------------同步数据结束---------------------------------------------------

function M:OnBack()
    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.Dorm.id, self.heroId)
end

function M:OnDispose()
    M.super.OnDispose(self)
    EventMgr:RemoveListener(UIMessageNames.ROLE_FASHION_CHANGE, self.m_RoleFashionChange)
end

return DormRoleFashionUICtrl
