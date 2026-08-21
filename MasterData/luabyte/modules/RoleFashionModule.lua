local RoleFashionModule = BaseClass("RoleFashionModule", require("Framework.Module.BaseGameModule"))
local M = RoleFashionModule
local rotateSpeed = 10
local MAX_SHOW_GIRL_CACHE_COUNT = 5 --缓存战员数量
local REMOVE_GIRL_COUNT = 3 -- 达到缓存数量之后，一次性删除的个数

function M:__init()
    self._isFirstTime = true
end

function M:OnEnter(heroId)
    M.super.OnEnter(self)
    local herodata = IHeroDataMgr:GetHeroDataById(heroId)
    local skin = IHeroDataMgr:GetHeroSkin(heroId, herodata:GetFashion())
    self.m_Slider = { 1, 0.82, 0.67, 0.5, 0.33, 0.15, 0 }
    self._curHeroId = heroId
    self._skinId = skin.id
    self.showGirlTab = {}
    if self:GetCurSceneName() ~= "Display02" then
        self:LoadScene("Display02", Bind(self, self._LoadSceneComplete))
    else
        --防止点击顶站导航直接再跳到养成里面，同一帧既删UI又显示UI，会造成BUG 
        --TimerManager:GetInstance():GetTimer(0.1,self._LoadSceneComplete,self,true):Start()
        self:_LoadSceneComplete(self:GetViewAndCtrl("Display02"))
    end
    
    GameHelper.DoPlayerAction(PlayerAction.OpenHero)
end

function M:_LoadSceneComplete(_, ctrl)
    ctrl:ChangeDisplay("FashionShow")
    self._view = ctrl:GetHolder("FashionShow")
    self:CreateDirector(self._view.CameraNode)
    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    --30 是写死的FOV
    -- self:GetCameraDirector():CameraTranslation(0, -4.520, 0.520, 6.050, 5.000, -221.907, 0, 30)
    self:GetCameraDirector():CameraTranslation(0, 0, 1.39, 3.831, 8, -180, 0, 30)
    UIContextMgr:GetInstance():Show("RoleFashionUI", self._curHeroId)
    self:Ready()
end

function M:OnExit()
    UIContextMgr:GetInstance():Close("RoleFashionUI")

    
    
    self.showGirl = nil
    
    for heroId, girl in pairs(self.showGirlTab) do
        RoleBehaviorCtrl:GetInstance():RemoveGirl(heroId, RoleUse.Delveop)
        --GameUtil.DestroyGo(fsm.gameObject)
    end
    
    ResourceManager:GetInstance():RemoveUnusedAssets()
    self.showGirlTab = nil
    M.super.OnExit(self)
end


--顯示角色模型，並且播放指定timelineId
function M:ShowHeroModel(skinId, withWeapon, isEnter)
    if not skinId then
        return 
    end
    
    if self.showGirl and self._skinId == skinId then
        return 
    end
    
    --默認持有武器
    if withWeapon == nil then
        withWeapon = true
    end
    
    if skinId > 0 then
        self:_RefreshModel(skinId, withWeapon, isEnter)
    end
    
    self._skinId = skinId
end

---isEnter :是否需要入场动画
function M:_RefreshModel(skinId, withWeapon, isEnter)
    if self.showGirl ~= nil then
        self.showGirl:Hide()
    end
    if self.showGirlTab[skinId] ~= nil then
        self.showGirl = self.showGirlTab[skinId]
    else
        local CS_BEHAVIOR = CS.GameX.EInteractActionBehaviorType
        local CommonShowCtrlWithCustom = require("RoleBehavior.Ctrls.CommonShowCtrlWithCustom")
        self.showGirl = RoleBehaviorCtrl:GetInstance():CreateGirlBySkinId(skinId, withWeapon, CommonShowCtrlWithCustom, RoleUse.Delveop,2, CS_BEHAVIOR.Enter_Develop, CS_BEHAVIOR.Develop_StandBy, 1)
        self.showGirl.transform:SetParent(self._view.showGirlRoot, false)
        self.showGirlTab[skinId] = self.showGirl
        self.showGirl:SetCanTouch(false)
        
        if table.count(self.showGirlTab) >= MAX_SHOW_GIRL_CACHE_COUNT then
            local heroIdList = {}
            
            for id, _ in pairs(self.showGirlTab) do
                if id ~= skinId and #heroIdList <= REMOVE_GIRL_COUNT then
                    table.insert(heroIdList, id)
                end
            end
            
            for _, hid in ipairs(heroIdList) do
                -- body
                RoleBehaviorCtrl:GetInstance():RemoveGirl(hid)
                self.showGirlTab[hid] = nil
            end
            
            ResourceManager:GetInstance():RemoveUnusedAssets()
        end
    end
    local defaultState = RoleStateName.None
    local needPlay = false
    if not isEnter then 
        needPlay = true
        defaultState = RoleStateName.Idle
    end
    self.showGirlTab[skinId]:Show(defaultState,needPlay)
    self._lastGenrateRoleTime = Time.realtimeSinceStartup
    
    -- if not isEnter then
    --     self.showGirl:ChangeState(RoleStateName.Idle)
    -- end
end

--歸位模型
function M:ResetModel()
    self.showGirl.transform.localEulerAngles = Vector3.zero
end

--是否可以拖動
function M:SetDrag(canDrag)
    self._canDrag = canDrag
end

function M:UpdateHeroGene(heroId, cfgArr)
    if self._curHeroId == heroId and self.geneLst[1]:IsLoad() then
        return 
    end
    
    self:_RemoveOldGeneBallAndGeneShow()
end

function M:_RemoveOldGeneBallAndGeneShow()
    for i = 1, #self.geneLst do
        self.geneLst[i]:RemoveBall()
    end
    
    if self.gene then
        GameUtil.DestroyGo(self.gene)
    end
end

return RoleFashionModule
