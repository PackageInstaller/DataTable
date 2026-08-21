local DormRoleFashionModule = BaseClass("DormRoleFashionModule", require("Framework.Module.BaseGameModule"))
local M = DormRoleFashionModule
local rotateSpeed = 10
local MAX_SHOW_GIRL_CACHE_COUNT = 5 --缓存战员数量
local REMOVE_GIRL_COUNT = 3 -- 达到缓存数量之后，一次性删除的个数

function M:__init()
    self.allGrils = {}
end

function M:OnEnter(heroId)
    M.super.OnEnter(self)
    local herodata = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local skin = DormHelper.GetRoomSkin(heroId, herodata.Fashion)
    self.m_Slider = { 1, 0.82, 0.67, 0.5, 0.33, 0.15, 0 }
    self.curHeroId = heroId
    self.skinId = skin.id
    self.showGirlTab = {}
    if self:GetCurSceneName() ~= "Home02" then
        self:LoadScene("Home02", Bind(self, self._LoadSceneComplete))
    else
        self:_LoadSceneComplete(self:GetViewAndCtrl("Home02"))
    end
    self._canDrag = true
end

function M:_LoadSceneComplete(_, ctrl)
    ctrl:ChangeDisplay("FashionShow")
    self._view = ctrl:GetHolder("FashionShow")
    self:CreateDirector(self._view.CameraNode)
    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    self:GetCameraDirector():CameraTranslation(0, 0, 1.39, 3.831, 8, -180, 0, 30)
    UIContextMgr:GetInstance():Show("DormRoleFashionUI", self.curHeroId)
    self:Ready()
end

function M:OnExit()
    UIContextMgr:GetInstance():Close("DormRoleFashionUI")

    
    
    self.showGirl = nil
    
    for heroId, girl in pairs(self.showGirlTab) do
        girl:Destroy()
    end
    
    ResourceManager:GetInstance():RemoveUnusedAssets()
    self.showGirlTab = nil
    M.super.OnExit(self)
end

function M:ShowHeroModel(skinId)
    if not skinId then
        return 
    end
    
    if self.showGirl and self.skinId == skinId then
        return 
    end
    
    if skinId > 0 then
        self:_RefreshModel(skinId)
    end
    
    self.skinId = skinId
end


function M:_RefreshModel(skinId)
    if self.showGirl ~= nil then
        self.showGirl:Hide()
    end
    if self.showGirlTab[skinId] ~= nil then
        self.showGirl = self.showGirlTab[skinId]
    else
        local roomSkinCfg = ConfigHelper.GetCfgByLua("roomSkin", skinId)
        local DormFashionHero = require("UI.Ctrl.Dorm.DormFashionHeroCtrl")
        local showGirlOjb = GameHelper.CreateDormRole(roomSkinCfg.fashionPrefab)
        showGirlOjb.transform:SetParent(self._view.showGirlRoot, false)
        self.showGirl = DormFashionHero.New(showGirlOjb)
        self.showGirlTab[skinId] = self.showGirl
        
        if table.count(self.showGirlTab) >= MAX_SHOW_GIRL_CACHE_COUNT then
            local heroIdList = {}
            
            for id, _ in pairs(self.showGirlTab) do
                if id ~= skinId and #heroIdList <= REMOVE_GIRL_COUNT then
                    table.insert(heroIdList, id)
                end
            end
            
            for _, hid in ipairs(heroIdList) do
                self.showGirlTab[hid]:Destroy()
                self.showGirlTab[hid] = nil
            end
            
            ResourceManager:GetInstance():RemoveUnusedAssets()
        end
    end
    self.showGirlTab[skinId]:Show()
    self._lastGenrateRoleTime = Time.realtimeSinceStartup
end

--歸位模型
function M:ResetModel()
    self.showGirl.transform.localEulerAngles = Vector3.zero
end

--是否可以拖動
function M:SetDrag(canDrag)
    self._canDrag = canDrag
end

return DormRoleFashionModule
