local RoleActionUICtrl = BaseClass("RoleActionUICtrl",BaseUICtrl)
local M = RoleActionUICtrl
local HeroRedPointType = EnumConst.HeroRedPointType
local tInsert = table.insert

function M:Init()
    -- self._view.heroScrollView:Init(require("UI.Ctrl.Main.RoleActionItemCtrl"),require("UI.View.Main.RoleActionItemView"))
    self._view.eventScrollView:Init(require("UI.Ctrl.Main.RoleActionEventItemCtrl"),require("UI.View.Main.RoleActionEventItemView"))
    self._allEventsData = {}
    self._allHeros = {}
    self._view.save:onClick(Bind(self,self._OnSave))
    self._onPlayHandler = Bind( self,self._OnPlay)
    self._TempOnClickHero = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_CLICKHERO, Bind(self, self._SetRoleEvents))
    self._view.RoleListCtrl.buttonStateChangeCallback = Bind(self,self._OnHeroListStateChange)
end

function M:_OnHeroListStateChange(state)
    self._view.roleInfoState:SetState(state)
end

function M:_OnSave(go)
    if self._curHeroId == IPlayerData.pictureId or self._curHeroId == 0 then 
        return 
    end
    local  RequestUpdatePictureId = {}
    RequestUpdatePictureId.PictureId = self._curHeroId
    NetPack:SendMessage(Proto.MessageId.RequestUpdatePictureId,RequestUpdatePictureId)
    self._view.save:SetState(2)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnEnter()
    local heroList = IHeroDataMgr:GetShowGirlsLst()
    local pictureId = IPlayerData.pictureId
    self._allHeros = {}
    local heroLength = heroList.Count  
    local selectHeroId = pictureId or 110003
   
    for i = 0 , heroLength - 1 do 
        local heroData = heroList[i] 
        local data = {}
        local heroId = heroData:GetHeroId()
        data.profession = ConfigHelper.GetCfgPropByLua("role", heroId, "profession")
        data.selectIndex = pictureId or 110003
        data.heroId = heroId
        data.redType = HeroRedPointType.RoleAction --看板娘红点
        tInsert( self._allHeros , data)
    end
    self._view.RoleListCtrl:RefHeroList(self._allHeros)
    
    self:_SetRoleEvents(selectHeroId)
    --强行显示主场景结点
    local module = ModuleMgr:GetInstance().GetCurrentModule()
    if module and module.SetCameraNodeActive then 
        module:SetCameraNodeActive(true)
    end
    self:_OnHeroListStateChange(1)
end

function M:_SetRoleEvents(heroId)
   
    if heroId == nil or heroId == 0 then 
        return 
    end
    for _, v in pairs(self._allHeros)do
        v.selectIndex = heroId
    end
    local selectHeroData = IHeroDataMgr:GetMyHeroDataById(heroId) 
    if self._curHeroId ~= heroId then 
        EventMgr:Broadcast(UIMessageNames.CHANGE_MAINSCENE_HERO,{heroData=selectHeroData})
    end
    local sign = 0
    --这里说是只会在主界面切换看板娘用 而且一定是我有的英雄才会切 所以heroID ==》 skinId 以自己的卡牌当数据做转换
    if  selectHeroData ~= nil then
        sign = selectHeroData:GetFashion()
    end


    local skinId = GameHelper.HeroId2SkinId(heroId,sign)
    local list = nil  
    if self._allEventsData[heroId] then 
        list = self._allEventsData[heroId]
    else
        list = {}
        local cfgs = ConfigHelper.GetCfgs("interactEvent")
        local len = cfgs.Length 
        for i = 0 , len -1 do 
            local cfg = cfgs[i]
            if cfg.skinId == skinId and cfg.isShow == 1 then 
                local triggerActions = cfg.triggerActions
                local triggerActionsLen = triggerActions.Length 
                local tasks = cfg.taskIds
                for j = 0 , triggerActionsLen - 1 do 
                    local o = {}
                    o.taskId = tasks[j]
                    o.interactActionId = triggerActions[j]
                    o.heroId = heroId 
                    o.playActionId = 0
                    o.onPlay = self._onPlayHandler
                    tInsert(list,o)
                end
            end
        end
        self._allEventsData[heroId] = list 
    end
    for _, o in ipairs(list) do
        -- body
        o.playActionId = 0 
    end
    self._view.eventScrollView:SetDataList(list)
    self._curHeroId = heroId 
    self._view.save:SetState(self._curHeroId == IPlayerData.pictureId and 2 or 1 )
    self._view.quality:SetHeroRare(heroId)
    self._view.iconProfession:SetProfessional(heroId)
    self._view.roleName:SetAvatarName(heroId,RoleType.ERT_Hero)
end

function M:OnBack()
    local selectHeroId = 0 
    for _,d in ipairs(self._allHeros) do 
        if d.selectIndex == d.heroId then 
            selectHeroId = d.heroId
            break 
        end
    end
    if selectHeroId == 0 or selectHeroId == IPlayerData.pictureId then 
        return true
    end
    self:_SetRoleEvents(IPlayerData.pictureId)
    self:Close()
   
    
    return true 
end

function M:_OnPlay(isStart,actionId)
    local list = self._allEventsData[self._curHeroId]
    for _,d in ipairs(list) do 
        if isStart then 
            d.playActionId = actionId
        else
            d.playActionId = 0 
        end
    end
end

function M:OnClose()

end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_CLICKHERO, self._TempOnClickHero)
    M.super.OnDispose(self)
end

return M 