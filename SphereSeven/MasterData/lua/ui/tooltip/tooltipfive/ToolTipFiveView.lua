local ToolTipFiveView = BaseClass("ToolTipFiveView",UIBaseView)
local base = UIBaseView
local this = ToolTipFiveView

function this.OnCreate(self)
    base.OnCreate(self);
    self.ItemList={}
    self.itemListIndex = 0
    self.Bg = self.rc:GetObject("Bg").transform
    self.titleImage = self.rc:GetObject("title_text"):GetComponent("Image")
    self.continueBut = self.rc:GetObject("continueBut"):GetComponent("Image")
    self.Mask= self.rc:GetObject("Mask")
    
    --self.continueBut = self.rc:GetObject("continueBut")
    
    self.ItemPanel = self.rc:GetObject("ItemPanel").transform
    for i = 0,self.ItemPanel.childCount - 1 do
        table.insert(self.ItemList,self.ItemPanel:GetChild(i));
    end
    
    UIUtil.AddBtnEvent(self.Mask,function(go)  self:Continue() end)
end
function this.OnLangCreate(self)
    LangUtil.GetSpriteLang(20,function(sprite)
        self.titleImage.sprite = sprite
    end)
    LangUtil.GetSpriteLang(21,function(sprite)
        self.continueBut.sprite = sprite
    end)
    self.continueBut:SetNativeSize()
    UIUtil.AddBtnEvent(self.continueBut.gameObject,function(go)  self:Continue() end)
end

function this.Continue(self)
    self.itemListIndex = self.itemListIndex+1
    self.continueBut.gameObject:SetActive(false)
    if self.model.data.Reward[self.itemListIndex]==nil then
        self.ctrl:CloseSelf()
        Game.Scene:GetComponent("GuideComponent"):AutoGuide()
    else
        for i, v in pairs(self.ItemList) do
            v.gameObject:SetActive(false)
            if self.model.data.Reward[self.itemListIndex][i] ~=nil then
                local image = v:Find("Image"):GetComponent("Image")
                local nameText = LangUtil.BindText(v:Find("nameText"))
                local NumText= v:Find("NumTxt"):GetComponent("Text")
                local itemBg= v:GetComponent("Image")

                local rewardInfo = {}
                local ZGuideReward = Z_GuideReward[self.model.data.Reward[self.itemListIndex][i]];
                rewardInfo.TemplateId = ZGuideReward.RewardId
                rewardInfo.RewardTypeInfo = RewordTypeList[ZGuideReward.RewardType]
                rewardInfo.Num = ZGuideReward.RewardNum

                local config = UIUtil.SetRewardInfo(rewardInfo, image, {numText = NumText})
                nameText.text = config.Name
                
                UIUtil.SetSprite(itemBg,AtlasConfig.ItemBg,"3.png")
                v.gameObject:SetActive(true)
            end
        end
        self.continueBut.gameObject:SetActive(true)
    end
end



function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
    --self.title_text.text = self.model.data.title
    self:Continue()
end

function this.OnAddListener(self)
    base.OnAddListener(self);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end


function this.OnDisable(self)
    base.OnDisable(self)
   
end

function this.OnDestroy(self)
    
end

return this
