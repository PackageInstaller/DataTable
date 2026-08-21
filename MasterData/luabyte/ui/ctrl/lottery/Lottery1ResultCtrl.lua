local Lottery1ResultCtrl = BaseClass( "Lottery1ResultCtrl" , BaseUICtrl )
local M = Lottery1ResultCtrl 

function M:Init()
    local LotteryStarCls = require( "UI.Ctrl.Lottery.LotteryStar")
    --self._startGroup = LotteryStarCls.New( self._view.view_StarsList2 )
    self._view.trans_Bg:onClick( function(go)
        self:_OnClickClose(go)
    end)
    self._view.Btn_Skip:onClick(function(go)
        self:_OnClickSkip(go)
    end)
    self._animator = self._view:FindComponent( typeof(CS.UnityEngine.Animator))
    self._displayIdx = 1 
    self._heros = nil 
    self._showhero = nil
    self._onCloseCallback = nil 
    self._onSkipCallback = nil 

    --图片路径常量
    self.ui_develop_icon_path = {"UI/SpritePics/develop/ui_develop_icon_1","UI/SpritePics/develop/ui_develop_icon_2","UI/SpritePics/develop/ui_develop_icon_3","UI/SpritePics/develop/ui_develop_icon_4"}
    self.ui_icon_nation_path = {"UI/SpritePics/nation/ui_icon_nation_1","UI/SpritePics/nation/ui_icon_nation_2","UI/SpritePics/nation/ui_icon_nation_3","UI/SpritePics/nation/ui_icon_nation_4"}
    self.ui_roleshow_icon_path = {"UI/SpritePics/roleshow/ui_roleshow_icon_1","UI/SpritePics/roleshow/ui_roleshow_icon_2","UI/SpritePics/roleshow/ui_roleshow_icon_3","UI/SpritePics/roleshow/ui_roleshow_icon_4","UI/SpritePics/roleshow/ui_roleshow_icon_5","UI/SpritePics/roleshow/ui_roleshow_icon_6"}
    self.ui_roleshow_img_path = {"UI/SpritePics/roleshow/ui_roleshow_img_01","UI/SpritePics/roleshow/ui_roleshow_img_02","UI/SpritePics/roleshow/ui_roleshow_img_03","UI/SpritePics/roleshow/ui_roleshow_img_04","UI/SpritePics/roleshow/ui_roleshow_img_05","UI/SpritePics/roleshow/ui_roleshow_img_06","UI/SpritePics/roleshow/ui_roleshow_img_07","UI/SpritePics/roleshow/ui_roleshow_img_08"}
end

--点击设置退出键
function M:OnDeviceBack()
    self:_OnClickClose(nil)
    return true 
end

function M:_OnClickClose(go)
    --等待中 
    if self._isInWaiting then 
        self._animator:JumpToLastFrame()
        self._isInWaiting = false
        return 
    end
    local length = #self:GetShowHeroData()
    if self._displayIdx >= length then
        self:Close()
        return 
    end
    self._displayIdx = self._displayIdx + 1 
    self:_SetContent(self:GetShowHeroData()[self._displayIdx])
    self:_PlayAnimator()
end

function M:_OnClickSkip(go)
    --判断剩余的卡牌中是否还有ssr
    local lastShowHero = self:GetShowHeroData()
    self._showHero = {}
    for i,v in ipairs(lastShowHero) do
        if i > self._displayIdx then--已经展示过的无视
            if  v.quality >= 4 then --剩余未展示的有SSR
                table.insert(self._showHero,v)
            end
        end
    end

    if #self._showHero >0 then --剩余未展示的卡牌中还有SSr
        self._displayIdx = 1 
        self:_SetContent(self:GetShowHeroData()[self._displayIdx])
        self:_PlayAnimator()
        return
    end
    local skipCallback = self._onSkipCallback
    self:Close()
    if skipCallback then 
        skipCallback()
    end
    self._onCloseCallback = nil
    
end

function M:OnClose()
    if self._timer then 
        self._timer:Stop()
    end
    self._timer = nil 
    if self._onCloseCallback then 
        self._onCloseCallback()
    end
    
    self._onCloseCallback = nil 
    self._onSkipCallback = nil 
    self._curheroCfg = nil
end

