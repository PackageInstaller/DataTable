local UIExpeditionTipView = BaseClass("UIExpeditionTipView",UIBaseView);
local base = UIBaseView
local this = UIExpeditionTipView

local consumeStartStone = {0,5,5,5,10,10,10,20,20,20}

local TipType = {["Fresh"] = 1,["Acc"] = 2,["ReCall"] = 3}     -- 1 刷新  2 加速 3 召回

function this.OnCreate(self)
    base.OnCreate(self)
    self.expeditionComponent =  Game.Scene.Player:GetComponent("ExpeditionComponent")
    self.btnClose = self.rc:GetObject("BtnClose")
    self.typeContent_1 = self.rc:GetObject("TypeContent_1")
    self.txtTittle_1 = self.typeContent_1.transform:Find("TxtTittle").gameObject
    self.txtTip_1 = self.typeContent_1.transform:Find("TxtTip").gameObject
    self.stoneHaveSpr = self.typeContent_1.transform:Find("StoneHaveSpr").gameObject
    self.txtStoneHaveTip = self.stoneHaveSpr.transform:Find("TxtTip").gameObject
    self.txtStoneHave = self.stoneHaveSpr.transform:Find("TxtCount").gameObject
    self.stoneNoSpr = self.typeContent_1.transform:Find("StoneNoSpr").gameObject
    self.txtStoneNoTip = self.stoneNoSpr.transform:Find("TxtTip").gameObject
    self.txtStoneNo = self.stoneNoSpr.transform:Find("TxtCount").gameObject
    self.btnFresh = self.typeContent_1.transform:Find("BtnFresh").gameObject
    self.txtBtnFresh = self.btnFresh.transform:Find("Text").gameObject
    self.btnAcc = self.typeContent_1.transform:Find("BtnAcc").gameObject
    self.txtBtnAcc = self.btnAcc.transform:Find("Text").gameObject
    self.btnCancle_1 = self.typeContent_1.transform:Find("BtnCancle").gameObject
    self.txtbtnCancle_1 = self.btnCancle_1.transform:Find("Text").gameObject

    self.typeContent_2 = self.rc:GetObject("TypeContent_2")
    self.txtTittle_2 = self.typeContent_2.transform:Find("TxtTittle").gameObject
    self.txtTip_2 = self.typeContent_2.transform:Find("TxtTip").gameObject
    self.btnSure = self.typeContent_2.transform:Find("BtnSure").gameObject
    self.txtBtnSure = self.btnSure.transform:Find("Text").gameObject
    self.btnCancle_2 = self.typeContent_2.transform:Find("BtnCancle").gameObject
    self.txtbtnCancle_2 = self.btnCancle_2.transform:Find("Text").gameObject
    UIUtil.AddBtnEvent(self.btnClose,function(go)
        self.ctrl:CloseSelf()
    end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.txtStoneHaveTip).text = LangUtil.GetSysLang(312)
    LangUtil.BindText(self.txtStoneNoTip).text = LangUtil.GetSysLang(312)
    if self.model.data.type ~= TipType.ReCall then
        LangUtil.BindText(self.txtTittle_1).text = LangUtil.GetSysLang(9)
        if self.model.data.type == TipType.Fresh then
            LangUtil.BindText(self.txtTip_1).text = string.format(LangUtil.GetSysLang(4097),consumeStartStone[11 - self.expeditionComponent.leftCount])
            LangUtil.BindText(self.txtBtnFresh).text = LangUtil.GetSysLang(326)
        else
            LangUtil.BindText(self.txtTip_1).text = string.format(LangUtil.GetSysLang(4109),self.model.data.leftHour)
            LangUtil.BindText(self.txtBtnAcc).text = LangUtil.GetSysLang(4107)
        end
        LangUtil.BindText(self.txtbtnCancle_1).text = LangUtil.GetSysLang(146)
    else
        LangUtil.BindText(self.txtBtnSure).text = LangUtil.GetSysLang(145)
        LangUtil.BindText(self.txtbtnCancle_2).text = LangUtil.GetSysLang(146)
        LangUtil.BindText(self.txtTittle_2).text = LangUtil.GetSysLang(9)
        LangUtil.BindText(self.txtTip_2).text = LangUtil.GetSysLang(4110)
    end
end

function this.OnEnable(self)
    base.OnEnable(self);
    self.typeContent_1.gameObject:SetActive(self.model.data.type ~= TipType.ReCall)
    self.typeContent_2.gameObject:SetActive(self.model.data.type == TipType.ReCall)
    self.btnFresh:SetActive(self.model.data.type == TipType.Fresh)
    self.btnAcc:SetActive(self.model.data.type == TipType.Acc)
    self.btnSure:SetActive(self.model.data.type == TipType.ReCall)
    if self.model.data.type ~= TipType.ReCall then
        local player = Game.Scene.Player
        LangUtil.BindText(self.txtStoneHave).text = UIUtil.ScientificCount(player.PaidStarStone)
        LangUtil.BindText(self.txtStoneNo).text = UIUtil.ScientificCount(player.FreeStarStone)
        UIUtil.AddBtnEvent(self.btnFresh,function(go)
            -- 刷新 TODO
            self.model.data.func()
            self.ctrl:CloseSelf()
        end)
        UIUtil.AddBtnEvent(self.btnAcc,function(go)
            -- 加速 TODO
            self.model.data.func()
            self.ctrl:CloseSelf()
        end)
        UIUtil.AddBtnEvent(self.txtbtnCancle_1,function(go)
            self.ctrl:CloseSelf()
        end)
    else
        UIUtil.AddBtnEvent(self.btnSure,function(go)
            self.model.data.func()
            self.ctrl:CloseSelf()
        end)
        UIUtil.AddBtnEvent(self.txtbtnCancle_2,function(go)
            self.ctrl:CloseSelf()
        end)
    end
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

