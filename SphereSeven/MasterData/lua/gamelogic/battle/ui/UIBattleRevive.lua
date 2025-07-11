---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2020/11/5 19:24
---
local UIBattleRevive = BaseClass("UIBattleRevive", UIBaseView)
local this = UIBattleRevive
local base = UIBaseView



local function exit(self)
    if self.model.ConfirmFinishCallback ~= nil then
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleRevive)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattleLose)
        self.model.ConfirmFinishCallback()
    end
end

function this.OnCreate(self)
    base.OnCreate(self)
    
    self.bg1 = self.rc:GetObject("Bg1")
    self.bg2 = self.rc:GetObject("Bg2")
    
    LangUtil.BindText(self.rc:GetObject("TopText")).text = LangUtil.GetSysLang(3007)
    LangUtil.BindText(self.rc:GetObject("Tip1")).text = LangUtil.GetSysLang(10)
    LangUtil.BindText(self.rc:GetObject("Tip2")).text = LangUtil.GetSysLang(3010)
    
    LangUtil.BindText(self.rc:GetObject("BuyExit")).text = LangUtil.GetSysLang(3012)
    LangUtil.BindText(self.rc:GetObject("BuyConfirm")).text = LangUtil.GetSysLang(3011)
    LangUtil.BindText(self.rc:GetObject("StarText")).text = LangUtil.GetSysLang(3008)
    LangUtil.BindText(self.rc:GetObject("StarLightText")).text = LangUtil.GetSysLang(3009)
    LangUtil.BindText(self.rc:GetObject("StarNum"), FontType.All_Number)
    self.starNum = LangUtil.BindText(self.rc:GetObject("StarNum"), FontType.All_Number)
    self.starLightNum = LangUtil.BindText(self.rc:GetObject("StarLightNum"), FontType.All_Number)

    -------------------------------------
    LangUtil.BindText(self.rc:GetObject("Top2Text")).text = LangUtil.GetSysLang(3007)
    LangUtil.BindText(self.rc:GetObject("ExitText")).text = LangUtil.GetSysLang(3017)
    LangUtil.BindText(self.rc:GetObject("BuyText")).text = LangUtil.GetSysLang(3015)
    LangUtil.BindText(self.rc:GetObject("Tip3Text")).text = LangUtil.GetSysLang(3074)

    local starStoneImg = self.rc:GetObject("StarImage"):GetComponent("Image")
    local starLightStoneImg = self.rc:GetObject("StarLightImage"):GetComponent("Image")
    local starLightStoneImg2 = self.rc:GetObject("StarLightImage2"):GetComponent("Image")

    UIUtil.SetSprite(starStoneImg, AtlasConfig.Item, GetItemIcon(Z_Item[ tonumber(Z_Misc["FREE_DIAMOND_ID"].Value[1]) ]))
    UIUtil.SetSprite(starLightStoneImg, AtlasConfig.Item, GetItemIcon(Z_Item[ tonumber(Z_Misc["DIAMOND_ID"].Value[1]) ]))
    UIUtil.SetSprite(starLightStoneImg2, AtlasConfig.Item, GetItemIcon(Z_Item[ tonumber(Z_Misc["DIAMOND_ID"].Value[1]) ]))
    
    -- 是否购买
    self.buyCloseBtn = self.rc:GetObject("BuyCloseBtn"):GetComponent("Button")
    self.buyExitBtn = self.rc:GetObject("BuyExitBtn"):GetComponent("Button")
    self.buyConfirmBtn = self.rc:GetObject("BuyConfirmBtn"):GetComponent("Button")
    
    -- 星光石不足
    self.closeBtn = self.rc:GetObject("CloseBtn"):GetComponent("Button")
    self.exitBtn = self.rc:GetObject("ExitBtn"):GetComponent("Button")
    self.buyBtn = self.rc:GetObject("BuyBtn"):GetComponent("Button")
    
    self.bg1:SetActive(true)
    self.bg2:SetActive(false)

    UIUtil.AddBtnEvent(self.buyCloseBtn, function(go) exit(self) end)
    UIUtil.AddBtnEvent(self.buyExitBtn, function(go) exit(self) end)
    UIUtil.AddBtnEvent(self.closeBtn, function(go) exit(self) end)
    UIUtil.AddBtnEvent(self.exitBtn, function(go) exit(self) end)

    self.player = Game.Scene.Player
    self.needStone = 100

    UIUtil.AddBtnEvent(self.buyConfirmBtn, function(go)
        if self.freeStoneAmount + self.paidStoneAmount  < self.needStone then
            self.bg1:SetActive(false)
            self.bg2:SetActive(true)
        else
            coroutine.start(function()
                local reqData = {}
                reqData.ExpendFreeStarStone = 0
                reqData.ExpendPaidStarStone = 0
                if self.freeStoneAmount + self.paidStoneAmount < self.needStone then
                    reqData.ExpendFreeStarStone = self.freeStoneAmount
                    reqData.ExpendPaidStarStone = self.paidStoneAmount
                elseif self.freeStoneAmount < self.needStone then
                    reqData.ExpendFreeStarStone = self.freeStoneAmount
                    reqData.ExpendPaidStarStone = self.needStone - self.freeStoneAmount
                else
                    reqData.ExpendFreeStarStone = self.needStone
                end
                -- local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil, Game.Scene.Session,
                --         PROTOCOL.BattlePlayerReviveReq, reqData)
                -- if info.Error == ErrorCode.ERR_Success then
                --     self.freeStoneAmount = self.freeStoneAmount - reqData.ExpendFreeStarStone
                --     self.paidStoneAmount = self.paidStoneAmount - reqData.ExpendPaidStarStone
                --     Game.Scene:GetComponent("BattleComponent"):PlayerReviveAll()
                --     UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleRevive)
                --     UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleLose)
                --     UIUtil.ToolTipFourth(LangUtil.GetSysLang(12))
                -- else
                --     UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error))
                -- end

                PublicRequest.SendRequest(PROTOCOL.BattlePlayerReviveReq, {}, function(response, errorCode)
                    DataManager:GetInstance():Broadcast(DataMessageNames.ON_ITEM_INFO_CHG)
                    if errorCode == 0 then 
                        self.freeStoneAmount = self.freeStoneAmount - reqData.ExpendFreeStarStone
                        self.paidStoneAmount = self.paidStoneAmount - reqData.ExpendPaidStarStone
                        Game.Scene:GetComponent("BattleComponent"):PlayerReviveAll()
                        UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleRevive)
                        UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleLose)
                        UIUtil.ToolTipFourth(LangUtil.GetSysLang(12))
                    else
                        --UIUtil.ToolTipFourth(LangUtil.GetServerError(info.Error))
                    end
                end)
            end)
        end
    end)

    UIUtil.AddBtnEvent(self.buyBtn, function(go)
        exit(self) 
        --UIUtil.ToolTipFourth(LangUtil.GetSysLang(3051)) 
    end)

    --if Game.Scene:GetComponent("AgainstComponent").IsAutoGame ~= 0 then
    --    if math.random(1, 2) == 1 then
    --        exit()
    --    else
    --        Game.Scene:GetComponent("BattleComponent"):PlayerReviveAll()
    --        UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleRevive)
    --        UIUtil.ToolTipFourth(LangUtil.GetSysLang(12))
    --    end
    --end
end

function this.GetTxt(self, text, enable)
    if not enable then
        return "<color=#F41F42>"..text.."</color>"
    else
        return "<color=#40EE9A>"..text.."</color>"
    end
end

function this.OnEnable(self)
    base.OnEnable(self)
    local battle_component = Game.Scene:GetComponent("BattleComponent")
    if battle_component ~= nil and battle_component.reviveTimes <= 0 then
        exit(self)
        return
    end

    self.freeStoneAmount = UIPublic.GetItemAmount(tonumber(Z_Misc["FREE_DIAMOND_ID"].Value[1]))
    self.paidStoneAmount = UIPublic.GetItemAmount(tonumber(Z_Misc["DIAMOND_ID"].Value[1]))
    self.starNum.text = self:GetTxt(tostring(self.freeStoneAmount), self.freeStoneAmount >= self.needStone)
    self.starLightNum.text = self:GetTxt(tostring(self.paidStoneAmount), self.paidStoneAmount >= self.needStone)


    --self.starNum.text = self:GetTxt(tostring(self.freeStoneAmount), self.freeStoneAmount >= self.needStone)
    --self.starLightNum.text = self:GetTxt(tostring(self.paidStoneAmount), self.paidStoneAmount >= self.needStone)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this