-- heros 为 {ResponseGameLotto.CLottoObj}
function M:OnEnter( heros ,onCloseCallback ,onSkipCallback,showheros,canSkip )
    if canSkip == nil then 
        canSkip = true
    end
    self._showHero = showheros  --有需要展示的卡牌 但是因为数据还是要往后传 
    self._heros = heros
    self._onCloseCallback = onCloseCallback
    self._onSkipCallback = onSkipCallback 

    self._displayIdx = 1 
    self._isInWaiting = false 
    self:_SetContent(self:GetShowHeroData()[self._displayIdx])
    --单抽不显示跳过按钮
    self._view.Btn_Skip:SetActive( #heros > 1 and canSkip )
    --单抽
    --仅展示一个英雄时 不能跳过
    if #heros == 1 then
        if showheros ~= nil and #showheros == 0 then --从抽卡跳过来的 且无SSR英雄需要展示 要执行直接跳过的逻辑
            self:_OnClickSkip()
            return
        end

    else--十连
        if showheros == nil or #showheros == 0 then  --十连跳过过来的 且没有ssr
            self:_OnClickSkip()
            return
        end
    end

    --self._view.trans_part2.gameObject:SetActive(true)
    --self._view.trans_part1.gameObject:SetActive(false)

    self:_PlayAnimator()
end

function M:OnWaitBlockUI()
    self._isInWaiting = false 
end

function M:_PlayAnimator()
    --用于再次调用时还原
    self._animator.enabled = false 
    self._animator.enabled = true 
    if self._curheroCfg.rare >= 4 then
    self._animator:Play("LotteryShowGirlNew",0,0)
    else 
    self._animator:Play("LotteryShowGirlNew2",0,0)

    end
	self._animator:Update(0)
end

function M:_SetContent(lotteHero)
    local hero = lotteHero
    local isChip = hero.ChipId~=nil and hero.ChipId > 0 
    local heroId = hero.ObjId 
    self._curheroCfg = ConfigHelper.GetCfgByLua("hero" , heroId )
    if self._curheroCfg == nil then 
        Logger.LogError("heroId .. " .. heroId ..  " error!!!")
    end
    self._view.txt_part2CnName:SetText(ConfigHelper.GetLocalString(self._curheroCfg.name))
    self._view.txt_part2EnName:SetText(ConfigHelper.GetLocalString(self._curheroCfg.nameEN))
    self._view.monologueText:SetText(ConfigHelper.GetLocalString(self._curheroCfg.drawWord))
    self._view.rimg_role:SetHeroDrawing(heroId,1)
    self._view.rimg_roleShadow:SetHeroDrawing(heroId,1)
    self._view.rimg_roleShadow2:SetHeroDrawing(heroId,1)
    self._view.img_profession:SetProfessional(heroId)
    self._view.img_part2RoleQualityShadow:SetPic(self.ui_develop_icon_path[self._curheroCfg.rare] , true )
    self._view.img_part2RoleQuality:SetPic(self.ui_develop_icon_path[self._curheroCfg.rare], true )

    local roleCfg = ConfigHelper.GetCfgByLua("role",self._curheroCfg.baseId)
    self._view.Nation:SetPic(self.ui_icon_nation_path[roleCfg.faction])
    self._view.NationShadow:SetPic(self.ui_icon_nation_path[roleCfg.faction])
    self._view.Logo:SetPic(self.ui_roleshow_icon_path[roleCfg.profession])
    self._view.LogoShadow:SetPic(self.ui_roleshow_icon_path[roleCfg.profession])
    
    self._view.newEmployee:SetActive(not isChip)
    self._view.colorQuality2:SetPic(self.ui_roleshow_img_path[self._curheroCfg.rare])


    --右边的那个额外产物
    if lotteHero.ChipId ~= nil and lotteHero.ChipId> 0 then
        self._view.finalProduct:SetActive(true)
        local itemData = ConfigHelper.GetCfgByLua("item" , lotteHero.ChipId )
        self._view.finalProductIcon:SetPic(itemData.icon)
    else
        self._view.finalProduct:SetActive(false)
    end

    self._view.state:SetState(self._curheroCfg.rare)

    GameHelper.PlayAudioById(self._curheroCfg.drawVoice)

    
    --单抽和十连都需要计时 修改了点击跳过的逻辑
    if self._timer then 
        self._timer:Stop()
     end
     -- 3秒的动画时间 
     self._timer = TimerManager:GetInstance():GetTimer( 4,Bind(self,self.OnWaitBlockUI),nil ,true )
     self._isInWaiting = true 
     self._timer:Start()
end

--显示用的数据
function M:GetShowHeroData()
    if self._showHero ~= nil and #self._showHero > 0 then --有需要展示的卡牌 但是因为数据还是要往后传 
        return self._showHero
    else 
        return self._heros
    end
    
end

return Lottery1ResultCtrl