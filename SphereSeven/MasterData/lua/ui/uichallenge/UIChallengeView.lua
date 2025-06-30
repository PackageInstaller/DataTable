---
---

local UIChallengeView = BaseClass("UIChallengeView",UIBaseView)
local base = UIBaseView
local this = UIChallengeView



function this.OnCreate(self)
    base.OnCreate(self)
    self.backBtn = self.rc:GetObject("BackButton")
    UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UIChallenge)

    self.PropUpList = self.rc:GetObject("PropUpList").transform
    self.ClassUpList = self.rc:GetObject("ClassUpList").transform
    self.day = UIUtil.GetDayForWeek()

    self.sevenStarComponent = Game.Scene.Player:GetComponent("SevenStarComponent")
    
    local main  = self.rc:GetObject("Main").transform
    local funcs = {
        [1] = function() UIManager:GetInstance():OpenWindow(UIWindowNames.UISevenStar,
            {
                type = 1,
                openDetail = false,
            }
        ) end,
        [2] = function() UIManager:GetInstance():OpenWindow(UIWindowNames.UISevenStar,
            {
                type = 2,
                openDetail = false,
            }
        ) end,
    }
    for i = 0,main.childCount - 1 do
        local child = main:GetChild(i).gameObject
        UIUtil.AddBtnEvent(child,funcs[i+1])
    end
    UIPublic.SetBackButton(
        self.backBtn,
        UIWindowNames.UIChallenge,
        414
    )
    --新手引导剧情
    local guide=Game.Scene:GetComponent("GuideComponent")
    local guideData = table.first(guide.GuideList,function (h) return h.Id == 10001  end)
    if guideData == nil or guideData.Step < 3 then
        guide:CheckStart(9,0)
    end

    -- if type == 1 then --属性
    --     -- body
    -- elseif type == 2 then --职业
    --     -- body
    -- end

    --local diff = self.sevenStarComponent.Days[1]
    local propList = {}
    local classList = {}

    for type, daysInfo in ipairs(self.sevenStarComponent.Days) do
        for index, levelInfo in ipairs(daysInfo) do
            for _, value in ipairs(levelInfo[1].BoostDate) do
                if value == self.day then
                    local info = {
                        index = index
                    }
                    if type == 1 then --属性
                        table.insert(propList,info)
                    elseif type == 2 then --职业
                        table.insert(classList,info)
                    end
                end
            end
        end
    end

    for i = 0, 7 do
        self.PropUpList:GetChild(i).gameObject:SetActive(false)
        self.ClassUpList:GetChild(i).gameObject:SetActive(false)
    end

    if #propList == 8 then
        self.PropUpList:GetChild(0).gameObject:SetActive(true)
        UIUtil.SetSprite(self.PropUpList:GetChild(0):GetComponent("Image"), AtlasConfig.Prop, "icon_bg_" .. 0 ..".png")
    else
        for i, value in ipairs(propList) do
            self.PropUpList:GetChild(i - 1).gameObject:SetActive(true)
            UIUtil.SetSprite(self.PropUpList:GetChild(i - 1):GetComponent("Image"), AtlasConfig.Prop, "icon_bg_" .. value.index ..".png")
        end
    end
    
    if #classList == 6 then
        self.ClassUpList:GetChild(0).gameObject:SetActive(true)
        UIUtil.SetSprite(self.ClassUpList:GetChild(0):GetComponent("Image"), AtlasConfig.Class, "icon_" .. 0 ..".png")
    else
        for i, value in ipairs(classList) do
            self.ClassUpList:GetChild(i - 1).gameObject:SetActive(true)
            UIUtil.SetSprite(self.ClassUpList:GetChild(i - 1):GetComponent("Image"), AtlasConfig.Class, "icon_" .. value.index ..".png")
        end
    end

end

function this.OnLangCreate(self)
    --local main  = self.rc:GetObject("Main").transform
    --LangUtil.BindText(self.backBtn.transform:Find("Text"))
    -- for i = 0,main.childCount - 1 do
    --     LangUtil.GetSpriteLang(367 + i, function(sprite) main:GetChild(i):GetComponent("Image").sprite = sprite end)
    --     if not IsNull( main:GetChild(i).transform:Find("activityBut") ) then
    --         if i == 0  then
    --             --UIUtil.activityBUt(main:GetChild(i).transform:Find("activityBut"),2,self.canvas.unity_canvas.sortingOrder,2)
    --         end
    --         if i == 1  then
    --             --UIUtil.activityBUt(main:GetChild(i).transform:Find("activityBut"),2,self.canvas.unity_canvas.sortingOrder,3)
    --         end
    --     end
    -- end
    
end

function this.OnEnable(self)
    base.OnEnable(self)
end

function this.OnRefresh(self)

end


function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    --UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    --UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end


return this


