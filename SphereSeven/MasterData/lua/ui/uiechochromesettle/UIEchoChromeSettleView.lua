local UIEchoChromeSettleView = BaseClass("UIEchoChromeSettleView",UIBaseView);
local base = UIBaseView;
local this = UIEchoChromeSettleView;

function this.OnCreate(self)
    base.OnCreate(self);
    self.txtTitle = self.rc:GetObject("Title")
    self.closeButton = self.rc:GetObject("CloseButton")
    self.confirmBtn = self.rc:GetObject("ConfirmBtn")
    self.txtConfirm = self.rc:GetObject("ConfirmText")
    self.heads = self.rc:GetObject("Heads")
    self.txtDamage = self.rc:GetObject("DamageText")
    self.bg = self.rc:GetObject("Bg")


    local battle_component = Game.Scene:GetComponent("BattleComponent")
    self.RightGroup = battle_component:SortByRowAndLine(battle_component:GetGroupUnits(MatrixGroup.Friend))
    local func = function(transform, cardInfo)
        local zCard = Z_Card[cardInfo.TemplateId]
        local starRoot = transform:Find("Star")
        local icon = transform:Find("Icon/Value"):GetComponent("Image")
        local frame = transform:Find("Frame"):GetComponent("Image")
        --local lvFrame = transform:Find("Level"):GetComponent("Image")
        local lvTxt = transform:Find("Level/Value"):GetComponent("Text")
        for i = 0,starRoot.childCount - 1 do
            starRoot:GetChild(i).gameObject:SetActive((i + 1 )<= cardInfo.Star)
        end
        icon.color.a = 1
        --lvFrame.color.a = 1
        lvTxt.text=  "LV "..cardInfo.Level
        UIUtil.SetCardSprite(icon,zCard.Id,cardInfo.SkinId,CardPictureType.Little,true)
        UIUtil.SetSprite(frame,AtlasConfig.CardLittleFrame,UIPublic.RareNames[zCard.Rare]..".png",true)
        --UIUtil.SetSprite(lvFrame,AtlasConfig.CardLittleFrame,"L_"..UIPublic.RareNames[zCard.Rare]..".png",true)
    end
    for i = 1, self.heads.transform.childCount do
        local tnf = self.heads.transform:GetChild(i - 1)
        if tnf == nil then return end
        tnf.gameObject:SetActive(true)
        if i <= #self.RightGroup then
            func(tnf, self.RightGroup[i].Card)
        else
            local starRoot = tnf:Find("Star")
            local icon = tnf:Find("Icon/Value"):GetComponent("Image")
            local frame = tnf:Find("Frame"):GetComponent("Image")
            local lvFrame = tnf:Find("Level"):GetComponent("Image")
            local lvTxt = tnf:Find("Level/Value"):GetComponent("Text")
            for index = 0, starRoot.childCount - 1 do
                starRoot:GetChild(index).gameObject:SetActive(false)
            end
            icon.color.a = 0
            lvFrame.color.a = 0
            lvTxt.text = nil
            UIUtil.SetSprite(frame, AtlasConfig.CardLittleFrame, "0.png",true)
        end
    end
    UIUtil.AddBtnEvent(self.closeButton, function() Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene) end)
    UIUtil.AddBtnEvent(self.confirmBtn, function() Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene) end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.txtTitle).text = LangUtil.GetSysLang(3)
    LangUtil.BindText(self.txtDamage).text = LangUtil.GetSysLang(7) .. ": " .. "<color=#40ee9a>"..self.model.data.Score.."</color>"
    LangUtil.BindText(self.txtConfirm)
end

function this.OnEnable(self)
    base.OnEnable(self)
end


function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this;