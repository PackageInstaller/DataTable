---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2020/4/7 15:20
---
---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIStoryListView = BaseClass("UIStoryListView",UIBaseView);
local base = UIBaseView
local this = UIStoryListView

local pfbName = "StoryListItem"

local color1 = Color.New(103/255,111/255,126/255)
local color2 = Color.New(98/255,99/255,106/255)


local function InitItemData(self, arg)
    local data = arg.data
    local transform = arg.go.transform;
    local Lock = transform:Find("Lock").gameObject
    local Title = LangUtil.BindText(transform:Find("Title"))
    local Name = LangUtil.BindText(transform:Find("Size/Name"))
    local Text = LangUtil.BindText(transform:Find("Text"))
    Title.text = data.LevelTitle

    if self.model.data.storyId >= data.Id then
        Lock:SetActive(false)
        Text.text = LangUtil.GetSysLang(933)--已开启
        Name.text = data.Name
        UIUtil.ScrollText(Name)
        Title.color = Color.white
        Name.color = Color.white
        Text.color = color1
        UIUtil.AddBtnEvent(arg.go, function()
            Game.Scene:GetComponent("DialogComponent"):OpenDialogOnly(data.ChapterId, data.StoryId, function()
                coroutine.start(function()
                    Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI,"HandBook")
                end)
            end)
        end)
    else
        Lock:SetActive(true)
        Text.text = LangUtil.GetSysLang(495)--未开启
        Name.text = ""
        Title.color = color2
        Text.color = color2
        UIUtil.AddBtnEvent(arg.go, function()
            UIUtil.ToolTipFourth(string.gsub(LangUtil.GetSysLang(934), "XX", data.LevelTitle) )--"通关第XX话解锁"
        end)
    end

end
    

function this.OnLangCreate(self)
    self.TitleText = LangUtil.BindText(self.rc:GetObject("Text"))
    self.ChapterText = LangUtil.BindText(self.rc:GetObject("ChapterText"))--.text= LangUtil.GetSysLang(122)
    self.TitleText.text = ""
    self.ChapterText.text = ""
end


function this.OnCreate(self)
    base.OnCreate(self)
    self.scrollView = self.rc:GetObject("ScrollView")
    --self.content = self.rc:GetObject("Content")
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(4)
    
    UIUtil.AddBtnEvent(self.rc:GetObject("Close"), function() UIManager:GetInstance():CloseWindow(UIWindowNames.UIStoryList) end,"Back")
    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function() UIManager:GetInstance():CloseWindow(UIWindowNames.UIStoryList) end,"Back")
end

function this.OnEnable(self)
    base.OnEnable(self)
    local titelStr = ""
    if self.model.data.levelType == LevelType.LevelTypeGameEvent then
        titelStr = LangUtil.GetSysLang(926)--活动物语
    else
        titelStr = LangUtil.GetSysLang(922)--主线物语
    end
    local zStoryChapter = table.first(Z_StoryChapter, function(v) return v.ChapterId == self.model.data.ChapterId end)
    self.TitleText.text = titelStr .. " " .. zStoryChapter.Name
    self.ChapterText.text = zStoryChapter.Title
    self.scroll:Clear()
    self.scroll:ScrollInit(self.model.data.sectionList, self.scrollView, pfbName, function (arg)
        InitItemData(self, arg)
    end)
    
    self:OnRefresh()
end

function this.OnRefresh(self)
    
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
    self.scroll:Dispose()
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

